Return-Path: <SRS0=P8sc=3O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B7FC32771
	for <linux-block@archiver.kernel.org>; Sat, 25 Jan 2020 03:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85C220716
	for <linux-block@archiver.kernel.org>; Sat, 25 Jan 2020 03:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N/GnyKaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbgAYDT5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jan 2020 22:19:57 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:32870 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387675AbgAYDT4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jan 2020 22:19:56 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00P3JHlp073406;
        Sat, 25 Jan 2020 03:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=nXbp8lKl14KNgVJ5YZHNYMc2g84K+obCbboQSnEg6sI=;
 b=N/GnyKaL3SvZlSj8t0akK+AiSTxskIoxqjTxq2IPfOegPWBsrFBbG0GvHhvqm4znba8T
 EIq5TZ2BchvTaXTWbDy6koU4MSbvg7svbqZZ/rAqpXU25BuIH/SeiaJ7adBe3rrYJcaT
 7JYQ2hDg5DZl46RIkXI5ehID/OwEV3JOx+7xQf3Ueh1f2kpv3ZQu8bSxr4a5lSufzpLT
 MW/Y8IyUtyvg+2JqLmuL9lOaPolySsCNGiPcHWic/v10uoarwgH/hRP5jeIuWeUfYF3t
 GrKoAA7Wj4jXNxkXzVmIYbW1BacbsQtIyu3vXDNR3Dfj2WabftX/aPtGGF8diMVoNVmr bQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xrd3tr1vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jan 2020 03:19:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00P3IKka071709;
        Sat, 25 Jan 2020 03:19:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xratary01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jan 2020 03:19:16 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00P3JB74007541;
        Sat, 25 Jan 2020 03:19:11 GMT
Received: from [192.168.0.110] (/39.176.206.183)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jan 2020 19:19:11 -0800
Subject: Re: [PATCH v5 4/6] block: Add support for REQ_ALLOCATE flag
To:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        axboe@kernel.dk, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, song@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, Chaitanya.Kulkarni@wdc.com,
        darrick.wong@oracle.com, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com
References: <157968992539.174869.7490844754165043549.stgit@localhost.localdomain>
 <157969069360.174869.18184061012552778480.stgit@localhost.localdomain>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <b33500eb-8e7c-9e25-b7bc-9309e426cfc3@oracle.com>
Date:   Sat, 25 Jan 2020 11:18:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <157969069360.174869.18184061012552778480.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9510 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001250028
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9510 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001250028
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/22/20 6:58 PM, Kirill Tkhai wrote:
> This adds support for REQ_ALLOCATE extension of REQ_OP_WRITE_ZEROES
> operation, which encourages a block device driver to just allocate
> blocks (or mark them allocated) instead of actual blocks zeroing.
> REQ_ALLOCATE is aimed to be used for network filesystems providing
> a block device interface. Also, block devices, which map a file
> on other filesystem (like loop), may use this for less fragmentation
> and batching fallocate() requests. Hypervisors like QEMU may
> introduce optimizations of clusters allocations based on this.
> 
> BLKDEV_ZERO_ALLOCATE is a new corresponding flag for
> blkdev_issue_zeroout().
> 
> Stacking devices start from zero max_allocate_sectors limit for now,
> and the support is going to be implemented separate for each device
> in the future.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  block/blk-lib.c           |   17 ++++++++++-------
>  block/blk-settings.c      |    4 ++++
>  fs/block_dev.c            |    4 ++++
>  include/linux/blk_types.h |    5 ++++-
>  include/linux/blkdev.h    |   13 ++++++++++---
>  5 files changed, 32 insertions(+), 11 deletions(-)
> 

This patch and following two are looks fine to me.
Feel free to add.
Reviewed-by: Bob Liu <bob.liu@oracle.com>

> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 3e38c93cfc53..9cd6f86523ba 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -214,7 +214,7 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
>  		struct bio **biop, unsigned flags)
>  {
>  	struct bio *bio = *biop;
> -	unsigned int max_write_zeroes_sectors;
> +	unsigned int max_write_zeroes_sectors, req_flags = 0;
>  	struct request_queue *q = bdev_get_queue(bdev);
>  
>  	if (!q)
> @@ -224,18 +224,21 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
>  		return -EPERM;
>  
>  	/* Ensure that max_write_zeroes_sectors doesn't overflow bi_size */
> -	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bdev, 0);
> +	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bdev, flags);
>  
>  	if (max_write_zeroes_sectors == 0)
>  		return -EOPNOTSUPP;
>  
> +	if (flags & BLKDEV_ZERO_NOUNMAP)
> +		req_flags |= REQ_NOUNMAP;
> +	if (flags & BLKDEV_ZERO_ALLOCATE)
> +		req_flags |= REQ_ALLOCATE|REQ_NOUNMAP;
> +
>  	while (nr_sects) {
>  		bio = blk_next_bio(bio, 0, gfp_mask);
>  		bio->bi_iter.bi_sector = sector;
>  		bio_set_dev(bio, bdev);
> -		bio->bi_opf = REQ_OP_WRITE_ZEROES;
> -		if (flags & BLKDEV_ZERO_NOUNMAP)
> -			bio->bi_opf |= REQ_NOUNMAP;
> +		bio->bi_opf = REQ_OP_WRITE_ZEROES | req_flags;
>  
>  		if (nr_sects > max_write_zeroes_sectors) {
>  			bio->bi_iter.bi_size = max_write_zeroes_sectors << 9;
> @@ -362,7 +365,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
>  	sector_t bs_mask;
>  	struct bio *bio;
>  	struct blk_plug plug;
> -	bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev, 0);
> +	bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev, flags);
>  
>  	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
>  	if ((sector | nr_sects) & bs_mask)
> @@ -391,7 +394,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
>  			try_write_zeroes = false;
>  			goto retry;
>  		}
> -		if (!bdev_write_zeroes_sectors(bdev, 0)) {
> +		if (!bdev_write_zeroes_sectors(bdev, flags)) {
>  			/*
>  			 * Zeroing offload support was indicated, but the
>  			 * device reported ILLEGAL REQUEST (for some devices
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index c8eda2e7b91e..8d5df9d37239 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -48,6 +48,7 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->chunk_sectors = 0;
>  	lim->max_write_same_sectors = 0;
>  	lim->max_write_zeroes_sectors = 0;
> +	lim->max_allocate_sectors = 0;
>  	lim->max_discard_sectors = 0;
>  	lim->max_hw_discard_sectors = 0;
>  	lim->discard_granularity = 0;
> @@ -83,6 +84,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
>  	lim->max_dev_sectors = UINT_MAX;
>  	lim->max_write_same_sectors = UINT_MAX;
>  	lim->max_write_zeroes_sectors = UINT_MAX;
> +	lim->max_allocate_sectors = 0;
>  }
>  EXPORT_SYMBOL(blk_set_stacking_limits);
>  
> @@ -506,6 +508,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>  					b->max_write_same_sectors);
>  	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
>  					b->max_write_zeroes_sectors);
> +	t->max_allocate_sectors = min(t->max_allocate_sectors,
> +					b->max_allocate_sectors);
>  	t->bounce_pfn = min_not_zero(t->bounce_pfn, b->bounce_pfn);
>  
>  	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 69bf2fb6f7cd..1ffef894b3bd 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -2122,6 +2122,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
>  					     GFP_KERNEL, BLKDEV_ZERO_NOFALLBACK);
>  		break;
> +	case FALLOC_FL_KEEP_SIZE:
> +		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
> +			GFP_KERNEL, BLKDEV_ZERO_ALLOCATE | BLKDEV_ZERO_NOFALLBACK);
> +		break;
>  	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
>  		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
>  					     GFP_KERNEL, 0);
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 70254ae11769..86accd2caa4e 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -335,7 +335,9 @@ enum req_flag_bits {
>  
>  	/* command specific flags for REQ_OP_WRITE_ZEROES: */
>  	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
> -
> +	__REQ_ALLOCATE,		/* only notify about allocated blocks,
> +				 * and do not actually zero them
> +				 */
>  	__REQ_HIPRI,
>  
>  	/* for driver use */
> @@ -362,6 +364,7 @@ enum req_flag_bits {
>  #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
>  
>  #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
> +#define REQ_ALLOCATE		(1ULL << __REQ_ALLOCATE)
>  #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
>  
>  #define REQ_DRV			(1ULL << __REQ_DRV)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 264202fa3bf8..20c94a7f9411 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -337,6 +337,7 @@ struct queue_limits {
>  	unsigned int		max_hw_discard_sectors;
>  	unsigned int		max_write_same_sectors;
>  	unsigned int		max_write_zeroes_sectors;
> +	unsigned int		max_allocate_sectors;
>  	unsigned int		discard_granularity;
>  	unsigned int		discard_alignment;
>  
> @@ -991,6 +992,8 @@ static inline struct bio_vec req_bvec(struct request *rq)
>  static inline unsigned int blk_queue_get_max_write_zeroes_sectors(
>  		struct request_queue *q, unsigned int op_flags)
>  {
> +	if (op_flags & REQ_ALLOCATE)
> +		return q->limits.max_allocate_sectors;
>  	return q->limits.max_write_zeroes_sectors;
>  }
>  
> @@ -1227,6 +1230,7 @@ extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  
>  #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
>  #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
> +#define BLKDEV_ZERO_ALLOCATE	(1 << 2)  /* allocate range of blocks */
>  
>  extern int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
>  		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop,
> @@ -1431,10 +1435,13 @@ static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev,
>  {
>  	struct request_queue *q = bdev_get_queue(bdev);
>  
> -	if (q)
> -		return q->limits.max_write_zeroes_sectors;
> +	if (!q)
> +		return 0;
>  
> -	return 0;
> +	if (flags & BLKDEV_ZERO_ALLOCATE)
> +		return q->limits.max_allocate_sectors;
> +	else
> +		return q->limits.max_write_zeroes_sectors;
>  }
>  
>  static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
> 
> 

