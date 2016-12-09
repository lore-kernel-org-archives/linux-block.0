Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 9 Dec 2016 08:49:14 -0500
From: Tejun Heo <tj@kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC 00/10] implement alternative and much simpler id allocator
Message-ID: <20161209134914.GC30394@mtj.duckdns.org>
References: <1481160187-9652-1-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481160187-9652-1-git-send-email-linux@rasmusvillemoes.dk>
List-ID: <linux-block@vger.kernel.org>

Hello, Rasmus.

On Thu, Dec 08, 2016 at 02:22:55AM +0100, Rasmus Villemoes wrote:
> TL;DR: these patches save 250 KB of memory, with more low-hanging
> fruit ready to pick.
> 
> While browsing through the lib/idr.c code, I noticed that the code at
> the end of ida_get_new_above() probably doesn't work as intended: Most
> users of ida use it via ida_simple_get(), and that starts by
> unconditionally calling ida_pre_get(), ensuring that ida->idr has
> 8==MAX_IDR_FREE idr_layers in its free list id_free. In the common
> case, none (or at most one) of these get used during
> ida_get_new_above(), and we only free one, leaving at least 6 (usually
> 7) idr_layers in the free list.

So, if you take a look at idr_layer_alloc(), there are two alternative
preloading mechanisms.  The one based on per-idr freelist -
get_from_free_list() - and the one using per-cpu preload cache.  idr
currently uses the new percpu path and ida uses the old path.  There
isn't anything fundamental to this difference.  It's just that we
introduced the new perpcu path to idr and haven't converted ida over
to it yet.

> Patches 1 and 2 are minor optimization opportunities, while patch 3 is
> an attempt at making the 'free the extra idr_layers one at a time'
> actually work. But it's not a very good solution, since it doesn't
> help the users who never do more than a handful of allocations, nor
> does it help those who call ida_pre_get/ida_get_new
> directly. Moreover, even if we somehow had perfect heuristics and got
> rid of all excess idr_layers and ida_bitmap (another 128 bytes we
> usually have hanging around), the minimum overhead of sizeof(struct
> idr_layer)+sizeof(struct ida_bitmap) ~ 2200 bytes is quite a lot for
> the many ida users who never allocate more than 100 ids.
> 
> So instead/in addition, I suggest we introduce a much simpler
> allocator based on a dynamically growing bitmap. Patches 4-10
> introduce struct tida and has a few examples of replacing ida with
> tida. [Yeah, tida is not a good name, and probably _get and _put are also
> bad.]

So, instead of creating something new, it'd be a lot better to
implement the same per-cpu preload behavior for ida so that caching is
per-cpu instead of per-ida.

Thanks.

-- 
tejun
