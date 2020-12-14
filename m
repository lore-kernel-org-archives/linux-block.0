Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0447C4361B
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 15:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62FA722B2C
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 15:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbgLNPZ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Dec 2020 10:25:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405383AbgLNPZF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Dec 2020 10:25:05 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD59222A99;
        Mon, 14 Dec 2020 15:24:23 +0000 (UTC)
Date:   Mon, 14 Dec 2020 10:24:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] blktrace: fix 'BUG: sleeping function called from
 invalid context' in case of PREEMPT_RT
Message-ID: <20201214102422.2d84035d@gandalf.local.home>
In-Reply-To: <20201214022217.1754273-1-ming.lei@redhat.com>
References: <20201214022217.1754273-1-ming.lei@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 14 Dec 2020 10:22:17 +0800
Ming Lei <ming.lei@redhat.com> wrote:

> trace_note_tsk() is called by __blk_add_trace(), which is covered by RCU read lock.
> So in case of PREEMPT_RT, warning of 'BUG: sleeping function called from invalid context'
> will be triggered because spin lock is converted to rtmutex.

The RCU read_lock() can not be the cause of this issue, because under
PREEMPT_RT, rcu_read_lock() can be preempted.

What was the full back trace of this problem?

> 
> Fix the issue by converting running_trace_lock into raw_spin_lock().
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  kernel/trace/blktrace.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 2c5b3c5317c2..53dc876d669d 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -34,7 +34,7 @@ static struct trace_array *blk_tr;
>  static bool blk_tracer_enabled __read_mostly;
>  
>  static LIST_HEAD(running_trace_list);
> -static __cacheline_aligned_in_smp DEFINE_SPINLOCK(running_trace_lock);
> +static __cacheline_aligned_in_smp DEFINE_RAW_SPINLOCK(running_trace_lock);
>  
>  /* Select an alternative, minimalistic output than the original one */
>  #define TRACE_BLK_OPT_CLASSIC	0x1
> @@ -121,12 +121,12 @@ static void trace_note_tsk(struct task_struct *tsk)
>  	struct blk_trace *bt;
>  
>  	tsk->btrace_seq = blktrace_seq;
> -	spin_lock_irqsave(&running_trace_lock, flags);
> +	raw_spin_lock_irqsave(&running_trace_lock, flags);
>  	list_for_each_entry(bt, &running_trace_list, running_list) {
>  		trace_note(bt, tsk->pid, BLK_TN_PROCESS, tsk->comm,
>  			   sizeof(tsk->comm), 0);
>  	}

How big is this running_trace_list? May not be something we want raw locks
around.

Please understand that converting locks to raw should be the last resort.
One should always look at the reason for a spin lock in a preempt disabled
area and see if there's other means of solving it before simply switch a
lock to raw, as each raw spinlock makes PREEMPT_RT less real time.

-- Steve


> -	spin_unlock_irqrestore(&running_trace_lock, flags);
> +	raw_spin_unlock_irqrestore(&running_trace_lock, flags);
>  }
>  
>  static void trace_note_time(struct blk_trace *bt)
> @@ -669,9 +669,9 @@ static int __blk_trace_startstop(struct request_queue *q, int start)
>  			blktrace_seq++;
>  			smp_mb();
>  			bt->trace_state = Blktrace_running;
> -			spin_lock_irq(&running_trace_lock);
> +			raw_spin_lock_irq(&running_trace_lock);
>  			list_add(&bt->running_list, &running_trace_list);
> -			spin_unlock_irq(&running_trace_lock);
> +			raw_spin_unlock_irq(&running_trace_lock);
>  
>  			trace_note_time(bt);
>  			ret = 0;
> @@ -679,9 +679,9 @@ static int __blk_trace_startstop(struct request_queue *q, int start)
>  	} else {
>  		if (bt->trace_state == Blktrace_running) {
>  			bt->trace_state = Blktrace_stopped;
> -			spin_lock_irq(&running_trace_lock);
> +			raw_spin_lock_irq(&running_trace_lock);
>  			list_del_init(&bt->running_list);
> -			spin_unlock_irq(&running_trace_lock);
> +			raw_spin_unlock_irq(&running_trace_lock);
>  			relay_flush(bt->rchan);
>  			ret = 0;
>  		}

