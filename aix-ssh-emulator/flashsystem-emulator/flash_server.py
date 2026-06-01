import asyncssh
import asyncio
import os

BASE = '/opt/mock/flash_commands'

class FlashSession(asyncssh.SSHServerSession):
    def __init__(self):
        self._chan = None

    def connection_made(self, chan):
        self._chan = chan

    def exec_requested(self, command):
        safe = command.replace(' ', '_')
        path = os.path.join(BASE, f'{safe}.txt')

        if os.path.exists(path):
            with open(path, 'r') as fh:
                self._chan.write(fh.read())
            self._chan.exit(0)
        else:
            self._chan.write(f'Unknown command: {command}\n')
            self._chan.exit(1)

        return True

class FlashServer(asyncssh.SSHServer):
    def session_requested(self):
        return FlashSession()

async def main():
    await asyncssh.create_server(
        FlashServer,
        '',
        2224,
        server_host_keys=['/etc/ssh/ssh_host_rsa_key'],
        username='admin',
        password='admin'
    )

if __name__ == '__main__':
    asyncio.get_event_loop().run_until_complete(main())
    asyncio.get_event_loop().run_forever()
