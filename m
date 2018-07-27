Return-Path: <keith.busch@intel.com>
Date: Fri, 27 Jul 2018 11:04:34 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 5/5] blk-mq: Rework blk-mq timeout handling again
Message-ID: <20180727170433.GD20829@localhost.localdomain>
References: <20180727162042.13425-1-bart.vanassche@wdc.com>
 <20180727162042.13425-6-bart.vanassche@wdc.com>
 <20180727164627.GB20829@localhost.localdomain>
 <08bd5d1c691e2c8f9950f7ebcf04716507a02675.camel@wdc.com>
 <20180727165718.GC20829@localhost.localdomain>
 <fca08072e67fc8a8a9c9acfe130753ee7020f4fe.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fca08072e67fc8a8a9c9acfe130753ee7020f4fe.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 27, 2018 at 04:59:34PM +0000, Bart Van Assche wrote:
> On Fri, 2018-07-27 at 10:57 -0600, Keith Busch wrote:
> > You skip that code if the driver returns BLK_EH_DONT_RESET_TIMER.
> 
> How about applying the following patch on top of this series?

That works for me if you, but it breaks scsi again when
scmd_eh_abort_handler completes the command a second time.

 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a97ab5ba9d18..aa66535604fd 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -854,10 +854,10 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
>  	 * latter case, if blk_mq_complete_request() was called while
>  	 * the timeout handler was in progress, ignore that call.
>  	 */
> -	if (ret == BLK_EH_DONT_RESET_TIMER)
> -		return;
> -	WARN_ON_ONCE(ret != BLK_EH_RESET_TIMER);
> -	blk_mq_add_timer(req);
> +	if (ret == BLK_EH_RESET_TIMER)
> +		blk_mq_add_timer(req);
> +	else
> +		WARN_ON_ONCE(ret != BLK_EH_DONT_RESET_TIMER);
>  again:
>  	if (blk_mq_change_rq_state(req, MQ_RQ_TIMED_OUT, MQ_RQ_IN_FLIGHT))
>  		return;
> 
> Bart.
