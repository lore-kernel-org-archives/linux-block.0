Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5A8C65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 21:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A79C20839
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 21:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="iBQcNqMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A79C20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbeLLVi2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:38:28 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42075 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbeLLVi2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 16:38:28 -0500
Received: by mail-yw1-f68.google.com with SMTP id x2so7624616ywc.9
        for <linux-block@vger.kernel.org>; Wed, 12 Dec 2018 13:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=mLOSjIAUrX39hElj7cDbvJEvfJbYtGEMjpd/cxcSnpk=;
        b=iBQcNqMShsv3PK9M8XglI10HE1biWbNg2COKU1/v6cVDvST+TL0NOLqSylzGQPDszM
         JM/GFVt/8ANOx151YoUpbaavv/hmeX7qlTXj+wc7YVstZz9HFG4HHPi7TCY0ZKFWAFBu
         0hA7VtDt9BJWR0SOIMfVs1RYnZ1cGxZKs+aLHnOmR4lqWbwOhKpP4IfxFulOHJXvQcJO
         9E85J6EM/gcTUOuBhKp3BikBc/Na+uCfwydPbHP3oC7pWAlqpRJ1f+TA4bp7Lo4A7U0S
         Sm378YZpU1+o/DcpOtmW9vA1qNJanauFkU5OKwOLjRFp5DTB3zaIaUPRpcIWvnAWl160
         Lb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=mLOSjIAUrX39hElj7cDbvJEvfJbYtGEMjpd/cxcSnpk=;
        b=k+VfhoZQW5z1V10TXykxQVthGsEzCCj+/sJio6LQQ8xL40ArHg9bd7wZkXSqj8DPt9
         ckqW+bWJPsMSJFkKk3wKZ3IQx6IJWF3IcnHvNvISOFgbU4IXO+FmsWqA0unMArE4GQM2
         ggdCBYInCkaF3COoDbUdlhsMJKr8kEHVzB9I72jUm2rXkWQyWtigXD1z0SovFnVCcjI0
         fFOu0EAyTV9jbRWPM+nrgwKh3QGS6kEC1Gr3j/Pi7i8rbawzVa9jCdLmWBZz4IMghtrE
         9ihSlLpE0ew3ink5C8oSvduqMQ0SNduw+5bSwEaofFbNk47v1tD5GHWzljyVW6nLqwum
         zLmg==
X-Gm-Message-State: AA+aEWa04SbuMR7qrqJLaWnSaLB8+fpL8e5A8q5OKFDPs2RmdqMBMQj6
        jl6mWDtHHIorx1YjV3tM0mr7BhryG9U=
X-Google-Smtp-Source: AFSGD/Wz8rFQTaN0gjzaUkj7gc06Cl7WiWz2/tg5UX7JMqRJN7I6bD0JfexEV1Tw/68QRBbuFKCR7g==
X-Received: by 2002:a81:a988:: with SMTP id g130mr22104785ywh.307.1544650706643;
        Wed, 12 Dec 2018 13:38:26 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y16sm6090712ywg.35.2018.12.12.13.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 13:38:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-block@vger.kernel.org, osandov@fb.com, kernel-team@fb.com
Subject: [PATCH] blktests: add a test for wbt
Date:   Wed, 12 Dec 2018 16:38:24 -0500
Message-Id: <20181212213824.26958-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There's currently no tests to verify wbt is working properly, this patch
fixes that.  Simply run a varied workload and measure the read latencies
with wbt off, and then turn it on and verify that the read latencies go
down.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/fio          |  8 +++++
 common/rc           |  8 +++++
 tests/block/022     | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/022.out |  2 ++
 tests/block/026     | 12 ++-----
 5 files changed, 114 insertions(+), 10 deletions(-)
 create mode 100755 tests/block/022
 create mode 100644 tests/block/022.out

diff --git a/common/fio b/common/fio
index e407088840b8..9e1a0557ac61 100644
--- a/common/fio
+++ b/common/fio
@@ -192,3 +192,11 @@ _fio_perf_report() {
 		TEST_RUN["$FIO_PERF_PREFIX$name"]="$value"
 	done
 }
+
+_fio_results_key() {
+	local job=$1
+	local key=$2
+	local resultfile=$3
+
+	jq '.jobs[] | select(.jobname == "'"$job"'") | .'"$key" "$resultfile"
+}
diff --git a/common/rc b/common/rc
index 153a32358519..91972d7b0130 100644
--- a/common/rc
+++ b/common/rc
@@ -183,6 +183,14 @@ _test_dev_is_pci() {
 	return 0
 }
 
