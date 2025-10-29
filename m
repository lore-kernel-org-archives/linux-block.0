Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F91B329C52
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753661; cv=none; b=FzE3sOqowIFXy0kp/HMfezPSOomvNxo0s35/yLm3ZV+l7HmWWfht8eYA2og6WL1Ky3j2qrq0Pjv/hD60BI5yFe5+88h5NR0q7qVTpBVbYZMWzF/EyLSabj1Mf5euuaQ6SbpC6iJegWTzOQVdtFd/to+96D4sZ5mzjw96RyUEVgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753661; c=relaxed/simple;
	bh=yWjewa9JNcRoCcYtgjHQrQLVg/vLVweIJihdHEb27uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3HUziEbgydE7SI0E4bjgY0EAIj03NzVHn90ox63xyfnGcD+d1cH212PTd6y5TQqUEDk1a1S0jV8Xgjd0u6aEtD9vWJgM0TATlmMyMgznPZiqh2+SCCRkWSlB3G7Fn8pDMR8udAmaBTu3PRsUlYN0AjoWCdI/YgkGYKM/skAXnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EGs5Fdcj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EGs5Fdcj"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6cf214a3ceso738966a12.3
        for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761753659; x=1762358459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUnoAdF987OgQsX5lEaFCHrVJc5YACNCImhQ2U9YKSE=;
        b=EGs5FdcjZ3rp3Ade9oSN5a7gJ6rExLHPwmgEBIWmvnc0qiHyB+PvhPArlbLCBxYaUs
         /7g5oFGGXBGTC9BwMWkYQBQhtMr2+q1SCfD2pztBQy3b8pRD3WqY9VgBwegxsz2fNFsx
         5Ik5Cf1TTUyqpf8VLNU+Ff4j4Lhdjr4mhAYSEzLy7scURBPDQxRLNiNnjVk2KZS02HwJ
         F7h9gZBCo7SLd3zBug27qUcFQJHP/TXpqY67pqTCmFfktqFnhkYeITZl5FK/l5Tlhdi8
         jC6B259frPVI333ppSh7mQcopqUyF5jbfgVq+NDJCOkiN801amCAo+ptgCDBvQsMy9l2
         jXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753659; x=1762358459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUnoAdF987OgQsX5lEaFCHrVJc5YACNCImhQ2U9YKSE=;
        b=XHlG6hkUnTA45pz+XHD3wlUEBuyzE1AdbyF1Mb6IZWk+d+zhjykDEOrqslAek8qVfx
         PxK1FpKBuIC8IX4aRSx6IjeLMyw4e5BRta3IMd3m2EWSpJd0MXEkIO4E5wrC/awEt/O5
         bABlQ2liDe9EJlYhOmkyCQHNGnJQ4OeX9bFnid9wbCuWyoI8Bzpa1BDsRuG4EaN1uM2O
         SONqeR/G2VV+Q0cIk4/hTkDFkX1U/rxBeDLbBuZUlhWwC1/Jzakf3SsZyf7KeCXhGUnx
         44sAsyDMUd2AotLylBIiuaAczj6Nykv5MV8x1vgUQ0yXv7Kh/FFhycDtVEaER1EgrMsw
         JG7g==
X-Forwarded-Encrypted: i=1; AJvYcCXEzA5jr5K11chF+2acMYPRCA8zclDQ2RzQmkdcq5y2u57aC3bfjQHQj0Nggcjq/PPfUsoi6iqpojNq4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7EItHVrE+ARt3m8bFMCMUOmTa2vKUza/gynZZh/yYBp0CY8pI
	2cGcgGmtQ52+rRAbzDwKmprzU4HqkR+zBDxpQHEUF2Nvw6D3TXtTRKGBsr50KxYIh4Ij+Fki8Gf
	dav2GI35+RKqUoSsK5cizP/ez6DJzsk2ZZ4uFjWUPTWBmzmGMmfiUIvoHsA==
