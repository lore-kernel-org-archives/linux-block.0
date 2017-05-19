Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX] block, bfq: access and cache blkg data only when
 safe
To: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, linus.walleij@linaro.org, broonie@kernel.org
References: <20170519083908.2588-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a2b424cb-202a-5a0d-8850-dd5e3332dd8b@kernel.dk>
Date: Fri, 19 May 2017 08:37:07 -0600
MIME-Version: 1.0
In-Reply-To: <20170519083908.2588-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/19/2017 02:39 AM, Paolo Valente wrote:
> @@ -692,8 +725,7 @@ void bfq_pd_offline(struct blkg_policy_data *pd)
>  		/*
>  		 * The idle tree may still contain bfq_queues belonging
>  		 * to exited task because they never migrated to a different
> -		 * cgroup from the one being destroyed now.  No one else
> -		 * can access them so it's safe to act without any lock.
> ++                * cgroup from the one being destroyed now.
>  		 */
>  		bfq_flush_idle_tree(st);
>  

Looks like an extra '+' snuck into that hunk.

-- 
Jens Axboe
