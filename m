Return-Path: <SRS0=+SaT=EC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB6CC55179
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 13:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B0120829
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 13:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900720AbgJ0NaW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Oct 2020 09:30:22 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:40172 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2900708AbgJ0NaW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 09:30:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UDNQijJ_1603805411;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0UDNQijJ_1603805411)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 27 Oct 2020 21:30:18 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, joseph.qi@linux.alibaba.com
Subject: [RFC] blk-mq: don't plug for HIPRI IO
Date:   Tue, 27 Oct 2020 21:29:51 +0800
Message-Id: <20201027132951.121812-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit cb700eb3faa4 ("block: don't plug for aio/O_DIRECT HIPRI IO")
only does not call blk_start_plug() or blk_finish_plug for HIPRI IO
in __blkdev_direct_IO(), but if upper layer subsystem, such as io_uring,
still initializes valid plug, block layer may still plug HIPRI IO.
To disable plug for HIPRI IO completely, do it in blk_mq_plug().

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 block/blk-mq.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index a52703c..5453d14 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -272,9 +272,11 @@ static inline struct blk_plug *blk_mq_plug(struct request_queue *q,
 {
 	/*
 	 * For regular block devices or read operations, use the context plug
-	 * which may be NULL if blk_start_plug() was not executed.
+	 * which may be NULL if blk_start_plug() was not executed, and don't
+	 * plug for HIPRI/polled IO, as those should go straight to issue.
 	 */
-	if (!blk_queue_is_zoned(q) || !op_is_write(bio_op(bio)))
+	if (!(bio->bi_opf & REQ_HIPRI) &&
+	    (!blk_queue_is_zoned(q) || !op_is_write(bio_op(bio))))
 		return current->plug;
 
 	/* Zoned block device write operation case: do not plug the BIO */
-- 
1.8.3.1

