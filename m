Return-Path: <oleg@redhat.com>
Date: Thu, 7 Dec 2017 14:44:47 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Benjamin LaHaise <ben@communityfibre.ca>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, Tejun Heo <tj@kernel.org>,
	axboe@kernel.dk, viro@zeniv.linux.org.uk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aio@kvack.org
Subject: Re: [PATCH 0/5] blkcg: Limit maximum number of aio requests
 available for cgroup
Message-ID: <20171207134447.GA7723@redhat.com>
References: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
 <20171204200756.GC2421075@devbig577.frc2.facebook.com>
 <17b22d53-ad3d-1ba8-854f-fc2a43d86c44@virtuozzo.com>
 <20171205151956.GA22836@redhat.com>
 <20171205153503.GE15720@kvack.org>
 <20171206173256.GA24254@redhat.com>
 <20171206174445.GM1493@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171206174445.GM1493@kvack.org>
List-ID: <linux-block@vger.kernel.org>

On 12/06, Benjamin LaHaise wrote:
>
> On Wed, Dec 06, 2017 at 06:32:56PM +0100, Oleg Nesterov wrote:
> >
> > No. Again, this memory is not properly accounted, and unlike mlock()ed
> > memory it is visible to shrinker which will do the unnecessary work on
> > memory shortage which in turn will lead to unnecessary page faults.
> >
> > So let me repeat, shouldn't we at least do mapping_set_unevictable() in
> > aio_private_file() ?

... and probably account this memory in ->pinned_vm

> Send a patch then!

I have no idea how to test this change, and personally I don't reallly care
about aio,

> I don't know why you're asking rather than sending a
> patch to do this if you think it is needed.

Because you are maintainer, and I naively thought it is always fine to
ask the maintainer if you think the code is not correct or sub-optimal.
Sorry for bothering you.

> > > > triggers OOM-killer which kills sshd and other daemons on my machine.
> > > > These pages were not even faulted in (or the shrinker can unmap them),
> > > > the kernel can not know who should be blamed.
> > >
> > > The OOM-killer killed the wrong process: News at 11.
> >
> > Well. I do not think we should blame OOM-killer in this case. But as I
> > said this is not a bug-report or something like this, I agree this is
> > a minor issue.
>
> I do think the OOM-killer is doing the wrong thing here.  If process X is
> the only one that is allocating gobs of memory,

aio_setup_ring() does find_or_create_page(file->f_mapping), this adds
the page to page cache. Again, this memory looks _reclaimable_ but it
is not because ctx->ring_pages has a reference.

I do not understand how we can blame OOM-killer, it should not kill the
task which blows the page cache, and this is how io_setup() looks to vm.

Quite possibly I missed something, please correct me.

Oleg.
