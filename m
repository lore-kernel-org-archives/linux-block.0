Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <2360959.cyJgAELf50@wuerfel>
References: <1482242508-26131-1-git-send-email-linus.walleij@linaro.org>
 <20161228085503.GA340@lst.de> <CACRpkdb2zyjRz_zniT5nLxWCeLwagn1ZiTWwXc6bHW229NmfPQ@mail.gmail.com>
 <2360959.cyJgAELf50@wuerfel>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 3 Jan 2017 13:57:44 +0100
Message-ID: <CACRpkdatyPCfs3ymGwNyxZ4=Zcvb+n0fwiGXmnHx5o9cEGU7Jg@mail.gmail.com>
Subject: Re: [PATCH v2] RFD: switch MMC/SD to use blk-mq multiqueueing
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Ritesh Harjani <riteshh@codeaurora.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block@vger.kernel.org,
	Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>,
	Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 2, 2017 at 10:40 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> b) without MMC CMDQ support:
>   - report queue depth of '2'
>   - first request gets handled as above
>   - if one request is pending, prepare the second request and
>     add a pointer to the mmc host structure (not that different
>     from what we do today)
>   - when the host driver completes a request, have it immediately
>     issue the next one from the interrupt handler. In case we need
>     to sleep here, use a threaded IRQ, or a workqueue. This should
>     avoid the need for the NULL requests

This part we can do already today with the old block layer and I think
we (heh, I guess me) should do that as the first step.

After this migrating to blk-mq becomes much easier.

Yours,
Linus Walleij
