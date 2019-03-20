Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2E4C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 08:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D522184D
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 08:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfCTIM5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:12:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:51652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727555AbfCTIM5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 04:12:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3394FAF56;
        Wed, 20 Mar 2019 08:12:56 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jan Kara <jack@suse.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH] block_dev: fix crash on chained bios with O_DIRECT
Date:   Wed, 20 Mar 2019 09:12:53 +0100
Message-Id: <20190320081253.129688-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__blkdev_direct_IO_simple() is allocating a bio on the stack.
When that bio needs to be split bio_chain_endio() invokes bio_put()
on this bio, causing the kernel to crash in mempool_free() as the
bio was never allocated from a mempool in the first place.
So call bio_get() before submitting to avoid this problem.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 fs/block_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index c546cdce77e6..4b3a04c3b8bd 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -235,6 +235,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_HIPRI)
 		bio.bi_opf |= REQ_HIPRI;
 
+	bio_get(&bio);
 	qc = submit_bio(&bio);
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
@@ -254,7 +255,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 
 	if (unlikely(bio.bi_status))
 		ret = blk_status_to_errno(bio.bi_status);
-
+	bio_put(&bio);
 out:
 	if (vecs != inline_vecs)
 		kfree(vecs);
-- 
2.16.4

