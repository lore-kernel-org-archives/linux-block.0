Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1538683746.230807.9.camel@acm.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Bart Van Assche <bvanassche@acm.org>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
 Linus Walleij <linus.walleij@linaro.org>, linux-block
 <linux-block@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
 linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Ulf Hansson
 <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, Artem
 Bityutskiy <dedekind1@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Jan Kara <jack@suse.cz>, Andreas Herrmann <aherrmann@suse.com>, Mel Gorman
 <mgorman@suse.com>, Chunyan Zhang <zhang.chunyan@linaro.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Date: Thu, 04 Oct 2018 13:09:06 -0700
In-Reply-To: <20181004202553.71c2599c@alans-desktop>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
	 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
	 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
	 <1538582091.205649.20.camel@acm.org>
	 <20181004202553.71c2599c@alans-desktop>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-10-04 at 20:25 +-0100, Alan Cox wrote:
+AD4 +AD4 I agree with Jens that it's best to leave it to the Linux distributors to
+AD4 +AD4 select a default I/O scheduler.
+AD4 
+AD4 That assumes such a thing exists. The kernel knows what devices it is
+AD4 dealing with. The kernel 'default' ought to be 'whatever is usually best
+AD4 for this device'. A distro cannot just pick a correct single default
+AD4 because NVME and USB sticks are both normal and rather different in needs.

Which I/O scheduler works best also depends which workload the user will run.
BFQ has significant advantages for interactive workloads like video replay
with concurrent background I/O but probably slows down kernel builds. That's
why I'm not sure whether the kernel should select the default I/O scheduler.

Bart.
