Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810737;
	b=rRcaCodALGiYVU3w2NylXOJYtp/IMQ8sOGbVLyoyD39J02J7Uzxk9lFiaVpXuZ1V6s8S
	 4a7XR9C0PTLsmfGTCbQoJvguqeVI/TbQ8riZ8wU7PwTECNcvItKxeVSrFEzDwxMyldA1K
	 6gLow49fIml18wUXb0E31JCI1fjRh5BisfnYZe38zkR26aWi7fN7pwktDGIaYiAQyZa/V
	 FkBZotI4otoUEzbglegnkbkg+a1aAtjjsZx9D7FDPqNF8EegRRzZ3BCFV012AokMmbnD7
	 FVTowarW8dZU2ZrsGSa3O9y/AKQu357UmQXJ2y322Q+VvgteO51pvU5Nkl3tjrkjbRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810737;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=N4fy+JSn/1f6rtV49KnVjO5Nktg/XWiLfB75i77CKgo=;
	b=MntZ2ydDbC19vlXxttK9Jipu+1qq46E8w2fB75dKVzoxDidiJ9m3QO22v29Z7ZnpCOWs
	 xvH72cH5izfQ8ol4BiJOwsoAwK02lmTEhFwukZ/xXIQ/aYfkTAF7Tc//ViWRrJhmCSnin
	 CisTJOzr2uIHT/dHOOOENLPGAIex8eFhXtKarFT0Vedxc2cDT6c9Kbq1dxq8c9Y8L4upp
	 Y8/EBGalpRGm6KKh9WlQU3LNudIrqghrRQpKZGOAUVnQiaftT4Tr+7+A+Sp+6eNyh2anu
	 O6Gnau5dVZcrX1CwZgixPDkIY+R3LhvJWH/oWR7pV5uRUM0AKf/JFS+fBEMu0g1tUeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bsANK4aD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QCPOIY1i;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bsANK4aD;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QCPOIY1i;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE34606A337
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 16:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE34606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bsANK4aD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QCPOIY1i;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bsANK4aD;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QCPOIY1i
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3FA21F787;
	Wed,  4 Nov 2026 16:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4fy+JSn/1f6rtV49KnVjO5Nktg/XWiLfB75i77CKgo=;
	b=bsANK4aDrxS2oe2L33wrfEfnR+CaiAwNUiDGbFwEhrKNVYhsA/lFmR5CsVfCdv6tHFGxcd
	1TRqtrQLYNbzVdQvOjrPk6IHydSdJ0bEsuKpqhpgu9l6VZn3pMeFVTVy61pRwCi5CZdliW
	p8z6Pc59wswLIzgNAtdIkr/OPimjRzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4fy+JSn/1f6rtV49KnVjO5Nktg/XWiLfB75i77CKgo=;
	b=QCPOIY1ijM0eB9TdakecypS7LFo8OPVlUBScxcGzekaqroNbGOF36Fw3xQ1r29FFyh+oxH
	TI/y1eMY06W5C2DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bsANK4aD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QCPOIY1i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4fy+JSn/1f6rtV49KnVjO5Nktg/XWiLfB75i77CKgo=;
	b=bsANK4aDrxS2oe2L33wrfEfnR+CaiAwNUiDGbFwEhrKNVYhsA/lFmR5CsVfCdv6tHFGxcd
	1TRqtrQLYNbzVdQvOjrPk6IHydSdJ0bEsuKpqhpgu9l6VZn3pMeFVTVy61pRwCi5CZdliW
	p8z6Pc59wswLIzgNAtdIkr/OPimjRzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4fy+JSn/1f6rtV49KnVjO5Nktg/XWiLfB75i77CKgo=;
	b=QCPOIY1ijM0eB9TdakecypS7LFo8OPVlUBScxcGzekaqroNbGOF36Fw3xQ1r29FFyh+oxH
	TI/y1eMY06W5C2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9E211350A;
	Wed,  4 Nov 2026 16:45:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 22oYJC1h62rSfQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 16:45:33 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 17:44:49 +0100
Subject: [PATCH blktests 10/10] contrib/nvme-target-control: add a NetApp
 ONTAP target
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
Message-Id: <20261104-nvme-target-control-v1-10-b31b40537bb4@suse.de>
References: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
In-Reply-To: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Rspamd-Queue-Id: F3FA21F787
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[readme.md:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,tmp.name:url,nvme_target_control.target:url];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.51

A storage array is a target NVME_TARGET_CONTROL is meant for, and it
doesn't do everything the Linux nvmet target does. Add the ontap target,
which configures a NetApp ONTAP storage virtual machine through the
ONTAP REST API.

