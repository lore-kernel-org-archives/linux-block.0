Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3879C43460
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 19:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA80B610EA
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 19:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbhDOToz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 15:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234226AbhDOToz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 15:44:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F0CA6115B;
        Thu, 15 Apr 2021 19:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618515871;
        bh=oU1cQr3wkqayozcT7QZOVj1UOm40p9k1jAVx6Ebpk7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NopJ6oGLjiZbNcp/BrmHyV+vsHX0w0jTtQvJJUDYAPpkpmV7L9CtsponNSRmdJ1nC
         LAq04IjmE6ilLWBWAF99hPFP96sEZRM/6GgA10boU+DQR9rLbvzh6dbt8ijVsXRDjC
         C58C6fR6NUlb05f7LfyWXMFg/mlHN+lg4k8OGeSY8Bd69bhVcEvHnO2hySM3iwfa1+
         pN3/w3paQ20SOzGYZKkRz1sNyGc5QOpmvmpDZCUAGwXFc57Af1ybduNiLiDiete/9B
         5KxURBYY6Rzl+ypVZRkqrnqpKtM2vT1dDUPH35s4bOo+PHB8+bkddbBdgUrEjRNR/U
         tEGuDPeM4pZ9w==
Date:   Thu, 15 Apr 2021 12:44:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 4/8] block: introduce bio_required_sector_alignment()
Message-ID: <YHiXns+jQL+MrmNK@gmail.com>
References: <20210325212609.492188-1-satyat@google.com>
 <20210325212609.492188-5-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325212609.492188-5-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 25, 2021 at 09:26:05PM +0000, Satya Tangirala wrote:
> This function returns the required alignment for the number of sectors in
> a bio. In particular, the number of sectors passed to bio_split() must be
> aligned to this value.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  block/blk.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/block/blk.h b/block/blk.h
> index 3b53e44b967e..5ef207a6d34c 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -261,6 +261,18 @@ static inline unsigned int bio_allowed_max_sectors(struct request_queue *q)
>  	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
>  }
>  
> +/*
> + * The required sector alignment for a bio. The number of sectors in any bio
> + * that's constructed/split must be aligned to this value.

What does "constructed" mean in this context?

> + */
> +static inline unsigned int bio_required_sector_alignment(struct bio *bio)
> +{
> +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> +
> +	return max(queue_logical_block_size(q) >> SECTOR_SHIFT,
> +		   blk_crypto_bio_sectors_alignment(bio));
> +}

It would be slightly simpler to use bdev_logical_block_size(bio->bi_bdev)
instead of queue_logical_block_size(bio->bi_bdev->bd_disk->queue).

Also, if there's interest in avoiding the branch implied by the max() here, it
would be possible to take advantage of the values being powers of 2 as follows:

static inline unsigned int bio_required_sector_alignment(struct bio *bio)
{
	unsigned int alignmask =
		(bdev_logical_block_size(q) >> SECTOR_SHIFT) - 1;

	alignmask |= blk_crypto_bio_sectors_alignment(bio) - 1;

	return alignmask + 1;
}
