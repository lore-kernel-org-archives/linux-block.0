Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247F5C43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 10:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A3221582
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 10:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="piuwGUcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfLRKuP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Dec 2019 05:50:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35686 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfLRKuP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Dec 2019 05:50:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gl2YWU6oIrYSQOsjiLJa7c1hRrKrWb24T2D+xEGxKqo=; b=piuwGUcwoPfhIIy2ROdCk1XcN
        m6N+ERda6x0EEe9ejtY/tLfrsA1taFdxo14DW0uNKYpxF9ASI6cFg4DeJNPbCbUrOhAL4wO+j5zME
        ibHfMFAKXZ5lIdhbCVyaJDanbm4u1nmYEJMn7eH8F5RBKWV2qZ/uIT+Vdu9d7xEjNkvwxIw4iHX6L
        R0BCZsj0g2ZbMAC021ZeVi+an4bVGAnXQt0eWGJA63j+YPS9OWF96k1Y3hqc7iVEFM0vtNkkFKgzx
        /qGPOe6JaxYHgRJ/HDlvesThD2lNBW+sURytUmZcWxistrlRiQPr2kaY7/6DtmQDtkHGyoZzIJJe1
        FW4mnQ4xw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihWtl-00023K-Gy; Wed, 18 Dec 2019 10:49:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F579300F29;
        Wed, 18 Dec 2019 11:48:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E563129DFB922; Wed, 18 Dec 2019 11:49:41 +0100 (CET)
Date:   Wed, 18 Dec 2019 11:49:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Long Li <longli@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [RFC PATCH 2/3] softirq: implement interrupt flood detection
Message-ID: <20191218104941.GR2844@hirez.programming.kicks-ass.net>
References: <20191218071942.22336-1-ming.lei@redhat.com>
 <20191218071942.22336-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218071942.22336-3-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 18, 2019 at 03:19:41PM +0800, Ming Lei wrote:

> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 0427a86743a4..f6e434ac4183 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -25,6 +25,8 @@
>  #include <linux/smpboot.h>
>  #include <linux/tick.h>
>  #include <linux/irq.h>
> +#include <linux/sched.h>
> +#include <linux/sched/clock.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/irq.h>
> @@ -52,6 +54,26 @@ DEFINE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);
>  EXPORT_PER_CPU_SYMBOL(irq_stat);
>  #endif
>  
> +#define IRQ_INTERVAL_STAGE1_WEIGHT_BITS		ilog2(512)
> +#define IRQ_INTERVAL_STAGE2_WEIGHT_BITS		ilog2(128)

That must be the most difficult way of writing 9 and 7 resp.

> +#define IRQ_INTERVAL_THRESHOLD_UNIT_NS	1000
> +
> +#define IRQ_INTERVAL_MIN_THRESHOLD_NS	IRQ_INTERVAL_THRESHOLD_UNIT_NS
> +#define IRQ_INTERVAL_MAX_MIN_THRESHOLD_TIME_NS  4000000000

(seriously a name with MAX_MIN in it ?!?)

That's unreadable, we have (4*NSEC_PER_SEC) for that (if I counted the
0s correctly)

These are all a bunch of magic value, any justification for them? Will
they always work?

