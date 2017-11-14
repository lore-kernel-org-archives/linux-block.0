Return-Path: <b.zolnierkie@samsung.com>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Paolo Valente
	<paolo.valente@linaro.org>, Avri Altman <Avri.Altman@sandisk.com>, Adrian
	Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 00/12 v5] Multiqueue for MMC/SD
Date: Tue, 14 Nov 2017 14:30:49 +0100
Message-id: <3035686.4xzDXYcRrr@amdc3058>
In-reply-to: <44451616.XazKDfAUO2@amdc3058>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
References: <CGME20171110104657epcas1p278e62237982d200175480c28080cb708@epcas1p2.samsung.com>
	<20171110100143.12256-1-linus.walleij@linaro.org>
	<44451616.XazKDfAUO2@amdc3058>
List-ID: <linux-block@vger.kernel.org>

On Tuesday, November 14, 2017 01:17:34 PM Bartlomiej Zolnierkiewicz wrote:

> This works much better than initial version and a simple dd read
> test shows more consistent results than with vanilla kernel.
> 
> However there are still some issues:
> 
> 1. 30 seconds delay on "Waiting for /dev to be fully populated..."
>    during boot
> 
> 2. reboot command no longer works (there is a livelock after
>    "The system is going down for reboot NOW!" message)
> 
> Full log (together with SysRq-l & SysRq-t outputs) attached.

BTW: these problems are not present in Adrian's V13 patchset
(with mmc-mq enabled by default).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
