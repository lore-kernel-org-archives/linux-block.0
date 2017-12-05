Return-Path: <oleg@redhat.com>
Date: Tue, 5 Dec 2017 16:19:56 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Tejun Heo <tj@kernel.org>, axboe@kernel.dk, bcrl@kvack.org,
	viro@zeniv.linux.org.uk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [PATCH 0/5] blkcg: Limit maximum number of aio requests
 available for cgroup
Message-ID: <20171205151956.GA22836@redhat.com>
References: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
 <20171204200756.GC2421075@devbig577.frc2.facebook.com>
 <17b22d53-ad3d-1ba8-854f-fc2a43d86c44@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17b22d53-ad3d-1ba8-854f-fc2a43d86c44@virtuozzo.com>
List-ID: <linux-block@vger.kernel.org>

On 12/05, Kirill Tkhai wrote:
>
> Currently, aio_nr and aio_max_nr are global.

Yeah, I too tried to complain 2 years ago...

> In case of containers this
> means that a single container may occupy all aio requests, which are
> available in the system,

and memory. let me quote my old emails...


This is off-topic, but the whole "vm" logic in aio_setup_ring()
looks sub-optimal. I do not mean the code, just it seems to me it
is pointless to pollute the page cache, and expose the pages we
can not swap/free to lru. Afaics we _only_ need this for migration.

This memory lives in page-cache/lru, it is visible for shrinker which
will unmap these pages for no reason on memory shortage. IOW, aio fools
the kernel, this memory looks reclaimable but it is not. And we only do
this for migration.

Even if this is not a problem, this does not look right. So perhaps at
least mapping_set_unevictable() makes sense. But I simply do not know
if migration will work with this change.



Perhaps I missed something, doesn't matter. But this means that
this memory is not accounted, so if I increase aio-max-nr then
this test-case

	#define __NR_io_setup	206

	int main(void)
	{
		int nr;

		for (nr = 0; ;++nr) {
			void *ctx = NULL;
			int ret = syscall(__NR_io_setup, 1, &ctx);
			if (ret) {
				printf("failed %d %m: ", nr);
				getchar();
			}
		}

		return 0;
	}

triggers OOM-killer which kills sshd and other daemons on my machine.
These pages were not even faulted in (or the shrinker can unmap them),
the kernel can not know who should be blamed.

Shouldn't we account aio events/pages somehow, say per-user, or in
mm->pinned_vm ?

I do not think this is unkown, and probably this all is fine. IOW,
this is just a question, not a bug-report or something like this.

And of course, this is not exploitable because aio-max-nr limits
the number of pages you can steal.

But otoh, aio_max_nr is system-wide, so the unpriviliged user can
ddos (say) mysqld. And this leads to the same question: shouldn't
we account nr_events at least?

Oleg.