> +
> +struct irq_interval {
> +	u64                     clock;
> +	int			avg;
> +	int			std_threshold:31;

I know of a standard deviation, but what is a standard threshold?

> +	int			stage:1;

signed single bit.. there's people that object to that. They figure just
a sign bit isn't much useful.

> +
> +	u64			stage_start_clock;
> +	unsigned		stage1_time;
> +	unsigned		stage2_time;
> +};
> +DEFINE_PER_CPU(struct irq_interval, avg_irq_interval);
> +
>  static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp;
>  
>  DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
> @@ -339,6 +361,140 @@ asmlinkage __visible void do_softirq(void)
>  	local_irq_restore(flags);
>  }
>  
> +static inline void irq_interval_update_avg(struct irq_interval *inter,
> +		u64 now, int weight_bits)
> +{
> +	inter->avg = inter->avg - ((inter->avg) >> weight_bits) +
> +		((now - inter->clock) >> weight_bits);

Did you perhaps want to write something like:

	s64 sample = now - inter->clock;

	inter->avg += (sample - inter->avg) >> weight_bits;

Which is a recognisable form.

It also shows the obvious overflow when sample is large (interrupts
didn't happen for a while). You'll want to clamp @sample to some max.

> +	if (unlikely(inter->avg < 0))
> +		inter->avg = 0;

And since inter->avg must never be <0, wth are you using a signed
bitfield? This generates shit code. Use an on-stack temporary if
anything:

	int avg = inter->avg;

	avg += (sample - avg) >> bits;
	if (avg < 0)
		avg = 0;

	inter->avg = avg;

and presto! no signed bitfields required.

> +}
> +
> +/*
> + * Keep the ratio of stage2 time to stage1 time between 1/2 and 1/8. If
> + * it is out of the range, adjust .std_threshold for maintaining the ratio.

it is either @std_threshold or @irq_interval::std_threshold

> + */
> +static inline void irq_interval_update_threshold(struct irq_interval *inter)
> +{
> +	if (inter->stage2_time * 2 > inter->stage1_time)
> +		inter->std_threshold -= IRQ_INTERVAL_THRESHOLD_UNIT_NS;
> +	if (inter->stage2_time * 8 < inter->stage1_time)
> +		inter->std_threshold += IRQ_INTERVAL_THRESHOLD_UNIT_NS;

I suppose that will eventually converge.

> +	if (inter->std_threshold <= 0)
> +		inter->std_threshold = IRQ_INTERVAL_THRESHOLD_UNIT_NS;

I think you'll find you actually meant to write:

	if (inter->std_threshold < IRQ_INTERVAL_THRESHOLD_UNIT_NS)


> +	if (inter->std_threshold >= 32 * IRQ_INTERVAL_THRESHOLD_UNIT_NS)
> +		inter->std_threshold = 32 * IRQ_INTERVAL_THRESHOLD_UNIT_NS;

We actually have a macro for this:

	inter->std_threshold = clamp(inter->std_threshold,
				     IRQ_INTERVAL_THRESHOLD_UNIT_NS,
				     32 * IRQ_INTERVAL_THRESHOLD_UNIT_NS);

> +}
> +
> +/*
> + * If we stay at stage1 for too long with minimized threshold and low enough
> + * interrupt average interval, there may have risk to lock up CPU.

It's not locked up...

> + */
> +static bool irq_interval_cpu_lockup_risk(struct irq_interval *inter, u64 now)
> +{
> +	if (inter->avg > inter->std_threshold)
> +		return false;
> +
> +	if (inter->std_threshold != IRQ_INTERVAL_MIN_THRESHOLD_NS)
> +		return false;
> +
> +	if (now - inter->stage_start_clock <=
> +			IRQ_INTERVAL_MAX_MIN_THRESHOLD_TIME_NS)
> +		return false;
> +	return true;
> +}
> +
> +/*
> + * Update average interrupt interval with the Exponential Weighted Moving
> + * Average(EWMA), and implement two-stage interrupt flood detection.
> + *
> + * Use scheduler's runqueue software clock at default for figuring
> + * interrupt interval for saving cost. When the interval becomes zero,
> + * it is reasonable to conclude scheduler's activity on this CPU has been
> + * stopped because of interrupt flood. Then switch to the 2nd stage
> + * detection in which clock is read from hardware, and the detection
> + * result can be more reliable.
> + */
> +static void irq_interval_update(void)
> +{
> +	struct irq_interval *inter = raw_cpu_ptr(&avg_irq_interval);

raw_cpu_ptr is wrong, this wants to be this_cpu_ptr()

> +	u64 now;
> +
> +	if (likely(!inter->stage)) {
> +		now = sched_local_rq_clock();
> +		irq_interval_update_avg(inter, now,
> +				IRQ_INTERVAL_STAGE1_WEIGHT_BITS);
> +
> +		if (unlikely(inter->avg < inter->std_threshold / 2 ||
> +				irq_interval_cpu_lockup_risk(inter, now))) {
> +			inter->stage = 1;
> +			now = sched_clock_cpu(smp_processor_id());
> +			inter->stage1_time = now - inter->stage_start_clock;
> +			inter->stage_start_clock = now;
> +
> +			/*
> +			 * reset as the mean of the min and the max value of
> +			 * stage2's threshold
> +			 */
> +			inter->avg = inter->std_threshold +
> +				(inter->std_threshold >> 2);
> +		}
> +	} else {
> +		now = sched_clock_cpu(smp_processor_id());
> +
> +		irq_interval_update_avg(inter, now,
> +				IRQ_INTERVAL_STAGE2_WEIGHT_BITS);
> +
> +		if (inter->avg > inter->std_threshold * 2) {
> +			inter->stage = 0;
> +			inter->stage2_time = now - inter->stage_start_clock;
> +			inter->stage_start_clock = now;
> +
> +			irq_interval_update_threshold(inter);
> +		}
> +	}
> +}

AFAICT the only reason for much of this complexity is so that you can
use this sched_local_rq_clock() thing, right? Once that reaches a
threshold, you go use the more accurate sched_clock_cpu() and once that
tickles the threshold you call it golden and raise hell.

So pray tell, why did you not integrate this with IRQ_TIME_ACCOUNTING ?
That already takes a timestamp and does most of what you need.

> @@ -356,6 +512,7 @@ void irq_enter(void)
>  	}
>  
>  	__irq_enter();
> +	irq_interval_update();
>  }

