Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Fri, 21 Apr 2017 15:06:59 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v3 2/8] blk-mq: Let blk_mq_debugfs_register() look up the
 queue name
Message-ID: <20170421220659.GB17177@vader.DHCP.thefacebook.com>
References: <20170418232949.5228-1-bart.vanassche@sandisk.com>
 <20170418232949.5228-3-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170418232949.5228-3-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 18, 2017 at 04:29:43PM -0700, Bart Van Assche wrote:
> A later patch will move the call of blk_mq_debugfs_register() to
> a function to which the queue name is not passed as an argument.
> To avoid having to add a 'name' argument to multiple callers, let
> blk_mq_debugfs_register() look up the queue name.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq-debugfs.c | 5 +++--
>  block/blk-mq-sysfs.c   | 2 +-
>  block/blk-mq.h         | 5 ++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
