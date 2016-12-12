Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 12 Dec 2016 13:05:01 -0500
From: Tejun Heo <tj@kernel.org>
To: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
Subject: Re: [RFC 00/10] implement alternative and much simpler id allocator
Message-ID: <20161212180501.GD13864@htj.duckdns.org>
References: <1481160187-9652-1-git-send-email-linux@rasmusvillemoes.dk>
 <20161209140140.5e0a68e2e1cf9861335bdf3b@linux-foundation.org>
 <20161212170959.GB13864@htj.duckdns.org>
 <BY2PR21MB0036238FFF7D84F17509B651CB980@BY2PR21MB0036.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BY2PR21MB0036238FFF7D84F17509B651CB980@BY2PR21MB0036.namprd21.prod.outlook.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Matthew.

On Mon, Dec 12, 2016 at 05:35:17PM +0000, Matthew Wilcox wrote:
> I know the preload followed by preload_end looks wrong.  I don't
> think it's broken though.  If we get preempted, then the worst
> situation is that we'll end up with the memory we preallocated being
> allocated to somebody else.  Then the attempt to allocate memory can
> fail, and we'll return -EAGAIN, at which point all callers are
> supposed to return to the pre_get() stage.  Certainly that's what
> ida_simple_get() does.

Ah, right, ida_pre_get() doesn't have any protection against other
task allocating inbetween pre_get and the actual allocation, so it
should retry on failure.  Yeah, then the proposed preloading wouldn't
be wrong.  It'd be nice to explain what's going on tho.

> I'd definitely be open to changing the IDA API.  I know Kent had
> some thoughts on that including splitting the simple lock into a
> per-IDA lock.  His last work on it was here, I believe:
> 
> https://evilpiepirate.org/git/linux-bcache.git/log/?h=idr

Yeah, that was a big re-write, but for now I think it'd be nice to
replace ida's pre_get mechanism with something similar to idr's
preload so that they're more consistent.  There aren't that many
direct users of ida_pre_get(), so it shouldn't be too difficult to
change.

Thanks.

-- 
tejun
