Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9F0C55194
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 17:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D05C2078E
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 17:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HpYVTlXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgDYRJw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726146AbgDYRJv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 13:09:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5C7C09B04D
        for <linux-block@vger.kernel.org>; Sat, 25 Apr 2020 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MhYm2rmlkK+w+Dg4/VRmChjYWg4cD/xUyM6piVv1os0=; b=HpYVTlXCkwSLIxVZRT04kqCER7
        BqXeXB38kJFpk26inb2UOVJQ8JAdrDM9/lZrOpiglWrEMslffmgKInI/WLu3vI6jSS9IzQLTpZqkY
        X/Z7yr79epnWWEkfsOrnHBE8E6/9KEPihLmes9pz4vGHE6dmhAv7Tv53WyzOqrtuq7FmgzjHAE8t5
        VmbF/eHKLMyuA+aX9i2BZS+hzyKhLgJe+SUvU/p8uvDA+zuRiUtupTWP1XvZ9C7YQtpeUxO0b2llr
        cB2RYcNHA1YzMESf3HevstZDBVJKlCGRjQmipAiajEbUqvgqEVu22MakCMTyf/jt9xpJeevwhtL1X
        08FA6gKw==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSOJI-0001i8-SS; Sat, 25 Apr 2020 17:09:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 01/11] block: improve the kerneldoc comments for submit_bio and generic_make_request
Date:   Sat, 25 Apr 2020 19:09:34 +0200
Message-Id: <20200425170944.968861-2-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200425170944.968861-1-hch@lst.de>
References: <20200425170944.968861-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The current documentation is a little weird, as it doesn't clearly
explain which function to use, and also has the guts of the information
on generic_make_request, which is the internal interface for stacking
drivers.

Fix this up by properly documenting submit_bio, and only documenting
the differences and the use case for generic_make_request.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index dffff21008886..68351ee94ad2e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -992,28 +992,13 @@ generic_make_request_checks(struct bio *bio)
 }
 
 /**
- * generic_make_request - hand a buffer to its device driver for I/O
+ * generic_make_request - re-submit a bio to the block device layer for I/O
  * @bio:  The bio describing the location in memory and on the device.
  *
- * generic_make_request() is used to make I/O requests of block
- * devices. It is passed a &struct bio, which describes the I/O that needs
- * to be done.
- *
- * generic_make_request() does not return any status.  The
- * success/failure status of the request, along with notification of
- * completion, is delivered asynchronously through the bio->bi_end_io
- * function described (one day) else where.
- *
- * The caller of generic_make_request must make sure that bi_io_vec
- * are set to describe the memory buffer, and that bi_dev and bi_sector are
- * set to describe the device address, and the
- * bi_end_io and optionally bi_private are set to describe how
- * completion notification should be signaled.
- *
- * generic_make_request and the drivers it calls may use bi_next if this
- * bio happens to be merged with someone else, and may resubmit the bio to
- * a lower device by calling into generic_make_request recursively, which
- * means the bio should NOT be touched after the call to ->make_request_fn.
+ * This is a version of submit_bio() that shall only be used for I/O that is
+ * resubmitted to lower level drivers by stacking block drivers.  All file
+ * systems and other upper level users of the block layer should use
+ * submit_bio() instead.
  */
 blk_qc_t generic_make_request(struct bio *bio)
 {
@@ -1152,10 +1137,14 @@ EXPORT_SYMBOL_GPL(direct_make_request);
  * submit_bio - submit a bio to the block device layer for I/O
  * @bio: The &struct bio which describes the I/O
  *
- * submit_bio() is very similar in purpose to generic_make_request(), and
- * uses that function to do most of the work. Both are fairly rough
- * interfaces; @bio must be presetup and ready for I/O.
+ * submit_bio() is used to submit I/O requests to block devices.  It is passed a
+ * fully set up &struct bio that describes the I/O that needs to be done.  The
+ * bio will be send to the device described by the bi_disk and bi_partno fields.
  *
+ * The success/failure status of the request, along with notification of
+ * completion, is delivered asynchronously through the ->bi_end_io() callback
+ * in @bio.  The bio must NOT be touched by thecaller until ->bi_end_io() has
+ * been called.
  */
 blk_qc_t submit_bio(struct bio *bio)
 {
-- 
2.26.1

