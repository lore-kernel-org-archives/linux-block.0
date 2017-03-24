Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: include errors in did_work calculation
Date: Fri, 24 Mar 2017 18:01:45 +0000
Message-ID: <1490378491.3312.13.camel@sandisk.com>
References: <f82c3ba7-2c19-1bf4-a68b-1793b3a2ac4e@kernel.dk>
In-Reply-To: <f82c3ba7-2c19-1bf4-a68b-1793b3a2ac4e@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-03-24 at 11:39 -0600, Jens Axboe wrote:
> Currently we return true in blk_mq_dispatch_rq_list() if we queued IO
> successfully, but we really want to return whether or not the we made
> progress. Progress includes if we got an error return.  If we don't,
> this can lead to a hang in blk_mq_sched_dispatch_requests() when a
> driver is draining IO by returning BLK_MQ_QUEUE_ERROR instead of
> manually ending the IO in error and return BLK_MQ_QUEUE_OK.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=
