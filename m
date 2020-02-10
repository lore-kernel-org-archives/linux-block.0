Return-Path: <SRS0=SfBO=36=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69039C3B184
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 09:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D8B21775
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 09:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgBJJea (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:34:30 -0500
Received: from relay.sw.ru ([185.231.240.75]:59472 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbgBJJeM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Feb 2020 04:34:12 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j15Rm-0000Jd-Id; Mon, 10 Feb 2020 12:33:42 +0300
Subject: [PATCH v6 2/6] block: Pass op_flags into blk_queue_get_max_sectors()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     martin.petersen@oracle.com, bob.liu@oracle.com, axboe@kernel.dk
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, darrick.wong@oracle.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Mon, 10 Feb 2020 12:33:42 +0300
Message-ID: <158132722235.239613.17443829991733096212.stgit@localhost.localdomain>
In-Reply-To: <158132703141.239613.3550455492676290009.stgit@localhost.localdomain>
References: <158132703141.239613.3550455492676290009.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This preparation patch changes argument type, and now
the function takes full op_flags instead of just op code.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Reviewed-by: Bob Liu <bob.liu@oracle.com>
---
 block/blk-core.c       |    4 ++--
 include/linux/blkdev.h |    8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 089e890ab208..28a6d46eb982 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1221,10 +1221,10 @@ EXPORT_SYMBOL(submit_bio);
 static int blk_cloned_rq_check_limits(struct request_queue *q,
 				      struct request *rq)
 {
-	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, req_op(rq))) {
+	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, rq->cmd_flags)) {
 		printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
 			__func__, blk_rq_sectors(rq),
-			blk_queue_get_max_sectors(q, req_op(rq)));
+			blk_queue_get_max_sectors(q, rq->cmd_flags));
 		return -EIO;
 	}
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1e3c08854b09..f4ec7ae214ab 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -988,8 +988,10 @@ static inline struct bio_vec req_bvec(struct request *rq)
 }
 
 static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
-						     int op)
+						     unsigned int op_flags)
 {
+	int op = op_flags & REQ_OP_MASK;
+
 	if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
 		return min(q->limits.max_discard_sectors,
 			   UINT_MAX >> SECTOR_SHIFT);
@@ -1028,10 +1030,10 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 	if (!q->limits.chunk_sectors ||
 	    req_op(rq) == REQ_OP_DISCARD ||
 	    req_op(rq) == REQ_OP_SECURE_ERASE)
-		return blk_queue_get_max_sectors(q, req_op(rq));
+		return blk_queue_get_max_sectors(q, rq->cmd_flags);
 
 	return min(blk_max_size_offset(q, offset),
-			blk_queue_get_max_sectors(q, req_op(rq)));
+			blk_queue_get_max_sectors(q, rq->cmd_flags));
 }
 
 static inline unsigned int blk_rq_count_bios(struct request *rq)


