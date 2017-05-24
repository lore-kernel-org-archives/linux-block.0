Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59743 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933607AbdEXGJn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2017 02:09:43 -0400
Subject: Re: [PATCH 22/31] scsi: Inline scsi_init_command()
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
References: <20170524003420.5381-1-bart.vanassche@sandisk.com>
 <20170524003420.5381-23-bart.vanassche@sandisk.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <30ccab85-adae-ae2a-52d6-dd16003f320e@suse.de>
Date: Wed, 24 May 2017 08:09:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170524003420.5381-23-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/24/2017 02:34 AM, Bart Van Assche wrote:
> The two drivers that use the per-device command list, namely aacraid
> and dpt_i2o, expect that that list contains only SCSI commands and
> no task management functions. Hence only call scsi_add_cmd_to_list()
> from the block layer prep callback functions and not from
> scsi_ioctl_reset().
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/scsi/scsi_error.c |  1 -
>  drivers/scsi/scsi_lib.c   | 10 ++--------
>  drivers/scsi/scsi_priv.h  |  1 -
>  3 files changed, 2 insertions(+), 10 deletions(-)
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
