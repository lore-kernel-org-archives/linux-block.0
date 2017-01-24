Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: Re: [PATCH 04/16] dm: remove incomple BLOCK_PC support
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
References: <1485185361-29786-1-git-send-email-hch@lst.de>
 <1485185361-29786-5-git-send-email-hch@lst.de>
Cc: Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <49da3ac5-70eb-4342-8ed3-c19d81684982@suse.de>
Date: Tue, 24 Jan 2017 09:22:35 +0100
MIME-Version: 1.0
In-Reply-To: <1485185361-29786-5-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 01/23/2017 04:29 PM, Christoph Hellwig wrote:
> DM tries to copy a few fields around for BLOCK_PC requests, but given
> that no dm-target ever wires up scsi_cmd_ioctl BLOCK_PC can't actually
> be sent to dm.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/md/dm-rq.c | 16 ----------------
>  1 file changed, 16 deletions(-)
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
