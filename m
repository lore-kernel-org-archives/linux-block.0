Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 23 May 2017 16:42:39 -0400
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Linux-Kernal <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org
Subject: Re: [PATCH BUGFIX] block, bfq: access and cache blkg data only when
 safe
Message-ID: <20170523204239.GI13222@htj.duckdns.org>
References: <20170519083908.2588-1-paolo.valente@linaro.org>
 <20170519145442.GA7174@wtj.duckdns.org>
 <F79460BD-95A4-424B-8E3A-EC765745C447@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F79460BD-95A4-424B-8E3A-EC765745C447@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hello, Paolo.

On Sat, May 20, 2017 at 09:27:33AM +0200, Paolo Valente wrote:
> Consider a process or a group that is moved from a given source group
> to a different group, or simply removed from a group (although I
> didn't yet succeed in just removing a process from a group :) ).  The
> pointer to the [b|c]fq_group contained in the schedulable entity
> belonging to the source group *is not* updated, in BFQ, if the entity
> is idle, and *is not* updated *unconditionally* in CFQ.  The update
> will happen in bfq_get_rq_private or cfq_set_request, on the arrival
> of a new request.  But, if the move happens right after the arrival of
> a request, then all the scheduler functions executed until a new
> request arrives for that entity will see a stale [b|c]fq_group.  Much

Limited staleness is fine.  Especially in this case, it isn't too
weird to claim that the order between the two operations isn't clearly
defined.

> worse, if also a blkcg_deactivate_policy or a blkg_destroy are
> executed right after the move, then both the policy data pointed by
> the [b|c]fq_group and the [b|c]fq_group itself may be deallocated.
> So, all the functions of the scheduler invoked before next request
> arrival may use dangling references!

Hmm... but cfq_group is allocated along with blkcg and blkcg always
ensures that there are no blkg left before freeing the pd area in
blkcg_css_offline().

Thanks.

-- 
tejun
