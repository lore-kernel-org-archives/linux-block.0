Return-Path: <hare@suse.de>
Subject: Re: [PATCH 2/3] dm rq: add DM_MAPIO_DELAY_REQUEUE to delay requeue of
 blk-mq requests
To: Mike Snitzer <snitzer@redhat.com>, axboe@kernel.dk, dm-devel@redhat.com
References: <1473782495-44128-1-git-send-email-snitzer@redhat.com>
 <1473782495-44128-3-git-send-email-snitzer@redhat.com>
Cc: linux-block@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1bffba61-1643-54ea-2e8d-a24326bd2381@suse.de>
Date: Wed, 14 Sep 2016 08:24:58 +0200
MIME-Version: 1.0
In-Reply-To: <1473782495-44128-3-git-send-email-snitzer@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 09/13/2016 06:01 PM, Mike Snitzer wrote:
> Otherwise blk-mq will immediately dispatch requests that are requeued
> via a BLK_MQ_RQ_QUEUE_BUSY return from blk_mq_ops .queue_rq.
> 
> Delayed requeue is implemented using blk_mq_delay_kick_requeue_list()
> with a delay of 5 secs.  In the context of DM multipath (all paths down)
> it doesn't make any sense to requeue more quickly.
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  drivers/md/dm-rq.c            | 35 ++++++++++++++++++++---------------
>  include/linux/device-mapper.h |  1 +
>  2 files changed, 21 insertions(+), 15 deletions(-)
> 
Hmm. Not sure if I agree with the reasoning for a 5 seconds delay; this
seems to be a rather broad estimate.
Won't it delay I/O resumption when we have intermittent path failure (eg
on iSCSI)?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
