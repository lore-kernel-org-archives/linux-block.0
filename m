Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304E2A927
	for <linux-block@vger.kernel.org>; Wed, 22 May 2024 00:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716338316; cv=none; b=A7XC7hxgMU65MXcZC+LJXXBkmIt4sSrrqFZSpLaEXMiWKFW02tRv2eysrQR2bgl27XObqqmUj8jjFxAkfV2dVEVYpcUTCt51d8mtht+fH4fPby9iUUQVIGFMS5WMu4VzsDiHkzqBr+ZaJVEHAwrbFNUN6LV+rdcx0saa04TzyXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716338316; c=relaxed/simple;
	bh=a/18lV88j0NDu6vM8zsb6c3ihQ8XHs6fmV6BAX8CGcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHFwuOan0F5LTedVY/Qr08l+6Nq9ogQJtNSxOGHupNtFTMJZoVX0TTE37CKK2P5Y1UUEkup8jFd1dBhh1rsFppcIhbsLJoP0tQG7krs3wdZnNr6RzsKwDjNYPSGBzvPZLDv8F+Bk6AtIWnyF4kYC5aat9DZ50wilEe2ohKf2JKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ax6lxHeR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ax6lxHeR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716338314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whmyphBAx9qpsIKF8MrhzX17A3NAPqvOPD2XlHs8Spo=;
	b=Ax6lxHeRWmFPz2bHSo/L//k/VYogPrnWVTmsy9jT6CHUVc+qiPTbGDDMDaggWinJ1iaU+C
	YC2lVyChHQMlbvyJ5rGKx3k/bXhuE0Hz7QOJIDiygPOw8dB656YA/HoErckcuG/MPyQDd2
	TD7dk8VXP0JOznNEj9T2x7EplmyeV2U=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-tARflZRdNjqmHbpNkly6EA-1; Tue, 21 May 2024 20:38:32 -0400
X-MC-Unique: tARflZRdNjqmHbpNkly6EA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ee089eedb7so13948916b3a.1
        for <linux-block@vger.kernel.org>; Tue, 21 May 2024 17:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716338311; x=1716943111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whmyphBAx9qpsIKF8MrhzX17A3NAPqvOPD2XlHs8Spo=;
        b=tppC6N1ZaKYf2ZuL7f3IW78oOgiE4hBgmjZGfUssSDLe3ufiga/XGxCGj80LWgvF48
         QEn4BGEVOQuqDnyoeQA8PmKBXQlZpuEML+EN2yZL5u9Dn/3Gssfh/HYQ+cmR8AXmKsv+
         HR4AZJdEnruihluTJuY3qU4KQxE7yF7/3urJzsFmv189G6p81x+IGHgbtZfvHMFnkNDe
         oS8TzeubpCabKxdmqsoIJR5zIHUFZFwVLGyaQ0eoFht4z00ORg14k/ZZ3LVy47uoNGTG
         /XyxxoIAwTpwI8YVLAv3qXu8BEusbtQi4ylJkXxpLzEggZPpVUUiEAneICx//swOeQDj
         gzkg==
X-Forwarded-Encrypted: i=1; AJvYcCVhJoC0EZJLhjPdsNHlMTPA8/x+HCtWGAUwj+DGmzH3oMIWjZJdG4XhUXG7R4D6zDscd7WdNlNsVsWIG2HohoMjLLF+WbELCrq1/y4=
X-Gm-Message-State: AOJu0YxpawRYyI5hnjubng8vSUWSZUc/o0WBz/0bvArUwTuYui1bOqbo
	sAErGUfDwUHZ44iL/m7F1q5c+pKdy5zgn9MIVVXYWRU2x4W+ZPYV9lmtgDQ/zOAjMv7VOGlQsZI
	KVHvCMNbckf1LZV8WF6EnmF3KFtEa4G+WlDAP+uQ9dTzdvYvnr1RBGLiWTKKypmIJXF/ap2B1zt
	vPs1a7vx5yPXD+rzlpIwHdEz86CIkJ0MFg8cU=
X-Received: by 2002:a05:6a00:148a:b0:6ed:434f:e73a with SMTP id d2e1a72fcca58-6f6d61b39c5mr496875b3a.30.1716338310671;
        Tue, 21 May 2024 17:38:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQDnWmUqPhmLFoOLHD0Ojge2E4RgMVYJLPsK/eRetFFpEyzlwGNK5hTWJ/bVxJEA0Jpreivfn/LwEebaWCXBY=
X-Received: by 2002:a05:6a00:148a:b0:6ed:434f:e73a with SMTP id
 d2e1a72fcca58-6f6d61b39c5mr496855b3a.30.1716338310155; Tue, 21 May 2024
 17:38:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+UZ4stcktsHw0r8ks8LCfXvYJyT+zv93wEfGuuLswArnw@mail.gmail.com>
 <20240521200308.983986-1-yukuai1@huaweicloud.com>
