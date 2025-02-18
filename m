Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A791B6D18
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739875367; cv=none; b=hk6ITnYXKGUBbfqDPEbPWUd1xKETlEDlYGUv7vLk2r00umQik7Gc3vqT81VhvhsDsnmMhysv9IuTasdHkgMTdS7tZ5RUzLQ/+5dRjyLg6XwhFiuRQ8ariEbYQBbR2kxuqz/gU92Mavf/dHy+hrLB0V7ABRti76mNWIXRJsxTnCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739875367; c=relaxed/simple;
	bh=hquhYqk6SG+y1CM6frcvMC+JIzYntVtkXfN9jcwQg38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUTygz2+Uh1QSk0KxwHzG67wtw++Dj2GQBVRz2h2jtYwxr2uY21CWADosvFi524OTGEyromYHN+9DxnB6yY4pG/MvaeUYen+yMNzQ6QYDit2lx+SbJhyOCdCUgKszCDmIxNYVqdvhIfTet+rQv4KyeDUANGrxlWLpMJLlsrSTCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHcscPqt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHcscPqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0305FC4CEE6;
	Tue, 18 Feb 2025 10:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739875366;
	bh=hquhYqk6SG+y1CM6frcvMC+JIzYntVtkXfN9jcwQg38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qHcscPqtB1pC6M0cmuNODjfdI978tnUwoaM7grZJWiZHRzgNcJYoEekJFAtZ09FUK
	 7iMAAvfEiC1N6nuN5sPBERa6kFv0JHZ0n7g9z8WZrf2kErR3KSb+AnEmGPyMYGVAaB
	 W88sbFbbAnrg525zXRFyAWqh3rRXhNQahstNZm4AA0VpowfGWixhQnsMtxu5jtSGvS
	 0+esUgyul9rZhallld4bGX9iVmDU++Thp6552lSuj+ULXYPZLzWHO2jTbmX+XdB5fc
	 4uCAD3ULikdh2K9OEFDUT9648tuSjST9wSp2L1ftgFah10OB2vaMzzfqGFcxpJ+5bn
	 AQhcwOscDG7mA==
Date: Tue, 18 Feb 2025 11:42:43 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Paul Bunyan <pbunyan@redhat.com>, Yi Zhang <yi.zhang@redhat.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, John Garry <john.g.garry@oracle.com>, 
	Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V3] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <rthanqn7zv66456urv23nh36l7rhdav2ubldz4e3r5e52ow5a5@dicfrbdak5ia>
References: <20250213120040.2271709-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213120040.2271709-1-ming.lei@redhat.com>

On Thu, Feb 13, 2025 at 08:00:40PM +0100, Ming Lei wrote:
> PAGE_SIZE is applied in validating block device queue limits, this way is
> very fragile and is wrong:
> 
> - queue limits are read from hardware, which is often one readonly hardware
> property
> 
> - PAGE_SIZE is one config option which can be changed during build time.
> 
> In RH lab, it has been found that max segment size of some mmc card is
> less than 64K, then this kind of card can't be probed successfully when
> same kernel is re-built with 64K PAGE_SIZE.
> 
> Fix this issue by using BLK_MIN_SEGMENT_SIZE in related code for dealing
> with queue limits and checking if bio needn't split as a hint. Define
> BLK_MIN_SEGMENT_SIZE as 4K(minimized PAGE_SIZE).
> 
> The following commits are depended for backporting:
> 
> commit 6aeb4f836480 ("block: remove bio_add_pc_page")
> commit 02ee5d69e3ba ("block: remove blk_rq_bio_prep")
> commit b7175e24d6ac ("block: add a dma mapping iterator")
> 
> Cc: Paul Bunyan <pbunyan@redhat.com>
> Cc: Yi Zhang <yi.zhang@redhat.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: John Garry <john.g.garry@oracle.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V3:
> 	- rephrase commit log & fix patch style(Christoph)
> 	- more comment log(Christoph)
> V2:
> 	- cover bio_split_rw_at()
> 	- add BLK_MIN_SEGMENT_SIZE
> 
>  block/blk-merge.c      | 2 +-
>  block/blk-settings.c   | 6 +++---
>  block/blk.h            | 8 ++++++--
>  include/linux/blkdev.h | 2 ++
>  4 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 15cd231d560c..b55c52a42303 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -329,7 +329,7 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
>  
>  		if (nsegs < lim->max_segments &&
>  		    bytes + bv.bv_len <= max_bytes &&
> -		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
> +		    bv.bv_offset + bv.bv_len <= BLK_MIN_SEGMENT_SIZE) {

In which cases this "new" condition (for systems where PAGE_SIZE >
BLK_MIN_SEGMENT_SIZE) is going to be true? In my test case below, is always
false, so it defaults to the else path. And I think that is going to be the
"normal" case in these systems, is that right?

Doing a 'quick' test using next-20250213 on a 16k PAGE_SIZE system with the NVMe
driver and a 4k lbs disk + ~1h fio sequential writes, I get results indicating
a write performance degradation of ~0.8%. This is due to the new loop condition
doing 4k steps rather than PS. I guess it's going to be slighly worse the larger
the PAGE_SIZE the system is, and bio? So, why not decreasing the minimum segment
size for the cases it's actually needed rather than making it now the default?

I've measured bio_split_rw_at latency in the above test with the following
results:

next-20250213:

This is a power-of-2 time (nanoseconds) histogram for all nr segments cases for
my DUT nvme drive:

@ns[fio]:
[128, 256)            11 |                                                    |
[256, 512)        242268 |                                                    |
[512, 1K)       16153055 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1K, 2K)          172281 |                                                    |
[2K, 4K)            3762 |                                                    |
[4K, 8K)            1184 |                                                    |
[8K, 16K)           7581 |                                                    |
[16K, 32K)          1516 |                                                    |
[32K, 64K)           124 |                                                    |
[64K, 128K)            9 |                                                    |
[128K, 256K)           4 |                                                    |
[256K, 512K)           2 |                                                    |
[512K, 1M)             1 |                                                    |

