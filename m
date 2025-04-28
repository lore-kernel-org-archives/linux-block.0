Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A69223338
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860430; cv=none; b=FcgT4KrOdMzoyZI3eAFFxRYRn/1qYs8uvUOcKKsbklhgeUOcsc9MK32CDmJfZx2DV2kp2n1HaLS39J3I/vgfHR2yW1DKV+jUlekDqrk9t1bqvs3lsKwrfDe2La6jwotOQ3qY+YriAy4Lsi6KJLtv2dk3zrN8EjZDAVriDYcrUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860430; c=relaxed/simple;
	bh=cgy8AVyfjzbaafjFGFIbiknfud7IpvHZ1FuIvqmcbdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIQI2+Kts0jcY3vzOb43YntjFWwqWvT1/VNJvkHIOxPNKWwP1l5XvhndwHDzY/r10dsJJ73tNTe5fFj7DA2hS0IMU1RBCPOGTCI/YitqoNzzf/fDYnYTBjf4Y7cAnn3cI6oSiqbEiJUQLZIJpJdNdRFgEpZRltUjP80oJWLp9Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=L2sdJm/i; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="L2sdJm/i"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b0ec7f3a205so294926a12.3
        for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745860427; x=1746465227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+O9hcnTfcLYnXLthbpKEzAnUbGOzzp38HULK9utAvg=;
        b=L2sdJm/ixu3CiZLUCbrX3fvtYIxefgHWI17YZ9NxS8XqMYBDI7icFtQwaSnS8qqhfE
         25DxvrAic5AgBl4as5zBomnFvoBsc/WK/a+SVKVdswPXU5EiERt08qRxnuDJha7BWMQm
         pajfmjumNDDPZzzKH8xGxUzxYb4Y7r91bExKnQagzYAbf3RMTrRtaGeXhBF71NHhls1e
         C+3bupLsd27aGq1nrisupwCm53cvdjFily6EmLFTJLLXQAKOG7CdOLIXGVpHQuuMvn7q
         xuBUpIlwF3lm/e3iHjRc/sIGW3b3l6Ha5vdGzE7or2PGYMHnpoEjZl6UK/qhXnwq4cNp
         Ystw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745860427; x=1746465227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+O9hcnTfcLYnXLthbpKEzAnUbGOzzp38HULK9utAvg=;
        b=CuaFJkJ+I05Mtfo4aqO1AkdrhJQ/GYvFGQWy82bS1ahv8FmhFJLzvKpf/GGoOiB6qe
         2aADUkUg490xiqhb/ySZVOuGTQMhRniGBsBjYetLqy7gILNypFauUVFXrKYYV0sfazCG
         k7k6qgj6MFl6h5exebHaBNV/4guzUJYLHK+3Y+10fZooBS28h+zGbrPtErirxwZQN3S6
         zHUgq7mVVNyz2c4bDgNy/eW1wi5Cqc+9F/1HYoNQcN6/4vR0zfmSi4Cx+MoTcclT2w9D
         ei4rAVj5houiTpEBqdyRnKKjvyaz9jUKJI3pyVmJrNdJ82ozJQDSplvxXTmaa8hIY2h4
         URaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzOZCiCY9T/N63Dl5wU5VQfpxdYCOEnngv4eCCQzHgnECG8tGnlmtpjMcEF9ex0IjchCDn09QSwhsxNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YytXzeJMwDryS51CiVB2v6ccj86HsK1A3DzgcOgQllnJ/v0xdAf
	+u4BfvzuKMaD0DwN2HvOqgSMNZwJzAU8TFra0P6iSqOxQ9t5+l1JkEnZsMFURXtHvt8MVCGuO7s
	YG7Edz0c5dZeGWdQVtnxEP2c+gDettkALPQpzvA==
