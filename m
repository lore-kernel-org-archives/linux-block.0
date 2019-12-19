Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60E9C43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 02:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5E9222C2
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 02:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnP60Osf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfLSCAL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Dec 2019 21:00:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46452 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726694AbfLSCAL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Dec 2019 21:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576720809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nn9orzCMcRCnewgssJCx11G+7aA7eF6BWs6I+sF8IpY=;
        b=HnP60Osfe2S04/J5yZ552/Va2o67w2qdruET/ci2U9bOHcLjt7SDLFZEFyWJXgKb9y5aJC
        Z7KzSIMr6EXgN++gKHqftUdwcr9++nDeoDyDHb3FfXCe4Ga7IBov4bOvIXYRSAUyVvBhro
        eNcB5hGe9nAxle+eArCaR4vjG2hw6yY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-zGE6-DNiNLaksPaMBsMeUQ-1; Wed, 18 Dec 2019 21:00:04 -0500
X-MC-Unique: zGE6-DNiNLaksPaMBsMeUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EF981800D42;
        Thu, 19 Dec 2019 02:00:02 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7730719C70;
        Thu, 19 Dec 2019 01:59:53 +0000 (UTC)
Date:   Thu, 19 Dec 2019 09:59:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Long Li <longli@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [RFC PATCH 2/3] softirq: implement interrupt flood detection
Message-ID: <20191219015948.GB6080@ming.t460p>
References: <20191218071942.22336-1-ming.lei@redhat.com>
 <20191218071942.22336-3-ming.lei@redhat.com>
 <20191218104941.GR2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218104941.GR2844@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Peter,

Thanks for your review!

On Wed, Dec 18, 2019 at 11:49:41AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 18, 2019 at 03:19:41PM +0800, Ming Lei wrote:
> 
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index 0427a86743a4..f6e434ac4183 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -25,6 +25,8 @@
> >  #include <linux/smpboot.h>
> >  #include <linux/tick.h>
> >  #include <linux/irq.h>
> > +#include <linux/sched.h>
> > +#include <linux/sched/clock.h>
> >  
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/irq.h>
> > @@ -52,6 +54,26 @@ DEFINE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);
> >  EXPORT_PER_CPU_SYMBOL(irq_stat);
> >  #endif
> >  
> > +#define IRQ_INTERVAL_STAGE1_WEIGHT_BITS		ilog2(512)
> > +#define IRQ_INTERVAL_STAGE2_WEIGHT_BITS		ilog2(128)
> 
> That must be the most difficult way of writing 9 and 7 resp.
> 
> > +#define IRQ_INTERVAL_THRESHOLD_UNIT_NS	1000
> > +
> > +#define IRQ_INTERVAL_MIN_THRESHOLD_NS	IRQ_INTERVAL_THRESHOLD_UNIT_NS
> > +#define IRQ_INTERVAL_MAX_MIN_THRESHOLD_TIME_NS  4000000000
> 
> (seriously a name with MAX_MIN in it ?!?)
> 
> That's unreadable, we have (4*NSEC_PER_SEC) for that (if I counted the
> 0s correctly)
> 
> These are all a bunch of magic value, any justification for them? Will
> they always work?

The two weight constant just decides rate of convergence.

IRQ_INTERVAL_THRESHOLD_UNIT_NS is the unit of updating the threshold.

IRQ_INTERVAL_MIN_THRESHOLD_NS is the minimized allowed threshold.

IRQ_INTERVAL_MAX_MIN_THRESHOLD_TIME_NS could be the only one magic
value, which is for avoiding to use the smallest threshold for too
long.

