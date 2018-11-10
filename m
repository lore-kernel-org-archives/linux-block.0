Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1541810910.10602.5.camel@acm.org>
Subject: Re: [PATCH 3/7] scsi: push blk_status_t up into
 scsi_setup_{fs,scsi}_cmnd
From: Bart Van Assche <bvanassche@acm.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Date: Fri, 09 Nov 2018 16:48:30 -0800
In-Reply-To: <20181109134241.29346-4-hch@lst.de>
References: <20181109134241.29346-1-hch@lst.de>
	 <20181109134241.29346-4-hch@lst.de>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-11-09 at 14:42 +-0100, Christoph Hellwig wrote:
+AD4 This just moves the prep+AF8-to+AF8-mq calls up in preparation of further removal
+AD4 of BLKPREP+AF8AKg usage.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
