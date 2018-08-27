Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To: Jens Axboe <axboe@kernel.dk>, Anchal Agarwal <anchalag@amzn.com>
Cc: fllinden@amazon.com,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
 <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
 <20180824181223.GA9049@kaos-source-ops-60001.pdx1.amazon.com>
 <677c8648-63fd-601c-b906-40a8502f9782@kernel.dk>
 <20180824203305.GA4690@kaos-source-ops-60001.pdx1.amazon.com>
 <dc734449-7cd8-3a8e-9fdc-d7d854393900@kernel.dk>
 <2fecf2f2-f00b-f6ba-710a-54ceaacfedbb@kernel.dk>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <00445460-d826-4d85-c5f4-fa565892da01@oracle.com>
Date: Mon, 27 Aug 2018 11:52:26 +0800
MIME-Version: 1.0
In-Reply-To: <2fecf2f2-f00b-f6ba-710a-54ceaacfedbb@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens

On 08/25/2018 11:41 PM, Jens Axboe wrote:
>  	do {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> +		if (test_bit(0, &data.flags))
> +			break;
>  
> -		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
> +		WARN_ON_ONCE(list_empty(&data.wq.entry));
> +
> +		if (!has_sleeper &&
> +		    rq_wait_inc_below(rqw, get_limit(rwb, rw))) {
> +			finish_wait(&rqw->wait, &data.wq);
> +
> +			/*
> +			 * We raced with wbt_wake_function() getting a token,
> +			 * which means we now have two. Put ours and wake
> +			 * anyone else potentially waiting for one.
> +			 */
> +			if (test_bit(0, &data.flags))
> +				wbt_rqw_done(rwb, rqw, wb_acct);
>  			break;

Just use 'bool' variable should be OK 
After finish_wait, no one could race with us here.

> +		}
>  
>  		if (lock) {
>  			spin_unlock_irq(lock);
> @@ -511,11 +569,11 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
>  			spin_lock_irq(lock);
>  		} else
>  			io_schedule();
> +
>  		has_sleeper = false;
>  	} while (1);

I cannot get the point of "since we can't rely on just being woken from the ->func handler
we set".
Do you mean there could be someone else could wake up this task ?

Thanks
Jianchao
