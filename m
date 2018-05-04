Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/3] block: don't disable interrupts during kmap_atomic()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-block@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
References: <20180504143247.5240-1-bigeasy@linutronix.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <19824605-9ff8-1122-a401-69ffd3fe558a@kernel.dk>
Date: Fri, 4 May 2018 08:36:41 -0600
MIME-Version: 1.0
In-Reply-To: <20180504143247.5240-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/4/18 8:32 AM, Sebastian Andrzej Siewior wrote:
> bounce_copy_vec() disables interrupts around kmap_atomic(). This is a
> leftover from the old kmap_atomic() implementation which relied on fixed
> mapping slots, so the caller had to make sure that the same slot could not
> be reused from an interrupting context.
> 
> kmap_atomic() was changed to dynamic slots long ago and commit 1ec9c5ddc17a
> ("include/linux/highmem.h: remove the second argument of k[un]map_atomic()")
> removed the slot assignements, but the callers were not checked for now
> redundant interrupt disabling.
> 
> Remove the conditional interrupt disable.

All three patches look fine to me, I'll queue them up for 4.18. In
the future, please include a cover letter for block patches when
sending > 1 patch. Makes it easier to reply to the series as a whole.

-- 
Jens Axboe
