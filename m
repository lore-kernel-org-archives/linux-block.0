Return-Path: <SRS0=2A/1=3K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165B7C33CAA
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 06:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FAA21734
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 06:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KB8mwRNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgAUGOT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jan 2020 01:14:19 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50594 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUGOS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jan 2020 01:14:18 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00L69HaV157630;
        Tue, 21 Jan 2020 06:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=FC5Ad7hsQ7RR9E8Ecodh1d/DDrXAU/0EVkchD0/zzVk=;
 b=KB8mwRNpgNESgHkWul6vJlaxal4JEPONOYQ7bb53BPkIewSWR71uQl70H45+uQeI1ogW
 FvOL2EP9G3LoyYikXx3VnxqfIF+gKTdXwKx21MyksAkNQnA1zq7PdYiaf4FVokY1QjOO
 dmYPJS88jC7wQN2ufalzPSNAMWbDG2KaK5RTxXtISPNltVL5o+zg8DZj55l0pdlrIV3K
 iB9ZVYMwxlP/XxyXXntoBlEktdXeK5ChCvrIF+eo3GfQaAJYA/naVcz6NP4Jm38vfk6M
 YGHtC7tNDzbHzQ1FqCJWzHTGV9rxRm8lNX9Fksb8vRmIPCgXvV7HeVkrLxb7ltOVm1UZ Tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xkseuaw9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 06:13:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00L696iX101727;
        Tue, 21 Jan 2020 06:13:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2xnpebnpev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 06:13:50 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00L6DkjN026741;
        Tue, 21 Jan 2020 06:13:46 GMT
