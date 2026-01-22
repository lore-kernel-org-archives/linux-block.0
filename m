Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB63938F230
	for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 02:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769049870; cv=pass; b=EaLya+e3cMBH/+xW5mBNz5Bc7jncuqJuMBBzgLjREc3DHLKEoHR2m6fYYCPphmRSrzwdE1CAJCDgdsh/DLyskEE6k7BSCJcHZ4m2XMVE6VH9I2+3jOrcLRZlpHn8CUAwowhinC2sBsKbipDXcvmsG5sHBcOLqZYiNhWrN/KAAXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769049870; c=relaxed/simple;
	bh=UR97j5oS5KW66h4wusIQPc7uR0tPcNE6widZpyUVWkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IP9oM+d/rUA3PLk8e3/ndrbTK1LBKZNzThrG7uTx8TABG///eSffbIWYwTjBQe6hmmmY6du9+Wvl9aR4q1obutEacZLnBXR+oqkj2hne+Cj5Ax0axxyNzGXwLEs3+ZH0PkrSE+s68jS8ORPu3+NyDCkY0hMAG3YvYZCgZl3aLFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7Epsi75; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7Epsi75"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-502a4e3e611so4400941cf.0
        for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 18:44:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769049863; cv=none;
        d=google.com; s=arc-20240605;
        b=EmmQk1H2SWQxGHAdeqYXRzSRuq6Znbm7NZUk4v3fZtp8eWlFuir20twoR1t1AeDiOg
         ZPcYXRPBGGunCnluqkOYsK5tlTQGlCseXRh2ePuwkYgUgMZL6ohGh1WNyVVTzsKzQZRm
         oDv3DeUsFOI37h69xt35x+huaoaaYryMRT0RSXOFb2RhC/cdc/wLVMrfSUOPllYJRyGU
         /Xb81a7I0Yf5WVgr0taPl7GnXG992/7yXo+EufpjiSv4r4meyq6kLJKdNt3GPQY+pFh6
         IvqrpoFm7P8dGZlEvE5eCn8+zuXF2ZQT8nlL+iH8a7emZjoDT+5WIwaalsovP1ZMXyiM
         epkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eAtbLcPlbXwcqSlVRBCKJrrca7k4pIWb0vsbKliyQro=;
        fh=fZeLfSoaazKb7o27iwZBJPhoGMKz7codVvtv+xUTvmY=;
        b=H0tZHp/Qy/2nJ8ZKzS245Z/GevyWOLDPHLJUgXEbmRpN1Gsj6Bietb/hfR4BQeTCLs
         gt2E7mn33Lwija287GVAvfxrbcz2E9ano/EZFJxophvdbHbstdF0rtkAheM86KPgUO3N
         psUcG7ySPsCTmteUt/obJag0ped2+iSoJRvhUn7/5d7/NMBwTNV5lhlbUeuK/+UIOZo9
         VzR6QxnMDnlo6HZuYr0jIn/izrtWVnPkuDQecLH/nagZ8TLJvsNR98AsOZ18XXZCJ28V
         +zA1odYzyJQWVpZzMLIe4IbLf041YUNk20HYDq3ZSiqec5CpdPfB3wjKzt6/XJWY9Nf3
         nptw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769049863; x=1769654663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAtbLcPlbXwcqSlVRBCKJrrca7k4pIWb0vsbKliyQro=;
        b=H7Epsi75Rhhe3nOnSKPNhy+aGuyneoCLXvwxkcCaSBJWM3fnwt9ZpqEnBXNSH3kXj2
         bU1A8VXiG6VkfoILDNo91BUSR09z/F/UI1rc5npHSqteJkJBrad/i+1uHDsNPqoK9mqE
         jucFluvAejkTaGTolTPXa0MYtCjeIDisagMfuzYtjo3+/vTsxx45LiE9+H6jm/NMTmzo
         w8KFQecrL/Nr/RODNxytPumaA8QduwKH5oNWk3DJlylLw0uy4A6+Ontha4K+WTFb1T8x
         3PNx+C6kREeQSc1VMfvfA+EzHBUKWjScpb5f8lkIPx6uMF0d77H4JSVx7BHxLZWD7xxQ
         Ig6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769049863; x=1769654663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eAtbLcPlbXwcqSlVRBCKJrrca7k4pIWb0vsbKliyQro=;
        b=wtZdsX7kbidRzq2sDPIlpeAOwKNp+9ndGbeZGautVoFzaGEhkfBENNSMQx/zopjnti
         sdJqUk91RlgRXqGfittJa/d0XFdMG2obUZwrWXGCyeOZDKm05Bjn7dDcwis8SdC5OkY3
         A+72JYiuNhVoGHYwSaXlmRSE3Fy+owJVNt3rKOv8hdmKr2JZYAPVrfEVFfQbDEk41CzK
         AxjauGLyLN2C+jMsI+r7cmPaoS7kay2obLVqAevBiP3a59rpICk1mq4m+KyPqeqNSs7c
         uXrS+NXYSLUFLhJjEBVAGm4mJOP0o+yHXMlNSsRKvwumhoReXkHkYcp7UistKoxKPv/c
         sTEg==
