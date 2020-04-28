Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5B6C83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 11:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AFC6206D7
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 11:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZN/mK16O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgD1L2D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgD1L2D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 07:28:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B66C03C1A9
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2020 04:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mvF8GX2l2ew3MNCy7WclmW2es+TXBF3Sq2eqxYDJVlQ=; b=ZN/mK16ODI3B4hLYKxM/biw6yd
        412dPqtsDCX5ttoTyjJxL4SbosOdbUkfPcopV/4txKYAJOtEauj1inb013fVlQyBEuqA7lOhIgvJ1
        H6bG0acvo5sWjUq/tCvWQT75aTLbsQfnMqTT9AS0IhE/9mK1M/r5AkKahALP96TpEuMi/ZA67rey1
        6LZcUc0hJOJcS7+vH7gwq3z7VZR1PLRCf630ElRvD7Okq4G+eFtI+Z33qgpooYQMgy1JeDOre91pI
        U/3LumUdJtGsGdf5XlZWCdfUj1JVQYYmWClJlkCqAdzsYjFJStTK2rKxwI22iDYvPkJvrhZ4ZIDcK
        Q8U902Nw==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTOPC-0002h6-Rb; Tue, 28 Apr 2020 11:28:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     hannes@cmpxchg.org, linux-block@vger.kernel.org
Subject: [PATCH 2/4] block: cleanup the memory stall accounting in submit_bio
Date:   Tue, 28 Apr 2020 13:27:54 +0200
Message-Id: <20200428112756.1892137-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428112756.1892137-1-hch@lst.de>
References: <20200428112756.1892137-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of a convoluted chain just check for REQ_OP_READ directly,
and keep all the memory stall code together in a single unlikely
branch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 68351ee94ad2e..81a291085c6ca 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1148,10 +1148,6 @@ EXPORT_SYMBOL_GPL(direct_make_request);
  */
 blk_qc_t submit_bio(struct bio *bio)
 {
-	bool workingset_read = false;
-	unsigned long pflags;
-	blk_qc_t ret;
-
 	if (blkcg_punt_bio_submit(bio))
 		return BLK_QC_T_NONE;
 
@@ -1170,8 +1166,6 @@ blk_qc_t submit_bio(struct bio *bio)
 		if (op_is_write(bio_op(bio))) {
 			count_vm_events(PGPGOUT, count);
 		} else {
-			if (bio_flagged(bio, BIO_WORKINGSET))
-				workingset_read = true;
 			task_io_account_read(bio->bi_iter.bi_size);
 			count_vm_events(PGPGIN, count);
 		}
@@ -1187,20 +1181,24 @@ blk_qc_t submit_bio(struct bio *bio)
 	}
 
 	/*
-	 * If we're reading data that is part of the userspace
-	 * workingset, count submission time as memory stall. When the
-	 * device is congested, or the submitting cgroup IO-throttled,
-	 * submission can be a significant part of overall IO time.
+	 * If we're reading data that is part of the userspace workingset, count
+	 * submission time as memory stall.  When the device is congested, or
+	 * the submitting cgroup IO-throttled, submission can be a significant
+	 * part of overall IO time.
 	 */
-	if (workingset_read)
-		psi_memstall_enter(&pflags);
-
-	ret = generic_make_request(bio);
+	if (unlikely(bio_op(bio) == REQ_OP_READ &&
+	    bio_flagged(bio, BIO_WORKINGSET))) {
+		unsigned long pflags;
+		blk_qc_t ret;
 
-	if (workingset_read)
+		psi_memstall_enter(&pflags);
+		ret = generic_make_request(bio);
 		psi_memstall_leave(&pflags);
 
-	return ret;
+		return ret;
+	}
+
+	return generic_make_request(bio);
 }
 EXPORT_SYMBOL(submit_bio);
 
-- 
2.26.2

