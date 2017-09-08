Return-Path: <shli@kernel.org>
Date: Fri, 8 Sep 2017 09:51:42 -0700
From: Shaohua Li <shli@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	lizefan@huawei.com, tglx@linutronix.de, kernel-team@fb.com,
	axboe@kernel.dk, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 1/3] kthread: add a mechanism to store cgroup info
Message-ID: <20170908165142.zn6yqhzi5gj4mq2p@kernel.org>
References: <cover.1504748195.git.shli@fb.com>
 <9d25e5bed5ef2fad5f8a817e293f0d93e3b329c2.1504748195.git.shli@fb.com>
 <20170908143537.GW1774378@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170908143537.GW1774378@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 08, 2017 at 07:35:37AM -0700, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 06, 2017 at 07:00:51PM -0700, Shaohua Li wrote:
> > +#ifdef CONFIG_CGROUPS
> > +void kthread_set_orig_css(struct cgroup_subsys_state *css);
> > +struct cgroup_subsys_state *kthread_get_orig_css(void);
> > +void kthread_reset_orig_css(void);
> 
> * It's a bit weird to associate a kthread with a css without being
>   specific.  If what's needed is a generic association (this kthread
>   is temporarily servicing this cgroup), it should be associated with
>   the cgroup.  But, I think it'd be better to make it specific instead
>   - ie. kthread_set_io_css().
> 
> * Do we need the reset function to be separate?  Can't we just clear
>   it when the set function is called with NULL css?
> 
> * For the accessor, can we do sth like kthread_orig_css() (or
>   kthread_io_css())?  "get" is overloaded between set/get and get/put,
>   so it can get confusing.
> 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index c05ac5f..ab2295d 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1276,6 +1276,7 @@ extern struct pid *cad_pid;
> >  #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
> >  #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_allowed */
> >  #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
> > +#define PF_KTHREAD_HAS_CSS	0x10000000	/* kthread has css info attached */
> 
> Do we need a separate flag for this?  kthreads already have PF_KTHREAD
> set.  I'm not sure why we'd need another flag.  Once we know it's a
> kthread, we can just access its css pointer field, right?

Ok, all suggestions are good, will update.

Thanks,
Shaohua
