Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55756 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751881AbdEXFzF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2017 01:55:05 -0400
Subject: Re: [PATCH 08/31] sd, sr: Convert two assignments into warning
 statements
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20170524003420.5381-1-bart.vanassche@sandisk.com>
 <20170524003420.5381-9-bart.vanassche@sandisk.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <9a183fb3-4829-9041-3721-382bfd0a2372@suse.de>
Date: Wed, 24 May 2017 07:55:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170524003420.5381-9-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/24/2017 02:33 AM, Bart Van Assche wrote:
> Before scsi_prep_fn() calls the ULP .init_command() callback
> function it stores the SCSI command pointer in request.special.
> This means that the SCpnt = rq->special assignments in the sd
> and sr drivers assign a pointer to itself. Hence convert these
> two assignment statements into warning statements.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/scsi/sd.c | 2 +-
>  drivers/scsi/sr.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
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
