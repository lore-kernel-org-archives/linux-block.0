Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 8 Sep 2017 10:54:10 -0700
From: Tejun Heo <tj@kernel.org>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	lizefan@huawei.com, tglx@linutronix.de, kernel-team@fb.com,
	axboe@kernel.dk, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 3/3] block/loop: make loop cgroup aware
Message-ID: <20170908175409.GB1774378@devbig577.frc2.facebook.com>
References: <cover.1504748195.git.shli@fb.com>
 <83915a4be672d99729029800196008c3b39c7a3a.1504748195.git.shli@fb.com>
 <20170908144808.GA1774378@devbig577.frc2.facebook.com>
 <20170908170715.54c536vy77w2biki@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170908170715.54c536vy77w2biki@kernel.org>
List-ID: <linux-block@vger.kernel.org>

Hello, Shaohua.

On Fri, Sep 08, 2017 at 10:07:15AM -0700, Shaohua Li wrote:
> > The fact that we're forwarding explicitly in loop still bothers me a
> > bit.  Can you please elaborate why we don't want to do this
> > generically through aio?
> 
> I think we must forward in loop, because each cmd could come from different
> cgroup, so we must explicitly forward for each cmd.
> 
> The main reason not to do the forward in aio is complexity. We at least have 3
> different implementations for dio:
> - __blockdev_direct_IO for ext4 and btrfs
> - iomap dio for xfs
> - blockdev dio implementation
> 
> Forwarding in dio means hooking the cgroup association for each bio dispatched
> in the implementations, which is a little messy. I'd like to avoid this if
> there is no strong reason to do it.

I see.  I think the important questions is whether we're failing to
forward io cgroup membership propagation on some aios?  If we are,
that is an obvious bug which should be addressed one way or the other,
and there's a fair chance that we wouldn't need to do anything special
for loop.

Given how simple the loop changes are, we sure can go with loop
specific changes for now; however, I'm a bit unconvinced that aio
changes would be that much more complex.  Can you please look into it?
If it is actually complex, we sure can do it later but I'd much prefer
to plug the hole as soon as possible.

Thanks.

-- 
tejun
