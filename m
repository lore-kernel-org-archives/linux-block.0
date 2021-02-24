Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C250C433E9
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 07:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ECCB64ED0
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 07:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhBXHam (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 02:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhBXHaf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 02:30:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB25C06178B
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 23:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YwAECrJsQc/I0ewRTHP69YHTuIXL5c6zJMWOZM3xvcs=; b=pj7A874z6f69+zhWptTFAs0hSI
        1k4nEEAY2Ji/aHS46fOmSTc1x0uvA1BMOFTUJQVDuh7otlXQ9R/60ufBJllL7z1PRZVXh/HdX9mKP
        bHpvOKZz2UjsEUpTsDgzNVnvmJm61Pw8DulfCWJTe4867XLqAUigsAerW041q6b4kuyYSBi3svBWC
        rLVh/JAy6YCNx4vuULswXADtNf5PEttnUSay5ziBDZcBnxBOjzExuNAA/ThWUNIz3q5D5BD5BmMtn
        udAG1KrH+owgOjkTmkjBJDCbB4RQHqZtl3sG1QrNNQUNV451Z1iKI5SoHYBN+XqO7AhXJw84IbBhV
        oKn3qXlQ==;
Received: from [2001:4bb8:188:6508:b7b:4fb9:de1e:2c81] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lEoc4-0096iv-TR; Wed, 24 Feb 2021 07:29:39 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 4/4] block: memory allocations in bounce_clone_bio must not fail
Date:   Wed, 24 Feb 2021 08:24:07 +0100
Message-Id: <20210224072407.46363-5-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224072407.46363-1-hch@lst.de>
References: <20210224072407.46363-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The caller can't cope with a failure from bounce_clone_bio, so
use __GFP_NOFAIL for the passthrough case.  bio_alloc_bioset already
won't fail due to the use of mempools.

And yes, we need to get rid of this bock layer bouncing code entirely
sooner or later..

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bounce.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bounce.c b/block/bounce.c
index 417faaac36b691..87983a35079c22 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -242,12 +242,11 @@ static struct bio *bounce_clone_bio(struct bio *bio_src)
 	 *    __bio_clone_fast() anyways.
 	 */
 	if (bio_is_passthrough(bio_src))
-		bio = bio_kmalloc(GFP_NOIO, bio_segments(bio_src));
+		bio = bio_kmalloc(GFP_NOIO | __GFP_NOFAIL,
+				  bio_segments(bio_src));
 	else
 		bio = bio_alloc_bioset(GFP_NOIO, bio_segments(bio_src),
 				       &bounce_bio_set);
-	if (!bio)
-		return NULL;
 	bio->bi_bdev		= bio_src->bi_bdev;
 	if (bio_flagged(bio_src, BIO_REMAPPED))
 		bio_set_flag(bio, BIO_REMAPPED);
-- 
2.29.2

