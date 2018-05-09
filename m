Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52234 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbeEIKz0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 May 2018 06:55:26 -0400
Date: Wed, 9 May 2018 12:55:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>,
        Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>,
        Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ruslan Ruslichenko <rruslich@cisco.com>, kernel-team@fb.com
Subject: Re: [PATCH 6/7] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180509105505.GQ12217@hirez.programming.kicks-ass.net>
References: <20180507210135.1823-1-hannes@cmpxchg.org>
 <20180507210135.1823-7-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180507210135.1823-7-hannes@cmpxchg.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 07, 2018 at 05:01:34PM -0400, Johannes Weiner wrote:

> @@ -28,10 +28,14 @@ static inline int sched_info_on(void)
>  	return 1;
>  #elif defined(CONFIG_TASK_DELAY_ACCT)
>  	extern int delayacct_on;
> -	return delayacct_on;
> -#else
> -	return 0;
> +	if (delayacct_on)
> +		return 1;
> +#elif defined(CONFIG_PSI)
> +	extern int psi_disabled;
> +	if (!psi_disabled)
> +		return 1;
>  #endif
> +	return 0;
>  }

> diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
> index 8aea199a39b4..cb4a68bcf37a 100644
> --- a/kernel/sched/stats.h
> +++ b/kernel/sched/stats.h
> @@ -55,12 +55,90 @@ static inline void rq_sched_info_depart  (struct rq *rq, unsigned long long delt
>  # define   schedstat_val_or_zero(var)	0
>  #endif /* CONFIG_SCHEDSTATS */
>  
> +#ifdef CONFIG_PSI
> +/*
> + * PSI tracks state that persists across sleeps, such as iowaits and
> + * memory stalls. As a result, it has to distinguish between sleeps,
> + * where a task's runnable state changes, and requeues, where a task
> + * and its state are being moved between CPUs and runqueues.
> + */
> +static inline void psi_enqueue(struct task_struct *p, u64 now)
> +{
> +	int clear = 0, set = TSK_RUNNING;
> +
> +	if (p->state == TASK_RUNNING || p->sched_psi_wake_requeue) {
> +		if (p->flags & PF_MEMSTALL)
> +			set |= TSK_MEMSTALL;
> +		p->sched_psi_wake_requeue = 0;
> +	} else {
> +		if (p->in_iowait)
> +			clear |= TSK_IOWAIT;
> +	}
> +
> +	psi_task_change(p, now, clear, set);
> +}
> +static inline void psi_dequeue(struct task_struct *p, u64 now)
> +{
> +	int clear = TSK_RUNNING, set = 0;
> +
> +	if (p->state == TASK_RUNNING) {
> +		if (p->flags & PF_MEMSTALL)
> +			clear |= TSK_MEMSTALL;
> +	} else {
> +		if (p->in_iowait)
> +			set |= TSK_IOWAIT;
> +	}
> +
> +	psi_task_change(p, now, clear, set);
> +}
> +static inline void psi_ttwu_dequeue(struct task_struct *p)
> +{
> +	/*
> +	 * Is the task being migrated during a wakeup? Make sure to
> +	 * deregister its sleep-persistent psi states from the old
> +	 * queue, and let psi_enqueue() know it has to requeue.
> +	 */
> +	if (unlikely(p->in_iowait || (p->flags & PF_MEMSTALL))) {
> +		struct rq_flags rf;
> +		struct rq *rq;
> +		int clear = 0;
> +
> +		if (p->in_iowait)
> +			clear |= TSK_IOWAIT;
> +		if (p->flags & PF_MEMSTALL)
> +			clear |= TSK_MEMSTALL;
> +
> +		rq = __task_rq_lock(p, &rf);
> +		update_rq_clock(rq);
> +		psi_task_change(p, rq_clock(rq), clear, 0);
> +		p->sched_psi_wake_requeue = 1;
> +		__task_rq_unlock(rq, &rf);
> +	}
> +}

That all seems to be missing psi_disabled tests.. Yes I know it's
burried down in psi_task_change() somewhere, but that's really (too)
late.

(also, you seem to be conserving whitespace; typically we have an empty
lines between functions)
