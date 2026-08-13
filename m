Received: from mta1.migadu.com (out-216.mta1.migadu.com [95.215.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835F6480DE0
	for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632065; cv=none; b=RFTl0NVmes5QRgueGBsAT4lOFPfZc8pr07jjuR7sNXa8FtqlvJXRNFLHcGEPoXXfq1syh09dhjV95wAGpWVNrPiXPy2l+Eu4SK3geIexb+fuPn7Qo80UuwFDhOnA9+Y5XHTKPT+YZlCLUmGYVYXY88Fk/6pBbkv/z1slOIXsoOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632065; c=relaxed/simple;
	bh=DJIPumNwszO12ziGPknv5wNE8CM0NkVTDYB78EnjgvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HTjjJn9c+N101BE2T1nVTYwa6Kd5FQuZK0/9XSElDR1pvL/ujf23MoL50vTRFAgZFlTz2f68x7MMSBOkSaE/1mWo1CahRY5QUduvV6/KYtNqG45e2U0mQ+F55Bx8ScPEMATSboturbwrdoDkbZtTGhWgSI1ikQb3sNEYo+jb01g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Syk2/DWn; arc=none smtp.client-ip=95.215.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Syk2/DWn"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DJIPumNwszO12ziGPknv5wNE8CM0NkVTDYB78EnjgvU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786632058; v=1; x=1787236858;
 b=Syk2/DWnCnpWS/E1HkafD9610Ny2T2VvtT2iCg3HD7kf3wIPW1zNukb6gO+ZfDo2ha8lPD33
 H/xFBvEhRrMAkdnEvAQvKlwa6Az9Dh6aubOjzxwORxki/hvlSmqwm+BrRoDP0jGkhCz/rAZqwdZ
 DOhu96AO6bv4pbV8JFdpy1CY=
X-Envelope-To: linux-block@vger.kernel.org
Received: from ctao-book.. (111.162.215.50)
	by smtp.migadu.com with ESMTPS id 2968fc17ef0d4a5f;
	Thu, 13 Aug 2026 14:40:58 +0000
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: linux-block@vger.kernel.org,
	shinichiro.kawasaki@wdc.com
Cc: hch@lst.de,
	yukuai@kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH blktests] tests/throtl: add a new test 009
Date: Thu, 13 Aug 2026 22:40:41 +0800
Message-ID: <20260813144041.1715866-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

Test the boundary condition of removing a cgroup while it still has IO
queued in the blk-throttle queue.  The queued bios must be flushed through
without any blk-cgroup or blk-throttle warning.

The dmesg check matches any blk-cgroup / blk-throttle warning rather than a
single call site, so it is not tied to one symbol.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
See also the related blkcg "store blkcg in bio" RFC:
https://lore.kernel.org/r/20260804065313.2092022-1-yukuai@kernel.org

 tests/throtl/009     | 67 ++++++++++++++++++++++++++++++++++++++++++++
 tests/throtl/009.out |  2 ++
 2 files changed, 69 insertions(+)
 create mode 100755 tests/throtl/009
 create mode 100644 tests/throtl/009.out

diff --git a/tests/throtl/009 b/tests/throtl/009
new file mode 100755
index 0000000..1f4ed67
--- /dev/null
+++ b/tests/throtl/009
@@ -0,0 +1,67 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Tao Cui <cuitao@kylinos.cn>
+#
+# Regression test for removing a cgroup while IO is still queued in the
+# blk-throttle queue.  The queued bios must be flushed without any
+# blk-cgroup or blk-throttle warning, and without leaking the blkg
+# reference they pin.
+
+. tests/throtl/rc
+
+THROTL_BLKDEV_TYPES="nullb"
+
+DESCRIPTION="queued throttled IO vs. cgroup removal must not warn"
+QUICK=1
+
+set_conditions() {
+	_set_throtl_blkdev_type "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	if ! _set_up_throtl; then
+		return 1
+	fi
+
+	# Throttle reads so the bio queues in the throttle queue.
+	_throtl_set_limits rbps=4096
+
+	(
+		echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
+		exec dd if=/dev/"$THROTL_DEV" of=/dev/null bs=1M count=1 status=none
+	) &
+	local io_pid=$!
+	sleep 2
+
+	# Move the reader to the cgroup2 root so the throttle cgroup can be
+	# removed while its bio is still queued.  $CGROUP2_DIR has +io in its
+	# subtree_control and so cannot hold processes.
+	echo "$io_pid" > "$(_cgroup2_base_dir)/cgroup.procs"
+
+	# Remove the throttle cgroup while its bio is still queued.
+	rmdir "$CGROUP2_DIR/$THROTL_DIR"
+	sleep 3
+
+	kill "$io_pid" 2>/dev/null
+	wait "$io_pid" 2>/dev/null
+
+	# $THROTL_DIR is already gone; tear down the rest by hand.
+	if [[ $THROTL_CLEAR_CGROUP2_DIR_CONTROL_IO == true ]]; then
+		echo "-io" > "$CGROUP2_DIR/cgroup.subtree_control"
+	fi
+	if [[ $THROTL_CLEAR_BASE_SUBTREE_CONTROL_IO == true ]]; then
+		echo "-io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"
+	fi
+	_exit_cgroup2
+	_exit_throtl_blkdev
+
+	if _dmesg_since_test_start | grep -qE "WARNING:.*(blk-cgroup|blk-throttle)"; then
+		echo "WARNING: blkcg/blk-throttle warning on cgroup removal with queued IO"
+		_dmesg_since_test_start | grep -A 12 -E "WARNING:.*(blk-cgroup|blk-throttle)" \
+			>> "$FULL"
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/throtl/009.out b/tests/throtl/009.out
new file mode 100644
index 0000000..be675dd
--- /dev/null
+++ b/tests/throtl/009.out
@@ -0,0 +1,2 @@
+Running throtl/009
+Test complete
-- 
2.43.0

