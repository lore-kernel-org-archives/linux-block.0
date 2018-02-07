Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Feb 2018 13:40:09 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq: Fix race between resetting the timer and
 completion handling
Message-ID: <20180207214009.GG695913@devbig577.frc2.facebook.com>
References: <20180207011133.25957-1-bart.vanassche@wdc.com>
 <20180207170612.GB695913@devbig577.frc2.facebook.com>
 <1518030233.2870.57.camel@wdc.com>
 <20180207200951.GE695913@devbig577.frc2.facebook.com>
 <1518037339.2870.61.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518037339.2870.61.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Wed, Feb 07, 2018 at 09:02:21PM +0000, Bart Van Assche wrote:
> The patch that I used in my test had an smp_wmb() call (see also below). Anyway,
> I will see whether I can extract more state information through debugfs.
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ef4f6df0f1df..8eb2105d82b7 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -827,13 +827,9 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
>  		__blk_mq_complete_request(req);
>  		break;
>  	case BLK_EH_RESET_TIMER:
> -		/*
> -		 * As nothing prevents from completion happening while
> -		 * ->aborted_gstate is set, this may lead to ignored
> -		 * completions and further spurious timeouts.
> -		 */
> -		blk_mq_rq_update_aborted_gstate(req, 0);
>  		blk_add_timer(req);
> +		smp_wmb();
> +		blk_mq_rq_update_aborted_gstate(req, 0);

Without the matching rmb, just adding rmb won't do much but given the
default strong ordering on x86 and other operations around, what you
were seeing is probably not caused by lack of barriers.

Thanks.

-- 
tejun
