Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB417C433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 21:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiD0VhP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239549AbiD0Vf2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 17:35:28 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8CE27172
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 14:32:16 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id i62so2419741pgd.6
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 14:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8O/rnxiVY9dHMiUF00rllxovkxa0MoE/CI7FMP2nu7k=;
        b=3Uur01fdTABmGiQQto81Aqb7RRosMGdk4LmAqL069PcQVGnXLBChrk7vWTPsfFDOwj
         NsBTM5BTk++URvHr5cYIuuN8/U/5yZb6QsTDiCiCZ8pkzVS8uKIQ88AKfqRTlhJcEF6E
         ingvHcsXyWE06irhBxCGRsneYqKgVf/6yseXI77M74cd6+MNH7IX9KOjJapANR4ZKa4A
         +UFLO1V6JV6VRzn2ZvRxgELm0lS62BpKH4b789QgRU/a7Omqjf3LwZ4z9xsLwTK0YRT6
         D6wlKqKFgcl6zzr0fFPI84X6W/um1pjLKf/PCzxz/t1jne6s+3BTXhFLZH6FJiW2cjze
         QxXw==
X-Gm-Message-State: AOAM532Y6hhIoB492pbdAYsmrJxp8BIqjdDWQnsk8MlYOyGxzch+9Dj/
        1X+f8rfrS7Jy71PVXTO5Oqw=
X-Google-Smtp-Source: ABdhPJxn8TzyLA6HXwUHc3JAo4qOCTtn/ZDxR3TmZCN2aFfcZDeRwoFJfnoDgX7qsy9XaxJV4n7Syg==
X-Received: by 2002:a65:460d:0:b0:39d:13e0:d571 with SMTP id v13-20020a65460d000000b0039d13e0d571mr25384869pgq.596.1651095135569;
        Wed, 27 Apr 2022 14:32:15 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:6cbb:d78e:9b3:bb62])
        by smtp.gmail.com with ESMTPSA id nm6-20020a17090b19c600b001cd4989fedbsm7700112pjb.39.2022.04.27.14.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 14:32:14 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 1/3] Introduce the io_schedulers() function
Date:   Wed, 27 Apr 2022 14:31:41 -0700
Message-Id: <20220427213143.2490653-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
In-Reply-To: <20220427213143.2490653-1-bvanassche@acm.org>
References: <20220427213143.2490653-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The functionality for retrieving the I/O schedulers supported by a request
queue occurs multiple times. Hence introduce a function for retrieving the
supported I/O schedulers.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 common/iosched             | 12 ++++++++++++
 common/multipath-over-rdma | 11 -----------
 tests/block/005            |  4 ++--
 tests/block/014            |  7 ++-----
 tests/block/015            |  7 ++-----
 tests/block/020            |  7 ++-----
 tests/block/021            |  6 ++----
 tests/nvmeof-mp/012        |  3 ++-
 tests/srp/012              |  3 ++-
 9 files changed, 26 insertions(+), 34 deletions(-)
 create mode 100644 common/iosched

diff --git a/common/iosched b/common/iosched
new file mode 100644
index 000000000000..5dd46216afcb
--- /dev/null
+++ b/common/iosched
@@ -0,0 +1,12 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 Google LLC
+
+# Prints a space-separated list with the names of all I/O schedulers supported
+# by block device $1.
+io_schedulers() {
+	local path=/sys/class/block/$1/queue/scheduler
+
+	[ -e "${path}" ] || return 1
+	sed 's/[][]//g' "${path}"
+}
diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index cef05ec92d29..75a5c832d6da 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -298,17 +298,6 @@ set_scheduler() {
 	fi
 }
 
-# Get block dev scheduler list
-get_scheduler_list() {
-	local b=$1 p
-	p=/sys/block/"$b"/queue/scheduler
-	if [ -e "$p" ]; then
-		sed 's/[][]//g' /sys/block/"$b"/queue/scheduler
-	else
-		return 1
-	fi
-}
-
 # Get a /dev/... path that points at dm device number $1. Set its I/O scheduler
 # to $2 and its timeout to $3. The shell script that includes this file must
 # define a function get_bdev_path() that translates device number $1 into a
diff --git a/tests/block/005 b/tests/block/005
index 77b9e2f57203..383c8f5b7d2b 100755
--- a/tests/block/005
+++ b/tests/block/005
@@ -5,6 +5,7 @@
 # Threads doing IO to a device, while we switch schedulers
 
 . tests/block/rc
+. common/iosched
 
 DESCRIPTION="switch schedulers while doing IO"
 TIMED=1
