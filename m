Return-Path: <axboe@kernel.dk>
Subject: Re: unify the interface of the proportional-share policy in blkio/io
To: Tejun Heo <tj@kernel.org>, Paolo Valente <paolo.valente@linaro.org>
Cc: lennart@poettering.net, linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>,
 ANGELO RUOCCO <220530@studenti.unimore.it>
References: <56EFD7A1-A894-410D-A923-E33911ED4647@linaro.org>
 <20180109195205.GP3668920@devbig577.frc2.facebook.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <28156887-c8eb-f142-f6c4-db726680305b@kernel.dk>
Date: Tue, 9 Jan 2018 12:53:24 -0700
MIME-Version: 1.0
In-Reply-To: <20180109195205.GP3668920@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/9/18 12:52 PM, Tejun Heo wrote:
> Hello, Paolo.
> 
> On Thu, Jan 04, 2018 at 08:00:02PM +0100, Paolo Valente wrote:
>> The solution for the second type of parameters may prove useful to
>> unify also the computation of statistics for the throttling policy.
>>
>> Does this proposal sound reasonable?
> 
> So, the above should work too but I wonder whether we could do this
> simpler.  Frankly, I wouldn't mind if cfq and bfq can't be mixed on a
> system - e.g. they can be built together but you can't enable bfq on
> some devides and cfq on others.  If we do that, all we need to do is
> just removing / adding cftypes when either gets activated which cgroup
> already does.

Not sure that would fly, since cfq is legacy and bfq is mq. You don't
always have a free choice of which one to use...

-- 
Jens Axboe
