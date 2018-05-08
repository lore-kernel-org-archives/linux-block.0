Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/4] block: break discard submissions into the user
 defined size
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 dchinner@redhat.com, hch@lst.de
References: <1525709615-14395-1-git-send-email-axboe@kernel.dk>
 <1525709615-14395-2-git-send-email-axboe@kernel.dk>
 <20180508204318.GB27324@vader>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a481ea48-329e-7f68-ff5c-0737b2c25a8c@kernel.dk>
Date: Tue, 8 May 2018 14:57:11 -0600
MIME-Version: 1.0
In-Reply-To: <20180508204318.GB27324@vader>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/8/18 2:43 PM, Omar Sandoval wrote:
> On Mon, May 07, 2018 at 10:13:32AM -0600, Jens Axboe wrote:
>> Don't build discards bigger than what the user asked for, if the
>> user decided to limit the size by writing to 'discard_max_bytes'.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/blk-lib.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-lib.c b/block/blk-lib.c
>> index a676084d4740..7417d617091b 100644
>> --- a/block/blk-lib.c
>> +++ b/block/blk-lib.c
>> @@ -62,10 +62,11 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>>  		unsigned int req_sects;
>>  		sector_t end_sect, tmp;
>>  
>> -		/* Make sure bi_size doesn't overflow */
>> -		req_sects = min_t(sector_t, nr_sects, UINT_MAX >> 9);
>> +		/* Issue in chunks of the user defined max discard setting */
>> +		req_sects = min_t(sector_t, nr_sects,
>> +					q->limits.max_discard_sectors);
>>  
> 
> Some drivers, including nvme, do
> 
>    blk_queue_max_discard_sectors(q, UINT_MAX)
> 
> That means q->limits.max_discard_sectors can be UINT_MAX, and
> 
>     bio->bi_iter.bi_size = req_sects << 9;
> 
> will overflow. We should probably cap max_discard_sectors at
> UINT_MAX >> 9 in a prep patch.

Probably better to just keep the local overflow check, I'll do that.
Thanks for spotting it!

-- 
Jens Axboe
