Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED34C256D
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745856078; cv=none; b=uY/qrd9th3AyKmETZudSF3qWr6LvhXGVT19X9JY2PHteBwiDwmjXWgCpispU/IvWdA/BAXj8+4rm5d7Blf99brgkP0Wubp1csbXa9fjPVq4uFBJCxZkfXdzLTLcS+9pnrbfyqDJdYSXpWGyLPAgp0ZJ51zyTy0uapqq3XZKOyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745856078; c=relaxed/simple;
	bh=4gPvIq8hjcS/s3gqe+10+H7S5tOhYs155hEqNA2UDcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfmX3yAZ4Dcu0iwXv3scTgVx0R5Hy9TGDC+RtPHkNVOajmaGM4AsYaOxQ2VJA41LWauVbHOwD8aeNGsWM0YQGWlHU/tVtYYs/dCaa0TToGSoJ0df6yYPpbKfyEYYSOiOMi7OcKnPJlTLvT84LCNV7LvFNDlkBqvmGUnHAV3hipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eR4SQ6H+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eR4SQ6H+"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so475530a91.2
        for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745856076; x=1746460876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALitjyRL+QPE2LQZz4a6RijgylMdtRY7uT7ABjWorNs=;
        b=eR4SQ6H+tOQpAdY3ewqxLQJ54JSCIT1nwrp87yp1Zu/n63fv/oRea2UiN6v45dPEua
         g+qATMMaOI1lg+0DtAXMfyZRJNK6tJ9dEPaZUZjK/yCDlSR7VYy+Dez3TPBw2GVDOEY4
         3a87UesvpVycO0icSBzvu9rJRdsFMNU8gwPvMbDGAg/F4MXGxH2GMId7Dr/jaJqtkkuA
         TZghOdq9moX9Qde4w+9DAWIPJyBafXsLn0pyjhXxOLn1XYXiknbvqRMWG6PZFVsPpKs/
         4fREnGagJbvjQ2EKwrvAdNwGFtRqr0V1XARpC4VlQ2zG9zONyQQ3n09HCysaNlYoW/3E
         2/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745856076; x=1746460876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALitjyRL+QPE2LQZz4a6RijgylMdtRY7uT7ABjWorNs=;
        b=gkuThYku5VFrnE1Ik858EzoYCD5hrVcIrBZKjlS3PvM5o6bfLE3xk5jxQmp3+pA4qY
         sPfJvMLldMJonOGmcanP59lZlrnTdsGG5LZOlq61lgGdjjPkwZjPDdNVyH5YFd8FSQg+
         KqBJWKPf15Sa5mrmg6DwSndGWl/5RFHA7QRzNZgcdD1lAVCCkH8ktUlRNDwp5O+DZeNq
         F1rQXUh89Dn2r5uTLSlCJ3F2E1pI7fBhwqic/Z1C0bCc5h9eLtAVNDuBEOAPC/QKfkCS
         nTIkk54P9yitC2dFSh9/RZ3FmayUC0FPko0QzISTEC7j5fKT68Nd44vOzt1uGYTjvyU1
         NJzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkD48G60+4cAt2xvwVKRAOCg2WunkAMuCZxWObP+WTEKcQsuhBL5IDWK4a0Qi8jiHNCuj9n82utGmm9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0+T471LqDuHm6eXoUcO4rSNmLfxKAFbewvMBvBGM3OqQo+phj
	/agcGFLAMKOXBB/pUWbwO+5Zgokbeqjkc7Lh0irpapej801N60joCWfLAWHe/9+UWPanaGFJW/C
	NrQVt8TLyV6phSlsIZJyif3Ykkuattsv5po3zsC7OmdaEzy1EUxDK5A==
X-Gm-Gg: ASbGnctLkKgtrJlxgw5beLbc+/7SnERolu5W60Bj6YVVxcuGdx0sYHNLGo7jSpLFyh8
	X/bNXNwOwiORA89jWblKh5bEcmkiy3DM21gkjHyi341uiPnLHiYPsL/8LKztyFXlzsjtHd/SR+h
	tN8W4WGP/N6+WknehBUXxKKQ==
X-Google-Smtp-Source: AGHT+IFH5qV4c30zj+hS6Vk4SaiZtOioD0fEnrlP2poknnEvUxUpUtIRIaboKo9QyxJoROpy6kkNZHYuWsnZLdUBtTs=
X-Received: by 2002:a17:90b:3e8e:b0:305:5f2c:c580 with SMTP id
 98e67ed59e1d1-309f7da6f77mr6681344a91.2.1745856075814; Mon, 28 Apr 2025
 09:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427134932.1480893-1-ming.lei@redhat.com> <20250427134932.1480893-3-ming.lei@redhat.com>
