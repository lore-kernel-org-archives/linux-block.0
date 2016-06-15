Return-Path: <hch@lst.de>
Date: Wed, 15 Jun 2016 12:25:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, mst@redhat.com, ooo@electrozaur.com,
	nab@linux-iscsi.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/7] block: ensure bios return from blk_get_request are
	properly initialized
Message-ID: <20160615102518.GA16734@lst.de>
References: <1465924564-14503-1-git-send-email-hch@lst.de> <1465924564-14503-4-git-send-email-hch@lst.de> <5761199A.1070400@kernel.dk> <20160615100712.GA16425@lst.de> <57612B4B.90509@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57612B4B.90509@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 15, 2016 at 12:17:47PM +0200, Jens Axboe wrote:
> I guess you are right, the fs path jumps in via __blk_mq_alloc_request(), 
> so not fs fast path. But it'd still be nice to properly fix this. Can it 
> wait until the rq->pc mess is resolved?

I'll resend the series removing the memset in the blk_get_request path,
which I think is very useful for now as the requests currently returned
from blk_get_request / blk_mq_alloc_request are inherently dangerous.
req->cmd zeroing is really just a workaround broken devices in practice,
as spec complicant scsi device never should look at the cmd array
beyond the command length.

I'll try to expedite the pc_request split, but I'd really like to get
all the NVMe over Fabrics work in first, as we'd be in merge hell otherwise.
