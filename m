Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936309AbdEXGPB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2017 02:15:01 -0400
Subject: Re: [PATCH 31/31] xen/scsifront: Remove code that zeroes
 driver-private command data
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
References: <20170524003420.5381-1-bart.vanassche@sandisk.com>
 <20170524003420.5381-32-bart.vanassche@sandisk.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b1d02684-78c2-8a9a-ce0b-e95c50467268@suse.de>
Date: Wed, 24 May 2017 08:14:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170524003420.5381-32-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/24/2017 02:34 AM, Bart Van Assche wrote:
> Since the SCSI core zeroes driver-private command data, remove
> that code from the xen-scsifront driver.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: xen-devel@lists.xenproject.org
> ---
>  drivers/scsi/xen-scsifront.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
> index a6a8b60d4902..36f59a1be7e9 100644
> --- a/drivers/scsi/xen-scsifront.c
> +++ b/drivers/scsi/xen-scsifront.c
> @@ -534,7 +534,6 @@ static int scsifront_queuecommand(struct Scsi_Host *shost,
>  	int err;
>  
>  	sc->result = 0;
> -	memset(shadow, 0, sizeof(*shadow));
>  
>  	shadow->sc  = sc;
>  	shadow->act = VSCSIIF_ACT_SCSI_CDB;
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
