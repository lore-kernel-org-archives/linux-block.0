Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CACRpkdYV2KfyRL6eweie3Yb-Em7L9X6Y3k=SOqO107oUX9MNbw@mail.gmail.com>
References: <20170510082418.10513-1-linus.walleij@linaro.org>
 <CGME20170510082450epcas1p148987e484907660670e2f875530c31c8@epcas1p1.samsung.com>
 <20170510082418.10513-2-linus.walleij@linaro.org> <3202707.f2tzK1cxd8@amdc3058>
 <CACRpkdZp3JtnNrxsvtNT7hDB1w5KJomngs-=J8PG5fbDF=e+0w@mail.gmail.com>
 <cc8694f6-4955-51d3-6342-107cfbb50ed2@cavium.com> <CACRpkdYV2KfyRL6eweie3Yb-Em7L9X6Y3k=SOqO107oUX9MNbw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 23 May 2017 12:08:36 +0200
Message-ID: <CAK8P3a3PQF53XQBPbLmHbHi-GL9u3sJiGHT+vU6ihkVJkXz50Q@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: core: Remove CONFIG_MMC_BLOCK_BOUNCE option.
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Steven J. Hill" <Steven.Hill@cavium.com>, Pierre Ossman <pierre@ossman.eu>,
	Vinod Koul <vinod.koul@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Paolo Valente <paolo.valente@linaro.org>,
	Daniel Mack <daniel@zonque.org>, Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, May 23, 2017 at 11:05 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Fri, May 19, 2017 at 9:30 AM, Steven J. Hill <Steven.Hill@cavium.com> wrote:
>
>> Remove MMC bounce buffer config option and associated code. This
>> is proposed in addition to Linus' changes to remove the config
>> option. I have tested this on our Octeon hardware platforms.
>>
>> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
>
> This would have to be rebased as Ulf merged my patch making this
> a per-host runtime config option. (The Kconfig is gone for example.)
>
> Bounce buffers were added by Pierre Ossman for kernel 2.6.23 in
> commit 98ccf14909ba02a41c5925b0b2c92aeeef23d3b9
> "mmc: bounce requests for simple hosts"
>
> Quote:
>
>     Some hosts cannot do scatter/gather in hardware. Since not doing sg
>     is such a big performance hit, we (optionally) bounce the requests
>     to a simple linear buffer that we hand over to the driver.
>
>     Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
>
> So this runs the risk on reducing performance on simple MMC/SD
> controllers. Notice: simple, not old.

Right, we definitely need to have something that allows us
to send larger commands to the device for scattered requests.

It wouldn't hurt to reconsider whether the current method is
the most efficient way of doing this, but that doesn't seem to
be a priority to me. If the MMC bounce buffers get in the way
of the blk-mq conversion, we could try to come up with a
different implementation as part of that conversion.

> We need to know if people are deploying simple controllers still
> and if this is something that really affects their performance.
>
> That said: this was put in place because the kernel was sending
> SG lists that the host DMA could not manage.
>
> Nowadays we have two mechanisms:
>
> - DMA engine and DMA-API that help out in managing bounce
>   buffers when used. This means this only is useful for hardware
>   that does autonomous DMA, without any separate DMA engine.

I think the bounce buffers in the DMA-API (swiotlb) should be
kept separate since it has a completely different purpose of
bouncing pages within the dma mask, rather than linearizing
a sglist.

If I read this right, we used to use blk-bounce for highmem
pages and mmc-bounce for lowmem until 2ff1fa679115 ("mmc_block:
bounce buffer highmem support") in 2008, now we don't
use blk-bounce at all if mmc-bounce is in use.

> - CMA that can actually allocate a big chunk of memory: I think
>   this original code is restricted to a 64KB segment because
>   kmalloc() will only guarantee contigous physical memory up to
>   64-128KiB or so. Now we could actually allocate a big badass
>   CMA buffer if that improves the performance, and that would be
>   a per-host setting.
>
> It would be good to hear from people seeing benefits from bounce
> buffers about this. What hardware is there that acually sees a
> significant improvement with bounce buffers?

The mmc-bounce code is active on hosts that have 'max_segs=1'
(the default unless they override it). These one set it to '1'
explicitly:

drivers/mmc/host/au1xmmc.c:     mmc->max_segs = AU1XMMC_DESCRIPTOR_COUNT;
drivers/mmc/host/bfin_sdh.c:    mmc->max_segs = 1; /* only BF51x */
drivers/mmc/host/sdhci.c:               mmc->max_segs = 1; /* with
SDHCI_USE_SDMA */
drivers/mmc/host/ushc.c:        mmc->max_segs      = 1;
drivers/mmc/host/via-sdmmc.c:   mmc->max_segs = 1;

These have max_segs=1 but ask for bounce buffers to be
disabled, which will severely limit their performance:

drivers/mmc/host/cavium.c:              mmc->max_segs = 1; /*
cavium,octeon-6130-mmc */
drivers/mmc/host/pxamci.c: mmc->max_segs = NR_SG;

These ones don't seem to set it at all, defaulting to '1':
drivers/mmc/host/cb710-mmc.c
drivers/mmc/host/moxart-mmc.c
drivers/mmc/host/sdricoh_cs.c
drivers/mmc/host/toshsd.c

       Arnd
