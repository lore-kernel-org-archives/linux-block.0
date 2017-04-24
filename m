Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 24 Apr 2017 09:46:33 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v4 03/10] blk-mq-debugfs: Rename functions for
 registering and unregistering the mq directory
Message-ID: <20170424164633.GA28510@vader.DHCP.thefacebook.com>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
 <20170421234026.18970-4-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170421234026.18970-4-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 21, 2017 at 04:40:19PM -0700, Bart Van Assche wrote:
> Since the blk_mq_debugfs_*register_hctxs() functions register and
> unregister all attributes under the "mq" directory, rename these
> into blk_mq_debugfs_*register_mq().

Thanks!

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq-debugfs.c | 8 ++++----
>  block/blk-mq-sysfs.c   | 6 +++---
>  block/blk-mq.h         | 8 ++++----
>  3 files changed, 11 insertions(+), 11 deletions(-)
