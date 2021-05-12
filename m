Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC0EC433B4
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91F836188B
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhELHDV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 03:03:21 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:37590 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhELHDP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 03:03:15 -0400
Received: by mail-pl1-f171.google.com with SMTP id h20so12051766plr.4
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 00:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Si1RoWNMKqVtvr0ax02yT4qVz3AmmuJc9uBQQbL56aI=;
        b=MFyeeXhhzILKSBWXBgFyCf7rMWDgujwslphbKdLNEFoV6HumjBesGzszxY3GacMUG2
         j31JnJNLjjsOMbLB9SawKGHYiArxDJ4S71aURB++FSz9AmrBr21wSdjdFYCRhf3zotGR
         glH9IPGe/ijlaGC2UCRtHO4YdYW04ybG0UlmYSK5unPHwK4xLnFLkjiF3KUZP8G5bYWG
         qSauWqeMOIdIUF4gFX2/oVQme34fchAICUA13HOoec6QMuA5h7M543WGLcWEs4WHTyAs
         tLaxY0zsDy4iHBstS/ZhCE3IfcqDF63MaMo6ygagPNNpFHz+6LrplBYRafW5wbFSGEPr
         ZQQg==
X-Gm-Message-State: AOAM531gI/8XiYPDzo6Be22oAzadwPceA4X9rlZzv7ZiNVoSXgSl/fc3
        waOEuXTZG1/MupsfMWeDi70=
X-Google-Smtp-Source: ABdhPJwofqx1MQ3jAs04KmyTXHiSkmqx8E280RTXLN5qHlV1Zm8ecVF2AVYWeDp2qmVU/TNIALCk9w==
X-Received: by 2002:a17:902:c3c5:b029:ed:3ff4:70f3 with SMTP id j5-20020a170902c3c5b02900ed3ff470f3mr34327002plj.12.1620802927087;
        Wed, 12 May 2021 00:02:07 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c6sm14877624pfo.192.2021.05.12.00.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:02:03 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B16F241EDA; Wed, 12 May 2021 06:14:24 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     osandov@fb.com, linux-block@vger.kernel.org
Cc:     bvanassche@acm.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/2] block: add add_disk() error handling tests
Date:   Wed, 12 May 2021 06:14:20 +0000
Message-Id: <20210512061420.13611-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210512061420.13611-1-mcgrof@kernel.org>
References: <20210512061420.13611-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If your kernel has the new CONFIG_FAIL_ADD_DISK which adds
error injection to the add_disk() paths, we'll run tests against
each possible test path and ensure that the kernel doesn't
crash / break / leak.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tests/block/013     | 156 ++++++++++++++++++++++++++++++++++++++++++++
 tests/block/013.out |   4 +-
 2 files changed, 157 insertions(+), 3 deletions(-)
 create mode 100755 tests/block/013

