Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5694B136663
	for <linux-block@vger.kernel.org>; Mon,  3 Jun 2024 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717432713; cv=none; b=GNvp93Mow8W1s25oPzhztebcSM+vE1n4Ash1WodD57++R72syDjOovh5YQByrGtHhunZ+Hdxou6C2FJ9eRkBWYny/VrFpZFJEsoqJZKpPCWzt3yKEvngyprco/893/uRe3V3abQSkxPv2UmS2Iq09fmy/669mgOfPKz/MP5n5rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717432713; c=relaxed/simple;
	bh=81rFzW9TbeYlnDmYQ0JUIHazYZgIhWCzQO91O4qLEfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IH47/U/QneOM0vxzKFCI6cTUscyD/qWB6cZn2ITwXyp1FLJBIAeZHAJRkwxp2ozzTAZy79eoBEOUIiAkKeEgPg4EuQlAhJvQXe48ehYB8KgF0zpyP/tIrGmJhtfvjn7+/x0lof2jnUzT6F4lJLhckUav5WKTE7/8uNxZnFF4VvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGYHQRm8; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGYHQRm8"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4eb167e9175so346763e0c.1
        for <linux-block@vger.kernel.org>; Mon, 03 Jun 2024 09:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717432710; x=1718037510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmVt+zRf5HDzmy5BGVb1iNkMXtAfU8YSXemBM2r9RPo=;
        b=gGYHQRm8jSJc8gnN4C1JUQ/6CmdGjZDmr4lzZ5scAZjTD7DNF95aeQchelizRViXa2
         yvGZG/Kj1btyth60O9ILhk2SOc0Zl02RE4AZo66UeA8RFi0e7FoR5DXUXl2AhnGTLaqr
         y/4Gs1euPaesaKGG+HyYZs+SUqUQ0SpZt69FVHDILYieZ+qHiUjpe8c82RYyBRZU4e6d
         mGSxhc9ZfHpIQXtv3S3lRFx6+yrXwnRXlU3A3au40/lVRhMLA5ebjgvmU8WY+0h5pHyt
         K9cZiKW9wJt1Bpox/v/tnceDbkYyJ6ZeQE6yvukvDWU0jpZcj8FhK2ZsIy0Fai3/Za1b
         DKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717432710; x=1718037510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmVt+zRf5HDzmy5BGVb1iNkMXtAfU8YSXemBM2r9RPo=;
        b=tC6Vy3jPWeIixiLu4amyWDd8WuDavrEk6HfWuk5mDsepzBptH4YAzPMnmCO/1gtAvY
         UVXuYQWJRdi9IC3vlOoWYfYsLpBpepV3MX8sfjwvGYetEGVD0kyRGdMilhoE03rsnhCi
         lWgbTKTdzcF/7fK8kjV0aEhfmsg4txmsGH0sEkuHsGQ8K8DmRFCXtn9XiQ4bZ9UzW61t
         dtJABmIZhrUmM32UMQTxprygJmsTZxNJVqRNwKM6va0ujmOascpEo1YBNv51AnXL7s9S
         9izhpd7YXochbNgkHbD7b2qNVU/Lb4LEIdJBU9UB82NgiYV5ptYA/z6OpeQFO8vG/uIH
         gW7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9j1L4Ai/Yy4zCvU/NB5VIutJT7013oiJgz20nw5JeER2lakYHcN0iXyvfVLbjuoDsJt/lo5Byyn7FsVu3LjSyHd5hFZ2Z/cW5CZQ=
X-Gm-Message-State: AOJu0YypJENApTzS16eLjk7s2BpEb0iUAUQmY97DAKAOhney4lpkqkW2
	zHai614jEPdR0ZnrwlZqJaNnzgHrcREBJOr/1ybSxA//p/0fk6vwVAbgzcRwRryTC3ip1+2TCce
	AGxw+8eB+mhOM+lXkMbMyI/osyg==
X-Google-Smtp-Source: AGHT+IElysqrqxRL/8QRnPtUhB/HUw65r9f5t1Ma1Xz8cgSkiEE7X0TUmoS9qum5rjp7pfEgfHtO0s+Oc4SGIMy4zz4=
X-Received: by 2002:ac5:cdaa:0:b0:4dc:d7aa:ccf9 with SMTP id
 71dfb90a1353d-4eb02ededd7mr6994674e0c.12.1717432709978; Mon, 03 Jun 2024
 09:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240513084939epcas5p4530be8e7fc62b8d4db694d6b5bca3a19@epcas5p4.samsung.com>
 <20240513084222.8577-1-anuj20.g@samsung.com>
