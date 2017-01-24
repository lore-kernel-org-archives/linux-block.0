Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbdAXLHl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 06:07:41 -0500
Subject: Re: [PATCH 11/16] scsi: remove scsi_cmd_dma_pool
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
References: <1485185361-29786-1-git-send-email-hch@lst.de>
 <1485185361-29786-12-git-send-email-hch@lst.de>
Cc: Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <73912b32-14a4-07ca-8144-5cb46f9d3149@suse.de>
Date: Tue, 24 Jan 2017 12:07:28 +0100
MIME-Version: 1.0
In-Reply-To: <1485185361-29786-12-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/23/2017 04:29 PM, Christoph Hellwig wrote:
> There is no need for GFP_DMA allocations of the scsi_cmnd structures
> themselves, all that might be DMAed to or from is the actual payload,
> or the sense buffers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/scsi/scsi.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
