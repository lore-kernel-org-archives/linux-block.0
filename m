Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082F6C77B61
	for <linux-block@archiver.kernel.org>; Fri, 28 Apr 2023 05:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345054AbjD1Fo4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Apr 2023 01:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345296AbjD1Fow (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2023 01:44:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2BC2111
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 22:44:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 62FFF68D0A; Fri, 28 Apr 2023 07:44:46 +0200 (CEST)
Date:   Fri, 28 Apr 2023 07:44:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 2/9] block: Micro-optimize
 blk_req_needs_zone_write_lock()
Message-ID: <20230428054446.GC8549@lst.de>
References: <20230424203329.2369688-1-bvanassche@acm.org> <20230424203329.2369688-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424203329.2369688-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 24, 2023 at 01:33:22PM -0700, Bart Van Assche wrote:
> @@ -367,8 +367,9 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
>  static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>  {
>  	/* Zoned block device write operation case: do not plug the BIO */
> -	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> -	    bdev_op_is_zoned_write(bio->bi_bdev, bio_op(bio)))
> +	if ((bio_op(bio) == REQ_OP_WRITE ||
> +	     bio_op(bio) == REQ_OP_WRITE_ZEROES) &&
> +	    disk_zone_is_seq(bio->bi_bdev->bd_disk, bio->bi_iter.bi_sector))
>  		return NULL;

I find this a bit hard to hard to read.  Why not:

	if (disk_zone_is_seq(bio->bi_bdev->bd_disk, bio->bi_iter.bi_sector)) {
	  	/*
		 * Do not plug for writes that require zone locking.
		 */
		if (bio_op(bio) == REQ_OP_WRITE ||
		    bio_op(bio) == REQ_OP_WRITE_ZEROES)
			return NULL;
	}

>  bool blk_req_needs_zone_write_lock(struct request *rq)
>  {
> -	if (!rq->q->disk->seq_zones_wlock)
> -		return false;
> -
> -	if (bdev_op_is_zoned_write(rq->q->disk->part0, req_op(rq)))
> -		return blk_rq_zone_is_seq(rq);
> -
> -	return false;
> +	return rq->q->disk->seq_zones_wlock &&
> +		(req_op(rq) == REQ_OP_WRITE ||
> +		 req_op(rq) == REQ_OP_WRITE_ZEROES) &&
> +		blk_rq_zone_is_seq(rq);

Similaly here.  The old version did flow much better, so I'd prefer
something like:


	if (!rq->q->disk->seq_zones_wlock || !blk_rq_zone_is_seq(rq))
		return false;
	return req_op(rq) == REQ_OP_WRITE || req_op(rq) == REQ_OP_WRITE_ZEROES);

I also wonder if the check that and op is write or write zeroes, that
is needs zone locking would be useful instead of dupliating it all
over.  That is instead of removing bdev_op_is_zoned_write
keep a op_is_zoned_write without the bdev_is_zoned check.
