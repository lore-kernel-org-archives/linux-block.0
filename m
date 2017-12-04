Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 4 Dec 2017 15:02:33 -0800
From: Tejun Heo <tj@kernel.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: axboe@kernel.dk, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aio@kvack.org, oleg@redhat.com
Subject: Re: [PATCH 0/5] blkcg: Limit maximum number of aio requests
 available for cgroup
Message-ID: <20171204230233.GQ2421075@devbig577.frc2.facebook.com>
References: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
 <20171204200756.GC2421075@devbig577.frc2.facebook.com>
 <17b22d53-ad3d-1ba8-854f-fc2a43d86c44@virtuozzo.com>
 <20171204215234.GN2421075@devbig577.frc2.facebook.com>
 <6eaa11a6-a087-42ab-df65-9142b59bf726@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6eaa11a6-a087-42ab-df65-9142b59bf726@virtuozzo.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Kirill.

On Tue, Dec 05, 2017 at 01:49:42AM +0300, Kirill Tkhai wrote:
> > If the only reason is kernel memory consumption protection, the only
> > thing we need to do is making sure that memory used for aio commands
> > are accounted against cgroup kernel memory consumption and
> > relaxing/removing system wide limit.
> 
> So, we just use GFP_KERNEL_ACCOUNT flag for allocation of internal aio
> structures and pages, and all the memory will be accounted in kmem and
> limited by memcg. Looks very good.

Yeah.

> One detail about memory consumption. io_submit() calls primitives
> file_operations::write_iter and read_iter. It's not clear for me whether
> they consume the same memory as if writev() or readv() system calls
> would be used instead. writev() may delay the actual write till dirty
> pages limit will be reached, so it seems logic of the accounting should
> be the same. So aio mustn't use more not accounted system memory in file
> system internals, then simple writev().
> 
> Could you please to say if you have thoughts about this?

I'm not too familiar with vfs / filesystems but I don't think there's
gonna be significant unaccounted memory consumption.  It shouldn't be
too difficult to find out with experiments too.

Thanks.

-- 
tejun
