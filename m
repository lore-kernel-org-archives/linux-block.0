Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810728;
	b=40p8JZHAM4yPyD/XVARpquX7kIjrUF2JQUdEmw6RJ1jG9z+fklDVg1CmXIQMB9wq6ckj
	 iZuCzZwvmV8P2wNwy/ft9eW5dAFjZbfw3L68+eIWXrVrWHNf4cO8J6CQH8wjSz0lICtts
	 8Mc+kkySpwZZwpbQWBxnMPUUVdaecznjg7i7fbEHHrxMeb6xZ6xHYVDsbbmR9pxw9J2Ib
	 g6X07Hdh6IavSINTh9FuoF2kPrcc4/2aMMSe3vxAFOco4exbkAm/vc6ytSQGtx4g+I2iX
	 /JZon8D3u7AnorPZfcpHIaLRAITfOiJq88o5sV+ZuUl30JcWOt36hpNh27eRI6Z5/fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810728;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Spamd-Result:X-Spam-Score:X-Spam-Level:
	 X-Spam-Flag;
	bh=516NjIP8GxxFnj0Xs+taRoKG9RS2oUvFEWnpq2Hgejs=;
	b=qV+LOLHlMpyoZUHeiL2BUXKhSnUEW9+QzbQXGm27psb2osNOHV9Cdhot61ab3UBdKeZh
	 I6pnxpXISdAvJd+nwvNgKGMH62KkZnvRzaV2OtTpIlDIqft4uGSsFmg8t7RMKcg1Z3Fm2
	 kIBlbjOMhSeq/sqszF1yIk0Kms/kNlq+8H9jLK2ZjDttyWPPKumm2GP1muB9XdNHsHEFB
	 sQ+zrSAJxyY88E2voqOM+TzRwKT/TzWXR0uDD3FCjbva1Xrw3jbOz1c6v1hwWV8hX4xbI
	 zsN0b9MmnRtpZdEltneHYW39YfQBys1QU/0b29cayTmaFMrwejlFT+z7MV80QoGCrnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="nqytj/n7";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=l8sCdqx1;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=reVl7dfw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3ajkeXnl;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD3606A329
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 16:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66CD3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nqytj/n7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=l8sCdqx1;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=reVl7dfw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3ajkeXnl
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8011C21FF9;
	Wed,  4 Nov 2026 16:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=516NjIP8GxxFnj0Xs+taRoKG9RS2oUvFEWnpq2Hgejs=;
	b=nqytj/n7RPZSE53pysCMMnhro2nkPrIjmJsxgcpv4utxKnsC1VNfQ+msE5+5J8ZYc80+5x
	IcC8i7D9BC3Fswi84OFd33u0CF5uUJHIa/jqnFgx8W30LdtsNzU5FdK+/g8l6DEnX49Blh
	ZGF4q7Qv5Bhw/e4z1q7dlptSF6BHLxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810724;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=516NjIP8GxxFnj0Xs+taRoKG9RS2oUvFEWnpq2Hgejs=;
	b=l8sCdqx1ntbdDN2OXxenR8fUsezOWTXvFOb9kUzYw3WtYJNsOmnwD2psad1uIYJTfph7/w
	4wddkyzML0tP+8Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=516NjIP8GxxFnj0Xs+taRoKG9RS2oUvFEWnpq2Hgejs=;
	b=reVl7dfwBPwpfMGKez1Kh6fdtqDP2pmt6h00t/gOjSA6F3uTQlVzvEH1uoz3mkiVjjL7dO
	irW8zboZnCc1eSAiLKKQlGuLZARK3pxIHBYrvRdfRV52L0YJ30TNec5T0DJE+FY6Ty45R4
	AzjajykqYEhlgt5fv7g4dgCQD8NcIac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=516NjIP8GxxFnj0Xs+taRoKG9RS2oUvFEWnpq2Hgejs=;
	b=3ajkeXnlJuFlPvw7n2HlWokcStktEQPSaczqjRnp70rR9PAhj8JyPMhI4We0Ud024TiEG3
	tiNJjrSFxzEvkTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33255134F0;
	Wed,  4 Nov 2026 16:45:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WDKCAyNh62p6fQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 16:45:23 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 17:44:45 +0100
Subject: [PATCH blktests 06/10] contrib: make nvme-target-control a
 standalone project
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-nvme-target-control-v1-6-b31b40537bb4@suse.de>
References: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
In-Reply-To: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[self.channel:url,imap1.dmz-prg2.suse.org:helo,nvme_target_control.target:url,readme.md:url,collections.abc:url,t:email,nvmet.sh:url,suse.de:email,tmp.name:url,channel.channel:url,target.target:url]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Flag: NO

contrib/nvme_target_control.py can't set up a target with the upstream
tools. It needs an nvmetcli REST API which was never merged, and its
nvmetcli client crashes with configshell-fb 2.0. Its configuration also
repeats the target setup on the host.

Replace it with contrib/nvme-target-control. It keeps the command line
blktests calls and adds commands for ports and host keys. The
configuration only says how to reach the target. The built-in nvmet
target configures configfs over ssh, other targets and channels are
plugins. README.md documents the configuration and the plugin
interface.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md                     |   4 +
 contrib/nvme-target-control/.gitignore             |   1 +
 contrib/nvme-target-control/README.md              | 129 +++++++
 contrib/nvme-target-control/nvme-target-control    |  19 ++
 .../nvme_target_control/__init__.py                |   3 +
 .../nvme_target_control/channel.py                 | 113 ++++++
 .../nvme-target-control/nvme_target_control/cli.py | 205 +++++++++++
 .../nvme_target_control/plugin.py                  |  35 ++
 .../nvme_target_control/target.py                  | 221 ++++++++++++
 .../nvme_target_control/targets/__init__.py        |   3 +
 .../nvme_target_control/targets/nvmet.py           | 107 ++++++
 .../nvme_target_control/targets/nvmet.sh           | 246 +++++++++++++
 contrib/nvme-target-control/pyproject.toml         |  42 +++
 .../tests/test_target_control.py                   | 380 +++++++++++++++++++++
 contrib/nvme_target_control.py                     | 204 -----------
 contrib/nvmet-subsys.jinja2                        |  71 ----
 16 files changed, 1508 insertions(+), 275 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 7d935aad3331..095d6aa4e18e 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -258,3 +258,7 @@ The blktests expects that the script interface implements following
 
 cleanup:
   --subsysnqn SUBSYSNQN
