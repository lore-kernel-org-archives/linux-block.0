Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A16C43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 23:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0FA2085A
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 23:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TdjpCFyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfEBXeT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 19:34:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfEBXeT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 19:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wc8vXI6lDdLvvfsVezgROZYGbgl69qLi532tw1TdByo=; b=TdjpCFyVweddOJtEHog7XDcwGc
        wWoT6WjcjL1iuROU7VZgAWHjwUG5Tjys1j0+1h7Z0S0i9nLSgJzGACsQ/1UB15JJEnHaBvr4rE7al
        LY+ODTjTkBfiKwpuH0NZ17YGvxF8u8qIDF4cK5C+Trq9YI6tmIbJj+9dxEy2WePCffxK9T82ZxngJ
        3UHVwIeWPx5r+ZBmOEdE3RydoHqWxYjakZT55SpDXMJWmC+vQT4jtt5KMShujj6BWu8qd3KNFO2b4
        KRV8Cc9NyxxaEYzvmCX4LLeJtcZtk3VLLmHdbgZc3hf2c33Rr16zFXZer4X5O1j5/F736yEGXK8lG
        ECzgGnaA==;
Received: from [12.246.51.142] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMLDW-0002mf-KH; Thu, 02 May 2019 23:34:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 6/8] block_dev: use bio_release_pages in __blkdev_direct_IO_simple
Date:   Thu,  2 May 2019 19:33:30 -0400
Message-Id: <20190502233332.28720-7-hch@lst.de>
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

Use bio_release_pages instead of a manual put_pages loop that fails to
take BIO_NO_PAGE_REF into account.  Also use bio_set_pages_dirty for
the rest of the former loop to reduce code duplication.

Fixes: 399254aaf489 ("block: add BIO_NO_PAGE_REF flag")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index a59ebea9d125..4fc2377884a3 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -204,13 +204,12 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
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
@@ -260,11 +259,9 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	}
 	__set_current_state(TASK_RUNNING);
 
-	bio_for_each_segment_all(bvec, &bio, iter_all) {
-		if (should_dirty && !PageCompound(bvec->bv_page))
-			set_page_dirty_lock(bvec->bv_page);
-		put_page(bvec->bv_page);
-	}
+	if (should_dirty)
+		bio_set_pages_dirty(&bio);
+	bio_release_pages(&bio);
 
 	if (unlikely(bio.bi_status))
 		ret = blk_status_to_errno(bio.bi_status);
-- 
2.20.1

