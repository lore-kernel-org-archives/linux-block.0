Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 24 May 2017 12:47:04 -0400
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Linux-Kernal <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org
Subject: Re: [PATCH BUGFIX] block, bfq: access and cache blkg data only when
 safe
Message-ID: <20170524164704.GF24798@htj.duckdns.org>
References: <20170519083908.2588-1-paolo.valente@linaro.org>
 <20170519145442.GA7174@wtj.duckdns.org>
 <F79460BD-95A4-424B-8E3A-EC765745C447@linaro.org>
 <20170523204239.GI13222@htj.duckdns.org>
 <6E15A7C4-398F-4A93-A717-C499B3900EF0@linaro.org>
 <20170524145023.GA24798@htj.duckdns.org>
 <C9B2B7D3-1E92-4E22-80FA-8A606643B536@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C9B2B7D3-1E92-4E22-80FA-8A606643B536@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Wed, May 24, 2017 at 05:43:18PM +0100, Paolo Valente wrote:
> > so none of the above objects can be destroyed before the request is
> > done.
> 
> ... the issue seems just to move to a more subtle position: cfq is ok,
> because it protects itself with rq lock, but blk-mq schedulers don't.
> So, the race that leads to the (real) crashes reported by people may
> actually be:

Oh, I was just thinking about !mq paths the whole time.

> 1 blkg_lookup executed on a blkg being destroyed: the scheduler gets a
> copy of the content of the blkg, but the rcu mechanism doesn't prevent
> destruction from going on
> 2 blkg_get gets executed on the copy of the original blkg

So, we can't do that.  We should look up and bump the ref and use the
original copy.  We probably should switch blkgs to use percpu-refs.

Thanks.

-- 
tejun
