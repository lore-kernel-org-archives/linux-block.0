Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F72C4338F
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 18:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E991260F12
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 18:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbhGWRa5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jul 2021 13:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhGWRa5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jul 2021 13:30:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF22260EFD;
        Fri, 23 Jul 2021 18:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627063888;
        bh=TuVfUMDvxzT1xNGQhFM4HU63m/o5k6uZDDnxRtBY5C8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KnxkyITLoa1Eegou5dusQAGIuHO0hVx7EpPH3VWpIll+iTW8lScgJ2PpccOIlwNHS
         XxQlV2xTYRfYE31kTyzss52hPlmsEU75bPe4eCuUIyKtG+lEDr4GzSYR5VIVG2i+dr
         PBQIYo6WH7CVgLFeu+KISOIvBpCB7k02vDP7HSzdB43ARsEd7joGjruUZQqGjQmQ47
         lLr/G9gibaFx+bnslTLkMfgjhmjOghASL2iic3y2iQz3nS5JZ4MUXcALge9dBGJx5L
         eT7nKnoSZl6XgVwV+E/Rx2lM7OOrzHCpBn4I/45iC4zK727Z1AKuaoHS/bmF9REuID
         6N7raTH/1tSRg==
Date:   Fri, 23 Jul 2021 11:11:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyaprateek2357@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v4 8/9] blk-merge: Ensure bios aren't split in middle of
 a crypto data unit
Message-ID: <YPsGT2DbRTEjtLWu@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
 <20210707052943.3960-9-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707052943.3960-9-satyaprateek2357@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 06, 2021 at 10:29:42PM -0700, Satya Tangirala wrote:
> From: Satya Tangirala <satyat@google.com>
> 
> Update get_max_io_size() to return a value aligned to
> bio_required_sector_alignment(). With this change, and the changes
> to blk_ksm_register() that restrict the supported data unit sizes
> based on the queue's limits, blk_bio_segment_split() won't split bios in
> the middle of a data unit anymore
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  block/blk-merge.c | 49 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index a11b3b53717e..68c96dec5680 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -135,27 +135,39 @@ static struct bio *blk_bio_write_same_split(struct request_queue *q,
>  
>  /*
>   * Return the maximum number of sectors from the start of a bio that may be
> - * submitted as a single request to a block device. If enough sectors remain,
> - * align the end to the physical block size. Otherwise align the end to the
> - * logical block size. This approach minimizes the number of non-aligned
> - * requests that are submitted to a block device if the start of a bio is not
> - * aligned to a physical block boundary.
> + * submitted as a single request to a block device. Tries to align the end to
> + * the physical block size, while also aligning the returned number of sectors
> + * to bio_required_sector_alignment(). This approach minimizes the number of
> + * non-aligned requests that are submitted to a block device if the start of a
> + * bio is not aligned to a physical block boundary.
> + *
> + * More clearly, there are two conditions we're interested in satisfying.
> + *
> + * Condition 1) We absolutely must have @return divisible by the
> + * bio_required_sector_alignment(bio).
> + *
> + * Condition 2) *If possible*, while still satisfying Condition 1, we would like
> + * to have start_offset + @return divisible by physical block size in sectors
> + * (pbs).
>   */

This comment is basically saying the same thing in two different ways.  Could we
just say it once clearly?  Maybe:

/*
 * Return the maximum number of sectors from the start of a bio that may be
 * submitted as a single request to a block device.  The returned value will be
 * a multiple of bio_required_sector_alignment().  If possible, the returned
 * value will also make the request end on a physical block boundary; this
 * minimizes the number of non-aligned requests that are submitted to a block
 * device when a bio doesn't start on a physical block boundary.
 */

>  static inline unsigned get_max_io_size(struct request_queue *q,
>  				       struct bio *bio)
>  {
> -	unsigned sectors = blk_max_size_offset(q, bio->bi_iter.bi_sector, 0);
> -	unsigned max_sectors = sectors;
> -	unsigned pbs = queue_physical_block_size(q) >> SECTOR_SHIFT;
> -	unsigned lbs = queue_logical_block_size(q) >> SECTOR_SHIFT;
> -	unsigned start_offset = bio->bi_iter.bi_sector & (pbs - 1);
> -
> -	max_sectors += start_offset;
> -	max_sectors &= ~(pbs - 1);
> -	if (max_sectors > start_offset)
> -		return max_sectors - start_offset;
> -
> -	return sectors & ~(lbs - 1);
> +	unsigned int start_offset = bio->bi_iter.bi_sector;
> +	unsigned int sectors = blk_max_size_offset(q, start_offset, 0);
> +	unsigned int pbs = queue_physical_block_size(q) >> SECTOR_SHIFT;
> +	unsigned int req_sector_align = bio_required_sector_alignment(bio);
> +	unsigned int pbs_aligned_sector = round_down(start_offset + sectors, pbs);
> +
> +	/*
> +	 * If we can return a pbs aligned endpoint while satisfying Condition 1,
> +	 * then do so.
> +	 */
> +	if (pbs_aligned_sector > start_offset &&
> +	    IS_ALIGNED(pbs_aligned_sector - start_offset, req_sector_align))
> +		return pbs_aligned_sector - start_offset;
> +
> +	return round_down(sectors, req_sector_align);
>  }

'start_offset' and 'pbs_aligned_sector' need to be 'sector_t', not 'unsigned
int'.  Also 'start_offset' probably should be called 'start_sector'.  And
'req_sector_align' could be shortened to just 'align'.

- Eric