In-Reply-To: <20240513084222.8577-1-anuj20.g@samsung.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 3 Jun 2024 22:07:53 +0530
Message-ID: <CACzX3AuJ3gOV63FyK+0vPvn4WxeY5+QdzUG_XNw2iGKtC2CuPw@mail.gmail.com>
Subject: Re: [PATCH v2] block: unmap and free user mapped integrity via submitter
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	martin.petersen@oracle.com, Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 3:02=E2=80=AFPM Anuj Gupta <anuj20.g@samsung.com> w=
rote:
>
> The user mapped intergity is copied back and unpinned by
> bio_integrity_free which is a low-level routine. Do it via the submitter
> rather than doing it in the low-level block layer code, to split the
> submitter side from the consumer side of the bio.
>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
> Changes in v2:
> - create a helper for unmap logic (Keith)
> - return if integrity is not user-mapped (Jens)
> - v1: https://lore.kernel.org/linux-block/20240510094429.2489-1-anuj20.g@=
samsung.com/
> ---
>  block/bio-integrity.c     | 26 ++++++++++++++++++++++++--
>  drivers/nvme/host/ioctl.c | 15 +++++++++++----
>  include/linux/bio.h       |  4 ++++
>  3 files changed, 39 insertions(+), 6 deletions(-)
>
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index 2e3e8e04961e..8b528e12136f 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -144,16 +144,38 @@ void bio_integrity_free(struct bio *bio)
>         struct bio_integrity_payload *bip =3D bio_integrity(bio);
>         struct bio_set *bs =3D bio->bi_pool;
>
> +       if (bip->bip_flags & BIP_INTEGRITY_USER)
> +               return;
>         if (bip->bip_flags & BIP_BLOCK_INTEGRITY)
>                 kfree(bvec_virt(bip->bip_vec));
> -       else if (bip->bip_flags & BIP_INTEGRITY_USER)
> -               bio_integrity_unmap_user(bip);
>
>         __bio_integrity_free(bs, bip);
>         bio->bi_integrity =3D NULL;
>         bio->bi_opf &=3D ~REQ_INTEGRITY;
>  }
>
> +/**
> + * bio_integrity_unmap_free_user - Unmap and free bio user integrity pay=
load
> + * @bio:       bio containing bip to be unmapped and freed
> + *
> + * Description: Used to unmap and free the user mapped integrity portion=
 of a
> + * bio. Submitter attaching the user integrity buffer is responsible for
> + * unmapping and freeing it during completion.
> + */
> +void bio_integrity_unmap_free_user(struct bio *bio)
> +{
> +       struct bio_integrity_payload *bip =3D bio_integrity(bio);
> +       struct bio_set *bs =3D bio->bi_pool;
> +
> +       if (WARN_ON_ONCE(!(bip->bip_flags & BIP_INTEGRITY_USER)))
> +               return;
> +       bio_integrity_unmap_user(bip);
> +       __bio_integrity_free(bs, bip);
> +       bio->bi_integrity =3D NULL;
> +       bio->bi_opf &=3D ~REQ_INTEGRITY;
> +}
> +EXPORT_SYMBOL(bio_integrity_unmap_free_user);
> +
>  /**
>   * bio_integrity_add_page - Attach integrity metadata
>   * @bio:       bio to update
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 499a8bb7cac7..2dff5933cae9 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -111,6 +111,13 @@ static struct request *nvme_alloc_user_request(struc=
t request_queue *q,
>         return req;
>  }
>
> +static void nvme_unmap_bio(struct bio *bio)
> +{
> +       if (bio_integrity(bio))
> +               bio_integrity_unmap_free_user(bio);
> +       blk_rq_unmap_user(bio);
> +}
> +
>  static int nvme_map_user_request(struct request *req, u64 ubuffer,
>                 unsigned bufflen, void __user *meta_buffer, unsigned meta=
_len,
>                 u32 meta_seed, struct io_uring_cmd *ioucmd, unsigned int =
flags)
> @@ -157,7 +164,7 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
>
>  out_unmap:
>         if (bio)
> -               blk_rq_unmap_user(bio);
> +               nvme_unmap_bio(bio);
>  out:
>         blk_mq_free_request(req);
>         return ret;
> @@ -195,7 +202,7 @@ static int nvme_submit_user_cmd(struct request_queue =
*q,
>         if (result)
>                 *result =3D le64_to_cpu(nvme_req(req)->result.u64);
>         if (bio)
> -               blk_rq_unmap_user(bio);
> +               nvme_unmap_bio(bio);
>         blk_mq_free_request(req);
>
>         if (effects)
> @@ -406,7 +413,7 @@ static void nvme_uring_task_cb(struct io_uring_cmd *i=
oucmd,
>         struct nvme_uring_cmd_pdu *pdu =3D nvme_uring_cmd_pdu(ioucmd);
>
>         if (pdu->bio)
> -               blk_rq_unmap_user(pdu->bio);
> +               nvme_unmap_bio(pdu->bio);
>         io_uring_cmd_done(ioucmd, pdu->status, pdu->result, issue_flags);
>  }
>
> @@ -432,7 +439,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struc=
t request *req,
>          */
>         if (blk_rq_is_poll(req)) {
>                 if (pdu->bio)
> -                       blk_rq_unmap_user(pdu->bio);
> +                       nvme_unmap_bio(pdu->bio);
>                 io_uring_cmd_iopoll_done(ioucmd, pdu->result, pdu->status=
);
>         } else {
>                 io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index d5379548d684..818e93612947 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -731,6 +731,7 @@ static inline bool bioset_initialized(struct bio_set =
*bs)
>                 bip_for_each_vec(_bvl, _bio->bi_integrity, _iter)
>
>  int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t l=
en, u32 seed);
> +void bio_integrity_unmap_free_user(struct bio *bio);
>  extern struct bio_integrity_payload *bio_integrity_alloc(struct bio *, g=
fp_t, unsigned int);
>  extern int bio_integrity_add_page(struct bio *, struct page *, unsigned =
int, unsigned int);
>  extern bool bio_integrity_prep(struct bio *);
> @@ -807,6 +808,9 @@ static inline int bio_integrity_map_user(struct bio *=
bio, void __user *ubuf,
>  {
>         return -EINVAL;
>  }
> +static inline void bio_integrity_unmap_free_user(struct bio *bio)
> +{
> +}
>
>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>
> --
> 2.25.1
>
>
Hi Jens,
This has got the necessary reviews. Can this be picked up?
Or do you see anything missing?
