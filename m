Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 20 Apr 2017 13:49:03 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v3 7/8] blk-mq: Add blk_mq_ops.show_rq()
Message-ID: <20170420204903.GA29391@vader.DHCP.thefacebook.com>
References: <20170418232949.5228-1-bart.vanassche@sandisk.com>
 <20170418232949.5228-8-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170418232949.5228-8-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 18, 2017 at 04:29:48PM -0700, Bart Van Assche wrote:
> This new callback function will be used in the next patch to show
> more information about SCSI requests.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
