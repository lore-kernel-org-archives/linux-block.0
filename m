Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1788C433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 07:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5CF464E31
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 07:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhBWHL1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 02:11:27 -0500
Received: from verein.lst.de ([213.95.11.211]:32946 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhBWHLY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 02:11:24 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7CDF168D0D; Tue, 23 Feb 2021 08:10:41 +0100 (CET)
Date:   Tue, 23 Feb 2021 08:10:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        John Stultz <john.stultz@linaro.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Anderson <dvander@google.com>,
        Alistair Delva <adelva@google.com>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing
 crash shortly after bootup
Message-ID: <20210223071040.GB16980@lst.de>
References: <CALAqxLUWjr2oR=5XxyGQ2HcC-TLARvboHRHHaAOUFq6_TsKXyw@mail.gmail.com> <BYAPR04MB4965F0B60169371A25CD423E86809@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965F0B60169371A25CD423E86809@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 23, 2021 at 03:51:23AM +0000, Chaitanya Kulkarni wrote:
> Looking at the other call sites do we need something like following ?

> Since __blk_queue_bounce() passes the NULL for the passthru case as a
> bio_set value ?

Well, that is a somewhat odd calling convention.  What about the patch below
instead?  That being we really need to kill this bouncing code off..


diff --git a/block/bounce.c b/block/bounce.c
index fc55314aa4269a..789fbcacb1e92a 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -214,9 +214,9 @@ static void bounce_end_io_read_isa(struct bio *bio)
 	__bounce_end_io_read(bio, &isa_page_pool);
 }
 
-static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
-		struct bio_set *bs)
+static struct bio *bounce_clone_bio(struct bio *bio_src, bool passthrough)
 {
+	unsigned int nr_vecs = bio_segments(bio_src);
 	struct bvec_iter iter;
 	struct bio_vec bv;
 	struct bio *bio;
@@ -242,8 +242,10 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 	 *    asking for trouble and would force extra work on
 	 *    __bio_clone_fast() anyways.
 	 */
-
-	bio = bio_alloc_bioset(gfp_mask, bio_segments(bio_src), bs);
+	if (passthrough)
+		bio = bio_kmalloc(GFP_NOIO, nr_vecs);
+	else
+		bio = bio_alloc_bioset(GFP_NOIO, nr_vecs, &bounce_bio_set);
 	if (!bio)
 		return NULL;
 	bio->bi_bdev		= bio_src->bi_bdev;
@@ -269,11 +271,11 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 		break;
 	}
 
-	if (bio_crypt_clone(bio, bio_src, gfp_mask) < 0)
+	if (bio_crypt_clone(bio, bio_src, GFP_NOIO) < 0)
 		goto err_put;
 
 	if (bio_integrity(bio_src) &&
-	    bio_integrity_clone(bio, bio_src, gfp_mask) < 0)
+	    bio_integrity_clone(bio, bio_src, GFP_NOIO) < 0)
 		goto err_put;
 
 	bio_clone_blkg_association(bio, bio_src);
@@ -313,8 +315,7 @@ static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
 		submit_bio_noacct(*bio_orig);
 		*bio_orig = bio;
 	}
-	bio = bounce_clone_bio(*bio_orig, GFP_NOIO, passthrough ? NULL :
-			&bounce_bio_set);
+	bio = bounce_clone_bio(*bio_orig, passthrough);
 
 	/*
 	 * Bvec table can't be updated by bio_for_each_segment_all(),
