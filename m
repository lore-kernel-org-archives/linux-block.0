Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk> <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538550325.14984.108.camel@gmail.com>
In-Reply-To: <1538550325.14984.108.camel@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Oct 2018 09:18:37 +0200
Message-ID: <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
Subject: Re: [PATCH] block: BFQ default for single queue devices
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
	linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
	Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>,
	Adrian Hunter <adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>, aherrmann@suse.com,
	mgorman@suse.com, Chunyan Zhang <zhang.chunyan@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, bfq-iosched@googlegroups.com,
	oleksandr@natalenko.name, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 3, 2018 at 9:05 AM Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Wed, 2018-10-03 at 08:29 +0200, Paolo Valente wrote:
> > So, I do understand your need for conservativeness, but, after so much
> > evidence on single-queue devices, and so many years! :), what's the
> > point in keeping Linux worse for virtually everybody, by default?
>
> Sounds like what we just need a mechanism for the device (ubi block in
> this case) to select the I/O scheduler. I doubt enhancing the default
> scheduler selection logic in 'elevator.c' is the right answer. Just
> give the driver authority to override the defaults.

This might be true in the wider sense (like for what scheduler to
select for an NVME device with N channels) but $SUBJECT is just
trying to select BFQ (if available) for devices with one and only one
hardware queue.

That is AFAICT the only reasonable choice for anything with just
one hardware queue as things stand right now.

I have a slight reservation for the weird outliers like loopdev, which
has "one hardware queue" (.nr_hw_queues == 1) though this
makes no sense at all. So I would like to know what people think
about that. Maybe we should have .nr_queues and .nr_hw_queues
where the former is the number of logical queues and the latter
the actual number of hardware queues.

Yours,
Linus Walleij
