Return-Path: <ben@communityfibre.ca>
Date: Tue, 5 Dec 2017 10:35:03 -0500
From: Benjamin LaHaise <ben@communityfibre.ca>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, Tejun Heo <tj@kernel.org>,
	axboe@kernel.dk, viro@zeniv.linux.org.uk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aio@kvack.org
Subject: Re: [PATCH 0/5] blkcg: Limit maximum number of aio requests available for cgroup
Message-ID: <20171205153503.GE15720@kvack.org>
References: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain> <20171204200756.GC2421075@devbig577.frc2.facebook.com> <17b22d53-ad3d-1ba8-854f-fc2a43d86c44@virtuozzo.com> <20171205151956.GA22836@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171205151956.GA22836@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Dec 05, 2017 at 04:19:56PM +0100, Oleg Nesterov wrote:
> On 12/05, Kirill Tkhai wrote:
> >
> > Currently, aio_nr and aio_max_nr are global.
> 
> Yeah, I too tried to complain 2 years ago...
> 
> > In case of containers this
> > means that a single container may occupy all aio requests, which are
> > available in the system,
> 
> and memory. let me quote my old emails...
> 
> 
> This is off-topic, but the whole "vm" logic in aio_setup_ring()
> looks sub-optimal. I do not mean the code, just it seems to me it
> is pointless to pollute the page cache, and expose the pages we
> can not swap/free to lru. Afaics we _only_ need this for migration.

It is needed for migration, which is needed for hot unplug of memory.
There is no way around this.

> This memory lives in page-cache/lru, it is visible for shrinker which
> will unmap these pages for no reason on memory shortage. IOW, aio fools
> the kernel, this memory looks reclaimable but it is not. And we only do
> this for migration.

It's the same as any other memory that's mlock()ed into RAM.

> Even if this is not a problem, this does not look right. So perhaps at
> least mapping_set_unevictable() makes sense. But I simply do not know
> if migration will work with this change.
> 
> 
> 
> Perhaps I missed something, doesn't matter. But this means that
> this memory is not accounted, so if I increase aio-max-nr then
> this test-case
> 
> 	#define __NR_io_setup	206
> 
> 	int main(void)
> 	{
> 		int nr;
> 
> 		for (nr = 0; ;++nr) {
> 			void *ctx = NULL;
> 			int ret = syscall(__NR_io_setup, 1, &ctx);
> 			if (ret) {
> 				printf("failed %d %m: ", nr);
> 				getchar();
> 			}
> 		}
> 
> 		return 0;
> 	}
> 
> triggers OOM-killer which kills sshd and other daemons on my machine.
> These pages were not even faulted in (or the shrinker can unmap them),
> the kernel can not know who should be blamed.

The OOM-killer killed the wrong process: News at 11.  This is not new
behaviour, and has always been an issue.  If it bothered to kill the
process that was doing the allocations, the ioctxes would be freed and all
would be well.  Doesn't the OOM killer take into account which process is
allocating memory?  Seems like a pretty major deficiency if it isn't.

> Shouldn't we account aio events/pages somehow, say per-user, or in
> mm->pinned_vm ?

Sure, I have no objection to that.  Please send a patch!

> I do not think this is unkown, and probably this all is fine. IOW,
> this is just a question, not a bug-report or something like this.
> 
> And of course, this is not exploitable because aio-max-nr limits
> the number of pages you can steal.

Which is why the aio-max-nr limit exists!  That it is imprecise and
imperfect is not being denied.

> But otoh, aio_max_nr is system-wide, so the unpriviliged user can
> ddos (say) mysqld. And this leads to the same question: shouldn't
> we account nr_events at least?

Anyone can DDoS the local system - this nothing new and has always been
the case.  I'm not opposed to improvements in this area.  The only issue I
have with Kirill's changes is that we need to have test cases for this new
functionality if the code is to be merged.

TBH, using memory accounting to limit things may be a better approach, as
that at least doesn't require changes to containers implementations to
obtain a benefit from bounding aio's memory usage.

		-ben

> Oleg.
> 

-- 
"Thought is the essence of where you are now."
