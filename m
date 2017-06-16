Return-Path: <Avri.Altman@wdc.com>
From: Avri Altman <Avri.Altman@wdc.com>
To: Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann
	<arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo
 Valente <paolo.valente@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Subject: RE: [PATCH 4/5] RFC: mmc: block: Convert RPMB to a character device
Date: Fri, 16 Jun 2017 07:22:34 +0000
Message-ID: <BY2PR0401MB0901F4F7AF2A1137199E872BFCC10@BY2PR0401MB0901.namprd04.prod.outlook.com>
References: <20170615121259.8281-1-linus.walleij@linaro.org>
 <20170615121259.8281-5-linus.walleij@linaro.org>
In-Reply-To: <20170615121259.8281-5-linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Hi,

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij@linaro.org]
> Sent: Thursday, June 15, 2017 3:13 PM
> To: linux-mmc@vger.kernel.org; Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-block@vger.kernel.org; Jens Axboe <axboe@kernel.dk>; Christoph
> Hellwig <hch@lst.de>; Arnd Bergmann <arnd@arndb.de>; Bartlomiej
> Zolnierkiewicz <b.zolnierkie@samsung.com>; Paolo Valente
> <paolo.valente@linaro.org>; Avri Altman <Avri.Altman@wdc.com>; Adrian
> Hunter <adrian.hunter@intel.com>; Linus Walleij <linus.walleij@linaro.org=
>
> Subject: [PATCH 4/5] RFC: mmc: block: Convert RPMB to a character device
>=20
> The RPMB partition on the eMMC devices is a special area used for storing
> cryptographically safe information signed by a special secret key. To wri=
te
> and read records from this special area, authentication is needed.
>=20
> The RPMB area is *only* and *exclusively* accessed using ioctl():s from
> userspace. It is not really a block device, as blocks cannot be read or w=
ritten
> from the device, also the signed chunks that can be stored on the RPMB ar=
e
> actually
> 256 bytes, not 512 making a block device a real bad fit.
>=20
> Currently the RPMB partition spawns a separate block device named
> /dev/mmcblkNrpmb for each device with an RPMB partition, including the
> creation of a block queue with its own kernel thread and all overhead
> associated with this. On the Ux500
> HREFv60 platform, for example, the two eMMCs means that two block
> queues with separate threads are created for no use whatsoever.
>=20
> I have concluded that this block device design for RPMB is actually prett=
y
> wrong. The RPMB area should have been designed to be accessed from
> /dev/mmcblkN directly, using ioctl()s on the main block device. It is how=
ever
> way too late to change that, since userspace expects to open an RPMB
> device in /dev/mmcblkNrpmb and we cannot break userspace.
>=20
Not sure how much you are bound by this.
Previous attempts, adopting a pragmatic approach - just added another ioctl=
 number, and used /dev/mmcblkN.
Moreover, a designated ioctl allows to address more cleanly the rpmb-specif=
ic needs, that are somehow awkward using multi_cmd.
Within the context of an RFC, would be interesting to know if someone even =
used  /dev/mmcblkNrpmb?

> Some discussion points:
>=20
> I am aware of Tomas Winklers attempts to make RPMB handling into its own
> subsystem. I have no such ambitions whatsoever, I am only trying to sensi=
bly
> accomodate what we already have and handle our RPMB in a way that is not
> littering the place with weirdo block devices.

I think that the key benefit of Tomas's approach, is being so comprehensive=
.
Thus enables pmb access of embedded block devices - mmc as well as other.

Cheers,
Avri
