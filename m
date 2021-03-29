Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC7EC433C1
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 02:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC4F61582
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 02:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhC2CSx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Mar 2021 22:18:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15081 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhC2CSY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Mar 2021 22:18:24 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F7x5Z71tDz19JTt;
        Mon, 29 Mar 2021 10:16:18 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Mon, 29 Mar 2021
 10:18:13 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <hch@lst.de>, <ming.lei@redhat.com>,
        <bvanassche@acm.org>, <yuyufen@huawei.com>
Subject: [RFC PATCH] block: protect bi_status with spinlock
Date:   Sun, 28 Mar 2021 22:23:37 -0400
Message-ID: <20210329022337.3992955-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For multiple split bios, if one of the bio is fail, the whole
should return error to application. But we found there is a race
between bio_integrity_verify_fn and bio complete, which return
io success to application after one of the bio fail. The race as
following:

split bio(READ)          kworker

nvme_complete_rq
blk_update_request //split error=0
  bio_endio
    bio_integrity_endio
      queue_work(kintegrityd_wq, &bip->bip_work);

                         bio_integrity_verify_fn
                         bio_endio //split bio
                          __bio_chain_endio
                             if (!parent->bi_status)

                               <interrupt entry>
                               nvme_irq
                                 blk_update_request //parent error=7
                                 req_bio_endio
                                    bio->bi_status = 7 //parent bio
                               <interrupt exit>

                               parent->bi_status = 0
                        parent->bi_end_io() // return bi_status=0

The bio has been split as two: split and parent. When split
bio completed, it depends on kworker to do endio, while
bio_integrity_verify_fn have been interrupted by parent bio
complete irq handler. Then, parent bio->bi_status which have
been set in irq handler will overwrite by kworker.

In fact, even without the above race, we also need to conside
the concurrency beteen mulitple split bio complete and update
the same parent bi_status. Normally, multiple split bios will
be issued to the same hctx and complete from the same irq
vector. But if we have updated queue map between multiple split
bios, these bios may complete on different hw queue and different
irq vector. Then the concurrency update parent bi_status may
cause the final status error.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/bio.c               | 3 +++
 block/blk-core.c          | 4 ++++
 include/linux/blk_types.h | 1 +
 3 files changed, 8 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 26b7f721cda8..74863aaebf53 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -276,9 +276,12 @@ EXPORT_SYMBOL(bio_reset);
 static struct bio *__bio_chain_endio(struct bio *bio)
 {
 	struct bio *parent = bio->bi_private;
+	unsigned long flags;
 
+	spin_lock_irqsave(&parent->bi_lock, flags);
 	if (!parent->bi_status)
 		parent->bi_status = bio->bi_status;
+	spin_unlock_irqrestore(&parent->bi_lock, flags);
 	bio_put(bio);
 	return parent;
 }
diff --git a/block/blk-core.c b/block/blk-core.c
index fc60ff208497..362653e937ff 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -241,8 +241,12 @@ static void print_req_error(struct request *req, blk_status_t status,
 static void req_bio_endio(struct request *rq, struct bio *bio,
 			  unsigned int nbytes, blk_status_t error)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&bio->bi_lock, flags);
 	if (error)
 		bio->bi_status = error;
+	spin_unlock_irqrestore(&bio->bi_lock, flags);
 
 	if (unlikely(rq->rq_flags & RQF_QUIET))
 		bio_set_flag(bio, BIO_QUIET);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index db026b6ec15a..c3d50ad99510 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -231,6 +231,7 @@ struct bio {
 	unsigned short		bi_ioprio;
 	unsigned short		bi_write_hint;
 	blk_status_t		bi_status;
+	spinlock_t		bi_lock;
 	atomic_t		__bi_remaining;
 
 	struct bvec_iter	bi_iter;
-- 
2.25.4

