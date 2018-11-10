Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1541810816.10602.3.camel@acm.org>
Subject: Re: [PATCH 1/7] ide: cleanup ->prep_rq calling convention
From: Bart Van Assche <bvanassche@acm.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Date: Fri, 09 Nov 2018 16:46:56 -0800
In-Reply-To: <20181109134241.29346-2-hch@lst.de>
References: <20181109134241.29346-1-hch@lst.de>
	 <20181109134241.29346-2-hch@lst.de>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-11-09 at 14:42 +-0100, Christoph Hellwig wrote:
+AD4 The return value is just used as a binary yes/no decicsion, so switch
+AD4 it to a bool instead of the old BLKPREP+AF8AKg values returned as an int.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
