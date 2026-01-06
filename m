Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C3217723
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717142; cv=none; b=q+sq9OUAbV4e2JqboGFVkRViEF3UVc/IcC28d4yhkN2KQJW3D21QBhNx6uDaoh5RAyryXLA/0ObjRf05Q+lhVUSOOBeCmLZEPbEXKRefR/YUma2HIMlSyK+dQYDJvjlR9bCmytrtcswNlNgEE6HjpkFl1bf9rNSHX6x7ykbjvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717142; c=relaxed/simple;
	bh=DP8+pjhFskwElb6cIG1WHNQjDAfFLDUggXyraKQshJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h675J7poiXrc6FoeLKfkUvUZ+ge9tWRzKt/P0O9MqXyIoIsf/XcrYc977zp5ICGhtoZfXTazrKyeQxvaD7HO7qVDrmGVh1755LOomZ9e7ziX4Ln3bS+pIyTZNfqYUdJ7HnzClGr8JzUoeWTUCpeMbUyhIbRD+s8wvXaVDL89Xbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Dhsjnn2R; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Dhsjnn2R"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-11df44181c3so26303c88.3
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 08:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767717139; x=1768321939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFME/jF/G3B8VWgjH0UPxTgzjz3BgD0dLRGP8ulIWHE=;
        b=Dhsjnn2RzBMu1rD3uHAZJQvwcrp+xeNP97WDnS8C77QL9VM/b52hw57K5hD5SnG2QS
         kjrzqdEB9QkJ28g8Mrnb2IB7iN6ysrwuYhONXxAhDH1SgoloEPA9UBqAtT0qTFjtXHjj
         967YTBUgsI+MziDV1/LQt1KSo4CuN52Bn80AbtcF8QWxKeqvNP70xpDhK+Kbk37eGRA3
         jnEAULtBaKlNYAewWUigXfN5lTvZlyZcIgPwWZrk+yeg2k8ypbJ/UyV/H9pdZPAPRTfF
         hHrTSs2IkBG7K4XECam+5rTkuB2Hl815m/EGjvo3zufNsl+B2nBnaVMWo6eDwnd+Iard
         zRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767717139; x=1768321939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uFME/jF/G3B8VWgjH0UPxTgzjz3BgD0dLRGP8ulIWHE=;
        b=gkggs82ozr/aVjUo9F6Jt0/8YjH0y5ZvaBaC8ANqRbBZ13k4r1HPlbDHlUrmLhNmIO
         4+fJ3XJgEvqt1T7G4gdBTVz/WZQ9fw5RWiNktkM/Pdny+tNUnlw+ZpAR7tEQWNW+nM7d
         9B/2lDUKbdQt65aLZ0FHVW/a+N124dvRuH99KEyTShVZqjO/DwyqNBDFU3yNZkq4ud43
         gJt5AsEquLHh1AU5H87HTLeJmacRA+63gUBoVlTw5XEJHAKDvuk4G/STU7WOOZ2QdWjq
         3YKe6SIqJKdwT8PeVi9KhF5SSOChIKLWFnMP3A7cA4Yn4U9Gn3eQfw+wesOISXrscovs
         Qz9w==
X-Forwarded-Encrypted: i=1; AJvYcCX+JQDQT/q+KfEvPoN2XA/miucPTYgqlJU0eyIr9dM792udDQUiwF2Wy4OKDuq6ohHqlB562Vpi1yn08g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhAjDnzL7eYsJ5aAJek/BBfjNO5nxOX8H0ma1ISHcjBqjrxbVk
	vN4sM/+J8o1tWCwErJ+wfbdCqBBzxmtpWvRj9mjwA4mF3sXiP2Q0T2t+EvME8M/j88RJsGJd+a1
	Pe7SPmyQx61izZpGbi7pDe10t4sYQK01he2gQRICPkg==
X-Gm-Gg: AY/fxX6OJNfRN9+pdGxzyTO4hSFSz+aCBAvLM0ptCt/JxUYljmgSmua0CUHA5NfHlzg
	9mvcby+kUkUBQLVzrvDYnT9n6YZpD/RiVPaD46en3pqvwqdsdSQrBvIjylty9+EVp1uLAUfChoU
	ygwr3jQwwiz1NCqVeWYVQqz32Jj5LbgCg0uZEvDE9ilgKpNUk/g9MJ6X//971TK9R91jILBUJtw
	62zfFDPJnUnSa1PrGZ+4V/DQUwCv/31j9BV4rRjDzoJY1qvWASLRSsc7/0+ZyZik1IxFlKD
