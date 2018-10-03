Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1538578732.205649.0.camel@acm.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Bart Van Assche <bvanassche@acm.org>
To: Christoph Hellwig <hch@infradead.org>, Damien Le Moal
	 <Damien.LeMoal@wdc.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Artem Bityutskiy
 <dedekind1@gmail.com>, Paolo Valente <paolo.valente@linaro.org>, Jens Axboe
 <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>, linux-mmc
 <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson
 <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, Adrian
 Hunter <adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>,
 "aherrmann@suse.com" <aherrmann@suse.com>, "mgorman@suse.com"
 <mgorman@suse.com>, Chunyan Zhang <zhang.chunyan@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bfq-iosched@googlegroups.com" <bfq-iosched@googlegroups.com>,
 "oleksandr@natalenko.name" <oleksandr@natalenko.name>, Mark Brown
 <broonie@kernel.org>
Date: Wed, 03 Oct 2018 07:58:52 -0700
In-Reply-To: <20181003125146.GA9313@infradead.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
	 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
	 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
	 <1538550325.14984.108.camel@gmail.com>
	 <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
	 <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
	 <20181003125146.GA9313@infradead.org>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-10-03 at 05:51 -0700, Christoph Hellwig wrote:
+AD4 On Wed, Oct 03, 2018 at 07:42:15AM +-0000, Damien Le Moal wrote:
+AD4 +AD4 Of note also is that host-managed like sequential zone devices are also likely
+AD4 +AD4 to show up soon with the work being done in the NVMe standard on the new +ACI-Zoned
+AD4 +AD4 namespace+ACI feature proposal. These devices will also require a scheduler like
+AD4 +AD4 mq-deadline guaranteeing per-zone in-order delivery of sequential write
+AD4 +AD4 requests. Looking only at the number of queues of the device is not enough to
+AD4 +AD4 choose the best (most reasonnable/appropriate) scheduler.
+AD4 
+AD4 We actually have a plan to avoid the need for a non-reordering scheduler
+AD4 there (including a Linux prototype for it).  Lets see if it survives the
+AD4 committee.

Has the work with the T10 committee to standardize the SCSI equivalent of anonymous
writes already started?

Thanks,

Bart.
