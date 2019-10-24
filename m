Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939CDCA9EBB
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 21:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B6621D71
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 21:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfJXVED (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 17:04:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46506 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfJXVED (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 17:04:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id f19so28959pgn.13
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 14:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WUzELtZ0/6O3O7y93j4oi5o6nnW4ejVR2cqHnlxjhqk=;
        b=DFIiQgNd///C8hdOR1UesYuinnX5FWrM+ILQNcqoy+20o42ORn35Whr/ESWXvx0FMD
         5/tJB9qNbbSSNE/ji3wAZjOVc1Z2IeFoshbLwTiJ4hZp0UJMQZAFZc5fvDcSNGqqoakq
         2Q8HWPLSLyIZ4oR96vl1PHO4UYlFquDAbk9aNWuq0SLwpQ5hEyre2RQ2/hraKYFhQf1E
         QOsiL/luQWe1kwDJsn8G+T6PqREwY8Ha9NsqzGBAhd1tL191Bc39RVZUpCG08j6F2XYW
         9MzMf1i6KJZzbcV1hBji4MYjQ+PZgoeZrXV0pqDoFYQ5CId/42JjwOOraoqPl0bIqVfA
         K6wA==
X-Gm-Message-State: APjAAAUtTQgI0No/P1ORIkLmHjlaeJE431qG07SDJ9p+t2jm6fXKxYkC
        gD8joLJYBiIMD+2OV3MYTTY=
X-Google-Smtp-Source: APXvYqyHx2TreEJGpqbrJPW3URG/eYbuu+t/XBrDJa7nCz/L3SF7igj1jBo3b/bbWCoDH9G1/IzDoA==
X-Received: by 2002:a65:49c9:: with SMTP id t9mr30681pgs.61.1571951042114;
        Thu, 24 Oct 2019 14:04:02 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id i22sm28270127pgg.20.2019.10.24.14.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 14:04:01 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests v2 2/2] Add a test that triggers blk_mq_update_nr_hw_queues()
Date:   Thu, 24 Oct 2019 14:03:52 -0700
Message-Id: <20191024210352.71080-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191024210352.71080-1-bvanassche@acm.org>
References: <20191024210352.71080-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Note: the newly added test script only triggers blk_mq_update_nr_hw_queues()
for kernel versions that include commit 45919fbfe1c4 ("null_blk: Enable
modifying 'submit_queues' after an instance has been configured").

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/block/029     | 64 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/029.out |  1 +
 2 files changed, 65 insertions(+)
 create mode 100755 tests/block/029
 create mode 100644 tests/block/029.out

diff --git a/tests/block/029 b/tests/block/029
new file mode 100755
index 000000000000..d298bac8db5c
--- /dev/null
+++ b/tests/block/029
@@ -0,0 +1,64 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2019 Google LLC
+#
+# Trigger blk_mq_update_nr_hw_queues().
+
+. tests/block/rc
+. common/null_blk
+
+DESCRIPTION="trigger blk_mq_update_nr_hw_queues()"
+QUICK=1
+
+requires() {
+	_have_null_blk
+}
+
+# Configure one null_blk instance.
+configure_null_blk() {
+	local nullb0="/sys/kernel/config/nullb/nullb0"
+
+	mkdir "$nullb0" &&
+	echo 0 > "$nullb0/completion_nsec" &&
+	echo 512 > "$nullb0/blocksize" &&
+	echo 16 > "$nullb0/size" &&
+	echo 1 > "$nullb0/memory_backed" &&
+	echo 1 > "$nullb0/power" &&
+	ls -l /dev/nullb* &>>"$FULL"
+}
+
+modify_nr_hw_queues() {
+	local deadline num_cpus
+
+	deadline=$(($(_uptime_s) + TIMEOUT))
+	num_cpus=$(nproc)
+	while [ "$(_uptime_s)" -lt "$deadline" ]; do
+		sleep .1
+		echo 1 > /sys/kernel/config/nullb/nullb0/submit_queues
+		sleep .1
+		echo "$num_cpus" > /sys/kernel/config/nullb/nullb0/submit_queues
+	done
+}
+
+test() {
+	local sq=/sys/kernel/config/nullb/nullb0/submit_queues
+
+	: "${TIMEOUT:=30}"
+	_init_null_blk nr_devices=0 queue_mode=2 &&
+	configure_null_blk
+	if { echo 1 >$sq; } 2>/dev/null; then
+		modify_nr_hw_queues &
+		fio --rw=randwrite --bs=4K --loops=$((10**6)) \
+		    --iodepth=64 --group_reporting --sync=1 --direct=1 \
+		    --ioengine=libaio --filename="/dev/nullb0" \
+		    --runtime="${TIMEOUT}" --name=nullb0 \
+		    --output="${RESULTS_DIR}/block/fio-output-029.txt" \
+		    >>"$FULL"
+		wait
+	else
+		echo "Skipping test because $sq cannot be modified" >>"$FULL"
+	fi
+	rmdir /sys/kernel/config/nullb/nullb0
+	_exit_null_blk
+	echo Passed
+}
diff --git a/tests/block/029.out b/tests/block/029.out
new file mode 100644
index 000000000000..863339fb8ced
--- /dev/null
+++ b/tests/block/029.out
@@ -0,0 +1 @@
+Passed
-- 
2.24.0.rc0.303.g954a862665-goog