X-Google-Smtp-Source: AGHT+IHciEDYe8treSke2aNxPU3dLkDLwHYbYjy5qupe+gnCNq0vkbIIFvrOpAVZ3PtZmUfndCj4I52AEBAwh/QxOI8=
X-Received: by 2002:a05:7022:6a5:b0:119:e55a:95a3 with SMTP id
 a92af1059eb24-121f18e4e1fmr1784027c88.5.1767717139189; Tue, 06 Jan 2026
 08:32:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-4-csander@purestorage.com> <aV0Jd76i9Iru8Ge9@fedora>
In-Reply-To: <aV0Jd76i9Iru8Ge9@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 6 Jan 2026 08:32:08 -0800
X-Gm-Features: AQt7F2oklRbhWHAgddnyYMm_gilIqLRjkjBNze5sGqqvqP4oeAJfQWUJV-D6Qfw
Message-ID: <CADUfDZpwRQv0yghG7S4ugNGc4X_b5bC=Za=+M-D36J5T46w64g@mail.gmail.com>
Subject: Re: [PATCH v3 03/19] ublk: support UBLK_PARAM_TYPE_INTEGRITY in
 device creation
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Zhang <stazhang@purestorage.com>, Uday Shankar <ushankar@purestorage.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 5:09=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Mon, Jan 05, 2026 at 05:57:35PM -0700, Caleb Sander Mateos wrote:
> > From: Stanley Zhang <stazhang@purestorage.com>
> >
> > Add a feature flag UBLK_F_INTEGRITY for a ublk server to request
> > integrity/metadata support when creating a ublk device. The ublk server
> > can also check for the feature flag on the created device or the result
> > of UBLK_U_CMD_GET_FEATURES to tell if the ublk driver supports it.
> > UBLK_F_INTEGRITY requires UBLK_F_USER_COPY, as user copy is the only
> > data copy mode initially supported for integrity data.
> > Add UBLK_PARAM_TYPE_INTEGRITY and struct ublk_param_integrity to struct
> > ublk_params to specify the integrity params of a ublk device.
> > UBLK_PARAM_TYPE_INTEGRITY requires UBLK_F_INTEGRITY and a nonzero
> > metadata_size. The LBMD_PI_CAP_* and LBMD_PI_CSUM_* values from the
> > linux/fs.h UAPI header are used for the flags and csum_type fields.
> > If the UBLK_PARAM_TYPE_INTEGRITY flag is set, validate the integrity
> > parameters and apply them to the blk_integrity limits.
> > The struct ublk_param_integrity validations are based on the checks in
> > blk_validate_integrity_limits(). Any invalid parameters should be
> > rejected before being applied to struct blk_integrity.
> >
> > Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> > [csander: drop redundant pi_tuple_size field, use block metadata UAPI
> >  constants, add param validation]
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c      | 94 ++++++++++++++++++++++++++++++++++-
> >  include/uapi/linux/ublk_cmd.h | 18 +++++++
> >  2 files changed, 111 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 8e3da9b2b93a..066c6ae062a0 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -42,10 +42,12 @@
> >  #include <linux/mm.h>
> >  #include <asm/page.h>
> >  #include <linux/task_work.h>
> >  #include <linux/namei.h>
> >  #include <linux/kref.h>
> > +#include <linux/blk-integrity.h>
> > +#include <uapi/linux/fs.h>
> >  #include <uapi/linux/ublk_cmd.h>
> >
> >  #define UBLK_MINORS          (1U << MINORBITS)
> >
> >  #define UBLK_INVALID_BUF_IDX         ((u16)-1)
> > @@ -81,11 +83,12 @@
> >
> >  /* All UBLK_PARAM_TYPE_* should be included here */
> >  #define UBLK_PARAM_TYPE_ALL                                \
> >       (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
> >        UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> > -      UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
> > +      UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT | \
> > +      UBLK_PARAM_TYPE_INTEGRITY)
> >
> >  struct ublk_uring_cmd_pdu {
> >       /*
> >        * Store requests in same batch temporarily for queuing them to
> >        * daemon context.
> > @@ -628,10 +631,57 @@ static void ublk_dev_param_basic_apply(struct ubl=
k_device *ub)
> >               set_disk_ro(ub->ub_disk, true);
> >
> >       set_capacity(ub->ub_disk, p->dev_sectors);
> >  }
> >
> > +static int ublk_integrity_flags(u32 flags)
> > +{
> > +     int ret_flags =3D 0;
> > +
> > +     if (flags & LBMD_PI_CAP_INTEGRITY) {
> > +             flags &=3D ~LBMD_PI_CAP_INTEGRITY;
> > +             ret_flags |=3D BLK_INTEGRITY_DEVICE_CAPABLE;
> > +     }
> > +     if (flags & LBMD_PI_CAP_REFTAG) {
> > +             flags &=3D ~LBMD_PI_CAP_REFTAG;
> > +             ret_flags |=3D BLK_INTEGRITY_REF_TAG;
> > +     }
> > +     return flags ? -EINVAL : ret_flags;
> > +}
> > +
> > +static int ublk_integrity_pi_tuple_size(u8 csum_type)
> > +{
> > +     switch (csum_type) {
> > +     case LBMD_PI_CSUM_NONE:
> > +             return 0;
> > +     case LBMD_PI_CSUM_IP:
> > +     case LBMD_PI_CSUM_CRC16_T10DIF:
> > +             return 8;
> > +     case LBMD_PI_CSUM_CRC64_NVME:
> > +             return 16;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static enum blk_integrity_checksum ublk_integrity_csum_type(u8 csum_ty=
pe)
> > +{
> > +     switch (csum_type) {
> > +     case LBMD_PI_CSUM_NONE:
> > +             return BLK_INTEGRITY_CSUM_NONE;
> > +     case LBMD_PI_CSUM_IP:
> > +             return BLK_INTEGRITY_CSUM_IP;
> > +     case LBMD_PI_CSUM_CRC16_T10DIF:
> > +             return BLK_INTEGRITY_CSUM_CRC;
> > +     case LBMD_PI_CSUM_CRC64_NVME:
> > +             return BLK_INTEGRITY_CSUM_CRC64;
> > +     default:
> > +             WARN_ON_ONCE(1);
> > +             return BLK_INTEGRITY_CSUM_NONE;
> > +     }
> > +}
> > +
> >  static int ublk_validate_params(const struct ublk_device *ub)
> >  {
> >       /* basic param is the only one which must be set */
> >       if (ub->params.types & UBLK_PARAM_TYPE_BASIC) {
> >               const struct ublk_param_basic *p =3D &ub->params.basic;
> > @@ -690,10 +740,33 @@ static int ublk_validate_params(const struct ublk=
_device *ub)
> >                       return -EINVAL;
> >               if (p->max_segment_size < UBLK_MIN_SEGMENT_SIZE)
> >                       return -EINVAL;
> >       }
> >
> > +     if (ub->params.types & UBLK_PARAM_TYPE_INTEGRITY) {
> > +             const struct ublk_param_integrity *p =3D &ub->params.inte=
grity;
> > +             int pi_tuple_size =3D ublk_integrity_pi_tuple_size(p->csu=
m_type);
> > +             int flags =3D ublk_integrity_flags(p->flags);
> > +
> > +             if (!(ub->dev_info.flags & UBLK_F_INTEGRITY))
> > +                     return -EINVAL;
> > +             if (flags < 0)
> > +                     return flags;
> > +             if (pi_tuple_size < 0)
> > +                     return pi_tuple_size;
> > +             if (!p->metadata_size)
> > +                     return -EINVAL;
> > +             if (p->csum_type =3D=3D LBMD_PI_CSUM_NONE &&
> > +                 p->flags & LBMD_PI_CAP_REFTAG)
> > +                     return -EINVAL;
> > +             if (p->pi_offset + pi_tuple_size > p->metadata_size)
> > +                     return -EINVAL;
> > +             if (p->interval_exp < SECTOR_SHIFT ||
> > +                 p->interval_exp > ub->params.basic.logical_bs_shift)
> > +                     return -EINVAL;
> > +     }
> > +
> >       return 0;
> >  }
> >
> >  static void ublk_apply_params(struct ublk_device *ub)
> >  {
> > @@ -2941,10 +3014,25 @@ static int ublk_ctrl_start_dev(struct ublk_devi=
ce *ub,
> >               lim.seg_boundary_mask =3D ub->params.seg.seg_boundary_mas=
k;
> >               lim.max_segment_size =3D ub->params.seg.max_segment_size;
> >               lim.max_segments =3D ub->params.seg.max_segments;
> >       }
> >
> > +     if (ub->params.types & UBLK_PARAM_TYPE_INTEGRITY) {
> > +             const struct ublk_param_integrity *p =3D &ub->params.inte=
grity;
> > +             int pi_tuple_size =3D ublk_integrity_pi_tuple_size(p->csu=
m_type);
> > +
> > +             lim.integrity =3D (struct blk_integrity) {
> > +                     .flags =3D ublk_integrity_flags(p->flags),
> > +                     .csum_type =3D ublk_integrity_csum_type(p->csum_t=
ype),
> > +                     .metadata_size =3D p->metadata_size,
> > +                     .pi_offset =3D p->pi_offset,
> > +                     .interval_exp =3D p->interval_exp,
> > +                     .tag_size =3D p->tag_size,
> > +                     .pi_tuple_size =3D pi_tuple_size,
> > +             };
> > +     }
> > +
> >       if (wait_for_completion_interruptible(&ub->completion) !=3D 0)
> >               return -EINTR;
> >
> >       if (ub->ublksrv_tgid !=3D ublksrv_pid)
> >               return -EINVAL;
> > @@ -3131,10 +3219,14 @@ static int ublk_ctrl_add_dev(const struct ublks=
rv_ctrl_cmd *header)
> >               if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_=
COPY |
> >                                       UBLK_F_AUTO_BUF_REG))
> >                       return -EINVAL;
> >       }
> >
> > +     /* User copy is required to access integrity buffer */
> > +     if (info.flags & UBLK_F_INTEGRITY && !(info.flags & UBLK_F_USER_C=
OPY))
> > +             return -EINVAL;
> > +
> >       /* the created device is always owned by current user */
> >       ublk_store_owner_uid_gid(&info.owner_uid, &info.owner_gid);
> >
> >       if (header->dev_id !=3D info.dev_id) {
> >               pr_warn("%s: dev id not match %u %u\n",
> > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cm=
d.h
> > index ec77dabba45b..a54c47832fa2 100644
> > --- a/include/uapi/linux/ublk_cmd.h
> > +++ b/include/uapi/linux/ublk_cmd.h
> > @@ -309,10 +309,16 @@
> >   * the I/O's daemon task. The q_id and tag of the registered buffer ar=
e required
> >   * in UBLK_U_IO_UNREGISTER_IO_BUF's ublksrv_io_cmd.
> >   */
> >  #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
> >
> > +/*
> > + * ublk device supports requests with integrity/metadata buffer.
> > + * Requires UBLK_F_USER_COPY.
> > + */
> > +#define UBLK_F_INTEGRITY (1ULL << 16)
> > +
> >  /* device state */
> >  #define UBLK_S_DEV_DEAD      0
> >  #define UBLK_S_DEV_LIVE      1
> >  #define UBLK_S_DEV_QUIESCED  2
> >  #define UBLK_S_DEV_FAIL_IO   3
> > @@ -598,10 +604,20 @@ struct ublk_param_segment {
> >       __u32   max_segment_size;
> >       __u16   max_segments;
> >       __u8    pad[2];
> >  };
> >
> > +struct ublk_param_integrity {
> > +     __u32   flags; /* LBMD_PI_CAP_* from linux/fs.h */
> > +     __u8    interval_exp;
> > +     __u8    metadata_size; /* UBLK_PARAM_TYPE_INTEGRITY requires nonz=
ero */
> > +     __u8    pi_offset;
> > +     __u8    csum_type; /* LBMD_PI_CSUM_* from linux/fs.h */
> > +     __u8    tag_size;
> > +     __u8    pad[7];
> > +};
>
> Looks max_integrity_segments is missed, otherwise this patch is fine for =
me.

My thinking was that there isn't any reason why a ublk server would
need to limit the number of integrity segments. The request integrity
segments aren't directly exposed to the ublk server through user copy.
And since zero copy isn't supported for integrity data, there's no
concern about needing to align the ublk integrity limits with the
backing device limits. What do you think?

Thanks,
Caleb
