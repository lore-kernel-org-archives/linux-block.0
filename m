Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 5 Dec 2017 07:51:25 -0800
From: Tejun Heo <tj@kernel.org>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, axboe@kernel.dk, bcrl@kvack.org,
	viro@zeniv.linux.org.uk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-aio@kvack.org, oleg@redhat.com
Subject: Re: [PATCH 0/5] blkcg: Limit maximum number of aio requests
 available for cgroup
Message-ID: <20171205155125.GS2421075@devbig577.frc2.facebook.com>
References: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
 <20171204200756.GC2421075@devbig577.frc2.facebook.com>
 <17b22d53-ad3d-1ba8-854f-fc2a43d86c44@virtuozzo.com>
 <20171204215234.GN2421075@devbig577.frc2.facebook.com>
 <6eaa11a6-a087-42ab-df65-9142b59bf726@virtuozzo.com>
 <x49a7yyw14n.fsf@segfault.boston.devel.redhat.com>
 <707ca8fa-aee1-f068-b8ab-de5004d3d7ac@virtuozzo.com>
 <x49vahl5giw.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <x49vahl5giw.fsf@segfault.boston.devel.redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Jeff.

On Tue, Dec 05, 2017 at 10:41:11AM -0500, Jeff Moyer wrote:
> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
> 
> >> I think you just need to account the completion ring.
> >
> > A request of struct aio_kiocb type consumes much more memory, than
> > struct io_event does. Shouldn't we account it too?
> 
> Not in my opinion.  The completion ring is the part that gets pinned for
> long periods of time.

For memcg, it should account all possibly significant memory
consumptions whether long term or transitional.  Otherwise, isolation
doesn't really work that well.

> Just be sure to document this where appropriate.  Users/admins should
> know that the aio completion ring now contributes to their memory
> budget.

Yeah, the memory section in cgroup-v2.txt does have a section for
this.

Thanks.

-- 
tejun
