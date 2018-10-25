Return-Path: <axboe@kernel.dk>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blktests: remove legacy IO path timeout test
Message-ID: <a927c881-36ce-3f2d-784b-a758b05cdc47@kernel.dk>
Date: Thu, 25 Oct 2018 14:49:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

This feature is gone from null_blk in the current Linux kernels.
It doesn't make sense to keep testing this on older kernels either,
as the legacy IO path is going away.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/tests/block/022 b/tests/block/022
deleted file mode 100755
index 91946cfab6bf..000000000000
--- a/tests/block/022
+++ /dev/null
@@ -1,45 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-3.0+
-# Copyright (C) 2018 Jens Axboe
-#
-# Smoke test !mq timeout handling with null-blk.
-
-. tests/block/rc
-. common/null_blk
-
-DESCRIPTION="run null-blk with legacy blk path and timeout injection configured"
-
-requires() {
-	_have_null_blk && _have_module_param null_blk timeout
-}
-
-test() {
-	echo "Running ${TEST_NAME}"
-
-	# The format is "<interval>,<probability>,<space>,<times>". Here, we
-	# fail 50% of I/Os.
-	if ! _init_null_blk queue_mode=1 timeout='1,50,0,-1'; then
-		return 1
-	fi
-
-	local scheds
-	# shellcheck disable=SC2207
-	scheds=($(sed 's/[][]//g' /sys/block/nullb0/queue/scheduler))
-
-	for sched in "${scheds[@]}"; do
-		echo "Testing $sched" >> "$FULL"
-		echo "$sched" > /sys/block/nullb0/queue/scheduler
-		# Do a bunch of I/Os which will timeout and then complete. The
-		# only thing we're really testing here is that this doesn't
-		# crash or hang.
-		for ((i = 0; i < 100; i++)); do
-			dd if=/dev/nullb0 of=/dev/null bs=4K count=4 \
-				iflag=direct status=none &
-		done
-		wait
-	done
-
-	_exit_null_blk
-
-	echo "Test complete"
-}
diff --git a/tests/block/022.out b/tests/block/022.out
deleted file mode 100644
index 14d43cb1c828..000000000000
--- a/tests/block/022.out
+++ /dev/null
@@ -1,2 +0,0 @@
-Running block/022
-Test complete

-- 
Jens Axboe
