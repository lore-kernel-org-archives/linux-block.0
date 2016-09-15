Return-Path: <hare@suse.de>
Subject: Re: [PATCH v2 4/6] dm rq: introduce dm_mq_kick_requeue_list()
To: Mike Snitzer <snitzer@redhat.com>, axboe@kernel.dk, dm-devel@redhat.com
References: <1473870576-54331-1-git-send-email-snitzer@redhat.com>
 <1473870576-54331-5-git-send-email-snitzer@redhat.com>
Cc: linux-block@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <891299a6-69d0-5436-ebb5-4808fcf32843@suse.de>
Date: Thu, 15 Sep 2016 08:16:02 +0200
MIME-Version: 1.0
In-Reply-To: <1473870576-54331-5-git-send-email-snitzer@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 09/14/2016 06:29 PM, Mike Snitzer wrote:
> Make it possible for a request-based target to kick the DM device's
> blk-mq request_queue's requeue_list.
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  drivers/md/dm-rq.c | 17 +++++++++++++----
>  drivers/md/dm-rq.h |  2 ++
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
