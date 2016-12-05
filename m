Return-Path: <jthumshirn@suse.de>
Date: Mon, 5 Dec 2016 10:01:05 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, paolo.valente@linaro.org
Subject: Re: [PATCH 3/7] block: use appropriate queue running functions
Message-ID: <20161205090105.GB8481@linux-x5ow.site>
References: <1480734921-23701-1-git-send-email-axboe@fb.com>
 <1480734921-23701-4-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1480734921-23701-4-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 02, 2016 at 08:15:17PM -0700, Jens Axboe wrote:
> Use MQ variants for MQ, legacy ones for legacy.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-core.c  |  5 ++++-
>  block/blk-exec.c  | 10 ++++++++--
>  block/blk-flush.c | 14 ++++++++++----
>  block/elevator.c  |  5 ++++-
>  4 files changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 0e23589ab3bf..3591f5419509 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -340,7 +340,10 @@ void __blk_run_queue(struct request_queue *q)
>  	if (unlikely(blk_queue_stopped(q)))
>  		return;
>  
> -	__blk_run_queue_uncond(q);

I don't quite get the WARN_ON_ONCE() is it for debug purposes? And similarly
blk_use_mq_path() + the other occurences below as well?


-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
