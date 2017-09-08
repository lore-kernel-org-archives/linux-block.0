Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 8 Sep 2017 07:40:32 -0700
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	lizefan@huawei.com, tglx@linutronix.de, kernel-team@fb.com,
	axboe@kernel.dk, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 1/3] kthread: add a mechanism to store cgroup info
Message-ID: <20170908144032.GY1774378@devbig577.frc2.facebook.com>
References: <cover.1504748195.git.shli@fb.com>
 <9d25e5bed5ef2fad5f8a817e293f0d93e3b329c2.1504748195.git.shli@fb.com>
 <20170908143537.GW1774378@devbig577.frc2.facebook.com>
 <20170908143846.GX1774378@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170908143846.GX1774378@devbig577.frc2.facebook.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 08, 2017 at 07:38:46AM -0700, Tejun Heo wrote:
> On Fri, Sep 08, 2017 at 07:35:37AM -0700, Tejun Heo wrote:
> > * It's a bit weird to associate a kthread with a css without being
> >   specific.  If what's needed is a generic association (this kthread
> >   is temporarily servicing this cgroup), it should be associated with
> >   the cgroup.  But, I think it'd be better to make it specific instead
> >   - ie. kthread_set_io_css().
> 
> kthread[_set]_blkcg_css() probably is a more consistent name.

Sorry, I meant kthread[_associate]_blkcg() so that it's consistent
with bio[_associate]_blkcg().

Thanks.

-- 
tejun
