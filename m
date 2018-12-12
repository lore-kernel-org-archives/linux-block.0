Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA16C65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 23:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A237820870
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 23:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544656206;
	bh=IY+bUjYXSZeDfY4kMc/l4w14vW45loWl3xJ0UsquDIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hzm5IYCOj7iNb0s4ujhyUbTYYzQqMOnWLvA8GCxZwtamPIAlmyY43/UsU3qoKqbdA
	 IlQTDxoHtejTkdjUKXMb2TAfWj2NaVs4pyHl+NrKyKa0ikA90hj/3CWv2mOpLDCsbd
	 WK1vhTYeUWPDrRUJITi9jujrZu7Aj0rUc4wttiQA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A237820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeLLXKF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:10:05 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37340 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbeLLXKE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 18:10:04 -0500
Received: by mail-yw1-f66.google.com with SMTP id h193so58647ywc.4
        for <linux-block@vger.kernel.org>; Wed, 12 Dec 2018 15:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gehLJkuzE2X6rIJfz23DkpRIt/ansKL7Mvm45OYkhik=;
        b=QTl1aGTxQL/2UAGnfzoHrafjFNcSyJtwHeld4CPji7psRoau7+Flqu4mHs3Dj6P3yH
         4R4xMzvyHqUd11A9ECWBMMwlE2Q9fUEhhySnsapb3s2Pd3lL1SKCKE4JflAeB7xggb/V
         4MTStiHSFIedlREiAIjoeGMBvCasOSTNxJ9xXKpZg2weHQPLUkNudm92qS8AJL2XBJdY
         KOpOckxqzr0kaI6Cuqre+vIckzZqhKFIqR0cypF5Zo7zeNeF5uXLuYEoh7T+9p+melT3
         jtx4EA/6WO76v5pgwM2ud1vKnWilSIVpM/Cz/A42W+StAaVexrH1KyMJkbNzw9oBZM4j
         wpkA==
X-Gm-Message-State: AA+aEWb7bMrHSAre0mTMiUYvjehlJZNF9Bu5pkFiFpUsY61r+/m39ODp
        c2WUQRwJ3WriRf5k5GmOM+k=
X-Google-Smtp-Source: AFSGD/WxFpF0gtkYRP7hlIXOYJkqxhyNOknyg1AQ1bMci2PVgujAUTysPxrWEzUfOar1PO5hS772nQ==
X-Received: by 2002:a0d:d305:: with SMTP id v5mr23667087ywd.109.1544656203660;
        Wed, 12 Dec 2018 15:10:03 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id i21sm137832ywg.5.2018.12.12.15.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Dec 2018 15:10:02 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH blktests 2/2] blktests: add Ming Lei's scsi-stress-remove
Date:   Wed, 12 Dec 2018 18:09:59 -0500
Message-Id: <20181212230959.69975-3-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181212230959.69975-1-dennis@kernel.org>
References: <20181212230959.69975-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This test exposed a race condition with shutting down a request_queue
and the new blkg association. The issue ended up being that while the
request_queue will just start failing requests, blkg destruction sets
the q->root_blkg to %NULL. This caused a NPE when trying to reference
it. So to help prevent this from happening again, integrate Ming's test
into blktests so that it can more easily be ran.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
---
 tests/block/022     | 96 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/022.out |  2 +
 2 files changed, 98 insertions(+)
 create mode 100755 tests/block/022
 create mode 100644 tests/block/022.out

diff --git a/tests/block/022 b/tests/block/022
new file mode 100755
index 0000000..45bfff7
--- /dev/null
+++ b/tests/block/022
@@ -0,0 +1,96 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2018 Ming Lei
+#
+# Regression test for patch "blkcg: handle dying request_queue when associating
+# a blkg"
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
+	scsi_debug_path="/sys/bus/pseudo/drivers/scsi_debug"
+	count=21
+
+	runtime=12
+	nr_fio_jobs=8
+	scsi_dbg_ndelay=10000
+
+	# set higher aio limit
+	echo 524288 > /proc/sys/fs/aio-max-nr
+
+	#figure out the CAN_QUEUE
+	can_queue=$(((count + 1) * (count / 2) / 2))
+
+	rmmod scsi_debug > /dev/null 2>&1
+	modprobe scsi_debug virtual_gb=128 max_luns=$count \
+		ndelay=$scsi_dbg_ndelay max_queue=$can_queue
+
+	# figure out scsi_debug disks
+	hosts=$(ls -d /sys/bus/pseudo/drivers/scsi_debug/adapter0/host*)
+	hostname=$(basename "$hosts")
+	host=$(echo "$hostname" | grep -o -E '[0-9]+')
+
+	sdisks=$(ls -d $scsi_debug_path/adapter*/"$hostname"/target*/*/block/*)
+	disks=""
+	for sd in $sdisks; do
+		disks+="/dev/"$(basename "$sd")
+		disks+=" "
+	done
+
+	use_mq=$(cat /sys/module/scsi_mod/parameters/use_blk_mq)
+	if [[ $use_mq = "Y" ]]; then
+		scheds=("none" "mq-deadline" "kyber")
+	else
+		scheds=("noop" "deadline" "cfq")
+	fi
+
+	fio_jobs=""
+	cnt=0
+	for sd in $disks; do
+		cnt=$((cnt+1))
+		fio_jobs=$fio_jobs" --name=job1 --filename=$sd: "
+		dev_name=$(basename "$sd")
+		q_path=/sys/block/$dev_name/queue
+
+		sched_idx=$((cnt % ${#scheds[@]}))
+		echo "${scheds[$sched_idx]}" > "$q_path/scheduler"
+		echo $cnt > "$q_path/../device/queue_depth"
+	done
+
+	fio --rw=randread --size=128G --direct=1 --ioengine=libaio \
+		--iodepth=2048 --numjobs=$nr_fio_jobs --bs=4k \
+		--group_reporting=1 --group_reporting=1 --runtime=$runtime \
+		--loops=10000 "$fio_jobs" > "$FULL" 2>&1 &
+
+	sleep 7
+	for sd in $disks; do
+		dev_name=$(basename "$sd")
+		dpath=/sys/block/$dev_name/device
+		[ -f "$dpath/delete" ] && echo 1 > "$dpath/delete"
+	done
+
+	wait
+}
+
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	scsi_debug_stress_remove
+
+	echo "Test complete"
+}
diff --git a/tests/block/022.out b/tests/block/022.out
new file mode 100644
index 0000000..14d43cb
--- /dev/null
+++ b/tests/block/022.out
@@ -0,0 +1,2 @@
+Running block/022
+Test complete
-- 
2.17.1

