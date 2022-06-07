Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9394EC43334
	for <linux-block@archiver.kernel.org>; Tue,  7 Jun 2022 12:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244243AbiFGMsV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jun 2022 08:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244224AbiFGMsQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jun 2022 08:48:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48CD13EA2
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SqL/dT8JHaSK4BhmWma2PjJFslONxIxpXjyJPGhZHP4=; b=ilPT2d6dAB8Zaa9Jh0nMiRLpId
        xX+XrG6W6D8m81aOCDj8/0f1k9hvyZzD7GIA19RGtK+cRf3U9f2hri8dQyNCNRxDNtjHid67tWC7Y
        4FIZ8ATSbnb/XGbFMf2weoq9aG+miu70hdXZafVKZfWXHFsCEYAdgRIOmhnsln+8rNXxMbTHMBlOP
        kOMkyh4jFZIElex/L+FIYkeGNVaX5HFcygdR4mz4RTfUSVPxEC/RuDSTn5qG8eQu3TaU7ATo/VqCK
        6M2IShkY7Esr+3+dxVTQRvQ36JzHOh8JRpP5JHoMlgy8cB8E1TD6G+xT1PFObuYQ6TH1T8voYCQK6
        nVmSKGAA==;
Received: from [2001:4bb8:190:726c:b34a:228:52ee:6d34] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyYcx-007ShD-PJ; Tue, 07 Jun 2022 12:48:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 09/13] block/020: convert to use _configure_null_blk
Date:   Tue,  7 Jun 2022 14:47:35 +0200
Message-Id: <20220607124739.1259977-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607124739.1259977-1-hch@lst.de>
References: <20220607124739.1259977-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Switch to use _configure_null_blk so that built-in null_blk can be
supported, which implies not using the default nullb0 device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/block/020 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/block/020 b/tests/block/020
index eef63cb..3e8cbbd 100755
--- a/tests/block/020
+++ b/tests/block/020
@@ -20,14 +20,14 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
-	if ! _init_null_blk irqmode=2 completion_nsec=2000000 \
-	     submit_queues=4 hw_queue_depth=1; then
+	if ! _configure_null_blk nullb1 irqmode=2 completion_nsec=2000000 \
+	     submit_queues=4 hw_queue_depth=1 power=1; then
 		return 1
 	fi
 
 	local scheds
 	# shellcheck disable=SC2207
-	scheds=($(sed 's/[][]//g' /sys/block/nullb0/queue/scheduler))
+	scheds=($(sed 's/[][]//g' /sys/block/nullb1/queue/scheduler))
 
 	local max_iodepth=$(($(cat /proc/sys/fs/aio-max-nr) / $(nproc)))
 	local iodepth=1024
@@ -36,10 +36,10 @@ test() {
 	fi
 	for sched in "${scheds[@]}"; do
 		echo "Testing $sched" >> "$FULL"
-		echo "$sched" > /sys/block/nullb0/queue/scheduler
+		echo "$sched" > /sys/block/nullb1/queue/scheduler
 		_fio_perf --bs=4k --ioengine=libaio --iodepth=$iodepth \
 			--numjobs="$(nproc)" --rw=randread --name=async \
-			--filename=/dev/nullb0 --size=1g --direct=1 \
+			--filename=/dev/nullb1 --size=1g --direct=1 \
 			--runtime=10
 	done
 
-- 
2.30.2

