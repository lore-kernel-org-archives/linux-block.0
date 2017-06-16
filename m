Return-Path: <hch@lst.de>
Date: Fri, 16 Jun 2017 09:45:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 4/5] RFC: mmc: block: Convert RPMB to a character device
Message-ID: <20170616074543.GA9125@lst.de>
References: <20170615121259.8281-1-linus.walleij@linaro.org> <20170615121259.8281-5-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170615121259.8281-5-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 15, 2017 at 02:12:58PM +0200, Linus Walleij wrote:
> Currently the RPMB partition spawns a separate block device
> named /dev/mmcblkNrpmb for each device with an RPMB partition,
> including the creation of a block queue with its own kernel
> thread and all overhead associated with this. On the Ux500
> HREFv60 platform, for example, the two eMMCs means that two
> block queues with separate threads are created for no use
> whatsoever.

Yikes!  What an amazingly stupid design decision.

> This patch tries to amend the situation using the following
> strategy:
> 
> - Stop creating a block device for the RPMB partition/area
> 
> - Instead create a custom, dynamic character device with
>   the same name.
> 
> - Make this new character device support exactly the same
>   set of ioctl()s as the old block device.
> 
> - Wrap the requests back to the same ioctl() handlers, but
>   issue them on the block queue of the main partition/area,
>   i.e. /dev/mmcblkN

Is it really worth to add all this code to work around the issue?
We could still keep the block device around and stub out anything
not needed.

> Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I think some tag is missing before Tomas' name.
