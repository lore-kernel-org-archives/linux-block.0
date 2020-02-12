Return-Path: <SRS0=TQg9=4A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004A0C352A4
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 18:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CC220724
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 18:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m8nC0OSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgBLSc4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Feb 2020 13:32:56 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39424 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgBLScz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 13:32:55 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CI8VLT102933;
        Wed, 12 Feb 2020 18:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=nz7vd3fyzwcyP/5qHs4DQXgU0UFGi/84mrF3oEBKNv4=;
 b=m8nC0OSEGT6rx/LqZh+8FrrfjYNJUGNcfIZ3ezzAPQzJmA4lizlq/ixtUyTFp6CJy78H
 8kxazmEzLtuFKC0anF8zXv3trhKrzRqdFkD3saTECI/RUEnHyrfjwCq7lws+wgrznCVP
 yuI1jKraaWXGObjQrSOlmTF9GS5fPFZUR/NB2NPQW+xdJchCxF0B/l3Orp3UJ61mKqOh
 9shbJfHQ/blh5tfXxSUqXLbPKJy+JV9eY6ES5vcIW9ItPjq4Np28tFPtHg37+s+X1Hr0
 eB4HtrBpvZ9ZexCEq5o2v9fl9NrUYHcqCYcOY+ouA+U5wTtY4GkSk0PEKot4g42J8Jwx EQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2y2jx6d23e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 18:31:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CIRF7c048321;
        Wed, 12 Feb 2020 18:31:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2y4kagp4km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 18:31:40 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01CIVXHa010665;
        Wed, 12 Feb 2020 18:31:33 GMT
