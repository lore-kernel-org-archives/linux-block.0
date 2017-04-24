Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 24 Apr 2017 09:58:31 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v4 01/10] blk-mq: Register <dev>/queue/mq after having
 registered <dev>/queue
Message-ID: <20170424165831.GE28510@vader.DHCP.thefacebook.com>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
 <20170421234026.18970-2-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170421234026.18970-2-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 21, 2017 at 04:40:17PM -0700, Bart Van Assche wrote:
> A later patch in this series will modify blk_mq_debugfs_register()
> such that it uses q->kobj.parent to determine the name of a
> request queue. Hence make sure that that pointer is initialized
> before blk_mq_debugfs_register() is called. To avoid lock inversion,
> protect sysfs / debugfs registration with the queue sysfs_lock
> instead of the global mutex all_q_mutex.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq-sysfs.c | 35 ++++++++++++++++++++++++++++-------
>  block/blk-mq.h       |  1 +
>  block/blk-sysfs.c    |  6 +++---
>  3 files changed, 32 insertions(+), 10 deletions(-)
