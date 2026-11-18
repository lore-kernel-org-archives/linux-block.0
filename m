Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994014;
	b=l3++OhCw24uA593CP6l5cLyDnMu43TDgLSoRbZ3glsmEV6GCjGAgMb4ms+y/zn++hXOV
	 uc2uAlPDSmoFNX6MXw3kAb7iZ2wyzHtKQFZdmR7TKKFP5z3veeeJB1M+GnqZ2jO9oxQiF
	 GalQvI7YYnNMcguF0GUx07lF9+7PSa/4aARFGY6FMi4cKEoKkKabMFJUbd/zY+peciuLo
	 ZmWW2RefPSKu/rphiyYkUUJhzK0FHK7qeGTMpzp1ASvga8ovAouEEqUhu1no3RBDC9fBT
	 KTNh80/4k2POuGQK4mv0dKHfgWrDNhqMzmfxfgHS7KolSsu9ZUEjPXACert9WtAEfWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994014;
	h=DMARC-Filter:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Rspamd-Pre-Result:
	 X-Rspamd-Queue-Id:X-Rspamd-Pre-Result:X-Rspamd-Action:X-Rspamd-Server:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Flag:X-Spam-Score;
	bh=Z5bRc8opH3HG5rKZ//0Jdc3vZAolZILBYEaXnuHruvE=;
	b=jcLyyf2g2sshULbMBlqhEcNijZquGvxqs4xQjt+pCqBTSetXCDkqCiS/ujrW5zyzvguc
	 SIB410mOyiyIXZe+1CRpR26a8d610l88JzQ75Of292eCe19W3W0EVSXlXrNrtsO59dB3o
	 ghld7P7Cj/BlFp5aH4Km9fZFTkIb6af6hxdFhZ3LB+tvtLsuotdeODtLg/ru8vrD+azIP
	 bRWXy/pIsNJ12aH80h7u1tCmLUTtBTtubPaASHxBArJg5bwFhxHA9JPz1O6+xuX0Eklq9
	 zrx3B1sLmEK5J5P6KDubJDXvmFBUHIIA4q349OjuYBd1Up5Y9JFZScOncNst1LWX3Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC3606A330
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 09:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82EC3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2C2B22229;
	Wed, 18 Nov 2026 09:26:51 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA3821334C;
	Wed, 18 Nov 2026 09:26:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pe95IFtv/WpHfgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 09:26:51 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 10:26:43 +0100
Subject: [PATCH blktests v2 5/9] contrib/nvme-target-control: list the
 DH-HMAC-CHAP algorithms
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
Message-Id: <20261118-nvme-target-control-v2-5-d191bbbf5dd6@suse.de>
References: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
In-Reply-To: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: F2C2B22229
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

Not all targets support all DH-HMAC-CHAP hashes and DH groups, e.g.
ONTAP doesn't support SHA-384. List the ones a target supports as
features, e.g. dhchap-sha384 or dhchap-ffdhe2048, so that the tests can
check for them. The nvmet target lists all of them.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 contrib/nvme-target-control/README.md                  | 11 +++++++----
 .../nvme-target-control/nvme_target_control/target.py  | 18 ++++++++++++++++++
 .../nvme_target_control/targets/nvmet.py               | 12 +++++++++++-
 .../nvme-target-control/tests/test_target_control.py   |  4 +++-
 4 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/contrib/nvme-target-control/README.md b/contrib/nvme-target-control/README.md
index 9abd7f30932d..8afbfc0be322 100644
--- a/contrib/nvme-target-control/README.md
+++ b/contrib/nvme-target-control/README.md
@@ -118,10 +118,13 @@ channel is a subclass of `Channel` which returns the command running
 The port commands and `set-host` are optional. A target implements them
 by overriding `add_ports`, `add_port`, `remove_port`, `list_ports`,
 `show_port`, `set_ana` and `set_host`. `config --show-features` lists the
