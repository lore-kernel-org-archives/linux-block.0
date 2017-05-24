Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934001AbdEXGNf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2017 02:13:35 -0400
Subject: Re: [PATCH 27/31] scsi: Consolidate more initialization code
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
References: <20170524003420.5381-1-bart.vanassche@sandisk.com>
 <20170524003420.5381-28-bart.vanassche@sandisk.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <80b51a1a-6341-c777-e22f-a6e01e66dcd9@suse.de>
Date: Wed, 24 May 2017 08:13:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170524003420.5381-28-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/24/2017 02:34 AM, Bart Van Assche wrote:
> Initialize struct scsi_cmnd.request from inside scsi_initialize_rq()
> instead of every time a request is prepared. Note: moving the tag
> initialization into scsi_initialize_rq() is not possible because
> the single-queue block layer only assigns a tag to a request after
> a request has been started.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/scsi/scsi_error.c | 1 -
>  drivers/scsi/scsi_lib.c   | 4 +---
>  2 files changed, 1 insertion(+), 4 deletions(-)
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
