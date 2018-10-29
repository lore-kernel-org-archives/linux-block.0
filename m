Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1540834809.196084.65.camel@acm.org>
Subject: Re: [PATCH 06/14] blk-mq: add 'type' attribute to the sysfs hctx
 directory
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 29 Oct 2018 10:40:09 -0700
In-Reply-To: <20181029163738.10172-7-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
	 <20181029163738.10172-7-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
+AD4 It can be useful for a user to verify what type a given hardware
+AD4 queue is, expose this information in sysfs.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
