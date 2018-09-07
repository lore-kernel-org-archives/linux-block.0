Return-Path: <dennisszhou@gmail.com>
Return-Path: <dennisszhou@gmail.com>
Date: Fri, 7 Sep 2018 16:24:30 -0400
From: Dennis Zhou <dennisszhou@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] blkcg: remove additional reference to the css
Message-ID: <20180907202429.GA97913@dennisz-mbp.dhcp.thefacebook.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
 <20180906211045.29055-10-dennisszhou@gmail.com>
 <20180907175446.GC1100574@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180907175446.GC1100574@devbig004.ftw2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 07, 2018 at 10:54:46AM -0700, Tejun Heo wrote:
> Hello,
> 
> On Thu, Sep 06, 2018 at 05:10:42PM -0400, Dennis Zhou wrote:
> > +struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
> > +					 struct cgroup_subsys *ss)
> > +{
> > +	struct cgroup_subsys_state *css;
> > +
> > +	rcu_read_lock();
> > +
> > +	do {
> > +		css = cgroup_css(cgrp, ss);
> > +
> > +		if (css)
> > +			goto out_unlock;
> > +		cgrp = cgroup_parent(cgrp);
> > +	} while (cgrp);
> > +
> > +	css = init_css_set.subsys[ss->id];
> > +out_unlock:
> > +	rcu_read_unlock();
> 
> Nothing protects @css here tho.  It can be released before the caller
> is done with it.  The caller must ensure that it's holding rcu read
> lock to protect the lookup and the subsequent uses.  cgroup_css()
> already checks for rcu locking, so if you just drop
> rcu_read_lock/unlock(), everything should work fine.
> 

Ah yes, that's my bad. I've removed it and the unnecessary goto now.

Thanks,
Dennis
