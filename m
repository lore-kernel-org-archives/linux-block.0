Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <6545b733-e28d-6a57-ae5b-293c1938b7c2@intel.com>
References: <20171110100143.12256-1-linus.walleij@linaro.org>
 <CAPDyKFpaeRpqea6dy+3nxEtYwBTLUTYoRsYrRHrvfmNX_afxwg@mail.gmail.com>
 <CACRpkdZ-_1vFLLUcRTXWPYdDomP8Pen9wBwEMUGgr2cd_y3eBQ@mail.gmail.com> <6545b733-e28d-6a57-ae5b-293c1938b7c2@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Nov 2017 14:13:37 +0100
Message-ID: <CACRpkdY=C5F5t+pCtetpHwtmU-qHKMtuvKw4zowyOT=1aYJSmQ@mail.gmail.com>
Subject: Re: [PATCH 00/12 v5] Multiqueue for MMC/SD
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Nov 15, 2017 at 2:50 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 14/11/17 23:17, Linus Walleij wrote:
>> We have the following risk factors:
>>
>> - Observed performance degradation of 1% (on x86 SDHI I guess)
>> - The kernel crashes if SD card is removed (both patch sets)
>
> I haven't been able to reproduce that.  Do you have more information?

I saw it in an earlier version of the patch set, but it might be due to
some confusion on my side.

I will try to get this series going and stress it a bit and see what happens.

Yours,
Linus Walleij
