Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 25 May 2017 10:37:00 -0400
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Linux-Kernal <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org
Subject: Re: [PATCH BUGFIX] block, bfq: access and cache blkg data only when
 safe
Message-ID: <20170525143700.GB23493@htj.duckdns.org>
References: <20170519083908.2588-1-paolo.valente@linaro.org>
 <20170519145442.GA7174@wtj.duckdns.org>
 <F79460BD-95A4-424B-8E3A-EC765745C447@linaro.org>
 <20170523204239.GI13222@htj.duckdns.org>
 <6E15A7C4-398F-4A93-A717-C499B3900EF0@linaro.org>
 <20170524145023.GA24798@htj.duckdns.org>
 <C9B2B7D3-1E92-4E22-80FA-8A606643B536@linaro.org>
 <20170524164704.GF24798@htj.duckdns.org>
 <DBB76394-B3DF-44AE-9536-8CDF270B37D5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DBB76394-B3DF-44AE-9536-8CDF270B37D5@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hello, Paolo.

On Thu, May 25, 2017 at 09:10:59AM +0200, Paolo Valente wrote:
> Ok.  So, just to better understand: as of now, i.e., before you make
> the changes you are proposing, the address returned by blkg_lookup can
> be used safely only if one both invokes blkg_lookup and gets a
> reference, while holding the rq lock all the time.  But then, before
> the changes you propose, what is the remaining role of rcu protection
> here?  Are there places where the value returned by blkg_lookup is
> actually used safely without getting a reference the returned blkg?

RCU protects the indexing structure and one doesn't have to hold rq
lock to just look up blkg.  The rule is a bit weird because we can
assume that the blkg's ref can be incremented in all places but that's
only because we don't destroy blkgs unless the associated blkcg or
device is destroyed, so we're cheating a little there.

Look for blkg_for_each_descendant_*() users for lockless lookup
examples.  There may be other uses but I can't remebmer off the top of
my head.

> Anyway, I'm willing to help with your proposal, if you think I can be
> of any help at some point.  In this respect, consider that I'm not an
> expert of percpu-refs either.

percpu-refs are not that different from regular atomic refcnts except
that the normal get / put operations are a lot cheaper (well, at least
scalable to a lot of concurrent operations), so better suited for
blk-mq.

> Finally, I guess that the general fix you have in mind may not be
> ready shortly.  So, I'll proceed with my temporary fix for the moment.
> In particular, I will
> 1) fix the typo reported by Jens;
> 2) add a note stating that this is a temporary fix;
> 3) if needed, modify commit log and comments in the diffs, to better
>     describe the general problem, and the actual critical race.

Sure, no objection there.

Thanks.

-- 
tejun
