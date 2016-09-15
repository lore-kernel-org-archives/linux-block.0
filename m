Return-Path: <hare@suse.de>
Subject: Re: [PATCH v2 1/6] blk-mq: introduce blk_mq_delay_kick_requeue_list()
To: Mike Snitzer <snitzer@redhat.com>, axboe@kernel.dk, dm-devel@redhat.com
References: <1473870576-54331-1-git-send-email-snitzer@redhat.com>
 <1473870576-54331-2-git-send-email-snitzer@redhat.com>
Cc: linux-block@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b7ad8b7d-08d4-70df-0295-384a5d5ff7c7@suse.de>
Date: Thu, 15 Sep 2016 08:10:42 +0200
MIME-Version: 1.0
In-Reply-To: <1473870576-54331-2-git-send-email-snitzer@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 09/14/2016 06:29 PM, Mike Snitzer wrote:
> blk_mq_delay_kick_requeue_list() provides the ability to kick the
> q->requeue_list after a specified time.  To do this the request_queue's
> 'requeue_work' member was changed to a delayed_work.
> 
> blk_mq_delay_kick_requeue_list() allows DM to defer processing requeued
> requests while it doesn't make sense to immediately requeue them
> (e.g. when all paths in a DM multipath have failed).
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  block/blk-mq.c         | 15 +++++++++++----
>  include/linux/blk-mq.h |  1 +
>  include/linux/blkdev.h |  2 +-
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