-ones it overrides, followed by the class attribute `extra_features`, e.g.
-`tls`. blktests skips the tests which need a feature the target doesn't
-list. Without `list-ports` and `show-port`, blktests connects to `traddr`
-and `trsvid`.
+ones it overrides, followed by the class attribute `extra_features`: the
+DH-HMAC-CHAP hashes and DH groups the target supports, e.g.
+`dhchap-sha256` or `dhchap-ffdhe2048` (`dhchap_features()` builds them),
+and `tls` if it sets up TLS. blktests skips the tests which need a
+feature the target doesn't list, and the steps of nvme/042 and nvme/043
+which use an algorithm the target doesn't list. Without `list-ports` and
+`show-port`, blktests connects to `traddr` and `trsvid`.
 
 ## Development
 
diff --git a/contrib/nvme-target-control/nvme_target_control/target.py b/contrib/nvme-target-control/nvme_target_control/target.py
index d648826e0386..1b3576bffbbf 100644
--- a/contrib/nvme-target-control/nvme_target_control/target.py
+++ b/contrib/nvme-target-control/nvme_target_control/target.py
@@ -11,6 +11,7 @@ API, can be added as 'package.module:Class' in the [target] 'type' option.
 
 import socket
 from abc import ABC, abstractmethod
+from collections.abc import Iterable
 from dataclasses import dataclass
 from pathlib import Path
 from typing import Any, ClassVar
@@ -23,6 +24,23 @@ DEF_SUBSYSNQN = 'blktests-subsystem-1'
 DEF_SUBSYS_UUID = '91fdba0d-f87b-4c25-b80f-db7be1418b9e'
 DEF_TRSVCID = '4420'
 
+# The DH-HMAC-CHAP hashes and DH groups, named as in the nvmet configfs
+# without hmac() around the hash
+DHCHAP_HASHES = ('sha256', 'sha384', 'sha512')
+DHCHAP_DHGROUPS = (
+    'null',
+    'ffdhe2048',
+    'ffdhe3072',
+    'ffdhe4096',
+    'ffdhe6144',
+    'ffdhe8192',
+)
+
+
+def dhchap_features(algorithms: Iterable[str]) -> tuple[str, ...]:
+    """Return the features for the DH-HMAC-CHAP hashes and DH groups."""
+    return tuple(f'dhchap-{alg}' for alg in algorithms)
+
 
 @dataclass(frozen=True)
 class Subsystem:
diff --git a/contrib/nvme-target-control/nvme_target_control/targets/nvmet.py b/contrib/nvme-target-control/nvme_target_control/targets/nvmet.py
index f5f2e8cc2a62..468417f2ca7e 100644
--- a/contrib/nvme-target-control/nvme_target_control/targets/nvmet.py
+++ b/contrib/nvme-target-control/nvme_target_control/targets/nvmet.py
@@ -24,7 +24,15 @@ from pathlib import Path
 from typing import Any
 
 from .. import channel
-from ..target import Port, Subsystem, Target, resolve
+from ..target import (
+    DHCHAP_DHGROUPS,
+    DHCHAP_HASHES,
+    Port,
+    Subsystem,
+    Target,
+    dhchap_features,
+    resolve,
+)
 
 SCRIPT = Path(__file__).resolve().parent / 'nvmet.sh'
 
@@ -40,6 +48,8 @@ HOST_ATTRS = {
 class NvmetTarget(Target):
     """Linux nvmet target."""
 
+    extra_features = dhchap_features(DHCHAP_HASHES + DHCHAP_DHGROUPS)
+
     def __init__(self, config: dict[str, Any]) -> None:
         super().__init__(config)
         self.channel = channel.create(config)
diff --git a/contrib/nvme-target-control/tests/test_target_control.py b/contrib/nvme-target-control/tests/test_target_control.py
index 730d6c8a9b69..c6d8933b6212 100644
--- a/contrib/nvme-target-control/tests/test_target_control.py
+++ b/contrib/nvme-target-control/tests/test_target_control.py
@@ -160,7 +160,9 @@ type = "fake_array:RecordingTarget"
         self.assertEqual(
             self.show('features'),
             'add-ports add-port remove-port list-ports show-port set-ana '
-            'set-host',
+            'set-host dhchap-sha256 dhchap-sha384 dhchap-sha512 dhchap-null '
+            'dhchap-ffdhe2048 dhchap-ffdhe3072 dhchap-ffdhe4096 '
+            'dhchap-ffdhe6144 dhchap-ffdhe8192',
         )
         self.config.write_text(PLUGIN)
         self.assertEqual(self.show('features'), '')

-- 
2.56.1

