Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52286 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756022AbeEILH7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 May 2018 07:07:59 -0400
Date: Wed, 9 May 2018 13:07:36 +0200
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
Subject: Re: [PATCH 7/7] psi: cgroup support
Message-ID: <20180509110736.GR12217@hirez.programming.kicks-ass.net>
References: <20180507210135.1823-1-hannes@cmpxchg.org>
 <20180507210135.1823-8-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180507210135.1823-8-hannes@cmpxchg.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 07, 2018 at 05:01:35PM -0400, Johannes Weiner wrote:
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -260,6 +260,18 @@ void psi_task_change(struct task_struct *task, u64 now, int clear, int set)
>  	task->psi_flags |= set;
>  
>  	psi_group_update(&psi_system, cpu, now, clear, set);
> +
> +#ifdef CONFIG_CGROUPS
> +       cgroup = task->cgroups->dfl_cgrp;
> +       while (cgroup && (parent = cgroup_parent(cgroup))) {
> +               struct psi_group *group;
> +
> +               group = cgroup_psi(cgroup);
> +               psi_group_update(group, cpu, now, clear, set);
> +
> +               cgroup = parent;
> +       }
> +#endif
>  }

TJ fixed needing that for stats at some point, why can't you do the
same?
