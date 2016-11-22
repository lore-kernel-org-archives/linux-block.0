Return-Path: <hch@lst.de>
Date: Tue, 22 Nov 2016 08:32:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/1] block_dev: Fixed direct I/O bio sector calculation
Message-ID: <20161122073215.GA12332@lst.de>
References: <1479796729-25517-1-git-send-email-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479796729-25517-1-git-send-email-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 22, 2016 at 03:38:49PM +0900, Damien Le Moal wrote:
> A direct I/O alignment must be always checked against the device blocks size,
> but the I/O offset (bio->bi_iter.bi_sector must always use 512B sector unit, and
> not the actual logical block size.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Ooops, yeah..

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
