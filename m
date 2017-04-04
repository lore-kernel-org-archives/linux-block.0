Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:52535 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdDDHJK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 03:09:10 -0400
Date: Tue, 4 Apr 2017 00:09:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 6/7] T10: Move opencoded contants to common header
Message-ID: <20170404070909.GG12008@infradead.org>
References: <1491204212-9952-1-git-send-email-dmonakhov@openvz.org>
 <1491204212-9952-7-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491204212-9952-7-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> -				if ((src->ref_tag == 0xffffffff) ||
> -				    (src->app_tag == 0xffff)) {
> +				if ((src->ref_tag == T10_REF_ESCAPE) ||
> +				    (src->app_tag == T10_APP_ESCAPE)) {

Please remove the inner braces while you're at it (also later in the
patch).

> index 9fba9dd..c96845c 100644
> --- a/include/linux/t10-pi.h
> +++ b/include/linux/t10-pi.h
> @@ -24,6 +24,9 @@ enum t10_dif_type {
>  	T10_PI_TYPE3_PROTECTION = 0x3,
>  };
>  
> +static const __be16 T10_APP_ESCAPE = (__force __be16) 0xffff;
> +static const __be32 T10_REF_ESCAPE = (__force __be32) 0xffffffff;

I'd do this as:

#define T10_APP_ESCAPE	cpu_to_be16(0xffff);
#define T10_REF_ESCAPE	cpu_to_be32(0xffffffff);

This avoids relying on the compiler to merge constants, and also gets
the endianess annotation right instead of force escaping it.
