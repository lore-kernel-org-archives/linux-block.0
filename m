Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B869112D757
	for <linux-block@vger.kernel.org>; Thu, 13 Jun 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296838; cv=none; b=UHjforH0XFE0lgC+jZV6ch1uwkZASYVz+LXmvN4Y9sy4xNQQXQjGhu7DXXJ/dSiK2nb/POKg8dal7xsQciGr8TjvaI2Cf7R79f/yUCZqPAQva7Q1yC3Gmj//IJXKT89ADYcPol7HBYvtBvXFDpnijUR50eUJkNpYAdY3P59AI28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296838; c=relaxed/simple;
	bh=oiRNwrOeX1J7zxk4Vb9PHPRoX4IWegI9xj73trv8KvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ujltCavuwPmYi3I0JNgpN2CWSrelW96cyfusn8y2o4fKCQvaNNtcDSMe8vR5TMdaXrmkpxKebye33zbwbn5lBcqBqg+cYBfT+y6jocTTaVFBqZQCwmj8fR9awYywtnTmD+xxd/lWnMFpdFjgAJITAuMlZArLaJv6dfy4zlSJp4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 96F3C22410;
	Thu, 13 Jun 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85FB413A7F;
	Thu, 13 Jun 2024 16:40:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jbKHHwEha2aqdwAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Thu, 13 Jun 2024 16:40:33 +0000
From: Cyril Hrubis <metan@ucw.cz>
To: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Cyril Hrubis <chrubis@suse.cz>
Subject: [PATCH] loop: Add regression test for unsupported backing file fallocate
Date: Thu, 13 Jun 2024 18:40:07 +0200
Message-ID: <20240613164007.22721-1-metan@ucw.cz>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.39 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	R_MISSING_CHARSET(0.50)[];
	FORGED_SENDER(0.30)[metan@ucw.cz,chrubis@suse.cz];
	NEURAL_HAM_SHORT(-0.18)[-0.901];
	MIME_GOOD(-0.10)[text/plain];
	FROM_NEQ_ENVFROM(0.10)[metan@ucw.cz,chrubis@suse.cz];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 96F3C22410
X-Spam-Flag: NO
X-Spam-Score: -2.39
X-Spam-Level: 

From: Cyril Hrubis <chrubis@suse.cz>

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 tests/loop/011     | 37 +++++++++++++++++++++++++++++++++++++
 tests/loop/011.out |  3 +++
 2 files changed, 40 insertions(+)
 create mode 100755 tests/loop/011
 create mode 100644 tests/loop/011.out

diff --git a/tests/loop/011 b/tests/loop/011
new file mode 100755
index 0000000..6a3dac7
--- /dev/null
+++ b/tests/loop/011
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Cyril Hrubis
+#
+# Regression test for patch "loop: Disable fallocate() zero and discard if not supported".
+#
+
+. tests/loop/rc
+DESCRIPTION="Make sure unsupported backing file fallocate does not fill dmesg with errors"
+
+requires() {
+	_have_program mkfs.ext2
+}
+
+test() {
+	local loop_dev;
+	echo "Running ${TEST_NAME}"
+
+	mkdir "$TMPDIR/tmpfs"
+	mount -t tmpfs testfs "$TMPDIR/tmpfs"
+	dd if=/dev/zero of="$TMPDIR/tmpfs/disk.img" bs=1M count=100 &> /dev/null
+
+	if ! loop_dev="$(losetup -f --show "$TMPDIR/tmpfs/disk.img")"; then
+		return 1
+	fi
+
+	mkfs.ext2 /dev/loop0 &> /dev/null
+
+	errors=$(_dmesg_since_test_start |grep "operation not supported error, dev" |wc -l)
+
+	losetup -d "$loop_dev"
+	umount "$TMPDIR/tmpfs"
+
+	echo "Found $errors error(s) in dmesg"
+
+	echo "Test complete"
+}
diff --git a/tests/loop/011.out b/tests/loop/011.out
new file mode 100644
index 0000000..cd88fd5
--- /dev/null
+++ b/tests/loop/011.out
@@ -0,0 +1,3 @@
+Running loop/011
+Found 1 error(s) in dmesg
+Test complete
-- 
2.44.2