diff --git a/tests/block/013 b/tests/block/013
new file mode 100755
index 0000000..a039048
--- /dev/null
+++ b/tests/block/013
@@ -0,0 +1,156 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Luis Chamberlain <mcgrof@kernel.org>
+
+# Trigger the block *add_disk()() error path. We used to not have
+# any error path handling for add_disk(). Only recently have we
+# added support for this. There are many places in which the
+# function call for add_disk() can fail, this test allows us to
+# force each path which could fail and test it.
+#
+# Correctness is verified by running the tests many times, looking
+# for kernel errors, crashes or memory leaks.
+
+. tests/block/rc
+. common/null_blk
+
+DESCRIPTION="trigger the add_disk() error paths"
+QUICK=1
+
+if [ -z "$SYS_DEBUGFS" ]; then
+	SYS_DEBUGFS="/sys/kernel/debug"
+fi
+
+if [ -z "$SYS_DEBUGFS_BLOCK_DIR" ]; then
+	SYS_DEBUGFS_BLOCK_DIR="$SYS_DEBUGFS/block"
+fi
+
+if [ -z "$BLOCK_ADD_DISK_FAIL_DEBUGFS_DIR" ]; then
+	BLOCK_ADD_DISK_FAIL_DEBUGFS_DIR="$SYS_DEBUGFS_BLOCK_DIR/config_fail_add_disk"
+fi
+
+if [ -z "$BLOCK_ADD_DISK_CONFIG_DIR" ]; then
+	BLOCK_ADD_DISK_CONFIG_DIR="$SYS_DEBUGFS_BLOCK_DIR/fail_add_disk"
+fi
+
+if [ -z "$KMEMLEAK_DEBUG_FILE" ]; then
+	KMEMLEAK_DEBUG_FILE="$SYS_DEBUGFS/kmemleak"
+fi
+
+requires() {
+	_have_kernel_option FAIL_ADD_DISK
+	_have_kernel_option FAULT_INJECTION_DEBUG_FS
+	_have_kernel_option DEBUG_KMEMLEAK
+	_have_null_blk
+}
+
+kmemleak_clear()
+{
+	echo clear > $KMEMLEAK_DEBUG_FILE
+}
+
+kmemleak_verify()
+{
+	echo scan > $KMEMLEAK_DEBUG_FILE
+	cat $KMEMLEAK_DEBUG_FILE
+}
+
+enable_add_disk_failures()
+{
+	echo 1 > $BLOCK_ADD_DISK_CONFIG_DIR/interval
+	echo 100 > $BLOCK_ADD_DISK_CONFIG_DIR/probability
+}
+
+disable_add_disk_failures()
+{
+	echo 0 > $BLOCK_ADD_DISK_CONFIG_DIR/interval
+	echo 0 > $BLOCK_ADD_DISK_CONFIG_DIR/probability
+}
+
+disable_add_disk_failure_paths()
+{
+	local fail_files_paths
+	local fail_path_bool
+
+	fail_files_paths=$(ls -1 $BLOCK_ADD_DISK_FAIL_DEBUGFS_DIR)
+
+	for fail_path_bool in ${fail_files_paths}; do
+		echo N > $BLOCK_ADD_DISK_FAIL_DEBUGFS_DIR/$fail_path_bool
+		if [[ $? -ne 0 ]]; then
+			echo "Could not disable $fail_path_bool"
+		fi
+	done
+}
+
+test_add_disk_failures()
+{
+	local fail_files
+	local fail_path
+	local leak_wc
+	local test_add_disk_cnt=$1
+
+	fail_files=$(ls -1 $BLOCK_ADD_DISK_FAIL_DEBUGFS_DIR)
+
+	# We enable only one failure path at a time. The order does not matter
+	# and so whatever order we get alphabetically is fine. We test for
+	# correctness by checking for crashes, and memory leaks.
+	for fail_path in ${fail_files}; do
+		disable_add_disk_failure_paths
+		echo Y > $BLOCK_ADD_DISK_FAIL_DEBUGFS_DIR/$fail_path
+		if [[ $? -ne 0 ]]; then
+			echo "Could not enable failure injection for $fail_path"
+			echo "on loop $test_add_disk_cnt"
+		fi
+
+		NULL_BLK_QUIET_MODPROBE="y"
+		if _init_null_blk queue_mode=2 ; then
+			echo "Loading of null_blk should have failed while testing"
+			echo "add_disk() failure on $fail_path loop test"
+			echo "number $test_add_disk_cnt"
+			return 1
+		fi
+		unset NULL_BLK_QUIET_MODPROBE
+
+		leak_wc=$(kmemleak_verify | wc -l)
+		if [[ $leak_wc -ne 0 ]]; then
+			echo "Memory leak detected while testing add_disk()"
+			echo "failure path on $fail_path loop test"
+			echo "number $test_add_disk_cnt"
+			kmemleak_verify
+		fi
+	done
+}
+
+test() {
+	local test_loop_cnt
+	local test_loop_max=5
+	local final_leak_w
+
+	enable_add_disk_failures
+	kmemleak_clear
+
+	for test_loop_cnt in $(seq 1 $test_loop_max); do
+		test_add_disk_failures $test_loop_cnt
+	done
+
+	disable_add_disk_failure_paths
+	disable_add_disk_failures
+
+	# Last check is just a sanity check to ensure we can still load
+	# the null block module correctly/
+	if ! _init_null_blk queue_mode=2; then
+		echo "Loading null_blk failed after disabling error injection"
+		return 1
+	fi
+
+	leak_wc=$(kmemleak_verify | wc -l)
+	if [[ $leak_wc -ne 0 ]]; then
+		echo "Memleak after disabling add_disk() error injection"
+		kmemleak_verify
+	fi
+	kmemleak_clear
+
+	_exit_null_blk
+
+	echo Passed
+}
diff --git a/tests/block/013.out b/tests/block/013.out
index 1a97562..863339f 100644
--- a/tests/block/013.out
+++ b/tests/block/013.out
@@ -1,3 +1 @@
-Running block/013
-Device or resource busy
-Test complete
+Passed
-- 
2.30.2

