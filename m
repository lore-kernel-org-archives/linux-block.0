Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/5] ide: kill ide_toggle_bounce
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
References: <20180424181625.22410-1-hch@lst.de>
 <20180424181625.22410-3-hch@lst.de>
 <5aaca0d3-417f-57f3-969f-b4c777c3fd48@kernel.dk>
 <20180426072033.GA14700@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <682db9af-33bc-639d-8930-7a66c30bc644@kernel.dk>
Date: Thu, 26 Apr 2018 09:11:21 -0600
MIME-Version: 1.0
In-Reply-To: <20180426072033.GA14700@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/26/18 1:20 AM, Christoph Hellwig wrote:
> On Tue, Apr 24, 2018 at 08:02:56PM -0600, Jens Axboe wrote:
>> On 4/24/18 12:16 PM, Christoph Hellwig wrote:
>>> ide_toggle_bounce did select various strange block bounce limits, including
>>> not bouncing at all as soon as an iommu is present in the system.  Given
>>> that the dma_map routines now handle any required bounce buffering except
>>> for ISA DMA, and the ide code already must handle either ISA DMA or highmem
>>> at least for iommu equipped systems we can get rid of the block layer
>>> bounce limit setting entirely.
>>
>> Pretty sure I was the one to add this code, when highmem page IO was
>> enabled about two decades ago...
>>
>> Outside of DMA, the issue was that the PIO code could not handle
>> highmem. That's not the case anymore, so this should be fine.
> 
> Yes, that is the rationale.  Any chance to you could look over the
> other patches as well?  Except for the networking one for which I'd
> really like to see a review from Dave all the users of the interface
> are block related.

You can add my reviewed-by to 1-3, and 5. Looks good to me.

-- 
Jens Axboe
