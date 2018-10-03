Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1538582446.205649.22.camel@acm.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Bart Van Assche <bvanassche@acm.org>
To: Paolo Valente <paolo.valente@linaro.org>, Oleksandr Natalenko
	 <oleksandr@natalenko.name>
Cc: Jens Axboe <axboe@kernel.dk>, Linus Walleij <linus.walleij@linaro.org>,
 linux-block <linux-block@vger.kernel.org>, linux-mmc
 <linux-mmc@vger.kernel.org>,  linux-mtd@lists.infradead.org, Pavel Machek
 <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger
 <richard@nod.at>, Artem Bityutskiy <dedekind1@gmail.com>, Adrian Hunter
 <adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>, Andreas Herrmann
 <aherrmann@suse.com>, Mel Gorman <mgorman@suse.com>, Chunyan Zhang
 <zhang.chunyan@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>, Mark Brown
 <broonie@kernel.org>
Date: Wed, 03 Oct 2018 09:00:46 -0700
In-Reply-To: <6AF8CEDE-2720-4206-900A-1A9B914A8FF0@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
	 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
	 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
	 <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
	 <6AF8CEDE-2720-4206-900A-1A9B914A8FF0@linaro.org>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-10-03 at 17:55 +-0200, Paolo Valente wrote:
+AD4 The problem, in particular, is that bfq is a complex beast, fighting
+AD4 against a jungle of I/O issues.  You have to be really into bfq, even
+AD4 to just know all of its features+ACE

This is a problem by itself. I don't know anyone who wants to have to deal
with I/O scheduler tunables.

Bart.
