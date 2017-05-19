Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpOj5tWuuEnwo-sTcN0rBCmz5r2YfT2HMSnEfMPc=+iRQ@mail.gmail.com>
References: <20170518092936.9277-1-linus.walleij@linaro.org> <CAPDyKFpOj5tWuuEnwo-sTcN0rBCmz5r2YfT2HMSnEfMPc=+iRQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 19 May 2017 15:56:08 +0200
Message-ID: <CACRpkdaG__UbL6vH_=AgtO95oeA60iuTGquwD1ADmU9LtT245Q@mail.gmail.com>
Subject: Re: [PATCH 1/6 v2] mmc: core: Delete bounce buffer Kconfig option
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, May 19, 2017 at 10:30 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Thanks, the *series* applied for next! (Responding to patch1 as
> couldn't find the cover-letter for v2).

Awesome, and just to make sure you will not be bored in the weekend
I just sent a sequel series expanding the use of per-request datas
to move more host locking and congestion out of the way.

Yours,
Linus Walleij
