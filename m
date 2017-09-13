Return-Path: <shli@kernel.org>
Date: Wed, 13 Sep 2017 15:30:04 -0700
From: Shaohua Li <shli@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	lizefan@huawei.com, tglx@linutronix.de, kernel-team@fb.com,
	axboe@kernel.dk, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V2 1/4] kthread: add a mechanism to store cgroup info
Message-ID: <20170913223004.qevnu4higaxyb74b@kernel.org>
References: <cover.1505335620.git.shli@fb.com>
 <802ba16bd896e56bc974780e97157760fde7c273.1505335620.git.shli@fb.com>
 <20170913213820.GA378890@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170913213820.GA378890@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 13, 2017 at 02:38:20PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 13, 2017 at 02:01:26PM -0700, Shaohua Li wrote:
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index 26db528..3107eee 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -20,7 +20,6 @@
> >  #include <linux/freezer.h>
> >  #include <linux/ptrace.h>
> >  #include <linux/uaccess.h>
> > -#include <linux/cgroup.h>
> >  #include <trace/events/sched.h>
> >  
> >  static DEFINE_SPINLOCK(kthread_create_lock);
> > @@ -47,6 +46,7 @@ struct kthread {
> >  	void *data;
> >  	struct completion parked;
> >  	struct completion exited;
> 
> maybe #ifdef CONFIG_CGROUPS?
> 
> > +	struct cgroup_subsys_state *blkcg_css;

Ah, I thought cgroup_subsys_state is always defined, let me double check.

> >  };
> ...
> > +void kthread_associate_blkcg(struct cgroup_subsys_state *css)
> > +{
> > +	struct kthread *kthread;
> > +
> > +	if (!(current->flags & PF_KTHREAD) || !current->set_child_tid)
> > +		return;
> > +	kthread = to_kthread(current);
> > +	if (css) {
> > +		css_get(css);
> > +		kthread->blkcg_css = css;
> > +	} else if (kthread->blkcg_css) {
> > +		css_put(kthread->blkcg_css);
> > +		kthread->blkcg_css = NULL;
> > +	}
> > +}
> > +EXPORT_SYMBOL(kthread_associate_blkcg);
> 
> Maybe doing sth like the following is less error-prone?
> 
> kthread_associate_blkcg(@css)
> {
> 	if (current's kthread->blkcg_css)
> 		put kthread->blkcg_css and set it to NULL;
> 	if (@css)
> 		get @css and set kthread->blkcg;
> }

Sounds good.

Thanks,
Shaohua
