Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F5028EA69
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848080; cv=none; b=u7+t5pKfWzscoSIO833OO/45Ok5doBBQdYpBzmoCIhvWc/+pbOdvCwU1PtLuBzy2HpOgunMPEkluQSpfj4hqgKS8jrJYTb695EoSWgASkHNIU3DW1LkRFjbUoorpoQQPlHXqPrr0jHZRw3RqoLE5l+degLxpjQc+HfYLQ0KBy3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848080; c=relaxed/simple;
	bh=ltfIDxZT8hbY7guDHz/cUokrTS34Qingmb8JjP8EWug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SP/uSCxNlCaB3ijQH0VeDZuYl75cAcezL6Hgx3pIoYOaZ3ihy4adsUzP/lFFrQm/G75TIZ0k3b0/JHgffNlqsY978E8JM2X9EaJCFQZxWhygjBdpSDWdpZLqZANP2vpeIsNGRF8JQzYV/1Y7c/eupQt2q4VsPPVbsTAsxeJ2Rns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPttoUK2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPttoUK2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750848077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ErcUn2NcvYH5UHzguAE6eBxtkmY6RPW1eoPmbhostL0=;
	b=iPttoUK2NRg0c1vKM2IFskJL5m1UlkhKs0ezeydHvB+YtBxZ5VNa7faZeu5lV/UCRBzw4w
	KjOikUTQgpaAKVufalP7Fv9i4L5l9U7OJPhKzRkJNDelZqedpUAaN2by4cRml8PbGdjjTr
	7136v3uMxDO1jcsLDOAYNPgnCNB2OJY=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-YDz8pFMxP_mHn9fmTH_Lnw-1; Wed, 25 Jun 2025 06:41:16 -0400
X-MC-Unique: YDz8pFMxP_mHn9fmTH_Lnw-1
X-Mimecast-MFC-AGG-ID: YDz8pFMxP_mHn9fmTH_Lnw_1750848076
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5314d22c278so1986418e0c.3
        for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 03:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750848076; x=1751452876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErcUn2NcvYH5UHzguAE6eBxtkmY6RPW1eoPmbhostL0=;
        b=DRY9I0Fa3/MUFXDvSPEzrvVqOv9eYDKURKLD5d+9Qr4u6834Im9M4YmKxff7hAL0jX
         cuPYPqcbRMsIDVv16GwLjtTncwSRuaBh/7mZlITV7dfWB2/qoyyP34lEqLHMJLbo2+Lr
         6/9yM0oz3nR6YXplr1dppptBDoxU495lyddwyMd8K1ZiDPKqefxnQI8J0s8r3T897KzM
         f/RNf8jSk+CrTwp3hqedJRDcRbzvujZ5u0B83wix7H5PmhAL/4QrvlOiotQZwqitDaIL
         x4ENnA0GJ48Wou/KQ6vmz7XglK2Clw+qaKasv0xQ3kjSYuVHi/tmpbXcCnbgCR8BM27A
         owgw==
X-Forwarded-Encrypted: i=1; AJvYcCUdxWOktZ3DxUuYH3as/WtEb/hDYt/or3HUMPFMot63M7p43xMSTZGvLO9mvEB3Aiw0opmwSTaWcqAd0g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb7OQ0Au/xHsXIU90XJYMncyhoigeIpuut9rqObBcCNZ8gTCdc
	WMV9KctAWrPmok1FVqxYgpQUHGM1udeeuEy8lOSA7GDOMrz7ZfCgQR2rG7RFCnLYJvf2z7Efutx
	7g9pWyF4TqI3L34K/cqaJ1+QO1IL5B2X5i6r0c6s3kVSYMBjUoHJmEkupP93U1w/5mMVOmGEmOT
	yQ+YYMqmL3ocniyBHdFXPfyCru6GCQJTke7+klnI8=
X-Gm-Gg: ASbGnctd4uQL9vD3tlnf0HKANBnNEEiIwSFIF1rwIPrzKa9MBNzAAw96+6fC+JGL9oS
	zhJIDZTX5jzpqfnjfY4AIEj/ObYXRBrx2i2PQNhDN6dbEOntKzYdUifRZyVT7Kz/QWm+gxqFKWe
	LZ
X-Received: by 2002:a05:6102:15c4:b0:4e6:ddd0:96f7 with SMTP id ada2fe7eead31-4ecc765898fmr785230137.13.1750848076082;
        Wed, 25 Jun 2025 03:41:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXbPZyYELptGl8VkZFz789wp/VDsSng+P9xsZm+lyCGXNT/lL3VAHAsdkD75gMSQksN3KaBpp4nYXK9WxI5Sw=
X-Received: by 2002:a05:6102:15c4:b0:4e6:ddd0:96f7 with SMTP id
 ada2fe7eead31-4ecc765898fmr785224137.13.1750848075819; Wed, 25 Jun 2025
 03:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612143443.2848197-1-willy@infradead.org> <20250612143443.2848197-3-willy@infradead.org>
In-Reply-To: <20250612143443.2848197-3-willy@infradead.org>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 25 Jun 2025 13:41:05 +0300
X-Gm-Features: Ac12FXwnzocGcxDTpyS9vkkvichcQpdXF6HqeZu-bSLiQ_y5im_LaEydI_74WUg
Message-ID: <CAO8a2ShGjYSXfV4Sd_NT9uw1Hfhpbpkx+ciu58KbjzRB584P_g@mail.gmail.com>
Subject: Re: [PATCH 2/5] null_blk: Use memzero_page()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good cleanup.

Reviewed-by: Alex Markuze amarkuze@redhat.com

On Thu, Jun 12, 2025 at 5:35=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> memzero_page() is the new name for zero_user().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  drivers/block/null_blk/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
> index aa163ae9b2aa..91642c9a3b29 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1179,7 +1179,7 @@ static int copy_from_nullb(struct nullb *nullb, str=
uct page *dest,
>                         memcpy_page(dest, off + count, t_page->page, offs=
et,
>                                     temp);
>                 else
> -                       zero_user(dest, off + count, temp);
> +                       memzero_page(dest, off + count, temp);
>
>                 count +=3D temp;
>                 sector +=3D temp >> SECTOR_SHIFT;
> --
> 2.47.2
>
>

