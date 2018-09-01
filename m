Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 31 Aug 2018 17:29:00 -0700
From: Tejun Heo <tj@kernel.org>
To: Dennis Zhou <dennisszhou@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/15] blkcg: cleanup and make blk_get_rl use
 blkg_lookup_create
Message-ID: <20180901002900.GJ1488037@devbig004.ftw2.facebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-13-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831015356.69796-13-dennisszhou@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 30, 2018 at 09:53:53PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> blk_get_rl is responsible for identifying which request_list a request
> should be allocated to. Try get logic was added earlier, but
> semantically the logic was not changed.
> 
> This patch makes better use of the bio already having a reference to the
> blkg in the hot path. The cold path uses a better fallback of
> blkg_lookup_create rather than just blkg_lookup and then falling back to
> the q->root_rl. If lookup_create fails with anything but -ENODEV, it
> falls back to q->root_rl.
> 
> A clarifying comment is added to explain why q->root_rl is used rather
> than the root blkg's rl.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

We're replicating that retry busy loop a lot.  It'd be really great to
factor that out and document what it's doing.

Thanks.

-- 
tejun
