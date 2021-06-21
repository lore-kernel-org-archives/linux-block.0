Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D22FC49EA4
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 07:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D0360240
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 07:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFUH1U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 03:27:20 -0400
Received: from verein.lst.de ([213.95.11.211]:40878 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbhFUH1S (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 03:27:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7EA6368BEB; Mon, 21 Jun 2021 09:25:02 +0200 (CEST)
Date:   Mon, 21 Jun 2021 09:25:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH V2 2/3] block: add ->poll_bio to
 block_device_operations
Message-ID: <20210621072502.GC6651@lst.de>
References: <20210617103549.930311-1-ming.lei@redhat.com> <20210617103549.930311-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617103549.930311-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	struct gendisk *disk = bio->bi_bdev->bd_disk;
> +	struct request_queue *q = disk->queue;
>  	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
>  	int ret;
>  
> -	if (cookie == BLK_QC_T_NONE || !blk_queue_poll(q))
> +	if ((queue_is_mq(q) && cookie == BLK_QC_T_NONE) ||
> +			!blk_queue_poll(q))
>  		return 0;

How does polling for a bio without a cookie make sense even when
polling bio based?

But if we come up for a good rationale for this I'd really
split the conditions to make them more readable:

	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
		return 0;
	if (queue_is_mq(q) && cookie == BLK_QC_T_NONE)
		return 0;

> +	if (!queue_is_mq(q)) {
> +		if (disk->fops->poll_bio) {
> +			ret = disk->fops->poll_bio(bio, flags);
> +		} else {
> +			WARN_ON_ONCE(1);
> +			ret = 0;
> +		}
> +	} else {
>  		ret = blk_mq_poll(q, cookie, flags);

I'd go for someting like:

	if (queue_is_mq(q))
		ret = blk_mq_poll(q, cookie, flags);
	else if (disk->fops->poll_bio)
		ret = disk->fops->poll_bio(bio, flags);
	else
		WARN_ON_ONCE(1);

with ret initialized to 0 at declaration time.

>  struct block_device_operations {
>  	void (*submit_bio)(struct bio *bio);
> +	/* ->poll_bio is for bio driver only */

I'd drop the comment, this is already nicely documented in add_disk
together with the actual check.  We also don't note this for submit_bio
here.
