Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block/laptop_mode: Convert timers to use timer_setup()
To: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc: Michal Hocko <mhocko@suse.com>, Andrew Morton
 <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
 Johannes Weiner <hannes@cmpxchg.org>, Nicholas Piggin <npiggin@gmail.com>,
 Vladimir Davydov <vdavydov.dev@gmail.com>,
 Matthew Wilcox <mawilcox@microsoft.com>, Jeff Layton <jlayton@redhat.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>
References: <20171005004924.GA23053@beast>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4d4ccf50-d0b6-a525-dc73-0d64d26da68a@kernel.dk>
Date: Thu, 5 Oct 2017 08:56:51 -0600
MIME-Version: 1.0
In-Reply-To: <20171005004924.GA23053@beast>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/04/2017 06:49 PM, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Jeff Layton <jlayton@redhat.com>
> Cc: linux-block@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This requires commit 686fef928bba ("timer: Prepare to change timer
> callback argument type") in v4.14-rc3, but should be otherwise
> stand-alone.

My only complaint about this is the use of a from_timer() macro instead
of just using container_of() at the call sites to actually show that is
happening. I'm generally opposed to obfuscation like that. It just means
you have to look up what is going on, instead of it being readily
apparent to the reader/reviewer.

I guess I do have a a second complaint as well - that it landed in -rc3,
which is rather late considering subsystem trees are usually forked
earlier than that. Had this been in -rc1, I would have had an easier
time applying the block bits for 4.15.

-- 
Jens Axboe
