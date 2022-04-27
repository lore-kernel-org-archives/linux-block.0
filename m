Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD34C433F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 21:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiD0VhP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239552AbiD0Vf3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 17:35:29 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DEC27175
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 14:32:17 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id g9so2409354pgc.10
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 14:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=izld47yi+4hdPwmp/gW2P8M72AXJeWRz7I4HQnWnNGA=;
        b=3qUQGBUQ1LtJDghLAdbWHJ2tqZkAl0HBhLX2KACXjPJkOMCyoeatg8lvcnF/WAXfv2
         0I5+oCA9b+nfzddQj0N9omwDnSdZZOoFvaW+jmJ6jKlOUDi8fXF27EmyN37UE85GNIgv
         bB44K/Vac94RyLRNjJ/4jtrDw1J978ZRxaly/yteDZO8uoJsjqJJPEnahdT/jZGPsj7q
         Z5nhxoBXgaVkcW03xK9yIxolSJhwu4RRI11aJjSY2Ub+uezwCe+TFj69hDdDHec6F/AR
         QsUR8Hps89qUwoWdebbz/uLXVLeij+5a46N49YhlhpSLBXKxFQcH5arJBHl+nL86Nv4O
         sNLg==
X-Gm-Message-State: AOAM531/UlRaG6Oc+XOeFT90dGuuMdVRsL13PEEMKLA8HFc3g/8jVOro
        aflFflPLv44w0qUBsQvL3JfyURh3gBUs6g==
X-Google-Smtp-Source: ABdhPJzaFRrUl4meNBoM3agpRmz+odurI2mkK4NcuwM9Y/anotbaU28moBblPdge6IG2syqXk6YSeg==
X-Received: by 2002:a05:6a02:197:b0:382:a4b0:b9a8 with SMTP id bj23-20020a056a02019700b00382a4b0b9a8mr25312676pgb.325.1651095136870;
        Wed, 27 Apr 2022 14:32:16 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:6cbb:d78e:9b3:bb62])
        by smtp.gmail.com with ESMTPSA id nm6-20020a17090b19c600b001cd4989fedbsm7700112pjb.39.2022.04.27.14.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 14:32:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 2/3] Add I/O scheduler tests for queue depth 1
Date:   Wed, 27 Apr 2022 14:31:42 -0700
Message-Id: <20220427213143.2490653-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
In-Reply-To: <20220427213143.2490653-1-bvanassche@acm.org>
References: <20220427213143.2490653-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some block devices, e.g. USB sticks, only support queue depth 1. The
QD=1 code paths do not get tested routinely. Hence add tests for the
QD=1 use case.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 common/rc           |  5 ++++
 tests/block/032     | 62 ++++++++++++++++++++++++++++++++++++++++++++
 tests/block/032.out |  2 ++
 tests/scsi/008      | 63 +++++++++++++++++++++++++++++++++++++++++++++
 tests/scsi/008.out  |  2 ++
 5 files changed, 134 insertions(+)
 create mode 100755 tests/block/032
 create mode 100644 tests/block/032.out
 create mode 100755 tests/scsi/008
 create mode 100644 tests/scsi/008.out

diff --git a/common/rc b/common/rc
index 0528ce808256..2377e223aea7 100644
--- a/common/rc
+++ b/common/rc
@@ -321,6 +321,11 @@ _uptime_s() {
 	awk '{ print int($1) }' /proc/uptime
 }
 
