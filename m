Return-Path: <hch@lst.de>
Date: Wed, 28 Dec 2016 09:55:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ritesh Harjani <riteshh@codeaurora.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	linux-block@vger.kernel.org,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	Baolin Wang <baolin.wang@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH v2] RFD: switch MMC/SD to use blk-mq multiqueueing
Message-ID: <20161228085503.GA340@lst.de>
References: <1482242508-26131-1-git-send-email-linus.walleij@linaro.org> <0fec238b-3c3c-6928-71ec-c3d4bcc6d267@codeaurora.org> <CACRpkdazLSk1i37ERs4YwuwXnmbmrnyAX1T5kRXjKcPSaAYd7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkdazLSk1i37ERs4YwuwXnmbmrnyAX1T5kRXjKcPSaAYd7Q@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Dec 27, 2016 at 01:21:28PM +0100, Linus Walleij wrote:
> > Could you please confirm on this- does even the HW/SW CMDQ in emmc would use
> > only 1 hardware queue with (say ~31) as queue depth, of that HW queue? Is
> > this understanding correct?
> 
> Yes as far as I can tell.
> 
> But you may have to tell me, because I'm not an expert in CMDQ.
> 
> Multiple queues are for when you can issue different request truly parallel
> without taking any previous and later request into account. CMDQ on
> MMC seems to require rollback etc if any of the issued requests after
> a certain request fail, and then it is essentially one queue, like a pipeline,
> and if one request fails all requests after that request needs to be backed
> out, correct?

I'm not an expert on the MMC CMDQ feature, but I know blk-mq pretty
well, so based on that and the decription of the series CMDQ finally
allows MMC to implement one single queue almost properly, but certainly
not multiple queues.

In block storage terms a queue is something where the OS can send
multiple commands to the device and let the device operate on them in
parallel (or at least pseudo-parallel).  Even with the MMC CMDQ feature
is seems after queueing up command the host still needs to control
execution ordering by talking to the hardware again for each command,
which isn't up to par with what other standards have been doing for the
last decades.  It's certainly not support for multiple queues, which
is defined as hardware features where the host allows multiple issuers
to use queue entirely independently of each other.

> Each queue must have its own error handling, and work isolated from
> the other queues to be considered a real hardware queue.

Note that error handling actually is one of the areas where queues
don't actually operate entirely independently once you escalate high
enough (device / controller reset).  For modern-ish protocols like
SCSI or NVMe the first level of error handling (abort) actually doesn't
involve the queue at all at the protocol, just the failed command.
But once that fails we quickly escalate to a reset, which involves
more than the queue.

> If the requests have dependencies, like referring each other, or
> as pointed out, needing to be cancelled if there is an error on a totally
> different request, it is just a deep pipeline, single hardware queue.

Strictly speaking it's not even a a real hardware queue in that case,
but with enough workarounds in the driver we can probably make it look
like a queue at least.  Certainly not multiple queues, though.

> On the contrary we expect a performance regression as mq has no
> scheduling. MQ is created for the usecase where you have multiple
> hardware queues and they are so hungry for work that you have a problem
> feeding them all. Needless to say, on eMMC/SD we don't have that problem
> right now atleast.

That's not entirely correct.  blk-mq is designed to replace the legacy
request code eventually.  The focus is on not wasting CPU cycles, and
to support multiple queues (but not require them).  Sequential workloads
should always be as fast as the legacy path and use less CPU cycles,
for random workloads we might have to wait for I/O scheduler support,
which is under way now:

    http://git.kernel.dk/cgit/linux-block/log/?h=blk-mq-sched

All that assumes a properly converted driver, which as seen by your 
experiments isn't easy for MMC as it's a very convoluted beast thanks
the hardware interface which isn't up to the standards we expect from
block storage protocols.
