Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396F0C83002
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 01:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C34206E2
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 01:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgD1BZH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 21:25:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3314 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbgD1BZH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 21:25:07 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5B09E9406323141899A7;
        Tue, 28 Apr 2020 09:25:04 +0800 (CST)
Received: from huawei.com (10.175.113.49) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 09:25:02 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] blk-mq-debugfs: update blk_queue_flag_name[] accordingly for new flags
Date:   Tue, 28 Apr 2020 09:54:56 +0800
Message-ID: <20200428015456.1194-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <e1e28027-2dac-3ae3-21c1-9ba779a5a566@acm.org>
References: <e1e28027-2dac-3ae3-21c1-9ba779a5a566@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.49]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Else there may be magic numbers in /sys/kernel/debug/block/*/state.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
v2: comments update as suggested by Bart
---
 block/blk-mq-debugfs.c | 3 +++
 include/linux/blkdev.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 7a79db81a63f..49fdbc8a025f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -125,6 +125,9 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(REGISTERED),
 	QUEUE_FLAG_NAME(SCSI_PASSTHROUGH),
 	QUEUE_FLAG_NAME(QUIESCED),
+	QUEUE_FLAG_NAME(PCI_P2PDMA),
+	QUEUE_FLAG_NAME(ZONE_RESETALL),
+	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
 };
 #undef QUEUE_FLAG_NAME
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32868fbedc9e..02809e4dd661 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -585,6 +585,7 @@ struct request_queue {
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
 
+/* Keep blk_queue_flag_name[] in sync with the definitions below */
 #define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
 #define QUEUE_FLAG_DYING	1	/* queue being torn down */
 #define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
-- 
2.21.1

