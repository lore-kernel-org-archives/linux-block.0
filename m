Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/3] Fixes for kernel v4.13
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20170621175547.21692-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c20beee0-b377-25f3-2235-143298c2563f@kernel.dk>
Date: Wed, 21 Jun 2017 12:01:29 -0600
MIME-Version: 1.0
In-Reply-To: <20170621175547.21692-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/21/2017 11:55 AM, Bart Van Assche wrote:
> Hello Jens,
> 
> The three patches in this series fix issues in the patches that are queued
> for kernel v4.13. Please consider these for kernel v4.13.
> 
> Thanks,
> 
> Bart.
> 
> Bart Van Assche (3):
>   block: Declare local symbols static
>   block: Fix off-by-one errors in blk_status_to_errno() and
>     print_req_error()
>   blk-mq: Make it safe to quiesce and unquiesce from an interrupt
>     handler

Looks good to me, applied.

-- 
Jens Axboe
