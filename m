Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BC717E8E7
	for <linux-block@vger.kernel.org>; Tue, 28 May 2024 03:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716868101; cv=none; b=d2a7QKybbwCQKvtNoTDd+VkGssG8OqXsgXsmtC4yanlZ8OJSv3x+7shwCNjQVcTCUp7lf25te7gkI4gBL+KfgfafZixfjWj2bpYtso1b8BMr3W8DiRlzJUMA3r3XQlO+thXUkv6OkoCwhQ7rHFB2m7qbWttr4PuVjmnAv3Y3Szc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716868101; c=relaxed/simple;
	bh=yyeBDjI04HvU5PJEMYDx4SQI7kbJQ7UbZoy41Jy4YF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwdGipDlnSBbqoYR5MyOAoeEaUW8F3JsFAql39LJH+zrOagtwoFFu/jl3Yf0llbbTUeTfDtxvkWHxi17hBI9W5lVQyIemq773Z+iXmrYmk96KJtIDWrCV3wBd36mAO51/tQ6WaE9IId3IIwV87u4GgtYMUlAxUIzZB2Lj2PbiTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfbxV3Cj; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfbxV3Cj"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4e4f02f4c6fso101390e0c.2
        for <linux-block@vger.kernel.org>; Mon, 27 May 2024 20:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716868097; x=1717472897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMwY3jSjxqwMDaKFlhd/s9pzladNU9TjXZV/5WHBypU=;
        b=GfbxV3CjRU+IYzwO+qlb3fJSAfGsfuUPy9dQ+q+G31VVQIEx64w4IRNskUe/vvrZgI
         S//ml5X9dSBbgb/0tkUBMLMTfQAT+flsvGy0yPJQ7lLFjiJvQVfH5acg7HFPqXPKXJWr
         CUxFdSnNznz1oTefX+QYDXhxqldN/0R3i8twrTFpsIEC4wYnHzDx/5KI/tDK2jsAszf6
         477UqhKfkcoAYKyLNQzlY4YXfM8WAkaNEw0HfjN85yfcR8EDs/j5nMtRMtoxev9G0jwm
         TsVOG0ZFiXtx87mxnrV/OvwR44GCTz/aowGsDPr+o+qpvJHHMYsSr/5r1JvBjAjo/5sC
         gbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716868097; x=1717472897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMwY3jSjxqwMDaKFlhd/s9pzladNU9TjXZV/5WHBypU=;
        b=t6UZD2vxlbLBjrkyRspjeE9hGSAfgTEluH5xKnp3B1+h5noAjm6JDZJGN1/fh8nWaN
         5cwk2Bgkp3wGYKM3dtfIl4d36+YrGccFIrXL36l+FeU2BAzfyxlQLIU82SFdpIDlprr6
         N2dFVC/BLlg4DPK+EnQIzk+6/co0njsSfM70fyIOIZtcv8hbwdrRWPcTYhj/6PSOE8c1
         U4RKguZX0SJgWT/sBn4uP9tHt8OfLZMYrhiZ3V7gqvRgHltK+VXhyARdFrifgSRjcUkN
         j1YiEnX5e615WO7BqwydTgI6y5XbHqQi4m20Imz+5sqbSLVIly7bX8dIMyETWbHb3JId
         2bgw==
X-Forwarded-Encrypted: i=1; AJvYcCVaYls32s93JEFN0r7CUh6ZVCIilUeYpmFx0wVKBbISKQtxBUM4QGG6jQmr6AHlVKfOFqX1IV4VETt0ghKAYQ6dZm8DtuL/rqXbeJI=
X-Gm-Message-State: AOJu0YzBhk8784vBMBp8BI6JvNkMLp8/7wKmnYUv8pzYm560IGovRYB+
	SKbi2hkBpq4K8nO94L2Wbwd4qFWmeKtOawucXWHKfYTqIddlkZ2S1yO+1IGAFm8c16ByVDDMREq
	7KCMbXtNTC9K0a1VR/2DsWDw+9g==
X-Google-Smtp-Source: AGHT+IEebTthiV+k9KwZYbfA6UqXjceghKuE5RhC9df1UxBYQNbJVxSNh4yrualQ39ZzH38xtnqX/A3NTiH2tP5u528=
X-Received: by 2002:a05:6122:3c54:b0:4e4:e998:bf88 with SMTP id
 71dfb90a1353d-4e4f02e3f3dmr10489613e0c.13.1716868097258; Mon, 27 May 2024
 20:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <719d2e-b0e6-663c-ec38-acf939e4a04b@redhat.com> <49d1afaa-f934-6ed2-a678-e0d428c63a65@redhat.com>
