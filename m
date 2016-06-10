Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55218 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750756AbcFJCz1 (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 9 Jun 2016 22:55:27 -0400
Date: Thu, 9 Jun 2016 19:54:36 -0700
From: Shaohua Li <shli@fb.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<axboe@fb.com>, <sitsofe@yahoo.com>, <snitzer@redhat.com>,
	<hch@infradead.org>, <Kernel-team@fb.com>
Subject: Re: [PATCH V2] block: correctly fallback for zeroout
Message-ID: <20160610025435.GA48899@shli-mbp.local>
References: <20160606223357.GA52883@shli-mbp.local>
 <yq18tydiyuf.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <yq18tydiyuf.fsf@sermon.lab.mkp.net>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 09, 2016 at 10:04:08PM -0400, Martin K. Petersen wrote:
> >>>>> "Shaohua" == Shaohua Li <shli@fb.com> writes:
> 
> Shaohua,
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 23d7f30..a3a26c8 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -84,6 +84,28 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  }
>  EXPORT_SYMBOL(__blkdev_issue_discard);
>  
> +static int do_blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> +		sector_t nr_sects, gfp_t gfp_mask, unsigned long flags,
> +		int *io_err)
> +{
> +	int type = REQ_WRITE | REQ_DISCARD;
> +	struct bio *bio = NULL;
> +	struct blk_plug plug;
> +	int ret;
> +
> +	if (flags & BLKDEV_DISCARD_SECURE)
> +		type |= REQ_SECURE;
> +
> +	blk_start_plug(&plug);
> +	ret = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, type,
> +			&bio);
> +	if (!ret && bio)
> +		*io_err = submit_bio_wait(type, bio);
> +	blk_finish_plug(&plug);
> +
> +	return ret;
> +}
> +
> 
> What does the extra io_err buy us? Just have this function return an
> error. And then in blkdev_issue_discard if you get -EOPNOTSUPP you
> special case it there.

The __blkdev_issue_discard returns -EOPNOTSUPP if disk doesn't support discard.
in that case, blkdev_issue_discard doesn't return 0. blkdev_issue_discard only
returns 0 if IO error is -EOPNOTSUPP. Please see bbd848e0fade51ae51da.

Thanks,
Shaohua
