Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51993 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755117AbdDFGxa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Apr 2017 02:53:30 -0400
Date: Thu, 6 Apr 2017 08:53:27 +0200
From: Michal Hocko <mhocko@kernel.org>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH v2] loop: Add PF_LESS_THROTTLE to block/loop device
 thread.
Message-ID: <20170406065326.GB5497@dhcp22.suse.cz>
References: <871staffus.fsf@notabene.neil.brown.name>
 <87wpazh3rl.fsf@notabene.neil.brown.name>
 <20170405071927.GA7258@dhcp22.suse.cz>
 <20170405073233.GD6035@dhcp22.suse.cz>
 <878tnegtoo.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <878tnegtoo.fsf@notabene.neil.brown.name>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu 06-04-17 12:23:51, NeilBrown wrote:
[...]
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 0ecb6461ed81..95679d988725 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -847,10 +847,12 @@ static void loop_unprepare_queue(struct loop_device *lo)
>  static int loop_prepare_queue(struct loop_device *lo)
>  {
>  	kthread_init_worker(&lo->worker);
> -	lo->worker_task = kthread_run(kthread_worker_fn,
> +	lo->worker_task = kthread_create(kthread_worker_fn,
>  			&lo->worker, "loop%d", lo->lo_number);
>  	if (IS_ERR(lo->worker_task))
>  		return -ENOMEM;
> +	lo->worker_task->flags |= PF_LESS_THROTTLE;
> +	wake_up_process(lo->worker_task);
>  	set_user_nice(lo->worker_task, MIN_NICE);
>  	return 0;

This should work for the current implementation because kthread_create
will return only after the full initialization has been done. No idea
whether we can rely on that in future. I also think it would be cleaner
to set the flag on current and keep the current semantic that only
current changes its flags.

So while I do not have a strong opinion on this I think defining loop
specific thread function which set PF_LESS_THROTTLE as the first thing
is more elegant and less error prone longerm. A short comment explaining
why we use the flag there would be also preferred.

I will leave the decision to you.

Thanks.

-- 
Michal Hocko
SUSE Labs
