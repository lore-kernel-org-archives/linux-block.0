Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6260FC48BD6
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 13:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327A921670
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 13:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SiWDFke1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfFZNtr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:49:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFZNtr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 09:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bg7sGOYlKwRqYVikIXXfaNZYUNxNnN0MDugk/1Lh2fQ=; b=SiWDFke1lG+gUG1b0njrxzYCwY
        oB5uwlAXV1AFQp/84ilqUteoj3BzATNuriH1MbU693hxTdsTKjDeN//LTGSe2DcQPJF0Y4nmkTtEv
        GKKfUhsZZUIcvSsMvEPLeU6aOIZZr2lUGIX+GyxqhSgMbSYD93GUS/G2TjuPDWagtjNS/5dIjktjW
        pVZ+AjPe6Jmqw2kVv/uD7PoRF/3Qv5RH1z2ABb5tdGlZjTQWtVs9yHRFrCwr7zWbKOYxHPeRBC34v
        behebxAowgosWyN87VfrH9BQpCjoCYQcFJr3monj9EgkcTuyX61Kw3EEQr5uA5O83wAv71GdtShFx
        DwBoe7HA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg8J0-0003Dl-SJ; Wed, 26 Jun 2019 13:49:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 7/9] block_dev: use bio_release_pages in bio_unmap_user
Date:   Wed, 26 Jun 2019 15:49:26 +0200
Message-Id: <20190626134928.7988-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626134928.7988-1-hch@lst.de>
References: <20190626134928.7988-1-hch@lst.de>
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
 fs/block_dev.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index a6572a811880..f00b569a9f89 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -203,13 +203,12 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 {
 	struct file *file = iocb->ki_filp;
 	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
-	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs, *bvec;
+	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs;
 	loff_t pos = iocb->ki_pos;
 	bool should_dirty = false;
 	struct bio bio;
 	ssize_t ret;
 	blk_qc_t qc;
-	struct bvec_iter_all iter_all;
 
 	if ((pos | iov_iter_alignment(iter)) &
 	    (bdev_logical_block_size(bdev) - 1))
@@ -259,13 +258,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	}
 	__set_current_state(TASK_RUNNING);
 
-	bio_for_each_segment_all(bvec, &bio, iter_all) {
-		if (should_dirty && !PageCompound(bvec->bv_page))
-			set_page_dirty_lock(bvec->bv_page);
-		if (!bio_flagged(&bio, BIO_NO_PAGE_REF))
-			put_page(bvec->bv_page);
-	}
-
+	bio_release_pages(&bio, should_dirty);
 	if (unlikely(bio.bi_status))
 		ret = blk_status_to_errno(bio.bi_status);
 
-- 
2.20.1

