Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V3 02/16] block, bfq: add full hierarchical scheduling and cgroups support
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170418070435.GB3899@wtj.duckdns.org>
Date: Wed, 19 Apr 2017 07:33:49 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 broonie@kernel.org
Message-Id: <000F96F3-DF5D-4F3E-B1C5-C78795F5E0AA@linaro.org>
References: <20170411134315.44135-1-paolo.valente@linaro.org> <20170411134315.44135-3-paolo.valente@linaro.org> <20170411214702.GA31551@wtj.duckdns.org> <1E0945A9-43F8-496D-B631-FB293921F304@linaro.org> <20170418070435.GB3899@wtj.duckdns.org>
To: Tejun Heo <tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 18 apr 2017, alle ore 09:04, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello, Paolo.
>=20
> On Wed, Apr 12, 2017 at 07:22:03AM +0200, Paolo Valente wrote:
>> could you elaborate a bit more on this?  I mean, cgroups support has
>> been in BFQ (and CFQ) for almost ten years, perfectly working as far
>> as I know.  Of course it is perfectly working in terms of I/O and not
>> of CPU bandwidth distribution; and, for the moment, it is effective
>> only for devices below 30-50KIOPS.  What's the point in throwing
>> (momentarily?) away such a fundamental feature?  What am I missing?
>=20
> I've been trying to track down latency issues with the CPU controller
> which basically takes the same approach and I'm not sure nesting
> scheduler timelines is a good approach.  It intuitively feels elegant
> but seems to have some fundamental issues.  IIUC, bfq isn't quite the
> same in that it doesn't need load balancer across multiple queues and
> it could be that bfq is close enough to the basic model that the
> nested behavior maps to the correct scheduling behavior.
>=20
> However, for example, in the CPU controller, the nested timelines
> break sleeper boost.  The boost is implemented by considering the
> thread to have woken up upto some duration prior to the current time;
> however, it only affects the timeline inside the cgroup and there's no
> good way to propagate it upwards.  The final result is two threads in
> a cgroup with the double weight can behave significantly worse in
> terms of latency compared to two threads with the weight of 1 in the
> root.
>=20

Hi Tejun,
I don't know in detail the specific multiple-queue issues you report,
but bfq implements the upward propagation you mention: if a process in
a group is to be privileged, i.e., if the process has basically to be
provided with a higher weight (in addition to other important forms of
help), then this weight boost is propagated upward through the path
from the process to the root node in the group hierarchy.

> Given that the nested scheduling ends up pretty expensive, I'm not
> sure how good a model this nesting approach is.  Especially if there
> can be multiple queues, the weight distribution across cgroup
> instances across multiple queues has to be coordinated globally
> anyway,

To get perfect global service guarantees, yes.  But you can settle
with tradeoffs that, according to my experience with storage and
packet I/O, are so good to be probably indistinguishable from an
ideal, but too costly solution.  I mean, with a well-done approximated
scheduling solution, the deviation with respect to an ideal service
can be in the same order of the noise caused by unavoidable latencies
of other sw and hw components than the scheduler.

> so the weight / cost adjustment part can't happen
> automatically anyway as in single queue case.  If we're going there,
> we might as well implement cgroup support by actively modulating the
> combined weights, which will make individual scheduling operations
> cheaper and it easier to think about and guarantee latency behaviors.
>=20

Yes.  Anyway, I didn't quite understand what is or could be the
alternative, w.r.t. hierarchical scheduling, for guaranteeing
bandwidth distribution of shared resources in a complex setting.  If
you think I could be of any help on this, just put me somehow in the
loop.

> If you think that bfq will stay single queue and won't need timeline
> modifying heuristics (for responsiveness or whatever), the current
> approach could be fine, but I'm a bit awry about committing to the
> current approach if we're gonna encounter the same problems.
>=20

As of now, bfq is targeted at not too fast devices (< 30-50KIOPS),
which happen to be single queue.  In particular, bfq is currently
agnostic w.r.t.  to the number of downstream queues.

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun
