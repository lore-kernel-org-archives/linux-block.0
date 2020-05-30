Return-Path: <SRS0=VeZL=7M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B264C433DF
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 13:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CCFF20776
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 13:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgE3NWZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 May 2020 09:22:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:46466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbgE3NWZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 May 2020 09:22:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 19912AFBC;
        Sat, 30 May 2020 13:22:23 +0000 (UTC)
Subject: Re: [PATCH v2] block: improve discard bio alignment in
 __blkdev_issue_discard()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Acshai Manoj <acshai.manoj@microfocus.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Enzo Matsumiya <ematsumiya@suse.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Xiao Ni <xni@redhat.com>
References: <20200529163418.101606-1-colyli@suse.de>
 <20200529225505.GA1121169@T590>
 <e08d0bda-a597-4f69-ab06-26706b718da1@suse.de>
 <20200530125356.GA1143142@T590> <20200530131139.GB1143142@T590>
From:   Coly Li <colyli@suse.de>
Autocrypt: addr=colyli@suse.de; keydata=
 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
Message-ID: <50cf2402-3aeb-27e2-6523-6b213a3c6b3e@suse.de>
Date:   Sat, 30 May 2020 21:22:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200530131139.GB1143142@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/5/30 21:11, Ming Lei wrote:
> On Sat, May 30, 2020 at 08:53:56PM +0800, Ming Lei wrote:
>> On Sat, May 30, 2020 at 06:07:07PM +0800, Coly Li wrote:
>>> On 2020/5/30 06:55, Ming Lei wrote:
>>>> On Sat, May 30, 2020 at 12:34:18AM +0800, Coly Li wrote:
>>>>> This patch improves discard bio split for address and size alignment in
>>>>> __blkdev_issue_discard(). The aligned discard bio may help underlying
>>>>> device controller to perform better discard and internal garbage
>>>>> collection, and avoid unnecessary internal fragment.
>>>>>
>>>>> Current discard bio split algorithm in __blkdev_issue_discard() may have
>>>>> non-discarded fregment on device even the discard bio LBA and size are
>>>>> both aligned to device's discard granularity size.
>>>>>
>>>>> Here is the example steps on how to reproduce the above problem.
>>>>> - On a VMWare ESXi 6.5 update3 installation, create a 51GB virtual disk
>>>>>   with thin mode and give it to a Linux virtual machine.
>>>>> - Inside the Linux virtual machine, if the 50GB virtual disk shows up as
>>>>>   /dev/sdb, fill data into the first 50GB by,
>>>>> 	# dd if=/dev/zero of=/dev/sdb bs=4096 count=13107200
>>>>> - Discard the 50GB range from offset 0 on /dev/sdb,
>>>>> 	# blkdiscard /dev/sdb -o 0 -l 53687091200
>>>>> - Observe the underlying mapping status of the device
>>>>> 	# sg_get_lba_status /dev/sdb -m 1048 --lba=0
>>>>>   descriptor LBA: 0x0000000000000000  blocks: 2048  mapped (or unknown)
>>>>>   descriptor LBA: 0x0000000000000800  blocks: 16773120  deallocated
>>>>>   descriptor LBA: 0x0000000000fff800  blocks: 2048  mapped (or unknown)
>>>>>   descriptor LBA: 0x0000000001000000  blocks: 8386560  deallocated
>>>>>   descriptor LBA: 0x00000000017ff800  blocks: 2048  mapped (or unknown)
>>>>>   descriptor LBA: 0x0000000001800000  blocks: 8386560  deallocated
>>>>>   descriptor LBA: 0x0000000001fff800  blocks: 2048  mapped (or unknown)
>>>>>   descriptor LBA: 0x0000000002000000  blocks: 8386560  deallocated
>>>>>   descriptor LBA: 0x00000000027ff800  blocks: 2048  mapped (or unknown)
>>>>>   descriptor LBA: 0x0000000002800000  blocks: 8386560  deallocated
>>>>>   descriptor LBA: 0x0000000002fff800  blocks: 2048  mapped (or unknown)
>>>>>   descriptor LBA: 0x0000000003000000  blocks: 8386560  deallocated
>>>>>   descriptor LBA: 0x00000000037ff800  blocks: 2048  mapped (or unknown)
>>>>>   descriptor LBA: 0x0000000003800000  blocks: 8386560  deallocated
>>>>>   descriptor LBA: 0x0000000003fff800  blocks: 2048  mapped (or unknown)
>>>>>   descriptor LBA: 0x0000000004000000  blocks: 8386560  deallocated
>>>>>   descriptor LBA: 0x00000000047ff800  blocks: 2048  mapped (or unknown)
>>>>>   descriptor LBA: 0x0000000004800000  blocks: 8386560  deallocated
>>>>>   descriptor LBA: 0x0000000004fff800  blocks: 2048  mapped (or unknown)
>>>>>   descriptor LBA: 0x0000000005000000  blocks: 8386560  deallocated
>>>>>   descriptor LBA: 0x00000000057ff800  blocks: 2048  mapped (or unknown)
>>>>>   descriptor LBA: 0x0000000005800000  blocks: 8386560  deallocated
>>>>>   descriptor LBA: 0x0000000005fff800  blocks: 2048  mapped (or unknown)
>>>>>   descriptor LBA: 0x0000000006000000  blocks: 6291456  deallocated
>>>>>   descriptor LBA: 0x0000000006600000  blocks: 0  deallocated
>>>>>
>>>>> Although the discard bio starts at LBA 0 and has 50<<30 bytes size which
>>>>> are perfect aligned to the discard granularity, from the above list
>>>>> these are many 1MB (2048 sectors) internal fragments exist unexpectedly.
>>>>>
>>>>> The problem is in __blkdev_issue_discard(), an improper algorithm causes
>>>>> an improper bio size which is not aligned.
>>>>>
>>>>>  25 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>>>>>  26                 sector_t nr_sects, gfp_t gfp_mask, int flags,
>>>>>  27                 struct bio **biop)
>>>>>  28 {
>>>>>  29         struct request_queue *q = bdev_get_queue(bdev);
>>>>>    [snipped]
>>>>>  56
>>>>>  57         while (nr_sects) {
>>>>>  58                 sector_t req_sects = min_t(sector_t, nr_sects,
>>>>>  59                                 bio_allowed_max_sectors(q));
>>>>>  60
>>>>>  61                 WARN_ON_ONCE((req_sects << 9) > UINT_MAX);
>>>>>  62
>>>>>  63                 bio = blk_next_bio(bio, 0, gfp_mask);
>>>>>  64                 bio->bi_iter.bi_sector = sector;
>>>>>  65                 bio_set_dev(bio, bdev);
>>>>>  66                 bio_set_op_attrs(bio, op, 0);
>>>>>  67
>>>>>  68                 bio->bi_iter.bi_size = req_sects << 9;
>>>>>  69                 sector += req_sects;
>>>>>  70                 nr_sects -= req_sects;
>>>>>    [snipped]
>>>>>  79         }
>>>>>  80
>>>>>  81         *biop = bio;
>>>>>  82         return 0;
>>>>>  83 }
>>>>>  84 EXPORT_SYMBOL(__blkdev_issue_discard);
>>>>>
>>>>> At line 58-59, to discard a 50GB range, req_sets is set as return value
>>>>> of bio_allowed_max_sectors(q), which is 8388607 sectors. In the above
>>>>> case, the discard granularity is 2048 sectors, although the start LBA
>>>>> and discard length are aligned to discard granularity, seq_sets never
>>>>> has chance to be aligned to discard granularity. This is why there are
>>>>> some still-mapped 2048 sectors segment in every 4 or 8 GB range.
>>>>>
>>>>> Because queue's max_discard_sectors is aligned to discard granularity,
>>>>> if req_sects at line 58 is set to a value closest to UINT_MAX and
>>>>> aligned to q->limits.max_discard_sectors, then all consequent split bios
>>>>> inside device driver are (almostly) aligned to discard_granularity of
>>>>> the device queue.
>>>>>
>>>>> This patch introduces bio_aligned_discard_max_sectors() to return the
>>>>> closet to UINT_MAX and aligned to q->limits.discard_granularity value,
>>>>> and replace bio_allowed_max_sectors() with this new inline routine to
>>>>> decide the split bio length.
>>>>>
>>>>> But we still need to handle the situation when discard start LBA is not
>>>>> aligned to q->limits.discard_granularity, otherwise even the length is
>>>>> aligned, current code may still leave 2048 segment around every 4BG
>>>>> range. Thereforeto calculate req_sects, firstly the start LBA of discard
>>>>> request command is checked, if it is not aligned to discard granularity,
>>>>> the first split location should make sure following bio has bi_sector
>>>>> aligned to discard granularity. Then there won't be still-mapped segment
>>>>> in the middle of the discard range.
>>>>>
>>>>> The above is how this patch improves discard bio alignment in
>>>>> __blkdev_issue_discard(). Now with this patch, after discard with same
>>>>> command line mentiond previously, sg_get_lba_status returns,
>>>>> descriptor LBA: 0x0000000000000000  blocks: 106954752  deallocated
>>>>> descriptor LBA: 0x0000000006600000  blocks: 0  deallocated
>>>>>
>>>>> We an see there is no 2048 sectors segment anymore, everything is clean.
>>>>>
>>>>> Reported-by: Acshai Manoj <acshai.manoj@microfocus.com>
>>>>> Signed-off-by: Coly Li <colyli@suse.de>
>>>>> Cc: Bart Van Assche <bvanassche@acm.org>
>>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>>> Cc: Enzo Matsumiya <ematsumiya@suse.com>
>>>>> Cc: Hannes Reinecke <hare@suse.com>
>>>>> Cc: Jens Axboe <axboe@kernel.dk>
>>>>> Cc: Ming Lei <ming.lei@redhat.com>
>>>>> Cc: Xiao Ni <xni@redhat.com>
>>>>> ---
>>>>> Changelog:
>>>>> v2: replace 9 with SECTOR_SHIFT as suggested by Bart Van Assche.
>>>>> v1: initial version.
>>>>>
>>>>>  block/blk-lib.c | 25 +++++++++++++++++++++++--
>>>>>  block/blk.h     | 15 +++++++++++++++
>>>>>  2 files changed, 38 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/block/blk-lib.c b/block/blk-lib.c
>>>>> index 5f2c429d4378..2fc0e3cc1ed8 100644
>>>>> --- a/block/blk-lib.c
>>>>> +++ b/block/blk-lib.c
>>>>> @@ -55,8 +55,29 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>>>>>  		return -EINVAL;
>>>>>  
>>>>>  	while (nr_sects) {
>>>>> -		sector_t req_sects = min_t(sector_t, nr_sects,
>>>>> -				bio_allowed_max_sectors(q));
>>>>> +		sector_t granularity_aligned_lba;
>>>>> +		sector_t req_sects;
>>>>> +
>>>>> +		granularity_aligned_lba =
>>>>> +			round_up(sector, q->limits.discard_granularity);
>>>>> +
>>>>> +		/*
>>>>> +		 * Check whether the discard bio starts at a discard_granularity
>>>>> +		 * aligned LBA,
>>>>> +		 * - If no: set (granularity_aligned_lba - sector) to bi_size of
>>>>> +		 *   the first split bio, then the second bio will start at a
>>>>> +		 *   discard_granularity aligned LBA.
>>>>> +		 * - If yes: use bio_aligned_discard_max_sectors() as the max
>>>>> +		 *   possible bi_size of th first split bio. Then when this bio
>>>>> +		 *   is split in device drive, the split ones are always easier
>>>>> +		 *   to be aligned to max_discard_sectors of the device's queue.
>>>>> +		 */
>>>>> +		if (granularity_aligned_lba == sector)
>>>>> +			req_sects = min_t(sector_t, nr_sects,
>>>>> +					  bio_aligned_discard_max_sectors(q));
>>>>> +		else
>>>>> +			req_sects = min_t(sector_t, nr_sects,
>>>>> +					  granularity_aligned_lba - sector);
>>>>
>>>> min_non_zero() may be cleaner.
>>>
>>> It seems no value in these two min_t() can be zero.
>>>
>>> Could you please give me more hint ?
>>
>> Looks I misunderstood it, so it is fine in this way.
>>
>>>
>>>
>>>
>>>>>  
>>>>>  		WARN_ON_ONCE((req_sects << 9) > UINT_MAX);
>>>>>  
>>>>> diff --git a/block/blk.h b/block/blk.h
>>>>> index 0a94ec68af32..dc5369e7e1fb 100644
>>>>> --- a/block/blk.h
>>>>> +++ b/block/blk.h
>>>>> @@ -292,6 +292,21 @@ static inline unsigned int bio_allowed_max_sectors(struct request_queue *q)
>>>>>  	return round_down(UINT_MAX, queue_logical_block_size(q)) >> 9;
>>>>>  }
>>>>>  
>>>>> +/*
>>>>> + * The max bio size which is aligned to q->limits.max_discard_sectors. This
>>>>> + * is a hint to split large discard bio in generic block layer, then if device
>>>>> + * driver needs to split the discard bio into smaller ones, their bi_size can
>>>>> + * be very probably and easily ligned to max_discard_sectors of the device's
>>>>> + * queue.
>>>>> + */
>>>>> +static inline unsigned int bio_aligned_discard_max_sectors(
>>>>> +					struct request_queue *q)
>>>>> +{
>>>>> +	return round_down(UINT_MAX,
>>>>> +			 (q->limits.max_discard_sectors << SECTOR_SHIFT))
>>>>> +			>> SECTOR_SHIFT;
>>>>> +}
>>>>
>>>> The above may not be correct, what if q->limits.max_discard_sectors is
>>>> less enough? raid10 may use default 512k max discard bytes. Then
>>>> bio_aligned_discard_max_sectors() can return bigger value than
>>>> q->limits.max_discard_sectors, and breaks this discard limit.
>>>
>>> It seems like I should use roundup() indeed. Thanks for the hint, let me
>>> improve in v3 patch.
>>
>> Actually, bio_aligned_discard_max_sectors() needn't to be <=
>> q->limits.max_discard_sectors because we will split this discard
>> request.
>>
>> Thinking of the issue further, the above stuff should have been done
>> in blk_bio_discard_split() instead of __blkdev_issue_discard() in which
>> we should simply create/submit one non-overflow bio, and shouldn't care
>> the granularity aligned stuff. blk_bio_discard_split() is supposed to
>> consider all kinds of queue limit and decide how to split.
> 
> oops, I know the story now, that is we only have 32bit .bi_size, so
> split code can't make prefect discard bio.
> 
> Then your patch is fine after overflow is fixed in bio_aligned_discard_max_sectors,
> given detailed comment is provided.

Sure I will post the improved v3 patch for your reviews.

Thanks.

Coly Li
