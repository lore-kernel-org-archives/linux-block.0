Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9255C04AAA
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 23:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24822085A
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 23:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MucrZaCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfEBXeS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 19:34:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfEBXeS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 19:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MPCO9CbAbUArb/9WNeILhBS9zt4i1qERt0qBnjRtDpI=; b=MucrZaCrAiw7FNIP+SUbxnFoeb
        DKQjhQSyOhmr2XlsXwErVfOs7tZ+jw5R4EEObzJOYE1h6wZSfUZSN3EPaGrDaJRzoYbRievuWIUpg
        6FpDB+5RKmeUPlCzKK4cGZviCIx0fWjTNqNYyjMoIVCVH9YCpSZGCSSWnu+c1s7hKxZcX1h+/Ulde
        WJmIPuehSXH9VUpeJvL3jh0mVyJu3m4r/HVRTjvx9hmu8xLZijprMSBP/hgwd9rgIxJpsfm/1AfsV
        Vm5Mt29MXPqi4S7ZkNa/X8FU12WRYZ4CSj7qb855QFvCvIX/0C69S147JiPiFDKXJyPS1Q/ZzrcGI
        9oI2r3ig==;
Received: from [12.246.51.142] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMLDV-0002mZ-Gg; Thu, 02 May 2019 23:34:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 5/8] block_dev: use bio_release_pages in blkdev_bio_end_io
Date:   Thu,  2 May 2019 19:33:29 -0400
Message-Id: <20190502233332.28720-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502233332.28720-1-hch@lst.de>
References: <20190502233332.28720-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use bio_release_pages instead of duplicating it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 8abc6570d29f..a59ebea9d125 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -335,13 +335,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 	if (should_dirty) {
 		bio_check_pages_dirty(bio);
 	} else {
-		if (!bio_flagged(bio, BIO_NO_PAGE_REF)) {
-			struct bvec_iter_all iter_all;
-			struct bio_vec *bvec;
-
-			bio_for_each_segment_all(bvec, bio, iter_all)
-				put_page(bvec->bv_page);
-		}
+		bio_release_pages(bio);
 		bio_put(bio);
 	}
 }
-- 
2.20.1

