Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF8C1F2BAD
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739911353; cv=none; b=JL6ZY0x164BCimV1P1HHmQXE6iblatOOv+NsvgC9b9qsQJ5ZIlnt1SfSoHnR44obkrN9ZteA8zO8RM6hPv1yX6vnikIyYPxcmG3WvpSVOjmpmaUCjgPtvA7BlKdkxq0PTgpptzI7bPZCBbcoNoAwAugrwyJZVXAi9CHquaqaIY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739911353; c=relaxed/simple;
	bh=iM69Sq4EwizlkemOzCEOYImo2uRAkRmz1v8bJzzMirA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jadrL7n5F6i2USh7HrCQh5vGuKMY1Qfi0/B8fSAQi4yF2EkdV6bXuT+49+OnU2+hDRv7LvtevGcn0JUqOtlwy22DMgd44sEc1FjjQAYY4fcGV09ghydXZ/Mr6G70l4Z2M0nt29TLJybhuQ1KVJAx3ZW+cLwnp2bNQUkgEj+VXfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZlJUPENh; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZlJUPENh"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fc95e20e72so410718a91.1
        for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 12:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739911350; x=1740516150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2knz9CJQIa2pL92LuX+mUCXVfehtSkHITIk/Cvm9PI=;
        b=ZlJUPENhekVQuI8QT3qlpchi9uDcRTKkNpmNAJo+vFXw8FXs1DH66hcPNe+VCqRK+5
         UrVkLRiyX9MV/7Ji1DZYef5QYzRlby3gP6eC9oqZJ7+a5oWb4Xc3JiTDnSEZhYSWYksA
         rkRJxYUVN0YGl8mkTogqkUO6hmKUa0srVF6SO9UTgbcvXcLc2w8VAqs32K8MZuHcFlEi
         jbVVh1OHZLiiZCEvuJ6+wGtnxXIsEU5XeMEyoK0nDP7TIhaR3FHS5yJD+tj+v70lUmIK
         Qv7Ua2Xb5okgRxuqbTajJwgpC++6HjV2UfEREdDqB9lK5/1t5wJPrvugYszTqpWfEZtC
         c8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739911350; x=1740516150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2knz9CJQIa2pL92LuX+mUCXVfehtSkHITIk/Cvm9PI=;
        b=U/TLkCXvWlgMVncxwNXspqLjlLGCyN7IpBPYKABJaHH3FfMs8gLvRVNNtr/2otbUA6
         bXL+JruNixrxNRr0bNnMPDBQrSwZYtj2x4Pce7mItCG7sffmVwAdWh3VdGNMiFusj/y+
         QfvAKwoYQ1HKWe4xGVUZw/aMICm8Wj7fFr8ut7gJnc0WLRwFUtegMUT6CiiTcz/EvkNb
         SxZt2Vlq+4LbhDyZ+br7dT8ow3b7tEvGTu2iwdnBr3hnDu/fI0EWdDRcxvzu8Jl2mWuc
         dvKJsX4rtoNsVZuHZcVzW7yJr7cp8alT5eejuse0mHhB+TBDOdxruH8b11Yo1+kGt4fw
         xFmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEaCZI6kUTQyp2r+T/GWtvHZvMegPIQDK0HN/wVthbGkcCTT/GmiEJIhksD4Duf5UpJLjfiNeanDxKlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/MquU87gRDO53yWrAMKQRo4RpS4XfagGItnI5xjp1LZEnpUk
	qhU0B32vNGSjsUC1csitBnLbcAuI8NiXp/gQp6okau/k11CDGxDZcU9XWqVjeKovhpKozQJvStR
	odW2ZfFpZcuXQkhVyBil2FNLjyqzv3zJWbG5x0w==
X-Gm-Gg: ASbGncuqiwhXCyFIZ67vzem2C4FhFuxxhRpMsav1Q4+vXQTU4a2ZMvPxHa0MBy/5YzB
	J0wl9vHSD+p7BW1Kw4AtV/oElhSBhSqmJfOPEx6UgE4eqISRd7d5m6Za+6Efb/esV2W64TWQ=
X-Google-Smtp-Source: AGHT+IFan/miZiad/qwZ2C19pxW/4XvVVUBhBNZlqk0pS27lbXaO2J9WHXZfVKaerNgUUDgaqnT1kJAwPmh/ZS8WCgI=
X-Received: by 2002:a17:90b:4cc3:b0:2ee:c059:7de6 with SMTP id
 98e67ed59e1d1-2fc40d12454mr9053183a91.2.1739911350385; Tue, 18 Feb 2025
 12:42:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214154348.2952692-1-kbusch@meta.com> <20250214154348.2952692-6-kbusch@meta.com>
 <CADUfDZpM-TXBYQy0B4xRnKjT=-OfX+AYo+6HGA7e7pyT39LxEA@mail.gmail.com> <Z7TpEEEubC5a5t6K@kbusch-mbp>
In-Reply-To: <Z7TpEEEubC5a5t6K@kbusch-mbp>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 18 Feb 2025 12:42:19 -0800
X-Gm-Features: AWEUYZkgk1bjVjv6uCgcaPbYdiR8HF4EkCSuklvR8ZfmHAAVegnvKIcg4u3DTgQ
Message-ID: <CADUfDZqb-55yAJU1GbDF3tqW=6DhNP+SV3Msx+Sv5GPRHt+s0w@mail.gmail.com>
Subject: Re: [PATCHv3 5/5] io_uring: cache nodes and mapped buffers
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com, asml.silence@gmail.com, 
	axboe@kernel.dk, linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 12:09=E2=80=AFPM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Fri, Feb 14, 2025 at 06:22:09PM -0800, Caleb Sander Mateos wrote:
> > > +static struct io_mapped_ubuf *io_alloc_imu(struct io_ring_ctx *ctx,
> > > +                                          int nr_bvecs)
> > > +{
> > > +       if (nr_bvecs <=3D IO_CACHED_BVECS_SEGS)
> > > +               return io_cache_alloc(&ctx->buf_table.imu_cache, GFP_=
KERNEL);
> >
> > If there is no entry available in the cache, this will heap-allocate
> > one with enough space for all IO_CACHED_BVECS_SEGS bvecs.
>
> The cache can only have fixed size objects in them, so we have to pick
> some kind of trade off. The cache starts off empty and fills up on
> demand, so whatever we allocate needs to be of that cache's element
> size.
>
> > Consider
> > using io_alloc_cache_get() instead of io_cache_alloc(), so the
> > heap-allocated fallback uses the minimal size.
>
> We wouldn't be able to fill the cache with the new dynamic object if we
> did that.

Right, that's a good point that there's a tradeoff. I think always
allocating space for IO_CACHED_BVECS_SEGS bvecs is reasonable. Maybe
IO_CACHED_BVECS_SEGS should be slightly smaller so the allocation fits
nicely in a power of 2? Currently it looks to take up 560 bytes:
>>> 48 + 16 * 32
560

Using IO_CACHED_BVECS_SEGS =3D 29 instead would make it 512 bytes:
>>> 48 + 16 * 29
512

Best,
Caleb

>
> > Also, where are these allocations returned to the imu_cache? Looks
> > like kvfree(imu) in io_buffer_unmap() and io_sqe_buffer_register()
> > needs to try io_alloc_cache_put() first.
>
> Oops. I kind of rushed this series last Friday as I needed to shut down
> very early in the day.
>
> Thanks for the comments. Will take my time for the next version.
