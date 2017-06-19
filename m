Return-Path: <tomasw@gmail.com>
MIME-Version: 1.0
In-Reply-To: <BY2PR0401MB0901F4F7AF2A1137199E872BFCC10@BY2PR0401MB0901.namprd04.prod.outlook.com>
References: <20170615121259.8281-1-linus.walleij@linaro.org>
 <20170615121259.8281-5-linus.walleij@linaro.org> <BY2PR0401MB0901F4F7AF2A1137199E872BFCC10@BY2PR0401MB0901.namprd04.prod.outlook.com>
From: Tomas Winkler <tomasw@gmail.com>
Date: Tue, 20 Jun 2017 00:28:48 +0300
Message-ID: <CA+i0qc6fieNtNW2GD3=PokjyAHMo4GF5jo7ZXWWEe-NYSgtLLg@mail.gmail.com>
Subject: Re: [PATCH 4/5] RFC: mmc: block: Convert RPMB to a character device
To: Avri Altman <Avri.Altman@wdc.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Tomas Winkler <tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 16, 2017 at 10:22 AM, Avri Altman <Avri.Altman@wdc.com> wrote:
> Hi,
>
>> -----Original Message-----
>> From: Linus Walleij [mailto:linus.walleij@linaro.org]
>> Sent: Thursday, June 15, 2017 3:13 PM
>> To: linux-mmc@vger.kernel.org; Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: linux-block@vger.kernel.org; Jens Axboe <axboe@kernel.dk>; Christoph
>> Hellwig <hch@lst.de>; Arnd Bergmann <arnd@arndb.de>; Bartlomiej
>> Zolnierkiewicz <b.zolnierkie@samsung.com>; Paolo Valente
>> <paolo.valente@linaro.org>; Avri Altman <Avri.Altman@wdc.com>; Adrian
>> Hunter <adrian.hunter@intel.com>; Linus Walleij <linus.walleij@linaro.org>
>> Subject: [PATCH 4/5] RFC: mmc: block: Convert RPMB to a character device
>>
>> The RPMB partition on the eMMC devices is a special area used for storing
>> cryptographically safe information signed by a special secret key. To write
>> and read records from this special area, authentication is needed.
>>
>> The RPMB area is *only* and *exclusively* accessed using ioctl():s from
>> userspace. It is not really a block device, as blocks cannot be read or written
>> from the device, also the signed chunks that can be stored on the RPMB are
>> actually
>> 256 bytes, not 512 making a block device a real bad fit.
>>
>> Currently the RPMB partition spawns a separate block device named
>> /dev/mmcblkNrpmb for each device with an RPMB partition, including the
>> creation of a block queue with its own kernel thread and all overhead
>> associated with this. On the Ux500
>> HREFv60 platform, for example, the two eMMCs means that two block
>> queues with separate threads are created for no use whatsoever.
>>
>> I have concluded that this block device design for RPMB is actually pretty
>> wrong. The RPMB area should have been designed to be accessed from
>> /dev/mmcblkN directly, using ioctl()s on the main block device. It is however
>> way too late to change that, since userspace expects to open an RPMB
>> device in /dev/mmcblkNrpmb and we cannot break userspace.
>>
> Not sure how much you are bound by this.
> Previous attempts, adopting a pragmatic approach - just added another ioctl number, and used /dev/mmcblkN.
> Moreover, a designated ioctl allows to address more cleanly the rpmb-specific needs, that are somehow awkward using multi_cmd.
> Within the context of an RFC, would be interesting to know if someone even used  /dev/mmcblkNrpmb?

Good question, need to look for TrustyOS and OP-TEE.

>
>> Some discussion points:
>>
>> I am aware of Tomas Winklers attempts to make RPMB handling into its own
>> subsystem. I have no such ambitions whatsoever, I am only trying to sensibly
>> accomodate what we already have and handle our RPMB in a way that is not
>> littering the place with weirdo block devices.
>
> I think that the key benefit of Tomas's approach, is being so comprehensive.
> Thus enables pmb access of embedded block devices - mmc as well as other.

My approach came from actual use case, but we cannot probably break
already working software.

> Cheers,
> Avri
>
Thanks
Tomas
