Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <BY2PR0401MB09019584ED8645C66540EA5CE5E20@BY2PR0401MB0901.namprd04.prod.outlook.com>
References: <20170510082418.10513-1-linus.walleij@linaro.org>
 <20170510082418.10513-6-linus.walleij@linaro.org> <BY2PR0401MB09019584ED8645C66540EA5CE5E20@BY2PR0401MB0901.namprd04.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 18 May 2017 11:26:51 +0200
Message-ID: <CACRpkdYLD=8G9R9DveGHPa61WB-dnqKUi_gPQPn0YKTs5TRP1g@mail.gmail.com>
Subject: Re: [PATCH 5/5] mmc: block: move multi-ioctl() to use block layer
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, May 12, 2017 at 11:09 PM, Avri Altman <Avri.Altman@sandisk.com> wrote:

>> +     req = blk_get_request(mq->queue,
>> +             idata[0]->ic.write_flag ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
>> +             __GFP_RECLAIM);
>
> It is possible, e.g. as in RPMB access, that some commands are read and some are write.
> Not sure that it makes any difference, because once it get back to mmc_blk_ioctl_cmd_issue(),
> The correct mmc requests will be issued anyway?

The OP type (REQ_OP_DRV_OUT or REQ_OP_DRV_IN) has no semantic
effect in the MMC/SD stack, I just need to set it to something reasonable.
They will all be handled the same when issueing the request later.

The only semantic effect would be if the block layer prioritize these types
of requests differently compared to each other or to other requests, in
which case I think this rough guess is not a big issue.

Yours,
Linus Walleij
