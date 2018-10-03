Return-Path: <dedekind1@gmail.com>
Message-ID: <1538550325.14984.108.camel@gmail.com>
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-block
 <linux-block@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
 linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Ulf Hansson
 <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, Adrian
 Hunter <adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>, Andreas Herrmann
 <aherrmann@suse.com>, Mel Gorman <mgorman@suse.com>, Chunyan Zhang
 <zhang.chunyan@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>, Oleksandr
 Natalenko <oleksandr@natalenko.name>,  Mark Brown <broonie@kernel.org>
Date: Wed, 03 Oct 2018 10:05:25 +0300
In-Reply-To: <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
	 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
	 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-10-03 at 08:29 +0200, Paolo Valente wrote:
> So, I do understand your need for conservativeness, but, after so much
> evidence on single-queue devices, and so many years! :), what's the
> point in keeping Linux worse for virtually everybody, by default?

Sounds like what we just need a mechanism for the device (ubi block in
this case) to select the I/O scheduler. I doubt enhancing the default
scheduler selection logic in 'elevator.c' is the right answer. Just
give the driver authority to override the defaults.
