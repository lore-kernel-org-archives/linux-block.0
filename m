Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 10 May 2018 10:01:10 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, osandov@fb.com, efault@gmx.de,
	paolo.valente@linaro.org
Subject: Re: [PATCH 5/9] sbitmap: fix missed wakeups caused by
 sbitmap_queue_get_shallow()
Message-ID: <20180510170110.GE30485@vader>
References: <1525969467-12476-1-git-send-email-axboe@kernel.dk>
 <1525969467-12476-6-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525969467-12476-6-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 10, 2018 at 10:24:23AM -0600, Jens Axboe wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The sbitmap queue wake batch is calculated such that once allocations
> start blocking, all of the bits which are already allocated must be
> enough to fulfill the batch counters of all of the waitqueues. However,
> the shallow allocation depth can break this invariant, since we block
> before our full depth is being utilized. Add
> sbitmap_queue_min_shallow_depth(), which saves the minimum shallow depth
> the sbq will use, and update sbq_calc_wake_batch() to take it into
> account.
> 
> Acked-by: Paolo Valente <paolo.valente@linaro.org>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed -- haha, wait, thanks for picking this one up :)

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  include/linux/sbitmap.h | 29 +++++++++++++++++++++++++++++
>  lib/sbitmap.c           | 49 ++++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 69 insertions(+), 9 deletions(-)
