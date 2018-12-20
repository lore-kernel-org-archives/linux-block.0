Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD0DC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 18:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540DA218D9
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 18:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545329915;
	bh=sS+YJv9PDcSaIKkxvV1gs7K3UzZTQGJg/l61zXoX7iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oPGACKsFSETN4Gw4V2dcQW0lmCDLne9K6muCiW8jHCz1MZVVSB6XJajyirW+FRUw/
	 DaH9b2KrcBPO/8vPOF/OegiyzJCnalZDI+5/jYkoS/J23mbV2on78bCVsOh0EHippI
	 A44DabyUORK1BqFI3pVxLmeJG2MZ3w2OJNtrMUF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388703AbeLTSSe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:18:34 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34470 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730897AbeLTSSe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 13:18:34 -0500
Received: by mail-yw1-f68.google.com with SMTP id g75so1058981ywb.1
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 10:18:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EWY3OuL6JZdXdY2O0STsZO7NtlrRHK8oR23qfHiwJTY=;
        b=rUzGQ4jarBpP6TVtb5dDghXkPLAmqWgNVD56sE5P/CFCRDX2KX4vA+bcSZcwHdq0n8
         EPxV3ZGtsvbNmaPAjpw01YIA6Car4sUAFDyqh//exbwgKMgAbKCCG1ljWwPY+jOBLDN/
         7vfdTdc5GG2kbiQbB0FxVvIK9uA16h3x9K2qcfJzM0IOd6fCjgSL5YowtbgJJWIJ8j2Y
         xFcxyvCN1aqK309nKl6+jKQQeuXZBA+3ucvWT2jqy2t9ihWChYF1Lo72ah8/m0U0FAf7
         GINLTYgC0C5RFVHWEamSyH5V1LTTsZE3sAhBT7ew7IPptO0yy/Pfmej1lzNkw/hY809g
         OL8Q==
X-Gm-Message-State: AA+aEWaLJXYMLc12HvqX3LZtkV0R7q+sRY09dFkzBEbv1AulN20iB+tc
        n2z9SfCE4IDUdY4D31dgqwynhIruiLo=
X-Google-Smtp-Source: AFSGD/V55KtKqncpIrCbScVR2+3ypLHquo9yVp3FFndd3J0rJs/VUj2VjYucRoL8JQ0K+RfLkh6NAg==
X-Received: by 2002:a0d:ec45:: with SMTP id v66mr26980939ywe.419.1545329912582;
        Thu, 20 Dec 2018 10:18:32 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.2])
        by smtp.gmail.com with ESMTPSA id q185sm7115113ywe.87.2018.12.20.10.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 10:18:31 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH blktests 2/2] blktests: add Ming Lei's scsi-stress-remove
Date:   Thu, 20 Dec 2018 12:18:26 -0600
Message-Id: <20181220181826.55481-3-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181220181826.55481-1-dennis@kernel.org>
References: <20181220181826.55481-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This test exposed a race condiiton when shutting down a request_queue
with active IO against it and blkg association for the IOs [1]. The
issue ended up being that while the request_queue will just start
failing requests, blkg destruction sets the q->root_blkg to %NULL. This
caused a NPE. This was fixed in [2].

So to help prevent this from happening again, integrate Ming's test into
blktests so that it can more easily be ran. Here I've ported it to fit
better into the blktests framework.

[1] https://lore.kernel.org/lkml/20181205171039.73066-1-dennis@kernel.org/
[2] https://lore.kernel.org/lkml/20181211230308.66276-1-dennis@kernel.org/

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
---
v2:
- Used helpers in common/scsi_debug per Omar's suggestion.

 tests/block/027     | 73 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/027.out |  2 ++
 2 files changed, 75 insertions(+)
 create mode 100755 tests/block/027
 create mode 100644 tests/block/027.out

diff --git a/tests/block/027 b/tests/block/027
new file mode 100755
index 0000000..d5e1463
--- /dev/null
+++ b/tests/block/027
@@ -0,0 +1,73 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2018 Ming Lei
+#
+# Regression test for commit 0273ac349f08 ("blkcg: handle dying request_queue
+# when associating a blkg")
+#
+# This tries to expose the race condition between blkg association and
+# request_queue shutdown. When a request_queue is shutdown, the corresponding
+# blkgs are destroyed. Any further associations should fail gracefully and not
+# cause a kernel panic.
+
+. tests/block/rc
+. common/scsi_debug
+. common/cgroup
+
+DESCRIPTION="test graceful shutdown of scsi_debug devices with running fio jobs"
+QUICK=1
+
+requires() {
+	_have_cgroup2_controller io && _have_scsi_debug && _have_fio
+}
+
+scsi_debug_stress_remove() {
+	if ! _init_scsi_debug "$@"; then
+		return
+	fi
+
+	# set higher aio limit
+	echo 524288 > /proc/sys/fs/aio-max-nr
+
+	local dev fio_jobs scheds
+	local cnt=1
+	for dev in "${SCSI_DEBUG_DEVICES[@]}"; do
+		# create fio job
+		fio_jobs=$fio_jobs" --name=job1 --filename=/dev/$dev "
+
+		# set queue scheduler and queue_depth
+		queue_path=/sys/block/$dev/queue
+		scheds=($(sed 's/[][]//g' "$queue_path/scheduler"))
+		sched_idx=$((cnt % ${#scheds[@]}))
+		echo "${scheds[$sched_idx]}" > "$queue_path/scheduler"
+		echo $cnt > "$queue_path/../device/queue_depth"
+		cnt=$((cnt+1))
+	done
+
+	local num_jobs=4 runtime=21
+	fio --rw=randread --size=128G --direct=1 --ioengine=libaio \
+		--iodepth=2048 --numjobs=$num_jobs --bs=4k \
+		--group_reporting=1 --group_reporting=1 --runtime=$runtime \
+		--loops=10000 "$fio_jobs" > "$FULL" 2>&1 &
+
+	sleep 7
+	local device_path
+	for dev in "${SCSI_DEBUG_DEVICES[@]}"; do
+		# shutdown devices in progress
+		device_path=/sys/block/$dev/device
+		[ -f "$device_path/delete" ] && echo 1 > "$device_path/delete"
+	done
+
+	wait
+
+	_exit_scsi_debug
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	scsi_debug_stress_remove virtual_gb=128 max_luns=21 ndelay=10000 \
+		max_queue=110
+
+	echo "Test complete"
+}
diff --git a/tests/block/027.out b/tests/block/027.out
new file mode 100644
index 0000000..b03498f
--- /dev/null
+++ b/tests/block/027.out
@@ -0,0 +1,2 @@
+Running block/027
+Test complete
-- 
2.17.1

