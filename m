Return-Path: <hch@lst.de>
Date: Mon, 22 May 2017 14:45:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH 0/6] More MMC block core refactorings
Message-ID: <20170522124533.GA11869@lst.de>
References: <20170519133732.27470-1-linus.walleij@linaro.org> <CAPDyKFrRXmxKZTngMYtWZCi3ZTuSgRFnnHnxQxB1aEzHdiyc+Q@mail.gmail.com> <BY2PR0401MB09012CAF1776FF4D3496558CE5F80@BY2PR0401MB0901.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BY2PR0401MB09012CAF1776FF4D3496558CE5F80@BY2PR0401MB0901.namprd04.prod.outlook.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 22, 2017 at 12:44:14PM +0000, Avri Altman wrote:
> Those debugfs entries are there for ages, and there are some user-space utilities,
>  e.g. for benchmarking etc. that count on it being there, 
>  as the key identification criteria if a mmc device is present.

debugfs is an optional feature not present on many systems, and
explicitly not considered a kernel ABI.
