Return-Path: <hare@suse.de>
Subject: Re: [PATCH v2 3/6] dm rq: reduce arguments passed to map_request()
 and dm_requeue_original_request()
To: Mike Snitzer <snitzer@redhat.com>, axboe@kernel.dk, dm-devel@redhat.com
References: <1473870576-54331-1-git-send-email-snitzer@redhat.com>
 <1473870576-54331-4-git-send-email-snitzer@redhat.com>
Cc: linux-block@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0b647308-835f-252d-d0ec-b20ad0937542@suse.de>
Date: Thu, 15 Sep 2016 08:15:13 +0200
MIME-Version: 1.0
In-Reply-To: <1473870576-54331-4-git-send-email-snitzer@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 09/14/2016 06:29 PM, Mike Snitzer wrote:
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  drivers/md/dm-rq.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
