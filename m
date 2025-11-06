Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4972D23B9
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447761; cv=none; b=OqHefgbALy6TIWtLL7pz28APuy+qXeavi1Hui5heb/LzMGwlw3kYzbD8A6Q3q9X8EFj4mSSSvjB4V2oZZ+siNycReUaVpOsClb4DpmpDZSqJ7qtjHfUntmEKbo+yzFdAOv285sOs/rnTyL1xG9Z6yUuIDvNreP6HLvzU26zdSF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447761; c=relaxed/simple;
	bh=5BPkPQQte4G28kUKXP7jNkgzYLVqSvlQdB/LoF8pVGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzWOg/HL6kuDDMbZt9UcPd4szN5IX/wHiDIWBZjzMChOOh7gT7FRDY/7SlxfiWycO3d7RWAASGJ+axrHRNmSx9ka3DRuCKNzCVk5QvuUz94fWiAuYdHamtKPZPogq9tgp4QjqNLjHQh7gHhtBWpkmwQPjrKnytXeRQhRAHtnRQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=aeiauzw7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="aeiauzw7"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-295395ceda3so1417545ad.2
        for <linux-block@vger.kernel.org>; Thu, 06 Nov 2025 08:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762447759; x=1763052559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SczTyzt+6IIPWQ1HMqgPPEu+3NB4N6lu6tfW61vk03Y=;
        b=aeiauzw7Ug4EGYy6Wr5KrgJgsqybQLwHS0xrDh947qe9CKVH/h5PdQDhan8pji0uh8
         2R2b7WuzFauK7/T0JQVBryJZ289j2nG69Dc1GYX//46sAuotDAcsiKlzQjopykygno3j
         WlNd+atCMwGyHk2n0Fxgn5pEjvkBC9/oWx/vd29O+HkbtAVhHIMhsebW/TgMom1qjp/K
         0Kv1FADjeFiZWxtRtGfSBILcyZkL7EkA9v3uX3JYlqpc+IJ33+7wdZ98WkdUipYXdbdy
         vT9FyK1vPcljmGuRPxs+ET7p4BV8V8Bej6ybKLs9XuGJw/71wrJuxJcqFNy1rzRrrd3b
         7+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447759; x=1763052559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SczTyzt+6IIPWQ1HMqgPPEu+3NB4N6lu6tfW61vk03Y=;
        b=lgGdJlC5m5P4Qg3xZSnv1TDQcUkFkTojtUh/pyyk2xeJZuIK5zxx+NZzy63ThK9Jl0
         2wJ7nYE1Omiyh1iZsUd8Q387LS7inedcl2oBBLWF4m6tycZg6mARuK4c4m6U1isslnb0
         asBXAZYoO8S/6HdgzkVchbzA9zRUxKtBe9TYxjZMjdngv9hqZU0aY/EWpRlGqdNKEdBB
         gP1yBCJnZDWYU7NwdWvzHwNb3dQpxhrRZOrmC4o6paPhfybB1yni49xafwuzx8GNEfZ9
         839v6wnodPQeRg3xBLYzUuTRZsbMFRSZS0emfhUDBcTI1wz4+Q3HmNYV59/Bs95Dq3l9
         js/w==
X-Forwarded-Encrypted: i=1; AJvYcCXkJoWeYv8+JN/IC1XF7ziSKl686jxARynd1BR7CBiBX00h04w8ci3A6stLKr1GtVynM+lES7HaJN0NIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQVAiGg5VyUQCPd9IgLL2Rh3IF7tGPlcW0iKZcqTpzFNbrDHI
	HM2FlBbqzO+vKuUi53sxtwuXNC2gz39IzMPyUKodRdziqsAKKpc091tG9hUGg215kscZ9n/EHZE
	EyrB8rbwIUrPC4mC4W5XqBQZAkcG7VIzmCjjyNt21pw==
X-Gm-Gg: ASbGnct847CtRfdpXLGt8z7OwZwI0wPG/v4fV/WzR1V57FiOjSuE5Vlc6zPoBAAwmfu
	+mhy9F/TZ0/Z2R3hAtqjWrSfRuYhymcbZEO4fHucxHpzEvEHZbNRVlZQMRLKIRtptHds0iKLwX5
	xpCCB9+DWfBcOQ8vQCD0Zq/GB62IE60b/PXEJfeN2431hkySwoakdH62Cy69SIA7qf6Ms5z+JmM
	R3aYIxXVVssIznveY0Qs64LBeUmBmTYh+xIf7OVsiXQ6B62famOrJIHPrRM/63DmwUCBJTE0cjU
	MnN0fPKrAzEhlggbJXQ=
