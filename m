Return-Path: <ben@communityfibre.ca>
Date: Wed, 6 Dec 2017 13:30:36 -0500
From: Benjamin LaHaise <ben@communityfibre.ca>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>,
	axboe@kernel.dk, viro@zeniv.linux.org.uk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aio@kvack.org
Subject: Re: [PATCH 0/5] blkcg: Limit maximum number of aio requests available for cgroup
Message-ID: <20171206183036.GO1493@kvack.org>
References: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain> <20171204200756.GC2421075@devbig577.frc2.facebook.com> <17b22d53-ad3d-1ba8-854f-fc2a43d86c44@virtuozzo.com> <20171205151956.GA22836@redhat.com> <20171205153503.GE15720@kvack.org> <20171206173256.GA24254@redhat.com> <20171206174445.GM1493@kvack.org> <103a542b-58c0-5d31-7b51-2a957a5bbd66@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <103a542b-58c0-5d31-7b51-2a957a5bbd66@virtuozzo.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Dec 06, 2017 at 09:19:09PM +0300, Kirill Tkhai wrote:
> On 06.12.2017 20:44, Benjamin LaHaise wrote:
> > On Wed, Dec 06, 2017 at 06:32:56PM +0100, Oleg Nesterov wrote:
> >>>> This memory lives in page-cache/lru, it is visible for shrinker which
> >>>> will unmap these pages for no reason on memory shortage. IOW, aio fools
> >>>> the kernel, this memory looks reclaimable but it is not. And we only do
> >>>> this for migration.
> >>>
> >>> It's the same as any other memory that's mlock()ed into RAM.
> >>
> >> No. Again, this memory is not properly accounted, and unlike mlock()ed
> >> memory it is visible to shrinker which will do the unnecessary work on
> >> memory shortage which in turn will lead to unnecessary page faults.
> >>
> >> So let me repeat, shouldn't we at least do mapping_set_unevictable() in
> >> aio_private_file() ?
> > 
> > Send a patch then!  I don't know why you're asking rather than sending a
> > patch to do this if you think it is needed.
> > 
> >>>> triggers OOM-killer which kills sshd and other daemons on my machine.
> >>>> These pages were not even faulted in (or the shrinker can unmap them),
> >>>> the kernel can not know who should be blamed.
> >>>
> >>> The OOM-killer killed the wrong process: News at 11.
> >>
> >> Well. I do not think we should blame OOM-killer in this case. But as I
> >> said this is not a bug-report or something like this, I agree this is
> >> a minor issue.
> > 
> > I do think the OOM-killer is doing the wrong thing here.  If process X is
> > the only one that is allocating gobs of memory, why kill process Y that
> > hasn't allocated memory in minutes or hours just because it is bigger?
> 
> I assume, if a process hasn't allocated memory in minutes or hours,
> then the most probably all of its evictable memory has already been
> moved to swap as its pages were last in lru list.

That assumption would be incorrect.  Just because memory isn't being
allocated doesn't mean that it isn't being used - the two are very
different things.  Most of the embedded systems I work on allocate memory
at startup and then use it until the system gets restarted or rebooted.
By only doing memory allocations at startup, code is simplified,
performance is more predictable and failure modes are constrained.

		-ben
-- 
"Thought is the essence of where you are now."
