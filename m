Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB355C433C1
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 11:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CAD61A09
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 11:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhCXLFx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 07:05:53 -0400
Received: from verein.lst.de ([213.95.11.211]:36519 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231634AbhCXLFj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 07:05:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8591168B05; Wed, 24 Mar 2021 12:05:37 +0100 (CET)
Date:   Wed, 24 Mar 2021 12:05:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] block: support zone append bvecs
Message-ID: <20210324110537.GA13839@lst.de>
References: <739a96e185f008c238fcf06cb22068016149ad4a.1616497531.git.johannes.thumshirn@wdc.com> <20210323123002.GA30758@lst.de> <PH0PR04MB7416CEB0FE5E8E56370A0A1D9B639@PH0PR04MB7416.namprd04.prod.outlook.com> <20210324071119.GA647@lst.de> <PH0PR04MB7416B0F00700A4C9D951AD5C9B639@PH0PR04MB7416.namprd04.prod.outlook.com> <PH0PR04MB74168F2BDB61F5E951339B4F9B639@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74168F2BDB61F5E951339B4F9B639@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 24, 2021 at 10:09:32AM +0000, Johannes Thumshirn wrote:
> Stupid question, but wouldn't it be sufficient if I did (this can still be
> simplified):

No, this loses data if the iter is bigger than what you truncate it to.
Just with your last patch you probably did not test with larger
enough iters to be beyond the zone append limit.

> diff --git a/block/bio.c b/block/bio.c
> index 26b7f721cda8..9c529b2db8fa 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -964,6 +964,16 @@ static int bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
>         return 0;
>  }
>  
> +static int bio_iov_append_bvec_set(struct bio *bio, struct iov_iter *iter)
> +{
> +       struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> +       unsigned int max_append = queue_max_zone_append_sectors(q) << 9;
> +
> +       iov_iter_truncate(iter, max_append);
> +
> +       return bio_iov_bvec_set(bio, iter);

OTOH if you copy the iter by value to a local one first and then
make sure the original iter is advanced it should work.  We don't
really need the iter advance for the original one, though.  Something like:

diff --git a/block/bio.c b/block/bio.c
index a1c4d2900c7a83..7d9e01580f2ab1 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -949,7 +949,7 @@ void bio_release_pages(struct bio *bio, bool mark_dirty)
 }
 EXPORT_SYMBOL_GPL(bio_release_pages);
 
-static int bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
+static void __bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 {
 	WARN_ON_ONCE(bio->bi_max_vecs);
 
@@ -959,7 +959,11 @@ static int bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 	bio->bi_iter.bi_size = iter->count;
 	bio_set_flag(bio, BIO_NO_PAGE_REF);
 	bio_set_flag(bio, BIO_CLONED);
+}
 
+static int bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
+{
+	__bio_iov_bvec_set(bio, iter);
 	iov_iter_advance(iter, iter->count);
 	return 0;
 }
@@ -1019,6 +1023,17 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	return 0;
 }
 
+static int bio_iov_bvec_set_append(struct bio *bio, struct iov_iter *iter)
+{
+	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	struct iov_iter i = *iter;
+
+	iov_iter_truncate(&i, queue_max_zone_append_sectors(q) << 9);
+	__bio_iov_bvec_set(bio, &i);
+	iov_iter_advance(iter, i.count);
+	return 0;
+}
+
 static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 {
 	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
@@ -1094,8 +1109,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	int ret = 0;
 
 	if (iov_iter_is_bvec(iter)) {
-		if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND))
-			return -EINVAL;
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
+			return bio_iov_bvec_set_append(bio, iter);
 		return bio_iov_bvec_set(bio, iter);
 	}
 
