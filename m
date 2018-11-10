Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1541811388.10602.7.camel@acm.org>
Subject: Re: [PATCH 5/7] scsi: return blk_status_t from scsi_init_io and
 ->init_command
From: Bart Van Assche <bvanassche@acm.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Date: Fri, 09 Nov 2018 16:56:28 -0800
In-Reply-To: <20181109134241.29346-6-hch@lst.de>
References: <20181109134241.29346-1-hch@lst.de>
	 <20181109134241.29346-6-hch@lst.de>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-11-09 at 14:42 +-0100, Christoph Hellwig wrote:
+AD4 Replace the old BLKRREP+AF8AKg values with the BLK+AF8-STS+AF8 ones that they are
+AD4 converted to later anyway.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
