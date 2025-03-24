Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A9C1802B
	for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855183; cv=none; b=GJcpRci97fN6pk1fvReOKJxdSGBlgre61qQB4C/jxWJDhxT/Xz7KE1doqNFnmYVhur70c7nM+yrZjT/96ThYkSLova1753hl6qmuT6lkkE5+xTpyTjTHoJ+MffZP9O+iM0vydbwi7RoTP2OiWg+raV12OWnTXtU/Bfb3umCGvUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855183; c=relaxed/simple;
	bh=0yU47s0cs/w042Uwdfx61clgJCXVV25KBO0poFJLCmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRUWEUjikoUILm+W97D/YLCCyOjlZeqXiB5ZfoeLjsCvyWC/e2AA+wPA4y+YZku8ayXbcIUVvg/7I5qh2ku+stMcCHIz9nzB1BsvF+JuezCvrtHWNS1oJVazOk6V+IwUbOIqlOfOwf0BiaG5iwfxv6RRSyHrpcd9UoibS8hpe4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TQ6Cz6j6; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TQ6Cz6j6"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-301b4f97cc1so1523189a91.2
        for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 15:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742855178; x=1743459978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrvR0aOcLIcAWx4e/98EnSWBHvNd6Y8j5/3yZVSpxaA=;
        b=TQ6Cz6j6gOux45Eztx7csav51XkdJt2AD2ZqELEOSeppMD+QrcCgBHhLrZsDeokdny
         ZJSaUapetNYd68hIcghyWYI+9ohbzoEXGlkvFBC7do2NVeDbEoQb+41HwX+xnr05oceV
         3WHgDWOsZBtExY0S/GSlmDiXcPIFa3e99yIJyWWT/C2jSu1eNcwY22XOcjcKwXKE/BtX
         CkqaeMOR/tmpWFVEnuqEKbAPjVWRykfQM+jLwq36Vh4p8G0W2EtzANZ+WE58XZLg1zCH
         s7lTUyPTDo1oOFaOGGvl5/uwjJHOdvgpTWIfwb4U+QXKJBFBj9STB2MKLr84UikXY/Aw
         nyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855178; x=1743459978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrvR0aOcLIcAWx4e/98EnSWBHvNd6Y8j5/3yZVSpxaA=;
        b=jlmN1pOEBk7jzVnPlRguGos7eC4HJgiVnKjbm3X9ePMLFQC6aBMhxvgiqAjUU+1j+i
         /E0Qmw1uQna74JHr7DZOnHGXedV9meUTrhiiSYhWVKpj3w/PqWFu5eu15V5pUGwr2Lm4
         Dydidme8ahpE1dcLg1/cPrz55JMh/Q8MR1KFbPmB9x05IMyJE9Esb/ywEd1Q5amr2b/k
         3jDRkAEFWP5/CnSkg15ouWlPiTxr94bn40gO94/KFxVwB7UxkTtEYdf7m6vl4acGM36j
         PrkBcaw4zOOWqpILmuaexJGcaecR6VwyxxS/lCUKR7C2PepLlHybBHryTvqvgm9w8UeF
         J2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCV4sn88FSrBVTn2UCtTqqzrBvJMjn17gJeIJldzUo1PBD7w90ymcXueVaT31YRlMBrFxzS8OUxKZaxmpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbt0wYz9YiP07EyZV4o40tW4AOYneOq8gRVsuvhhFAEnOQPQB6
	wx9yQtQGXW4wV9IvsZ+O70SdriOF1jI97uUNbdbviz7wyaVBUvusDGn5ePHuZDHtBKgTgGR1V7Z
	ONmO7wIypzDw3tdKBbjq/qzF7TK756SE2TcCxig==
X-Gm-Gg: ASbGncuLl05FqnTjXArK4PXctGqq5mifnRqMZUgO/UsD97jZPV+2Q3HbjjB6sqVX1HD
	2T1Fozb/VOfGaA+bhE9P2p2P1gd8r4j9qhoLDpXxzQWxSdf8C5rkE8IhMZz7ST6u7n06cQPnBaH
	2C9krJfCdY7NnHy6SAQ+5hdntGaw==
X-Google-Smtp-Source: AGHT+IHEuoOmdsDRjio3NzdLf9VqVRH72VMW5JQn+EaCXJEuqHnIL/a0PZZBIRQwotYAsErXJhdXTyjt2RtaDGu9IvM=
X-Received: by 2002:a17:90b:3887:b0:2fe:b45b:e7ec with SMTP id
 98e67ed59e1d1-3030ff157e7mr7974206a91.8.1742855178264; Mon, 24 Mar 2025
 15:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324134905.766777-1-ming.lei@redhat.com> <20250324134905.766777-5-ming.lei@redhat.com>
