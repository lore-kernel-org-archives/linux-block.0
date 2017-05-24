Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58877 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933980AbdEXGGv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2017 02:06:51 -0400
Subject: Re: [PATCH 19/31] scsi: Change argument type of scsi_req_init()
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
References: <20170524003420.5381-1-bart.vanassche@sandisk.com>
 <20170524003420.5381-20-bart.vanassche@sandisk.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <29ec26ad-f57e-2b9b-e793-153fd419600c@suse.de>
Date: Wed, 24 May 2017 08:06:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170524003420.5381-20-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/24/2017 02:34 AM, Bart Van Assche wrote:
> Since scsi_req_init() works on a struct scsi_request, change the
> argument type into struct scsi_request *.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/scsi_ioctl.c                | 10 +++++++---
>  drivers/ide/ide-probe.c           |  2 +-
>  drivers/scsi/scsi_lib.c           |  4 +++-
>  drivers/scsi/scsi_transport_sas.c |  2 +-
>  include/scsi/scsi_request.h       |  2 +-
>  5 files changed, 13 insertions(+), 7 deletions(-)
> 
Ah, right. Now it's clear.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