X-Gm-Gg: ASbGncvoEF7HekpP3L2U9dQjPOsYNgOg84Qa0P0tEZEyWgTIaWxqZZpLoF6xDkhjj34
	l1/l00JtaX32+Uz0DK96NmBTi15dWpXif93UsiU8+aStWxeYKWaDbnQEVBKFGuDkR1Yv2KEU3YE
	atkt3aduupEJpEAM+on2hW8w==
X-Google-Smtp-Source: AGHT+IEe0qaC0lQE4vVBPq0O/UkufyhMgS9z3ZbPY1mvtJ8bizDhkkrVjsKtA3hkJLPYrj6rIi0bINvnfo6SXiRHqEk=
X-Received: by 2002:a17:90b:2248:b0:2fe:91d0:f781 with SMTP id
 98e67ed59e1d1-30a2205ed62mr68803a91.2.1745860426928; Mon, 28 Apr 2025
 10:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428094420.1584420-1-ming.lei@redhat.com> <20250428094420.1584420-5-ming.lei@redhat.com>
In-Reply-To: <20250428094420.1584420-5-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 28 Apr 2025 10:13:35 -0700
X-Gm-Features: ATxdqUFfaibAVOB9lsrlFcvbbkzlbm3pJ51B84XwwL59NRLca-HSsvfIndwZufY
Message-ID: <CADUfDZrr19VZTm+rfN3Ks9Rrvek2CEBBt0V=CLO2uHayWffcow@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] ublk: convert to refcount_t
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 2:45=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Convert to refcount_t and prepare for supporting to register bvec buffer
> automatically, which needs to initialize reference counter as 2, and
> kref doesn't provide this interface, so convert to refcount_t.
>
> Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index ac56482b55f5..9cd331d12fa6 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -79,7 +79,7 @@
>          UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
>
>  struct ublk_rq_data {
> -       struct kref ref;
> +       refcount_t ref;
>  };
>
>  struct ublk_uring_cmd_pdu {
> @@ -484,7 +484,6 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_=
queue *ubq,
>  #endif
>
>  static inline void __ublk_complete_rq(struct request *req);
> -static void ublk_complete_rq(struct kref *ref);
>
>  static dev_t ublk_chr_devt;
>  static const struct class ublk_chr_class =3D {
> @@ -644,7 +643,7 @@ static inline void ublk_init_req_ref(const struct ubl=
k_queue *ubq,
>         if (ublk_need_req_ref(ubq)) {
>                 struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
>
> -               kref_init(&data->ref);
> +               refcount_set(&data->ref, 1);
>         }
>  }
>
> @@ -654,7 +653,7 @@ static inline bool ublk_get_req_ref(const struct ublk=
_queue *ubq,
>         if (ublk_need_req_ref(ubq)) {
>                 struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
>
> -               return kref_get_unless_zero(&data->ref);
> +               return refcount_inc_not_zero(&data->ref);
>         }
>
>         return true;
> @@ -666,7 +665,8 @@ static inline void ublk_put_req_ref(const struct ublk=
_queue *ubq,
>         if (ublk_need_req_ref(ubq)) {
>                 struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
>
> -               kref_put(&data->ref, ublk_complete_rq);
> +               if(refcount_dec_and_test(&data->ref))

nit: missing space after if

Other than that,

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> +                       __ublk_complete_rq(req);
>         } else {
>                 __ublk_complete_rq(req);
>         }
> @@ -1124,15 +1124,6 @@ static inline void __ublk_complete_rq(struct reque=
st *req)
>         blk_mq_end_request(req, res);
>  }
>
> -static void ublk_complete_rq(struct kref *ref)
> -{
> -       struct ublk_rq_data *data =3D container_of(ref, struct ublk_rq_da=
ta,
> -                       ref);
> -       struct request *req =3D blk_mq_rq_from_pdu(data);
> -
> -       __ublk_complete_rq(req);
> -}
> -
>  static void ublk_complete_io_cmd(struct ublk_io *io, struct request *req=
,
>                                  int res, unsigned issue_flags)
>  {
> --
> 2.47.0
>
