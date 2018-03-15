Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932397AbeCOPtW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:49:22 -0400
Subject: Re: [PATCH 03/16] bcache: Annotate switch fall-through
To: Bart Van Assche <bart.vanassche@wdc.com>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
 <20180315150814.9412-4-bart.vanassche@wdc.com>
From: Coly Li <colyli@suse.de>
Message-ID: <2c3ebe0d-b148-83f4-456e-785219a412ff@suse.de>
Date: Thu, 15 Mar 2018 23:48:53 +0800
MIME-Version: 1.0
In-Reply-To: <20180315150814.9412-4-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 15/03/2018 11:08 PM, Bart Van Assche wrote:
> This patch avoids that building with W=1 triggers complaints about
> switch fall-throughs.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

Reviewed-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
>  drivers/md/bcache/util.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
> index a23cd6a14b74..6198041f0ee2 100644
> --- a/drivers/md/bcache/util.c
> +++ b/drivers/md/bcache/util.c
> @@ -32,20 +32,27 @@ int bch_ ## name ## _h(const char *cp, type *res)		\
>  	case 'y':						\
>  	case 'z':						\
>  		u++;						\
> +		/* fall through */				\
>  	case 'e':						\
>  		u++;						\
> +		/* fall through */				\
>  	case 'p':						\
>  		u++;						\
> +		/* fall through */				\
>  	case 't':						\
>  		u++;						\
> +		/* fall through */				\
>  	case 'g':						\
>  		u++;						\
> +		/* fall through */				\
>  	case 'm':						\
>  		u++;						\
> +		/* fall through */				\
>  	case 'k':						\
>  		u++;						\
>  		if (e++ == cp)					\
>  			return -EINVAL;				\
> +		/* fall through */				\
>  	case '\n':						\
>  	case '\0':						\
>  		if (*e == '\n')					\
> 
