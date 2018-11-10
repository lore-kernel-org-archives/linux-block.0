Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1541811569.10602.9.camel@acm.org>
Subject: Re: [PATCH 6/7] scsi: return blk_status_t from device handler
 ->prep_fn
From: Bart Van Assche <bvanassche@acm.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Date: Fri, 09 Nov 2018 16:59:29 -0800
In-Reply-To: <20181109134241.29346-7-hch@lst.de>
References: <20181109134241.29346-1-hch@lst.de>
	 <20181109134241.29346-7-hch@lst.de>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-11-09 at 14:42 +-0100, Christoph Hellwig wrote:
+AD4 Remove the last use of the old BLKPREP+AF8AKg values, which get converted
+AD4 to BLK+AF8-STS+AF8AKg later anyway.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