X-Google-Smtp-Source: AGHT+IG+VJgBurUuRaoHFeElA3ww13b2pdW9jZ1rmXSb4lXIbFB/JQJjQwhVJGoxQwk4v6RgB2FCuAc+oh0P0sQeJgk=
X-Received: by 2002:a17:903:183:b0:290:ad79:c617 with SMTP id
 d9443c01a7336-297c038e94dmr1135875ad.1.1762447758581; Thu, 06 Nov 2025
 08:49:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105202823.2198194-1-csander@purestorage.com>
 <20251105202823.2198194-3-csander@purestorage.com> <aQwjvu-bFZRT-8Ol@fedora>
In-Reply-To: <aQwjvu-bFZRT-8Ol@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 6 Nov 2025 08:49:05 -0800
X-Gm-Features: AWmQ_bkhP150tPSs9ogACQ31l-vCnwULMm8lXvcaEuHxWviVQoTkfsJ7PTWALcY
Message-ID: <CADUfDZq-CPJdDdtJMH7imu2rMUffJYdyFZHFyePni_Rf-AdBtw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ublk: use rq_for_each_bvec() for user copy
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 8:27=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Wed, Nov 05, 2025 at 01:28:23PM -0700, Caleb Sander Mateos wrote:
> > ublk_advance_io_iter() and ublk_copy_io_pages() currently open-code the
> > iteration over request's bvecs. Switch to the rq_for_each_bvec() macro
> > provided by blk-mq to avoid reaching into the bio internals and simplif=
y
> > the code. Unlike bio_iter_iovec(), rq_for_each_bvec() can return
> > multi-page bvecs. So switch from copy_{to,from}_iter() to
> > copy_page_{to,from}_iter() to map and copy each page in the bvec.
> >
> > Suggested-by: Ming Lei <ming.lei@redhat.com>
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c | 78 ++++++++++++----------------------------
> >  1 file changed, 23 insertions(+), 55 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 40eee3e15a4c..929d40fe0250 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -911,81 +911,49 @@ static const struct block_device_operations ub_fo=
ps =3D {
> >       .open =3D         ublk_open,
> >       .free_disk =3D    ublk_free_disk,
> >       .report_zones =3D ublk_report_zones,
> >  };
> >
> > -struct ublk_io_iter {
> > -     struct bio *bio;
> > -     struct bvec_iter iter;
> > -};
> > -
> > -/* return how many bytes are copied */
> > -static size_t ublk_copy_io_pages(struct ublk_io_iter *data,
> > -             struct iov_iter *uiter, int dir)
> > +/*
> > + * Copy data between request pages and io_iter, and 'offset'
> > + * is the start point of linear offset of request.
> > + */
> > +static size_t ublk_copy_user_pages(const struct request *req,
> > +             unsigned offset, struct iov_iter *uiter, int dir)
> >  {
> > +     struct req_iterator iter;
> > +     struct bio_vec bv;
> >       size_t done =3D 0;
> >
> > -     for (;;) {
> > -             struct bio_vec bv =3D bio_iter_iovec(data->bio, data->ite=
r);
> > -             void *bv_buf =3D bvec_kmap_local(&bv);
> > +     rq_for_each_bvec(bv, req, iter) {
> >               size_t copied;
> >
> > +             if (offset >=3D bv.bv_len) {
> > +                     offset -=3D bv.bv_len;
> > +                     continue;
> > +             }
> > +
> > +             bv.bv_offset +=3D offset;
> > +             bv.bv_len -=3D offset;
> > +             bv.bv_page +=3D bv.bv_offset / PAGE_SIZE;
> > +             bv.bv_offset %=3D PAGE_SIZE;
>
> The above two lines are not needed because copy_page_*_iter() handles
> it already.

Yes, I realized that, but was trying to avoid the error in
page_copy_sane(). Though it sounds like updating the starting page
isn't sufficient, as the bvec may still span multiple pages.

>
> >               if (dir =3D=3D ITER_DEST)
> > -                     copied =3D copy_to_iter(bv_buf, bv.bv_len, uiter)=
;
> > +                     copied =3D copy_page_to_iter(
> > +                             bv.bv_page, bv.bv_offset, bv.bv_len, uite=
r);
>
> WARN in page_copy_sane() is triggered because copy_page_*_iter() requires
> all pages belong to one same compound page.
>
> One quick fix is to replace rq_for_each_bvec() with rq_for_each_segment()=
.

Sure, I can switch to rq_for_each_segment(). But then there's not much
point in using copy_page_{to,from}_iter(), right? It allows skipping
the bvec_kmap_local()/kunmap_local(), but incurs additional overhead
to support copying multiple base pages within a single compound page,
which rq_for_each_segment() will never produce.

Best,
Caleb
