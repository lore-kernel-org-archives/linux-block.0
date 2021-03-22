Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA0DC433C1
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 07:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D2C61930
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 07:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCVHjM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 03:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhCVHiy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 03:38:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFF4C061574
        for <linux-block@vger.kernel.org>; Mon, 22 Mar 2021 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LPpAEJDzmufdcoHvyDzkNMH6hO0chhf3uoTJ8hwYRok=; b=u8VsPfjMYb970wglnBMT0YFbf6
        X7VNN1Qv83hYRbuZCndyiYVfaPcM8sZHjMX3yt13TEbQCv5dENHmV8MixscDHMSkCCwWiUh3T9nb3
        AN6c1REyH9yDJgmJUu0tm6b8x3uVGfy/3Fxafjxs8TUkdMI3W+cfjyqVvQqpVtPAXh2wv5ZJ8S5na
        4QrLyEMarNjQ7C33OPatBx85BK1qVOzsdsLgagjbKTW7Q4tPR3i30dQPn4AnsjlDCFX3dPIDBKUrb
        cPGsp+gIuHW3R+Pg561ggs8cupxjD55zZT4zzj9l8Kwgi0HHOJP7nJwLdWKUBdBIA3d7fubVsk3bh
        sQPZHTYA==;
Received: from [2001:4bb8:180:4ea2:5b87:a441:96f6:10e9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOF8d-0089sB-Ql; Mon, 22 Mar 2021 07:38:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the underlying device
Date:   Mon, 22 Mar 2021 08:37:26 +0100
Message-Id: <20210322073726.788347-3-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210322073726.788347-1-hch@lst.de>
References: <20210322073726.788347-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we reset/teardown a controller, we must freeze and quiesce the
namespaces request queues to make sure that we safely stop inflight I/O
submissions. Freeze is mandatory because if our hctx map changed between
reconnects, blk_mq_update_nr_hw_queues will immediately attempt to freeze
the queue, and if it still has pending submissions (that are still
quiesced) it will hang.

However, by freezing the namespaces request queues, and only unfreezing
them when we successfully reconnect, inflight submissions that are
running concurrently can now block grabbing the nshead srcu until either
we successfully reconnect or ctrl_loss_tmo expired (or the user
explicitly disconnected).

This caused a deadlock when a different controller (different path on the
same subsystem) became live (i.e. optimized/non-optimized). This is
because nvme_mpath_set_live needs to synchronize the nshead srcu before
requeueing I/O in order to make sure that current_path is visible to
future (re-)submisions. However the srcu lock is taken by a blocked
submission on a frozen request queue, and we have a deadlock.

In order to fix this use the blk_mq_submit_bio_direct API to submit the
bio to the low-level driver, which does not block on the queue free
but instead allows nvme-multipath to pick another path or queue up the
bio.

Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")

Reported-by Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/multipath.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a1d476e1ac020f..92adebfaf86fd1 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -309,6 +309,7 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 	 */
 	blk_queue_split(&bio);
 
+retry:
 	srcu_idx = srcu_read_lock(&head->srcu);
 	ns = nvme_find_path(head);
 	if (likely(ns)) {
@@ -316,7 +317,12 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 		bio->bi_opf |= REQ_NVME_MPATH;
 		trace_block_bio_remap(bio, disk_devt(ns->head->disk),
 				      bio->bi_iter.bi_sector);
-		ret = submit_bio_noacct(bio);
+
+		if (!blk_mq_submit_bio_direct(bio, &ret)) {
+			nvme_mpath_clear_current_path(ns);
+			srcu_read_unlock(&head->srcu, srcu_idx);
+			goto retry;
+		}
 	} else if (nvme_available_path(head)) {
 		dev_warn_ratelimited(dev, "no usable path - requeuing I/O\n");
 
-- 
2.30.1

