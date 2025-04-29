Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981002FB2
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 01:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745890742; cv=none; b=tKJ1ys3h6iloQA4bDgntbXkDiCLAFlJ+qk6+HYjgMMFKk/HKn8M1Y08I2+EHAsOtgdoiRJJZgL2V3nHdtPz92Gu6xjUo9RVm6A1IhXQDklrH5lxiu79P8pEw46Xfyj6dFHTgX4itq5CNMjg72qv9RSm+qt1Gz0uB0hW4u3FA5V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745890742; c=relaxed/simple;
	bh=xryzTqB5n/UH4p0Qu5M1iIFoYmGG+nNTbZO0s3WmTf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLA8SfG8p5WMX7AiJ0L0irkVp34+gn5LZmGbb7hQgkJqmhAjgjpAfw8lZgFsXb3OgW6TN738xr+cDcifFhPZ9nuq/PK5vx9avLtz70zv05ThdoHe/Rxr7+ATUOzEl1ZRUSeUOdiPqMmk3kvwq7AloVDC0vLTLo5cJzz6pDRLw6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XVsUr0nC; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XVsUr0nC"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736c8cee603so535629b3a.1
        for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 18:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745890740; x=1746495540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPslriOkEvhefBRQkFVEFT+YSJZ3pLDNZnAHYqb3FUo=;
        b=XVsUr0nCquvSzwvlKMdMlBuCw3O2Dea74QQ1Gi1TS2vSDsIE/plQ3qbyKEWEPbeUQI
         2IM+62iuFGRhkTS7VoczfiQHuQxtITzcafZ6tu9/q0+h4jOZYQ0DjT8elQHU0fciLvNr
         bdOnDJaMmGC5R+EMehy03AXapdzz7wrccB169U1O/Z62Qp2tt9kNskY5VOd69HcVmPHh
         zS0bhdJpyxtt6auJFebclHx+AysbHJBH7fSo+SHahSW4HAJvChmGPOH+GQ92cOmF/9Vv
         CgUy1LE0btTjr8EhmjiO26BvlZqB5eanri+U/1XDNUXbmpigJnDEzVkSUTwmtWQOPlJ1
         Z7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745890740; x=1746495540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPslriOkEvhefBRQkFVEFT+YSJZ3pLDNZnAHYqb3FUo=;
        b=c+Pfsld4+9kqVBJixwEkX0n7iQqEpImXReyo+Zpl4r0uA9ZtQ0e0OAqBOKM9mGS2rp
         pRGi3flM8AjLicv9/Msm9nptXVb14bZ/Av/Q+JDwdPcEoHnY7E617bK3lHl3n1I29WV0
         EfUimpsIV+1WwgLrpPfTb0UmzjHoky1GK5GWfDLiqIAW8Zy4yIDWMWFjBxLavCIyrjhI
         a4hJbwWEsvpSLrLbEfDR7tgjES3xpIZ1xn8L/t1rFNxlulSbBYpOxT2fFtuuLKkdjQzh
         /SZIBc2mprN5iy/uqvSPLpazz3qy+/OMPFGnyogYI2oLOnMdvuEdo9X5FJZV8YDCk401
         3aOg==
X-Forwarded-Encrypted: i=1; AJvYcCUo8p2pwKO87zNSd32FhapPlnu3kgCCBVoGTi3dGRFZrrOKKhHjZkgVXWyYqZ53r+ywXrBbBi1cAeGl4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzY6WVjuo6pootDA4qkAErTBqoXotpOVzzi4336UWGX2lVbbkmP
	QiU1RZlhe9FjjljRTDSqdg8Bl6+f5PgVrbp2V4zaH9iahg4Mo3HKIbRLAELeqgp4lAmhjfg1k00
	4kYET+56dSHYvVgh9YXRIQAFdmUPE3dPBygxlAm58GBRijKo4enI=
X-Gm-Gg: ASbGncu3tcK3WNH+P79uZ4RQb1Hvtu+mR7IUikE1NzaZm32kky8mjfjRyiBpdvU0ekr
	XDh76DMEmiPie2/yt1Meshdx9kxZD/Df9r7/2bi2xfbZknC5f5XRvoKaZ2Aq1PMfz3lA89ZZjXj
	6CbXKy0eDi6ZbppTOUGPwz
X-Google-Smtp-Source: AGHT+IHlt3vaK3BliTnw0lI+Ms8NzrqZUrhNlyJ12QRDWbUcQa+5VsGoQpeDOY5/5ZvA15HNNRKeXOyLkblnIxiWR74=
X-Received: by 2002:a17:90b:2248:b0:2ff:7970:d2bd with SMTP id
 98e67ed59e1d1-30a220e1803mr780794a91.5.1745890739528; Mon, 28 Apr 2025
 18:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427134932.1480893-1-ming.lei@redhat.com> <20250427134932.1480893-3-ming.lei@redhat.com>
 <CADUfDZq4m2ndHPmbWnECXWCYO_o7X-ys37=10gqMMYcO+xEJhA@mail.gmail.com>
 <aBAjlJXxz97F4ZOC@fedora> <aBAtIf4cvR_Xd9Hb@fedora>
