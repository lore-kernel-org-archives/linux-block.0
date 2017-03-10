Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] don't forget to call pd_online_fn when activate policy
To: Zhou Chengming <zhouchengming1@huawei.com>
References: <1489026008-161611-1-git-send-email-zhouchengming1@huawei.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 miaoxie@huawei.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <54047101-8ad6-a4fd-dda6-25c2551a3a3c@kernel.dk>
Date: Fri, 10 Mar 2017 08:12:29 -0700
MIME-Version: 1.0
In-Reply-To: <1489026008-161611-1-git-send-email-zhouchengming1@huawei.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/08/2017 07:20 PM, Zhou Chengming wrote:
> When we activate policy on the request_queue, we will create policy_date
> for all the existing blkgs of the request_queue, so we should call
> pd_init_fn() and pd_online_fn() on these newly created policy_data.
> 
> Signed-off-by: Zhou Chengming <zhouchengming1@huawei.com>
> ---
>  block/blk-cgroup.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 8ba0af7..0dd9e76 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1254,6 +1254,12 @@ int blkcg_activate_policy(struct request_queue *q,
>  		pd->plid = pol->plid;
>  		if (pol->pd_init_fn)
>  			pol->pd_init_fn(pd);
> +
> +		if (pol->pd_online_fn) {
> +			spin_lock(blkg->blkcg->lock);
> +			pol->pd_online_fn(pd);
> +			spin_unlock(blkg->blkcg->lock);
> +		}

You didn't even compile this, did you?

-- 
Jens Axboe
