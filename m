Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Subject: Re: [PATCH] blk: optimization for classic polling
To: Keith Busch <keith.busch@intel.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Cc: axboe@fb.com, joshi.k@samsung.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
References: <CGME20180208143655epcas1p444bf34705526b7839a5a135f82761aad@epcas1p4.samsung.com>
 <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
 <20180208152730.GA4906@localhost.localdomain>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2fa9340f-302b-1531-d51b-d4bfbdf50f86@grimberg.me>
Date: Thu, 8 Feb 2018 18:03:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180208152730.GA4906@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>


> I think it'd be simpler to have blk_poll set it back to running if
> need_resched is true rather than repeat this patter across all the
> callers:
> 
> ---
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index df93102e2149..40285fe1c8ad 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3164,6 +3164,7 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
>   		cpu_relax();
>   	}
>   
> +	set_current_state(TASK_RUNNING);
>   	return false;
>   }
>   
> --

Nice!
