Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8299C2D0E4
	for <linux-block@archiver.kernel.org>; Mon, 23 Nov 2020 08:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A67204EF
	for <linux-block@archiver.kernel.org>; Mon, 23 Nov 2020 08:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgKWIAq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Nov 2020 03:00:46 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:46348 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726991AbgKWIAq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 03:00:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UGDrsux_1606118440;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UGDrsux_1606118440)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 23 Nov 2020 16:00:40 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com,
        ming.lei@redhat.com, hch@infradead.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH v5] block: disable iopoll for split bio
Date:   Mon, 23 Nov 2020 16:00:20 +0800
Message-Id: <20201123080020.64667-1-jefflexu@linux.alibaba.com>
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
split bio.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 block/bio.c               |  2 ++
 block/blk-merge.c         | 10 ++++++++++
 block/blk-mq.c            |  2 +-
 include/linux/blk_types.h |  1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index fa01bef35bb1..d21e49f81bd2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -684,6 +684,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	bio_set_flag(bio, BIO_CLONED);
 	if (bio_flagged(bio_src, BIO_THROTTLED))
 		bio_set_flag(bio, BIO_THROTTLED);
+	if (bio_flagged(bio_src, BIO_NONE_COOKIE))
+		bio_set_flag(bio, BIO_NONE_COOKIE);
 	bio->bi_opf = bio_src->bi_opf;
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_write_hint = bio_src->bi_write_hint;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index bcf5e4580603..d86b6679c405 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -279,6 +279,16 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	return NULL;
 split:
 	*segs = nsegs;
+
+	/*
+	 * Bio splitting may cause subtle trouble such as hang
+	 * when doing sync iopoll in direct IO routine. Given
+	 * performance gain of iopoll for big IO can be trival,
+	 * disable iopoll when split needed.
+	 */
+	bio->bi_opf &= ~REQ_HIPRI;
+	bio_set_flag(bio, BIO_NONE_COOKIE);
+
 	return bio_split(bio, sectors, GFP_NOIO, bs);
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55bcee5dc032..46dcbaf989a6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2265,7 +2265,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 		blk_mq_sched_insert_request(rq, false, true, true);
 	}
 
-	return cookie;
+	return bio_flagged(bio, BIO_NONE_COOKIE) ? BLK_QC_T_NONE : cookie;
 queue_exit:
 	blk_queue_exit(q);
 	return BLK_QC_T_NONE;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d9b69bbde5cc..938fd25d2c68 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -284,6 +284,7 @@ enum {
 				 * of this bio. */
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
+	BIO_NONE_COOKIE,	/* disable iopoll for split bio */
 	BIO_FLAG_LAST
 };
 
-- 
2.27.0