Received: from localhost (/10.159.151.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 10:31:32 -0800
Date:   Wed, 12 Feb 2020 10:31:29 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     martin.petersen@oracle.com, bob.liu@oracle.com, axboe@kernel.dk,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/6] block: Add support for REQ_ALLOCATE flag
Message-ID: <20200212183129.GO6874@magnolia>
References: <158132703141.239613.3550455492676290009.stgit@localhost.localdomain>
 <158132723311.239613.5269033996109738831.stgit@localhost.localdomain>
 <20200212165837.GL6874@magnolia>
 <092f2dc2-7bb7-d5dd-9a54-e9430940ece9@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <092f2dc2-7bb7-d5dd-9a54-e9430940ece9@virtuozzo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=2 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=2 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120132
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 12, 2020 at 08:33:52PM +0300, Kirill Tkhai wrote:
> Hi, Darrick,
> 
> On 12.02.2020 19:58, Darrick J. Wong wrote:
> > On Mon, Feb 10, 2020 at 12:33:53PM +0300, Kirill Tkhai wrote:
> >> This adds support for REQ_ALLOCATE extension of REQ_OP_WRITE_ZEROES
> >> operation, which encourages a block device driver to just allocate
> >> blocks (or mark them allocated) instead of actual blocks zeroing.
> >> REQ_ALLOCATE is aimed to be used for network filesystems providing
> >> a block device interface. Also, block devices, which map a file
> >> on other filesystem (like loop), may use this for less fragmentation
> >> and batching fallocate() requests. Hypervisors like QEMU may
> >> introduce optimizations of clusters allocations based on this.
> >>
> >> BLKDEV_ZERO_ALLOCATE is a new corresponding flag for
> >> blkdev_issue_zeroout().
> >>
> >> Stacking devices start from zero max_allocate_sectors limit for now,
> >> and the support is going to be implemented separate for each device
> >> in the future.
> >>
> >> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> >> Reviewed-by: Bob Liu <bob.liu@oracle.com>
> >> ---
> >>  block/blk-lib.c           |   17 ++++++++++-------
> >>  block/blk-settings.c      |    4 ++++
> >>  fs/block_dev.c            |    4 ++++
> >>  include/linux/blk_types.h |    5 ++++-
> >>  include/linux/blkdev.h    |   13 ++++++++++---
> >>  5 files changed, 32 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/block/blk-lib.c b/block/blk-lib.c
> >> index 3e38c93cfc53..9cd6f86523ba 100644
> >> --- a/block/blk-lib.c
> >> +++ b/block/blk-lib.c
> >> @@ -214,7 +214,7 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
> >>  		struct bio **biop, unsigned flags)
> >>  {
> >>  	struct bio *bio = *biop;
> >> -	unsigned int max_write_zeroes_sectors;
> >> +	unsigned int max_write_zeroes_sectors, req_flags = 0;
> >>  	struct request_queue *q = bdev_get_queue(bdev);
> >>  
> >>  	if (!q)
> >> @@ -224,18 +224,21 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
> >>  		return -EPERM;
> >>  
> >>  	/* Ensure that max_write_zeroes_sectors doesn't overflow bi_size */
> >> -	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bdev, 0);
> >> +	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bdev, flags);
> >>  
> >>  	if (max_write_zeroes_sectors == 0)
> >>  		return -EOPNOTSUPP;
> >>  
> >> +	if (flags & BLKDEV_ZERO_NOUNMAP)
> >> +		req_flags |= REQ_NOUNMAP;
> >> +	if (flags & BLKDEV_ZERO_ALLOCATE)
> >> +		req_flags |= REQ_ALLOCATE|REQ_NOUNMAP;
> >> +
> >>  	while (nr_sects) {
> >>  		bio = blk_next_bio(bio, 0, gfp_mask);
> >>  		bio->bi_iter.bi_sector = sector;
> >>  		bio_set_dev(bio, bdev);
> >> -		bio->bi_opf = REQ_OP_WRITE_ZEROES;
> >> -		if (flags & BLKDEV_ZERO_NOUNMAP)
> >> -			bio->bi_opf |= REQ_NOUNMAP;
> >> +		bio->bi_opf = REQ_OP_WRITE_ZEROES | req_flags;
> >>  
> >>  		if (nr_sects > max_write_zeroes_sectors) {
> >>  			bio->bi_iter.bi_size = max_write_zeroes_sectors << 9;
> >> @@ -362,7 +365,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
> >>  	sector_t bs_mask;
> >>  	struct bio *bio;
> >>  	struct blk_plug plug;
> >> -	bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev, 0);
> >> +	bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev, flags);
> >>  
> >>  	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
> >>  	if ((sector | nr_sects) & bs_mask)
> >> @@ -391,7 +394,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
> >>  			try_write_zeroes = false;
> >>  			goto retry;
> >>  		}
> >> -		if (!bdev_write_zeroes_sectors(bdev, 0)) {
> >> +		if (!bdev_write_zeroes_sectors(bdev, flags)) {
> >>  			/*
> >>  			 * Zeroing offload support was indicated, but the
> >>  			 * device reported ILLEGAL REQUEST (for some devices
> >> diff --git a/block/blk-settings.c b/block/blk-settings.c
> >> index c8eda2e7b91e..8d5df9d37239 100644
> >> --- a/block/blk-settings.c
> >> +++ b/block/blk-settings.c
> >> @@ -48,6 +48,7 @@ void blk_set_default_limits(struct queue_limits *lim)
> >>  	lim->chunk_sectors = 0;
> >>  	lim->max_write_same_sectors = 0;
> >>  	lim->max_write_zeroes_sectors = 0;
> >> +	lim->max_allocate_sectors = 0;
> >>  	lim->max_discard_sectors = 0;
> >>  	lim->max_hw_discard_sectors = 0;
> >>  	lim->discard_granularity = 0;
> >> @@ -83,6 +84,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
> >>  	lim->max_dev_sectors = UINT_MAX;
> >>  	lim->max_write_same_sectors = UINT_MAX;
> >>  	lim->max_write_zeroes_sectors = UINT_MAX;
> >> +	lim->max_allocate_sectors = 0;
> >>  }
> >>  EXPORT_SYMBOL(blk_set_stacking_limits);
> >>  
> >> @@ -506,6 +508,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
> >>  					b->max_write_same_sectors);
> >>  	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
> >>  					b->max_write_zeroes_sectors);
> >> +	t->max_allocate_sectors = min(t->max_allocate_sectors,
> >> +					b->max_allocate_sectors);
> >>  	t->bounce_pfn = min_not_zero(t->bounce_pfn, b->bounce_pfn);
> >>  
> >>  	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
> >> diff --git a/fs/block_dev.c b/fs/block_dev.c
> >> index 69bf2fb6f7cd..1ffef894b3bd 100644
> >> --- a/fs/block_dev.c
> >> +++ b/fs/block_dev.c
> >> @@ -2122,6 +2122,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> >>  		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
> >>  					     GFP_KERNEL, BLKDEV_ZERO_NOFALLBACK);
> >>  		break;
> >> +	case FALLOC_FL_KEEP_SIZE:
> >> +		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
> >> +			GFP_KERNEL, BLKDEV_ZERO_ALLOCATE | BLKDEV_ZERO_NOFALLBACK);
> > 
> > I think this should be ^^^ indented to match the other calls.
> 
> The only idea I have about this is something like the below. But the below is over 90 char...
> 
> 		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
> 					     GFP_KERNEL,
> 					     BLKDEV_ZERO_ALLOCATE | BLKDEV_ZERO_NOFALLBACK);
> 
> Could you please clarify what you mean?

I mostly meant that the indent for the nth lines ought to be more than a
single indent to make it easier to scan through the code, but you're
right, the kernel indentation style is uglier.  I could suggest
something like this, which actually does fit:

	case FALLOC_FL_KEEP_SIZE:
		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
				GFP_KERNEL,
				BLKDEV_ZERO_ALLOCATE | BLKDEV_ZERO_NOFALLBACK);
		break;

But that's apparently apocryphal. :/

--D

> >>  	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
> >>  		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
> >>  					     GFP_KERNEL, 0);
> >> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> >> index 70254ae11769..86accd2caa4e 100644
> >> --- a/include/linux/blk_types.h
> >> +++ b/include/linux/blk_types.h
> >> @@ -335,7 +335,9 @@ enum req_flag_bits {
> >>  
> >>  	/* command specific flags for REQ_OP_WRITE_ZEROES: */
> >>  	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
> >> -
> >> +	__REQ_ALLOCATE,		/* only notify about allocated blocks,
> >> +				 * and do not actually zero them
> > 
> > "only notify"?  Is someone getting a notification?  Or are we simply
> > "notifying" the device that it must ensure allocated blocks?
> > 
> > If it's that last one, then perhaps this should be reworded:
> > 
> > /*
> >  * Ensure the LBA range is backed by physical storage
> >  * without writing zeroes to the blocks.
> >  */
> 
> Sounds good.
>  
> >> +				 */
> >>  	__REQ_HIPRI,
> >>  
> >>  	/* for driver use */
> >> @@ -362,6 +364,7 @@ enum req_flag_bits {
> >>  #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
> >>  
> >>  #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
> >> +#define REQ_ALLOCATE		(1ULL << __REQ_ALLOCATE)
> >>  #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
> >>  
> >>  #define REQ_DRV			(1ULL << __REQ_DRV)
> >> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> >> index 55a714161684..40707f980a2e 100644
> >> --- a/include/linux/blkdev.h
> >> +++ b/include/linux/blkdev.h
> >> @@ -336,6 +336,7 @@ struct queue_limits {
> >>  	unsigned int		max_hw_discard_sectors;
> >>  	unsigned int		max_write_same_sectors;
> >>  	unsigned int		max_write_zeroes_sectors;
> >> +	unsigned int		max_allocate_sectors;
> >>  	unsigned int		discard_granularity;
> >>  	unsigned int		discard_alignment;
> >>  
> >> @@ -990,6 +991,8 @@ static inline struct bio_vec req_bvec(struct request *rq)
> >>  static inline unsigned int blk_queue_get_max_write_zeroes_sectors(
> >>  		struct request_queue *q, unsigned int op_flags)
> >>  {
> >> +	if (op_flags & REQ_ALLOCATE)
> >> +		return q->limits.max_allocate_sectors;
> >>  	return q->limits.max_write_zeroes_sectors;
> >>  }
> >>  
> >> @@ -1226,6 +1229,7 @@ extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> >>  
> >>  #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
> >>  #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
> >> +#define BLKDEV_ZERO_ALLOCATE	(1 << 2)  /* allocate range of blocks */
> >>  
> >>  extern int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
> >>  		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop,
> >> @@ -1430,10 +1434,13 @@ static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev,
> >>  {
> >>  	struct request_queue *q = bdev_get_queue(bdev);
> >>  
> >> -	if (q)
> >> -		return q->limits.max_write_zeroes_sectors;
> >> +	if (!q)
> >> +		return 0;
> >>  
> >> -	return 0;
> >> +	if (flags & BLKDEV_ZERO_ALLOCATE)
> >> +		return q->limits.max_allocate_sectors;
> >> +	else
> >> +		return q->limits.max_write_zeroes_sectors;
> >>  }
> >>  
> >>  static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
> >>
> >>
> 
> Thanks,
> Kirill
