Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam02on0073.outbound.protection.outlook.com ([104.47.36.73]:30624
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750733AbdALV3F (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2017 16:29:05 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "osandov@osandov.com" <osandov@osandov.com>
Subject: Re: [PATCH 07/10] blk-mq: abstract out helpers for
 allocating/freeing tag maps
Date: Thu, 12 Jan 2017 21:29:00 +0000
Message-ID: <1484256526.2720.19.camel@sandisk.com>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
         <1484170803-9311-8-git-send-email-axboe@fb.com>
In-Reply-To: <1484170803-9311-8-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-01-11 at 14:40 -0700, Jens Axboe wrote:
> @@ -2392,12 +2425,12 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *s=
et)
>  	if (set->nr_hw_queues > nr_cpu_ids)
>  		set->nr_hw_queues =3D nr_cpu_ids;
> =20
> +	ret =3D -ENOMEM;
>  	set->tags =3D kzalloc_node(nr_cpu_ids * sizeof(struct blk_mq_tags *),
>  				 GFP_KERNEL, set->numa_node);
>  	if (!set->tags)
>  		return -ENOMEM;
> =20
> -	ret =3D -ENOMEM;
>  	set->mq_map =3D kzalloc_node(sizeof(*set->mq_map) * nr_cpu_ids,
>  			GFP_KERNEL, set->numa_node);
>  	if (!set->mq_map)

Not that it matters to me, but this change probably isn't needed?

Anyway:

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
