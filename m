Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C69171B0
	for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718625666; cv=none; b=QTCNBTlCV46E0On9rk07/0wV3/mXnusINjvv6dKRK2+9MQa0KncaWCofl0DVzeUyUybJPKScQq8XuvSpMEi6MeCkeI+4jo4c3v32/bP1Q1F3hICyUM0oY1QXjSueKURIY8ND35n7JEoFTyANeRPbBlSfmCQcQ4gYIuc8sq4tyvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718625666; c=relaxed/simple;
	bh=LqmUPKAGwsiMlF6o8YqN7A9CuPqa7AJnVWySOnOQmCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I58IwDIXaWMT6wimRqAvC4pTFPl+ZlueIhGDEe6Qq+fuUjx0lmIRQ22v+EcPfOeK5xYaoFFM5c/uciL8+K0wQdIKZsUQGdPC9opcbb4lkjrQFgYQ0qJmb1ikG1978r8AbV5oXBb4YaUyKP7PLnQ/eS6//HrP7VPSadYeJ1GIPgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SR6XwOSL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y+0Gg+WF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SR6XwOSL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y+0Gg+WF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SR6XwOSL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y+0Gg+WF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SR6XwOSL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y+0Gg+WF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AB44638134;
	Mon, 17 Jun 2024 12:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718625656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BmApUNZ35RCYIspe4sZrbLWqEHhX78sLaKAL3Fo75Mo=;
	b=SR6XwOSLimwJR/d3I++llPXyRKHezRAc9Or9NU5ehAnLqL3KHt30JIBAYOGqXF8lrI0g/R
	NC4MypQT126ig9ArBvCeUAZM1c1tGoMtuUwkKlPH1khzTy6T1pgaoiLR5K7RIzCpt7yetc
	2gBNCbcvkzJjRW0GnsQxWwm6AF39o7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718625656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BmApUNZ35RCYIspe4sZrbLWqEHhX78sLaKAL3Fo75Mo=;
	b=Y+0Gg+WFMRKwBfeXWVOcFnhvwcrutCTPcB8+zgVGivvvsCBWcWMGL66Fqf9eecJYFVglWJ
	Mjs43G9JS4g8NsBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SR6XwOSL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Y+0Gg+WF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718625656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BmApUNZ35RCYIspe4sZrbLWqEHhX78sLaKAL3Fo75Mo=;
	b=SR6XwOSLimwJR/d3I++llPXyRKHezRAc9Or9NU5ehAnLqL3KHt30JIBAYOGqXF8lrI0g/R
	NC4MypQT126ig9ArBvCeUAZM1c1tGoMtuUwkKlPH1khzTy6T1pgaoiLR5K7RIzCpt7yetc
	2gBNCbcvkzJjRW0GnsQxWwm6AF39o7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718625656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BmApUNZ35RCYIspe4sZrbLWqEHhX78sLaKAL3Fo75Mo=;
	b=Y+0Gg+WFMRKwBfeXWVOcFnhvwcrutCTPcB8+zgVGivvvsCBWcWMGL66Fqf9eecJYFVglWJ
	Mjs43G9JS4g8NsBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98342139AB;
	Mon, 17 Jun 2024 12:00:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lLj7I3glcGZdJwAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Mon, 17 Jun 2024 12:00:56 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Cyril Hrubis <chrubis@suse.cz>
Subject: [PATCH v2] loop: Add regression test for unsupported backing file fallocate
Date: Mon, 17 Jun 2024 14:00:18 +0200
Message-ID: <20240617120018.13832-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AB44638134
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---

v2:
  - make use of grep -c instead of wc -l
  - Add WRITE_ZEROES string to the grep regexp

 tests/loop/011     | 37 +++++++++++++++++++++++++++++++++++++
 tests/loop/011.out |  3 +++
 2 files changed, 40 insertions(+)
 create mode 100755 tests/loop/011
 create mode 100644 tests/loop/011.out

diff --git a/tests/loop/011 b/tests/loop/011
new file mode 100755
index 0000000..baabe5c
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
+	errors=$(_dmesg_since_test_start |grep -c "operation not supported error, dev .*WRITE_ZEROES")
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

