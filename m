Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 1 Nov 2018 14:59:57 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/16] blk-mq: add 'type' attribute to the sysfs hctx
 directory
Message-ID: <20181101215957.GH18005@vader>
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-7-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181030183252.17857-7-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 30, 2018 at 12:32:42PM -0600, Jens Axboe wrote:
> It can be useful for a user to verify what type a given hardware
> queue is, expose this information in sysfs.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq-sysfs.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Out of curiousity, why sysfs instead of debugfs?
