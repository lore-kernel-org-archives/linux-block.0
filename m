Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1761126C1E
	for <linux-block@vger.kernel.org>; Sat, 12 Apr 2025 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744421124; cv=none; b=FIvX5XfsaDmOqIydGXSWjj7426+TNC0hfSttjnsdJBSbniHh2hSMIf8HJsbEfb1jGs0VH5Vu0FrtPMZcXxq++JW9SqeCXs7/Q/ZlWmbMWTFZ2+o+o+MTGAdxYB3rp2zjgcjvXO5wXk3trc4AQ9t+LIOUOspRwMXQegWYu6Ft5lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744421124; c=relaxed/simple;
	bh=5UeX5RiZJVhD4I8h/Pmw4+5cG26ufvPCZjBBYW7NMEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDx1zb5+6mUabt/TSbcVoc47UTqmxz56LKRn7snF4gUpaWkUOv3nmQ0+FDei2ujRAYsW9QY/KYAQ1fBfazTwa9aiznjlfG5C+xeoYyW0GdUe/0ZCd7LBUY23KdNwOqifOSqjgnubFvDYhMpZzMCtuWoqqkZipf2bQo+j+tB3fAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqBjHODZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqBjHODZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744421121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2vjf9vXx9JkuxASxNHGliuMLD++yjQxtGQUYtfvuOoM=;
	b=FqBjHODZYq5RdoKTAsyqQyVFoW0Asq0pro0UHtAit8y82gkoEbYD4rFIo/CZs/CyWqPrhu
	M/fr50+XEBHMAjSYVOiTgENks9hDYDDnvoGR6DqDofasY+QNQPKupS0smXHpy8WDRW+B6z
	XwPK6s0i7LaGtqJo2ErtdHhbhcvGs5w=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-BsETidx7M8GMG4JzcSkM6w-1; Fri, 11 Apr 2025 21:25:19 -0400
X-MC-Unique: BsETidx7M8GMG4JzcSkM6w-1
X-Mimecast-MFC-AGG-ID: BsETidx7M8GMG4JzcSkM6w_1744421119
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-86cce6363f6so2481360241.1
        for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 18:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744421119; x=1745025919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vjf9vXx9JkuxASxNHGliuMLD++yjQxtGQUYtfvuOoM=;
        b=k8slktwJmWQz/Cw4IAv3IUVPL8Iyc145qW4uSB8qKKL6weIwzXRy7o50JwsiFzgzYs
         xv3Whce+AFrrH/kV89JeLDKBdNGO96rnfcq3NDLIcmHZapq6BYmthIqyDNndOk31tuJn
         37neYveXCEejR+X9O4B1SXqieTKV5JQP6NOeNTPtFAl+CRAmb5QzLbELLUxfHiTIAGKX
         HgRY7kcQPD52TqkmPfr6o7JKVyfu0sOPOgCfndtWHcrTrKw4WPwxbFeXOEc2M+RBsXrz
         2Jt2ksN9uuq82BJvoc3g/eb8t8fbzJlYHaflGdjc5rutlVKj3dL8Ai8u8TXlHxDoZLB8
         Ffcw==
X-Forwarded-Encrypted: i=1; AJvYcCUIitkHcP7vs6+rJL+h94ufxPe5x0p2t3oAb/mrf0hXEWvD18NiThLbADb2BiwXprrJ9A+ok1ySaBFYfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4FDUPZyYFfR0NpIPBqfu/p8zTLFE8wWlXKmX6GNUFaL1P6vgk
	P4ABjPU8dvrEPMFYTpp8A9LbwvEIWh22Mq7jxBPbmDkCTnOO39rYBgFEglaR8eueSr8UGcpQH16
	2x1M8eOu76gbskO1pTkiGonga6k906mYdhQq4+DAMzkttYTeFol+wJLooJ0gpshteMWEZcC88qA
	kAogWHegcwwd1718J59d6N2vl7o51fh/dIrmmvrLXbtbwNRN9W
X-Gm-Gg: ASbGncv6/asLtMxcwAVskf8CgbdGFe+ZKUXoHtoZg3zrw/m4cIwdkJlM8DQUPMPa2Lt
	K8f1y35gvHs3bQ/9v3hNMGIXXBMezaL8w9szGnFMQuM2n1YIFCeGZNId46ca5ql1e9X253g==
X-Received: by 2002:a05:6102:1481:b0:4c3:69f:5be with SMTP id ada2fe7eead31-4c9d3f8d210mr7901229137.7.1744421118901;
        Fri, 11 Apr 2025 18:25:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRqLaRyPhfsLt7QcpcOLXf5X5TpXbcakHcPVH9K4aRD/E42ibSE6eTZWSyKb5TBZ1n9Wor+sMyVLuurY8gaMo=
X-Received: by 2002:a05:6102:1481:b0:4c3:69f:5be with SMTP id
 ada2fe7eead31-4c9d3f8d210mr7901217137.7.1744421118383; Fri, 11 Apr 2025
 18:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407131526.1927073-1-ming.lei@redhat.com> <20250407131526.1927073-3-ming.lei@redhat.com>
 <37a69ba9-7928-4b4a-a887-1ec0b35a25e9@wdc.com>
In-Reply-To: <37a69ba9-7928-4b4a-a887-1ec0b35a25e9@wdc.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Sat, 12 Apr 2025 09:25:07 +0800
X-Gm-Features: ATxdqUG0V90K1U_S5BiPXO3DYS4B0ChtfCBNl0dzhnhHHsbCvus12hnRzLdgmh4
Message-ID: <CAFj5m9K1ePNk_RS-UZWac6F_vdzF9fg_s23uB6DUN-L9PHJveg@mail.gmail.com>
Subject: Re: [PATCH 02/13] selftests: ublk: fix ublk_find_tgt()
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Caleb Sander Mateos <csander@purestorage.com>, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 2:05=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 07.04.25 15:18, Ming Lei wrote:
> > Bounds check for iterator variable `i` is missed, so add it and fix
> > ublk_find_tgt().
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   tools/testing/selftests/ublk/kublk.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selft=
ests/ublk/kublk.c
> > index 91c282bc7674..5c03c776426f 100644
> > --- a/tools/testing/selftests/ublk/kublk.c
> > +++ b/tools/testing/selftests/ublk/kublk.c
> > @@ -14,13 +14,12 @@ static const struct ublk_tgt_ops *tgt_ops_list[] =
=3D {
> >
> >   static const struct ublk_tgt_ops *ublk_find_tgt(const char *name)
> >   {
> > -     const struct ublk_tgt_ops *ops;
> >       int i;
> >
> >       if (name =3D=3D NULL)
> >               return NULL;
> >
> > -     for (i =3D 0; sizeof(tgt_ops_list) / sizeof(ops); i++)
> > +     for (i =3D 0; i < sizeof(tgt_ops_list) / sizeof(tgt_ops_list[0]);=
 i++)
>
> Why not
>
>         for (i=3D0; i < ARRAY_SIZE(tgt_ops_list); i++)

It is because ARRAY_SIZE isn't defined as one generic helper for
test code.

But it is more readable, so I will add it in ublk header.

Thanks,

