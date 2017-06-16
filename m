Return-Path: <ulf.hansson@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170616074543.GA9125@lst.de>
References: <20170615121259.8281-1-linus.walleij@linaro.org>
 <20170615121259.8281-5-linus.walleij@linaro.org> <20170616074543.GA9125@lst.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 16 Jun 2017 11:47:23 +0200
Message-ID: <CAPDyKFoWHKNsAnqrnmS-_e6OeTAMx5nGxY5W8ittWGPjriANLg@mail.gmail.com>
Subject: Re: [PATCH 4/5] RFC: mmc: block: Convert RPMB to a character device
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On 16 June 2017 at 09:45, Christoph Hellwig <hch@lst.de> wrote:
> On Thu, Jun 15, 2017 at 02:12:58PM +0200, Linus Walleij wrote:
>> Currently the RPMB partition spawns a separate block device
>> named /dev/mmcblkNrpmb for each device with an RPMB partition,
>> including the creation of a block queue with its own kernel
>> thread and all overhead associated with this. On the Ux500
>> HREFv60 platform, for example, the two eMMCs means that two
>> block queues with separate threads are created for no use
>> whatsoever.
>
> Yikes!  What an amazingly stupid design decision.

Unfortunate, there is more. :-)

We are actually registering at least three more block devices per eMMC
card (two boot partitions, and one general purpose partition). Except
for the main partition of course.

The difference compared to rpmb from the above, is that those are
actually general read/write partitions.

So all these partitions are on the same eMMC card, but being I/O
scheduled separately because there are separate block devices. Yeah,
starvation, latency, etc - all bad things comes with it. :-)

My point is, this is only the first step in re-working and fixing this
- and we really appreciate your review!

[...]

Kind regards
Uffe
