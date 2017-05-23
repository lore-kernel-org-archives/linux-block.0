Return-Path: <Avri.Altman@sandisk.com>
From: Avri Altman <Avri.Altman@sandisk.com>
To: Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian
 Hunter <adrian.hunter@intel.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann
	<arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo
 Valente <paolo.valente@linaro.org>
Subject: RE: [PATCH 4/5] mmc: block: move single ioctl() commands to block
 requests
Date: Tue, 23 May 2017 08:14:25 +0000
Message-ID: <BY2PR0401MB090182E0D7E605B76139C0F3E5F90@BY2PR0401MB0901.namprd04.prod.outlook.com>
References: <20170510082418.10513-1-linus.walleij@linaro.org>
 <20170510082418.10513-5-linus.walleij@linaro.org>
In-Reply-To: <20170510082418.10513-5-linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Linus Walleij
> Sent: Wednesday, May 10, 2017 11:24 AM
> To: linux-mmc@vger.kernel.org; Ulf Hansson <ulf.hansson@linaro.org>;
> Adrian Hunter <adrian.hunter@intel.com>
> Cc: linux-block@vger.kernel.org; Jens Axboe <axboe@kernel.dk>; Christoph
> Hellwig <hch@lst.de>; Arnd Bergmann <arnd@arndb.de>; Bartlomiej
> Zolnierkiewicz <b.zolnierkie@samsung.com>; Paolo Valente
> <paolo.valente@linaro.org>; Linus Walleij <linus.walleij@linaro.org>
> Subject: [PATCH 4/5] mmc: block: move single ioctl() commands to block
> requests
>=20
> This wraps single ioctl() commands into block requests using the custom
> block layer request types REQ_OP_DRV_IN and REQ_OP_DRV_OUT.
>=20
> By doing this we are loosening the grip on the big host lock, since two c=
alls to
> mmc_get_card()/mmc_put_card() are removed.
>=20
> We are storing the ioctl() in/out argument as a pointer in the per-reques=
t
> struct mmc_blk_request container. Since we now let the block layer alloca=
te
> this data, blk_get_request() will allocate it for us and we can immediate=
ly
> dereference it and use it to pass the argument into the block layer.
>=20
> Tested on the ux500 with the userspace:
> mmc extcsd read /dev/mmcblk3
> resulting in a successful EXTCSD info dump back to the console.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
tested-by: Avri Altman <Avri.Altman@sandisk.com>
