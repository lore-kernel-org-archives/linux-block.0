Return-Path: <prvs=9403a763c3=shli@fb.com>
Date: Fri, 18 Aug 2017 09:28:25 -0700
From: Shaohua Li <shli@fb.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <Kernel-team@fb.com>
Subject: Re: [PATCH] blk-throttle: ignore discard request size
Message-ID: <20170818162825.GA21653@MacBook-Pro.dhcp.thefacebook.com>
References: <67ffcf14c2d15622b84c60a493b590dd81a07f51.1503068984.git.shli@fb.com>
 <e2144181-6129-96e2-0e44-66625da2f04a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <e2144181-6129-96e2-0e44-66625da2f04a@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Aug 18, 2017 at 09:35:01AM -0600, Jens Axboe wrote:
> On 08/18/2017 09:13 AM, Shaohua Li wrote:
> > discard request usually is very big and easily use all bandwidth budget
> > of a cgroup. discard request size doesn't really mean the size of data
> > written, so it doesn't make sense to account it into bandwidth budget.
> > This patch ignores discard requests size. It makes sense to account
> > discard request into iops budget though.
> 
> Some (most) devices to touch media for a discard operation, but the
> cost tends to be fairly constant and independent of discard size.
> Would it make sense to just treat it as a constant cost? Zero
> cost seems wrong.

that would be hard to find the cost. Would this make sense?

min_t(unsigned int, bio->bi_iter.bi_size, queue_max_sectors(q) << 9)
