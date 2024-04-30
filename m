Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1228BE5
	for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 04:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452591; cv=none; b=IHO11I+yLO78inCC0bPjJRWKMetDzNuOMHiJ0IHmyDMOkAIlccTcihzT+EQhFenil/z7TLplpQvipggmc9ZkvCBOno5RAylYnuVcy37aadlo2s1UtBT14UV4bB8Ix9ZTWuHSI6zZ0GzMcU5DF5Hg/qYkA2C3N3TqKbYy7TDP6qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452591; c=relaxed/simple;
	bh=VQ1N96EbjrEe1NKrUaM1C217aZOtx91+Jh0YrrYveME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6HuHAd4gsno8t6sO9TV8Vn//GlAptBECy4j0oCABKMbXrsGminqxaR3rh6O+x1mpK4vtb4auOxXYaYwIhCmjh1pMHxWjhBdcAhVYDc3InsigPHHOXgJ8ktFqdPJ7FjhnswS6gNLAZ+PmUqjhS0OffXlVMQnqeag1EraDVVffPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpdT/yqi; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpdT/yqi"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4dac4791267so1780746e0c.1
        for <linux-block@vger.kernel.org>; Mon, 29 Apr 2024 21:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714452589; x=1715057389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItSQ26q2YZUEpV+ZFz+IP6EN2hihJvGt6vO5eficMMg=;
        b=SpdT/yqi9SoegP4dFj+jRttBFb+faJXLhrRUv2JLLyh/GpN2m1KJ90oqgba3fmuyEl
         J2KkiIpBe+fS6BnQf8Smx0/ipbUY9zqZOj6qvaAQyDIBxNU2acRM5E7TP2ex9CuA22PJ
         VFemzmLp4tG4iTdYewYVTv+i44MCDapaZxi5U+t4JmWBibh9Qk8eDFtUT35OVJx3vNZ3
         +iP59EHyLHHilGetsAfbqIxzH4VARLvzMaH5BZQu7C07vxBCdt4CeB/t+vxuqCHVEl0P
         eoI95QCyXyhL5+/sQngn2PVG9eo40Ag6zYtu9DCdFhanSWmAb46lERedIO30uG7sKWhm
         skpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714452589; x=1715057389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItSQ26q2YZUEpV+ZFz+IP6EN2hihJvGt6vO5eficMMg=;
        b=slHMnq6k3io6MHY4oVPEOZbKiiiz2lNwfyDZIiUjnyHLXiOTB6mWbZi6YlujGZdbJe
         4juAVx7+blRnyZBO4XDKvoPKbtS0PRBAj48M2tlk8EwCmHBCE3kvkJLrzon4JRwKFfFo
         Fv4hQ/nDN8Xg8fvRj0qMO4h1rwPQOmrRpVCf/GGw28unH1qDMBFx2e1v2t5SESgXq5FB
         vRFwxHIVmQtPfFTyB799PLOCbfGvXdkv0FMHVCFGW5Le+vV8vevJ3waIjqRl4iTNSUAy
         y2FX2CRyqS61LzgQbonMV97BuYT+Igbj2b4JHIbQYQHE0D7oZ0zRQgggvy59FJM1Oksz
         BLHA==
X-Forwarded-Encrypted: i=1; AJvYcCVMSaILB5sq0XRnsOshhHpg4YJynhFtu5J78OYpVXizZFjfJ0RSA3NBM5Gt65d79P4+g/C5eyEdWGX2w9copHyiABn03dQVyJoQApU=
X-Gm-Message-State: AOJu0YyNIlf0G/yL8uqU7lHZDbUvY8oIwcyxUwHx9OhkrVdYXnqOTvV5
	g2DAYkjn7gsVG8TCN99fRDex+gixjsuY1yu0fXjMTBdNFKYMRg6FVJo3MVPm6ZJz61MWyqU7tIP
	f1uM4Li2pL6k+B3wIYgYsT9hhzQ==