On first use the target creates a volume with one namespace. Setup
creates an NVMe subsystem, allows the host and maps the namespace. The
ports are the NVMe/TCP LIFs of the SVM. The target implements
list-ports, show-port and set-host, the tests which need other commands
or TLS skip. README.md documents the configuration and the limits.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md                     |   3 +-
 contrib/nvme-target-control/README.md              |  48 +++
 .../nvme_target_control/target.py                  |   1 +
 .../nvme_target_control/targets/ontap.py           | 392 +++++++++++++++++++++
 contrib/nvme-target-control/tests/test_ontap.py    | 340 ++++++++++++++++++
 5 files changed, 783 insertions(+), 1 deletion(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 9ac55f2c6724..15c7672fade5 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -303,5 +303,6 @@ the tests which need a feature the list lacks.
   --dhgroup DHGROUP
 
 contrib/nvme-target-control implements this interface. It configures a Linux
-nvmet target over ssh and can be extended for other targets, see
+nvmet target over ssh or a NetApp ONTAP storage virtual machine through its
+REST API, and can be extended for other targets, see
 contrib/nvme-target-control/README.md.
diff --git a/contrib/nvme-target-control/README.md b/contrib/nvme-target-control/README.md
index dc421b00b788..5bd532cd7c2f 100644
--- a/contrib/nvme-target-control/README.md
+++ b/contrib/nvme-target-control/README.md
@@ -49,6 +49,7 @@ nothing, to run against a target which is configured already.
 | Type | Target |
 | --- | --- |
 | `nvmet` (default) | Linux nvmet target, configured through configfs |
+| `ontap` | NetApp ONTAP storage virtual machine, through the REST API |
 | `package.module:Class` | A `Target` subclass outside this package |
 
 ### nvmet
@@ -80,6 +81,53 @@ The target needs sshd, configfs, losetup and the nvmet modules for the
 transport. The ssh destination may be an alias from the ssh config, `traddr`
 is then its `HostName`.
 
+### ontap
+
+Configures a storage virtual machine (SVM) of a NetApp ONTAP cluster through
+the ONTAP REST API. blktests connects over NVMe/TCP to the LIFs of the SVM:
+
+    [target]
+    type = "ontap"
+    host = "192.0.2.100"
+    user = "admin"
+    password_file = "/root/.config/blktests/ontap-password"
+    svm = "svm1"
+    aggregate = "aggr1"
+
+The first time blktests asks for the subsystem UUID, the target creates the
+volume and the namespace `/vol/VOLUME/ns1` unless they exist. The volume
+gets no snapshots: the tests rewrite the namespace, snapshots would fill
+the volume. Setup creates the subsystem, allows the host and maps the
+namespace to it. Cleanup deletes the subsystem. The volume and namespace
+stay for the next run. The target caches the namespace UUID, the SVM UUID
+and the LIFs in `cache_dir`, and the DH-HMAC-CHAP secrets of the hosts,
+which ONTAP doesn't return.
+
+ONTAP derives the subsystem NQN from the subsystem name: `config
+--show-subsysnqn` shows the NQN of the subsystem `blktests`. The tests which
+use other NQNs need the NQN prefix of the SVM. The ports are the NVMe/TCP
+LIFs, numbered 1 to N by LIF name, each subsystem is reachable on all of
+them. The target implements `list-ports`, `show-port` and `set-host`.
+ONTAP can't modify the DH-HMAC-CHAP settings of a host: `set-host` removes
+the host and adds it again, which drops its connections. ONTAP manages the
+ANA states and doesn't support SHA-384. The target doesn't set up TLS.
+
+| Option | Meaning |
+| --- | --- |
+| `host` | cluster management address |
+| `user` | ONTAP user |
+| `password_file` | file with the password of `user` in its first line, mode 0600 |
+| `svm` | the SVM |
+| `aggregate` | aggregate for the volume, needed if it doesn't exist |
+| `volume` | volume of the namespace, default `blktests` |
+| `volume_size` | size of a new volume, default `4G` |
+| `ns_size` | size of a new namespace, default `2G` |
+| `verify_tls` | verify the certificate of `host`, default true |
+| `cache_dir` | default `~/.cache/nvme-target-control` |
+
+The user needs the rights to manage volumes, namespaces and NVMe
+subsystems of the SVM.
+
 ## Adding a target
 
 A target is a subclass of `nvme_target_control.target.Target`. It gets the
diff --git a/contrib/nvme-target-control/nvme_target_control/target.py b/contrib/nvme-target-control/nvme_target_control/target.py
index d648826e0386..8b2df2e6d6ac 100644
--- a/contrib/nvme-target-control/nvme_target_control/target.py
+++ b/contrib/nvme-target-control/nvme_target_control/target.py
@@ -210,6 +210,7 @@ OPTIONAL_COMMANDS = {
 
 TARGETS = {
     'nvmet': 'nvme_target_control.targets.nvmet:NvmetTarget',
+    'ontap': 'nvme_target_control.targets.ontap:OntapTarget',
 }
 
 
diff --git a/contrib/nvme-target-control/nvme_target_control/targets/ontap.py b/contrib/nvme-target-control/nvme_target_control/targets/ontap.py
new file mode 100644
index 000000000000..198303d1360e
--- /dev/null
+++ b/contrib/nvme-target-control/nvme_target_control/targets/ontap.py
@@ -0,0 +1,392 @@
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+"""NetApp ONTAP storage virtual machine (SVM), through the ONTAP REST API.
+
+blktests connects over NVMe/TCP to the LIFs of the SVM. [target] options:
+
+  host           cluster management address
+  user           ONTAP user
+  password_file  file with the password of user in the first line
+  svm            the SVM
+  aggregate      aggregate for the volume, needed if it doesn't exist
+  volume         volume of the namespace, default 'blktests'
+  volume_size    size of the volume if it is created, default 4G
+  ns_size        size of the namespace if it is created, default 2G
+  verify_tls     verify the certificate of host, default true
+  cache_dir      default ~/.cache/nvme-target-control
+
+The first time blktests asks for the subsystem UUID, the target creates the
+volume, without snapshots, and the namespace /vol/VOLUME/ns1 unless they
+exist, and caches the namespace UUID, the SVM UUID and the LIFs. Setup
+creates an NVMe subsystem, allows the host and maps the namespace to it.
+Cleanup deletes the subsystem. The volume and namespace stay.
+
+ONTAP derives the subsystem NQN from the subsystem name and the SVM.
+'config --show-subsysnqn' shows the NQN of the subsystem 'blktests'. Other
+NQNs only work with the NQN prefix of the SVM.
+
+The ports are the NVMe/TCP LIFs, numbered 1..N by LIF name. Every
+subsystem is reachable on all of them. Ports can't be added or removed and
+ONTAP manages the ANA states. ONTAP can't modify the DH-HMAC-CHAP settings
+of a host: set-host removes the host and adds it again, which drops its
+connections. The target doesn't set up TLS.
+"""
+
+import base64
+import json
+import ssl
+import time
+import urllib.error
+import urllib.parse
+import urllib.request
+from pathlib import Path
+from typing import Any
+
+from ..target import Port, Subsystem, Target
+
+NQN_PREFIX = 'nqn.1992-08.com.netapp:sn.{}:subsystem.'
+DEF_SUBSYSTEM = 'blktests'
+
+# The names blktests uses for the DH-HMAC-CHAP hash and DH group, and the
+# ones ONTAP uses. ONTAP doesn't support SHA-384.
+HASHES = {
+    'hmac(sha256)': 'sha_256',
+    'hmac(sha512)': 'sha_512',
+}
+DHGROUPS = {
+    'null': 'none',
+    'ffdhe2048': '2048_bit',
+    'ffdhe3072': '3072_bit',
+    'ffdhe4096': '4096_bit',
+    'ffdhe6144': '6144_bit',
+    'ffdhe8192': '8192_bit',
+}
+
+
+class OntapError(OSError):
+    """An ONTAP REST request failed, status is its HTTP status."""
+
+    def __init__(self, message: str, status: int = 0) -> None:
+        super().__init__(message)
+        self.status = status
+
+
+class OntapTarget(Target):
+    """NetApp ONTAP storage virtual machine with NVMe/TCP LIFs."""
+
+    def __init__(self, config: dict[str, Any]) -> None:
+        super().__init__(config)
+        self.svm = str(config['svm'])
+        self.volume = str(config.get('volume', 'blktests'))
+        self.ns_path = f'/vol/{self.volume}/ns1'
+        cache = Path(
+            config.get('cache_dir', '~/.cache/nvme-target-control')
+        ).expanduser()
+        self.cache_file = cache / f'ontap-{config["host"]}-{self.svm}.json'
+        # The DH-HMAC-CHAP settings of the hosts, by subsystem name: ONTAP
+        # doesn't return the secrets, set_host needs them.
+        self.hosts_file = self.cache_file.with_suffix('.hosts.json')
+
+    # REST
+
+    def _request(
+        self,
+        method: str,
+        path: str,
+        body: dict[str, Any] | None = None,
+        query: dict[str, str] | None = None,
+    ) -> dict[str, Any]:
+        url = f'https://{self.config["host"]}/api{path}'
+        if query:
+            url += '?' + urllib.parse.urlencode(query)
+        password = (
+            Path(self.config['password_file']).read_text().split('\n')[0]
+        )
+        auth = f'{self.config["user"]}:{password}'.encode()
+        req = urllib.request.Request(
+            url,
+            method=method,
+            data=json.dumps(body).encode() if body is not None else None,
+            headers={
+                'Authorization': 'Basic ' + base64.b64encode(auth).decode(),
+                'Accept': 'application/json',
+                'Content-Type': 'application/json',
+            },
+        )
+        ctx = (
+            None
+            if self.config.get('verify_tls', True)
+            else ssl._create_unverified_context()
+        )
+        try:
+            with urllib.request.urlopen(req, context=ctx, timeout=60) as r:
+                data = r.read()
+                status = r.status
+        except urllib.error.HTTPError as e:
+            with e:
+                text = e.read().decode(errors='replace')
+            raise OntapError(
+                f'{method} {path}: {e.code} {text}', e.code
+            ) from None
+        result: dict[str, Any] = json.loads(data) if data else {}
+        if status == 202 and 'job' in result:
+            self._wait_job(result['job']['uuid'])
+        return result
+
+    def _wait_job(self, uuid: str) -> None:
+        for _ in range(300):
+            job = self._request('GET', f'/cluster/jobs/{uuid}')
+            if job['state'] == 'success':
+                return
+            if job['state'] == 'failure':
+                raise OntapError(f'job {uuid}: {job.get("message")}')
+            time.sleep(1)
+        raise OntapError(f'job {uuid} did not finish')
+
+    def _records(
+        self, path: str, query: dict[str, str]
+    ) -> list[dict[str, Any]]:
+        records: list[dict[str, Any]] = self._request(
+            'GET', path, query={'svm.name': self.svm, **query}
+        ).get('records', [])
+        return records
+
+    # Values blktests asks for many times per test: cached
+
+    def _cache(self) -> dict[str, Any]:
+        try:
+            cache: dict[str, Any] = json.loads(self.cache_file.read_text())
+            return cache
+        except (OSError, ValueError):
+            pass
+        svm = self._request('GET', '/svm/svms', query={'name': self.svm})
+        lifs = self._records(
+            '/network/ip/interfaces',
+            {'services': 'data_nvme_tcp', 'fields': 'name,ip.address'},
+        )
+        cache = {
+            'svm_uuid': svm['records'][0]['uuid'],
+            'lifs': [
+                lif['ip']['address']
+                for lif in sorted(lifs, key=lambda lif: str(lif['name']))
+            ],
+            'ns_uuid': self._namespace_uuid(),
+        }
+        self.cache_file.parent.mkdir(parents=True, exist_ok=True)
+        self.cache_file.write_text(json.dumps(cache))
+        return cache
+
+    def _namespace_uuid(self) -> str:
+        """Return the UUID of the namespace, create it first if needed."""
+        ns = self._records(
+            '/storage/namespaces', {'name': self.ns_path, 'fields': 'uuid'}
+        )
+        if ns:
+            return str(ns[0]['uuid'])
+        if not self._records('/storage/volumes', {'name': self.volume}):
+            self._request(
+                'POST',
+                '/storage/volumes',
+                {
+                    'name': self.volume,
+                    'svm': {'name': self.svm},
+                    'aggregates': [{'name': self.config['aggregate']}],
+                    'size': self.config.get('volume_size', '4G'),
+                    # The tests rewrite the namespace: snapshots of it
+                    # would fill the volume and fail the writes
+                    'snapshot_policy': {'name': 'none'},
+                    'space': {'snapshot': {'reserve_percent': 0}},
+                },
+            )
+        self._request(
+            'POST',
+            '/storage/namespaces',
+            {
+                'svm': {'name': self.svm},
+                'name': self.ns_path,
+                'os_type': 'linux',
+                'space': {'size': self.config.get('ns_size', '2G')},
+            },
+        )
+        return self._namespace_uuid()
+
+    def traddr(self) -> str:
+        return str(self._cache()['lifs'][0])
+
+    def subsysnqn(self) -> str:
+        return self._nqn_prefix() + DEF_SUBSYSTEM
+
+    def subsys_uuid(self) -> str:
+        return str(self._cache()['ns_uuid'])
+
+    def _nqn_prefix(self) -> str:
+        return NQN_PREFIX.format(self._cache()['svm_uuid'].replace('-', ''))
+
+    def _name(self, subsysnqn: str) -> str:
+        """Return the subsystem name ONTAP derives subsysnqn from."""
+        prefix = self._nqn_prefix()
+        if not subsysnqn.startswith(prefix):
+            raise OntapError(
+                f'{subsysnqn}: ONTAP subsystem NQNs start with {prefix}'
+            )
+        return subsysnqn[len(prefix) :]
+
+    # Subsystems
+
+    def _subsystem(self, name: str) -> dict[str, Any] | None:
+        subsys = self._records('/protocols/nvme/subsystems', {'name': name})
+        return subsys[0] if subsys else None
+
+    def _delete_subsystem(self, uuid: str) -> None:
+        self._request(
+            'DELETE',
+            f'/protocols/nvme/subsystems/{uuid}',
+            query={
+                'allow_delete_while_mapped': 'true',
+                'allow_delete_with_hosts': 'true',
+            },
+        )
+
+    def setup(
+        self, subsys: Subsystem, nr_ports: int = 1, tls: str = 'none'
+    ) -> None:
+        if tls != 'none':
+            raise NotImplementedError('OntapTarget does not set up TLS')
+        name = self._name(subsys.nqn)
+        # A subsystem left by an aborted run would keep the namespace
+        stale = self._records(
+            '/protocols/nvme/subsystem-maps',
+            {
+                'namespace.name': self.ns_path,
+                'fields': 'subsystem.name,subsystem.uuid',
+            },
+        )
+        for m in stale:
+            if not m['subsystem']['name'].startswith(DEF_SUBSYSTEM):
+                raise OntapError(
+                    f'{self.ns_path} is mapped to {m["subsystem"]["name"]}'
+                )
+            self._delete_subsystem(m['subsystem']['uuid'])
+
+        chap = {}
+        if subsys.hostkey:
+            chap['host_secret_key'] = subsys.hostkey
+        if subsys.ctrlkey:
+            chap['controller_secret_key'] = subsys.ctrlkey
+        self._request(
+            'POST',
+            '/protocols/nvme/subsystems',
+            {
+                'svm': {'name': self.svm},
+                'name': name,
+                'os_type': 'linux',
+                'hosts': [self._host(subsys.hostnqn, chap)],
+            },
+        )
+        hosts = self._hosts()
+        hosts[name] = {subsys.hostnqn: chap}
+        self._save_hosts(hosts)
+        self._request(
+            'POST',
+            '/protocols/nvme/subsystem-maps',
+            {
+                'svm': {'name': self.svm},
+                'subsystem': {'name': name},
+                'namespace': {'name': self.ns_path},
+            },
+        )
+
+    def cleanup(self, subsysnqn: str) -> None:
+        name = self._name(subsysnqn)
+        subsys = self._subsystem(name)
+        if subsys:
+            self._delete_subsystem(subsys['uuid'])
+        hosts = self._hosts()
+        if hosts.pop(name, None) is not None:
+            self._save_hosts(hosts)
+
+    # Hosts
+
+    @staticmethod
+    def _host(hostnqn: str, chap: dict[str, str]) -> dict[str, Any]:
+        for field in ('host_secret_key', 'controller_secret_key'):
+            # DHHC-1:02: is a secret transformed with SHA-384
+            if chap.get(field, '').startswith('DHHC-1:02:'):
+                raise OntapError('ONTAP does not support SHA-384 secrets')
+        host: dict[str, Any] = {'nqn': hostnqn}
+        if chap:
+            host['dh_hmac_chap'] = chap
+        return host
+
+    def _hosts(self) -> dict[str, dict[str, dict[str, str]]]:
+        try:
+            hosts: dict[str, dict[str, dict[str, str]]] = json.loads(
+                self.hosts_file.read_text()
+            )
+            return hosts
+        except (OSError, ValueError):
+            return {}
+
+    def _save_hosts(self, hosts: dict[str, dict[str, dict[str, str]]]) -> None:
+        self.hosts_file.parent.mkdir(parents=True, exist_ok=True)
+        # The file holds secrets
+        self.hosts_file.touch(mode=0o600)
+        self.hosts_file.write_text(json.dumps(hosts))
+
+    def set_host(self, hostnqn: str, attrs: dict[str, str]) -> None:
+        """Change the DH-HMAC-CHAP settings of the host.
+
+        ONTAP can't modify them: remove the host from the subsystems setup
+        created and add it again. This drops the connections of the host
+        to these subsystems; the host reconnects.
+        """
+        fields = {
+            'hostkey': ('host_secret_key', None),
+            'ctrlkey': ('controller_secret_key', None),
+            'hash': ('hash_function', HASHES),
+            'dhgroup': ('group_size', DHGROUPS),
+        }
+        hosts = self._hosts()
+        for name, subsys_hosts in hosts.items():
+            if hostnqn not in subsys_hosts:
+                continue
+            # Change a copy: the host keeps its settings if one is invalid
+            chap = dict(subsys_hosts[hostnqn])
+            for attr, value in attrs.items():
+                field, names = fields[attr]
+                if not value:
+                    chap.pop(field, None)
+                elif names is None:
+                    chap[field] = value
+                elif value in names:
+                    chap[field] = names[value]
+                else:
+                    raise OntapError(f'ONTAP does not support {attr} {value}')
+            host = self._host(hostnqn, chap)
+            subsys_hosts[hostnqn] = chap
+            subsys = self._subsystem(name)
+            if not subsys:
+                continue
+            path = f'/protocols/nvme/subsystems/{subsys["uuid"]}/hosts'
+            quoted = urllib.parse.quote(hostnqn, safe='')
+            try:
+                self._request('DELETE', f'{path}/{quoted}')
+            except OntapError as e:
+                # Gone if an earlier set-host failed to add it again
+                if e.status != 404:
+                    raise
+            self._request('POST', path, host)
+        self._save_hosts(hosts)
+
+    # Ports: the LIFs
+
+    def list_ports(self, subsysnqn: str) -> list[str]:
+        if not self._subsystem(self._name(subsysnqn)):
+            return []
+        return [str(i) for i in range(1, len(self._cache()['lifs']) + 1)]
+
+    def show_port(self, port: str) -> Port:
+        lifs = self._cache()['lifs']
+        if not port.isdigit() or not 1 <= int(port) <= len(lifs):
+            raise OntapError(f'no port {port}')
+        return Port('tcp', lifs[int(port) - 1], self.value('trsvid'))
diff --git a/contrib/nvme-target-control/tests/test_ontap.py b/contrib/nvme-target-control/tests/test_ontap.py
new file mode 100644
index 000000000000..49f708a05fd1
--- /dev/null
+++ b/contrib/nvme-target-control/tests/test_ontap.py
@@ -0,0 +1,340 @@
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (c) 2026 SUSE LLC and contributors
+"""Tests for the ONTAP target, against a fake ONTAP REST API."""
+
+import base64
+import io
+import json
+import sys
+import tempfile
+import unittest
+import urllib.error
+import urllib.parse
+import urllib.request
+import uuid
+from pathlib import Path
+from typing import Any
+from unittest import mock
+
+sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
+
+from nvme_target_control import target
+from nvme_target_control.target import Subsystem
+from nvme_target_control.targets import ontap
+
+SVM_UUID = 'd714f2f5-ab77-11ed-af12-00a0988fb732'
+PREFIX = 'nqn.1992-08.com.netapp:sn.d714f2f5ab7711edaf1200a0988fb732'
+NQN = PREFIX + ':subsystem.blktests'
+HOSTNQN = 'nqn.2014-08.org.nvmexpress:uuid:57c34e91'
+KEY = 'DHHC-1:01:aGVsbG8gd29ybGQgaGVsbG8gd29ybGQgaGVsbG8hISEhTr8=:'
+KEY2 = 'DHHC-1:00:YW5vdGhlciBrZXkgYW5vdGhlciBrZXkgYW5vdGhlciEhIUV8=:'
+
+
+class Response(io.BytesIO):
+    def __init__(self, status: int, body: dict[str, Any] | None) -> None:
+        super().__init__(
+            json.dumps(body).encode() if body is not None else b''
+        )
+        self.status = status
+
+
+def records(r: list[dict[str, Any]]) -> tuple[int, dict[str, Any]]:
+    """A collection GET reply."""
+    return 200, {'records': r, 'num_records': len(r)}
+
+
+class FakeOntap:
+    """The REST resources the ONTAP target uses, in memory."""
+
+    def __init__(self) -> None:
+        self.requests: list[tuple[str, str, dict[str, Any] | None]] = []
+        self.auth: list[str] = []
+        self.contexts: list[Any] = []
+        self.lifs = [
+            {'name': 'lif-b', 'ip': {'address': '192.0.2.2'}},
+            {'name': 'lif-a', 'ip': {'address': '192.0.2.1'}},
+        ]
+        self.volumes: dict[str, dict[str, Any]] = {}
+        self.namespaces: dict[str, str] = {}
+        self.subsystems: dict[str, dict[str, Any]] = {}
+        self.maps: dict[str, str] = {}  # namespace name -> subsystem name
+        self.job_state = 'success'
+
+    def urlopen(
+        self,
+        req: urllib.request.Request,
+        context: Any = None,
+        timeout: int = 0,
+    ) -> Response:
+        url = urllib.parse.urlsplit(req.full_url)
+        query = dict(urllib.parse.parse_qsl(url.query))
+        body = json.loads(req.data) if req.data else None  # type: ignore[arg-type]
+        method = req.get_method()
+        path = urllib.parse.unquote(url.path.removeprefix('/api'))
+        self.requests.append((method, path, body))
+        self.auth.append(req.get_header('Authorization') or '')
+        self.contexts.append(context)
+        status, result = self.handle(method, path, query, body)
+        if status >= 400:
+            raise urllib.error.HTTPError(
+                req.full_url,
+                status,
+                'error',
+                {},  # type: ignore[arg-type]
+                io.BytesIO(json.dumps(result).encode()),
+            )
+        return Response(status, result)
+
+    def handle(
+        self,
+        method: str,
+        path: str,
+        query: dict[str, str],
+        body: dict[str, Any] | None,
+    ) -> tuple[int, dict[str, Any] | None]:
+        if (method, path) == ('GET', '/svm/svms'):
+            return records([{'uuid': SVM_UUID, 'name': query['name']}])
+        if (method, path) == ('GET', '/network/ip/interfaces'):
+            return records(self.lifs)
+        if path == '/storage/volumes':
+            if method == 'POST':
+                assert body is not None
+                self.volumes[body['name']] = body
+                return 202, {'job': {'uuid': 'job-1'}}
+            vols = [{'name': query['name']}] * (query['name'] in self.volumes)
+            return records(vols)
+        if path.startswith('/cluster/jobs/'):
+            return 200, {'state': self.job_state, 'message': 'no space'}
+        if path == '/storage/namespaces':
+            if method == 'POST':
+                assert body is not None
+                self.namespaces[body['name']] = str(uuid.uuid4())
+                return 201, None
+            name = query['name']
+            if name not in self.namespaces:
+                return records([])
+            return records([{'uuid': self.namespaces[name]}])
+        if path == '/protocols/nvme/subsystem-maps':
+            if method == 'POST':
+                assert body is not None
+                self.maps[body['namespace']['name']] = body['subsystem'][
+                    'name'
+                ]
+                return 201, None
+            subsys = self.maps.get(query['namespace.name'])
+            if subsys is None:
+                return records([])
+            uid = self.subsystems[subsys]['uuid']
+            return records([{'subsystem': {'name': subsys, 'uuid': uid}}])
+        if path == '/protocols/nvme/subsystems':
+            if method == 'POST':
+                assert body is not None
+                self.subsystems[body['name']] = {
+                    'uuid': str(uuid.uuid4()),
+                    'hosts': {h['nqn']: h for h in body['hosts']},
+                }
+                return 201, None
+            name = query['name']
+            if name not in self.subsystems:
+                return records([])
+            return records([{'name': name, **self.subsystems[name]}])
+        parts = path.split('/')
+        found = [
+            n for n, s in self.subsystems.items() if s['uuid'] == parts[4]
+        ]
+        if not found:
+            return 404, {'error': {'message': 'no subsystem'}}
+        subsys = found[0]
+        hosts = self.subsystems[subsys]['hosts']
+        if method == 'DELETE' and len(parts) == 5:
+            del self.subsystems[subsys]
+            self.maps = {k: v for k, v in self.maps.items() if v != subsys}
+            return 200, None
+        if method == 'DELETE':
+            if parts[6] not in hosts:
+                return 404, {'error': {'message': 'no host'}}
+            del hosts[parts[6]]
+            return 200, None
+        assert body is not None
+        hosts[body['nqn']] = body
+        return 201, None
+
+
+class OntapTestCase(unittest.TestCase):
+    def setUp(self) -> None:
+        tmp = tempfile.TemporaryDirectory()
+        self.addCleanup(tmp.cleanup)
+        self.tmp = Path(tmp.name)
+        (self.tmp / 'password').write_text('secret\n')
+        self.fake = FakeOntap()
+        patch = mock.patch.object(urllib.request, 'urlopen', self.fake.urlopen)
+        patch.start()
+        self.addCleanup(patch.stop)
+
+    def target(self, **config: Any) -> ontap.OntapTarget:
+        cfg = {
+            'type': 'ontap',
+            'host': '192.0.2.100',
+            'user': 'admin',
+            'password_file': str(self.tmp / 'password'),
+            'svm': 'svm1',
+            'aggregate': 'aggr1',
+            'cache_dir': str(self.tmp / 'cache'),
+            **config,
+        }
+        tgt = target.create(cfg)
+        assert isinstance(tgt, ontap.OntapTarget)
+        return tgt
+
+    def subsys(self, **keys: str) -> Subsystem:
+        tgt = self.target()
+        return Subsystem(NQN, tgt.value('subsys_uuid'), HOSTNQN, **keys)
+
+
+class TestOntapConfig(OntapTestCase):
+    def test_values(self) -> None:
+        tgt = self.target()
+        self.assertEqual(tgt.value('traddr'), '192.0.2.1')
+        self.assertEqual(tgt.value('trsvid'), '4420')
+        self.assertEqual(tgt.value('subsysnqn'), NQN)
+        self.assertEqual(
+            tgt.value('subsys_uuid'), self.fake.namespaces['/vol/blktests/ns1']
+        )
+        self.assertEqual(
+            tgt.features(), ['list-ports', 'show-port', 'set-host']
+        )
+
+    def test_creates_volume_without_snapshots(self) -> None:
+        self.target(volume='bt', ns_size='1G').value('subsys_uuid')
+        vol = self.fake.volumes['bt']
+        self.assertEqual(vol['aggregates'], [{'name': 'aggr1'}])
+        self.assertEqual(vol['snapshot_policy'], {'name': 'none'})
+        self.assertEqual(vol['space'], {'snapshot': {'reserve_percent': 0}})
+        self.assertIn('/vol/bt/ns1', self.fake.namespaces)
+
+    def test_cached(self) -> None:
+        self.target().value('subsys_uuid')
+        nr = len(self.fake.requests)
+        tgt = self.target()
+        for name in ['traddr', 'subsysnqn', 'subsys_uuid']:
+            tgt.value(name)
+        self.assertEqual(len(self.fake.requests), nr)
+
+    def test_request(self) -> None:
+        self.target(verify_tls=False).value('traddr')
+        auth = base64.b64encode(b'admin:secret').decode()
+        self.assertEqual(set(self.fake.auth), {'Basic ' + auth})
+        self.assertTrue(all(c is not None for c in self.fake.contexts))
+        self.fake.contexts.clear()
+        self.target(cache_dir=str(self.tmp / 'c2')).value('traddr')
+        self.assertTrue(all(c is None for c in self.fake.contexts))
+
+    def test_job_failure(self) -> None:
+        self.fake.job_state = 'failure'
+        with self.assertRaisesRegex(ontap.OntapError, 'no space'):
+            self.target().value('subsys_uuid')
+
+
+class TestOntapSubsystems(OntapTestCase):
+    def test_setup_cleanup(self) -> None:
+        tgt = self.target()
+        tgt.setup(self.subsys(hostkey=KEY, ctrlkey=KEY2), 4)
+        subsys = self.fake.subsystems['blktests']
+        self.assertEqual(
+            subsys['hosts'][HOSTNQN]['dh_hmac_chap'],
+            {'host_secret_key': KEY, 'controller_secret_key': KEY2},
+        )
+        self.assertEqual(self.fake.maps, {'/vol/blktests/ns1': 'blktests'})
+        self.assertEqual(tgt.list_ports(NQN), ['1', '2'])
+        self.assertEqual(
+            tgt.show_port('2'), target.Port('tcp', '192.0.2.2', '4420')
+        )
+        self.assertEqual(tgt.hosts_file.stat().st_mode & 0o777, 0o600)
+
+        tgt.cleanup(NQN)
+        self.assertEqual((self.fake.subsystems, self.fake.maps), ({}, {}))
+        self.assertEqual(tgt.list_ports(NQN), [])
+        self.assertEqual(json.loads(tgt.hosts_file.read_text()), {})
+
+    def test_stale_subsystem(self) -> None:
+        tgt = self.target()
+        tgt.setup(self.subsys())
+        tgt.setup(self.subsys())
+        self.assertEqual(list(self.fake.subsystems), ['blktests'])
+        self.fake.maps['/vol/blktests/ns1'] = 'other'
+        self.fake.subsystems['other'] = {'uuid': 'u', 'hosts': {}}
+        with self.assertRaisesRegex(ontap.OntapError, 'mapped to other'):
+            tgt.setup(self.subsys())
+
+    def test_unsupported(self) -> None:
+        tgt = self.target()
+        with self.assertRaisesRegex(ontap.OntapError, 'start with'):
+            tgt.setup(Subsystem('nqn.foo', 'u', HOSTNQN))
+        with self.assertRaises(NotImplementedError):
+            tgt.setup(self.subsys(), tls='required')
+        with self.assertRaisesRegex(ontap.OntapError, 'no port 3'):
+            tgt.show_port('3')
+        with self.assertRaises(NotImplementedError):
+            tgt.set_ana('1', 1, 'optimized')
+
+
+class TestOntapSetHost(OntapTestCase):
+    def chap(self) -> dict[str, str]:
+        hosts = self.fake.subsystems['blktests']['hosts']
+        chap: dict[str, str] = hosts[HOSTNQN]['dh_hmac_chap']
+        return chap
+
+    def test_set_host(self) -> None:
+        tgt = self.target()
+        tgt.setup(self.subsys(hostkey=KEY))
+        tgt.set_host(HOSTNQN, {'hash': 'hmac(sha512)', 'dhgroup': 'ffdhe8192'})
+        self.assertEqual(
+            self.chap(),
+            {
+                'host_secret_key': KEY,
+                'hash_function': 'sha_512',
+                'group_size': '8192_bit',
+            },
+        )
+        # A new target, as for the next command, knows the secrets
+        self.target().set_host(HOSTNQN, {'hostkey': KEY2, 'ctrlkey': KEY})
+        self.assertEqual(self.chap()['host_secret_key'], KEY2)
+        self.assertEqual(self.chap()['controller_secret_key'], KEY)
+        deletes = [r for r in self.fake.requests if r[0] == 'DELETE']
+        self.assertEqual(len(deletes), 2)
+
+    def test_unsupported_hash(self) -> None:
+        tgt = self.target()
+        tgt.setup(self.subsys(hostkey=KEY))
+        with self.assertRaisesRegex(ontap.OntapError, 'hmac.sha384'):
+            tgt.set_host(HOSTNQN, {'hash': 'hmac(sha384)'})
+
+    def test_sha384_secret(self) -> None:
+        tgt = self.target()
+        with self.assertRaisesRegex(ontap.OntapError, 'SHA-384 secrets'):
+            tgt.setup(self.subsys(hostkey='DHHC-1:02:abc:'))
+        tgt.setup(self.subsys(hostkey=KEY))
+        with self.assertRaisesRegex(ontap.OntapError, 'SHA-384 secrets'):
+            tgt.set_host(HOSTNQN, {'ctrlkey': 'DHHC-1:02:abc:'})
+        # The host is still allowed with the old key
+        self.assertEqual(self.chap(), {'host_secret_key': KEY})
+
+    def test_host_already_removed(self) -> None:
+        tgt = self.target()
+        tgt.setup(self.subsys(hostkey=KEY))
+        del self.fake.subsystems['blktests']['hosts'][HOSTNQN]
+        tgt.set_host(HOSTNQN, {'hostkey': KEY2})
+        self.assertEqual(self.chap(), {'host_secret_key': KEY2})
+
+    def test_http_error(self) -> None:
+        tgt = self.target()
+        tgt.setup(self.subsys())
+        self.fake.subsystems['blktests']['uuid'] = 'gone'
+        self.fake.subsystems['x'] = {'uuid': 'other', 'hosts': {}}
+        with self.assertRaises(ontap.OntapError) as e:
+            tgt._delete_subsystem('missing')
+        self.assertEqual(e.exception.status, 404)
+
+
+if __name__ == '__main__':
+    unittest.main()

-- 
2.56.0

