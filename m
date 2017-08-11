Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CA+i0qc7wEM_8U11LO3TMDHf6s6CTTTkVyt31p2x8J3hNspR9EA@mail.gmail.com>
References: <20170615121259.8281-1-linus.walleij@linaro.org>
 <20170615121259.8281-5-linus.walleij@linaro.org> <CA+i0qc7wEM_8U11LO3TMDHf6s6CTTTkVyt31p2x8J3hNspR9EA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Aug 2017 11:31:49 +0200
Message-ID: <CACRpkdZXWw4TyKdQO_xG3S0-FZY9aMpH_zZRGg4m2T0newg9Lg@mail.gmail.com>
Subject: Re: [PATCH 4/5] RFC: mmc: block: Convert RPMB to a character device
To: Tomas Winkler <tomasw@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>, Adrian Hunter <adrian.hunter@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 19, 2017 at 11:18 PM, Tomas Winkler <tomasw@gmail.com> wrote:

> That's correct, I guess someone didn't read the spec till the end when
> adding rpmb block device.
> though also looks like that the software guys where drinking up in the
> bar while jdec committee has met.

:D

>> +/* Device type for RPMB character devices */
>> +static dev_t rpmb_devt;
>
> This is mmc_rpmb device not 'rpmb' as there are other storage devices
> that provide RPMB partition.

OK fixed it.

>> +
>> +/* Bus type for RPMB character devices */
>> +static struct bus_type rpmb_bus_type = {
>> +       .name = "rpmb",
>> +};
>
> Same here, mmc_rpmb_... , and other place bellow.

OK fixed it.

>> +struct mmc_rpmb_data {
(...)
> would keep also partition access bit needed for the partition switching.
(...)
>>  static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>> -                              struct mmc_blk_ioc_data *idata)
>> +                              struct mmc_blk_ioc_data *idata, bool rpmb_ioctl)
> Don't remember now if this is for eMMC but in future there might be
> more then one RPMB partition  on the device
> and boolean will not work here. rather use target_part, tho bits are
> exhausted there too.
(...)
>> -       bool is_rpmb = false;
>> +       unsigned int target_part;
> should come as a function input.
(...)
>> +                       ret = mmc_blk_alloc_rpmb_part(card, md,
>> +                               card->part[idx].size >> 9,
>> +                               card->part[idx].name);
> Extract partition access bits form    card->part[idx].part_cfg,

OK I am trying my best with this too...

Yours,
Linus Walleij
