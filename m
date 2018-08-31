Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 31 Aug 2018 16:04:20 -0700
From: Tejun Heo <tj@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Dennis Zhou <dennisszhou@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>, kernel-team@fb.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] blkcg: fix ref count issue with bio_blkcg using
 task_css
Message-ID: <20180831230420.GB1488037@devbig004.ftw2.facebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-5-dennisszhou@gmail.com>
 <20180831153538.brzgcm3rgmwfy3rg@destiny>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831153538.brzgcm3rgmwfy3rg@destiny>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Fri, Aug 31, 2018 at 11:35:39AM -0400, Josef Bacik wrote:
> > +static inline struct cgroup_subsys_state *blkcg_get_css(void)
> > +{
> > +	struct cgroup_subsys_state *css;
> > +
> > +	rcu_read_lock();
> > +
> > +	css = kthread_blkcg();
> > +	if (css) {
> > +		css_get(css);
> > +	} else {
> > +		while (true) {
> > +			css = task_css(current, io_cgrp_id);
> > +			if (likely(css_tryget(css)))
> > +				break;
> > +			cpu_relax();
> 
> Does this work?  I'm ignorant of what cpu_relax() does, but it seems if we're
> rcu_read_lock()'ed here we aren't going to queisce so if we fail to get the css
> here we just simply aren't going to get it unless we go to sleep right?  An
> honest question, because this is all magic to me, I'd like to understand how
> this isn't going to infinite loop on us if css_tryget(css) fails.

The only time css_tryget() on task_css(current, xxx) can fail is if it
races against the current thread migrating away from that cgroup and
that cgroup is now getting destroyed.  IOW,

1. For css_tryget() to fail, the cgroup must be dying.
2. The cgroup must be empty for it to be dying.
3. current must have already been migrated away to a different cgroup.

So, the above happens only when racing against css_set_move_task() -
it's seeing the old css pointer.  As the membership pointer switching
must already have happened, all it's waiting for is the new css
membership pointer to be propagated on the polling cpu, making
cpu_relax() busy loop the right thing to do.

This pattern is also used in task_get_css() and cgroup_sk_alloc().
Given that it's a bit tricky, it probably would be worthwhile to
factor out and document it.

Once Josef's other concerns are addressed, please feel free to add

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