In-Reply-To: <49d1afaa-f934-6ed2-a678-e0d428c63a65@redhat.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 28 May 2024 09:17:40 +0530
Message-ID: <CACzX3AvanzKyVFsyWOLyQMXo8oYOX=fggPaW_Uej+KUNfhMmFA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v4] block: change rq_integrity_vec to respect the iterator
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 9:10=E2=80=AFPM Mikulas Patocka <mpatocka@redhat.co=
m> wrote:
>
> If we allocate a bio that is larger than NVMe maximum request size,
> attach integrity metadata to it and send it to the NVMe subsystem, the
> integrity metadata will be corrupted.
>
> Splitting the bio works correctly. The function bio_split will clone the
> bio, trim the iterator of the first bio and advance the iterator of the
> second bio.
>
> However, the function rq_integrity_vec has a bug - it returns the first
> vector of the bio's metadata and completely disregards the metadata
> iterator that was advanced when the bio was split. Thus, the second bio
> uses the same metadata as the first bio and this leads to metadata
> corruption.
>
> This commit changes rq_integrity_vec, so that it calls mp_bvec_iter_bvec
> instead of returning the first vector. mp_bvec_iter_bvec reads the
> iterator and uses it to build a bvec for the current position in the
> iterator.
>
> The "queue_max_integrity_segments(rq->q) > 1" check was removed, because
> the updated rq_integrity_vec function works correctly with multiple
> segments.
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>
> ---
>  drivers/nvme/host/pci.c       |    6 +++---
>  include/linux/blk-integrity.h |   14 +++++++-------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> Index: linux-2.6/drivers/nvme/host/pci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/nvme/host/pci.c
> +++ linux-2.6/drivers/nvme/host/pci.c
> @@ -825,9 +825,9 @@ static blk_status_t nvme_map_metadata(st
>                 struct nvme_command *cmnd)
>  {
>         struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> +       struct bio_vec bv =3D rq_integrity_vec(req);
>
> -       iod->meta_dma =3D dma_map_bvec(dev->dev, rq_integrity_vec(req),
> -                       rq_dma_dir(req), 0);
> +       iod->meta_dma =3D dma_map_bvec(dev->dev, &bv, rq_dma_dir(req), 0)=
;
>         if (dma_mapping_error(dev->dev, iod->meta_dma))
>                 return BLK_STS_IOERR;
>         cmnd->rw.metadata =3D cpu_to_le64(iod->meta_dma);
> @@ -966,7 +966,7 @@ static __always_inline void nvme_pci_unm
>                 struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
>
>                 dma_unmap_page(dev->dev, iod->meta_dma,
> -                              rq_integrity_vec(req)->bv_len, rq_dma_dir(=
req));
> +                              rq_integrity_vec(req).bv_len, rq_dma_dir(r=
eq));
>         }
>
>         if (blk_rq_nr_phys_segments(req))
> Index: linux-2.6/include/linux/blk-integrity.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/linux/blk-integrity.h
> +++ linux-2.6/include/linux/blk-integrity.h
> @@ -106,14 +106,13 @@ static inline bool blk_integrity_rq(stru
>  }
>
>  /*
> - * Return the first bvec that contains integrity data.  Only drivers tha=
t are
> - * limited to a single integrity segment should use this helper.
> + * Return the current bvec that contains the integrity data. bip_iter ma=
y be
> + * advanced to iterate over the integrity data.
>   */
> -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> +static inline struct bio_vec rq_integrity_vec(struct request *rq)
>  {
> -       if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
> -               return NULL;
> -       return rq->bio->bi_integrity->bip_vec;
> +       return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
> +                                rq->bio->bi_integrity->bip_iter);
>  }
>  #else /* CONFIG_BLK_DEV_INTEGRITY */
>  static inline int blk_rq_count_integrity_sg(struct request_queue *q,
> @@ -179,7 +178,8 @@ static inline int blk_integrity_rq(struc
>
>  static inline struct bio_vec *rq_integrity_vec(struct request *rq)
>  {
> -       return NULL;
> +       /* the optimizer will remove all calls to this function */
> +       return (struct bio_vec){ };
>  }
>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>  #endif /* _LINUX_BLK_INTEGRITY_H */
>

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
