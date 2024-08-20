Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A248130499;
	Tue, 20 Aug 2024 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724179770; cv=none; b=eqQ5IkWu6w87PgJFMln/ZJ6w/c3h4Brs1N5OSVH6UiAfpRA+98IJnBFc6m3euXjfknaJFsSyVTR7vsx0RqpnZX8Xsnk213pNKGYTRQ29xNHb8ilZ60mwu/VdoGGdn9bbJlaxtAuZtqHHQrRO30AIQA61WseiTMghp1a2zdEa7MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724179770; c=relaxed/simple;
	bh=gyhe0JlTNt+mfblLvFCfzEN71MyH2AiH4+ibll4gIac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfLMnmALrmykxN7Xpd7s4b/Dd+SyIAmVaHwx58ALzC3yX5raHE3qLCqP8zaF7oGUIvcMKn37V0drHV5TlOFHYt3m+tFHw611J7IOXDzUxoqbR4ifvIhnU1Zf7Q2hUjc93r3Lz4itXO6xtpz4CZ65sQ1oo4jdCh1Pm0awGtRTV/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loUgWwac; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loUgWwac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04C2C4AF09;
	Tue, 20 Aug 2024 18:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724179769;
	bh=gyhe0JlTNt+mfblLvFCfzEN71MyH2AiH4+ibll4gIac=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=loUgWwacJGE7rLBK8gbmylwUy20YkkbfT7OMrRIfymkGGLlYfNjNQgoSaVsPL025d
	 wDyRpteyIRDHSmEXUr2W+ad2faB5jfe2vRvHH2/vYx5CcPA7aaUnxABEavzJLQoHjL
	 8KPadM44cXCRpExu57Dk2J74umeHl6fIt4Ts3fBy9MmuT5X6xlPtP+ujfjgD+1DHMK
	 1T97c8ddWFBUvIJDbIt+b9bMotW2aXb3j+t76Q0IP24ZGS8k9bxz1BavrGIUJSgrWw
	 pH81CKYRVqbCmY+0myT4dyJUpV2PAeNfRk1uBdl0LgWXU9R9CJqyRleZNUQ9xzZVyq
	 ePt6HMR6hrPUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0C210CE0DE1; Tue, 20 Aug 2024 11:49:29 -0700 (PDT)
Date: Tue, 20 Aug 2024 11:49:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] softirq: remove parameter from action callback
Message-ID: <6648a8f0-0af1-4351-95b9-8380df8f336d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <0f19dd9a-e2fd-4221-aaf5-bafc516f9c32@kernel.dk>
 <20240815171549.3260003-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815171549.3260003-1-csander@purestorage.com>

On Thu, Aug 15, 2024 at 11:15:40AM -0600, Caleb Sander Mateos wrote:
> When softirq actions are called, they are passed a pointer to the entry
> in the softirq_vec table containing the action's function pointer. This
> pointer isn't very useful, as the action callback already knows what
> function it is. And since each callback handles a specific softirq, the
> callback also knows which softirq number is running.
> 
> No softirq action callbacks actually use this parameter, so remove it
> from the function pointer signature. This clarifies that softirq actions
> are global routines and makes it slightly cheaper to call them.
> 
> v2: use full 72 characters in commit description lines, add Reviewed-by
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>

