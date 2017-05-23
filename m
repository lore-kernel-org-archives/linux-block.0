Return-Path: <hch@lst.de>
Date: Tue, 23 May 2017 11:52:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>
Subject: Re: [PATCH 5/6] mmc: debugfs: Move card status retrieveal into the
	block layer
Message-ID: <20170523095222.GA25307@lst.de>
References: <20170519133732.27470-1-linus.walleij@linaro.org> <20170519133732.27470-6-linus.walleij@linaro.org> <CAPDyKFqzjv-C1SWh9_QD+LsHCMeg=R8nSeNgBsbPJ725PSMmDg@mail.gmail.com> <CACRpkdb9yRHiaK7qWarPFdLe3ODeQG9Hh8hG7uB6cb=9svkcWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkdb9yRHiaK7qWarPFdLe3ODeQG9Hh8hG7uB6cb=9svkcWg@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 23, 2017 at 11:49:48AM +0200, Linus Walleij wrote:
> In that case CONFIG_MMC_BLOCK contains 'm' instead of 'y'
> which confusingly does not evaluate to true in the preprocessor
> (it assumes it is a misspelled 'n' I guess).
> 
> And then the autobuilders wreak havoc.
> 
> And that is why the IS_ENABLED() defines exist in the first
> place IIUC.
> 
> I'm all for making CONFIG_MMC_BLOCK into a bool... but
> don't know how people (Intel laptops) feel about that extra
> code in their kernel at all times.

All the time?  At least only if any mmc/sd host driver is loaded,
right?  I don't think those additional 20k fatten the cow
(as we say in German).
