Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:58232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933685AbeEIKFF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 May 2018 06:05:05 -0400
Date: Wed, 9 May 2018 12:04:55 +0200
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
Message-ID: <20180509100455.GK12217@hirez.programming.kicks-ass.net>
References: <20180507210135.1823-1-hannes@cmpxchg.org>
 <20180507210135.1823-7-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180507210135.1823-7-hannes@cmpxchg.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 07, 2018 at 05:01:34PM -0400, Johannes Weiner wrote:
> +static void psi_clock(struct work_struct *work)
> +{
> +	u64 some[NR_PSI_RESOURCES] = { 0, };
> +	u64 full[NR_PSI_RESOURCES] = { 0, };
> +	unsigned long nonidle_total = 0;
> +	unsigned long missed_periods;
> +	struct delayed_work *dwork;
> +	struct psi_group *group;
> +	unsigned long expires;
> +	int cpu;
> +	int r;
> +
> +	dwork = to_delayed_work(work);
> +	group = container_of(dwork, struct psi_group, clock_work);
> +
> +	/*
> +	 * Calculate the sampling period. The clock might have been
> +	 * stopped for a while.
> +	 */
> +	expires = group->period_expires;
> +	missed_periods = (jiffies - expires) / MY_LOAD_FREQ;
> +	group->period_expires = expires + ((1 + missed_periods) * MY_LOAD_FREQ);
> +
> +	/*
> +	 * Aggregate the per-cpu state into a global state. Each CPU
> +	 * is weighted by its non-idle time in the sampling period.
> +	 */
> +	for_each_online_cpu(cpu) {

Typically when using online CPU state, you also need hotplug notifiers
to deal with changes in the online set.

You also typically need something like cpus_read_lock() around an
iteration of online CPUs, to avoid the set changing while you're poking
at them.

The lack for neither is evident or explained.

> +		struct psi_group_cpu *groupc = per_cpu_ptr(group->cpus, cpu);
> +		unsigned long nonidle;
> +
> +		nonidle = nsecs_to_jiffies(groupc->nonidle_time);
> +		groupc->nonidle_time = 0;
> +		nonidle_total += nonidle;
> +
> +		for (r = 0; r < NR_PSI_RESOURCES; r++) {
> +			struct psi_resource *res = &groupc->res[r];
> +
> +			some[r] += (res->times[0] + res->times[1]) * nonidle;
> +			full[r] += res->times[1] * nonidle;
> +
> +			/* It's racy, but we can tolerate some error */
> +			res->times[0] = 0;
> +			res->times[1] = 0;
> +		}
> +	}
> +
> +	for (r = 0; r < NR_PSI_RESOURCES; r++) {
> +		/* Finish the weighted aggregation */
> +		some[r] /= max(nonidle_total, 1UL);
> +		full[r] /= max(nonidle_total, 1UL);
> +
> +		/* Accumulate stall time */
> +		group->some[r] += some[r];
> +		group->full[r] += full[r];
> +
> +		/* Calculate recent pressure averages */
> +		calc_avgs(group->avg_some[r], some[r], missed_periods);
> +		calc_avgs(group->avg_full[r], full[r], missed_periods);
> +	}
> +
> +	/* Keep the clock ticking only when there is action */
> +	if (nonidle_total)
> +		schedule_delayed_work(dwork, MY_LOAD_FREQ);
> +}
