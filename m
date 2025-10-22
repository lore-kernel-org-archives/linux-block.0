Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F8D20ADD6
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 04:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761106779; cv=none; b=Gdgl/+b1RM5IGx+iXRYA7yi/IcWMI6fCAaMCsS8PAjKxUPO2PWE8xX9FeqV1AtJOHxltgc/HLxKXZ5x7Kauan+HP9ODBz0Xg7nyNZEKmgPTTJoMZEuyd5iLEMcFue9b9jjWsFd2+h17dgI+E66NVx0jIliUxB9NdsbtIE0h5DuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761106779; c=relaxed/simple;
	bh=EgU8rnXynIPhs/BZsA64otPdBcSY9W7JNRXfkBA9twA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRRS7nzf5R40NMd+1SzAnA4Qi+k8OmtjRPTCksJOO0EAscGknsA7qTSvQQliDeY0/toub1DNtbTH7BKmOJ5Xnucg8Fk+Vt7jUTKR9P/TYbUzNT1eIEA100SLWfZC67lKfVuT3X8b3V5E8jLYDlYRDcst1H/U+i983dGAKCD4C/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZJXU8N1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZJXU8N1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761106776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEB1GkxvFRSrK09fb4q7fCqBnMrGabs898MxIlOczVU=;
	b=LZJXU8N1fNEFr8wjO9uPdXtgWTz+npeJvn6qclp0FwFmOsegSwG9J9nulpqx3SUO1nWO/g
	PqyNQQxiE0bID6FPMx1vEpPYV+XBc7baBDJ2Grtpd4VzMr0bTKvNO4HilwhduBCE1mIwzR
	Qc+DY/SyOlUDuP+1A8lCNWq6jvWX8wk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-T5zi-ecuMyOPq5zwjZ-CnA-1; Wed, 22 Oct 2025 00:19:34 -0400
X-MC-Unique: T5zi-ecuMyOPq5zwjZ-CnA-1
X-Mimecast-MFC-AGG-ID: T5zi-ecuMyOPq5zwjZ-CnA_1761106773
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33dadf7c5beso2755593a91.0
        for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 21:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761106773; x=1761711573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEB1GkxvFRSrK09fb4q7fCqBnMrGabs898MxIlOczVU=;
        b=NiYbp/JAKPZfZ7ns8uKIHEvR+GD7/oh1Ufz+n2C4dJofMTNEyFrkDHbQsG+eO6zl1S
         ElmRo72YyKm+dsFji0n8HlE1uZVxglN8+h9yhcWfOU/o2oa/hYhGqqJ+RJskSPmMoKHM
         sHwfITbnjh2EzqvpSC03BMYWaGH+rEvCZaMC7N0W7o1OcV6B45t6aoQWmlVQF2gqzDOt
         1/MrT1YfGcIhT9kMXChAuKlSkYAkiGjSDtsMoxnmGIRpM61zdkPRzJr3h33EtfMzFrDO
         8QSiv48eRUyBSpLWHvKxgJx3WQPhVkl6vKnjTjllPRTj+Y3YDtnpoQORKGHK0JrBdwTN
         M9xA==
X-Forwarded-Encrypted: i=1; AJvYcCVtY6nrG4Cf9nCRtpvNqiUmVMEhsZlJMCs0ztUOtDCoa/nIJzIrXlKi6hlURho2VAB7ERM1XuBrFi0q4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgjOjkez3F4T4seODGY4vTehe2kAAeR3n79esUhlDrHFyejpIx
	+8f1plKbT1YvyDMHAYPSn7g7xzuL38JhqhSidmmlHTUjBIjI+FZ7rsqAX74eEpfnuoVlHWa69QR
	HtscnQ4jlz+bCyowyZ4YAJr54NekzgYiymVl3uf3eLvPJey+bnC3HrsaUA8pM9EQ2acXNDi00XM
	eq4AAjsLrQMr4XWxKAApBqH65fuWgUlhfl/uWqE7A=
