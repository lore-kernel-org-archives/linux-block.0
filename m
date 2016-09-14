Return-Path: <hare@suse.de>
Subject: Re: [PATCH 3/3] dm mpath: delay the requeue of blk-mq requests while
 all paths down
To: Mike Snitzer <snitzer@redhat.com>, axboe@kernel.dk, dm-devel@redhat.com
References: <1473782495-44128-1-git-send-email-snitzer@redhat.com>
 <1473782495-44128-4-git-send-email-snitzer@redhat.com>
Cc: linux-block@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a20ea38d-4dce-3302-3e9a-bc46e250f556@suse.de>
Date: Wed, 14 Sep 2016 08:25:51 +0200
MIME-Version: 1.0
In-Reply-To: <1473782495-44128-4-git-send-email-snitzer@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 09/13/2016 06:01 PM, Mike Snitzer wrote:
> Return DM_MAPIO_DELAY_REQUEUE from .clone_and_map_rq.  Also, return
> false from .busy, if all paths are down, so that blk-mq requests get
> mapped via .clone_and_map_rq -- which results in DM_MAPIO_DELAY_REQUEUE
> being returned to dm-rq.
> 
> This change allows for a noticeable reduction in cpu utilization
> (reduced kworker load) while all paths are down, e.g.:
> 
> system CPU idleness (as measured by fio's --idle-prof=system):
> before: system: 87.53%
> after:  system: 97.07%
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  drivers/md/dm-mpath.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
