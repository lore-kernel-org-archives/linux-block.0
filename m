Return-Path: <BATV+dc87fcab3479c3ad1e48+5519+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 3 Oct 2018 05:51:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Paolo Valente <paolo.valente@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	linux-mmc <linux-mmc@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Adrian Hunter <adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>,
	"aherrmann@suse.com" <aherrmann@suse.com>,
	"mgorman@suse.com" <mgorman@suse.com>,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bfq-iosched@googlegroups.com" <bfq-iosched@googlegroups.com>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
Message-ID: <20181003125146.GA9313@infradead.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538550325.14984.108.camel@gmail.com>
 <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
 <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 03, 2018 at 07:42:15AM +0000, Damien Le Moal wrote:
> Of note also is that host-managed like sequential zone devices are also likely
> to show up soon with the work being done in the NVMe standard on the new "Zoned
> namespace" feature proposal. These devices will also require a scheduler like
> mq-deadline guaranteeing per-zone in-order delivery of sequential write
> requests. Looking only at the number of queues of the device is not enough to
> choose the best (most reasonnable/appropriate) scheduler.

We actually have a plan to avoid the need for a non-reordering scheduler
there (including a Linux prototype for it).  Lets see if it survives the
committee.
