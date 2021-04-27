Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C5FC43470
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 16:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE8061158
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 16:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbhD0QVY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Apr 2021 12:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbhD0QTe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Apr 2021 12:19:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4FAC061760;
        Tue, 27 Apr 2021 09:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9SbBr1by35FoFBLhYEbZYkU7Qe9kHfjLM/wxBmc4fMU=; b=0vdWoXRolKpeBBk0GTzNEVXHuH
        359fOdlNRQX5sEcyT5YY+c+hjUgaiCHwwPEROn29PFnE7LnQ2SpQLSsahYEvirq/uBJDoUyfkkfKu
        dpgQTRQXXLM0sWMjUrimDLs8qgtPjRB5ZRtnxn3inynNAI0zWg0tBxuVxdwBSQvCH3Se+fWZAZU/x
        8+vUCyn2kaBct6YJU9QtgYjMu+IJnhuwlncWJwyxqGzcilsR8Wlb9TAgnwy5h4TSD27xsMD5+t04x
        Vf2JC/kOQTug3VKVZgpEd+D16vaodefMI7v6DpQ8Xvb6juvN/mHKJvx9RD/eZz6t+nf5VkgS5mJCP
        VG1oefiA==;
Received: from [2001:4bb8:18c:28b2:c772:7205:2aa4:840d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbQQ7-00Gr4E-5d; Tue, 27 Apr 2021 16:18:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/15] iomap: don't try to poll multi-bio I/Os in __iomap_dio_rw
Date:   Tue, 27 Apr 2021 18:16:07 +0200
Message-Id: <20210427161619.1294399-4-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210427161619.1294399-1-hch@lst.de>
References: <20210427161619.1294399-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If an iocb is split into multiple bios we can't poll for both.  So don't
bother to even try to poll in that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bdd0d89bbf0a..357419f39654 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -282,6 +282,13 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 	if (!iov_iter_count(dio->submit.iter))
 		goto out;
 
+	/*
+	 * We can only poll for single bio I/Os.
+	 */
+	if (need_zeroout ||
+	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode)))
+		dio->iocb->ki_flags &= ~IOCB_HIPRI;
+
 	if (need_zeroout) {
 		/* zero out from the start of the block to the write offset */
 		pad = pos & (fs_block_size - 1);
@@ -339,6 +346,11 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 
 		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
 						 BIO_MAX_VECS);
+		/*
+		 * We can only poll for single bio I/Os.
+		 */
+		if (nr_pages)
+			dio->iocb->ki_flags &= ~IOCB_HIPRI;
 		iomap_dio_submit_bio(dio, iomap, bio, pos);
 		pos += n;
 	} while (nr_pages);
@@ -571,6 +583,11 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			iov_iter_revert(iter, pos - dio->i_size);
 			break;
 		}
+
+		/*
+		 * We can only poll for single bio I/Os.
+		 */
+		iocb->ki_flags &= ~IOCB_HIPRI;
 	} while ((count = iov_iter_count(iter)) > 0);
 	blk_finish_plug(&plug);
 
-- 
2.30.1

