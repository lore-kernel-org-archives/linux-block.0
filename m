Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA855C433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 10:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiBOKGF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 05:06:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiBOKGF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 05:06:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AB624F
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 02:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7rzMBCheXI6s6ZmGT/40NcplVoa+oeu+cZp5B+iU6Vk=; b=ZsSEGkOPwOp5GZ11N423WzJwb2
        h0IzNRuZKhh5tt+uFqD+F2bI9y6qF77J5qcGK77ZS9huB8swE2MoV3LbdLSagzMq6z5lju1i1fxz9
        MMHTp0j2BdsWimqdySOX3bIBbGv03XyUxlufrveawQDkhZvxqrHSIYE4T56HCgTh1FiLe9gOtjxzc
        QzsDVJDwmYvhFm86mXLgbv8zla10m9LAKrKIhtc1oUW1q/5Lm8w95unhfU9Ty4PouuoF1bPVL3359
        0Chp3Xz9JkFZeDzsdE5ofuQseHN9YssoDDhKSLaXf5c7Sw1nbsG6+G2sTndBbwJUjANxH3sDsi/NU
        H/RM4vRQ==;
Received: from [2001:4bb8:184:543c:6bdf:22f4:7f0a:fe97] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJuiX-002E4g-Gk; Tue, 15 Feb 2022 10:05:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 4/5] dm: remove useless code from dm_dispatch_clone_request
Date:   Tue, 15 Feb 2022 11:05:39 +0100
Message-Id: <20220215100540.3892965-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215100540.3892965-1-hch@lst.de>
References: <20220215100540.3892965-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Both ->start_time_ns and the RQF_IO_STAT are set when the request is
allocated using blk_mq_alloc_request by dm-mpath in blk_mq_rq_ctx_init.
The block layer also ensures ->start_time_ns is only set when actually
needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-rq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 2fcc9b7f391b3..8f6117342d322 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -307,10 +307,6 @@ static blk_status_t dm_dispatch_clone_request(struct request *clone, struct requ
 {
 	blk_status_t r;
 
-	if (blk_queue_io_stat(clone->q))
-		clone->rq_flags |= RQF_IO_STAT;
-
-	clone->start_time_ns = ktime_get_ns();
 	r = blk_insert_cloned_request(clone);
 	if (r != BLK_STS_OK && r != BLK_STS_RESOURCE && r != BLK_STS_DEV_RESOURCE)
 		/* must complete clone in terms of original request */
-- 
2.30.2