X-Gm-Gg: ASbGncuvgHNtDTEAjhaHYzb7UA3uQ8gNTQSUQIZy6NcO8yO4yXRQcahr3PzqKySfDcd
	IndLYvDHqbF8SNwDMxDDyZcmzyadbRgjiQfcBhFtg8B58MKpZ/GxZcw8DHyQJaZaQhqFNz/FPSt
	UYQNv/oRQDiQaDMNLDkcHQiDuc8b1nivL/hNmqF+9wYEaLjInwEYOvpX9N
X-Received: by 2002:a17:90b:3f10:b0:32e:c6b6:956b with SMTP id 98e67ed59e1d1-33bcf85aba8mr27206993a91.4.1761106773380;
        Tue, 21 Oct 2025 21:19:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxpm190zeS/O7QhosnTZCJ+sJ0OOtUfB8EF+I18t2uJyG2ctlTvkqQPBgMA4jG+/iqib9IAmxZwYBAa++FoXg=
X-Received: by 2002:a17:90b:3f10:b0:32e:c6b6:956b with SMTP id
 98e67ed59e1d1-33bcf85aba8mr27206962a91.4.1761106772999; Tue, 21 Oct 2025
 21:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com> <20251021085030-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251021085030-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Oct 2025 12:19:19 +0800
X-Gm-Features: AS18NWCKmXJHmGDH1OnrtnkNAc2Gt2Hyx92v8bPZ5LqsjBJ7559XCA-Y6f0OWpQ
Message-ID: <CACGkMEsU3+OWv=6mvQgP2iGL3Pe09=8PkTVA=2d9DPQ_SbTNSA@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: NULL out vqs to avoid double free on failed resume
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cong Zhang <cong.zhang@oss.qualcomm.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pavan.kondeti@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 21, 2025 at 07:07:56PM +0800, Cong Zhang wrote:
> > The vblk->vqs releases during freeze. If resume fails before vblk->vqs
> > is allocated, later freeze/remove may attempt to free vqs again.
> > Set vblk->vqs to NULL after freeing to avoid double free.
> >
> > Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> > ---
> > The patch fixes a double free issue that occurs in virtio_blk during
> > freeze/resume.
> > The issue is caused by:
> > 1. During the first freeze, vblk->vqs is freed but pointer is not set t=
o
> >    NULL.
> > 2. Virtio block device fails before vblk->vqs is allocated during resum=
e.
> > 3. During the next freeze, vblk->vqs gets freed again, causing the
> >    double free crash.
>
> this part I don't get. if restore fails, how can freeze be called
> again?

For example, could it be triggered by the user?

Thanks

>
> > ---
> >  drivers/block/virtio_blk.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index f061420dfb10c40b21765b173fab7046aa447506..746795066d7f56a01c9a9c0=
344d24f9fa06841eb 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -1026,8 +1026,13 @@ static int init_vq(struct virtio_blk *vblk)
> >  out:
> >       kfree(vqs);
> >       kfree(vqs_info);
> > -     if (err)
> > +     if (err) {
> >               kfree(vblk->vqs);
> > +             /*
> > +              * Set to NULL to prevent freeing vqs again during freezi=
ng.
> > +              */
> > +             vblk->vqs =3D NULL;
> > +     }
> >       return err;
> >  }
> >
>
> > @@ -1598,6 +1603,12 @@ static int virtblk_freeze_priv(struct virtio_dev=
ice *vdev)
> >
> >       vdev->config->del_vqs(vdev);
> >       kfree(vblk->vqs);
> > +     /*
> > +      * Set to NULL to prevent freeing vqs again after a failed vqs
> > +      * allocation during resume. Note that kfree() already handles NU=
LL
> > +      * pointers safely.
> > +      */
> > +     vblk->vqs =3D NULL;
> >
> >       return 0;
> >  }
> >
> > ---
> > base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
> > change-id: 20250926-virtio_double_free-7ab880d82a17
> >
> > Best regards,
> > --
> > Cong Zhang <cong.zhang@oss.qualcomm.com>
>

