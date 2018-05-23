Return-Path: <linux-block-owner@vger.kernel.org>
Received: from gum.cmpxchg.org ([85.214.110.215]:51818 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932875AbeEWNPt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 May 2018 09:15:49 -0400
Date: Wed, 23 May 2018 09:17:47 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vinayak Menon <vinmenon@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>,
        Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>,
        Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Ruslan Ruslichenko <rruslich@cisco.com>, kernel-team@fb.com
Subject: Re: [PATCH 6/7] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180523131747.GA4086@cmpxchg.org>
References: <20180507210135.1823-1-hannes@cmpxchg.org>
 <20180507210135.1823-7-hannes@cmpxchg.org>
 <87060553-2e09-2e2a-13a2-a91345d6df30@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87060553-2e09-2e2a-13a2-a91345d6df30@codeaurora.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, May 09, 2018 at 04:33:24PM +0530, Vinayak Menon wrote:
> On 5/8/2018 2:31 AM, Johannes Weiner wrote:
> > +	/* Kick the stats aggregation worker if it's gone to sleep */
> > +	if (!delayed_work_pending(&group->clock_work))
> 
> This causes a crash when the work is scheduled before system_wq is up. In my case when the first
> schedule was called from kthreadd. And I had to do this to make it work.
> if (keventd_up() && !delayed_work_pending(&group->clock_work))
>
> > +		schedule_delayed_work(&group->clock_work, MY_LOAD_FREQ);

I was trying to figure out how this is possible, and it didn't make
sense because we do initialize the system_wq way before kthreadd.

Did you by any chance backport this to a pre-4.10 kernel which does
not have 3347fa092821 ("workqueue: make workqueue available early
during boot") yet?

> > +void psi_task_change(struct task_struct *task, u64 now, int clear, int set)
> > +{
> > +	struct cgroup *cgroup, *parent;
> 
> unused variables

They're used in the next patch, I'll fix that up.

Thanks
