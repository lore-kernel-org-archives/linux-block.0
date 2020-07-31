Return-Path: <SRS0=FZnh=BK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3A3C433DF
	for <linux-block@archiver.kernel.org>; Fri, 31 Jul 2020 01:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B924A2083E
	for <linux-block@archiver.kernel.org>; Fri, 31 Jul 2020 01:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2QuW0Ljh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgGaBmr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 21:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731091AbgGaBmp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 21:42:45 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14106C061574;
        Thu, 30 Jul 2020 18:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Tnw4CXdFxPZH/HgogWPLP+vk9CL2uhkCX8j4Qgf27Xc=; b=2QuW0Ljh64tW4qP+PBp2dTY6wb
        L3lWErDiQqUkNoMeHusi1mTO28pSWrwq9crQu4S2/RXaZJTLy4T0eotYEroBqZI5bTpBzwwv053zQ
        eu69HUEuw0N5SUGlUqlG9jYRecigRtbAQZt1Ce7olBhSjWME4PXeENSjv+UiXMMKsTzzdfb5Z0dWz
        9Vw9KbLqmvlZTQWhC6XIZEDMLDpvXI8zrd59Jn/EQpzl/5YOZHQBBkPV4EPEkgw9cdU/OOLYl0QTH
        C3iDeoxhKxVy9SN9B+i+VvuMSyQ7Z8UVD73wbbqvnwgCUwhynw5aInQ7rUwa/og2xo4rTtNIgq5X6
        RfzlNMLg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1K4I-0006bc-LO; Fri, 31 Jul 2020 01:42:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH 2/7] block: bio: delete duplicated words
Date:   Thu, 30 Jul 2020 18:42:28 -0700
Message-Id: <20200731014233.6418-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200731014233.6418-1-rdunlap@infradead.org>
References: <20200731014233.6418-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drop the repeated words "a" and "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 block/bio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200730.orig/block/bio.c
+++ linux-next-20200730/block/bio.c
@@ -862,7 +862,7 @@ EXPORT_SYMBOL(bio_add_pc_page);
  * @same_page: return if the segment has been merged inside the same page
  *
  * Try to add the data at @page + @off to the last bvec of @bio.  This is a
- * a useful optimisation for file systems with a block size smaller than the
+ * useful optimisation for file systems with a block size smaller than the
  * page size.
  *
  * Warn if (@len, @off) crosses pages in case that @same_page is true.
@@ -988,7 +988,7 @@ static int __bio_iov_bvec_add_pages(stru
  * Pins pages from *iter and appends them to @bio's bvec array. The
  * pages will have to be released using put_page() when done.
  * For multi-segment *iter, this function only adds pages from the
- * the next non-empty segment of the iov iterator.
+ * next non-empty segment of the iov iterator.
  */
 static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
