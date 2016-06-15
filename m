Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/7] block: ensure bios return from blk_get_request are
 properly initialized
To: Christoph Hellwig <hch@lst.de>
References: <1465924564-14503-1-git-send-email-hch@lst.de>
 <1465924564-14503-4-git-send-email-hch@lst.de> <5761199A.1070400@kernel.dk>
 <20160615100712.GA16425@lst.de>
Cc: mst@redhat.com, ooo@electrozaur.com, nab@linux-iscsi.org,
 linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <57612B4B.90509@kernel.dk>
Date: Wed, 15 Jun 2016 12:17:47 +0200
MIME-Version: 1.0
In-Reply-To: <20160615100712.GA16425@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/15/2016 12:07 PM, Christoph Hellwig wrote:
> On Wed, Jun 15, 2016 at 11:02:18AM +0200, Jens Axboe wrote:
>> On 06/14/2016 07:16 PM, Christoph Hellwig wrote:
>>> blk_get_request is used for BLOCK_PC and similar passthrough requests.
>>> Currently we always need to call blk_rq_set_block_pc or an open coded
>>> version of it to allow appending bios using the request mapping helpers
>>> later on, which is a somewhat awkward API.  Instead move the
>>> initialization part of blk_rq_set_block_pc into blk_get_request, so that
>>> we always have a safe to use request.
>>
>> This still puts the pc related memset() into the normal fast path...
>
> Oops, I missed removing it from the alloc path when adding back
> blk_rq_set_block_pc, will fix it up.
>
> But I have to object to this actually being a fast path - it's not
> used for any fs request, just BLOCK_PC, NVMe passthrough and various
> driver specific little hacks.

I guess you are right, the fs path jumps in via 
__blk_mq_alloc_request(), so not fs fast path. But it'd still be nice to 
properly fix this. Can it wait until the rq->pc mess is resolved?

-- 
Jens Axboe