> 
> > +
> > +struct irq_interval {
> > +	u64                     clock;
> > +	int			avg;
> > +	int			std_threshold:31;
> 
> I know of a standard deviation, but what is a standard threshold?

It is just one threshold, will rename it.

> 
> > +	int			stage:1;
> 
> signed single bit.. there's people that object to that. They figure just
> a sign bit isn't much useful.

OK, the stage has just two value, zero or non-zero. Maybe it can be
changed to use two bits.

> 
> > +
> > +	u64			stage_start_clock;
> > +	unsigned		stage1_time;
> > +	unsigned		stage2_time;
> > +};
> > +DEFINE_PER_CPU(struct irq_interval, avg_irq_interval);
> > +
> >  static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp;
> >  
> >  DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
> > @@ -339,6 +361,140 @@ asmlinkage __visible void do_softirq(void)
> >  	local_irq_restore(flags);
> >  }
> >  
> > +static inline void irq_interval_update_avg(struct irq_interval *inter,
> > +		u64 now, int weight_bits)
> > +{
> > +	inter->avg = inter->avg - ((inter->avg) >> weight_bits) +
> > +		((now - inter->clock) >> weight_bits);
> 
> Did you perhaps want to write something like:
> 
> 	s64 sample = now - inter->clock;
> 
> 	inter->avg += (sample - inter->avg) >> weight_bits;
> 
> Which is a recognisable form.

Yeah, that is it.

> 
> It also shows the obvious overflow when sample is large (interrupts
> didn't happen for a while). You'll want to clamp @sample to some max.

Looks not necessary, even it is overflowed, it is exponential decay,
so the average will become to normal level very quick. Given it is run
in fast path, I'd suggest to not introduce the unnecessary clamp.

> 
> > +	if (unlikely(inter->avg < 0))
> > +		inter->avg = 0;
> 
> And since inter->avg must never be <0, wth are you using a signed
> bitfield? This generates shit code. Use an on-stack temporary if
> anything:
> 
> 	int avg = inter->avg;
> 
> 	avg += (sample - avg) >> bits;
> 	if (avg < 0)
> 		avg = 0;
> 
> 	inter->avg = avg;
> 
> and presto! no signed bitfields required.

Fine.

> 
> > +}
> > +
> > +/*
> > + * Keep the ratio of stage2 time to stage1 time between 1/2 and 1/8. If
> > + * it is out of the range, adjust .std_threshold for maintaining the ratio.
> 
> it is either @std_threshold or @irq_interval::std_threshold
> 
> > + */
> > +static inline void irq_interval_update_threshold(struct irq_interval *inter)
> > +{
> > +	if (inter->stage2_time * 2 > inter->stage1_time)
> > +		inter->std_threshold -= IRQ_INTERVAL_THRESHOLD_UNIT_NS;
> > +	if (inter->stage2_time * 8 < inter->stage1_time)
> > +		inter->std_threshold += IRQ_INTERVAL_THRESHOLD_UNIT_NS;
> 
> I suppose that will eventually converge.

Right.

> 
> > +	if (inter->std_threshold <= 0)
> > +		inter->std_threshold = IRQ_INTERVAL_THRESHOLD_UNIT_NS;
> 
> I think you'll find you actually meant to write:
> 
> 	if (inter->std_threshold < IRQ_INTERVAL_THRESHOLD_UNIT_NS)
> 
> 
> > +	if (inter->std_threshold >= 32 * IRQ_INTERVAL_THRESHOLD_UNIT_NS)
> > +		inter->std_threshold = 32 * IRQ_INTERVAL_THRESHOLD_UNIT_NS;
> 
> We actually have a macro for this:
> 
> 	inter->std_threshold = clamp(inter->std_threshold,
> 				     IRQ_INTERVAL_THRESHOLD_UNIT_NS,
> 				     32 * IRQ_INTERVAL_THRESHOLD_UNIT_NS);

OK.

> 
> > +}
> > +
> > +/*
> > + * If we stay at stage1 for too long with minimized threshold and low enough
> > + * interrupt average interval, there may have risk to lock up CPU.
> 
> It's not locked up...

If the interrupt flood isn't detected, the lock up may happen. Given the
stage1 uses runqueue's software clock which may not be accurate enough, we
need this way to avoid the risk.

> 
> > + */
> > +static bool irq_interval_cpu_lockup_risk(struct irq_interval *inter, u64 now)
> > +{
> > +	if (inter->avg > inter->std_threshold)
> > +		return false;
> > +
> > +	if (inter->std_threshold != IRQ_INTERVAL_MIN_THRESHOLD_NS)
> > +		return false;
> > +
> > +	if (now - inter->stage_start_clock <=
> > +			IRQ_INTERVAL_MAX_MIN_THRESHOLD_TIME_NS)
> > +		return false;
> > +	return true;
> > +}
> > +
> > +/*
> > + * Update average interrupt interval with the Exponential Weighted Moving
> > + * Average(EWMA), and implement two-stage interrupt flood detection.
> > + *
> > + * Use scheduler's runqueue software clock at default for figuring
> > + * interrupt interval for saving cost. When the interval becomes zero,
> > + * it is reasonable to conclude scheduler's activity on this CPU has been
> > + * stopped because of interrupt flood. Then switch to the 2nd stage
> > + * detection in which clock is read from hardware, and the detection
> > + * result can be more reliable.
> > + */
> > +static void irq_interval_update(void)
> > +{
> > +	struct irq_interval *inter = raw_cpu_ptr(&avg_irq_interval);
> 
> raw_cpu_ptr is wrong, this wants to be this_cpu_ptr()

OK.

> 
> > +	u64 now;
> > +
> > +	if (likely(!inter->stage)) {
> > +		now = sched_local_rq_clock();
> > +		irq_interval_update_avg(inter, now,
> > +				IRQ_INTERVAL_STAGE1_WEIGHT_BITS);
> > +
> > +		if (unlikely(inter->avg < inter->std_threshold / 2 ||
> > +				irq_interval_cpu_lockup_risk(inter, now))) {
> > +			inter->stage = 1;
> > +			now = sched_clock_cpu(smp_processor_id());
> > +			inter->stage1_time = now - inter->stage_start_clock;
> > +			inter->stage_start_clock = now;
> > +
> > +			/*
> > +			 * reset as the mean of the min and the max value of
> > +			 * stage2's threshold
> > +			 */
> > +			inter->avg = inter->std_threshold +
> > +				(inter->std_threshold >> 2);
> > +		}
> > +	} else {
> > +		now = sched_clock_cpu(smp_processor_id());
> > +
> > +		irq_interval_update_avg(inter, now,
> > +				IRQ_INTERVAL_STAGE2_WEIGHT_BITS);
> > +
> > +		if (inter->avg > inter->std_threshold * 2) {
> > +			inter->stage = 0;
> > +			inter->stage2_time = now - inter->stage_start_clock;
> > +			inter->stage_start_clock = now;
> > +
> > +			irq_interval_update_threshold(inter);
> > +		}
> > +	}
> > +}
> 
> AFAICT the only reason for much of this complexity is so that you can
> use this sched_local_rq_clock() thing, right? Once that reaches a
> threshold, you go use the more accurate sched_clock_cpu() and once that
> tickles the threshold you call it golden and raise hell.

Right.

> 
> So pray tell, why did you not integrate this with IRQ_TIME_ACCOUNTING ?
> That already takes a timestamp and does most of what you need.

Yeah, that was the 1st approach I thought of, but IRQ_TIME_ACCOUNTING
may be disabled, and enabling it may cause observable effect on IO
performance.

> 
> > @@ -356,6 +512,7 @@ void irq_enter(void)
> >  	}
> >  
> >  	__irq_enter();
> > +	irq_interval_update();
> >  }
> 
> Arggh.. you're going to make every single interrupt take at least 2
> extra cache misses for this gunk?!?

