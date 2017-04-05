Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43651 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753857AbdDEGcw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Apr 2017 02:32:52 -0400
Subject: Re: [PATCH 2/9] bio-integrity: bio_trim should truncate integrity
 vector accordingly
To: Dmitry Monakhov <dmonakhov@openvz.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
 <1491332201-26926-3-git-send-email-dmonakhov@openvz.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <98d22a8d-5937-ae80-0551-0bf713c3eb4d@suse.de>
Date: Wed, 5 Apr 2017 08:32:49 +0200
MIME-Version: 1.0
In-Reply-To: <1491332201-26926-3-git-send-email-dmonakhov@openvz.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/04/2017 08:56 PM, Dmitry Monakhov wrote:
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
> ---
>  block/bio.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index e75878f..fa84323 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1907,6 +1907,10 @@ void bio_trim(struct bio *bio, int offset, int size)
>  	bio_advance(bio, offset << 9);
>  
>  	bio->bi_iter.bi_size = size;
> +
> +	if (bio_integrity(bio))
> +		bio_integrity_trim(bio, 0, size);
> +
>  }
>  EXPORT_SYMBOL_GPL(bio_trim);
>  
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
