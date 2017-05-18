Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <3202707.f2tzK1cxd8@amdc3058>
References: <20170510082418.10513-1-linus.walleij@linaro.org>
 <CGME20170510082450epcas1p148987e484907660670e2f875530c31c8@epcas1p1.samsung.com>
 <20170510082418.10513-2-linus.walleij@linaro.org> <3202707.f2tzK1cxd8@amdc3058>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 18 May 2017 09:48:02 +0200
Message-ID: <CACRpkdZp3JtnNrxsvtNT7hDB1w5KJomngs-=J8PG5fbDF=e+0w@mail.gmail.com>
Subject: Re: [PATCH 1/5] mmc: core: Delete bounce buffer Kconfig option
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Paolo Valente <paolo.valente@linaro.org>, Daniel Mack <daniel@zonque.org>,
	Marc Zyngier <marc.zyngier@arm.com>, "Steven J. Hill" <Steven.Hill@cavium.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, May 15, 2017 at 4:04 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:

> [ I added Daniel, Marc & Steven to cc: ]

>> The option CONFIG_MMC_BLOCK_BOUNCE is default y so the
>> majority of platforms in the kernel already have it on, and
>> it then gets turned off at runtime since most of these have
>> a host->max_segs > 1. The few exceptions that have
>> host->max_segs == 1 and still turn off the bounce buffering
>> are those that disable it in their defconfig.
>>
>> Those are the following:
>>
>> arch/arm/configs/colibri_pxa300_defconfig
>> arch/arm/configs/zeus_defconfig
>> - Uses MMC_PXA, drivers/mmc/host/pxamci.c
>> - Sets host->max_segs = NR_SG, which is 1
>> - This needs its bounce buffer deactivated so we set
>>   host->disable_bounce to true in the host driver
>
> [...]
>
>> arch/mips/configs/cavium_octeon_defconfig
>> - Uses MMC_CAVIUM_OCTEON, drivers/mmc/host/cavium.c
>> - Sets host->max_segs to 16 or 1
>> - Setting host->disable_bounce to be sure for the 1 case
>
> From looking at the code it seems that bounce buffering should
> be always beneficial to MMC performance when host->max_segs == 1.
>
> It would be useful to know why these specific defconfigs
> disable bounce buffering (to save memory?). Maybe the defaults
> should be changed nowadays?

I agree. But I can't test on pxamci and cavium so I would
appreciate if the driver maintainers try to remove the
flag (MMC_CAP_NO_BOUNCE_BUFF in the v2 patch set)
and see what happens.

I would be happy to cut this special flag altogether, but I am
also afraid of screwing up some config :/

Yours,
Linus Walleij
