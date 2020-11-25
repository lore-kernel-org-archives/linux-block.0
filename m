Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3917C6379D
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 13:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 749AA206E5
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 13:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgKYNnl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 08:43:41 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:40344 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729594AbgKYNnk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 08:43:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UGWBy5N_1606311815;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UGWBy5N_1606311815)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Nov 2020 21:43:35 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com,
        ming.lei@redhat.com, hch@infradead.org
Subject: [PATCH v7] block: disable iopoll for split bio
Date:   Wed, 25 Nov 2020 21:43:35 +0800
Message-Id: <20201125134335.63479-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

iopoll is initially for small size, latency sensitive IO. It doesn't
work well for big IO, especially when it needs to be split to multiple
bios. In this case, the returned cookie of __submit_bio_noacct_mq() is
indeed the cookie of the last split bio. The completion of *this* last
split bio done by iopoll doesn't mean the whole original bio has
completed. Callers of iopoll still need to wait for completion of other
split bios.

Besides bio splitting may cause more trouble for iopoll which isn't
supposed to be used in case of big IO.

iopoll for split bio may cause potential race if CPU migration happens
during bio submission. Since the returned cookie is that of the last
split bio, polling on the corresponding hardware queue doesn't help
complete other split bios, if these split bios are enqueued into
different hardware queues. Since interrupts are disabled for polling
queues, the completion of these other split bios depends on timeout
mechanism, thus causing a potential hang.

iopoll for split bio may also cause hang for sync polling. Currently
both the blkdev and iomap-based fs (ext4/xfs, etc) support sync polling
in direct IO routine. These routines will submit bio without REQ_NOWAIT
flag set, and then start sync polling in current process context. The
process may hang in blk_mq_get_tag() if the submitted bio has to be
split into multiple bios and can rapidly exhaust the queue depth. The
process are waiting for the completion of the previously allocated
requests, which should be reaped by the following polling, and thus
causing a deadlock.

To avoid these subtle trouble described above, just disable iopoll for
split bio and return BLK_QC_T_NONE in this case. The side effect is that
non-HIPRI IO also returns BLK_QC_T_NONE now. It should be acceptable
since the returned cookie is never used for non-HIPRI IO.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 block/blk-merge.c | 8 ++++++++
 block/blk-mq.c    | 6 +++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index bcf5e4580603..8a2f1fb7bb16 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -279,6 +279,14 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	return NULL;
 split:
 	*segs = nsegs;
+
+	/*
+	 * Bio splitting may cause subtle trouble such as hang when doing sync
+	 * iopoll in direct IO routine. Given performance gain of iopoll for
+	 * big IO can be trival, disable iopoll when split needed.
+	 */
+	bio->bi_opf &= ~REQ_HIPRI;
+
 	return bio_split(bio, sectors, GFP_NOIO, bs);
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55bcee5dc032..4acd702575cd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2265,7 +2265,11 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 		blk_mq_sched_insert_request(rq, false, true, true);
 	}
 
-	return cookie;
+	if (bio->bi_opf & REQ_HIPRI)
+		return cookie;
+
+	return BLK_QC_T_NONE;
+
 queue_exit:
 	blk_queue_exit(q);
 	return BLK_QC_T_NONE;
-- 
2.27.0

