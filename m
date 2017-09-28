Return-Path: <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, shawn.lin@rock-chips.com,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Paolo Valente <paolo.valente@linaro.org>,
 Avri Altman <Avri.Altman@sandisk.com>,
 Tomas Winkler <tomas.winkler@intel.com>
Subject: Re: [PATCH 1/2 v6] mmc: block: Convert RPMB to a character device
To: Linus Walleij <linus.walleij@linaro.org>
References: <20170920080201.32438-1-linus.walleij@linaro.org>
 <b4a75994-1556-56ac-499c-8527988ee70f@intel.com>
 <CACRpkdabXNgCz+mtOOAZR1OqbCT0VgpxKT=FPh_99DTnsnCcSQ@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <e18231a7-c50b-c3d9-ca5b-be26f6ac81fc@rock-chips.com>
Date: Thu, 28 Sep 2017 11:56:11 +0800
MIME-Version: 1.0
In-Reply-To: <CACRpkdabXNgCz+mtOOAZR1OqbCT0VgpxKT=FPh_99DTnsnCcSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 2017/9/28 3:45, Linus Walleij wrote:
> On Wed, Sep 27, 2017 at 1:35 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> BUG when removing, fixed by reverting this patch.
>>
>> [  346.548512] mmc1: card 0001 removed
>> [  346.552782] BUG: unable to handle kernel NULL pointer dereference at 0000000000000070
> 
> How did you achieve this? I need to reproduce it.
> 
> RPMB is only available on eMMC cards and I don't have a removable eMMC
> card since by definition they are soldered on.
> 
> Does it happen on an ordinary MMC card without RPMB?
> 
> I'm sorry if I'm ignorant of something very obvious here...
> 
> I will read the code and see if I'm missing something obvious.

Haven't closely look at this patch, but btw, don't you need
put_device(&rpmb->dev) for the error path of  mmc_blk_alloc_rpmb_part
and  also do that for mmc_blk_remove_rpmb_part?

And don't you need to check rpmb->md->usage when doing
mmc_blk_remove_rpmb_part ?

> 
> Yours,
> Linus Walleij
> 
> 
> 
