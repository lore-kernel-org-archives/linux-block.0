Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 12 Dec 2016 12:09:59 -0500
From: Tejun Heo <tj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Matthew Wilcox <mawilcox@microsoft.com>
Subject: Re: [RFC 00/10] implement alternative and much simpler id allocator
Message-ID: <20161212170959.GB13864@htj.duckdns.org>
References: <1481160187-9652-1-git-send-email-linux@rasmusvillemoes.dk>
 <20161209140140.5e0a68e2e1cf9861335bdf3b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161209140140.5e0a68e2e1cf9861335bdf3b@linux-foundation.org>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Fri, Dec 09, 2016 at 02:01:40PM -0800, Andrew Morton wrote:
> On Thu,  8 Dec 2016 02:22:55 +0100 Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
> > TL;DR: these patches save 250 KB of memory, with more low-hanging
> > fruit ready to pick.
> > 
> > While browsing through the lib/idr.c code, I noticed that the code at
> > the end of ida_get_new_above() probably doesn't work as intended: Most
> > users of ida use it via ida_simple_get(), and that starts by
> > unconditionally calling ida_pre_get(), ensuring that ida->idr has
> > 8==MAX_IDR_FREE idr_layers in its free list id_free. In the common
> > case, none (or at most one) of these get used during
> > ida_get_new_above(), and we only free one, leaving at least 6 (usually
> > 7) idr_layers in the free list.
> 
> Please be aware of
> 
> http://ozlabs.org/~akpm/mmots/broken-out/reimplement-idr-and-ida-using-the-radix-tree.patch
> http://lkml.kernel.org/r/1480369871-5271-68-git-send-email-mawilcox@linuxonhyperv.com
> 
> I expect we'll be merging patches 1-32 of that series into 4.10-rc1 and
> the above patch (#33) into 4.11-rc1.

Ah, yeah, great to see the silly implementation being replaced the
radix tree.  ida_pre_get() looks suspicious tho.  idr_preload()
immedicately being followed by idr_preload_end() probably is broken.
Maybe what we need is moving ida to idr like preload interface and
then convert it to radix based interface?  ida currently assumes
per-ida preloading.

Thanks.

-- 
tejun
