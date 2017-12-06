Return-Path: <oleg@redhat.com>
Date: Wed, 6 Dec 2017 18:32:56 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Benjamin LaHaise <ben@communityfibre.ca>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, Tejun Heo <tj@kernel.org>,
	axboe@kernel.dk, viro@zeniv.linux.org.uk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aio@kvack.org
Subject: Re: [PATCH 0/5] blkcg: Limit maximum number of aio requests
 available for cgroup
Message-ID: <20171206173256.GA24254@redhat.com>
References: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
 <20171204200756.GC2421075@devbig577.frc2.facebook.com>
 <17b22d53-ad3d-1ba8-854f-fc2a43d86c44@virtuozzo.com>
 <20171205151956.GA22836@redhat.com>
 <20171205153503.GE15720@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171205153503.GE15720@kvack.org>
List-ID: <linux-block@vger.kernel.org>

On 12/05, Benjamin LaHaise wrote:
>
> On Tue, Dec 05, 2017 at 04:19:56PM +0100, Oleg Nesterov wrote:
> >
> > and memory. let me quote my old emails...
> >
> >
> > This is off-topic, but the whole "vm" logic in aio_setup_ring()
> > looks sub-optimal. I do not mean the code, just it seems to me it
> > is pointless to pollute the page cache, and expose the pages we
> > can not swap/free to lru. Afaics we _only_ need this for migration.
>
> It is needed for migration, which is needed for hot unplug of memory.
> There is no way around this.

I know, and I even mentioned this above.


> > This memory lives in page-cache/lru, it is visible for shrinker which
> > will unmap these pages for no reason on memory shortage. IOW, aio fools
> > the kernel, this memory looks reclaimable but it is not. And we only do
> > this for migration.
>
> It's the same as any other memory that's mlock()ed into RAM.

No. Again, this memory is not properly accounted, and unlike mlock()ed
memory it is visible to shrinker which will do the unnecessary work on
memory shortage which in turn will lead to unnecessary page faults.

So let me repeat, shouldn't we at least do mapping_set_unevictable() in
aio_private_file() ?


> > triggers OOM-killer which kills sshd and other daemons on my machine.
> > These pages were not even faulted in (or the shrinker can unmap them),
> > the kernel can not know who should be blamed.
>
> The OOM-killer killed the wrong process: News at 11.

Well. I do not think we should blame OOM-killer in this case. But as I
said this is not a bug-report or something like this, I agree this is
a minor issue.

Oleg.
