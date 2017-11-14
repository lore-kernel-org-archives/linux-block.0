Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <3035686.4xzDXYcRrr@amdc3058>
References: <CGME20171110104657epcas1p278e62237982d200175480c28080cb708@epcas1p2.samsung.com>
 <20171110100143.12256-1-linus.walleij@linaro.org> <44451616.XazKDfAUO2@amdc3058>
 <3035686.4xzDXYcRrr@amdc3058>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Nov 2017 22:19:05 +0100
Message-ID: <CACRpkdY3JGJtkN6z1cdn2jxfNbNwRyP+CryOv98mC99uTQNDcA@mail.gmail.com>
Subject: Re: [PATCH 00/12 v5] Multiqueue for MMC/SD
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 14, 2017 at 2:30 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On Tuesday, November 14, 2017 01:17:34 PM Bartlomiej Zolnierkiewicz wrote:
>
>> This works much better than initial version and a simple dd read
>> test shows more consistent results than with vanilla kernel.
>>
>> However there are still some issues:
>>
>> 1. 30 seconds delay on "Waiting for /dev to be fully populated..."
>>    during boot
>>
>> 2. reboot command no longer works (there is a livelock after
>>    "The system is going down for reboot NOW!" message)
>>
>> Full log (together with SysRq-l & SysRq-t outputs) attached.
>
> BTW: these problems are not present in Adrian's V13 patchset
> (with mmc-mq enabled by default).

Yes, as I even say in the cover letter I think his patches are
better so we should use those.

Bart can you provide a Tested-by for Adrian' patch set?

Yours,
Linus Walleij
