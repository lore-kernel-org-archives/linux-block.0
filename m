Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3161DF73A
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763404215; cv=none; b=ufqiBxhWpAfUCyjLYhtteQkMchxFrbaNIpeWjDFfy1rXa4nD03HSpiWktPcPNU8MMTYvm/+eRcKmUb1PADPRf1yt6DZORrVHLjipdBDBhFCgBU9PtDHQC21eXAj0CIeN31mlGoO/7tF/pCY3zCOKP9/DfGLzboWvVoF33M1cIS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763404215; c=relaxed/simple;
	bh=6ACO230Z61PzkEJMH+xQVxXum9C9jJAnmzUzGdKHsdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZwAmtYjBWwU877A4Sj88Fx3uKJSzuVYrHNVtBQcP8WqGGxfyG5an6GcVuKz8EYvqyQNRiXlkqMgTt6py3/MjH35o0XGvO5AaU7/UVXN1eOUBfZMFeSIPbDGMHget0wsMyQwmJSjpLofyxcQPXjTD9EOT2tGjWMCXLc9DHeLK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cbFUrs5W; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cbFUrs5W"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297ea4c2933so3295675ad.0
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 10:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763404213; x=1764009013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzaCLoEtUwEPf+UCdRCiyccMjBUBRj6w3HifvChgOxM=;
        b=cbFUrs5WT43Oh+EcgfPXNavuOnsZRDb/fSwUGCUS5mSSyceLFI3x6j0QQu01TCRoKE
         q3HQGcoufyGYn4QkLJvGdO1h1n7I6Yp7bEQj2Umy4ZOCJquY2P4JC0C6grl837AvMERQ
         2dfWJkxSbIpIhvN9zUazgex0mut8J/ymOlr7Fdv7uV0mLsxq12RPEpQHvLuAmXbZR4CZ
         aE3vLgqA/Fqimv1qBfCmDbuLNRwCbu0sy/PMr6Uxo+hL5f0YdDlHoBkx3VTGsDvQEaSX
         qzDlSqlgbI1qokiPu4JJmHjlKPbylyN93lFfSiettD3XLcK5I9rX4Y+SePTTb4a24M0B
         Ah7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763404213; x=1764009013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MzaCLoEtUwEPf+UCdRCiyccMjBUBRj6w3HifvChgOxM=;
        b=oScfdd3FNaTQb8qTHgsCY840PxOTgh50Zi4MtBfxhSLjYjG66UIR2LgXjwbVCgc8hq
         0DmaFAitoilgreNBbL6QLFJtmzQ1Yy+1aDYFr/iiun0+Z3gALf7pGtxgPa1UPYVpwILb
         Q4Wcs4KdBZ+ld2j8H3I/niEoasRjri1WE3bX38p+Hj+reMvjb7+kGJQ8O7Szvxq4bppZ
         mKVDdteryjHuAbCQYDpHGIQiiESbELcvgwKdgfMKjALITVgzUWQOLWPP5rku4mxfEXef
         xg/6CvOlXQGH9PHAxVyyPvWKBReOXwjk4XlTmCS8DJxpaeNbA6taoFgVA+94mV5vcExc
         Z7Fw==
X-Forwarded-Encrypted: i=1; AJvYcCU8loScMvwaY1XyVgDZFql6ZBfcVthsVeYRqUqFnLsemCucdCdGwnjZA4XhYaEOvE9wqzgewZbg3KTkrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhr6EK6TxAub/zn6hYa1ET67lTmq4dgTqa5FYA2FgeHbyKyqWH
	AhSMvPHzpqnf6TdLsQ105+u7KXRHIPWnsp+yXFytMUoBqdbud0KLx6FPS7Zw63sW2/6alUzz3pX
	s1E/Q8WRHLvi0YGXPkeJI8P5dUZACApKXC513mjvhkQ==
X-Gm-Gg: ASbGncuNqtYHO2LeLQLysxBGEQTMGgxVUQqApNzdr2WFons/Uw6uPePWwzlCgESyzyB
	BgJbNDm63LXd9p4+2XSkPzeMZ5SPF6fI00YmKod+GYn1pMrmedZE8bEqZH6/6xB49uzbkTIsHQJ
	fp0jiHCuOM+4sACo/EMIzs2LSIBbER4HLpj6t/dheyh5uUX+EB6/4l3E04Xr+4lMOIPIqJ70C/d
	dDe40nRpPBEtQFnnoDCBC8ej7OPeVhhNZp5lCPv9Q8be4HKpIwMbRk5j/OZlOrMmZeie2Sb
