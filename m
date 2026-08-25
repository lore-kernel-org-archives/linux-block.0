Received: from mta1.migadu.com (out-84.mta1.migadu.com [95.215.58.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA903F58F7
	for <linux-block@vger.kernel.org>; Tue, 25 Aug 2026 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654465; cv=none; b=gj6bdZ/qSFt/nzrGPpEIHvO3cDHz9+20rcxhSgYcdpRDeP0aTsZU+rJlPZgOS2F2DUdn4vWnqAqUTAliEBBHvncrKZEQ4xvgT/2dF21B8jFxGsLa120k/hJsMvjV9NXTSB4JIJcOaJoYMy7WkocizXFGIMewqs2CynNciefTz/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654465; c=relaxed/simple;
	bh=WHKg9UjIpsqDmNwfmCjIgvoWDEiZGQ1dkzLjisSlAYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p6z1LVkz/FyL0J6rd3FkLxB6gZJRqZ03xkl+bH0XLQSdLRQmqkq+3ePYjuv64IIiO3OMU7JjWWMgQ/eh6mfi3N+KlswGVzQkU08IwgCoHMO53xj/XuviqVBJIYx6pHHVm5wiboPOBeuRD7HyRBfmY/eEcEBiVc8LXrajuq0mAYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QehboYkD; arc=none smtp.client-ip=95.215.58.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QehboYkD"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WHKg9UjIpsqDmNwfmCjIgvoWDEiZGQ1dkzLjisSlAYA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787654461; v=1; x=1788259261;
 b=QehboYkDS77dW/w73KGiTvz5FzyEB2ldJ03/KYgVQOK8RPrTyjFkLlfR5wA1A73+8ZVdrXBx
 T+COyDLY5znuCXHsxRypPJCSd0/+wwob850l35U17WYAn4JclD+9h4aqNsI30Sfoj6nAPgpmNft
 MbOR98B86jMVJfUgmTDwxUNU=
X-Envelope-To: linux-block@vger.kernel.org
Received: from ctao-book.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 100ba27861d2a031;
	Tue, 25 Aug 2026 10:41:01 +0000
X-Mizu-Trace-ID: 100ba27861d2a031
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	hch@lst.de,
	yukuai@kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH blktests v2] tests/throtl: add a new test 009
Date: Tue, 25 Aug 2026 18:40:53 +0800
Message-ID: <20260825104053.70390-1-cui.tao@linux.dev>
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

Link: https://lore.kernel.org/all/20260804133208.GB8078@lst.de/
---
Changes since v1 [1]:
- Add a Link: tag referring to the background discussion, as suggested
  by Shin'ichiro.
- Drop THROTL_BLKDEV_TYPES=nullb so the test runs for both nullb and
  scsi_debug like the other throtl test cases, as suggested by
  Shin'ichiro.

See also the blkcg "store blkcg in bio" RFC:
https://lore.kernel.org/r/20260804065313.2092022-1-yukuai@kernel.org

Link: https://lore.kernel.org/r/20260813144041.1715866-1-cui.tao@linux.dev

 tests/throtl/009     | 64 ++++++++++++++++++++++++++++++++++++++++++++
 tests/throtl/009.out |  2 ++
 2 files changed, 66 insertions(+)
 create mode 100755 tests/throtl/009
 create mode 100644 tests/throtl/009.out

diff --git a/tests/throtl/009 b/tests/throtl/009
new file mode 100755
index 0000000..d304301
--- /dev/null
+++ b/tests/throtl/009
@@ -0,0 +1,64 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Tao Cui <cuitao@kylinos.cn>
+#
+# Regression test for removing a cgroup while IO is still queued in the
+# blk-throttle queue.  The queued bios must be flushed without any
+# blk-cgroup or blk-throttle warning.
+
+. tests/throtl/rc
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
+	# Throttle reads so the bio queues.
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