+
+contrib/nvme-target-control implements this interface. It configures a Linux
+nvmet target over ssh and can be extended for other targets, see
+contrib/nvme-target-control/README.md.
diff --git a/contrib/nvme-target-control/.gitignore b/contrib/nvme-target-control/.gitignore
new file mode 100644
index 000000000000..c18dd8d83cee
--- /dev/null
+++ b/contrib/nvme-target-control/.gitignore
@@ -0,0 +1 @@
+__pycache__/
diff --git a/contrib/nvme-target-control/README.md b/contrib/nvme-target-control/README.md
new file mode 100644
index 000000000000..dc421b00b788
--- /dev/null
+++ b/contrib/nvme-target-control/README.md
@@ -0,0 +1,129 @@
+# nvme-target-control
+
+Sets up and tears down remote NVMe targets for blktests. blktests calls it
+through `NVME_TARGET_CONTROL` to run the fabrics tests against a target on
+another machine instead of the local nvmet target, see
+Documentation/running-tests.md.
+
+It needs Python 3.10 or newer, and tomli on Python 3.10. It runs from the
+source tree.
+
+## Usage
+
+    NVME_TARGET_CONTROL=$PWD/contrib/nvme-target-control/nvme-target-control \
+        ./check nvme
+
+Tests which change the local nvmet configfs, e.g. `attr_qid_max`, skip with
+a remote target.
+
+## Configuration
+
+`~/.config/blktests/nvme_target_control.toml`, or the file
+`NVME_TARGET_CONTROL_CONFIG` points to. It only says how to reach the
+target, e.g. a Linux box with nvmet:
+
+    [target]
+    remote = "root@10.0.0.1"
+
+The rest is worked out on the host or created on the target:
+
+| Value | Default |
+| --- | --- |
+| `traddr` | the address of the target, e.g. of the ssh destination |
+| `host_traddr` | the local address of the route to `traddr` |
+| `hostnqn`, `hostid` | `/etc/nvme/hostnqn` and `/etc/nvme/hostid`, else the blktests defaults |
+| `trtype` | `tcp` |
+| `trsvid` | `4420` |
+| `subsysnqn`, `subsys_uuid` | the blktests defaults |
+| `blkdev_type` | `device` |
+
+These are the values blktests reads with `config --show-*`. Each can be
+set in `[target]`, e.g. `traddr` if the data path uses another address than
+the ssh login. With `skip_setup_cleanup = true`, setup and cleanup do
+nothing, to run against a target which is configured already.
+
+## Targets
+
+`type` in `[target]` selects the target:
+
+| Type | Target |
+| --- | --- |
+| `nvmet` (default) | Linux nvmet target, configured through configfs |
+| `package.module:Class` | A `Target` subclass outside this package |
+
+### nvmet
+
+Runs the shell script `nvmet.sh` on the target through a channel. Setup
+creates the subsystem with namespace 1, allows the host and exports the
+subsystem on new ports, one unless blktests asks for more. Unless `blkdev`
+is set, the namespace is a loop device on an image file in
+`/var/tmp/nvme-target-control` on the target. Cleanup removes the
+subsystem, the ports which don't export another subsystem, the hosts no
+other subsystem allows, and the loop device and image file.
+
+A new port gets the lowest free nvmet port ID N, starting at 1, and listens
+on `traddr` at service ID `trsvid` + N - 1. The first port of a target
+without other ports listens on `trsvid`. The nvmet target implements all
+port commands: `add-ports`, `add-port`, `remove-port`, `list-ports`,
+`show-port` and `set-ana`, and `set-host`, which changes the DH-CHAP keys,
+hash and DH group of the host.
+
+| Option | Meaning |
+| --- | --- |
+| `channel` | `ssh` (default), `local` or `package.module:Class` |
+| `remote` | ssh destination; the login must not ask for a password |
+| `ssh_options` | list of extra ssh arguments |
+| `blkdev` | block device or file backing the namespace, must keep the data |
+| `img_size` | size of the image file without `blkdev`, default `1G` |
+
+The target needs sshd, configfs, losetup and the nvmet modules for the
+transport. The ssh destination may be an alias from the ssh config, `traddr`
+is then its `HostName`.
+
+## Adding a target
+
+A target is a subclass of `nvme_target_control.target.Target`. It gets the
+`[target]` section as `self.config`:
+
+```python
+from nvme_target_control.target import Subsystem, Target
+
+
+class ArrayTarget(Target):
+    def traddr(self) -> str:
+        # The address the host connects to, without contacting the
+        # target: blktests asks for it many times per test.
+        return self.config['data_address']
+
+    def setup(
+        self, subsys: Subsystem, nr_ports: int = 1, tls: str = 'none'
+    ) -> None:
+        # Create subsys.nqn with one namespace, allow subsys.hostnqn and
+        # export it on self.value('traddr'):self.value('trsvid').
+        ...
+
+    def cleanup(self, subsysnqn: str) -> None: ...
+```
+
+Select it with `type = "mymodule:ArrayTarget"`; `mymodule` must be
+importable, e.g. through `PYTHONPATH`. It can override the other defaults
+the same way, e.g. `subsysnqn` if the target names subsystems itself. A
+target with a management API, e.g. a storage array with a REST API, talks
+to it directly. A target configured with shell commands can use a channel:
+`nvme_target_control.channel.create` creates the one `[target]` names. A
+channel is a subclass of `Channel` which returns the command running
+`sh -s -- ARGS` on the target and the host name of the target.
+
+The port commands and `set-host` are optional. A target implements them
+by overriding `add_ports`, `add_port`, `remove_port`, `list_ports`,
+`show_port`, `set_ana` and `set_host`. `config --show-features` lists the
+ones it overrides, followed by the class attribute `extra_features`, e.g.
+`tls`. blktests skips the tests which need a feature the target doesn't
+list. Without `list-ports` and `show-port`, blktests connects to `traddr`
+and `trsvid`.
+
+## Development
+
+    ruff check . && ruff format --check . && mypy
+    python3 -m unittest discover -s tests
+    shellcheck -s sh nvme_target_control/targets/*.sh
diff --git a/contrib/nvme-target-control/nvme-target-control b/contrib/nvme-target-control/nvme-target-control
new file mode 100755
index 000000000000..7aedf7bfdc8c
--- /dev/null
+++ b/contrib/nvme-target-control/nvme-target-control
@@ -0,0 +1,19 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+"""Set up and tear down remote NVMe targets for blktests.
+
+Point NVME_TARGET_CONTROL at this file, see README.md.
+"""
+
+import sys
+from pathlib import Path
+
+if sys.version_info < (3, 10):
+    sys.exit('nvme-target-control needs Python 3.10 or newer')
+
+sys.path.insert(0, str(Path(__file__).resolve().parent))
+
+from nvme_target_control.cli import main
+
+sys.exit(main())
diff --git a/contrib/nvme-target-control/nvme_target_control/__init__.py b/contrib/nvme-target-control/nvme_target_control/__init__.py
new file mode 100644
index 000000000000..e97c509fc0cf
--- /dev/null
+++ b/contrib/nvme-target-control/nvme_target_control/__init__.py
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+"""Set up and tear down remote NVMe targets for blktests."""
diff --git a/contrib/nvme-target-control/nvme_target_control/channel.py b/contrib/nvme-target-control/nvme_target_control/channel.py
new file mode 100644
index 000000000000..28bbb540b5b2
--- /dev/null
+++ b/contrib/nvme-target-control/nvme_target_control/channel.py
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+"""Channels run shell scripts on the target.
+
+Targets which are configured with shell commands, like the Linux nvmet
+target, use a channel to reach the target machine. Targets with their own
+management API don't need one.
+"""
+
+import shlex
+import subprocess
+from abc import ABC, abstractmethod
+from collections.abc import Sequence
+from typing import Any
+
+from . import plugin
+
+
+class ChannelError(Exception):
+    """A script failed on the target."""
+
+
+class Channel(ABC):
+    """Runs shell scripts on the target."""
+
+    def __init__(self, config: dict[str, Any]) -> None:
+        self.config = config
+
+    @abstractmethod
+    def command(self, args: Sequence[str]) -> list[str]:
+        """Return the command which runs 'sh -s -- args' on the target."""
+
+    @abstractmethod
+    def host(self) -> str:
+        """Return the host name or address of the target machine."""
+
+    def run(self, script: str, args: Sequence[str]) -> str:
+        """Run script with the positional parameters args.
+
+        Return what the script printed on stdout.  Its stderr is passed
+        through.
+        """
+        cmd = self.command(args)
+        ret = subprocess.run(
+            cmd,
+            input=script,
+            stdout=subprocess.PIPE,
+            text=True,
+            check=False,
+        )
+        if ret.returncode:
+            raise ChannelError(
+                f'{shlex.join(cmd)} failed with exit code {ret.returncode}'
+            )
+        return ret.stdout
+
+
+class LocalChannel(Channel):
+    """Runs the scripts on this machine."""
+
+    def command(self, args: Sequence[str]) -> list[str]:
+        return ['sh', '-s', '--', *args]
+
+    def host(self) -> str:
+        return '127.0.0.1'
+
+
+class SshChannel(Channel):
+    """Runs the scripts on the 'remote' ssh destination.
+
+    'ssh_options' are passed to ssh. The login must not ask for a password.
+    """
+
+    def _ssh(self) -> list[str]:
+        try:
+            remote = self.config['remote']
+        except KeyError:
+            raise ChannelError("ssh channel needs 'remote'") from None
+        return ['ssh', *self.config.get('ssh_options', []), remote]
+
+    def command(self, args: Sequence[str]) -> list[str]:
+        # ssh passes the command to the remote shell as one string.
+        return [*self._ssh(), shlex.join(['sh', '-s', '--', *args])]
+
+    def host(self) -> str:
+        # ssh -G prints the configuration for the destination without
+        # connecting, including the host name of an alias.
+        ssh = self._ssh()
+        ret = subprocess.run(
+            [ssh[0], '-G', *ssh[1:]],
+            capture_output=True,
+            text=True,
+            check=False,
+        )
+        for line in ret.stdout.splitlines():
+            key, _, value = line.partition(' ')
+            if key == 'hostname':
+                return value
+        raise ChannelError(f'ssh -G {ssh[-1]} failed: {ret.stderr.strip()}')
+
+
+CHANNELS = {
+    'local': f'{__name__}:LocalChannel',
+    'ssh': f'{__name__}:SshChannel',
+}
+
+
+def create(config: dict[str, Any]) -> Channel:
+    """Create the channel named by config['channel'], ssh by default."""
+    cls = plugin.load('channel', config.get('channel', 'ssh'), CHANNELS)
+    if not (isinstance(cls, type) and issubclass(cls, Channel)):
+        raise plugin.PluginError(f'{cls!r} is not a Channel')
+    return cls(config)
diff --git a/contrib/nvme-target-control/nvme_target_control/cli.py b/contrib/nvme-target-control/nvme_target_control/cli.py
new file mode 100644
index 000000000000..2b49ab7bb4df
--- /dev/null
+++ b/contrib/nvme-target-control/nvme_target_control/cli.py
@@ -0,0 +1,205 @@
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+"""The command line interface blktests calls through NVME_TARGET_CONTROL."""
+
+import argparse
+import os
+import sys
+from collections.abc import Sequence
+from pathlib import Path
+from typing import Any
+
+from . import target
+from .channel import ChannelError
+from .plugin import PluginError
+
+if sys.version_info >= (3, 11):
+    import tomllib
+else:
+    import tomli as tomllib  # type: ignore[import-not-found,unused-ignore]
+
+
+def config_path() -> Path:
+    """Return the configuration file.
+
+    NVME_TARGET_CONTROL_CONFIG overrides the default
+    $XDG_CONFIG_HOME/blktests/nvme_target_control.toml.
+    """
+    path = os.environ.get('NVME_TARGET_CONTROL_CONFIG')
+    if path:
+        return Path(path)
+    base = os.environ.get('XDG_CONFIG_HOME') or str(Path.home() / '.config')
+    return Path(base) / 'blktests' / 'nvme_target_control.toml'
+
+
+def load_config(path: Path) -> dict[str, Any]:
+    with path.open('rb') as f:
+        config: dict[str, Any] = tomllib.load(f)
+    return config
+
+
+# The config --show-* options, named like the Target methods
+SHOW = [
+    'blkdev_type',
+    'trtype',
+    'hostnqn',
+    'hostid',
+    'host_traddr',
+    'traddr',
+    'trsvid',
+    'subsys_uuid',
+    'subsysnqn',
+]
+
+
+def show(tgt: target.Target, args: argparse.Namespace) -> None:
+    if args.show_features:
+        print(' '.join(tgt.features()))
+        return
+    for option in SHOW:
+        if getattr(args, f'show_{option}'):
+            print(tgt.value(option))
+            return
+
+
+def subsystem(args: argparse.Namespace) -> target.Subsystem:
+    return target.Subsystem(
+        nqn=args.subsysnqn,
+        uuid=args.subsys_uuid,
+        hostnqn=args.hostnqn,
+        hostkey=args.hostkey,
+        ctrlkey=args.ctrlkey,
+    )
+
+
+def print_lines(lines: Sequence[str]) -> None:
+    for line in lines:
+        print(line)
+
+
+def run(config: dict[str, Any], args: argparse.Namespace) -> None:
+    tgt = target.create(config['target'])
+    if args.cmd == 'config':
+        show(tgt, args)
+        return
+    if config['target'].get('skip_setup_cleanup', False):
+        return
+
+    if args.cmd == 'setup':
+        tgt.setup(subsystem(args), args.ports, args.tls)
+    elif args.cmd == 'cleanup':
+        tgt.cleanup(args.subsysnqn)
+    elif args.cmd == 'add-ports':
+        print_lines(tgt.add_ports(args.subsysnqn, args.ports, args.tls))
+    elif args.cmd == 'add-port':
+        print(tgt.add_port(args.tls))
+    elif args.cmd == 'remove-port':
+        tgt.remove_port(args.port)
+    elif args.cmd == 'list-ports':
+        print_lines(tgt.list_ports(args.subsysnqn))
+    elif args.cmd == 'show-port':
+        port = tgt.show_port(args.port)
+        print(port.trtype, port.traddr, port.trsvcid)
+    elif args.cmd == 'set-ana':
+        tgt.set_ana(args.port, args.grpid, args.state)
+    elif args.cmd == 'set-host':
+        attrs = {
+            name: getattr(args, name)
+            for name in target.HOST_ATTRS
+            if getattr(args, name) is not None
+        }
+        tgt.set_host(args.hostnqn, attrs)
+
+
+def add_subsys_args(
+    parser: argparse.ArgumentParser, required: bool = True
+) -> None:
+    parser.add_argument('--subsysnqn', required=True)
+    parser.add_argument('--subsys-uuid', required=required)
+    parser.add_argument('--hostnqn', required=required)
+    parser.add_argument('--ctrlkey', default='')
+    parser.add_argument('--hostkey', default='')
+
+
+def add_port_args(parser: argparse.ArgumentParser, ports: bool) -> None:
+    """Add the options of the commands which create ports."""
+    if ports:
+        parser.add_argument('--ports', type=int, default=1)
+    tls = parser.add_mutually_exclusive_group()
+    # The options of _nvmet_target_setup in common/nvme
+    tls.add_argument(
+        '--tls',
+        action='store_const',
+        dest='tls',
+        const='not-required',
+        default='none',
+    )
+    tls.add_argument(
+        '--force-tls', action='store_const', dest='tls', const='required'
+    )
+
+
+def build_parser() -> argparse.ArgumentParser:
+    parser = argparse.ArgumentParser(
+        prog='nvme-target-control',
+        description='Set up and tear down remote NVMe targets for blktests.',
+    )
+    sub = parser.add_subparsers(dest='cmd', required=True)
+
+    setup = sub.add_parser('setup')
+    add_subsys_args(setup)
+    add_port_args(setup, ports=True)
+
+    cleanup = sub.add_parser('cleanup')
+    cleanup.add_argument('--subsysnqn', required=True)
+
+    # common/nvme passes the setup options to add-ports, only the
+    # subsystem NQN is used.
+    add_ports = sub.add_parser('add-ports')
+    add_subsys_args(add_ports, required=False)
+    add_port_args(add_ports, ports=True)
+
+    add_port_args(sub.add_parser('add-port'), ports=False)
+
+    sub.add_parser('remove-port').add_argument('--port', required=True)
+
+    sub.add_parser('list-ports').add_argument('--subsysnqn', required=True)
+
+    sub.add_parser('show-port').add_argument('--port', required=True)
+
+    set_ana = sub.add_parser('set-ana')
+    set_ana.add_argument('--port', required=True)
+    set_ana.add_argument('--grpid', type=int, required=True)
+    set_ana.add_argument('--state', required=True)
+
+    set_host = sub.add_parser('set-host')
+    set_host.add_argument('--hostnqn', required=True)
+    for name in target.HOST_ATTRS:
+        set_host.add_argument('--' + name)
+
+    cfg = sub.add_parser('config')
+    for option in SHOW:
+        cfg.add_argument(
+            '--show-' + option.replace('_', '-'), action='store_true'
+        )
+    cfg.add_argument('--show-features', action='store_true')
+
+    return parser
+
+
+def main(argv: Sequence[str] | None = None) -> int:
+    args = build_parser().parse_args(argv)
+    try:
+        run(load_config(config_path()), args)
+    except (
+        ChannelError,
+        PluginError,
+        NotImplementedError,
+        KeyError,
+        OSError,
+        ValueError,
+        tomllib.TOMLDecodeError,
+    ) as e:
+        print(f'nvme-target-control: {e!r}', file=sys.stderr)
+        return 1
+    return 0
diff --git a/contrib/nvme-target-control/nvme_target_control/plugin.py b/contrib/nvme-target-control/nvme_target_control/plugin.py
new file mode 100644
index 000000000000..a73ebf4665b1
--- /dev/null
+++ b/contrib/nvme-target-control/nvme_target_control/plugin.py
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+"""Look up target and channel implementations by name."""
+
+import importlib
+from typing import Any
+
+
+class PluginError(Exception):
+    """A plugin can't be found or loaded."""
+
+
+def load(kind: str, name: str, builtin: dict[str, str]) -> Any:
+    """Return the class for name.
+
+    name is either a key of builtin or 'package.module:Class', to load an
+    implementation from outside this package.
+    """
+    path = builtin.get(name, name)
+    module_name, sep, class_name = path.partition(':')
+    if not sep or not module_name or not class_name:
+        known = ', '.join(sorted(builtin))
+        raise PluginError(
+            f"unknown {kind} '{name}', use one of {known} or 'module:Class'"
+        )
+    try:
+        module = importlib.import_module(module_name)
+    except ImportError as e:
+        raise PluginError(f"can't load {kind} '{name}': {e}") from e
+    try:
+        return getattr(module, class_name)
+    except AttributeError as e:
+        raise PluginError(
+            f"{kind} '{name}': {module_name} has no {class_name}"
+        ) from e
diff --git a/contrib/nvme-target-control/nvme_target_control/target.py b/contrib/nvme-target-control/nvme_target_control/target.py
new file mode 100644
index 000000000000..d648826e0386
--- /dev/null
+++ b/contrib/nvme-target-control/nvme_target_control/target.py
@@ -0,0 +1,221 @@
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+"""Targets configure a subsystem on a kind of NVMe target.
+
+A target implementation gets the [target] section of the configuration. It
+answers the values blktests asks for with 'config --show-*' and creates the
+subsystem blktests connects to. The built-in 'nvmet' target configures a
+Linux nvmet target. Other targets, e.g. a storage array with a management
+API, can be added as 'package.module:Class' in the [target] 'type' option.
+"""
+
+import socket
+from abc import ABC, abstractmethod
+from dataclasses import dataclass
+from pathlib import Path
+from typing import Any, ClassVar
+
+from . import plugin
+
+# The defaults of blktests, see common/nvme
+DEF_HOSTID = '0f01fb42-9f7f-4856-b0b3-51e60b8de349'
+DEF_SUBSYSNQN = 'blktests-subsystem-1'
+DEF_SUBSYS_UUID = '91fdba0d-f87b-4c25-b80f-db7be1418b9e'
+DEF_TRSVCID = '4420'
+
+
+@dataclass(frozen=True)
+class Subsystem:
+    """The subsystem blktests wants to connect to."""
+
+    nqn: str
+    uuid: str
+    hostnqn: str
+    hostkey: str = ''
+    ctrlkey: str = ''
+
+
+@dataclass(frozen=True)
+class Port:
+    """The address of a port, what the host passes to nvme connect."""
+
+    trtype: str
+    traddr: str
+    trsvcid: str
+
+
+# The TLS modes of a port: no TLS, TLS optional, TLS required
+TLS_MODES = ('none', 'not-required', 'required')
+
+# The DH-CHAP attributes of a host: the host key, the controller key for
+# bidirectional authentication, the hash and the DH group, e.g.
+# 'hmac(sha256)' and 'ffdhe2048'
+HOST_ATTRS = ('hostkey', 'ctrlkey', 'hash', 'dhgroup')
+
+
+def read_first_line(path: str) -> str | None:
+    try:
+        return Path(path).read_text().split('\n', 1)[0].strip() or None
+    except OSError:
+        return None
+
+
+def resolve(host: str) -> str:
+    """Return the IP address of host."""
+    return str(
+        socket.getaddrinfo(host, None, type=socket.SOCK_STREAM)[0][4][0]
+    )
+
+
+def source_address(addr: str) -> str:
+    """Return the local address of the route to addr."""
+    family = socket.AF_INET6 if ':' in addr else socket.AF_INET
+    with socket.socket(family, socket.SOCK_DGRAM) as s:
+        # Connecting a UDP socket sends nothing, it only picks the route.
+        s.connect((addr, 9))
+        return str(s.getsockname()[0])
+
+
+class Target(ABC):
+    """A kind of NVMe target.
+
+    config is the [target] section. Each value blktests asks for can be set
+    there with the name of the 'config --show-*' option, e.g. 'traddr'.
+    Otherwise the target works it out, see the methods below. They must not
+    contact the target: blktests asks for them many times per test.
+    """
+
+    def __init__(self, config: dict[str, Any]) -> None:
+        self.config = config
+
+    def value(self, name: str) -> str:
+        """Return the value of 'config --show-NAME'."""
+        if name in self.config:
+            return str(self.config[name])
+        return str(getattr(self, name)())
+
+    def trtype(self) -> str:
+        return 'tcp'
+
+    @abstractmethod
+    def traddr(self) -> str:
+        """Return the address the host connects to."""
+
+    def trsvid(self) -> str:
+        return DEF_TRSVCID
+
+    def host_traddr(self) -> str:
+        return source_address(self.value('traddr'))
+
+    def hostnqn(self) -> str:
+        return (
+            read_first_line('/etc/nvme/hostnqn')
+            or f'nqn.2014-08.org.nvmexpress:uuid:{self.value("hostid")}'
+        )
+
+    def hostid(self) -> str:
+        return read_first_line('/etc/nvme/hostid') or DEF_HOSTID
+
+    def subsysnqn(self) -> str:
+        return DEF_SUBSYSNQN
+
+    def subsys_uuid(self) -> str:
+        return DEF_SUBSYS_UUID
+
+    def blkdev_type(self) -> str:
+        return 'device'
+
+    @abstractmethod
+    def setup(
+        self, subsys: Subsystem, nr_ports: int = 1, tls: str = 'none'
+    ) -> None:
+        """Create subsys with one namespace and export it on new ports.
+
+        tls is one of TLS_MODES.
+        """
+
+    @abstractmethod
+    def cleanup(self, subsysnqn: str) -> None:
+        """Remove the subsystem and whatever setup created for it."""
+
+    # The optional commands.  Ports are named by IDs the target picks.  A
+    # target leaves the commands it can't do unimplemented.  blktests
+    # skips the tests which need a feature 'config --show-features'
+    # doesn't list.  Without list-ports and show-port, it connects to
+    # traddr and trsvid.
+
+    # Features which are not commands, e.g. 'tls'
+    extra_features: ClassVar[tuple[str, ...]] = ()
+
+    def features(self) -> list[str]:
+        """Return the optional commands the target implements.
+
+        Followed by extra_features.
+        """
+        return [
+            cmd
+            for cmd, method in OPTIONAL_COMMANDS.items()
+            if getattr(type(self), method) is not getattr(Target, method)
+        ] + list(self.extra_features)
+
+    def _not_implemented(self, what: str) -> NotImplementedError:
+        return NotImplementedError(
+            f'{type(self).__name__} does not implement {what}'
+        )
+
+    def add_ports(
+        self, subsysnqn: str, nr_ports: int, tls: str = 'none'
+    ) -> list[str]:
+        """Export the subsystem on nr_ports new ports, return their IDs."""
+        raise self._not_implemented('add-ports')
+
+    def add_port(self, tls: str = 'none') -> str:
+        """Create a port which exports no subsystem, return its ID."""
+        raise self._not_implemented('add-port')
+
+    def remove_port(self, port: str) -> None:
+        """Remove the port."""
+        raise self._not_implemented('remove-port')
+
+    def list_ports(self, subsysnqn: str) -> list[str]:
+        """Return the IDs of the ports which export the subsystem."""
+        raise self._not_implemented('list-ports')
+
+    def show_port(self, port: str) -> Port:
+        """Return the address of the port."""
+        raise self._not_implemented('show-port')
+
+    def set_ana(self, port: str, grpid: int, state: str) -> None:
+        """Set the state of ANA group grpid on the port."""
+        raise self._not_implemented('set-ana')
+
+    def set_host(self, hostnqn: str, attrs: dict[str, str]) -> None:
+        """Change the DH-CHAP attributes of a host setup allowed.
+
+        attrs maps names of HOST_ATTRS to their new values.
+        """
+        raise self._not_implemented('set-host')
+
+
+# The optional commands and the Target methods implementing them
+OPTIONAL_COMMANDS = {
+    'add-ports': 'add_ports',
+    'add-port': 'add_port',
+    'remove-port': 'remove_port',
+    'list-ports': 'list_ports',
+    'show-port': 'show_port',
+    'set-ana': 'set_ana',
+    'set-host': 'set_host',
+}
+
+TARGETS = {
+    'nvmet': 'nvme_target_control.targets.nvmet:NvmetTarget',
+}
+
+
+def create(config: dict[str, Any]) -> Target:
+    """Create the target the [target] section describes."""
+    cls = plugin.load('target', config.get('type', 'nvmet'), TARGETS)
+    if not (isinstance(cls, type) and issubclass(cls, Target)):
+        raise plugin.PluginError(f'{cls!r} is not a Target')
+    return cls(config)
diff --git a/contrib/nvme-target-control/nvme_target_control/targets/__init__.py b/contrib/nvme-target-control/nvme_target_control/targets/__init__.py
new file mode 100644
index 000000000000..99f346b65556
--- /dev/null
+++ b/contrib/nvme-target-control/nvme_target_control/targets/__init__.py
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+"""Built-in target implementations."""
diff --git a/contrib/nvme-target-control/nvme_target_control/targets/nvmet.py b/contrib/nvme-target-control/nvme_target_control/targets/nvmet.py
new file mode 100644
index 000000000000..f5f2e8cc2a62
--- /dev/null
+++ b/contrib/nvme-target-control/nvme_target_control/targets/nvmet.py
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+"""The Linux nvmet target, configured through configfs.
+
+The configfs changes are in the shell script nvmet.sh next to this file.
+It runs on the target through a channel, ssh by default. [target] options:
+
+  channel      how to reach the target: 'ssh' (default), 'local' or
+               'package.module:Class'
+  remote       ssh destination, e.g. 'root@nvmet.local'
+  ssh_options  list of extra ssh arguments
+  blkdev       block device or file backing the namespace; by default
+               setup creates a loop device on an image file on the target
+               and cleanup removes both
+  img_size     size of the image file, default 1G
+
+A new port gets the lowest free port ID N >= 1 and the service ID
+trsvid + N - 1, so the first port listens on trsvid. The values of
+'config --show-*' can be set too, see Target.
+"""
+
+from collections.abc import Sequence
+from pathlib import Path
+from typing import Any
+
+from .. import channel
+from ..target import Port, Subsystem, Target, resolve
+
+SCRIPT = Path(__file__).resolve().parent / 'nvmet.sh'
+
+# The configfs attributes of the HOST_ATTRS
+HOST_ATTRS = {
+    'hostkey': 'dhchap_key',
+    'ctrlkey': 'dhchap_ctrl_key',
+    'hash': 'dhchap_hash',
+    'dhgroup': 'dhchap_dhgroup',
+}
+
+
+class NvmetTarget(Target):
+    """Linux nvmet target."""
+
+    def __init__(self, config: dict[str, Any]) -> None:
+        super().__init__(config)
+        self.channel = channel.create(config)
+
+    def traddr(self) -> str:
+        return resolve(self.channel.host())
+
+    def _run(self, *args: str) -> list[str]:
+        """Run an nvmet.sh command, return the words it printed."""
+        return self.channel.run(SCRIPT.read_text(), args).split()
+
+    def _port_args(self, tls: str) -> Sequence[str]:
+        return (
+            self.value('trtype'),
+            self.value('traddr'),
+            self.value('trsvid'),
+            tls,
+        )
+
+    def setup(
+        self, subsys: Subsystem, nr_ports: int = 1, tls: str = 'none'
+    ) -> None:
+        self._run(
+            'setup',
+            *self._port_args(tls),
+            str(nr_ports),
+            subsys.nqn,
+            subsys.uuid,
+            str(self.config.get('blkdev', '')),
+            str(self.config.get('img_size', '1G')),
+            subsys.hostnqn,
+            subsys.hostkey,
+            subsys.ctrlkey,
+        )
+
+    def cleanup(self, subsysnqn: str) -> None:
+        self._run('cleanup', subsysnqn)
+
+    def add_ports(
+        self, subsysnqn: str, nr_ports: int, tls: str = 'none'
+    ) -> list[str]:
+        return self._run(
+            'add-ports', *self._port_args(tls), str(nr_ports), subsysnqn
+        )
+
+    def add_port(self, tls: str = 'none') -> str:
+        (port,) = self._run('add-port', *self._port_args(tls))
+        return port
+
+    def remove_port(self, port: str) -> None:
+        self._run('remove-port', port)
+
+    def list_ports(self, subsysnqn: str) -> list[str]:
+        return self._run('list-ports', subsysnqn)
+
+    def show_port(self, port: str) -> Port:
+        trtype, traddr, trsvcid = self._run('show-port', port)
+        return Port(trtype, traddr, trsvcid)
+
+    def set_ana(self, port: str, grpid: int, state: str) -> None:
+        self._run('set-ana', port, str(grpid), state)
+
+    def set_host(self, hostnqn: str, attrs: dict[str, str]) -> None:
+        for name, value in attrs.items():
+            self._run('set-host', hostnqn, HOST_ATTRS[name], value)
diff --git a/contrib/nvme-target-control/nvme_target_control/targets/nvmet.sh b/contrib/nvme-target-control/nvme_target_control/targets/nvmet.sh
new file mode 100644
index 000000000000..33f383eb17f0
--- /dev/null
+++ b/contrib/nvme-target-control/nvme_target_control/targets/nvmet.sh
@@ -0,0 +1,246 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+#
+# Configure subsystems and ports of a Linux nvmet target through configfs.
+# Runs on the target.
+#
+# Usage: nvmet.sh COMMAND ARGS...
+#
+#   setup TRTYPE TRADDR TRSVCID TLS NR_PORTS SUBSYSNQN SUBSYS_UUID BLKDEV
+#         IMG_SIZE HOSTNQN HOSTKEY CTRLKEY
+#	Create a subsystem with namespace 1, allow one host and export the
+#	subsystem on NR_PORTS new ports.  Without BLKDEV, the namespace is a
+#	loop device on an IMG_SIZE image file, cleanup removes both.
+#   cleanup SUBSYSNQN
+#	Remove a subsystem, the ports which exported it and no other
+#	subsystem, the hosts no other subsystem allows and the loop device
+#	and image file setup created.
+#   add-ports TRTYPE TRADDR TRSVCID TLS NR_PORTS SUBSYSNQN
+#	Export a subsystem on NR_PORTS new ports, print their IDs.
+#   add-port TRTYPE TRADDR TRSVCID TLS
+#	Create a port which exports no subsystem, print its ID.
+#   remove-port PORT
+#	Remove a port and the subsystem links and ANA groups on it.
+#   list-ports SUBSYSNQN
+#	Print the IDs of the ports which export a subsystem.
+#   show-port PORT
+#	Print the transport type, address and service ID of a port.
+#   set-ana PORT GRPID STATE
+#	Set the state of an ANA group on a port, create the group if needed.
+#   set-host HOSTNQN ATTR VALUE
+#	Set a DH-CHAP attribute of a host: dhchap_key, dhchap_ctrl_key,
+#	dhchap_hash or dhchap_dhgroup.
+#
+# A new port gets the lowest free port ID N >= 1 and the service ID
+# TRSVCID + N - 1.  TLS is none, not-required or required.
+
+set -e
+
+cfs=/sys/kernel/config/nvmet
+state=/var/tmp/nvme-target-control
+
+die() {
+	echo "nvmet.sh: $*" >&2
+	exit 1
+}
+
+# add_port TRTYPE TRADDR TRSVCID TLS: create a port, set its ID in $port
+add_port() {
+	trtype=$1
+	traddr=$2
+	trsvcid=$3
+	tls=$4
+
+	modprobe nvmet
+	modprobe "nvmet-${trtype}"
+
+	port=1
+	while [ -e "${cfs}/ports/${port}" ]; do
+		port=$((port + 1))
+	done
+	case "${traddr}" in
+	*:*)	adrfam=ipv6 ;;
+	*)	adrfam=ipv4 ;;
+	esac
+
+	mkdir "${cfs}/ports/${port}"
+	echo "${trtype}" > "${cfs}/ports/${port}/addr_trtype"
+	echo "${adrfam}" > "${cfs}/ports/${port}/addr_adrfam"
+	echo "${traddr}" > "${cfs}/ports/${port}/addr_traddr"
+	echo $((trsvcid + port - 1)) > "${cfs}/ports/${port}/addr_trsvcid"
+	case "${tls}" in
+	none)
+		;;
+	not-required|required)
+		echo tls1.3 > "${cfs}/ports/${port}/addr_tsas"
+		if [ "${tls}" = not-required ]; then
+			echo "not required" > "${cfs}/ports/${port}/addr_treq"
+		fi
+		;;
+	*)
+		die "unknown TLS mode: ${tls}"
+		;;
+	esac
+}
+
+# add_ports TRTYPE TRADDR TRSVCID TLS NR_PORTS SUBSYSNQN
+add_ports() {
+	[ -d "${cfs}/subsystems/$6" ] || die "no subsystem $6"
+	i=0
+	while [ "${i}" -lt "$5" ]; do
+		add_port "$1" "$2" "$3" "$4"
+		# Linking the first subsystem enables the port.
+		ln -s "${cfs}/subsystems/$6" "${cfs}/ports/${port}/subsystems/$6"
+		echo "${port}"
+		i=$((i + 1))
+	done
+}
+
+remove_port() {
+	p="${cfs}/ports/$1"
+	[ -d "${p}" ] || die "no port $1"
+	for link in "${p}"/subsystems/*; do
+		[ -L "${link}" ] && rm "${link}"
+	done
+	for grp in "${p}"/ana_groups/*; do
+		# ANA group 1 belongs to the port.
+		[ "${grp##*/}" = 1 ] || rmdir "${grp}"
+	done
+	rmdir "${p}"
+}
+
+setup() {
+	trtype=$1
+	traddr=$2
+	trsvcid=$3
+	tls=$4
+	nr_ports=$5
+	subsysnqn=$6
+	subsys_uuid=$7
+	blkdev=$8
+	img_size=$9
+	hostnqn=${10}
+	hostkey=${11}
+	ctrlkey=${12}
+
+	modprobe nvmet
+
+	if [ -z "${blkdev}" ]; then
+		mkdir -p "${state}"
+		img="${state}/${subsysnqn}.img"
+		rm -f "${img}"
+		truncate -s "${img_size}" "${img}"
+		blkdev=$(losetup -f --show "${img}")
+		echo "${blkdev}" > "${state}/${subsysnqn}.loop"
+	fi
+
+	host="${cfs}/hosts/${hostnqn}"
+	mkdir -p "${host}"
+	if [ -n "${hostkey}" ]; then
+		echo "${hostkey}" > "${host}/dhchap_key"
+	fi
+	if [ -n "${ctrlkey}" ]; then
+		echo "${ctrlkey}" > "${host}/dhchap_ctrl_key"
+	fi
+
+	subsys="${cfs}/subsystems/${subsysnqn}"
+	mkdir "${subsys}"
+	echo 0 > "${subsys}/attr_allow_any_host"
+	mkdir "${subsys}/namespaces/1"
+	echo "${blkdev}" > "${subsys}/namespaces/1/device_path"
+	echo "${subsys_uuid}" > "${subsys}/namespaces/1/device_uuid"
+	echo 1 > "${subsys}/namespaces/1/enable"
+	ln -s "${host}" "${subsys}/allowed_hosts/${hostnqn}"
+
+	add_ports "${trtype}" "${traddr}" "${trsvcid}" "${tls}" \
+		"${nr_ports}" "${subsysnqn}" > /dev/null
+}
+
+cleanup() {
+	subsysnqn=$1
+	subsys="${cfs}/subsystems/${subsysnqn}"
+
+	if [ -d "${subsys}" ]; then
+		for p in "${cfs}"/ports/*; do
+			[ -L "${p}/subsystems/${subsysnqn}" ] || continue
+			rm "${p}/subsystems/${subsysnqn}"
+			if [ -z "$(ls "${p}/subsystems")" ]; then
+				remove_port "${p##*/}"
+			fi
+		done
+
+		for link in "${subsys}"/allowed_hosts/*; do
+			[ -L "${link}" ] || continue
+			hostnqn=$(basename "${link}")
+			rm "${link}"
+			if ! ls "${cfs}"/subsystems/*/allowed_hosts/"${hostnqn}" \
+					> /dev/null 2>&1; then
+				rmdir "${cfs}/hosts/${hostnqn}"
+			fi
+		done
+
+		for ns in "${subsys}"/namespaces/*; do
+			[ -d "${ns}" ] || continue
+			echo 0 > "${ns}/enable"
+			rmdir "${ns}"
+		done
+
+		rmdir "${subsys}"
+	fi
+
+	if [ -f "${state}/${subsysnqn}.loop" ]; then
+		losetup -d "$(cat "${state}/${subsysnqn}.loop")"
+		rm -f "${state}/${subsysnqn}.loop" "${state}/${subsysnqn}.img"
+	fi
+}
+
+list_ports() {
+	for p in "${cfs}"/ports/*; do
+		[ -L "${p}/subsystems/$1" ] && echo "${p##*/}"
+	done
+	return 0
+}
+
+show_port() {
+	p="${cfs}/ports/$1"
+	[ -d "${p}" ] || die "no port $1"
+	echo "$(cat "${p}/addr_trtype") $(cat "${p}/addr_traddr")" \
+		"$(cat "${p}/addr_trsvcid")"
+}
+
+set_ana() {
+	p="${cfs}/ports/$1"
+	[ -d "${p}" ] || die "no port $1"
+	grp="${p}/ana_groups/$2"
+	[ -d "${grp}" ] || mkdir "${grp}"
+	echo "$3" > "${grp}/ana_state"
+}
+
+set_host() {
+	h="${cfs}/hosts/$1"
+	[ -d "${h}" ] || die "no host $1"
+	case "$2" in
+	dhchap_key|dhchap_ctrl_key|dhchap_hash|dhchap_dhgroup)
+		echo "$3" > "${h}/$2"
+		;;
+	*)
+		die "unknown host attribute: $2"
+		;;
+	esac
+}
+
+cmd=$1
+shift
+case "${cmd}" in
+setup)		setup "$@" ;;
+cleanup)	cleanup "$@" ;;
+add-ports)	add_ports "$@" ;;
+add-port)	add_port "$@"; echo "${port}" ;;
+remove-port)	remove_port "$@" ;;
+list-ports)	list_ports "$@" ;;
+show-port)	show_port "$@" ;;
+set-ana)	set_ana "$@" ;;
+set-host)	set_host "$@" ;;
+*)		die "unknown command: ${cmd}" ;;
+esac
diff --git a/contrib/nvme-target-control/pyproject.toml b/contrib/nvme-target-control/pyproject.toml
new file mode 100644
index 000000000000..2445637e9bd4
--- /dev/null
+++ b/contrib/nvme-target-control/pyproject.toml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-3.0+
+#
+# The linters for nvme-target-control: ruff check and mypy, run from this
+# directory. The tests: python3 -m unittest discover -s tests
+
+[project]
+name = "nvme-target-control"
+version = "0.1.0"
+description = "Set up and tear down remote NVMe targets for blktests"
+requires-python = ">=3.10"
+license = { text = "GPL-3.0-or-later" }
+# Pure stdlib, Python < 3.11 needs tomli
+dependencies = ["tomli; python_version < '3.11'"]
+
+[tool.ruff]
+line-length = 79
+target-version = "py310"
+extend-include = ["nvme-target-control"]
+
+[tool.ruff.lint]
+select = [
+    "E",    # pycodestyle
+    "W",
+    "F",    # pyflakes
+    "I",    # isort
+    "B",    # bugbear
+    "UP",   # pyupgrade
+    "SIM",  # simplify
+    "RUF",
+]
+
+[tool.ruff.format]
+quote-style = "single"
+
+[tool.mypy]
+python_version = "3.10"
+strict = true
+files = ["nvme_target_control", "tests"]
+
+[tool.ruff.lint.per-file-ignores]
+# its start runs with old Pythons, to report the version
+"nvme-target-control" = ["UP036"]
diff --git a/contrib/nvme-target-control/tests/test_target_control.py b/contrib/nvme-target-control/tests/test_target_control.py
new file mode 100644
index 000000000000..730d6c8a9b69
--- /dev/null
+++ b/contrib/nvme-target-control/tests/test_target_control.py
@@ -0,0 +1,380 @@
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+"""Tests for the command line, the plugin lookup and the nvmet target."""
+
+import contextlib
+import io
+import os
+import shlex
+import sys
+import tempfile
+import types
+import unittest
+from collections.abc import Sequence
+from pathlib import Path
+from typing import Any, ClassVar
+from unittest import mock
+
+sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
+
+from nvme_target_control import channel, cli, plugin, target
+from nvme_target_control.targets import nvmet
+
+CONFIG = """\
+[target]
+remote = "root@127.0.0.1"
+"""
+
+SETUP_ARGS = [
+    'setup',
+    '--subsysnqn', 'blktests-subsystem-1',
+    '--subsys-uuid', '91fdba0d-f87b-4c25-b80f-db7be1418b9e',
+    '--hostnqn', 'nqn.2014-08.org.nvmexpress:uuid:57c34e91',
+]  # fmt: skip
+
+
+class RecordingTarget(target.Target):
+    """A target plugin which records the calls."""
+
+    calls: ClassVar[list[tuple[str, Any]]] = []
+
+    def traddr(self) -> str:
+        return '192.0.2.1'
+
+    def setup(
+        self, subsys: target.Subsystem, nr_ports: int = 1, tls: str = 'none'
+    ) -> None:
+        self.calls.append(('setup', (subsys, nr_ports, tls)))
+
+    def cleanup(self, subsysnqn: str) -> None:
+        self.calls.append(('cleanup', subsysnqn))
+
+
+PLUGIN = """\
+[target]
+type = "fake_array:RecordingTarget"
+"""
+
+
+class ConfigTestCase(unittest.TestCase):
+    def setUp(self) -> None:
+        tmp = tempfile.TemporaryDirectory()
+        self.addCleanup(tmp.cleanup)
+        self.config = Path(tmp.name) / 'config.toml'
+        self.config.write_text(CONFIG)
+        env = mock.patch.dict(
+            os.environ, {'NVME_TARGET_CONTROL_CONFIG': str(self.config)}
+        )
+        env.start()
+        self.addCleanup(env.stop)
+        module = types.ModuleType('fake_array')
+        module.RecordingTarget = RecordingTarget  # type: ignore[attr-defined]
+        modules = mock.patch.dict(sys.modules, {'fake_array': module})
+        modules.start()
+        self.addCleanup(modules.stop)
+        RecordingTarget.calls = []
+
+    def main(self, argv: Sequence[str]) -> tuple[int, str, str]:
+        out, err = io.StringIO(), io.StringIO()
+        with (
+            contextlib.redirect_stdout(out),
+            contextlib.redirect_stderr(err),
+        ):
+            ret = cli.main(argv)
+        return ret, out.getvalue(), err.getvalue()
+
+    def show(self, option: str) -> str:
+        ret, out, err = self.main(['config', f'--show-{option}'])
+        self.assertEqual((ret, err), (0, ''))
+        return out.rstrip('\n')
+
+
+class TestCli(ConfigTestCase):
+    def test_defaults(self) -> None:
+        self.assertEqual(self.show('traddr'), '127.0.0.1')
+        self.assertEqual(self.show('host-traddr'), '127.0.0.1')
+        self.assertEqual(self.show('trtype'), 'tcp')
+        self.assertEqual(self.show('trsvid'), '4420')
+        self.assertEqual(self.show('subsysnqn'), 'blktests-subsystem-1')
+        self.assertEqual(
+            self.show('subsys-uuid'), '91fdba0d-f87b-4c25-b80f-db7be1418b9e'
+        )
+        self.assertEqual(self.show('blkdev-type'), 'device')
+
+    def test_host_identity(self) -> None:
+        files = {
+            '/etc/nvme/hostid': 'abc',
+            '/etc/nvme/hostnqn': 'nqn.test:host',
+        }
+        with mock.patch.object(target, 'read_first_line', files.get):
+            self.assertEqual(self.show('hostid'), 'abc')
+            self.assertEqual(self.show('hostnqn'), 'nqn.test:host')
+        with mock.patch.object(target, 'read_first_line', lambda _: None):
+            self.assertEqual(self.show('hostid'), target.DEF_HOSTID)
+            self.assertEqual(
+                self.show('hostnqn'),
+                f'nqn.2014-08.org.nvmexpress:uuid:{target.DEF_HOSTID}',
+            )
+
+    def test_overrides(self) -> None:
+        self.config.write_text(
+            CONFIG + 'traddr = "10.9.9.9"\ntrsvid = 4421\nhostid = "x"\n'
+        )
+        self.assertEqual(self.show('traddr'), '10.9.9.9')
+        self.assertEqual(self.show('trsvid'), '4421')
+        self.assertEqual(self.show('hostid'), 'x')
+
+    def test_external_target_plugin(self) -> None:
+        self.config.write_text(PLUGIN)
+        self.assertEqual(self.show('traddr'), '192.0.2.1')
+        ret, _, err = self.main([*SETUP_ARGS, '--ctrlkey', 'ckey'])
+        self.assertEqual((ret, err), (0, ''))
+        ret, _, err = self.main(
+            ['cleanup', '--subsysnqn', 'blktests-subsystem-1']
+        )
+        self.assertEqual((ret, err), (0, ''))
+        (cmd, (subsys, nr_ports, tls)), (cmd2, nqn) = RecordingTarget.calls
+        self.assertEqual(cmd, 'setup')
+        self.assertEqual(subsys.nqn, 'blktests-subsystem-1')
+        self.assertEqual(subsys.ctrlkey, 'ckey')
+        self.assertEqual((nr_ports, tls), (1, 'none'))
+        self.assertEqual((cmd2, nqn), ('cleanup', 'blktests-subsystem-1'))
+
+    def test_setup_ports_tls(self) -> None:
+        self.config.write_text(PLUGIN)
+        ret, _, err = self.main([*SETUP_ARGS, '--ports', '3', '--tls'])
+        self.assertEqual((ret, err), (0, ''))
+        ret, _, err = self.main([*SETUP_ARGS, '--force-tls'])
+        self.assertEqual((ret, err), (0, ''))
+        (_, (_, n1, tls1)), (_, (_, n2, tls2)) = RecordingTarget.calls
+        self.assertEqual(
+            (n1, tls1, n2, tls2), (3, 'not-required', 1, 'required')
+        )
+        with (
+            contextlib.redirect_stderr(io.StringIO()),
+            self.assertRaises(SystemExit),
+        ):
+            cli.main([*SETUP_ARGS, '--tls', '--force-tls'])
+
+    def test_features(self) -> None:
+        self.assertEqual(
+            self.show('features'),
+            'add-ports add-port remove-port list-ports show-port set-ana '
+            'set-host',
+        )
+        self.config.write_text(PLUGIN)
+        self.assertEqual(self.show('features'), '')
+
+    def test_set_host(self) -> None:
+        with mock.patch.object(nvmet.NvmetTarget, 'set_host') as set_host:
+            ret, _, err = self.main(
+                ['set-host', '--hostnqn', 'nqn.h', '--dhgroup', 'ffdhe2048']
+            )
+        self.assertEqual((ret, err), (0, ''))
+        set_host.assert_called_once_with('nqn.h', {'dhgroup': 'ffdhe2048'})
+
+    def test_port_output(self) -> None:
+        with (
+            mock.patch.object(
+                nvmet.NvmetTarget,
+                'show_port',
+                return_value=target.Port('tcp', '10.0.0.1', '4421'),
+            ),
+            mock.patch.object(
+                nvmet.NvmetTarget, 'add_ports', return_value=['2', '3']
+            ),
+        ):
+            ret, out, _ = self.main(['show-port', '--port', '2'])
+            self.assertEqual((ret, out), (0, 'tcp 10.0.0.1 4421\n'))
+            ret, out, _ = self.main(
+                ['add-ports', '--ports', '2', '--subsysnqn', 'nqn.s']
+            )
+            self.assertEqual((ret, out), (0, '2\n3\n'))
+
+    def test_ports_not_implemented(self) -> None:
+        self.config.write_text(PLUGIN)
+        for argv in [
+            ['add-ports', '--ports', '2', *SETUP_ARGS[1:]],
+            ['add-port'],
+            ['remove-port', '--port', '1'],
+            ['list-ports', '--subsysnqn', 'nqn.s'],
+            ['show-port', '--port', '1'],
+            ['set-ana', '--port', '1', '--grpid', '1', '--state', 'optimized'],
+            ['set-host', '--hostnqn', 'nqn.h', '--hash', 'hmac(sha256)'],
+        ]:
+            ret, out, err = self.main(argv)
+            self.assertEqual((ret, out), (1, ''))
+            self.assertIn(f'does not implement {argv[0]}', err)
+
+    def test_skip_setup_cleanup(self) -> None:
+        self.config.write_text(PLUGIN + 'skip_setup_cleanup = true\n')
+        ret, _, err = self.main(SETUP_ARGS)
+        self.assertEqual((ret, err), (0, ''))
+        self.assertEqual(RecordingTarget.calls, [])
+
+    def test_unknown_target(self) -> None:
+        self.config.write_text('[target]\ntype = "foo"\n')
+        ret, _, err = self.main(SETUP_ARGS)
+        self.assertEqual(ret, 1)
+        self.assertIn("unknown target 'foo'", err)
+
+    def test_missing_config(self) -> None:
+        self.config.unlink()
+        ret, _, err = self.main(SETUP_ARGS)
+        self.assertEqual(ret, 1)
+        self.assertIn('FileNotFoundError', err)
+
+
+class TestPlugin(unittest.TestCase):
+    def test_builtin_and_path(self) -> None:
+        self.assertIs(
+            plugin.load('channel', 'ssh', channel.CHANNELS),
+            channel.SshChannel,
+        )
+        self.assertIs(
+            plugin.load(
+                'channel',
+                'nvme_target_control.channel:LocalChannel',
+                channel.CHANNELS,
+            ),
+            channel.LocalChannel,
+        )
+
+    def test_errors(self) -> None:
+        for name in ['foo', 'no_such_module:Foo', 'nvme_target_control:Foo']:
+            with self.assertRaises(plugin.PluginError):
+                plugin.load('channel', name, channel.CHANNELS)
+
+    def test_wrong_base_class(self) -> None:
+        with self.assertRaises(plugin.PluginError):
+            channel.create({'channel': 'nvme_target_control.target:Target'})
+
+
+class TestChannel(unittest.TestCase):
+    def test_ssh_command(self) -> None:
+        ch = channel.SshChannel(
+            {'remote': 'root@t', 'ssh_options': ['-p', '22']}
+        )
+        cmd = ch.command(['nqn with space', "it's", ''])
+        self.assertEqual(cmd[:4], ['ssh', '-p', '22', 'root@t'])
+        # The remote shell splits the command back into the arguments.
+        self.assertEqual(
+            shlex.split(cmd[4]),
+            ['sh', '-s', '--', 'nqn with space', "it's", ''],
+        )
+
+    def test_ssh_host(self) -> None:
+        ch = channel.SshChannel({'remote': 'root@192.0.2.7'})
+        self.assertEqual(ch.host(), '192.0.2.7')
+
+    def test_ssh_needs_remote(self) -> None:
+        with self.assertRaises(channel.ChannelError):
+            channel.SshChannel({}).command([])
+
+    def test_local_run(self) -> None:
+        out = channel.LocalChannel({}).run('printf "%s|" "$@"', ['a b', ''])
+        self.assertEqual(out, 'a b||')
+
+    def test_local_run_fails(self) -> None:
+        with self.assertRaises(channel.ChannelError):
+            channel.LocalChannel({}).run('exit 3', [])
+
+
+class FakeChannel(channel.Channel):
+    runs: ClassVar[list[tuple[str, list[str]]]] = []
+
+    def command(self, args: Sequence[str]) -> list[str]:
+        return []
+
+    def host(self) -> str:
+        return '192.0.2.5'
+
+    output: ClassVar[str] = ''
+
+    def run(self, script: str, args: Sequence[str]) -> str:
+        self.runs.append((script, list(args)))
+        return self.output
+
+
+class TestNvmet(unittest.TestCase):
+    def target(
+        self, config: dict[str, Any], output: str = ''
+    ) -> nvmet.NvmetTarget:
+        FakeChannel.runs = []
+        FakeChannel.output = output
+        return nvmet.NvmetTarget(
+            {'channel': f'{__name__}:FakeChannel', **config}
+        )
+
+    def test_traddr_from_channel(self) -> None:
+        self.assertEqual(self.target({}).value('traddr'), '192.0.2.5')
+
+    def test_setup(self) -> None:
+        tgt = self.target({})
+        tgt.setup(target.Subsystem('nqn.s', 'uuid', 'nqn.h', 'hk', 'ck'))
+        ((script, args),) = FakeChannel.runs
+        self.assertIn('/sys/kernel/config/nvmet', script)
+        self.assertEqual(
+            args,
+            ['setup', 'tcp', '192.0.2.5', '4420', 'none', '1', 'nqn.s',
+             'uuid', '', '1G', 'nqn.h', 'hk', 'ck'],
+        )  # fmt: skip
+
+    def test_setup_options(self) -> None:
+        tgt = self.target(
+            {'blkdev': '/dev/nullb0', 'traddr': '10.0.0.1', 'trsvid': 4430}
+        )
+        tgt.setup(target.Subsystem('nqn.s', 'uuid', 'nqn.h'), 2, 'required')
+        ((_, args),) = FakeChannel.runs
+        self.assertEqual(
+            args[2:6] + args[8:9],
+            ['10.0.0.1', '4430', 'required', '2', '/dev/nullb0'],
+        )
+
+    def test_cleanup(self) -> None:
+        tgt = self.target({})
+        tgt.cleanup('nqn.s')
+        ((script, args),) = FakeChannel.runs
+        self.assertIn('losetup -d', script)
+        self.assertEqual(args, ['cleanup', 'nqn.s'])
+
+    def test_ports(self) -> None:
+        port_args = ['tcp', '192.0.2.5', '4420', 'none']
+        tgt = self.target({}, '2\n3\n')
+        self.assertEqual(tgt.add_ports('nqn.s', 2), ['2', '3'])
+        self.assertEqual(tgt.list_ports('nqn.s'), ['2', '3'])
+        self.assertEqual(
+            [args for _, args in FakeChannel.runs],
+            [['add-ports', *port_args, '2', 'nqn.s'],
+             ['list-ports', 'nqn.s']],
+        )  # fmt: skip
+
+        tgt = self.target({}, '4\n')
+        self.assertEqual(tgt.add_port('not-required'), '4')
+        tgt.remove_port('4')
+        tgt.set_ana('4', 2, 'inaccessible')
+        self.assertEqual(
+            [args for _, args in FakeChannel.runs],
+            [['add-port', 'tcp', '192.0.2.5', '4420', 'not-required'],
+             ['remove-port', '4'],
+             ['set-ana', '4', '2', 'inaccessible']],
+        )  # fmt: skip
+
+        tgt = self.target({})
+        tgt.set_host(
+            'nqn.h', {'ctrlkey': 'DHHC-1:00:x:', 'hash': 'hmac(sha512)'}
+        )
+        self.assertEqual(
+            [args for _, args in FakeChannel.runs],
+            [['set-host', 'nqn.h', 'dhchap_ctrl_key', 'DHHC-1:00:x:'],
+             ['set-host', 'nqn.h', 'dhchap_hash', 'hmac(sha512)']],
+        )  # fmt: skip
+
+        tgt = self.target({}, 'tcp 10.0.0.1 4421\n')
+        self.assertEqual(
+            tgt.show_port('2'), target.Port('tcp', '10.0.0.1', '4421')
+        )
+
+
+if __name__ == '__main__':
+    unittest.main()
diff --git a/contrib/nvme_target_control.py b/contrib/nvme_target_control.py
deleted file mode 100755
index 7ad1e4519427..000000000000
--- a/contrib/nvme_target_control.py
+++ /dev/null
@@ -1,204 +0,0 @@
-#!/usr/bin/env python3
-# SPDX-License-Identifier: GPL-3.0+
-
-# blktests calls this script to setup/teardown remote targets. blktests passes
-# all relevant information via the command line, e.g. --hostnqn.
-#
-# This script uses nvmetcli to setup the remote target (it depends on the REST
-# API feature [1]). There is not technical need for nvmetcli to use but it makes
-# it simple to setup a remote Linux box. If you want to setup someting else
-# you should to replace this part.
-#
-# There are couple of global configuration options which need to be set.
-# Add ~/.config/blktests/nvme_target_control.toml file with something like:
-#
-# [main]
-# skip_setup_cleanup=false
-# nvmetcli='/usr/bin/nvmetcli'
-# remote='http://nvmet.local:5000'
-#
-# [host]
-# blkdev_type='device'
-# trtype='tcp'
-# hostnqn='nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349'
-# hostid='0f01fb42-9f7f-4856-b0b3-51e60b8de349'
-# host_traddr='192.168.154.187'
-#
-# [subsys_0]
-# traddr='192.168.19.189'
-# trsvid='4420'
-# subsysnqn='blktests-subsystem-1'
-# subsys_uuid='91fdba0d-f87b-4c25-b80f-db7be1418b9e'
-#
-# This expects nvmetcli with the restapi service running on target.
-#
-# Alternatively, you can skip the the target setup/cleanup completely
-# (skip_setup_cleanup) and run against a previously configured target.
-#
-# [main]
-# skip_setup_cleanup=true
-# nvmetcli='/usr/bin/nvmetcli'
-# remote='http://nvmet.local:5000'
-#
-# [host]
-# blkdev_type='device'
-# trtype='tcp'
-# hostnqn='nqn.2014-08.org.nvmexpress:uuid:1a9e23dd-466e-45ca-9f43-a29aaf47cb21'
-# hostid='1a9e23dd-466e-45ca-9f43-a29aaf47cb21'
-# host_traddr='10.161.16.48'
-#
-# [subsys_0]
-# traddr='10.162.198.45'
-# trsvid='4420'
-# subsysnqn='nqn.1988-11.com.dell:powerstore:00:f03028e73ef7D032D81E'
-# subsys_uuid='3a5c104c-ee41-38a1-8ccf-0968003d54e7'
-# blkdev='/dev/nullb0'
-#
-# nvmetcli uses JSON configuration, thus this script creates a JSON configuration
-# using a jinja2 template. After this step we simple have to set the blktests
-# variable correctly and start blktests.
-#
-#   NVME_TARGET_CONTROL=~/blktests/contrib/nvme_target_control.py ./check nvme
-#
-# [1] https://github.com/hreinecke/nvmetcli/tree/restapi
-
-import os
-
-# workaround for python<3.11
-TOML_OPEN_MODE="rb"
-try:
-    import tomllib
-except ModuleNotFoundError:
-    import pip._vendor.tomli as tomllib
-    TOML_OPEN_MODE="r"
-
-import argparse
-import subprocess
-from jinja2 import Environment, FileSystemLoader
-
-
-XDG_CONFIG_HOME = os.environ.get("XDG_CONFIG_HOME")
-if not XDG_CONFIG_HOME:
-    XDG_CONFIG_HOME = os.environ.get('HOME') + '/.config'
-
-
-with open(f'{XDG_CONFIG_HOME}/blktests/nvme_target_control.toml', TOML_OPEN_MODE) as f:
-    config = tomllib.load(f)
-    nvmetcli = config['main']['nvmetcli']
-    remote = config['main']['remote']
-
-
-def gen_conf(conf):
-    basepath = os.path.dirname(__file__)
-    environment = Environment(loader=FileSystemLoader(basepath))
-    template = environment.get_template('nvmet-subsys.jinja2')
-    filename = f'{conf["subsysnqn"]}.json'
-    content = template.render(conf)
-    with open(filename, mode='w', encoding='utf-8') as outfile:
-        outfile.write(content)
-
-
-def target_setup(args):
-    if config['main']['skip_setup_cleanup']:
-        return
-
-    conf = {
-        'subsysnqn': args.subsysnqn,
-        'subsys_uuid': args.subsys_uuid,
-        'hostnqn': args.hostnqn,
-        'allowed_hosts': args.hostnqn,
-        'ctrlkey': args.ctrlkey,
-        'hostkey': args.hostkey,
-        'blkdev': config['subsys_0']['blkdev'],
-    }
-
-    gen_conf(conf)
-
-    subprocess.call(['python3', nvmetcli, '--remote=' + remote,
-                     'restore', args.subsysnqn + '.json'])
-
-def target_add_ports(_):
-    if config['main']['skip_setup_cleanup']:
-        return
-
-    print("Warning: add-ports is not implemented yet.")
-
-def target_cleanup(args):
-    if config['main']['skip_setup_cleanup']:
-        return
-
-    subprocess.call(['python3', nvmetcli, '--remote=' + remote,
-                     'clear', args.subsysnqn + '.json'])
-
-
-def target_config(args):
-	if args.show_blkdev_type:
-		print(config['host']['blkdev_type'])
-	elif args.show_trtype:
-		print(config['host']['trtype'])
-	elif args.show_hostnqn:
-		print(config['host']['hostnqn'])
-	elif args.show_hostid:
-		print(config['host']['hostid'])
-	elif args.show_host_traddr:
-		print(config['host']['host_traddr'])
-	elif args.show_traddr:
-		print(config['subsys_0']['traddr'])
-	elif args.show_trsvid:
-		print(config['subsys_0']['trsvid'])
-	elif args.show_subsysnqn:
-		print(config['subsys_0']['subsysnqn'])
-	elif args.show_subsys_uuid:
-		print(config['subsys_0']['subsys_uuid'])
-
-
-def build_parser():
-    parser = argparse.ArgumentParser()
-    sub = parser.add_subparsers(required=True)
-
-    setup = sub.add_parser('setup')
-    setup.add_argument('--subsysnqn', required=True)
-    setup.add_argument('--subsys-uuid', required=True)
-    setup.add_argument('--hostnqn', required=True)
-    setup.add_argument('--ctrlkey', default='')
-    setup.add_argument('--hostkey', default='')
-    setup.set_defaults(func=target_setup)
-
-    setup = sub.add_parser('add-ports')
-    setup.add_argument('--ports', required=True)
-    setup.add_argument('--subsysnqn', required=True)
-    setup.add_argument('--subsys-uuid', required=True)
-    setup.add_argument('--hostnqn', required=True)
-    setup.add_argument('--ctrlkey', default='')
-    setup.add_argument('--hostkey', default='')
-    setup.set_defaults(func=target_add_ports)
-
-    cleanup = sub.add_parser('cleanup')
-    cleanup.add_argument('--subsysnqn', required=True)
-    cleanup.set_defaults(func=target_cleanup)
-
-    config = sub.add_parser('config')
-    config.add_argument('--show-blkdev-type', action='store_true')
-    config.add_argument('--show-trtype', action='store_true')
-    config.add_argument('--show-hostnqn', action='store_true')
-    config.add_argument('--show-hostid', action='store_true')
-    config.add_argument('--show-host-traddr', action='store_true')
-    config.add_argument('--show-traddr', action='store_true')
-    config.add_argument('--show-trsvid', action='store_true')
-    config.add_argument('--show-subsys-uuid', action='store_true')
-    config.add_argument('--show-subsysnqn', action='store_true')
-    config.set_defaults(func=target_config)
-
-    return parser
-
-
-def main():
-    import sys
-
-    parser = build_parser()
-    args = parser.parse_args()
-    args.func(args)
-
-
-if __name__ == '__main__':
-    main()
diff --git a/contrib/nvmet-subsys.jinja2 b/contrib/nvmet-subsys.jinja2
deleted file mode 100644
index a446fbd9b784..000000000000
--- a/contrib/nvmet-subsys.jinja2
+++ /dev/null
@@ -1,71 +0,0 @@
-{
-  "hosts": [
-    {
-      "nqn": "{{ hostnqn }}"
-    }
-  ],
-  "ports": [
-    {
-      "addr": {
-        "adrfam": "ipv4",
-        "traddr": "0.0.0.0",
-        "treq": "not specified",
-        "trsvcid": "4420",
-        "trtype": "tcp",
-        "tsas": "none"
-      },
-      "ana_groups": [
-        {
-          "ana": {
-            "state": "optimized"
-          },
-          "grpid": 1
-        }
-      ],
-      "param": {
-        "inline_data_size": "16384",
-        "pi_enable": "0"
-      },
-      "portid": 0,
-      "referrals": [],
-      "subsystems": [
-        "{{ subsysnqn }}"
-      ]
-    }
-  ],
-  "subsystems": [
-    {
-      "allowed_hosts": [
-        "{{ allowed_hosts }}"
-      ],
-      "attr": {
-        "allow_any_host": "0",
-        "cntlid_max": "65519",
-        "cntlid_min": "1",
-        "firmware": "yada",
-        "ieee_oui": "0x000000",
-        "model": "Linux",
-        "pi_enable": "0",
-        "qid_max": "128",
-        "serial": "0c74361069d9db6c65ef",
-        "version": "1.3"
-      },
-      "namespaces": [
-        {
-          "ana": {
-            "grpid": "1"
-          },
-          "ana_grpid": 1,
-          "device": {
-            "nguid": "00000000-0000-0000-0000-000000000000",
-            "path": "{{ blkdev }}",
-            "uuid": "{{ subsys_uuid }}"
-          },
-          "enable": 1,
-          "nsid": 1
-        }
-      ],
-      "nqn": "{{ subsysnqn }}"
-    }
-  ]
-}

-- 
2.56.0

