Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7960AC4708F
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 14:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59334613EA
	for <linux-block@archiver.kernel.org>; Wed,  2 Jun 2021 14:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhFBOcQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jun 2021 10:32:16 -0400
Received: from foss.arm.com ([217.140.110.172]:46366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230074AbhFBOcP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Jun 2021 10:32:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35C8D1042;
        Wed,  2 Jun 2021 07:30:32 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.31.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D16593F73D;
        Wed,  2 Jun 2021 07:30:19 -0700 (PDT)
Date:   Wed, 2 Jun 2021 15:30:16 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, bristot <bristot@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86 <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        acme <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cgroups <cgroups@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
        rcu <rcu@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        KVM list <kvm@vger.kernel.org>
Subject: Re: [PATCH 3/6] sched,perf,kvm: Fix preemption condition
Message-ID: <20210602143016.GE12753@C02TD0UTHF1T.local>
References: <20210602131225.336600299@infradead.org>
 <20210602133040.398289363@infradead.org>
 <1873020549.5854.1622642347895.JavaMail.zimbra@efficios.com>
 <YLeRVQbXt2hCiO8f@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLeRVQbXt2hCiO8f@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 02, 2021 at 04:10:29PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 02, 2021 at 09:59:07AM -0400, Mathieu Desnoyers wrote:
> > ----- On Jun 2, 2021, at 9:12 AM, Peter Zijlstra peterz@infradead.org wrote:
> > 
> > > When ran from the sched-out path (preempt_notifier or perf_event),
> > > p->state is irrelevant to determine preemption. You can get preempted
> > > with !task_is_running() just fine.
> > > 
> > > The right indicator for preemption is if the task is still on the
> > > runqueue in the sched-out path.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > > kernel/events/core.c |    7 +++----
> > > virt/kvm/kvm_main.c  |    2 +-
> > > 2 files changed, 4 insertions(+), 5 deletions(-)
> > > 
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -8568,13 +8568,12 @@ static void perf_event_switch(struct tas
> > > 		},
> > > 	};
> > > 
> > > -	if (!sched_in && task->state == TASK_RUNNING)
> > > +	if (!sched_in && current->on_rq) {
> > 
> > This changes from checking task->state to current->on_rq, but this change
> > from "task" to "current" is not described in the commit message, which is odd.
> > 
> > Are we really sure that task == current here ?
> 
> Yeah, @task == @prev == current at this point, but yes, not sure why I
> changed that... lemme change that back to task.

FWIW, with that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

I have no strong feelings either way w.r.t. the whitespace cleanup. ;)

Thanks,
Mark
