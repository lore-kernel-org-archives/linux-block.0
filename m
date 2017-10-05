Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:54671 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbdJERNa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Oct 2017 13:13:30 -0400
Date: Thu, 5 Oct 2017 10:13:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 2/2] block: cope with WRITE ZEROES failing in
 blkdev_issue_zeroout()
Message-ID: <20171005171327.GB31208@infradead.org>
References: <1507129396-20458-1-git-send-email-idryomov@gmail.com>
 <1507129396-20458-3-git-send-email-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507129396-20458-3-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Oct 04, 2017 at 05:03:16PM +0200, Ilya Dryomov wrote:
> sd_config_write_same() ignores ->max_ws_blocks == 0 and resets it to
> permit trying WRITE SAME on older SCSI devices, unless ->no_write_same
> is set.  Because REQ_OP_WRITE_ZEROES is implemented in terms of WRITE
> SAME, blkdev_issue_zeroout() may fail with -EREMOTEIO:
> 
>   $ fallocate -zn -l 1k /dev/sdg
>   fallocate: fallocate failed: Remote I/O error
>   $ fallocate -zn -l 1k /dev/sdg  # OK
>   $ fallocate -zn -l 1k /dev/sdg  # OK

Can we wire this up for blktests somehow?

> 
> The following calls succeed because sd_done() sets ->no_write_same in
> response to a sense that would become BLK_STS_TARGET/-EREMOTEIO, causing
> __blkdev_issue_zeroout() to fall back to generating ZERO_PAGE bios.
> 
> This means blkdev_issue_zeroout() must cope with WRITE ZEROES failing
> and fall back to manually zeroing, unless BLKDEV_ZERO_NOFALLBACK is
> specified.  For BLKDEV_ZERO_NOFALLBACK case, return -EOPNOTSUPP if
> sd_done() has just set ->no_write_same thus indicating lack of offload
> support.
> 
> Fixes: c20cfc27a473 ("block: stop using blkdev_issue_write_same for zeroing")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  block/blk-lib.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 9d2ab8bba52a..17494275673e 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -321,12 +321,6 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
>   *  Zero-fill a block range, either using hardware offload or by explicitly
>   *  writing zeroes to the device.
>   *
> - *  Note that this function may fail with -EOPNOTSUPP if the driver signals
> - *  zeroing offload support, but the device fails to process the command (for
> - *  some devices there is no non-destructive way to verify whether this
> - *  operation is actually supported).  In this case the caller should call
> - *  retry the call to blkdev_issue_zeroout() and the fallback path will be used.
> - *
>   *  If a device is using logical block provisioning, the underlying space will
>   *  not be released if %flags contains BLKDEV_ZERO_NOUNMAP.
>   *
> @@ -370,18 +364,45 @@ EXPORT_SYMBOL(__blkdev_issue_zeroout);
>  int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
>  		sector_t nr_sects, gfp_t gfp_mask, unsigned flags)
>  {
> -	int ret;
> -	struct bio *bio = NULL;
> +	int ret = 0;
> +	sector_t bs_mask;
> +	struct bio *bio;
>  	struct blk_plug plug;
> +	bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev);
> +
> +	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
> +	if ((sector | nr_sects) & bs_mask)
> +		return -EINVAL;
>  
> +retry:
> +	bio = NULL;
>  	blk_start_plug(&plug);
> -	ret = __blkdev_issue_zeroout(bdev, sector, nr_sects, gfp_mask,
> -			&bio, flags);
> +	if (try_write_zeroes) {
> +		ret = __blkdev_issue_write_zeroes(bdev, sector, nr_sects,
> +						  gfp_mask, &bio, flags);
> +	} else if (!(flags & BLKDEV_ZERO_NOFALLBACK)) {
> +		ret = __blkdev_issue_zero_pages(bdev, sector, nr_sects,
> +						gfp_mask, &bio);
> +	} else if (!bdev_write_zeroes_sectors(bdev)) {
> +		/*
> +		 * Manual zeroout is not allowed and either:
> +		 * - no zeroing offload support
> +		 * - zeroing offload support was indicated, but the device
> +		 *   reported ILLEGAL REQUEST (for some devices there is no
> +		 *   non-destructive way to verify whether WRITE ZEROES is
> +		 *   actually supported)
> +		 */
> +		ret = -EOPNOTSUPP;

I don't understand the conditional above this error return - if
we can't zero using either method we should always return an error.

Except for that the patch looks fine.
