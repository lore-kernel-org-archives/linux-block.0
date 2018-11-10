Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1541810828.10602.4.camel@acm.org>
Subject: Re: [PATCH 2/7] scsi: simplify scsi_prep_state_check
From: Bart Van Assche <bvanassche@acm.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Date: Fri, 09 Nov 2018 16:47:08 -0800
In-Reply-To: <20181109134241.29346-3-hch@lst.de>
References: <20181109134241.29346-1-hch@lst.de>
	 <20181109134241.29346-3-hch@lst.de>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-11-09 at 14:42 +-0100, Christoph Hellwig wrote:
+AD4 Return a blk+AF8-status+AF8-t directly, and make the code a little more compact
+AD4 by handling the fast path in the caller.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
