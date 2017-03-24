Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Fri, 24 Mar 2017 11:03:31 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: include errors in did_work calculation
Message-ID: <20170324180331.GB16134@vader.DHCP.thefacebook.com>
References: <f82c3ba7-2c19-1bf4-a68b-1793b3a2ac4e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f82c3ba7-2c19-1bf4-a68b-1793b3a2ac4e@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Mar 24, 2017 at 11:39:10AM -0600, Jens Axboe wrote:
> Currently we return true in blk_mq_dispatch_rq_list() if we queued IO
> successfully, but we really want to return whether or not the we made
> progress. Progress includes if we got an error return.  If we don't,
> this can lead to a hang in blk_mq_sched_dispatch_requests() when a
> driver is draining IO by returning BLK_MQ_QUEUE_ERROR instead of
> manually ending the IO in error and return BLK_MQ_QUEUE_OK.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>

Reviewed-by: Omar Sandoval <osandov@fb.com>
