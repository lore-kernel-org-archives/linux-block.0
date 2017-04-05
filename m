Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753447AbdDEGeo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Apr 2017 02:34:44 -0400
Subject: Re: [PATCH 3/9] bio-integrity: bio_integrity_advance must update
 integrity seed
To: Dmitry Monakhov <dmonakhov@openvz.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
 <1491332201-26926-4-git-send-email-dmonakhov@openvz.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3a7e328e-dbb9-cd15-d71c-8370787cf4ea@suse.de>
Date: Wed, 5 Apr 2017 08:34:42 +0200
MIME-Version: 1.0
In-Reply-To: <1491332201-26926-4-git-send-email-dmonakhov@openvz.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/04/2017 08:56 PM, Dmitry Monakhov wrote:
> SCSI drivers do care about bip_seed so we must update it accordingly.
> 
> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
> ---
>  block/bio-integrity.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index b5009a8..82a6ffb 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -425,6 +425,7 @@ void bio_integrity_advance(struct bio *bio, unsigned int bytes_done)
>  	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
>  	unsigned bytes = bio_integrity_bytes(bi, bytes_done >> 9);
>  
> +	bip->bip_iter.bi_sector += bytes_done >> 9;
>  	bvec_iter_advance(bip->bip_vec, &bip->bip_iter, bytes);
>  }
>  EXPORT_SYMBOL(bio_integrity_advance);
> 
Odd that we've missed that one...

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
