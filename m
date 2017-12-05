Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Tejun Heo <tj@kernel.org>,  axboe@kernel.dk,  bcrl@kvack.org,  viro@zeniv.linux.org.uk,  linux-block@vger.kernel.org,  linux-kernel@vger.kernel.org,  linux-aio@kvack.org,  oleg@redhat.com
Subject: Re: [PATCH 0/5] blkcg: Limit maximum number of aio requests available for cgroup
References: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
	<20171204200756.GC2421075@devbig577.frc2.facebook.com>
	<17b22d53-ad3d-1ba8-854f-fc2a43d86c44@virtuozzo.com>
	<20171204215234.GN2421075@devbig577.frc2.facebook.com>
	<6eaa11a6-a087-42ab-df65-9142b59bf726@virtuozzo.com>
	<x49a7yyw14n.fsf@segfault.boston.devel.redhat.com>
	<707ca8fa-aee1-f068-b8ab-de5004d3d7ac@virtuozzo.com>
Date: Tue, 05 Dec 2017 10:41:11 -0500
In-Reply-To: <707ca8fa-aee1-f068-b8ab-de5004d3d7ac@virtuozzo.com> (Kirill
	Tkhai's message of "Tue, 5 Dec 2017 02:14:54 +0300")
Message-ID: <x49vahl5giw.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Kirill Tkhai <ktkhai@virtuozzo.com> writes:

>> I think you just need to account the completion ring.
>
> A request of struct aio_kiocb type consumes much more memory, than
> struct io_event does. Shouldn't we account it too?

Not in my opinion.  The completion ring is the part that gets pinned for
long periods of time.

Just be sure to document this where appropriate.  Users/admins should
know that the aio completion ring now contributes to their memory
budget.

Cheers,
Jeff
