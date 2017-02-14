Return-Path: <BATV+22b37a3386d2a29d172b+4923+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 14 Feb 2017 00:23:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shaun Tancheff <shaun@tancheff.com>
Subject: Re: [PATCH] sd: Check for unaligned partial completion
Message-ID: <20170214082314.GA31838@infradead.org>
References: <20170214081030.24558-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170214081030.24558-1-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

> +	unsigned int sector_sz = SCpnt->device->sector_size;

Can you spell out size?

> +	/*
> +	 * In case of bogus fw or device, we could end up having
> +	 * unaligned partial completion. Check this here.
> +	 */
> +	resid = scsi_get_resid(SCpnt);
> +	if (SCpnt->request->cmd_type == REQ_TYPE_FS &&
> +	    resid & (sector_sz - 1)) {

->done is only called for fs requests, so you can remove this check.
