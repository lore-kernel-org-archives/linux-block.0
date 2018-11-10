Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1541811175.10602.6.camel@acm.org>
Subject: Re: [PATCH 4/7] scsi: clean up error handling in scsi_init_io
From: Bart Van Assche <bvanassche@acm.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Date: Fri, 09 Nov 2018 16:52:55 -0800
In-Reply-To: <20181109134241.29346-5-hch@lst.de>
References: <20181109134241.29346-1-hch@lst.de>
	 <20181109134241.29346-5-hch@lst.de>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-11-09 at 14:42 +-0100, Christoph Hellwig wrote:
+AD4 There is no need to call scsi+AF8-mq+AF8-free+AF8-sgtables until we have actually
+AD4 allocated sgtables.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