X-Forwarded-Encrypted: i=1; AJvYcCWH51s0xRECZaj3MYmrbnWkdDm4fEOb1kemIaCv9lSCbLU7wbexRdg8W4gQYapSuGN2NzzFmqNCqcgstg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbx9KRNYi9UFv/t0idiisbb+ijeqXAEcIBJlvjij575Fm1vE+U
	bKBLlMJxJjpoc3mw05gFZEPpOz2SN/caVzUeGEzyUgvjI0xO5X1C+97iGBW8sjB3JtB1Ln8KTu9
	uo3+i6us6U5/Dy41kUsxE4WtbFtyha7E=
X-Gm-Gg: AZuq6aIG7F8SNW5RhfVjeo9mjWG2WhD2P1tMdseQMrHHpW0ovYao8Vkw26b6z590Wj7
	Vhub4cfKldW1pdirh5dtuIVxicKxVmy81KlFAq9R17sC5OeMO7+/2DX5qLX1V9Yj1A2k7yp3sWR
	0YpFhKKw2Iu6kr6xsp43XgbSp23OUdZTO9RDColEetHgVDJJSUpSYwsxTpfEssRpUXQEbhZw/ea
	1+rCmachUGGZatIR5bArTwLQioahozhzSmV8W3Mgo16aad6M2mtOzSroVlrlihIIJktDg==
X-Received: by 2002:ac8:7c43:0:b0:4ed:bc0a:88c3 with SMTP id
 d75a77b69052e-502eb5b14b5mr24575241cf.33.1769049863440; Wed, 21 Jan 2026
 18:44:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-11-hch@lst.de>
 <20260122004451.GN5945@frogsfrogsfrogs>
In-Reply-To: <20260122004451.GN5945@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 21 Jan 2026 18:44:12 -0800
X-Gm-Features: AZwV_Qg4LxBvht9EBcr0hoT1-gc5FWfx00BC6aQnC2V2vC-gMfVpk6AU_v2RXiM
Message-ID: <CAJnrk1YAbcODi8pkG9XawciDpaHqdbZE+ucji73D_F=Jv1kQXg@mail.gmail.com>
Subject: Re: [PATCH 10/15] iomap: only call into ->submit_read when there is a read_ctx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Carlos Maiolino <cem@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 4:44=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Jan 21, 2026 at 07:43:18AM +0100, Christoph Hellwig wrote:
> > Move the NULL check into the callers to simplify the callees.  Not sure
> > how fuse worked before, given that it was missing the NULL check.

In fuse, ctx->read_ctx is always valid. It gets initialized to point
to a local struct before it calls into
iomap_read_folio()/iomap_readahead()

>
> Let's cc Joanne to find out then...? [done]
>
> --D
>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/iomap/bio.c         | 5 +----
> >  fs/iomap/buffered-io.c | 4 ++--
> >  2 files changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
> > index cb60d1facb5a..80bbd328bd3c 100644
> > --- a/fs/iomap/bio.c
> > +++ b/fs/iomap/bio.c
> > @@ -21,10 +21,7 @@ static void iomap_read_end_io(struct bio *bio)
> >  static void iomap_bio_submit_read(const struct iomap_iter *iter,
> >               struct iomap_read_folio_ctx *ctx)
> >  {
> > -     struct bio *bio =3D ctx->read_ctx;
> > -
> > -     if (bio)
> > -             submit_bio(bio);
> > +     submit_bio(ctx->read_ctx);
> >  }
> >
> >  static void iomap_read_alloc_bio(const struct iomap_iter *iter,
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 4a15c6c153c4..6367f7f38f0c 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -572,7 +572,7 @@ void iomap_read_folio(const struct iomap_ops *ops,
> >               iter.status =3D iomap_read_folio_iter(&iter, ctx,
> >                               &bytes_submitted);
> >
> > -     if (ctx->ops->submit_read)
> > +     if (ctx->read_ctx && ctx->ops->submit_read)
> >               ctx->ops->submit_read(&iter, ctx);
> >
> >       iomap_read_end(folio, bytes_submitted);
> > @@ -636,7 +636,7 @@ void iomap_readahead(const struct iomap_ops *ops,
> >               iter.status =3D iomap_readahead_iter(&iter, ctx,
> >                                       &cur_bytes_submitted);
> >
> > -     if (ctx->ops->submit_read)
> > +     if (ctx->read_ctx && ctx->ops->submit_read)
> >               ctx->ops->submit_read(&iter, ctx);

I wonder if it makes sense to just have submit_read() take in the void
*read_ctx directly instead of it taking in the entire struct
iomap_read_folio_ctx. afaict, the other fields aren't used/necessary.

This patch as-is makes sense to me though.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks,
Joanne

> >
> >       if (ctx->cur_folio)
> > --
> > 2.47.3
> >
> >
