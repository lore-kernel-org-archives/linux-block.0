Return-Path: <oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 26 Jun 2018 22:35:19 +0200
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, broonie@kernel.org,
 linus.walleij@linaro.org, bfq-iosched@googlegroups.com
Subject: Re: [PATCH BUGFIX RESEND 0/4] bfq: fix bugs breaking bandwidth
 guarantees occasionally
In-Reply-To: <20180625195537.7769-1-paolo.valente@linaro.org>
References: <20180625195537.7769-1-paolo.valente@linaro.org>
Message-ID: <c0098394dac86d23935276a6d25d1f3a@natalenko.name>
List-ID: <linux-block@vger.kernel.org>

Hi.

On 25.06.2018 21:55, Paolo Valente wrote:
> Hi,
> during some bandwidth tests, I found some occasional but severe
> malfunctions (losses of bandwidth control). The first three patches in
> this series fix the bugs that caused these malfunctions. The last
> patch is a fix/improvement of the name of one of the functions
> involved with these bugs.
> 
> I guess these patches are appropriate for next kernel release.
> 
> Thanks,
> Paolo
> 
> Paolo Valente (4):
>   block, bfq: add/remove entity weights correctly
>   block, bfq: do not expire a queue that will deserve dispatch plugging
>   block, bfq: fix service being wrongly set to zero in case of
>     preemption
>   block, bfq: give a better name to bfq_bfqq_may_idle
> 
>  block/bfq-iosched.c | 131 
> +++++++++++++++++++++++++++++++++++++++++++---------
>  block/bfq-iosched.h |   7 ++-
>  block/bfq-wf2q.c    |  30 ++++++------
>  3 files changed, 128 insertions(+), 40 deletions(-)
> 
> --
> 2.16.1

So far, no smoke or visible issues while running it on my 2 SSDs with a 
daily workload applied.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thanks.

-- 
   Oleksandr Natalenko (post-factum)
