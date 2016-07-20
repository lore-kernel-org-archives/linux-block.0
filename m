Return-Path: <axboe@kernel.dk>
Subject: Re: resend: passthrough request improvements V3
To: Christoph Hellwig <hch@lst.de>
References: <1468920714-4304-1-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9b9d20f6-6dc9-4ff2-bbd1-0ed3beaac47f@kernel.dk>
Date: Wed, 20 Jul 2016 17:38:56 -0600
MIME-Version: 1.0
In-Reply-To: <1468920714-4304-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 07/19/2016 03:31 AM, Christoph Hellwig wrote:
> These days we have a lot more users of struct request for driver internal
> use than just REQ_TYPE_BLOCK_PC, so let's polish this infrastructure
> up a bit.
>
> Unchanged from the last post on June 16th.
>
> Changes since V2:
>  - really drop zeroing ->cmd from blk_get_request
>  - add ACK from Boaz
>
> Changes since V1:
>  - keep blk_rq_set_block_pc for now and leave zeroing ->cmd in it

Added to 4.8, thanks.

-- 
Jens Axboe