+# System uptime in centiseconds.
+_uptime_cs() {
+	sed 's/\.//;s/ .*//' /proc/uptime
+}
+
 # Arguments: module to unload ($1) and retry count ($2).
 unload_module() {
 	local i m=$1 rc=${2:-1}
diff --git a/tests/block/032 b/tests/block/032
new file mode 100755
index 000000000000..8b4d30282988
--- /dev/null
+++ b/tests/block/032
@@ -0,0 +1,62 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 Google LLC
+
+. tests/block/rc
+. common/null_blk
+. common/iosched
+
+DESCRIPTION="test I/O scheduler performance of null_blk with queue_depth 1"
+QUICK=1
+
+requires() {
+	_have_null_blk
+}
+
+# Measure the time required to perform I/O on dev $1 with I/O scheduler $2.
+sched_time() {
+	local dev=$1 sched=$2
+	echo "$sched" > "/sys/block/$dev/queue/scheduler"
+	local start
+	start=$(_uptime_cs)
+	dd if="/dev/$dev" of=/dev/null bs=4K count=$((512 * 1024)) \
+	   iflag=direct status=none &
+	dd of="/dev/$dev" if=/dev/zero bs=4K count=$((512 * 1024)) \
+	   oflag=direct status=none &
+	wait
+	echo $(($(_uptime_cs) - start))
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local params=(
+		hw_queue_depth=1
+		queue_mode=2
+	)
+	_init_null_blk "${params[@]}" || return 1
+
+	local dev=nullb0 fail status
+
+	none_time_cs=$(sched_time "$dev" none)
+	for sched in $(io_schedulers "$dev"); do
+		[ "$sched" = none ] && continue
+		time_cs=$(sched_time "$dev" "$sched")
+		if [ "$time_cs" -lt $(("$none_time_cs" * 110 / 100)) ]; then
+			status=pass
+		else
+			status=fail
+			fail=true
+		fi
+		TEST_RUN[$sched]="$time_cs vs $none_time_cs: $status"
+	done
+
+	_exit_null_blk
+
+	if [ -z "$fail" ]; then
+		echo "Test complete"
+	else
+		echo "Test failed"
+		return 1
+	fi
+}
diff --git a/tests/block/032.out b/tests/block/032.out
new file mode 100644
index 000000000000..3604e9e1e751
--- /dev/null
+++ b/tests/block/032.out
@@ -0,0 +1,2 @@
+Running block/032
+Test complete
diff --git a/tests/scsi/008 b/tests/scsi/008
new file mode 100755
index 000000000000..dec304fd29a2
--- /dev/null
+++ b/tests/scsi/008
@@ -0,0 +1,63 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 Google LLC
+
+. tests/scsi/rc
+. common/iosched
+. common/scsi_debug
+
+DESCRIPTION="test I/O scheduler performance of scsi_debug with queue_depth 1"
+QUICK=1
+
+requires() {
+	_have_scsi_debug
+}
+
+# Measure the time required to perform I/O on dev $1 with I/O scheduler $2.
+sched_time() {
+	local dev=$1 sched=$2
+	echo "$sched" > "/sys/block/$dev/queue/scheduler"
+	local start
+	start=$(_uptime_cs)
+	dd if="/dev/$dev" of=/dev/null bs=4K count=$((512 * 1024)) \
+	   iflag=direct status=none &
+	dd of="/dev/$dev" if=/dev/zero bs=4K count=$((512 * 1024)) \
+	   oflag=direct status=none &
+	wait
+	echo $(($(_uptime_cs) - start))
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local params=(
+		delay=0
+		dev_size_mb=2048
+		host_max_queue=1
+	)
+	_init_scsi_debug "${params[@]}" || return 1
+
+	local dev="${SCSI_DEBUG_DEVICES[0]}" fail
+
+	none_time_cs=$(sched_time "$dev" none)
+	for sched in $(io_schedulers "$dev"); do
+		[ "$sched" = none ] && continue
+		time_cs=$(sched_time "$dev" "$sched")
+		if [ "$time_cs" -lt $(("$none_time_cs" * 110 / 100)) ]; then
+			status=pass
+		else
+			status=fail
+			fail=true
+		fi
+		TEST_RUN[$sched]="$time_cs vs $none_time_cs: $status"
+	done
+
+	_exit_scsi_debug
+
+	if [ -z "$fail" ]; then
+		echo "Test complete"
+	else
+		echo "Test failed"
+		return 1
+	fi
+}
diff --git a/tests/scsi/008.out b/tests/scsi/008.out
new file mode 100644
index 000000000000..135bd5ae4b2d
--- /dev/null
+++ b/tests/scsi/008.out
@@ -0,0 +1,2 @@
+Running scsi/008
+Test complete
