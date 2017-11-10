Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20171110100143.12256-1-linus.walleij@linaro.org>
References: <20171110100143.12256-1-linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 10 Nov 2017 14:39:09 +0100
Message-ID: <CACRpkdb72u4Pso9YwCpsWey4pLazKbLmL6z5RxhswMf0zbAnsw@mail.gmail.com>
Subject: Re: [PATCH 00/12 v5] Multiqueue for MMC/SD
To: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>, Adrian Hunter <adrian.hunter@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Nov 10, 2017 at 11:01 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> Removing a card during I/O does not work well however :/
> So I guess I would need to work on that if this series should
> continue. (Hopefully unlikely.)

I tested a bit more and it turns out this doesn't work on any of
the MQ patch sets.

Which matches Christoph's statement that this is not really
working. I haven't really analyzed why though, I can see that
the kernel crashes firmly into a brick wall, but on mainline
it does not.

I think it's just something we have to smoke out in the next
release cycle as we switch to MQ.

Yours,
Linus Walleij
