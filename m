Return-Path: <axboe@kernel.dk>
Subject: Re: remove the legacy BLKPREP_* values
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org
References: <20181109134241.29346-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <28e4f89c-e374-c19f-cee2-4505e98a43c0@kernel.dk>
Date: Fri, 9 Nov 2018 08:51:56 -0700
MIME-Version: 1.0
In-Reply-To: <20181109134241.29346-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/9/18 6:42 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series gets rid of the old BLKPREP_* values from the legacy block
> layer in favor of always using a blk_status_t (or a bool in one case).

Series looks good to me, tested the IDE bits too. I'm assuming we'll
take this through the block tree with the dependencies, I'll wait
a bit to let folks take a closer look.

-- 
Jens Axboe
