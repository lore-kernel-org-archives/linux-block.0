Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RFC 10/14] block, bfq: add Early Queue Merge (EQM)
To: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
 <20170304160131.57366-11-paolo.valente@linaro.org>
Cc: Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
 linus.walleij@linaro.org, broonie@kernel.org,
 Mauro Andreolini <mauro.andreolini@unimore.it>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d37a7169-f279-8244-19f8-440dc1490893@kernel.dk>
Date: Tue, 7 Mar 2017 10:44:00 -0700
MIME-Version: 1.0
In-Reply-To: <20170304160131.57366-11-paolo.valente@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/04/2017 09:01 AM, Paolo Valente wrote:
> @@ -560,6 +600,15 @@ struct bfq_data {
>  	struct bfq_io_cq *bio_bic;
>  	/* bfqq associated with the task issuing current bio for merging */
>  	struct bfq_queue *bio_bfqq;
> +
> +	/*
> +	 * io context to put right after bfqd->lock is released. This
> +	 * filed is used to perform put_io_context, when needed, to
> +	 * after the scheduler lock has been released, and thus
> +	 * prevent an ioc->lock from being possibly taken while the
> +	 * scheduler lock is being held.
> +	 */
> +	struct io_context *ioc_to_put;
>  };

The logic around this is nasty, effectively you end up having locking
around sections of code instea of structures, which is never a good
idea.

The helper functions for unlocking and dropping the ioc add to the mess
as well.

Can't we simply pass back a pointer to an ioc to free? That should be
possible, given that we must have grabbed the bfqd lock ourselves
further up in the call chain. So we _know_ that we'll drop it later on.
If that wasn't the case, the existing logic wouldn't work.

-- 
Jens Axboe
