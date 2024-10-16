Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2EC2076A6;
	Wed, 16 Oct 2024 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729076934; cv=none; b=DEZZ9fxSr8+5Tzu/it3xoOoIOh2LkcQH2cLhZRjcZAnsC14GuicTkDiWD0iL7rdzz+IKNiIOvf8pTNH514pMYfJIybqDNUMLFHFow9P7BDbfNlwcb64Dc0/NUqjaDXhiSan5cGA0R3mA2C2ldHa9nm+PyOndVNkDSsMeutfrnmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729076934; c=relaxed/simple;
	bh=serKe8tHlOrXNXs54i3kenw7XTJg+lTNjLS5V05yv/s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMfQKPSNvQPiFai5ce/TYgLnhSgG4rtiwCW7i25H+KcT4V7qmWp9/P5gXS3sAMFdE98plN0IcdrxZHPyoLfm+e0gAyI7rtt+1OLjSlbWpUWltraYe/amTofFE2rgB932X3Hnk8Dpg4bqIppqoaE2beKQvFWPyIodWGpMcnRtd9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ST9F9vra; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ST9F9vra"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb561f273eso27936181fa.2;
        Wed, 16 Oct 2024 04:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729076931; x=1729681731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgR2+WDRyuZp5/EA3TzWdSDdm1lah41Q0kcqmp7FNNY=;
        b=ST9F9vraVIONjZ3PNKxa8T1vDyFU643f8LoW3rqjQblbFueJGiQYTUDUntERg0U5LS
         H4cCUn/ja6SviIW0o+QCuJ+8c2p7ymm0CXYSuPmgPOM/76zp8RqlMpiWsi3PqE+XeKNf
         b1cDa+sDMefDZ41soTz62THEQMIJPCHu3Nf5ogFDhnyWTBaBMs76PLCtymf4dr7apdPn
         3dDOKfIIlBteadrWB5wTdIvf6lLcKbgDbz34AHd++Gernqmzud6mts7W+4Et+7YG7YNv
         y2OzRgNywSBfPrkXOjF8y1JwGOk1NQe2nvdaFRZrMgyNOC4kMRAHJSmWbZuSZFOgDGJ+
         Friw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729076931; x=1729681731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgR2+WDRyuZp5/EA3TzWdSDdm1lah41Q0kcqmp7FNNY=;
        b=Cm9RaszUdJvajHOGgMnLNGkGfdFob2O4p6JYj3vAm/sFp+RpsQq8DKLwpAMbhrWXSb
         xkSegD87WOi1YZ2gDtotRaExkgWc+5zFIByus9dSF/3jR7aZEZO1G6sg5UgFgOlE591i
         n5OB6QC+Zzq7Sh6+ETByfQgzZ2brloAVX7lpMnQWUx4sXWzUvk7ZpQGCFKpJk6ANMMp2
         kT2hcbRJdKHaxaQI+83LYxdlkMUFpdiNZY57zjdeUJ6KV9euKUHUwoFed0uxNkxmsFo0
         7lwuQyTTPVj7Ng2QM4uxUjku8JKM9wQ209E/fFucaPC8Huv9JzCl7gbpbEF2drC+aqa0
         WxXg==
X-Forwarded-Encrypted: i=1; AJvYcCU5IAX4AlyCHG47dgESRGJlTIabAsKIizLCMAV9C1+lx4wOCpsDpdxSZ5Z2W1Eg2/GdAq6/UGfasHOr7roFfko=@vger.kernel.org, AJvYcCUxSjTc0rhSQ/tPwmF5JtBWDkkclJtc8OZwUGeAKQePLjVHh/Lii4VYZ/S9RZWL2rCmhEYjz8hhZx2amNmC@vger.kernel.org, AJvYcCXqB/dx1eh4MiLqrO80drd/cVFtfc0edjVQ9HstMulxogpffxsTNyq0cI+fqW453V7e4RKlxxUEiSNHaN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnvKNQiG8S5L3rtH72/5BRjcJrZD5QhQJV0cFWLVpUq9snjE3O
	Qs9La4XVui5hfTk0LSbAFobGCXooGTwp9a/cXTAQhdb78Zta8r9n
X-Google-Smtp-Source: AGHT+IFjjfpeb7i91SIRpG3vpwFOV9VHQnoo1Etn6OxAQdEDHy7vguM7RDwkvRepnzmSP1K0JGJJEQ==
X-Received: by 2002:a2e:4c09:0:b0:2fa:d978:a6a2 with SMTP id 38308e7fff4ca-2fb327813b8mr61302781fa.27.1729076930577;
        Wed, 16 Oct 2024 04:08:50 -0700 (PDT)
Received: from pc636 (host-95-203-1-67.mobileonline.telia.com. [95.203.1.67])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb5d122023sm4019741fa.29.2024.10.16.04.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 04:08:50 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 16 Oct 2024 13:08:47 +0200
To: Julia Lawall <Julia.Lawall@inria.fr>, Jens Axboe <axboe@kernel.dk>
Cc: Jens Axboe <axboe@kernel.dk>, kernel-janitors@vger.kernel.org,
	vbabka@suse.cz, paulmck@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/17] block: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Message-ID: <Zw-ev-t7G6X4RX8Z@pc636>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
 <20241013201704.49576-10-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013201704.49576-10-Julia.Lawall@inria.fr>

On Sun, Oct 13, 2024 at 10:16:56PM +0200, Julia Lawall wrote:
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
> 
> The changes were made using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  block/blk-ioc.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index 25dd4db11121..ce82770c72ab 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -32,13 +32,6 @@ static void get_io_context(struct io_context *ioc)
>  	atomic_long_inc(&ioc->refcount);
>  }
>  
> -static void icq_free_icq_rcu(struct rcu_head *head)
> -{
> -	struct io_cq *icq = container_of(head, struct io_cq, __rcu_head);
> -
> -	kmem_cache_free(icq->__rcu_icq_cache, icq);
> -}
> -
>  /*
>   * Exit an icq. Called with ioc locked for blk-mq, and with both ioc
>   * and queue locked for legacy.
> @@ -102,7 +95,7 @@ static void ioc_destroy_icq(struct io_cq *icq)
>  	 */
>  	icq->__rcu_icq_cache = et->icq_cache;
>  	icq->flags |= ICQ_DESTROYED;
> -	call_rcu(&icq->__rcu_head, icq_free_icq_rcu);
> +	kfree_rcu(icq, __rcu_head);
>  }
>  
>  /*
> 
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

