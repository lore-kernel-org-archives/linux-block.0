Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354E3C433F5
	for <linux-block@archiver.kernel.org>; Wed,  4 May 2022 14:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351254AbiEDOda (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 May 2022 10:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351322AbiEDOd2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 May 2022 10:33:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50472275E6
        for <linux-block@vger.kernel.org>; Wed,  4 May 2022 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zvAC6ZTe7BWO/nE5xk4xidOPjZN83JwJcpxvQ1Vafho=; b=oI2scAPQpecm1M+am/lqNWheay
        tzZ0cDwuv3HuIcvYhPjDEH/ZtVbuFVn6q6loanuDt1orwuvjz+5L/+b7KxY5Vf8FoYN3zmacHXU3T
        9DRZVTohvpuNCSaPyqzM7HEmwc0MfW9umyCGteaUTpNYMswKjRai+10AlLiEV9jcGsrx5b5j4UGqp
        otz8vNchQ+3pZyjBH6ANqWze+PBQ6ktypQ6sKoPQ30BO60JoW2KbG3MO5l5ExQ0v8eczRuQcOsqu/
        4OzoibA5qDSRj6jAIzyalU/nsDvzHknf1JbKiZyoNtfKLa5YJEgdJIGHgJf4sH3b9RoUad5HrJZpn
        fih+tseA==;
Received: from [8.34.116.185] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmG0m-00BGdJ-80; Wed, 04 May 2022 14:29:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: allow passing a NULL bdev to bio_alloc_clone/bio_init_clone
Date:   Wed,  4 May 2022 07:29:50 -0700
Message-Id: <20220504142950.567582-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504142950.567582-1-hch@lst.de>
References: <20220504142950.567582-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Device mapper wants to allocate a bio before knowing the device it
gets send to, so add explicit support for that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3cffc01e6377f..23a6838cb97e0 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -732,13 +732,15 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio_set_flag(bio, BIO_CLONED);
 	if (bio_flagged(bio_src, BIO_THROTTLED))
 		bio_set_flag(bio, BIO_THROTTLED);
-	if (bio->bi_bdev == bio_src->bi_bdev &&
-	    bio_flagged(bio_src, BIO_REMAPPED))
-		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_iter = bio_src->bi_iter;
 
-	bio_clone_blkg_association(bio, bio_src);
+	if (bio->bi_bdev) {
+		if (bio->bi_bdev == bio_src->bi_bdev &&
+		    bio_flagged(bio_src, BIO_REMAPPED))
+			bio_set_flag(bio, BIO_REMAPPED);
+		bio_clone_blkg_association(bio, bio_src);
+	}
 
 	if (bio_crypt_clone(bio, bio_src, gfp) < 0)
 		return -ENOMEM;
-- 
2.30.2

