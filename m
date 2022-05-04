Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E92DC433FE
	for <linux-block@archiver.kernel.org>; Wed,  4 May 2022 14:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240792AbiEDOd3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 May 2022 10:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351321AbiEDOd2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 May 2022 10:33:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDC5275E8
        for <linux-block@vger.kernel.org>; Wed,  4 May 2022 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7E+qu5WE7gZh4ulQGbpSuKuemWRPaHiwe8MiYb+5YVM=; b=pWeBm9eFCltL6olX4AnSZa1YCQ
        wFDNCZItJmV3vyPKgP6yUn32NcQqsN/o+Iy+bu40UyOlm8WDI4BscNPf+cPj9i2GDOmyz9Iu9Ico9
        WBZsIRFJxYjnuPGUUg5xeKI4E1P4bJT2/LbQWzY0JIUgSrJdAGLHEzxGyDjXk6bUAKgL1IUNEB41j
        /c8MUIl/iSwA5v6Ctr1qCFQKaWgZgNOxnW0pZqdfhZXZkhcpf6g+sg2TjTCVP9SBc5vFbk2f4HhAe
        R0YXzIIitZFSL32cmmnw3rfeJD1Ql0MkGUt+q26AmxM1w9ijXES6hh1wmBw3D8+0gjH4bsTSK9jjj
        aEWuqfbA==;
Received: from [8.34.116.185] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmG0l-00BGd4-DY; Wed, 04 May 2022 14:29:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: remove superfluous calls to blkcg_bio_issue_init
Date:   Wed,  4 May 2022 07:29:49 -0700
Message-Id: <20220504142950.567582-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504142950.567582-1-hch@lst.de>
References: <20220504142950.567582-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkcg_bio_issue_init is called in submit_bio.  There is no need to have
extra calls that just get overriden in __bio_clone and the two places
that copy and pasted from it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c                 | 1 -
 block/blk-crypto-fallback.c | 1 -
 block/bounce.c              | 1 -
 3 files changed, 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4259125e16ab2..3cffc01e6377f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -739,7 +739,6 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio->bi_iter = bio_src->bi_iter;
 
 	bio_clone_blkg_association(bio, bio_src);
-	blkcg_bio_issue_init(bio);
 
 	if (bio_crypt_clone(bio, bio_src, gfp) < 0)
 		return -ENOMEM;
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 7c854584b52b5..5ddf33f999dfe 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -177,7 +177,6 @@ static struct bio *blk_crypto_fallback_clone_bio(struct bio *bio_src)
 		bio->bi_io_vec[bio->bi_vcnt++] = bv;
 
 	bio_clone_blkg_association(bio, bio_src);
-	blkcg_bio_issue_init(bio);
 
 	return bio;
 }
diff --git a/block/bounce.c b/block/bounce.c
index 467be46d0e656..8f7b6fe3b4db5 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -191,7 +191,6 @@ static struct bio *bounce_clone_bio(struct bio *bio_src)
 		goto err_put;
 
 	bio_clone_blkg_association(bio, bio_src);
-	blkcg_bio_issue_init(bio);
 
 	return bio;
 
-- 
2.30.2