Could you explain it a bit why two cache misses are involved?

I understand at most one miss is caused, which should only happen in
irq_interval_update(), and what is the other one?

> 
> And it lumps all interrupts on a single heap, and doesn't do any of the
> otherwise useful things we've been wanting to have IRQ timings for :/
> 
> 
> _If_ you want to do something like this, do it like the below. That only
> adds a few instruction to irq_exit() and only touches a cacheline that's
> already touched.
> 
> It computes both the avg duration and the avg inter-arrival-time of
> hardirqs. Things get critical when:
> 
> 	inter-arrival-avg < 2*duration-avg
> 
> or something like that.
> 
> ---
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index d43318a489f2..6f5ef70b5a1d 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -50,7 +50,7 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
>  void irqtime_account_irq(struct task_struct *curr)
>  {
>  	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
> -	s64 delta;
> +	s64 delta, iat;
>  	int cpu;
>  
>  	if (!sched_clock_irqtime)
> @@ -58,7 +58,6 @@ void irqtime_account_irq(struct task_struct *curr)
>  
>  	cpu = smp_processor_id();
>  	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
> -	irqtime->irq_start_time += delta;
>  
>  	/*
>  	 * We do not account for softirq time from ksoftirqd here.
> @@ -66,10 +65,21 @@ void irqtime_account_irq(struct task_struct *curr)
>  	 * in that case, so as not to confuse scheduler with a special task
>  	 * that do not consume any time, but still wants to run.
>  	 */
> -	if (hardirq_count())
> +	if (hardirq_count()) {
>  		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
> -	else if (in_serving_softirq() && curr != this_cpu_ksoftirqd())
> +
> +		/* this is irq_exit(), delta is the duration of the hardirq */
> +		irqtime->duration_avg += (delta - irqtime->duration_avg) >> 7;
> +
> +		/* compute the inter arrival time using the previous arrival_time */
> +		iat = irqtime->irq_start_time - irqtime->irq_arrival_time;
> +		irqtime->irq_arrival_time += iat;
> +		irqtime->irq_inter_arrival_avg += (iat - irqtime->inter_arrival_avg) >> 7;
> +
> +	} else if (in_serving_softirq() && curr != this_cpu_ksoftirqd())
>  		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
> +
> +	irqtime->irq_start_time += delta;
>  }
>  EXPORT_SYMBOL_GPL(irqtime_account_irq);
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 280a3c735935..cab07e5a6c11 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2236,6 +2236,9 @@ struct irqtime {
>  	u64			total;
>  	u64			tick_delta;
>  	u64			irq_start_time;
> +	u64			irq_duration_avg;
> +	u64			irq_arrival_time;
> +	u64			irq_inter_arrival_avg;
>  	struct u64_stats_sync	sync;
>  };

I think we can do that in case of IRQ_TIME_ACCOUNTING, but the
option may not be enabled.

How about only using the rq software clock in case that
IRQ_TIME_ACCOUNTING is disabled?  Meantime replies irqtime
for computing the interval average when the option is enabled.


Thanks,
Ming

