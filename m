Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: BFQ default for single queue devices
To: Linus Walleij <linus.walleij@linaro.org>, linux-block@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>, Paolo Valente <paolo.valente@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
Date: Tue, 2 Oct 2018 08:31:07 -0600
MIME-Version: 1.0
In-Reply-To: <20181002124329.21248-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/2/18 6:43 AM, Linus Walleij wrote:
> This sets BFQ as the default scheduler for single queue
> block devices (nr_hw_queues == 1) if it is available. This
> affects notably MMC/SD-cards but notably also UBI and
> the loopback device.
> 
> I have been running it for a while without any negative
> effects on my pet systems and I want some wider testing
> so let's throw it out there and see what people say.
> Admittedly my use cases are limited.
> 
> I talked to Pavel a bit back and it turns out he has a
> usecase for BFQ as well and I bet he also would like it
> as default scheduler for that system (Pavel tell us more,
> I don't remember what it was!)
> 
> Intuitively I could understand that maybe we want to
> leave the loop device (possibly others? nbd? rbd?) as
> "none", as it is probably relying on a scheduler on the
> device below it, so I'm open to passing in a scheduler hint
> from the respective subsystem in say struct blk_mq_tag_set.
> However that makes for a bit of syntactic dissonance
> with the struct member ".nr_hw_queues" (I wonder how
> the loop device can have 1 "hardware queue"?) so
> maybe we should in that case also rename that struct
> member to ".nr_queues" fair and square before we start
> making adjustments for treating queues differently whether
> they are in hardware or actually not.

I think this should just be done with udev rules, and I'd
prefer if the distros would lead the way on this, as they
are the ones that will most likely see the most bug reports
on a change like this.

-- 
Jens Axboe