In-Reply-To: <20240521200308.983986-1-yukuai1@huaweicloud.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Wed, 22 May 2024 08:38:18 +0800
Message-ID: <CAGVVp+WrW8nL1+h52LBcS7uP5M1DjzMxHfwvW42VHvid4nZfKw@mail.gmail.com>
Subject: Re: [PATCH -next] block: fix bio lost for plug enabeld bio based device
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: xni@redhat.com, axboe@kernel.dk, yukuai3@huawei.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 8:10=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> With the following two conditions, bio will be lost:
>
> 1) blk plug is not enabled, for example, __blkdev_direct_IO_simple() and
> __blkdev_direct_IO_async();
> 2) bio plug is enabled, for example write IO for raid1/raid10 while
> bitmap is enabled;
>
> Root cause is that blk_finish_plug() will add the bio to
> curent->bio_list, while such bio will not be handled:
>
> __submit_bio_noacct
>  current->bio_list =3D bio_list_on_stack;
>  blk_start_plug
>
>  do {
>   dm_submit_bio
>    md_handle_request
>     raid10_write_request
>      -> generate new bio for underlying disks
>      raid1_add_bio_to_plug -> bio is added to plug
>  } while ((bio =3D bio_list_pop(&bio_list_on_stack[0])))
>  -> previous bio are all handled
>
>  blk_finish_plug
>   raid10_unplug
>    raid1_submit_write
>     submit_bio_noacct
>      if (current->bio_list)
>       bio_list_add(&current->bio_list[0], bio)
>       -> add new bio
>
>  current->bio_list =3D NULL
>  -> new bio is lost
>
> Fix the problem by moving plug into the while loop, so that
> current->bio_list will still be handled after blk_finish_plug().
>
> By the way, enable plug for raid1/raid10 in this case will also prevent
> delay IO handling into daemon thread, which should also improve IO
> performance.
>
> Fixes: 060406c61c7c ("block: add plug while submitting IO")
> Reported-by: Changhui Zhong <czhong@redhat.com>
> Closes: https://lore.kernel.org/all/CAGVVp+Xsmzy2G9YuEatfMT6qv1M--YdOCQ0g=
7z7OVmcTbBxQAg@mail.gmail.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-core.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 01186333c88e..dd29d5465af6 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -613,9 +613,14 @@ static inline blk_status_t blk_check_zone_append(str=
uct request_queue *q,
>
>  static void __submit_bio(struct bio *bio)
>  {
> +       /* If plug is not used, add new plug here to cache nsecs time. */
> +       struct blk_plug plug;
> +
>         if (unlikely(!blk_crypto_bio_prep(&bio)))
>                 return;
>
> +       blk_start_plug(&plug);
> +
>         if (!bio->bi_bdev->bd_has_submit_bio) {
>                 blk_mq_submit_bio(bio);
>         } else if (likely(bio_queue_enter(bio) =3D=3D 0)) {
> @@ -624,6 +629,8 @@ static void __submit_bio(struct bio *bio)
>                 disk->fops->submit_bio(bio);
>                 blk_queue_exit(disk->queue);
>         }
> +
> +       blk_finish_plug(&plug);
>  }
>
>  /*
> @@ -648,13 +655,11 @@ static void __submit_bio(struct bio *bio)
>  static void __submit_bio_noacct(struct bio *bio)
>  {
>         struct bio_list bio_list_on_stack[2];
> -       struct blk_plug plug;
>
>         BUG_ON(bio->bi_next);
>
>         bio_list_init(&bio_list_on_stack[0]);
>         current->bio_list =3D bio_list_on_stack;
> -       blk_start_plug(&plug);
>
>         do {
>                 struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
> @@ -688,23 +693,19 @@ static void __submit_bio_noacct(struct bio *bio)
>                 bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[=
1]);
>         } while ((bio =3D bio_list_pop(&bio_list_on_stack[0])));
>
> -       blk_finish_plug(&plug);
>         current->bio_list =3D NULL;
>  }
>
>  static void __submit_bio_noacct_mq(struct bio *bio)
>  {
>         struct bio_list bio_list[2] =3D { };
> -       struct blk_plug plug;
>
>         current->bio_list =3D bio_list;
> -       blk_start_plug(&plug);
>
>         do {
>                 __submit_bio(bio);
>         } while ((bio =3D bio_list_pop(&bio_list[0])));
>
> -       blk_finish_plug(&plug);
>         current->bio_list =3D NULL;
>  }
>
> --
> 2.39.2
>

Hi=EF=BC=8C Kuai

the raid1 and raid10 issue has been fixed by this patch=EF=BC=8C
please feel free to add:

Tested-by: Changhui Zhong <czhong@redhat.com>

Thanks=EF=BC=8C

