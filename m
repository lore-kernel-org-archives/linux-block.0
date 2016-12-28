Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20161228085503.GA340@lst.de>
References: <1482242508-26131-1-git-send-email-linus.walleij@linaro.org>
 <0fec238b-3c3c-6928-71ec-c3d4bcc6d267@codeaurora.org> <CACRpkdazLSk1i37ERs4YwuwXnmbmrnyAX1T5kRXjKcPSaAYd7Q@mail.gmail.com>
 <20161228085503.GA340@lst.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Dec 2016 00:59:51 +0100
Message-ID: <CACRpkdb2zyjRz_zniT5nLxWCeLwagn1ZiTWwXc6bHW229NmfPQ@mail.gmail.com>
Subject: Re: [PATCH v2] RFD: switch MMC/SD to use blk-mq multiqueueing
To: Christoph Hellwig <hch@lst.de>
Cc: Ritesh Harjani <riteshh@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Jens Axboe <axboe@kernel.dk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block@vger.kernel.org,
	Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, Dec 28, 2016 at 9:55 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Dec 27, 2016 at 01:21:28PM +0100, Linus Walleij wrote:

>> On the contrary we expect a performance regression as mq has no
>> scheduling. MQ is created for the usecase where you have multiple
>> hardware queues and they are so hungry for work that you have a problem
>> feeding them all. Needless to say, on eMMC/SD we don't have that problem
>> right now atleast.
>
> That's not entirely correct.  blk-mq is designed to replace the legacy
> request code eventually.  The focus is on not wasting CPU cycles, and
> to support multiple queues (but not require them).

OK! Performance is paramount, so this indeed confirms that we need
to re-engineer the MMC/SD stack to not rely on this kthread to "drive"
transactions, instead we need to complete them quickly from the driver
callbacks and let MQ drive.

A problem here is that issueing the requests are in blocking context
while completion is in IRQ context (for most drivers) so we need to
look into this.

>  Sequential workloads
> should always be as fast as the legacy path and use less CPU cycles,

That seems more or less confirmed by my dd-test in the commit
message. sys time is really small with the simple time+dd tests.

> for random workloads we might have to wait for I/O scheduler support,
> which is under way now:
>
>     http://git.kernel.dk/cgit/linux-block/log/?h=blk-mq-sched

Awesome.

> All that assumes a properly converted driver, which as seen by your
> experiments isn't easy for MMC as it's a very convoluted beast thanks
> the hardware interface which isn't up to the standards we expect from
> block storage protocols.

I think we can hash it out, we just need to rewrite the MMC/SD
core request handling a bit.

Yours,
Linus Walleij
