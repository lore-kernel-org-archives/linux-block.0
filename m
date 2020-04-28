Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582E8C83004
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 11:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D66206D6
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 11:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L0HvvhNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD1L2B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgD1L2B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 07:28:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634CFC03C1A9
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2020 04:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CV+vrDVGO83UcdaLZ7/fyxufNJM2DWLWM3D7E5GvzJ8=; b=L0HvvhNnOIORGZ4O5wJ+K4+tVu
        tVaAgdn6KO0fJ2k5SalwXshS5ym7j1MaZDI/3teCMZuDhq5eLSmE/2wJZcMzPlTfiwTs+gBqAqx4q
        ZKrj3/13RMMpje3r+wrlPOSjhf2uw7XmbOViOH9+dFJqFEHT3sN+9cGlWgBw8iLcB3La05rB32kbn
        s3l55k7uGo7Vr8izppXydOs6kY/HwmWU+nfNYxyef4TJ7Ehss0F7Lp+3TkWv40VcltDC9J7/8zbB2
        MdPsQ8zSDuC3kmA+Y55mDhxmYOqIMNNWXYxRadpU8qV3YZFk1EslGi6xZjgEJh6ji9xcfxnjC4Wt8
        2abaGgcA==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTOPA-0002gZ-EN; Tue, 28 Apr 2020 11:28:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     hannes@cmpxchg.org, linux-block@vger.kernel.org
Subject: [PATCH 1/4] block: improve the submit_bio and generic_make_request documentation
Date:   Tue, 28 Apr 2020 13:27:53 +0200
Message-Id: <20200428112756.1892137-2-hch@lst.de>
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
2.26.2

