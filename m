Return-Path: <ming.lei@redhat.com>
Date: Fri, 19 Oct 2018 09:28:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
	Dave Chinner <dchinner@redhat.com>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"Darrick J . Wong" <darrick.wong@oracle.com>, xfs@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/5] block: warn on un-aligned DMA IO buffer
Message-ID: <20181019012805.GA13384@ming.t460p>
References: <20181018131817.11813-1-ming.lei@redhat.com>
 <20181018131817.11813-2-ming.lei@redhat.com>
 <cdc2f78a-4c97-0b71-e4d3-08bfcca6b42e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cdc2f78a-4c97-0b71-e4d3-08bfcca6b42e@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 18, 2018 at 08:27:28AM -0600, Jens Axboe wrote:
> On 10/18/18 7:18 AM, Ming Lei wrote:
> > Now we only check if DMA IO buffer is aligned to queue_dma_alignment()
> > for pass-through request, and it isn't done for normal IO request.
> > 
> > Given the check has to be done on each bvec, it isn't efficient to add the
> > check in generic_make_request_checks().
> > 
> > This patch addes one WARN in blk_queue_split() for capturing this issue.
> 
> I don't want to do this, because then we are forever doomed to
> have something that fully loops a bio at submission time. I
> absolutely hate the splitting we have and the need for it,
> hopefully it can go away for a subset of IOs at some point.
> 
> In many ways, this seems to be somewhat of a made-up problem, I don't
> recall a single bug report for something like this over decades of
> working with the IO stack. 512b alignment restrictions for DMA seems
> absolutely insane. I know people claim they exist, but clearly that
> isn't a hard requirement or we would have been boned years ago.

There are still some drivers with this requirement:

drivers/ata/libata-scsi.c:1308: blk_queue_update_dma_alignment(q, sdev->sector_size - 1);
drivers/ata/pata_macio.c:812:           blk_queue_update_dma_alignment(sdev->request_queue, 31);
drivers/ata/pata_macio.c:827:           blk_queue_update_dma_alignment(sdev->request_queue, 15);
drivers/block/ps3disk.c:470:    blk_queue_dma_alignment(queue, dev->blk_size-1);
drivers/block/rsxx/dev.c:282:           blk_queue_dma_alignment(card->queue, blk_size - 1);
drivers/block/xen-blkfront.c:957:       blk_queue_dma_alignment(rq, 511);
drivers/ide/ide-cd.c:1512:      blk_queue_dma_alignment(q, 31);
drivers/message/fusion/mptscsih.c:2388: blk_queue_dma_alignment (sdev->request_queue, 512 - 1);
drivers/staging/rts5208/rtsx.c:94:      blk_queue_dma_alignment(sdev->request_queue, (512 - 1));
drivers/usb/image/microtek.c:329:       blk_queue_dma_alignment(s->request_queue, (512 - 1));
drivers/usb/storage/scsiglue.c:92:      blk_queue_update_dma_alignment(sdev->request_queue, (512 - 1));
drivers/usb/storage/uas.c:818:  blk_queue_update_dma_alignment(sdev->request_queue, (512 - 1));


Thanks,
Ming
