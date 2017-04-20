Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Remove blk_mq_sched_move_to_dispatch()
To: Bart Van Assche <bart.vanassche@sandisk.com>
References: <20170420232519.19906-1-bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
 Hannes Reinecke <hare@suse.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8e6b165f-8915-936f-3217-86d3992a5cfc@kernel.dk>
Date: Thu, 20 Apr 2017 17:28:51 -0600
MIME-Version: 1.0
In-Reply-To: <20170420232519.19906-1-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/20/2017 05:25 PM, Bart Van Assche wrote:
> commit c13660a08c8b ("blk-mq-sched: change ->dispatch_requests()
> to ->dispatch_request()") removed the last user of this function.
> Hence also remove the function itself.

Thanks Bart, added.

-- 
Jens Axboe
