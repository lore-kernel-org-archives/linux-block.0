Return-Path: <SRS0=DF0J=BY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E931DC433E1
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 06:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C392820829
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 06:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y/PDeELN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgHNGhe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgHNGhd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Aug 2020 02:37:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DDBC061757
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2020 23:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4ewHs5PUhm87BjZjuFsJrtIXKeUhl9GOfzykGRYvbJk=; b=Y/PDeELN38d00lLJl/3CxCIVB7
        /rQeWUA/ToC1Rxjzzp3hAkCQhXne5jjS4Xw9uhSTODzmw3vbWSoIfkVdFAq0PtuKNngTQqOXtxmUa
        vEA3UUihyANqC3G2/zA96tkASLXWy8hdZ9aQzOMFEoLhUk3FFZKCv1Eec/277eNoHugyZShPqLDXe
        8DVjdkNUGBAhp6fbV3VogmU1vEr4rgeIVDZQSCoU4QlZwD7YLxB+AO7yr0522pNRCpb0Os/e2b8NI
        C5r6h71ioBVTDGtIK3IpR5wkjsXXNTQvGpZR8qzDuIYlu07KD1BKabn2FD0DcgW6gB44boy9XWgkp
        jgf/sO+Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6TLH-0006rA-NL; Fri, 14 Aug 2020 06:37:31 +0000
Date:   Fri, 14 Aug 2020 07:37:31 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritika Srivastava <ritika.srivastava@oracle.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v2 2/2] block: return BLK_STS_NOTSUPP if operation is not
 supported
Message-ID: <20200814063731.GA26356@infradead.org>
References: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
 <1596062878-4238-3-git-send-email-ritika.srivastava@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596062878-4238-3-git-send-email-ritika.srivastava@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The concept looks fine, but some of the formatting especially in the
comments is strange.  Also we should not print the message for this
case, but just the real error.  Updated version with my suggestions
below.

Also don't you need a third patch that makes dm-multipath stop sending
Write Same/Zeroes command when this happens?

---
From c056b0523173f17cd3d8ca77a8cfca4e45fe8cb7 Mon Sep 17 00:00:00 2001
From: Ritika Srivastava <ritika.srivastava@oracle.com>
Date: Wed, 29 Jul 2020 15:47:58 -0700
Subject: block: better deal with the delayed not supported case in
 blk_cloned_rq_check_limits

If WRITE_ZERO/WRITE_SAME operation is not supported by the storage,
blk_cloned_rq_check_limits() will return IO error which will cause
device-mapper to fail the paths.

Instead, if the queue limit is set to 0, return BLK_STS_NOTSUPP.
BLK_STS_NOTSUPP will be ignored by device-mapper and will not fail the
paths.

Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ritika Srivastava <ritika.srivastava@oracle.com>
---
 block/blk-core.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index e04ee2c8da2e95..81b830c24b5b4f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1296,10 +1296,21 @@ EXPORT_SYMBOL(submit_bio);
 static blk_status_t blk_cloned_rq_check_limits(struct request_queue *q,
 				      struct request *rq)
 {
-	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, req_op(rq))) {
+	unsigned int max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
+
+	if (blk_rq_sectors(rq) > max_sectors) {
+		/*
+		 * At least SCSI device do not have a good way to return if
+		 * Write Same is actually supported.  So we first try to issue
+		 * one and if it fails clear the max sectors value on failure.
+		 * If this occurs onthe lower device we need to propagate the
+		 * right error code up.
+		 */
+		if (max_sectors == 0)
+			return BLK_STS_NOTSUPP;
+
 		printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
-			__func__, blk_rq_sectors(rq),
-			blk_queue_get_max_sectors(q, req_op(rq)));
+			__func__, blk_rq_sectors(rq), max_sectors);
 		return BLK_STS_IOERR;
 	}
 
@@ -1326,8 +1337,11 @@ static blk_status_t blk_cloned_rq_check_limits(struct request_queue *q,
  */
 blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *rq)
 {
-	if (blk_cloned_rq_check_limits(q, rq))
-		return BLK_STS_IOERR;
+	blk_status_t ret;
+
+	ret = blk_cloned_rq_check_limits(q, rq);
+	if (ret != BLK_STS_OK)
+		return ret;
 
 	if (rq->rq_disk &&
 	    should_fail_request(&rq->rq_disk->part0, blk_rq_bytes(rq)))
-- 
2.28.0

