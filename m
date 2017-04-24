Return-Path: <hare@suse.com>
Subject: Re: [PATCH v4 02/10] blk-mq: Let blk_mq_debugfs_register() look up
 the queue name
To: Bart Van Assche <bart.vanassche@sandisk.com>, Jens Axboe <axboe@kernel.dk>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
 <20170421234026.18970-3-bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
From: Hannes Reinecke <hare@suse.com>
Message-ID: <f849989a-9553-32a7-fdea-bb704bb9f39a@suse.com>
Date: Mon, 24 Apr 2017 09:25:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170421234026.18970-3-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/22/2017 01:40 AM, Bart Van Assche wrote:
> A later patch will move the call of blk_mq_debugfs_register() to
> a function to which the queue name is not passed as an argument.
> To avoid having to add a 'name' argument to multiple callers, let
> blk_mq_debugfs_register() look up the queue name.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq-debugfs.c | 5 +++--
>  block/blk-mq-sysfs.c   | 2 +-
>  block/blk-mq.h         | 5 ++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
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