X-Google-Smtp-Source: AGHT+IHKK4t2ubCHumP7WUtBKSZVKeZq+sjUYYsc1kZ1RQ+IcYNueimW5Fsgr0LeARPqeFQsWnC5m355rqj0sHr1YVY=
X-Received: by 2002:a05:6122:918:b0:4d4:2398:51a2 with SMTP id
 j24-20020a056122091800b004d4239851a2mr10993915vka.8.1714452587133; Mon, 29
 Apr 2024 21:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <19d1b52a-f43e-5b41-ff1d-5257c7b3492@redhat.com>
In-Reply-To: <19d1b52a-f43e-5b41-ff1d-5257c7b3492@redhat.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 30 Apr 2024 10:19:10 +0530
Message-ID: <CACzX3AsAwXorQ2H90L61oT0cut0GLL0O82zecy+o_p3mkSR=BQ@mail.gmail.com>
Subject: Re: [PATCH] block: change rq_integrity_vec to respect the iterator
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 12:07=E2=80=AFAM Mikulas Patocka <mpatocka@redhat.c=
om> wrote:
>
> Hi
>
> I am changing dm-crypt, so that it can store the autenticated encryption
> tag directly into the NVMe metadata (without using dm-integrity). This
> will improve performance significantly, because we can avoid journaling
> done by dm-integrity. I've got it working, but I've found this bug, so I'=
m
> sending a patch for it.
>
> Mikulas
>
>
> From: Mikulas Patocka <mpatocka@redhat.com>
>
> If we allocate a bio that is larger than NVMe maximum request size, attac=
h
> integrity metadata to it and send it to the NVMe subsystem, the integrity
> metadata will be corrupted.
>
> Splitting the bio works correctly. The function bio_split will clone the
> bio, trim the size of the first bio and advance the iterator of the secon=
d
> bio.
>
> However, the function rq_integrity_vec has a bug - it returns the first
> vector of the bio's metadata and completely disregards the metadata
> iterator that was advanced when the bio was split. Thus, the second bio
> uses the same metadata as the first bio and this leads to metadata
> corruption.
>
> This commit changes rq_integrity_vec, so that it calls mp_bvec_iter_bvec
> instead of returning the first vector. mp_bvec_iter_bvec reads the
> iterator and advances the vector by the iterator.

We also encountered this issue with split and had a similar solution [1]
This needs a fixes tag too.
fixes <2a876f5e25e8e> ("block: add a rq_integrity_vec helper")

>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>
> ---
>  drivers/nvme/host/pci.c       |    6 +++---
>  include/linux/blk-integrity.h |   12 ++++++------
>  2 files changed, 9 insertions(+), 9 deletions(-)
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
> @@ -109,11 +109,11 @@ static inline bool blk_integrity_rq(stru
>   * Return the first bvec that contains integrity data.  Only drivers tha=
t are
>   * limited to a single integrity segment should use this helper.
>   */

The comment here needs to be updated. rq_integrity_vec now becomes an
iter based operation that can be used by drivers with multiple
integrity segments.

> -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> +static inline struct bio_vec rq_integrity_vec(struct request *rq)
>  {
> -       if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
> -               return NULL;
> -       return rq->bio->bi_integrity->bip_vec;
> +       WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1);
> +       return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
> +                                rq->bio->bi_integrity->bip_iter);
>  }
>  #else /* CONFIG_BLK_DEV_INTEGRITY */
>  static inline int blk_rq_count_integrity_sg(struct request_queue *q,
> @@ -177,9 +177,9 @@ static inline int blk_integrity_rq(struc
>         return 0;
>  }
>
> -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> +static inline struct bio_vec rq_integrity_vec(struct request *rq)
>  {
> -       return NULL;
> +       BUG();
>  }
>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>  #endif /* _LINUX_BLK_INTEGRITY_H */
>
>
[1] https://lore.kernel.org/linux-block/20240425183943.6319-6-joshi.k@samsu=
ng.com/
--
Anuj Gupta