In-Reply-To: <20250427134932.1480893-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 28 Apr 2025 09:01:04 -0700
X-Gm-Features: ATxdqUFf_7ZzH_F5k1fCVjHYxUNLjxtooxtchCr62Ej0zTr3dz-gSjOaoa1C0Hs
Message-ID: <CADUfDZq4m2ndHPmbWnECXWCYO_o7X-ys37=10gqMMYcO+xEJhA@mail.gmail.com>
Subject: Re: [PATCH v6.15 2/3] ublk: decouple zero copy from user copy
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 6:49=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> UBLK_F_USER_COPY and UBLK_F_SUPPORT_ZERO_COPY are two different
> features, and shouldn't be coupled together.
>
> Commit 1f6540e2aabb ("ublk: zc register/unregister bvec") enables
> user copy automatically in case of UBLK_F_SUPPORT_ZERO_COPY, this way
> isn't correct.
>
> So decouple zero copy from user copy, and use independent helper to
> check each one.

I agree this makes sense.

>
> Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 40f971a66d3e..0a3a3c64316d 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -205,11 +205,6 @@ static inline struct request *__ublk_check_and_get_r=
eq(struct ublk_device *ub,
>  static inline unsigned int ublk_req_build_flags(struct request *req);
>  static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ub=
q,
>                                                    int tag);
> -static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
> -{
> -       return ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZE=
RO_COPY);
> -}
> -
>  static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
>  {
>         return ub->dev_info.flags & UBLK_F_ZONED;
> @@ -609,14 +604,19 @@ static void ublk_apply_params(struct ublk_device *u=
b)
>                 ublk_dev_param_zoned_apply(ub);
>  }
>
> +static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
> +{
> +       return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
> +}
> +
>  static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
>  {
> -       return ubq->flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY)=
;
> +       return ubq->flags & UBLK_F_USER_COPY;
>  }
>
>  static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
>  {
> -       return !ublk_support_user_copy(ubq);
> +       return !ublk_support_user_copy(ubq) && !ublk_support_zero_copy(ub=
q);
>  }
>
>  static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
> @@ -624,8 +624,11 @@ static inline bool ublk_need_req_ref(const struct ub=
lk_queue *ubq)
>         /*
>          * read()/write() is involved in user copy, so request reference
>          * has to be grabbed
> +        *
> +        * for zero copy, request buffer need to be registered to io_urin=
g
> +        * buffer table, so reference is needed
>          */
> -       return ublk_support_user_copy(ubq);
> +       return ublk_support_user_copy(ubq) || ublk_support_zero_copy(ubq)=
;
>  }
>
>  static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
> @@ -2245,6 +2248,9 @@ static struct request *ublk_check_and_get_req(struc=
t kiocb *iocb,
>         if (!ubq)
>                 return ERR_PTR(-EINVAL);
>
> +       if (!ublk_support_user_copy(ubq))
> +               return ERR_PTR(-EACCES);

This partly overlaps with the existing ublk_need_req_ref() check in
__ublk_check_and_get_req() (although that allows
UBLK_F_SUPPORT_ZERO_COPY too). Can that check be removed now that the
callers explicitly check ublk_support_user_copy() or
ublk_support_zero_copy()?

> +
>         if (tag >=3D ubq->q_depth)
>                 return ERR_PTR(-EINVAL);
>
> @@ -2783,13 +2789,18 @@ static int ublk_ctrl_add_dev(const struct ublksrv=
_ctrl_cmd *header)
>         ub->dev_info.flags |=3D UBLK_F_CMD_IOCTL_ENCODE |
>                 UBLK_F_URING_CMD_COMP_IN_TASK;
>
> -       /* GET_DATA isn't needed any more with USER_COPY */
> -       if (ublk_dev_is_user_copy(ub))
> +       /* GET_DATA isn't needed any more with USER_COPY or ZERO COPY */
> +       if (ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_=
COPY))
>                 ub->dev_info.flags &=3D ~UBLK_F_NEED_GET_DATA;
>
> -       /* Zoned storage support requires user copy feature */
> +       /*
> +        * Zoned storage support requires reuse `ublksrv_io_cmd->addr` fo=
r
> +        * returning write_append_lba, which is only allowed in case of
> +        * user copy or zero copy

Thanks, this comment is much more helpful.

Best,
Caleb

> +        */
>         if (ublk_dev_is_zoned(ub) &&
> -           (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) || !ublk_dev_is_user_copy(=
ub))) {
> +           (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) || !(ub->dev_info.flags &
> +            (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY)))) {
>                 ret =3D -EINVAL;
>                 goto out_free_dev_number;
>         }
> --
> 2.47.0
>
