Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 4 Dec 2017 13:52:34 -0800
From: Tejun Heo <tj@kernel.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: axboe@kernel.dk, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aio@kvack.org, oleg@redhat.com
Subject: Re: [PATCH 0/5] blkcg: Limit maximum number of aio requests
 available for cgroup
Message-ID: <20171204215234.GN2421075@devbig577.frc2.facebook.com>
References: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
 <20171204200756.GC2421075@devbig577.frc2.facebook.com>
 <17b22d53-ad3d-1ba8-854f-fc2a43d86c44@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17b22d53-ad3d-1ba8-854f-fc2a43d86c44@virtuozzo.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Kirill.

On Tue, Dec 05, 2017 at 12:44:00AM +0300, Kirill Tkhai wrote:
> > Can you please explain how this is a fundamental resource which can't
> > be controlled otherwise?
> 
> Currently, aio_nr and aio_max_nr are global. In case of containers this
> means that a single container may occupy all aio requests, which are
> available in the system, and to deprive others possibility to use aio
> at all. This may happen because of evil intentions of the container's
> user or because of the program error, when the user makes this occasionally.

Hmm... I see.  It feels really wrong to me to make this a first class
resource because there is a system wide limit.  The only reason I can
think of for the system wide limit is to prevent too much kernel
memory consumed by creating a lot of aios but that squarely falls
inside cgroup memory controller protection.  If there are other
reasons why the number of aios should be limited system-wide, please
bring them up.

If the only reason is kernel memory consumption protection, the only
thing we need to do is making sure that memory used for aio commands
are accounted against cgroup kernel memory consumption and
relaxing/removing system wide limit.

Thanks.

-- 
tejun