Arggh.. you're going to make every single interrupt take at least 2
extra cache misses for this gunk?!?

And it lumps all interrupts on a single heap, and doesn't do any of the
otherwise useful things we've been wanting to have IRQ timings for :/


_If_ you want to do something like this, do it like the below. That only
adds a few instruction to irq_exit() and only touches a cacheline that's
already touched.

It computes both the avg duration and the avg inter-arrival-time of
hardirqs. Things get critical when:

	inter-arrival-avg < 2*duration-avg

or something like that.

---
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index d43318a489f2..6f5ef70b5a1d 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -50,7 +50,7 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
 void irqtime_account_irq(struct task_struct *curr)
 {
 	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
-	s64 delta;
+	s64 delta, iat;
 	int cpu;
 
 	if (!sched_clock_irqtime)
@@ -58,7 +58,6 @@ void irqtime_account_irq(struct task_struct *curr)
 
 	cpu = smp_processor_id();
 	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
-	irqtime->irq_start_time += delta;
 
 	/*
 	 * We do not account for softirq time from ksoftirqd here.
@@ -66,10 +65,21 @@ void irqtime_account_irq(struct task_struct *curr)
 	 * in that case, so as not to confuse scheduler with a special task
 	 * that do not consume any time, but still wants to run.
 	 */
-	if (hardirq_count())
+	if (hardirq_count()) {
 		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
-	else if (in_serving_softirq() && curr != this_cpu_ksoftirqd())
+
+		/* this is irq_exit(), delta is the duration of the hardirq */
+		irqtime->duration_avg += (delta - irqtime->duration_avg) >> 7;
+
+		/* compute the inter arrival time using the previous arrival_time */
+		iat = irqtime->irq_start_time - irqtime->irq_arrival_time;
+		irqtime->irq_arrival_time += iat;
+		irqtime->irq_inter_arrival_avg += (iat - irqtime->inter_arrival_avg) >> 7;
+
+	} else if (in_serving_softirq() && curr != this_cpu_ksoftirqd())
 		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
+
+	irqtime->irq_start_time += delta;
 }
 EXPORT_SYMBOL_GPL(irqtime_account_irq);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 280a3c735935..cab07e5a6c11 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2236,6 +2236,9 @@ struct irqtime {
 	u64			total;
 	u64			tick_delta;
 	u64			irq_start_time;
+	u64			irq_duration_avg;
+	u64			irq_arrival_time;
+	u64			irq_inter_arrival_avg;
 	struct u64_stats_sync	sync;
 };
 
