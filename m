Return-Path: <hare@suse.com>
Subject: Re: [PATCH v4 01/10] blk-mq: Register <dev>/queue/mq after having
 registered <dev>/queue
To: Bart Van Assche <bart.vanassche@sandisk.com>, Jens Axboe <axboe@kernel.dk>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
 <20170421234026.18970-2-bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
From: Hannes Reinecke <hare@suse.com>
Message-ID: <09faa222-da55-9389-cea4-fd6197174dba@suse.com>
Date: Mon, 24 Apr 2017 09:25:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170421234026.18970-2-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/22/2017 01:40 AM, Bart Van Assche wrote:
> A later patch in this series will modify blk_mq_debugfs_register()
> such that it uses q->kobj.parent to determine the name of a
> request queue. Hence make sure that that pointer is initialized
> before blk_mq_debugfs_register() is called. To avoid lock inversion,
> protect sysfs / debugfs registration with the queue sysfs_lock
> instead of the global mutex all_q_mutex.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq-sysfs.c | 35 ++++++++++++++++++++++++++++-------
>  block/blk-mq.h       |  1 +
>  block/blk-sysfs.c    |  6 +++---
>  3 files changed, 32 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
