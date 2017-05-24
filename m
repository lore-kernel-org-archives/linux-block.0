Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S938322AbdEXFvm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2017 01:51:42 -0400
Subject: Re: [PATCH 04/31] Introduce scsi_start_queue()
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Israel Rukshin <israelr@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Benjamin Block <bblock@linux.vnet.ibm.com>
References: <20170524003420.5381-1-bart.vanassche@sandisk.com>
 <20170524003420.5381-5-bart.vanassche@sandisk.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <7346a47f-1694-3808-af6c-c356d0008e15@suse.de>
Date: Wed, 24 May 2017 07:51:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170524003420.5381-5-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/24/2017 02:33 AM, Bart Van Assche wrote:
> This patch does not change any functionality.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Israel Rukshin <israelr@mellanox.com>
> Cc: Max Gurtovoy <maxg@mellanox.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Benjamin Block <bblock@linux.vnet.ibm.com>
> ---
>  drivers/scsi/scsi_lib.c  | 25 +++++++++++++++----------
>  drivers/scsi/scsi_priv.h |  1 +
>  2 files changed, 16 insertions(+), 10 deletions(-)
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
