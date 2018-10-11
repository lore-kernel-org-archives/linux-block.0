Return-Path: <axboe@kernel.dk>
Subject: Re: [RESEND][PATCH v2] cfq: clear queue pointers from cfqg after
 unpinning them in cfq_pd_offline
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Caspar Zhang <caspar@linux.alibaba.com>, jiufei.xue@linux.alibaba.com,
 Tejun Heo <tj@kernel.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <befb45da-2a7b-8dff-30e7-59b441f604fe@maciej.szmigiero.name>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3abb177f-d6ba-7f7b-e8a6-d27e8cf388a0@kernel.dk>
Date: Thu, 11 Oct 2018 11:46:37 -0600
MIME-Version: 1.0
In-Reply-To: <befb45da-2a7b-8dff-30e7-59b441f604fe@maciej.szmigiero.name>
Content-Type: text/plain; charset=iso-8859-2
List-ID: <linux-block@vger.kernel.org>

On 10/10/18 3:16 PM, Maciej S. Szmigiero wrote:
> BFQ is already doing a similar thing in its .pd_offline_fn() method
> implementation.
> 
> While it seems that after commit 4c6994806f70
> ("blk-throttle: fix race between blkcg_bio_issue_check() and cgroup_rmdir()")
> was reverted leaving these pointers intact no longer causes crashes
> clearing them is still a sensible thing to do to make the code more robust.

Applied, thanks.

-- 
Jens Axboe
