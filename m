Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 6 Jul 2016 11:06:29 -0400
From: Tejun Heo <tj@kernel.org>
To: aaronlee0817 <aaronlee0817@163.com>
Cc: axboe@kernel.dk, mlin@kernel.org, shli@kernel.org,
	linux-kernel@vger.kernel.org, cgroup@vger.kernel.org,
	jiale0817.li@samsung.com, yanzi.zhang@samsung.com,
	zhen1.zhang@samsung.com, linux-block@vger.kernel.org
Subject: Re: Re: cgroup: Fix split bio been throttled more than once
Message-ID: <20160706150629.GA31684@mtj.duckdns.org>
References: <77238e99.142c5.155b660564f.Coremail.aaronlee0817@163.com>
 <20160705222626.GC25394@htj.duckdns.org>
 <458d1946.12fa6.155c0b80d60.Coremail.aaronlee0817@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <458d1946.12fa6.155c0b80d60.Coremail.aaronlee0817@163.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Wed, Jul 06, 2016 at 10:58:55PM +0800, aaronlee0817 wrote:
> >But that said, can't we just copy BIO_THROTLED while splitting?
> 
> In my opinion， copying BIO_THROTLED while splitting doesn't work
> with this, because, the bio within the limit will not set BIO_THROTLED
> but will be split, and back to call generic_make_request(), and will be 
> count twice.

I see.  It's just a bit weird that we're marking this from clone site
when it's an issue which is specific to throttling.  The thing is
depending on how bio clone is used, it could misbehave in the other
direction (bio not accounted at all).  What we want to know is whether
a bio has been previously accounted or not, rather than whether a bio
is a result of splitting.  I think it'd be better to track that
instead.

Thanks.

-- 
tejun