+_test_dev_supports_wbt() {
+	if [[ ! -e "${TEST_DEV_SYSFS}/queue/wbt_lat_usec" ]]; then
+		SKIP_REASON="$TEST_DEV does not support wbt"
+		return 1
+	fi
+	return 0
+}
+
 _get_pci_dev_from_blkdev() {
 	readlink -f "$TEST_DEV_SYSFS/device" | \
 		grep -Eo '[0-9a-f]{4,5}:[0-9a-f]{2}:[0-9a-f]{2}\.[0-9a-f]' | \
diff --git a/tests/block/022 b/tests/block/022
new file mode 100755
index 000000000000..647f759e4cd0
--- /dev/null
+++ b/tests/block/022
@@ -0,0 +1,94 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2018 Josef Bacik
+#
+# A basic test to exercise wbt and verify it's working.
+
+. tests/block/rc
+
+DESCRIPTION="run a read workload and write workload together with wbt"
+
+requires() {
+	_have_fio && _have_program jq
+}
+
+device_requires() {
+	_test_dev_supports_wbt
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	fio_config="$TMPDIR/test.fio"
+	fio_results="$TMPDIR/results.json"
+	fio_args=("--output-format=json" "--output=$fio_results")
+
+	cat << EOF > "$fio_config"
+	[global]
+	group_reporting
+	numjobs=8
+	filename=$TEST_DEV
+	randseed=12345
+	runtime=30
+	ioengine=psync
+
+	[reads]
+	new_group
+	readwrite=randread
+
+	[writes]
+	new_group
+	readwrite=randwrite
+EOF
+
+	local wbt_setting
+	wbt_setting=$(_test_dev_queue_get wbt_lat_usec)
+
+	_test_dev_queue_set wbt_lat_usec 0
+
+	# Run just the reads to get a baseline read latency for this workload
+	if ! fio "${fio_args[@]}" "$fio_config"; then
+		echo "fio exited with status $?"
+		return 1
+	fi
+
+	local avg_lat
+	avg_lat=$(_fio_results_key reads read.lat_ns.mean "$fio_results")
+	avg_lat=$(echo "$avg_lat" | cut -d . -f 1)
+
+	echo "avg latency $avg_lat" >> "$FULL"
+
+	# WBT isn't immediate, it requires missing latency targets before it
+	# starts to clamp down on writes, so give ourselves a little wiggle room
+	# to make sure our read latencies are still protected.
+	local thresh=$((avg_lat - avg_lat * 15 / 100))
+
+	echo "threshold is $thresh" >> "$FULL"
+
+	# Fast enough disk means we may not throttle writes, so set the
+	# threshold to something stupid low so we can verify wbt is doing
+	# something.  Otherwise the defaults will be fine for spinning rust.
+	if [[ $(_test_dev_queue_get rotational) -eq "0" ]]; then
+		_test_dev_queue_set wbt_lat_usec 1
+	else
+		_test_dev_queue_set wbt_lat_usec "$wbt_setting"
+	fi
+
+	if ! fio "${fio_args[@]}" "$fio_config"; then
+		echo "fio exited with status $?"
+		return 1
+	fi
+	_test_dev_queue_set wbt_lat_usec "$wbt_setting"
+
+	avg_lat=$(_fio_results_key reads read.lat_ns.mean "$fio_results")
+	avg_lat=$(echo "$avg_lat" | cut -d . -f 1)
+	echo "avg latency contended is $avg_lat" >> "$FULL"
+
+	# Verify we are at least somewhat protected now
+	if [[ $avg_lat -gt $thresh ]]; then
+		echo "Read latency too high, wbt not working?"
+		return 1
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/block/022.out b/tests/block/022.out
new file mode 100644
index 000000000000..14d43cb1c828
--- /dev/null
+++ b/tests/block/022.out
@@ -0,0 +1,2 @@
+Running block/022
+Test complete
diff --git a/tests/block/026 b/tests/block/026
index 88113a99bd28..8b18e6314d5e 100644
--- a/tests/block/026
+++ b/tests/block/026
@@ -14,21 +14,13 @@ requires() {
 		_have_program jq
 }
 
-fio_results_key() {
-	local job=$1
-	local key=$2
-	local resultfile=$3
-
-	jq '.jobs[] | select(.jobname == "'"$job"'") | .'"$key" "$resultfile"
-}
-
 sum_read_write_bytes() {
 	local job=$1
 	local resultfile=$2
 	local readbytes writebytes
 
-	readbytes=$(fio_results_key "$job" read.io_bytes "$resultfile")
-	writebytes=$(fio_results_key "$job" write.io_bytes "$resultfile")
+	readbytes=$(_fio_results_key "$job" read.io_bytes "$resultfile")
+	writebytes=$(_fio_results_key "$job" write.io_bytes "$resultfile")
 	echo $((readbytes + writebytes))
 }
 
-- 
2.14.3

