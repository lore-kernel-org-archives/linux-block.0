Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
To: Linus Walleij <linus.walleij@linaro.org>, linux-block@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>, Paolo Valente <paolo.valente@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>,
 Adrian Hunter <adrian.hunter@intel.com>, Bart Van Assche
 <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
 Artem Bityutskiy <dedekind1@gmail.com>, Christoph Hellwig
 <hch@infradead.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
 Mark Brown <broonie@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Johannes Thumshirn <jthumshirn@suse.de>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Jonathan Corbet <corbet@lwn.net>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d25e02de-e1be-0fb7-237b-3e53d56c6f64@kernel.dk>
Date: Mon, 15 Oct 2018 09:39:17 -0600
MIME-Version: 1.0
In-Reply-To: <20181015141059.26579-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/15/18 8:10 AM, Linus Walleij wrote:
> This sets BFQ as the default scheduler for single queue
> block devices (nr_hw_queues == 1) if it is available. This
> affects notably MMC/SD-cards but also UBI and the loopback
> device.
> 
> I have been running it for a while without any negative
> effects on my pet systems and I want some wider testing
> so let's throw it out there and see what people say.
> Admittedly my use cases are limited. I need to keep this
> patch around for my personal needs anyway.
> 
> We take special care to avoid using BFQ on zoned devices
> (in particular SMR, shingled magnetic recording devices)
> as these currently require mq-deadline to group writes
> together.
> 
> I have opted against introducing any default scheduler
> through Kconfig as the mq-deadline enforcement for
> zoned devices has to be done at runtime anyways and
> too many config options will make things confusing.
> 
> My argument for setting a default policy in the kernel
> as opposed to user space is the "reasonable defaults"
> type, analogous to how we have one default CPU scheduling
> policy (CFS) that make most sense for most tasks, and
> how automatic process group scheduling happens in most
> distributions without userspace involvement. The BFQ
> scheduling policy makes most sense for single hardware
> queue devices and many embedded systems will not have
> the clever userspace tools (such as udev) to make an
> educated choice of scheduling policy. Defaults should be
> those that make most sense for the hardware.

I still don't like this. There are going to be tons of
cases where the single queue device is some hw raid setup
or similar, where performance is going to be much worse with
BFQ than it is with mq-deadline, for instance. That's just
one case.

This kind of policy does not belong in the kernel, at least
not in the current form. If we had some sort of "enable best
options for a desktop" then it could fall under that umbrella.

-- 
Jens Axboe
