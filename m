Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3429C3A8735
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089190; cv=none; b=alje3L8f2tqH5/kq770zs8dOotjC6ch/nV55PLlvJtfrtg7QN8m9Sif+7PozugnBsCXNGV4kdsnjxe5KM9f62nFtXA4d1aYHE/9YE7ulL4L4lF2wstussmToCtMtgxKiTuIKSBQUqW3wOk6foo2Ww3HoQxVOMkO/hO/IhE41Vgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089190; c=relaxed/simple;
	bh=QqkdOP1zhQ8kNAHcIw4gTfAacQ4D4WVk9zHFNJp0za8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCmFIjb3+yQTMQ+ozf51YMf5ZdAPt8qRQuKX2uq0LyqFIGr5mZBiQJEUNJ2pRgc7pgg284JcyJ+ALgJnfr43YTo/dRqz0TqaDin9+8Wt6R4ea0R+yAMuy0r1VYLpYnSd4FVduZuHgJyiVaEQrX1Fnj0eV0PsyYbZXUBP+RlHY8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45eecb8bf67so4986623f8f.2
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 03:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781089188; x=1781693988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHtohPpXGahlOenhXvNIAGjZSypHtfodeQ5qiGu/QPA=;
        b=diPwvXLfs7itin0i9buDvWqkaYfM2R5SLPAnK2VJZh6b5Ydj2MXCR/InghNk5NiGW1
         1CNZs1SMAAT60AFqKwy6cDClWxe/ptDqANWA6A2ukhaiYBglR94QLxU/hFmqVjEAvCtv
         iTDe6U3PvvomsvMAANRW82wyIx+Z5Mq6sfisii/C9Y1shP00YRWtStlZ/aP4Gyy2VJes
         5LXUwn7ju/Rbwn+KroQPxPT5ulp0Yv0QKIQU8m8Wi7QhXOq2ZWdAdx18SN3XOC6Z0xWd
         QHGSiq9kGqEm4klvRSreD0So/jMq+uaGOStqxhlJMkXTdolAWrPygZ8RJwjmqhSZAbeb
         Up0Q==
X-Gm-Message-State: AOJu0YxviIRa4ro2HBEkfNKrEVc8p76oNGFQQX6rwr5syCZph6rWmKcy
	Tn/rCZxmMsfmnkUzVQcd5f6bW4QjiPugWudeQa0cUfNoesJz4uZMdVpo
X-Gm-Gg: Acq92OE7cExI5WMJMhCTU0gU/7H9i7WU8Ww9UMylc5d3pwKDPZ0H6flDwMLvmiAj3es
	vA4RToDEGPJ9BjBclnSonCAKQgcvupuUIHyd1CvpetWM9rA+NiSmd9WTJt3oRy6lvTU3RDA6pFh
	HQB4Bu4PO10lgdFEIGhOhDd8t19lfbXPszY03PEGNmYCdpGFgVijZnQmMTUX4nzeg7JE6Vo7Y+o
	CvO60pY4PWOj7uYOcG85InsfI9DQvX/27u3ihL8j6k+TqtPT9iZkRcClB3eRGdceUq8+BBBbAW3
	KcsGjH8UjWrqpD//rgRNzbeoRQdmYGVlLEA/BKyuj5e0IjXsLbTiUnSjdx2us4v5VNSE7UvQS/f
	BRS3/wqz4vVoqAr9tJ6RwPc49g+g28s98CW0pYdSidEUKFo4IJFJFF3X4PzguY6QY27KS+WiACd
	U7wGlWeKDGOFeJyTp5zQJwmwiFnEr0X7jFUBN7NeyJmbM1k8oJVimHOgmOJ4wGWIpkzPBeZ9u57
	dW2igRcCHP6
X-Received: by 2002:a5d:6644:0:b0:45e:f780:6181 with SMTP id ffacd0b85a97d-46030501958mr26460720f8f.23.1781089187489;
        Wed, 10 Jun 2026 03:59:47 -0700 (PDT)
Received: from [10.68.32.41] (bba-217-164-201-253.alshamil.net.ae. [217.164.201.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dce6sm63499684f8f.30.2026.06.10.03.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 03:59:46 -0700 (PDT)
Message-ID: <6330395a-15a5-43bd-a2fa-69fb24eef76e@linux.com>
Date: Wed, 10 Jun 2026 14:59:44 +0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Subject: Re: [PATCH v1] floppy: Drop unused pnp driver data
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <99dbf851ffb99229ea1dcfd8f58e9ee6a1f05349.1781075967.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <99dbf851ffb99229ea1dcfd8f58e9ee6a1f05349.1781075967.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/06/2026 11:27, Uwe Kleine-König (The Capable Hub) wrote:
> The pnp_device_id array is only used for module data to support
> auto-loading the floppy module. So the .driver_data member is unused and
> this assignment can be dropped.
> 
> While touching that array, align the coding style to what is used most
> for these.
> 
> This patch doesn't modify the compiled array, only its representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Reviewed-by: Denis Efremov (Oracle) <efremov@linux.com>

> ---
> Hello,
> 
> I intend to change struct pnp_device_id and for that it's required that
> .driver_data is not assigned using a list initializer. Instead of
> converting it to a named initializer, drop the assignment as the value
> is unused. So this is both a cleanup and a preparation for a later patch
> series.
> 
> See
> https://lore.kernel.org/all/cover.1779878004.git.u.kleine-koenig@baylibre.com/
> for a more verbose description on the mentioned change to struct
> pnp_device_id (though this is about platform_device_id, but the idea
> here is the same).
> 
> Best regards
> Uwe
> 
>  drivers/block/floppy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 0509746f8aed..dca495be0683 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -5012,8 +5012,8 @@ MODULE_LICENSE("GPL");
>  
>  /* This doesn't actually get used other than for module information */
>  static const struct pnp_device_id floppy_pnpids[] = {
> -	{"PNP0700", 0},
> -	{}
> +	{ .id = "PNP0700" },
> +	{ }
>  };
>  
>  MODULE_DEVICE_TABLE(pnp, floppy_pnpids);
> 
> base-commit: 49e02880ec0a8c378e811bc9d85da188d7c6204c

