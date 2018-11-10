Return-Path: <axboe@kernel.dk>
Subject: Re: remove the legacy BLKPREP_* values
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org
References: <20181109134241.29346-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d1ae861c-67b9-d6d2-01ff-708040b6ed0e@kernel.dk>
Date: Sat, 10 Nov 2018 08:17:26 -0700
MIME-Version: 1.0
In-Reply-To: <20181109134241.29346-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/9/18 6:42 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series gets rid of the old BLKPREP_* values from the legacy block
> layer in favor of always using a blk_status_t (or a bool in one case).

Applied

-- 
Jens Axboe
