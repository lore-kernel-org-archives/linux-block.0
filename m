Return-Path: <BATV+dc87fcab3479c3ad1e48+5519+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 3 Oct 2018 08:01:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Linus Walleij <linus.walleij@linaro.org>,
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
Message-ID: <20181003150131.GA7306@infradead.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538550325.14984.108.camel@gmail.com>
 <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
 <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <20181003125146.GA9313@infradead.org>
 <1538578732.205649.0.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1538578732.205649.0.camel@acm.org>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 03, 2018 at 07:58:52AM -0700, Bart Van Assche wrote:
> Has the work with the T10 committee to standardize the SCSI equivalent of anonymous
> writes already started?

No, and I don't know of anyone who wants to do that in the short term.
