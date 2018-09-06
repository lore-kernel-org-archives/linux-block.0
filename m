Return-Path: <dennisszhou@gmail.com>
Return-Path: <dennisszhou@gmail.com>
Date: Thu, 6 Sep 2018 16:45:15 -0400
From: Dennis Zhou <dennisszhou@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/15] blkcg: remove additional reference to the css
Message-ID: <20180906204514.GC26048@dennisz-mbp.dhcp.thefacebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-12-dennisszhou@gmail.com>
 <20180901002603.GI1488037@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180901002603.GI1488037@devbig004.ftw2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Aug 31, 2018 at 05:26:03PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Thu, Aug 30, 2018 at 09:53:52PM -0400, Dennis Zhou wrote:
> > -	css = cgroup_get_e_css(page->mem_cgroup->css.cgroup, &io_cgrp_subsys);
> >  
> > -	return __bio_associate_blkg_from_css(bio, css);
> > +	rcu_read_lock();
> > +
> > +	while (true) {
> > +		css = cgroup_e_css(page->mem_cgroup->css.cgroup,
> > +				   &io_cgrp_subsys);
> 
> So, while they seem similar cgroup_e_css() and cgroup_get_e_css()
> behave very differently in terms of locking.  cgroup_e_css() can only
> be used under cgroup_mutex because it is used during migration and has
> to test cgroup_ss_mask().  The right thing to do here would be
> renaming cgroup_e_css() to something else and add a new implementation
> which operates in the same way as cgroup_get_e_css().
> 
> BTW, this should have triggered lockdep warning.  I'd strongly
> recommend testing with lockdep enabled.
> 
> Other than that, looks good to me.
> 

I see. I've renamed the original cgroup_e_css() to
cgroup_e_css_by_mask() and then did what cgroup_get_e_css() did without
the get part in the new cgroup_e_css().

Thanks,
Dennis