Same power-of-2 histogram for 64 nr segments case only. Note: I couldn't trigger
a much larger nr segment case.

@latency[64]:
[256, 512)        379481 |@@                                                  |
[512, 1K)        8096428 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1K, 2K)            1592 |                                                    |
[2K, 4K)            1181 |                                                    |
[4K, 8K)             332 |                                                    |
[8K, 16K)           3027 |                                                    |
[16K, 32K)           669 |                                                    |
[32K, 64K)            63 |                                                    |
[64K, 128K)            5 |                                                    |
[128K, 256K)           2 |                                                    |
[256K, 512K)           1 |                                                    |

next-20250213 + BLK_MIN_SEGMENT_SIZE patch:

@ns[fio]:
[128, 256)             3 |                                                    |
[256, 512)         76345 |                                                    |
[512, 1K)       15514581 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1K, 2K)          755336 |@@                                                  |
[2K, 4K)            7063 |                                                    |
[4K, 8K)            3301 |                                                    |
[8K, 16K)           4574 |                                                    |
[16K, 32K)          1816 |                                                    |
[32K, 64K)           155 |                                                    |
[64K, 128K)           22 |                                                    |
[128K, 256K)           6 |                                                    |
[256K, 512K)           4 |                                                    |
[512K, 1M)             2 |                                                    |
[1M, 2M)               2 |                                                    |
[2M, 4M)               1 |                                                    |
[4M, 8M)               0 |                                                    |
[8M, 16M)              1 |                                                    |

@latency[64]:
[256, 512)          6800 |                                                    |
[512, 1K)        7540158 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1K, 2K)            5747 |                                                    |
[2K, 4K)            2578 |                                                    |
[4K, 8K)             996 |                                                    |
[8K, 16K)           1960 |                                                    |
[16K, 32K)           773 |                                                    |
[32K, 64K)            54 |                                                    |
[64K, 128K)            5 |                                                    |
[128K, 256K)           3 |                                                    |
[256K, 512K)           3 |                                                    |
[512K, 1M)             2 |                                                    |

So comparing the above, I notice that the new routine is slightly slower,
resulting in a minor degradation. Do you think is worth exploring a fix and
returning PAGE_SIZE as BLK_MIN_SEGMENT_SIZE for the cases we don't need to go
further?


>  			nsegs++;
>  			bytes += bv.bv_len;
>  		} else {
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index c44dadc35e1e..539a64ad7989 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -303,7 +303,7 @@ int blk_validate_limits(struct queue_limits *lim)
>  	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
>  				lim->max_dev_sectors);
>  	if (lim->max_user_sectors) {
> -		if (lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
> +		if (lim->max_user_sectors < BLK_MIN_SEGMENT_SIZE / SECTOR_SIZE)
>  			return -EINVAL;
>  		lim->max_sectors = min(max_hw_sectors, lim->max_user_sectors);
>  	} else if (lim->io_opt > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
> @@ -341,7 +341,7 @@ int blk_validate_limits(struct queue_limits *lim)
>  	 */
>  	if (!lim->seg_boundary_mask)
>  		lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
> -	if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1))
> +	if (WARN_ON_ONCE(lim->seg_boundary_mask < BLK_MIN_SEGMENT_SIZE - 1))
>  		return -EINVAL;
>  
>  	/*
> @@ -362,7 +362,7 @@ int blk_validate_limits(struct queue_limits *lim)
>  		 */
>  		if (!lim->max_segment_size)
>  			lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
> -		if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
> +		if (WARN_ON_ONCE(lim->max_segment_size < BLK_MIN_SEGMENT_SIZE))
>  			return -EINVAL;
>  	}
>  
> diff --git a/block/blk.h b/block/blk.h
> index 90fa5f28ccab..0eca1687bec4 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -358,8 +358,12 @@ struct bio *bio_split_zone_append(struct bio *bio,
>  static inline bool bio_may_need_split(struct bio *bio,
>  		const struct queue_limits *lim)
>  {
> -	return lim->chunk_sectors || bio->bi_vcnt != 1 ||
> -		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
> +	if (lim->chunk_sectors)
> +		return true;
> +	if (bio->bi_vcnt != 1)
> +		return true;
> +	return bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset >
> +		BLK_MIN_SEGMENT_SIZE;
>  }
>  
>  /**
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 248416ecd01c..2021b2174268 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1163,6 +1163,8 @@ static inline bool bdev_is_partition(struct block_device *bdev)
>  enum blk_default_limits {
>  	BLK_MAX_SEGMENTS	= 128,
>  	BLK_SAFE_MAX_SECTORS	= 255,
> +	/* use minimized PAGE_SIZE as min segment size hint */
> +	BLK_MIN_SEGMENT_SIZE	= 4096,
>  	BLK_MAX_SEGMENT_SIZE	= 65536,
>  	BLK_SEG_BOUNDARY_MASK	= 0xFFFFFFFFUL,
>  };
> -- 
> 2.47.1
> 
