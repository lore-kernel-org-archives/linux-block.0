Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55499 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751881AbdEXFyJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2017 01:54:09 -0400
Subject: Re: [PATCH 07/31] scsi: Use blk_mq_rq_to_pdu() to convert a request
 to a SCSI command pointer
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20170524003420.5381-1-bart.vanassche@sandisk.com>
 <20170524003420.5381-8-bart.vanassche@sandisk.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <21bf2eef-48b4-7f49-cf63-bf8db44caf0e@suse.de>
Date: Wed, 24 May 2017 07:54:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170524003420.5381-8-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/24/2017 02:33 AM, Bart Van Assche wrote:
> Since commit e9c787e65c0c ("scsi: allocate scsi_cmnd structures as
> part of struct request") struct request and struct scsi_cmnd are
> adjacent. This means that there is now an alternative to reading
> req->special to convert a pointer to a prepared request into a
> SCSI command pointer, namely by using blk_mq_rq_to_pdu(). Make
> this change where appropriate. Although this patch does not
> change any functionality, it slightly improves performance and
> slightly improves readability.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/scsi/scsi_error.c |  2 +-
>  drivers/scsi/scsi_lib.c   | 18 +++++++++---------
>  include/scsi/scsi_tcq.h   |  2 +-
>  3 files changed, 11 insertions(+), 11 deletions(-)
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