In-Reply-To: <20250324134905.766777-5-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 24 Mar 2025 15:26:06 -0700
X-Gm-Features: AQ5f1JrFRkoXZehDjXXBy8CTz9LB3BKhjMEsQJd9Un-62Gf6w0anjK5takKH_38
Message-ID: <CADUfDZo4jmifYJwDRsX0FMemxDiuRu_XG6GV6+drVUOgDk3QwQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] ublk: add segment parameter
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:49=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> IO split is usually bad in io_uring world, since -EAGAIN is caused and
> IO handling may have to fallback to io-wq, this way does hurt performance=
.
>
> ublk starts to support zero copy recently, for avoiding unnecessary IO
> split, ublk driver's segment limit should be aligned with backend
> device's segment limit.
>
> Another reason is that io_buffer_register_bvec() needs to allocate bvecs,
> which number is aligned with ublk request segment number, so that big
> memory allocation can be avoided by setting reasonable max_segments limit=
.
>
> So add segment parameter for providing ublk server chance to align
> segment limit with backend, and keep it reasonable from implementation
> viewpoint.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 15 ++++++++++++++-
>  include/uapi/linux/ublk_cmd.h |  9 +++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index acb6aed7be75..53a463681a41 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -74,7 +74,7 @@
>  #define UBLK_PARAM_TYPE_ALL                                \
>         (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
>          UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> -        UBLK_PARAM_TYPE_DMA_ALIGN)
> +        UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
>
>  struct ublk_rq_data {
>         struct kref ref;
> @@ -580,6 +580,13 @@ static int ublk_validate_params(const struct ublk_de=
vice *ub)
>                         return -EINVAL;
>         }
>
> +       if (ub->params.types & UBLK_PARAM_TYPE_SEGMENT) {
> +               const struct ublk_param_segment *p =3D &ub->params.seg;
> +
> +               if (!is_power_of_2(p->seg_boundary_mask + 1))
> +                       return -EINVAL;

Looking at blk_validate_limits(), it seems like there are some
additional requirements? Looks like seg_boundary_mask has to be at
least PAGE_SIZE - 1 and max_segment_size has to be at least PAGE_SIZE
if virt_boundary_mask is set?

Aside from that, this looks good to me.

Best,
Caleb

> +       }
> +
>         return 0;
>  }
>
> @@ -2350,6 +2357,12 @@ static int ublk_ctrl_start_dev(struct ublk_device =
*ub, struct io_uring_cmd *cmd)
>         if (ub->params.types & UBLK_PARAM_TYPE_DMA_ALIGN)
>                 lim.dma_alignment =3D ub->params.dma.alignment;
>
> +       if (ub->params.types & UBLK_PARAM_TYPE_SEGMENT) {
> +               lim.seg_boundary_mask =3D ub->params.seg.seg_boundary_mas=
k;
> +               lim.max_segment_size =3D ub->params.seg.max_segment_size;
> +               lim.max_segments =3D ub->params.seg.max_segments;
> +       }
> +
>         if (wait_for_completion_interruptible(&ub->completion) !=3D 0)
>                 return -EINTR;
>
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index 7255b36b5cf6..83c2b94251f0 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -410,6 +410,13 @@ struct ublk_param_dma_align {
>         __u8    pad[4];
>  };
>
> +struct ublk_param_segment {
> +       __u64   seg_boundary_mask;
> +       __u32   max_segment_size;
> +       __u16   max_segments;
> +       __u8    pad[2];
> +};
> +
>  struct ublk_params {
>         /*
>          * Total length of parameters, userspace has to set 'len' for bot=
h
> @@ -423,6 +430,7 @@ struct ublk_params {
>  #define UBLK_PARAM_TYPE_DEVT            (1 << 2)
>  #define UBLK_PARAM_TYPE_ZONED           (1 << 3)
>  #define UBLK_PARAM_TYPE_DMA_ALIGN       (1 << 4)
> +#define UBLK_PARAM_TYPE_SEGMENT         (1 << 5)
>         __u32   types;                  /* types of parameter included */
>
>         struct ublk_param_basic         basic;
> @@ -430,6 +438,7 @@ struct ublk_params {
>         struct ublk_param_devt          devt;
>         struct ublk_param_zoned zoned;
>         struct ublk_param_dma_align     dma;
> +       struct ublk_param_segment       seg;
>  };
>
>  #endif
> --
> 2.47.0
>
