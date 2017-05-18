Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <34FA1610-93EF-441A-B8B9-F1DD6B706398@sandisk.com>
References: <CACRpkdbZrkAqEdP1-QqDww0ZuFcY47Jgj9dPqkG_whrx7pwC-w@mail.gmail.com>
 <CAK8P3a1CGtj5VSVoMM34VWn781WpS8ZcHpq6n0UfNOWWYEq=QQ@mail.gmail.com>
 <CAPDyKFqiyEcScuWLVXE9kAa2yQyJCZfbXyAdAQOb081nLjyvvw@mail.gmail.com>
 <CAK8P3a1yJJ33R9EPPcErLUO2enFGrSJzWmVRwHdHP+3_2iP7ow@mail.gmail.com>
 <CACRpkdYsWnXLZEpZr74pLB8zjTV4Q=sdAfX+sz0n_E46SaJa9Q@mail.gmail.com>
 <BY2PR0401MB0901B37DB60608662AE5C631E5050@BY2PR0401MB0901.namprd04.prod.outlook.com>
 <CACRpkdbstMEC-_JcEfEm1debQRPeYBDmTPm0L_jGFnrgRZg1Zw@mail.gmail.com>
 <BY2PR0401MB0901B0167734FEFB7F1E5DF6E5040@BY2PR0401MB0901.namprd04.prod.outlook.com>
 <34FA1610-93EF-441A-B8B9-F1DD6B706398@sandisk.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 18 May 2017 11:36:34 +0200
Message-ID: <CACRpkdaczsqeBE155iXmxqDj5K04mrEnysHeMuzJD8uC-_b3Sw@mail.gmail.com>
Subject: Re: Outstanding MQ questions from MMC
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Avri Altman <Avri.Altman@sandisk.com>, Arnd Bergmann <arnd@arndb.de>,
	"ulf. org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Adrian Hunter <adrian.hunter@intel.com>,
	Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 18, 2017 at 5:31 PM, Alex Lemberg <Alex.Lemberg@sandisk.com> wrote:

> There is an additional functionality, which is require the host lock
> to be held for several write commands - the FFU.
> In case of FFU, the FW can be download/write in several iterations
> of Write command (CMD25). This sequence should not be interrupted by regular
> Write requests.
> In current driver, both FFU and RPMB can be sent by using mmc_blk_ioctl_multi_cmd().

Both single and multi ioctl()s are funneled into the block layer
using the driver-specific request ops in the latest iteration of
my patch set.

It turns out this was a simpler change than I though.

If you check the patch set I realized that I also fixes a userspace
starvation issue when issueing ioctls() such as for RPMB
during heavy block I/O.

This usecase:

> dd if=/dev/mmcblk3 of=/dev/null bs=1M &
> mmc extcs read /dev/mmcblk3

This would previously hang until the dd command was complete before
issuing the ioctl() command, just waiting for the host lock.
I guess RPMB has the same problem...

It is now fixed.

If you can verify the v2 patch set (just posted) and provide Tested-by's
(or bug reports...) it's appreciated.

Yours,
Linus Walleij
