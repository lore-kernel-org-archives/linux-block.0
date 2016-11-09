Return-Path: <axboe@kernel.dk>
Subject: Re: BUG: Hung task timeouts in for-4.10/dio
To: Damien Le Moal <damien.lemoal@wdc.com>, Christoph Hellwig <hch@lst.de>
References: <8eed541f-b4c2-37c9-6650-216f3d0aa92f@fb.com>
 <21f0cddd-28d9-790d-b4fc-4635cca77ea8@deltatee.com>
 <9fe151a1-2d9f-28ef-25a7-bbcb01d8d972@fb.com>
 <c2d69ddc-28c9-bf26-5b06-74d00e88a700@deltatee.com>
 <6997fb64-aaac-208f-fa89-b8b4567f7321@fb.com>
 <a74de948-3026-d9b3-6b2e-b9cc1f3c05d4@deltatee.com>
 <6d532d4a-8d35-f610-65ed-efef949a3686@fb.com>
 <84693d82-b8dc-42b3-03da-055def7499a0@deltatee.com>
 <1e0e590b-fde3-a86d-bc60-8e5465928533@fb.com>
 <84cf8089-7d6d-0146-49fb-91a2d08650b2@wdc.com>
 <20161109010959.GA32126@lst.de>
 <b3d8c5fa-b930-b21f-3986-1ff94611c7f9@wdc.com>
 <a6d1d368-04a2-e999-a610-abd96add81a9@fb.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 Mike Snitzer <snitzer@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <03cda65e-3a82-6ccd-861b-67a55888eb19@kernel.dk>
Date: Tue, 8 Nov 2016 19:02:52 -0700
MIME-Version: 1.0
In-Reply-To: <a6d1d368-04a2-e999-a610-abd96add81a9@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/08/2016 06:28 PM, Jens Axboe wrote:
> On 11/08/2016 06:25 PM, Damien Le Moal wrote:
>>
>> On 11/9/16 10:09, Christoph Hellwig wrote:
>>> Ok, sounds like I'm really the one to blame.  I'll see if I can
>>> find a reproducer.  Damien, or you using device mapper on that
>>> system?
>>
>> No LVM/md/dm used on boot. Mount is direct to the block device (SSDs
>> with ext4). The devices are simple SSDs, so no polling involved.
>>
>> The hangs suspiciously look like they are either background write or
>> flush. So I was wondering if it is indeed related to FLUSH/FUA as Logan
>> suggested or the background write stuff, rather than the direct-IO
>> optimization & polling.
>
> The background write stuff is not in either of those branches, plus the
> backtrace would have looked different. Yours is showing us waiting for a
> request. I don't think it's the direct-io or polling code, it looks like
> a generic issue.
>
>> Will try again/bisect to see if I can get more info.
>
> Maybe try and revert the one that Logan pointed his finger at, if that
> is doable.

It smells like an accounting error. One thing that I don't like with the
current scheme is the implicit knowledge that certain flags imply sync
as well. If we clear any of those flags, then we screw up accounting at
the end.

Does this make a difference?


diff --git a/block/blk-flush.c b/block/blk-flush.c
index c486b7aa62ee..d70983e28115 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -395,6 +395,8 @@ void blk_insert_flush(struct request *rq)
  	if (!(fflags & (1UL << QUEUE_FLAG_FUA)))
  		rq->cmd_flags &= ~REQ_FUA;

+	rq->cmd_flags |= REQ_SYNC;
+
  	/*
  	 * An empty flush handed down from a stacking driver may
  	 * translate into nothing if the underlying device does not

-- 
Jens Axboe