X-Gm-Gg: ASbGncsDZoUGtP6NKYPWPSDcraM5cIJztSjozkAoaX1zUHA68ePGJ6uOfdIghwEMVGF
	RTsWA2Fswq6/SHPokfzbFCqgOEXge8u3SQK67uHC8K/1/GVb3tST3RmIxlwWxtxrVajcziaP4y1
	50vzG0HBOSG0ni+IXDdiiClmCXA08+tqOg6JYmU2WTsh2LuJ17IaUthsNIuTsD6IQNUURdOcid0
	iLnW/OvOoajwocHS7HlcJPCiYegyd8l2KuAdUAGE4H1XafnoDEfESTfr5q6V7ZEZndMznIa3/5X
	P4ifAGctj2zThQEGgf0W4OUXINuB
X-Google-Smtp-Source: AGHT+IELsmTr3WjQZpapFLRsxxCeqyvcgoH1SYhHpekW/J+xyxt/TqD1fsOdDDz0wpo8/F/Zwn7AbDiMyulfAYeEKFI=
X-Received: by 2002:a17:902:d2ce:b0:27e:eb9b:b80f with SMTP id
 d9443c01a7336-294dedf12fdmr25082135ad.2.1761753657009; Wed, 29 Oct 2025
 09:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029031035.258766-1-ming.lei@redhat.com> <20251029031035.258766-4-ming.lei@redhat.com>
In-Reply-To: <20251029031035.258766-4-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 29 Oct 2025 09:00:45 -0700
X-Gm-Features: AWmQ_bmr-a6lyhwNWlViJrw5x23-RYGKbAelW-Nd16y_1R413C-MApXMpsjqrsM
Message-ID: <CADUfDZqD3F7GuPVr=gPe1YWLr4GUx5=YxXzM_Gxt84F8sxTO7Q@mail.gmail.com>
Subject: Re: [PATCH V3 3/5] ublk: use struct_size() for allocation
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 8:11=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Convert ublk_queue to use struct_size() for allocation.
>
> Changes in this commit:
>
> 1. Update ublk_init_queue() to use struct_size(ubq, ios, depth)
>    instead of manual size calculation (sizeof(struct ublk_queue) +
>    depth * sizeof(struct ublk_io)).
>
> This provides better type safety and makes the code more maintainable
> by using standard kernel macro for flexible array handling.
>
> Meantime annotate ublk_queue.ios by __counted_by().
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  drivers/block/ublk_drv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index ed77b4527b33..409874714c62 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -203,7 +203,7 @@ struct ublk_queue {
>         bool fail_io; /* copy of dev->state =3D=3D UBLK_S_DEV_FAIL_IO */
>         spinlock_t              cancel_lock;
>         struct ublk_device *dev;
> -       struct ublk_io ios[];
> +       struct ublk_io ios[] __counted_by(q_depth);
>  };
>
>  struct ublk_device {
> @@ -2700,7 +2700,6 @@ static int ublk_get_queue_numa_node(struct ublk_dev=
ice *ub, int q_id)
>  static int ublk_init_queue(struct ublk_device *ub, int q_id)
>  {
>         int depth =3D ub->dev_info.queue_depth;
> -       int ubq_size =3D sizeof(struct ublk_queue) + depth * sizeof(struc=
t ublk_io);
>         gfp_t gfp_flags =3D GFP_KERNEL | __GFP_ZERO;
>         struct ublk_queue *ubq;
>         struct page *page;
> @@ -2711,7 +2710,8 @@ static int ublk_init_queue(struct ublk_device *ub, =
int q_id)
>         numa_node =3D ublk_get_queue_numa_node(ub, q_id);
>
>         /* Allocate queue structure on local NUMA node */
> -       ubq =3D kvzalloc_node(ubq_size, GFP_KERNEL, numa_node);
> +       ubq =3D kvzalloc_node(struct_size(ubq, ios, depth), GFP_KERNEL,
> +                           numa_node);
>         if (!ubq)
>                 return -ENOMEM;
>
> --
> 2.47.0
>