For the RCU pieces:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  block/blk-mq.c            |  2 +-
>  include/linux/interrupt.h |  4 ++--
>  kernel/rcu/tiny.c         |  2 +-
>  kernel/rcu/tree.c         |  2 +-
>  kernel/sched/fair.c       |  2 +-
>  kernel/softirq.c          | 15 +++++++--------
>  kernel/time/hrtimer.c     |  2 +-
>  kernel/time/timer.c       |  2 +-
>  lib/irq_poll.c            |  2 +-
>  net/core/dev.c            |  4 ++--
>  10 files changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e3c3c0c21b55..aa28157b1aaf 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1126,11 +1126,11 @@ static void blk_complete_reqs(struct llist_head *list)
>  
>  	llist_for_each_entry_safe(rq, next, entry, ipi_list)
>  		rq->q->mq_ops->complete(rq);
>  }
>  
> -static __latent_entropy void blk_done_softirq(struct softirq_action *h)
> +static __latent_entropy void blk_done_softirq(void)
>  {
>  	blk_complete_reqs(this_cpu_ptr(&blk_cpu_done));
>  }
>  
>  static int blk_softirq_cpu_dead(unsigned int cpu)
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 3f30c88e0b4c..694de61e0b38 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -592,11 +592,11 @@ extern const char * const softirq_to_name[NR_SOFTIRQS];
>   * asm/hardirq.h to get better cache usage.  KAO
>   */
>  
>  struct softirq_action
>  {
> -	void	(*action)(struct softirq_action *);
> +	void	(*action)(void);
>  };
>  
>  asmlinkage void do_softirq(void);
>  asmlinkage void __do_softirq(void);
>  
> @@ -607,11 +607,11 @@ static inline void do_softirq_post_smp_call_flush(unsigned int unused)
>  {
>  	do_softirq();
>  }
>  #endif
>  
> -extern void open_softirq(int nr, void (*action)(struct softirq_action *));
> +extern void open_softirq(int nr, void (*action)(void));
>  extern void softirq_init(void);
>  extern void __raise_softirq_irqoff(unsigned int nr);
>  
>  extern void raise_softirq_irqoff(unsigned int nr);
>  extern void raise_softirq(unsigned int nr);
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index 4402d6f5f857..b3b3ce34df63 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -103,11 +103,11 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
>  	rcu_lock_release(&rcu_callback_map);
>  	return false;
>  }
>  
>  /* Invoke the RCU callbacks whose grace period has elapsed.  */
> -static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused)
> +static __latent_entropy void rcu_process_callbacks(void)
>  {
>  	struct rcu_head *next, *list;
>  	unsigned long flags;
>  
>  	/* Move the ready-to-invoke callbacks to a local list. */
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e641cc681901..93bd665637c0 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2853,11 +2853,11 @@ static __latent_entropy void rcu_core(void)
>  	// If strict GPs, schedule an RCU reader in a clean environment.
>  	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
>  		queue_work_on(rdp->cpu, rcu_gp_wq, &rdp->strict_work);
>  }
>  
> -static void rcu_core_si(struct softirq_action *h)
> +static void rcu_core_si(void)
>  {
>  	rcu_core();
>  }
>  
>  static void rcu_wake_cond(struct task_struct *t, int status)
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9057584ec06d..8dc9385f6da4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12481,11 +12481,11 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
>   * - directly from the local scheduler_tick() for periodic load balancing
>   *
>   * - indirectly from a remote scheduler_tick() for NOHZ idle balancing
>   *   through the SMP cross-call nohz_csd_func()
>   */
> -static __latent_entropy void sched_balance_softirq(struct softirq_action *h)
> +static __latent_entropy void sched_balance_softirq(void)
>  {
>  	struct rq *this_rq = this_rq();
>  	enum cpu_idle_type idle = this_rq->idle_balance;
>  	/*
>  	 * If this CPU has a pending NOHZ_BALANCE_KICK, then do the
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 02582017759a..d082e7840f88 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -549,11 +549,11 @@ static void handle_softirqs(bool ksirqd)
>  		prev_count = preempt_count();
>  
>  		kstat_incr_softirqs_this_cpu(vec_nr);
>  
>  		trace_softirq_entry(vec_nr);
> -		h->action(h);
> +		h->action();
>  		trace_softirq_exit(vec_nr);
>  		if (unlikely(prev_count != preempt_count())) {
>  			pr_err("huh, entered softirq %u %s %p with preempt_count %08x, exited with %08x?\n",
>  			       vec_nr, softirq_to_name[vec_nr], h->action,
>  			       prev_count, preempt_count());
> @@ -698,11 +698,11 @@ void __raise_softirq_irqoff(unsigned int nr)
>  	lockdep_assert_irqs_disabled();
>  	trace_softirq_raise(nr);
>  	or_softirq_pending(1UL << nr);
>  }
>  
> -void open_softirq(int nr, void (*action)(struct softirq_action *))
> +void open_softirq(int nr, void (*action)(void))
>  {
>  	softirq_vec[nr].action = action;
>  }
>  
>  /*
> @@ -758,12 +758,11 @@ static bool tasklet_clear_sched(struct tasklet_struct *t)
>  		  t->use_callback ? (void *)t->callback : (void *)t->func);
>  
>  	return false;
>  }
>  
> -static void tasklet_action_common(struct softirq_action *a,
> -				  struct tasklet_head *tl_head,
> +static void tasklet_action_common(struct tasklet_head *tl_head,
>  				  unsigned int softirq_nr)
>  {
>  	struct tasklet_struct *list;
>  
>  	local_irq_disable();
> @@ -803,20 +802,20 @@ static void tasklet_action_common(struct softirq_action *a,
>  		__raise_softirq_irqoff(softirq_nr);
>  		local_irq_enable();
>  	}
>  }
>  
> -static __latent_entropy void tasklet_action(struct softirq_action *a)
> +static __latent_entropy void tasklet_action(void)
>  {
>  	workqueue_softirq_action(false);
> -	tasklet_action_common(a, this_cpu_ptr(&tasklet_vec), TASKLET_SOFTIRQ);
> +	tasklet_action_common(this_cpu_ptr(&tasklet_vec), TASKLET_SOFTIRQ);
>  }
>  
> -static __latent_entropy void tasklet_hi_action(struct softirq_action *a)
> +static __latent_entropy void tasklet_hi_action(void)
>  {
>  	workqueue_softirq_action(true);
> -	tasklet_action_common(a, this_cpu_ptr(&tasklet_hi_vec), HI_SOFTIRQ);
> +	tasklet_action_common(this_cpu_ptr(&tasklet_hi_vec), HI_SOFTIRQ);
>  }
>  
>  void tasklet_setup(struct tasklet_struct *t,
>  		   void (*callback)(struct tasklet_struct *))
>  {
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index b8ee320208d4..836157e09e25 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1755,11 +1755,11 @@ static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now,
>  				hrtimer_sync_wait_running(cpu_base, flags);
>  		}
>  	}
>  }
>  
> -static __latent_entropy void hrtimer_run_softirq(struct softirq_action *h)
> +static __latent_entropy void hrtimer_run_softirq(void)
>  {
>  	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
>  	unsigned long flags;
>  	ktime_t now;
>  
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 64b0d8a0aa0f..760bbeb1f331 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -2438,11 +2438,11 @@ static void run_timer_base(int index)
>  }
>  
>  /*
>   * This function runs timers and the timer-tq in bottom half context.
>   */
> -static __latent_entropy void run_timer_softirq(struct softirq_action *h)
> +static __latent_entropy void run_timer_softirq(void)
>  {
>  	run_timer_base(BASE_LOCAL);
>  	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
>  		run_timer_base(BASE_GLOBAL);
>  		run_timer_base(BASE_DEF);
> diff --git a/lib/irq_poll.c b/lib/irq_poll.c
> index 2d5329a42105..08b242bbdbdf 100644
> --- a/lib/irq_poll.c
> +++ b/lib/irq_poll.c
> @@ -73,11 +73,11 @@ void irq_poll_complete(struct irq_poll *iop)
>  	__irq_poll_complete(iop);
>  	local_irq_restore(flags);
>  }
>  EXPORT_SYMBOL(irq_poll_complete);
>  
> -static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
> +static void __latent_entropy irq_poll_softirq(void)
>  {
>  	struct list_head *list = this_cpu_ptr(&blk_cpu_iopoll);
>  	int rearm = 0, budget = irq_poll_budget;
>  	unsigned long start_time = jiffies;
>  
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 751d9b70e6ad..3ac02b0ca29e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5246,11 +5246,11 @@ int netif_rx(struct sk_buff *skb)
>  		local_bh_enable();
>  	return ret;
>  }
>  EXPORT_SYMBOL(netif_rx);
>  
> -static __latent_entropy void net_tx_action(struct softirq_action *h)
> +static __latent_entropy void net_tx_action(void)
>  {
>  	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
>  
>  	if (sd->completion_queue) {
>  		struct sk_buff *clist;
> @@ -6919,11 +6919,11 @@ static int napi_threaded_poll(void *data)
>  		napi_threaded_poll_loop(napi);
>  
>  	return 0;
>  }
>  
> -static __latent_entropy void net_rx_action(struct softirq_action *h)
> +static __latent_entropy void net_rx_action(void)
>  {
>  	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
>  	unsigned long time_limit = jiffies +
>  		usecs_to_jiffies(READ_ONCE(net_hotdata.netdev_budget_usecs));
>  	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
> -- 
> 2.45.2
> 
