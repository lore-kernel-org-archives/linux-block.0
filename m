Return-Path: <pierre@ossman.eu>
Subject: Re: [RFC PATCH] mmc: core: Remove CONFIG_MMC_BLOCK_BOUNCE option.
To: Linus Walleij <linus.walleij@linaro.org>,
 "Steven J. Hill" <Steven.Hill@cavium.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
 <adrian.hunter@intel.com>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Arnd Bergmann <arnd@arndb.de>, Paolo Valente <paolo.valente@linaro.org>,
 Daniel Mack <daniel@zonque.org>, Marc Zyngier <marc.zyngier@arm.com>
References: <20170510082418.10513-1-linus.walleij@linaro.org>
 <CGME20170510082450epcas1p148987e484907660670e2f875530c31c8@epcas1p1.samsung.com>
 <20170510082418.10513-2-linus.walleij@linaro.org>
 <3202707.f2tzK1cxd8@amdc3058>
 <CACRpkdZp3JtnNrxsvtNT7hDB1w5KJomngs-=J8PG5fbDF=e+0w@mail.gmail.com>
 <cc8694f6-4955-51d3-6342-107cfbb50ed2@cavium.com>
 <CACRpkdYV2KfyRL6eweie3Yb-Em7L9X6Y3k=SOqO107oUX9MNbw@mail.gmail.com>
From: Pierre Ossman <pierre@ossman.eu>
Message-ID: <e38eb2c8-db91-1a36-925d-aa88be56a40b@ossman.eu>
Date: Tue, 23 May 2017 20:24:41 +0200
MIME-Version: 1.0
In-Reply-To: <CACRpkdYV2KfyRL6eweie3Yb-Em7L9X6Y3k=SOqO107oUX9MNbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 23/05/17 11:05, Linus Walleij wrote:
> 
> Pierre, what host were you developing this for? Maybe I can try
> to get the same and test it.
> 

I think the work primarily was done with the Texas Instruments SDHCI 
host that HP used in their laptops. Ricoh controllers were also popular, 
but they had some proprietary mode that you had to get them out of.

If I recall correctly, all early SDHCI controllers needed this feature. 
I think scatter/gather was a later addition to the spec.

I take it updates to the SD specification hasn't fixed this performance 
issue?

Regards
-- 
Pierre Ossman
