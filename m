Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 18 Apr 2017 16:04:35 +0900
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Fabio Checconi <fchecconi@gmail.com>,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	linux-block@vger.kernel.org,
	Linux-Kernal <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org
Subject: Re: [PATCH V3 02/16] block, bfq: add full hierarchical scheduling
 and cgroups support
Message-ID: <20170418070435.GB3899@wtj.duckdns.org>
References: <20170411134315.44135-1-paolo.valente@linaro.org>
 <20170411134315.44135-3-paolo.valente@linaro.org>
 <20170411214702.GA31551@wtj.duckdns.org>
 <1E0945A9-43F8-496D-B631-FB293921F304@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1E0945A9-43F8-496D-B631-FB293921F304@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hello, Paolo.

On Wed, Apr 12, 2017 at 07:22:03AM +0200, Paolo Valente wrote:
> could you elaborate a bit more on this?  I mean, cgroups support has
> been in BFQ (and CFQ) for almost ten years, perfectly working as far
> as I know.  Of course it is perfectly working in terms of I/O and not
> of CPU bandwidth distribution; and, for the moment, it is effective
> only for devices below 30-50KIOPS.  What's the point in throwing
> (momentarily?) away such a fundamental feature?  What am I missing?

I've been trying to track down latency issues with the CPU controller
which basically takes the same approach and I'm not sure nesting
scheduler timelines is a good approach.  It intuitively feels elegant
but seems to have some fundamental issues.  IIUC, bfq isn't quite the
same in that it doesn't need load balancer across multiple queues and
it could be that bfq is close enough to the basic model that the
nested behavior maps to the correct scheduling behavior.

However, for example, in the CPU controller, the nested timelines
break sleeper boost.  The boost is implemented by considering the
thread to have woken up upto some duration prior to the current time;
however, it only affects the timeline inside the cgroup and there's no
good way to propagate it upwards.  The final result is two threads in
a cgroup with the double weight can behave significantly worse in
terms of latency compared to two threads with the weight of 1 in the
root.

Given that the nested scheduling ends up pretty expensive, I'm not
sure how good a model this nesting approach is.  Especially if there
can be multiple queues, the weight distribution across cgroup
instances across multiple queues has to be coordinated globally
anyway, so the weight / cost adjustment part can't happen
automatically anyway as in single queue case.  If we're going there,
we might as well implement cgroup support by actively modulating the
combined weights, which will make individual scheduling operations
cheaper and it easier to think about and guarantee latency behaviors.

If you think that bfq will stay single queue and won't need timeline
modifying heuristics (for responsiveness or whatever), the current
approach could be fine, but I'm a bit awry about committing to the
current approach if we're gonna encounter the same problems.

Thanks.

-- 
tejun
