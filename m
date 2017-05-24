Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60703 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934001AbdEXGNz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2017 02:13:55 -0400
Subject: Re: [PATCH 28/31] scsi_setup_fs_cmnd(): Call scsi_req_init() instead
 of open-coding it
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
References: <20170524003420.5381-1-bart.vanassche@sandisk.com>
 <20170524003420.5381-29-bart.vanassche@sandisk.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ab277c15-c26a-10cd-8a9a-eac905131453@suse.de>
Date: Wed, 24 May 2017 08:13:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170524003420.5381-29-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/24/2017 02:34 AM, Bart Van Assche wrote:
> The only functional change is that this patch causes scsi_setup_fs_cmnd()
> to clear scsi_request.sense_len.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/scsi/scsi_lib.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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
