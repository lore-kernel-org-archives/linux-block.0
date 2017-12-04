Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 4 Dec 2017 12:07:56 -0800
From: Tejun Heo <tj@kernel.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: axboe@kernel.dk, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aio@kvack.org, oleg@redhat.com
Subject: Re: [PATCH 0/5] blkcg: Limit maximum number of aio requests
 available for cgroup
Message-ID: <20171204200756.GC2421075@devbig577.frc2.facebook.com>
References: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

Hello, Kirill.

On Mon, Dec 04, 2017 at 07:12:51PM +0300, Kirill Tkhai wrote:
> this patch set introduces accounting aio_nr and aio_max_nr per blkio cgroup.
> It may be used to limit number of aio requests, which are available for
> a cgroup, and could be useful for containers.

Can you please explain how this is a fundamental resource which can't
be controlled otherwise?

Thanks.

-- 
tejun
