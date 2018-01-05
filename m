Return-Path: <axboe@kernel.dk>
Subject: Re: [for-416 PATCH 1/2] bcache: Fix, improve efficiency of
 closure_sync()
To: Michael Lyle <mlyle@lyle.org>, linux-bcache@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>
References: <20171230230934.910-1-mlyle@lyle.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cfee0947-24bd-c45a-5219-81ae6a208069@kernel.dk>
Date: Fri, 5 Jan 2018 09:05:14 -0700
MIME-Version: 1.0
In-Reply-To: <20171230230934.910-1-mlyle@lyle.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/30/17 4:09 PM, Michael Lyle wrote:
> +void __closure_sync(struct closure *cl)
> +{
> +	struct closure_syncer s = { .task = current };
>  
> +	cl->s = &s;
> +	continue_at(cl, closure_sync_fn, NULL);
> +
> +	while (1) {
> +		__set_current_state(TASK_UNINTERRUPTIBLE);
> +		smp_mb(); /* Ensure task state set before load of done flag */

That's why we have set_current_state().

-- 
Jens Axboe
