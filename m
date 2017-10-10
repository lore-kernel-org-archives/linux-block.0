Return-Path: <zwp10758@gmail.com>
Return-Path: <zwp10758@gmail.com>
From: weiping zhang <zwp10758@gmail.com>
Date: Tue, 10 Oct 2017 23:44:17 +0800
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH] blkcg: check pol->cpd_free_fn before free cpd
Message-ID: <20171010154417.GA38613@localhost.didichuxing.com>
References: <20171010145342.GA24247@localhost.didichuxing.com>
 <e161a324-40ba-fac8-d0e0-65b63ea8ceaf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e161a324-40ba-fac8-d0e0-65b63ea8ceaf@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 10, 2017 at 09:04:39AM -0600, Jens Axboe wrote:
> On 10/10/2017 08:53 AM, weiping zhang wrote:
> > check pol->cpd_free_fn() instead of pol->cpd_alloc_fn() when free cpd.
> 
> In practice this shouldn't make a difference, since if you have an
> alloc_fn, you better also have a free_fn. I'd argue a better
> patch would be ensuring that's the case, since the current situation
> would at least oops and show you there's an issue, but with the patch
> we'll just leak the memory.
> 
> I'll apply it, but would be nice if this was handled a bit more
> proactively.
> 
Thanks your comments, I'll add a sanity check in blkcg_policy_register
function.
