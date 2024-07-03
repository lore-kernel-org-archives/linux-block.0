Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB52C45005
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 03:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719976146; cv=none; b=mp5SnMnQnQQsaIriep0wXpHcN/6zjal6T1DIfIL/FjOehyPmArKyxfNh3mzuT1FIcpSL37706ovZWm/73zYcFzT+lbn1x/sn23LlpS5tL1Pml2cYCi1tQ628bG9zAlnbmzzBcjVnka37tSe184nLZbuyb1XvEYjpCItrXQht8o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719976146; c=relaxed/simple;
	bh=ebBE5csxzSU8jb7EKoYKazxV8HskGRvw5TKdqlpAof8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyBFYqITPn+6JE3aENwHPem0TK56USHLJu1b+lZjxMQXHkwwC3guLALHBstYbgHvVvBeQabWWLF4n3n8+imo3Z/4dsOcSAs+q31H8m+tgqhU+/4ijO5YsB9hCoV7j98ewjjGLdAcqcMMDIkZtXqzSWJueLfjRe+PD44A3iFWNgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNN3zf2m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNN3zf2m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719976143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqTih/u22dsz2YqGSr29lh4ZAhZDYLuFKJMZEOZjPn4=;
	b=BNN3zf2mhIQTmq+Tp5TGDxQb8vTXkqspEm+x3gPktPvi5TcO8umgH9iib9DMfaCjIdFd2+
	M9WQbxiOO/Ekr5+YWO6YZ+2ds8itJ7Vjo9TyuEzM1xBdCbu5plysLOCNjUKVQge+uaJHl6
	vRqDsO5s6by/vqbz8bjWnUYDWWwOtSk=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-C7mjGbIgPZenUWwrODg8jA-1; Tue, 02 Jul 2024 23:09:01 -0400
X-MC-Unique: C7mjGbIgPZenUWwrODg8jA-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-48f3c35695eso497499137.3
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2024 20:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719976141; x=1720580941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqTih/u22dsz2YqGSr29lh4ZAhZDYLuFKJMZEOZjPn4=;
        b=irOBUEqPGhGBY9sQr8ER+Aky01jJ0t1xWiWxG/3zdU1rEaJviz5K6Uf6499Iv7J7e/
         qfLo2rQ7sl9J34dkK66c2OZ0R9xhCsahhSCdKLuc6/bnSxreX1v1KVJqEx2FM2dIm8/h
         KwCLzG+M3SVynwdZRbzJqMd27rShBSG2/BF6YedtfB7eW4XXHfCecG/+gGBSuyYHUoBq
         7lBNkVhEWz/KmLyNZXmHaF3S+M/lkj4nJdXv1wxY3ukwMCqFOLaYxBw3Pb+7fJ8h1dYW
         Ip5dDdYP0l62QPGMWQghDd9UlrKhYdH+43msEL5VMoP1eCkm7urftp2E21XIEwM0+DhT
         2GsA==
X-Forwarded-Encrypted: i=1; AJvYcCUXbFCq1bw9iANYH7LvSvuKpNRQCHjMFfYFf1MAm+df16TNXuQ3gse7w76Bg+bOimPFBWdk97AU5zKaiRvceN76gY3jKytkOrAtnFA=
X-Gm-Message-State: AOJu0YzWfaNFPtPTKxdZYv6NiFsbWpJK4f9uiWeoU7cpCsJCNAmxtWEe
	YIScNyBYcnH3rtaNLaYgEQ7PHtIcm6a+h/ojM/W4HddSkunEfOE8DvI8B1TsDLffT83XsJbgy4U
	G7VTYkGaVLFtKNFgxqoxIK9xlaXP564cTxEELSnks13eJaKVycbOzyvm/JfHcC9M3GSHvN21O80
	LMIeEuE1c8BB/kkUCGEI5Niolo+QZIc6Y4/cA=
X-Received: by 2002:a05:6102:5090:b0:48f:19af:d2a4 with SMTP id ada2fe7eead31-48faf0db435mr11124792137.2.1719976141095;
        Tue, 02 Jul 2024 20:09:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6cG4rvhz6h7sOV9Zn7RppDOZ1Y+nVQn7hMFUt203MqoVxXCE70cL+WWnw7hKYH9ZYAZHJp/x1nd6rS6hNXj4=
X-Received: by 2002:a05:6102:5090:b0:48f:19af:d2a4 with SMTP id
 ada2fe7eead31-48faf0db435mr11124775137.2.1719976140825; Tue, 02 Jul 2024
 20:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240702101517epcas5p3f651d9307bab6ece4d3e450ed61deb82@epcas5p3.samsung.com>
 <20240702100753.2168-1-anuj20.g@samsung.com>
In-Reply-To: <20240702100753.2168-1-anuj20.g@samsung.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 3 Jul 2024 11:08:49 +0800
Message-ID: <CAFj5m9LcpCbdy4Vim3R+=KOnyM_AwevGM1ye5NSY4HRt1XS06Q@mail.gmail.com>
Subject: Re: [PATCH] block: reuse original bio_vec array for integrity during clone
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, 
	joshi.k@samsung.com, linux-block@vger.kernel.org, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 7:38=E2=80=AFPM Anuj Gupta <anuj20.g@samsung.com> wr=
ote:
>
> Modify bio_integrity_clone to reuse the original bvec array instead of
> allocating and copying it, similar to how bio data path is cloned.
>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  block/bio-integrity.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index c4aed1dfa497..b78c145eb026 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -76,7 +76,7 @@ struct bio_integrity_payload *bio_integrity_alloc(struc=
t bio *bio,
>                                           &bip->bip_max_vcnt, gfp_mask);
>                 if (!bip->bip_vec)
>                         goto err;
> -       } else {
> +       } else if (nr_vecs) {
>                 bip->bip_vec =3D bip->bip_inline_vecs;
>         }
>
> @@ -584,14 +584,11 @@ int bio_integrity_clone(struct bio *bio, struct bio=
 *bio_src,
>
>         BUG_ON(bip_src =3D=3D NULL);
>
> -       bip =3D bio_integrity_alloc(bio, gfp_mask, bip_src->bip_vcnt);
> +       bip =3D bio_integrity_alloc(bio, gfp_mask, 0);
>         if (IS_ERR(bip))
>                 return PTR_ERR(bip);
>
> -       memcpy(bip->bip_vec, bip_src->bip_vec,
> -              bip_src->bip_vcnt * sizeof(struct bio_vec));
> -
> -       bip->bip_vcnt =3D bip_src->bip_vcnt;
> +       bip->bip_vec =3D bip_src->bip_vec;
>         bip->bip_iter =3D bip_src->bip_iter;
>         bip->bip_flags =3D bip_src->bip_flags & ~BIP_BLOCK_INTEGRITY;

I am curious how the patch avoids double free? Given nothing changes
in bip free code path and source bip_vec is associated with this bip.

Thanks,