X-Google-Smtp-Source: AGHT+IEtM3Vl6x6oK5FA4rFU6auMdZd0ElEgFDKV7JJBxw7qeWJA8ehrZUnspnptnJ/JZdt74s/qU9MAmBacxjKRaK8=
X-Received: by 2002:a05:7022:61a9:b0:119:e56a:4ffb with SMTP id
 a92af1059eb24-11b40b36d09mr5551624c88.0.1763404212565; Mon, 17 Nov 2025
 10:30:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112093808.2134129-1-ming.lei@redhat.com> <20251112093808.2134129-7-ming.lei@redhat.com>
 <CADUfDZoSiEjY0w7V1j09u1B=quJsizYKjOBQAGW61PcFtog7GA@mail.gmail.com> <aRm9QLOI5LT9w-HB@fedora>
In-Reply-To: <aRm9QLOI5LT9w-HB@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 17 Nov 2025 10:29:59 -0800
X-Gm-Features: AWmQ_bkRsJSsk-n1xsukAj908zqwqW--F6sUHHiL4W4gqCShgEEhBKw4BVClpjs
Message-ID: <CADUfDZoAFQNR4h32b8J4hqEQhLBupeW213h3pT6d6-dZcHk6Qw@mail.gmail.com>
Subject: Re: [PATCH V3 06/27] ublk: add helper of __ublk_fetch()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 4:02=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Fri, Nov 14, 2025 at 09:21:53PM -0800, Caleb Sander Mateos wrote:
> > On Wed, Nov 12, 2025 at 1:39=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Add helper __ublk_fetch() for refactoring ublk_fetch().
> > >
> > > Meantime move ublk_config_io_buf() out of __ublk_fetch() to make
> > > the code structure cleaner.
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 46 +++++++++++++++++++++-----------------=
--
> > >  1 file changed, 24 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 5e83c1b2a69e..dd9c35758a46 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -2234,39 +2234,41 @@ static int ublk_check_fetch_buf(const struct =
ublk_device *ub, __u64 buf_addr)
> > >         return 0;
> > >  }
> > >
> > > -static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *=
ub,
> > > -                     struct ublk_io *io, __u64 buf_addr)
> > > +static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device=
 *ub,
> > > +                       struct ublk_io *io)
> > >  {
> > > -       int ret =3D 0;
> > > -
> > > -       /*
> > > -        * When handling FETCH command for setting up ublk uring queu=
e,
> > > -        * ub->mutex is the innermost lock, and we won't block for ha=
ndling
> > > -        * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
> > > -        */
> > > -       mutex_lock(&ub->mutex);
> > >         /* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
> > > -       if (ublk_dev_ready(ub)) {
> > > -               ret =3D -EBUSY;
> > > -               goto out;
> > > -       }
> > > +       if (ublk_dev_ready(ub))
> > > +               return -EBUSY;
> > >
> > >         /* allow each command to be FETCHed at most once */
> > > -       if (io->flags & UBLK_IO_FLAG_ACTIVE) {
> > > -               ret =3D -EINVAL;
> > > -               goto out;
> > > -       }
> > > +       if (io->flags & UBLK_IO_FLAG_ACTIVE)
> > > +               return -EINVAL;
> > >
> > >         WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
> > >
> > >         ublk_fill_io_cmd(io, cmd);
> > > -       ret =3D ublk_config_io_buf(ub, io, cmd, buf_addr, NULL);
> > > -       if (ret)
> > > -               goto out;
> > >
> > >         WRITE_ONCE(io->task, get_task_struct(current));
> > >         ublk_mark_io_ready(ub);
> > > -out:
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *=
ub,
> > > +                     struct ublk_io *io, __u64 buf_addr)
> > > +{
> > > +       int ret;
> > > +
> > > +       /*
> > > +        * When handling FETCH command for setting up ublk uring queu=
e,
> > > +        * ub->mutex is the innermost lock, and we won't block for ha=
ndling
> > > +        * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
> > > +        */
> > > +       mutex_lock(&ub->mutex);
> > > +       ret =3D __ublk_fetch(cmd, ub, io);
> > > +       if (!ret)
> > > +               ret =3D ublk_config_io_buf(ub, io, cmd, buf_addr, NUL=
L);
> >
> > This changes ublk_config_io_buf() to be called *after*
> > ublk_mark_io_ready(). Is that safe? It seems like io->addr could be
> > read in ublk_setup_iod() as soon as the ublk device is marked as ready
> > for I/O.
>
> disk can't be added unless acquiring ub->mutex, so it is safe.

Okay, I see what you mean. ub->mutex is acquired after
wait_for_completion_interruptible() in ublk_ctrl_start_dev() and
ublk_ctrl_end_recovery() before allowing I/O to the ublk device. Then,

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
