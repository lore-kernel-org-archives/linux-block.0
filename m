Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/5] block: warn on un-aligned DMA IO buffer
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Dave Chinner <dchinner@redhat.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, xfs@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
 Matthew Wilcox <willy@infradead.org>
References: <20181018131817.11813-1-ming.lei@redhat.com>
 <20181018131817.11813-2-ming.lei@redhat.com>
 <cdc2f78a-4c97-0b71-e4d3-08bfcca6b42e@kernel.dk>
 <20181019012805.GA13384@ming.t460p>
 <2d9acd14-89ca-2304-75da-6e15240119f3@kernel.dk>
 <20181019013912.GB13384@ming.t460p>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2cf11c18-aea5-0783-3163-fba3b59bbde2@kernel.dk>
Date: Thu, 18 Oct 2018 19:52:59 -0600
MIME-Version: 1.0
In-Reply-To: <20181019013912.GB13384@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/18/18 7:39 PM, Ming Lei wrote:
> On Thu, Oct 18, 2018 at 07:33:50PM -0600, Jens Axboe wrote:
>> On 10/18/18 7:28 PM, Ming Lei wrote:
>>> On Thu, Oct 18, 2018 at 08:27:28AM -0600, Jens Axboe wrote:
>>>> On 10/18/18 7:18 AM, Ming Lei wrote:
>>>>> Now we only check if DMA IO buffer is aligned to queue_dma_alignment()
>>>>> for pass-through request, and it isn't done for normal IO request.
>>>>>
>>>>> Given the check has to be done on each bvec, it isn't efficient to add the
>>>>> check in generic_make_request_checks().
>>>>>
>>>>> This patch addes one WARN in blk_queue_split() for capturing this issue.
>>>>
>>>> I don't want to do this, because then we are forever doomed to
>>>> have something that fully loops a bio at submission time. I
>>>> absolutely hate the splitting we have and the need for it,
>>>> hopefully it can go away for a subset of IOs at some point.
>>>>
>>>> In many ways, this seems to be somewhat of a made-up problem, I don't
>>>> recall a single bug report for something like this over decades of
>>>> working with the IO stack. 512b alignment restrictions for DMA seems
>>>> absolutely insane. I know people claim they exist, but clearly that
>>>> isn't a hard requirement or we would have been boned years ago.
>>>
>>> There are still some drivers with this requirement:
>>>
>>> drivers/ata/libata-scsi.c:1308: blk_queue_update_dma_alignment(q, sdev->sector_size - 1);
>>> drivers/ata/pata_macio.c:812:           blk_queue_update_dma_alignment(sdev->request_queue, 31);
>>> drivers/ata/pata_macio.c:827:           blk_queue_update_dma_alignment(sdev->request_queue, 15);
>>> drivers/block/ps3disk.c:470:    blk_queue_dma_alignment(queue, dev->blk_size-1);
>>> drivers/block/rsxx/dev.c:282:           blk_queue_dma_alignment(card->queue, blk_size - 1);
>>> drivers/block/xen-blkfront.c:957:       blk_queue_dma_alignment(rq, 511);
>>> drivers/ide/ide-cd.c:1512:      blk_queue_dma_alignment(q, 31);
>>> drivers/message/fusion/mptscsih.c:2388: blk_queue_dma_alignment (sdev->request_queue, 512 - 1);
>>> drivers/staging/rts5208/rtsx.c:94:      blk_queue_dma_alignment(sdev->request_queue, (512 - 1));
>>> drivers/usb/image/microtek.c:329:       blk_queue_dma_alignment(s->request_queue, (512 - 1));
>>> drivers/usb/storage/scsiglue.c:92:      blk_queue_update_dma_alignment(sdev->request_queue, (512 - 1));
>>> drivers/usb/storage/uas.c:818:  blk_queue_update_dma_alignment(sdev->request_queue, (512 - 1));
>>
>> Of course, I too can grep :-)
>>
>> My point is that these settings might not match reality. And the
>> WARN_ON(), as implemented, is going to trigger on any device that
>> DOESN'T set the alignment, as Bart pointed out.
> 
> It is just a WARN_ON_ONCE() which exactly shows something which need
> further attention, then related people may take a look and we can move
> on.
> 
> So I think it is correct thing to do.

It most certainly is NOT the right thing to do, when we know that:

1) We currently have drivers setting an alignment that we don't meet
2) We have drivers not setting an alignment, and getting 512 by default
3) We have drivers setting an alignment that seems incorrect

It's something that can be debated once everything else has been
done, it's most certainly not something that should be done upfront
when we KNOW it'll trigger for cases. WARN_ON_ONCE() can be useful
to figure out if an invalid condition triggers, it's pointless to
add it for cases that we know exactly how they will trigger.

-- 
Jens Axboe
