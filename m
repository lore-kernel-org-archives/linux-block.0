Return-Path: <hch@lst.de>
Date: Tue, 14 Mar 2017 15:43:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Paolo Valente <paolo.valente@linaro.org>,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	Baolin Wang <baolin.wang@linaro.org>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 06/16] mmc: core: replace waitqueue with worker
Message-ID: <20170314144357.GA31043@lst.de>
References: <20170209153403.9730-1-linus.walleij@linaro.org> <20170209153403.9730-7-linus.walleij@linaro.org> <00989e26-cdb9-48d7-2e46-ae6ef66e59a7@intel.com> <CACRpkdYOyEs8vxmPt1kGiKJrw8+16DyD8Nn=ke6mgxPaCQynCw@mail.gmail.com> <3fc89f9f-fbcf-113d-3644-b6c9dae003f0@intel.com> <8f1f3d4c-410c-2632-c776-4ced363bdb0d@kernel.dk> <e4b2c4bc-8627-2234-354d-c986f69b220f@intel.com> <97f2a4ea-0802-9f23-6ac7-b9d6c6afbfcc@kernel.dk> <a3571278-b30d-c3cb-bea6-d1776eb53025@intel.com> <a3216031-0801-45e2-320c-bfc88fa742b4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a3216031-0801-45e2-320c-bfc88fa742b4@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 14, 2017 at 08:36:26AM -0600, Jens Axboe wrote:
> There's one case that doesn't look like it was converted properly, but
> that's a mistake. The general insert-and-run cases run inline if we can,
> but the direct-issue needs a fixup, see below.

Note that blk_mq_try_issue_directly is only called for the multiple
hardware queue case, so MMC would not hit it.