@@ -17,9 +18,8 @@ requires() {
 test_device() {
 	echo "Running ${TEST_NAME}"
 
-	local scheds
 	# shellcheck disable=SC2207
-	scheds=($(sed 's/[][]//g' "${TEST_DEV_SYSFS}/queue/scheduler"))
+	local scheds=($(io_schedulers "${TEST_DEV_SYSFS}"))
 
 	if _test_dev_is_rotational; then
 		size="32m"
diff --git a/tests/block/014 b/tests/block/014
index 04c34fa12b5c..78e90269389e 100755
--- a/tests/block/014
+++ b/tests/block/014
@@ -6,6 +6,7 @@
 
 . tests/block/rc
 . common/null_blk
+. common/iosched
 
 DESCRIPTION="run null-blk with blk-mq and timeout injection configured"
 
@@ -22,11 +23,7 @@ test() {
 		return 1
 	fi
 
-	local scheds
-	# shellcheck disable=SC2207
-	scheds=($(sed 's/[][]//g' /sys/block/nullb0/queue/scheduler))
-
-	for sched in "${scheds[@]}"; do
+	for sched in $(io_schedulers nullb0); do
 		echo "Testing $sched" >> "$FULL"
 		echo "$sched" > /sys/block/nullb0/queue/scheduler
 		# Do a bunch of I/Os which will timeout and then complete. The
diff --git a/tests/block/015 b/tests/block/015
index 79102a2bea54..5eb954b4906c 100755
--- a/tests/block/015
+++ b/tests/block/015
@@ -7,6 +7,7 @@
 
 . tests/block/rc
 . common/null_blk
+. common/iosched
 
 DESCRIPTION="run null-blk on different schedulers with requeue injection configured"
 QUICK=1
@@ -24,11 +25,7 @@ test() {
 		return 1
 	fi
 
-	local scheds
-	# shellcheck disable=SC2207
-	scheds=($(sed 's/[][]//g' /sys/block/nullb0/queue/scheduler))
-
-	for sched in "${scheds[@]}"; do
+	for sched in $(io_schedulers nullb0); do
 		echo "Testing $sched" >> "$FULL"
 		echo "$sched" > /sys/block/nullb0/queue/scheduler
 		dd if=/dev/nullb0 of=/dev/null bs=4K count=$((512 * 1024)) \
diff --git a/tests/block/020 b/tests/block/020
index b4887a26ff0a..0301129e1c1d 100755
--- a/tests/block/020
+++ b/tests/block/020
@@ -8,6 +8,7 @@
 
 . tests/block/rc
 . common/null_blk
+. common/iosched
 
 DESCRIPTION="run null-blk on different schedulers with only one hardware tag"
 QUICK=1
@@ -25,16 +26,12 @@ test() {
 		return 1
 	fi
 
-	local scheds
-	# shellcheck disable=SC2207
-	scheds=($(sed 's/[][]//g' /sys/block/nullb0/queue/scheduler))
-
 	local max_iodepth=$(($(cat /proc/sys/fs/aio-max-nr) / $(nproc)))
 	local iodepth=1024
 	if (( iodepth > max_iodepth )); then
 		iodepth=$max_iodepth
 	fi
-	for sched in "${scheds[@]}"; do
+	for sched in $(io_schedulers nullb0); do
 		echo "Testing $sched" >> "$FULL"
 		echo "$sched" > /sys/block/nullb0/queue/scheduler
 		_fio_perf --bs=4k --ioengine=libaio --iodepth=$iodepth \
diff --git a/tests/block/021 b/tests/block/021
index a1bbf45a3bc9..7b562de0f99c 100755
--- a/tests/block/021
+++ b/tests/block/021
@@ -8,6 +8,7 @@
 
 . tests/block/rc
 . common/null_blk
+. common/iosched
 
 DESCRIPTION="read/write nr_requests on null-blk with different schedulers"
 QUICK=1
@@ -26,11 +27,8 @@ test() {
 
 	local max_nr
 	local nr
-	local scheds
-	# shellcheck disable=SC2207
-	scheds=($(sed 's/[][]//g' /sys/block/nullb0/queue/scheduler))
 
-	for sched in "${scheds[@]}"; do
+	for sched in $(io_schedulers nullb0); do
 		echo "Testing $sched" >> "$FULL"
 		echo "$sched" > /sys/block/nullb0/queue/scheduler
 		max_nr="$(cat /sys/block/nullb0/queue/nr_requests)"
diff --git a/tests/nvmeof-mp/012 b/tests/nvmeof-mp/012
index 8b2e918773e5..0b56dfb46d1e 100755
--- a/tests/nvmeof-mp/012
+++ b/tests/nvmeof-mp/012
@@ -3,6 +3,7 @@
 # Copyright (c) 2018 Western Digital Corporation or its affiliates
 
 . tests/nvmeof-mp/rc
+. common/iosched
 
 DESCRIPTION="dm-mpath on top of multiple I/O schedulers"
 QUICK=1
@@ -18,7 +19,7 @@ test_io_schedulers() {
 		use_blk_mq ${mq} || return $?
 		dev=$(get_bdev 0) || return $?
 		dm=$(basename "$(readlink -f "${dev}")") || return $?
-		scheds="$(get_scheduler_list "$dm")" || return $?
+		scheds="$(io_schedulers "$dm")" || return $?
 		for sched in $scheds; do
 			set_scheduler "$dm" "$sched" \
 				      >>"$FULL" 2>&1 || continue
diff --git a/tests/srp/012 b/tests/srp/012
index 1a2fc6d2dc2f..7c72288b773b 100755
--- a/tests/srp/012
+++ b/tests/srp/012
@@ -3,6 +3,7 @@
 # Copyright (c) 2018 Western Digital Corporation or its affiliates
 
 . tests/srp/rc
+. common/iosched
 
 DESCRIPTION="dm-mpath on top of multiple I/O schedulers"
 QUICK=1
@@ -22,7 +23,7 @@ test_io_schedulers() {
 		use_blk_mq ${mq} ${mq} || return $?
 		dev=$(get_bdev 0) || return $?
 		dm=$(basename "$(readlink -f "${dev}")") || return $?
-		scheds="$(get_scheduler_list "$dm")" || return $?
+		scheds="$(io_schedulers "$dm")" || return $?
 		for sched in $scheds; do
 			set_scheduler "$dm" "$sched" \
 				      >>"$FULL" 2>&1 || continue
