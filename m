Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 Mar 2017 17:53:29 -0400
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tahsin Erdogan <tahsin@google.com>, linux-block@vger.kernel.org,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blkcg: allocate struct blkcg_gq outside request queue
 spinlock
Message-ID: <20170328215329.GF28157@htj.duckdns.org>
References: <CAAeU0aMvuzfkAyhzheYRxfb7NzLk2oJSzUk5+BoVcktrZDtcRw@mail.gmail.com>
 <20170324215627.12831-1-tahsin@google.com>
 <5b9ab59c-4121-d49a-1dc5-bd419f3ac94f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5b9ab59c-4121-d49a-1dc5-bd419f3ac94f@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Mar 24, 2017 at 04:04:32PM -0600, Jens Axboe wrote:
> On 03/24/2017 03:56 PM, Tahsin Erdogan wrote:
> > blkg_conf_prep() currently calls blkg_lookup_create() while holding
> > request queue spinlock. This means allocating memory for struct
> > blkcg_gq has to be made non-blocking. This causes occasional -ENOMEM
> > failures in call paths like below:
> > 
> >   pcpu_alloc+0x68f/0x710
> >   __alloc_percpu_gfp+0xd/0x10
> >   __percpu_counter_init+0x55/0xc0
> >   cfq_pd_alloc+0x3b2/0x4e0
> >   blkg_alloc+0x187/0x230
> >   blkg_create+0x489/0x670
> >   blkg_lookup_create+0x9a/0x230
> >   blkg_conf_prep+0x1fb/0x240
> >   __cfqg_set_weight_device.isra.105+0x5c/0x180
> >   cfq_set_weight_on_dfl+0x69/0xc0
> >   cgroup_file_write+0x39/0x1c0
> >   kernfs_fop_write+0x13f/0x1d0
> >   __vfs_write+0x23/0x120
> >   vfs_write+0xc2/0x1f0
> >   SyS_write+0x44/0xb0
> >   entry_SYSCALL_64_fastpath+0x18/0xad
> > 
> > In the code path above, percpu allocator cannot call vmalloc() due to
> > queue spinlock.
> > 
> > A failure in this call path gives grief to tools which are trying to
> > configure io weights. We see occasional failures happen shortly after
> > reboots even when system is not under any memory pressure. Machines
> > with a lot of cpus are more vulnerable to this condition.
> > 
> > Do struct blkcg_gq allocations outside the queue spinlock to allow
> > blocking during memory allocations.
> 
> This looks much simpler/cleaner to me, compared to v5. Tejun, what do
> you think?

So, this patch in itself looks better but now we end up with two
separate mechanisms to handle non-atomic allocations.  This drop lock
/ alloc / relock / check invariants in the main path and preallocation
logic used in the init path.  Right now, both proposed implementations
aren't that satisfactory.  Personally, I'd prefer superficial ugliness
to structural duplications, but, ideally, we shouldn't have to make
this choice.  idk, it's a bug fix.  We can always clean things up
later.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
