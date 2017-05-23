Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <cc8694f6-4955-51d3-6342-107cfbb50ed2@cavium.com>
References: <20170510082418.10513-1-linus.walleij@linaro.org>
 <CGME20170510082450epcas1p148987e484907660670e2f875530c31c8@epcas1p1.samsung.com>
 <20170510082418.10513-2-linus.walleij@linaro.org> <3202707.f2tzK1cxd8@amdc3058>
 <CACRpkdZp3JtnNrxsvtNT7hDB1w5KJomngs-=J8PG5fbDF=e+0w@mail.gmail.com> <cc8694f6-4955-51d3-6342-107cfbb50ed2@cavium.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 May 2017 11:05:02 +0200
Message-ID: <CACRpkdYV2KfyRL6eweie3Yb-Em7L9X6Y3k=SOqO107oUX9MNbw@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: core: Remove CONFIG_MMC_BLOCK_BOUNCE option.
To: "Steven J. Hill" <Steven.Hill@cavium.com>, Pierre Ossman <pierre@ossman.eu>,
	Vinod Koul <vinod.koul@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Paolo Valente <paolo.valente@linaro.org>, Daniel Mack <daniel@zonque.org>,
	Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, May 19, 2017 at 9:30 AM, Steven J. Hill <Steven.Hill@cavium.com> wrote:

> Remove MMC bounce buffer config option and associated code. This
> is proposed in addition to Linus' changes to remove the config
> option. I have tested this on our Octeon hardware platforms.
>
> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>

This would have to be rebased as Ulf merged my patch making this
a per-host runtime config option. (The Kconfig is gone for example.)

Bounce buffers were added by Pierre Ossman for kernel 2.6.23 in
commit 98ccf14909ba02a41c5925b0b2c92aeeef23d3b9
"mmc: bounce requests for simple hosts"

Quote:

    Some hosts cannot do scatter/gather in hardware. Since not doing sg
    is such a big performance hit, we (optionally) bounce the requests
    to a simple linear buffer that we hand over to the driver.

    Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

So this runs the risk on reducing performance on simple MMC/SD
controllers. Notice: simple, not old.

We need to know if people are deploying simple controllers still
and if this is something that really affects their performance.

That said: this was put in place because the kernel was sending
SG lists that the host DMA could not manage.

Nowadays we have two mechanisms:

- DMA engine and DMA-API that help out in managing bounce
  buffers when used. This means this only is useful for hardware
  that does autonomous DMA, without any separate DMA engine.

- CMA that can actually allocate a big chunk of memory: I think
  this original code is restricted to a 64KB segment because
  kmalloc() will only guarantee contigous physical memory up to
  64-128KiB or so. Now we could actually allocate a big badass
  CMA buffer if that improves the performance, and that would be
  a per-host setting.

It would be good to hear from people seeing benefits from bounce
buffers about this. What hardware is there that acually sees a
significant improvement with bounce buffers?

Pierre, what host were you developing this for? Maybe I can try
to get the same and test it.

Yours,
Linus Walleij