In-Reply-To: <aBAtIf4cvR_Xd9Hb@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 28 Apr 2025 18:38:48 -0700
X-Gm-Features: ATxdqUHOugEPJ7XizH789e8LR-t8STK4nLoLEL6uSVgCP0Eytr-k_pXVtsliydo
Message-ID: <CADUfDZoUVe0CJ_1nrUE2y6xehoTMP0_w_mc9or5AB4y2pzx5pA@mail.gmail.com>
Subject: Re: [PATCH v6.15 2/3] ublk: decouple zero copy from user copy
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 6:36=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Tue, Apr 29, 2025 at 08:55:48AM +0800, Ming Lei wrote:
> > On Mon, Apr 28, 2025 at 09:01:04AM -0700, Caleb Sander Mateos wrote:
> > > On Sun, Apr 27, 2025 at 6:49=E2=80=AFAM Ming Lei <ming.lei@redhat.com=
> wrote:
> > > >
> > > > UBLK_F_USER_COPY and UBLK_F_SUPPORT_ZERO_COPY are two different
> > > > features, and shouldn't be coupled together.
> > > >
> > > > Commit 1f6540e2aabb ("ublk: zc register/unregister bvec") enables
> > > > user copy automatically in case of UBLK_F_SUPPORT_ZERO_COPY, this w=
ay
> > > > isn't correct.
> > > >
> > > > So decouple zero copy from user copy, and use independent helper to
> > > > check each one.
> > >
> > > I agree this makes sense.
> > >
> > > >
> > > > Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >  drivers/block/ublk_drv.c | 35 +++++++++++++++++++++++------------
> > > >  1 file changed, 23 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > index 40f971a66d3e..0a3a3c64316d 100644
> > > > --- a/drivers/block/ublk_drv.c
> > > > +++ b/drivers/block/ublk_drv.c
> > > > @@ -205,11 +205,6 @@ static inline struct request *__ublk_check_and=
_get_req(struct ublk_device *ub,
> > > >  static inline unsigned int ublk_req_build_flags(struct request *re=
q);
> > > >  static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_que=
ue *ubq,
> > > >                                                    int tag);
> > > > -static inline bool ublk_dev_is_user_copy(const struct ublk_device =
*ub)
> > > > -{
> > > > -       return ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPP=
ORT_ZERO_COPY);
> > > > -}
> > > > -
> > > >  static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
> > > >  {
> > > >         return ub->dev_info.flags & UBLK_F_ZONED;
> > > > @@ -609,14 +604,19 @@ static void ublk_apply_params(struct ublk_dev=
ice *ub)
> > > >                 ublk_dev_param_zoned_apply(ub);
> > > >  }
> > > >
> > > > +static inline bool ublk_support_zero_copy(const struct ublk_queue =
*ubq)
> > > > +{
> > > > +       return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
> > > > +}
> > > > +
> > > >  static inline bool ublk_support_user_copy(const struct ublk_queue =
*ubq)
> > > >  {
> > > > -       return ubq->flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO=
_COPY);
> > > > +       return ubq->flags & UBLK_F_USER_COPY;
> > > >  }
> > > >
> > > >  static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
> > > >  {
> > > > -       return !ublk_support_user_copy(ubq);
> > > > +       return !ublk_support_user_copy(ubq) && !ublk_support_zero_c=
opy(ubq);
> > > >  }
> > > >
> > > >  static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
> > > > @@ -624,8 +624,11 @@ static inline bool ublk_need_req_ref(const str=
uct ublk_queue *ubq)
> > > >         /*
> > > >          * read()/write() is involved in user copy, so request refe=
rence
> > > >          * has to be grabbed
> > > > +        *
> > > > +        * for zero copy, request buffer need to be registered to i=
o_uring
> > > > +        * buffer table, so reference is needed
> > > >          */
> > > > -       return ublk_support_user_copy(ubq);
> > > > +       return ublk_support_user_copy(ubq) || ublk_support_zero_cop=
y(ubq);
> > > >  }
> > > >
> > > >  static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
> > > > @@ -2245,6 +2248,9 @@ static struct request *ublk_check_and_get_req=
(struct kiocb *iocb,
> > > >         if (!ubq)
> > > >                 return ERR_PTR(-EINVAL);
> > > >
> > > > +       if (!ublk_support_user_copy(ubq))
> > > > +               return ERR_PTR(-EACCES);
> > >
> > > This partly overlaps with the existing ublk_need_req_ref() check in
> > > __ublk_check_and_get_req() (although that allows
> > > UBLK_F_SUPPORT_ZERO_COPY too). Can that check be removed now that the
> > > callers explicitly check ublk_support_user_copy() or
> > > ublk_support_zero_copy()?
> >
> > Yeah, it can be removed.
>
> Actually the removal can only be done after the 3rd patch is applied with
> zero copy check is added.

Right, I just meant it can be removed in this series.

Thanks,
Caleb
