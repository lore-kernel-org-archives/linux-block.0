Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1539615735.129692.3.camel@acm.org>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
From: Bart Van Assche <bvanassche@acm.org>
To: Linus Walleij <linus.walleij@linaro.org>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, Pavel Machek
 <pavel@ucw.cz>, Paolo Valente <paolo.valente@linaro.org>, Ulf Hansson
 <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, Adrian
 Hunter <adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>, Artem Bityutskiy
 <dedekind1@gmail.com>, Christoph Hellwig <hch@infradead.org>, Alan Cox
 <gnomes@lxorguk.ukuu.org.uk>, Mark Brown <broonie@kernel.org>, Damien Le
 Moal <Damien.LeMoal@wdc.com>, Johannes Thumshirn <jthumshirn@suse.de>,
 Oleksandr Natalenko <oleksandr@natalenko.name>, Jonathan Corbet
 <corbet@lwn.net>
Date: Mon, 15 Oct 2018 08:02:15 -0700
In-Reply-To: <20181015141059.26579-1-linus.walleij@linaro.org>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-10-15 at 16:10 +-0200, Linus Walleij wrote:
+AD4 +- +ACo For blk-mq devices, we default to using:
+AD4 +- +ACo - +ACI-none+ACI for multiqueue devices (nr+AF8-hw+AF8-queues +ACEAPQ 1)
+AD4 +- +ACo - +ACI-bfq+ACI, if available, for single queue devices
+AD4 +- +ACo - +ACI-mq-deadline+ACI if +ACI-bfq+ACI is not available for single queue devices
+AD4 +- +ACo - +ACI-none+ACI for single queue devices as well as last resort

For SATA SSDs nr+AF8-hw+AF8-queues +AD0APQ 1 so this patch will also affect these SSDs.
Since this patch is an attempt to improve performance, I'd like to see
measurement data for one or more recent SATA SSDs before a decision is
taken about what to do with this patch. 

Thanks,

Bart.