Received: from [192.168.0.110] (/39.176.206.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jan 2020 22:13:46 -0800
Subject: Re: [PATCH block v2 2/3] block: Add support for REQ_NOZERO flag
To:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        axboe@kernel.dk, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, darrick.wong@oracle.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com
References: <157917805422.88675.6477661554332322975.stgit@localhost.localdomain>
 <157917816325.88675.16481772163916741596.stgit@localhost.localdomain>
 <a6f36a19-0607-fc1e-d2da-37aa00c4b76e@oracle.com>
 <fe055cf4-db28-e72d-c247-3a9c921919f5@virtuozzo.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <71039bfe-764f-441a-115f-1065ca8096bf@oracle.com>
Date:   Tue, 21 Jan 2020 14:13:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <fe055cf4-db28-e72d-c247-3a9c921919f5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001210054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001210054
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/20/20 6:02 PM, Kirill Tkhai wrote:
> On 19.01.2020 04:50, Bob Liu wrote:
>> On 1/16/20 8:36 PM, Kirill Tkhai wrote:
>>> This adds support for REQ_NOZERO extension of REQ_OP_WRITE_ZEROES
>>> operation, which encourages a block device driver to just allocate
>>> blocks (or mark them allocated) instead of actual blocks zeroing.
>>> REQ_NOZERO is aimed to be used for network filesystems providing
>>> a block device interface. Also, block devices, which map a file
>>> on other filesystem (like loop), may use this for less fragmentation
>>> and batching fallocate() requests. Hypervisors like QEMU may
>>> introduce optimizations of clusters allocations based on this.
>>>
>>> BLKDEV_ZERO_ALLOCATE is a new corresponding flag for
>>> blkdev_issue_zeroout().
>>>> CC: Martin K. Petersen <martin.petersen@oracle.com>
>>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>>> ---
>>>  block/blk-core.c          |    6 +++---
>>>  block/blk-lib.c           |   17 ++++++++++-------
>>>  block/blk-merge.c         |    9 ++++++---
>>>  block/blk-settings.c      |   17 +++++++++++++++++
>>>  fs/block_dev.c            |    4 ++++
>>>  include/linux/blk_types.h |    5 ++++-
>>>  include/linux/blkdev.h    |   31 ++++++++++++++++++++++++-------
>>>  7 files changed, 68 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index 50a5de025d5e..2edcd55624f1 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -978,7 +978,7 @@ generic_make_request_checks(struct bio *bio)
>>>  			goto not_supported;
>>>  		break;
>>>  	case REQ_OP_WRITE_ZEROES:
>>> -		if (!q->limits.max_write_zeroes_sectors)
>>> +		if (!blk_queue_get_max_write_zeroes_sectors(q, bio->bi_opf))
>>>  			goto not_supported;
>>>  		break;
>>>  	default:
>>> @@ -1250,10 +1250,10 @@ EXPORT_SYMBOL(submit_bio);
>>>  static int blk_cloned_rq_check_limits(struct request_queue *q,
>>>  				      struct request *rq)
>>>  {
>>> -	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, req_op(rq))) {
>>> +	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, rq->cmd_flags)) {
>>>  		printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
>>>  			__func__, blk_rq_sectors(rq),
>>> -			blk_queue_get_max_sectors(q, req_op(rq)));
>>> +			blk_queue_get_max_sectors(q, rq->cmd_flags));
>>>  		return -EIO;
>>>  	}
>>>  
>>> diff --git a/block/blk-lib.c b/block/blk-lib.c
>>> index 3e38c93cfc53..3e80279eb029 100644
>>> --- a/block/blk-lib.c
>>> +++ b/block/blk-lib.c
>>> @@ -214,7 +214,7 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
>>>  		struct bio **biop, unsigned flags)
>>>  {
>>>  	struct bio *bio = *biop;
>>> -	unsigned int max_write_zeroes_sectors;
>>> +	unsigned int max_write_zeroes_sectors, req_flags = 0;
>>>  	struct request_queue *q = bdev_get_queue(bdev);
>>>  
>>>  	if (!q)
>>> @@ -224,18 +224,21 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
>>>  		return -EPERM;
>>>  
>>>  	/* Ensure that max_write_zeroes_sectors doesn't overflow bi_size */
>>> -	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bdev, 0);
>>> +	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bdev, flags);
>>>  
>>>  	if (max_write_zeroes_sectors == 0)
>>>  		return -EOPNOTSUPP;
>>>  
>>> +	if (flags & BLKDEV_ZERO_NOUNMAP)
>>> +		req_flags |= REQ_NOUNMAP;
>>> +	if (flags & BLKDEV_ZERO_ALLOCATE)
>>> +		req_flags |= REQ_NOZERO|REQ_NOUNMAP;
>>> +
>>>  	while (nr_sects) {
>>>  		bio = blk_next_bio(bio, 0, gfp_mask);
>>>  		bio->bi_iter.bi_sector = sector;
>>>  		bio_set_dev(bio, bdev);
>>> -		bio->bi_opf = REQ_OP_WRITE_ZEROES;
>>> -		if (flags & BLKDEV_ZERO_NOUNMAP)
>>> -			bio->bi_opf |= REQ_NOUNMAP;
>>> +		bio->bi_opf = REQ_OP_WRITE_ZEROES | req_flags;
>>>  
>>>  		if (nr_sects > max_write_zeroes_sectors) {
>>>  			bio->bi_iter.bi_size = max_write_zeroes_sectors << 9;
>>> @@ -362,7 +365,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
>>>  	sector_t bs_mask;
>>>  	struct bio *bio;
>>>  	struct blk_plug plug;
>>> -	bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev, 0);
>>> +	bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev, flags);
>>>  
>>>  	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
>>>  	if ((sector | nr_sects) & bs_mask)
>>> @@ -391,7 +394,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
>>>  			try_write_zeroes = false;
>>>  			goto retry;
>>>  		}
>>> -		if (!bdev_write_zeroes_sectors(bdev, 0)) {
>>> +		if (!bdev_write_zeroes_sectors(bdev, flags)) {
>>>  			/*
>>>  			 * Zeroing offload support was indicated, but the
>>>  			 * device reported ILLEGAL REQUEST (for some devices
>>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>>> index 347782a24a35..e3ce4b87bbaa 100644
>>> --- a/block/blk-merge.c
>>> +++ b/block/blk-merge.c
>>> @@ -105,15 +105,18 @@ static struct bio *blk_bio_discard_split(struct request_queue *q,
>>>  static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
>>>  		struct bio *bio, struct bio_set *bs, unsigned *nsegs)
>>>  {
>>> +	unsigned int max_sectors;
>>> +
>>> +	max_sectors = blk_queue_get_max_write_zeroes_sectors(q, bio->bi_opf);
>>>  	*nsegs = 0;
>>>  
>>> -	if (!q->limits.max_write_zeroes_sectors)
>>> +	if (!max_sectors)
>>>  		return NULL;
>>>  
>>> -	if (bio_sectors(bio) <= q->limits.max_write_zeroes_sectors)
>>> +	if (bio_sectors(bio) <= max_sectors)
>>>  		return NULL;
>>>  
>>> -	return bio_split(bio, q->limits.max_write_zeroes_sectors, GFP_NOIO, bs);
>>> +	return bio_split(bio, max_sectors, GFP_NOIO, bs);
>>>  }
>>>  
>>>  static struct bio *blk_bio_write_same_split(struct request_queue *q,
>>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>>> index 5f6dcc7a47bd..f682374c5106 100644
>>> --- a/block/blk-settings.c
>>> +++ b/block/blk-settings.c
>>> @@ -48,6 +48,7 @@ void blk_set_default_limits(struct queue_limits *lim)
>>>  	lim->chunk_sectors = 0;
>>>  	lim->max_write_same_sectors = 0;
>>>  	lim->max_write_zeroes_sectors = 0;
>>> +	lim->max_allocate_sectors = 0;
>>>  	lim->max_discard_sectors = 0;
>>>  	lim->max_hw_discard_sectors = 0;
>>>  	lim->discard_granularity = 0;
>>> @@ -83,6 +84,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
>>>  	lim->max_dev_sectors = UINT_MAX;
>>>  	lim->max_write_same_sectors = UINT_MAX;
>>>  	lim->max_write_zeroes_sectors = UINT_MAX;
>>> +	lim->max_allocate_sectors = UINT_MAX;
>>>  }
>>>  EXPORT_SYMBOL(blk_set_stacking_limits);
>>>  
>>> @@ -257,6 +259,19 @@ void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
>>>  }
>>>  EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
>>>  
>>> +/**
>>> + * blk_queue_max_allocate_sectors - set max sectors for a single
>>> + *                                  allocate request
>>> + * @q:  the request queue for the device
>>> + * @max_allocate_sectors: maximum number of sectors to write per command
>>> + **/
>>> +void blk_queue_max_allocate_sectors(struct request_queue *q,
>>> +		unsigned int max_allocate_sectors)
>>> +{
>>> +	q->limits.max_allocate_sectors = max_allocate_sectors;
>>> +}
>>> +EXPORT_SYMBOL(blk_queue_max_allocate_sectors);
>>> +
>>
>> I'd suggest split this to a separated patch.
> 
> Yeah, this function is used in [3/3] only, so in may go after this patch [2/3] as a separate patch.
> 
>>>  /**
>>>   * blk_queue_max_segments - set max hw segments for a request for this queue
>>>   * @q:  the request queue for the device
>>> @@ -506,6 +521,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>>>  					b->max_write_same_sectors);
>>>  	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
>>>  					b->max_write_zeroes_sectors);
>>> +	t->max_allocate_sectors = min(t->max_allocate_sectors,
>>> +					b->max_allocate_sectors);
>>>  	t->bounce_pfn = min_not_zero(t->bounce_pfn, b->bounce_pfn);
>>>  
>>>  	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
>>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>>> index 69bf2fb6f7cd..1ffef894b3bd 100644
>>> --- a/fs/block_dev.c
>>> +++ b/fs/block_dev.c
>>> @@ -2122,6 +2122,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>>>  		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
>>>  					     GFP_KERNEL, BLKDEV_ZERO_NOFALLBACK);
>>>  		break;
>>> +	case FALLOC_FL_KEEP_SIZE:
>>> +		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
>>> +			GFP_KERNEL, BLKDEV_ZERO_ALLOCATE | BLKDEV_ZERO_NOFALLBACK);
>>> +		break;
>>>  	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
>>>  		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
>>>  					     GFP_KERNEL, 0);
>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>> index 70254ae11769..9ed166860099 100644
>>> --- a/include/linux/blk_types.h
>>> +++ b/include/linux/blk_types.h
>>> @@ -335,7 +335,9 @@ enum req_flag_bits {
>>>  
>>>  	/* command specific flags for REQ_OP_WRITE_ZEROES: */
>>>  	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
>>> -
>>> +	__REQ_NOZERO,		/* only notify about allocated blocks,
>>> +				 * and do not actual zero them
>>> +				 */
>>>  	__REQ_HIPRI,
>>>  
>>>  	/* for driver use */
>>> @@ -362,6 +364,7 @@ enum req_flag_bits {
>>>  #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
>>>  
>>>  #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
>>> +#define REQ_NOZERO		(1ULL << __REQ_NOZERO)
>>>  #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
>>>  
>>>  #define REQ_DRV			(1ULL << __REQ_DRV)
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index 4cd69552df9a..f4ec5db64432 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -336,6 +336,7 @@ struct queue_limits {
>>>  	unsigned int		max_hw_discard_sectors;
>>>  	unsigned int		max_write_same_sectors;
>>>  	unsigned int		max_write_zeroes_sectors;
>>> +	unsigned int		max_allocate_sectors;
>>>  	unsigned int		discard_granularity;
>>>  	unsigned int		discard_alignment;
>>>  
>>> @@ -988,9 +989,19 @@ static inline struct bio_vec req_bvec(struct request *rq)
>>>  	return mp_bvec_iter_bvec(rq->bio->bi_io_vec, rq->bio->bi_iter);
>>>  }
>>>  
>>> +static inline unsigned int blk_queue_get_max_write_zeroes_sectors(
>>> +		struct request_queue *q, unsigned int op_flags)
>>> +{
>>> +	if (op_flags & REQ_NOZERO)
>>> +		return q->limits.max_allocate_sectors;
>>> +	return q->limits.max_write_zeroes_sectors;
>>> +}
>>> +
>>
>> And this one.
> 
> It looks it won't be good, since this will require to declare REQ_NOZERO
> in a separate patch. This will tear off the flag declaration from the logic.
> 
>> Also, should we consider other code path used q->limits.max_write_zeroes_sectors?
> 
> Other code paths should not dereference q->limits.max_allocate_sectors, unless
> it is directly set in not-zero value. In case of max_allocate_sectors is zero,
> high-level primitives (generic_make_request_checks(), __blkdev_issue_write_zeroes(), ..)
> complete such the bios immediately. Other drivers may need additional work
> to support this, and really only subset of drivers need support of this, so this is
> not a subject of this patchset.
> 
> Hm, it looks like there is an exception, which may inherit stack limits from children.
> Device-mapper will pick all the limits we enable for children.
> We may disable REQ_WRITE_ZEROES|REQ_NOZERO directly there, since it's not supported
> in this driver yet.
> 
> Are you hinting at this here?
> 

Oh, I mean other place references q->limits.max_write_zeroes_sectors.
Like in drivers/md/dm-io.c:
		special_cmd_max_sectors = q->limits.max_write_zeroes_sectors;

Now there should use blk_queue_get_max_write_zeroes_sectors() instead of use
q->limits.max_write_zeroes_sectors directly?

If yes, then I think codes related with function blk_queue_get_max_write_zeroes_sectors() should
also be split to separated patch.

> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 0a2cc197f62b..b8aa5f6f9ce1 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -489,6 +489,7 @@ static int dm_set_device_limits(struct dm_target *ti, struct dm_dev *dev,
>  		       (unsigned long long) start << SECTOR_SHIFT);
>  
>  	limits->zoned = blk_queue_zoned_model(q);
> +	limits->max_allocate_sectors = 0;
>  
>  	return 0;
>  }
> @@ -1548,6 +1549,7 @@ int dm_calculate_queue_limits(struct dm_table *table,
>  			       dm_device_name(table->md),
>  			       (unsigned long long) ti->begin,
>  			       (unsigned long long) ti->len);
> +		limits->max_allocate_sectors = 0;
>  
>  		/*
>  		 * FIXME: this should likely be moved to blk_stack_limits(), would
> 
> Thanks,
> Kirill
> 

