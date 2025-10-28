Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE6128AB0B
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761688359; cv=none; b=n4mflshmHNzjgv0SpZkZDHAR2bZg3h2Tzw4iXaRmqfrdxkDBg2eotgEikl8TETgdaS7OjgrKwvUOZcxf4Ib0MYLzVUcdYNzn+cXeNQs11MvxGLH54205jkox6FLTVquoOSi5dWEAJx4LbO3Mr7eY8CfNRPKxHb4hNBAaxz5bNZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761688359; c=relaxed/simple;
	bh=EPAdca6VBDnxo5Q+mh9iiDqFcecKTa0JcSLQtI/GwqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbqWIaM86eOWwk7H4EOk8cQM+gfgqHRT23Z8cpTNhUGPPHb2JVECR1iTW9GCPxoktqdTFJtcdVXSd87mP/O9SlGm0EgS01ll6npn05BiZDS8NXmyyuM8z5TnKNVhW1ceF17vvEnBhoMq0FXhBeshrN93UcN9zYjEUwCNk1ZJWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WCcyVTHs; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WCcyVTHs"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29245cb814cso13530415ad.1
        for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 14:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761688357; x=1762293157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7J6niER6ZpiDQVvofMKZNARqeF73XKzpfTD8QhPj1wo=;
        b=WCcyVTHsya0GUtFOfNiK62aBwS9HNXyTqZRYXXOgiFWMVgseZUtI9+z9uOnRxgzurZ
         t+Xg0m0bk4CSNQbUVX22rZaxoMvccFpIVk1+MEc/W9DrG86z3pYPt3LHM8SfUMyMl3Jl
         qeu39/D+sFsbzydv+xybLWoRIGYbhEGACByjSlvkv1jIdfEJPkw4fDiR80LFNNXVPV0P
         3Vlw/BOUHxUCV7uq63zwKsSgZhhEfHDkR12BL5rXTGdv/eZXOY9iKNIuTh9BeF5pdwDJ
         AIhGB2kHYd7w0Ty1OC04uedoclyCqTPITqAOzZpXBPabAHQhRar7b1pYY7S9aM8CjOET
         UOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761688357; x=1762293157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7J6niER6ZpiDQVvofMKZNARqeF73XKzpfTD8QhPj1wo=;
        b=FY10C6qf9PM1ZbYAZUeKjGnYvnNmOJ0vhDAdaDEh+VhyUE2hu2zsDyhxRCG5HlvoDa
         imAm5AY0mz6b3ofGKfYpjk7EalxgJgdk29cApIvDDMRZl/gYtsR/qkT1U3QrwCW119b2
         SmIN3Ru1Lpc3j+pUDOjlVmu9HuxNrorG34w5T9mz8NxuWkcgmyL1r+W/8Ib6e0wnZjFu
         a1lkU5C9OJZUsH2nYY3eTw+/jM/qWx+aYIHAW/YT82+fTOfkIEgFM4dgqJymVCvw7KQd
         DDQ4MXGjU/8r0QUcveTwa+2xl2u8XwI84oHWzU1OxTatRXgpAjCR4j0OFCgjhYKklVuv
         X95w==
X-Forwarded-Encrypted: i=1; AJvYcCVsI/T1+o2mNbMH8jZ7ejON1hUCg8DL9UAt0sfqeKAa3RU6/gAqYfaOH/gyAFrp8IvTBGf6SHsCNV/nEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL43NcRXXB1iTkS2ZNdAJiLyD1+xITqapjmS9WWmhlg8bIgzlh
	FmdBvw/ZK3qJw3DbHgWABBMt/DkEBZEPLCogBIjayXVTvwRT2BB9LVsnIeqrtpzdnCxGuMtZsYS
	PBzD1o3H90oidhYKAmwPP+h3cyKsZmgeyMhC8DiYgxQ==
X-Gm-Gg: ASbGncueS9G+dE7HK0gpwkrfbwzE0hZrRQ9ONlaaWFWc9h51dHst0bCrS8r1aF2A0rh
	KRgB1OOkemp+KaRgAr2BzoOoNiqNWFlBJuVHcsczXStYA84+6e4B+NRFRwW0bJOSkBz0xJf9wVw
	lq5I5HfXZRjkbZm8Rvv/w5U5wUdFLpxkwzhiXKpAvG5YEzkzcj8ViKl46a359RDkt3aiqd+LTAQ
	kd1MFB7GSGHIONati104BMZn3/thqSQvLFd4XCRKZgAI88TIVcwkUKL6vYKbxUgaJJjIsr1lPrx
	6ApYEji3apZZiX7teL5FtrH747Hveg==
X-Google-Smtp-Source: AGHT+IETVj07RNwcuaC7jaZLE+XmaOhDLQF66zEUrpUCiujAiXPOhWCYs9D57TVd8W/Yn4ppFXff2Gjp4xy6h5gY8ks=
X-Received: by 2002:a17:903:3846:b0:26c:3c15:f780 with SMTP id
 d9443c01a7336-294def34564mr3384505ad.8.1761688356873; Tue, 28 Oct 2025
 14:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028085636.185714-1-ming.lei@redhat.com> <20251028085636.185714-4-ming.lei@redhat.com>
In-Reply-To: <20251028085636.185714-4-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 28 Oct 2025 14:52:25 -0700
X-Gm-Features: AWmQ_bnIA-JvzpK2jKcJ-7vXkDANHKWOuIHxLOvM1ANuRnIoubWq-elzhqotRSc
Message-ID: <CADUfDZr-4iq752TrPjb8a9u_Wsa73dFMz_Z5_P8rmJjPUe5dGQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/5] ublk: use flexible array for ublk_queue.ios
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 1:57=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Convert ublk_queue to use DECLARE_FLEX_ARRAY for the ios field and
> use struct_size() for allocation, following kernel best practices.
>
> Changes in this commit:
>
> 1. Convert ios field from "struct ublk_io ios[]" to use
>    DECLARE_FLEX_ARRAY(struct ublk_io, ios) for consistency with
>    modern kernel style.

Documentation/process/deprecated.rst suggests that
DECLARE_FLEX_ARRAY() is discouraged except in the niche cases when
it's necessary (which don't apply here). Or am I misunderstanding
something? However, struct ublk_io ios[] does seem like a good use
case for __counted_by().

>
> 2. Update ublk_init_queue() to use struct_size(ubq, ios, depth)
>    instead of manual size calculation (sizeof(struct ublk_queue) +
>    depth * sizeof(struct ublk_io)).

Sure, this looks like an improvement.

Best,
Caleb

>
> This provides better type safety and makes the code more maintainable
> by using standard kernel macros for flexible array handling.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 394e9b5f512f..cef9cfa94feb 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -203,7 +203,8 @@ struct ublk_queue {
>         bool fail_io; /* copy of dev->state =3D=3D UBLK_S_DEV_FAIL_IO */
>         spinlock_t              cancel_lock;
>         struct ublk_device *dev;
> -       struct ublk_io ios[];
> +
> +       DECLARE_FLEX_ARRAY(struct ublk_io, ios);
>  };
>
>  struct ublk_device {
> @@ -2700,7 +2701,6 @@ static int ublk_get_queue_numa_node(struct ublk_dev=
ice *ub, int q_id)
>  static int ublk_init_queue(struct ublk_device *ub, int q_id)
>  {
>         int depth =3D ub->dev_info.queue_depth;
> -       int ubq_size =3D sizeof(struct ublk_queue) + depth * sizeof(struc=
t ublk_io);
>         gfp_t gfp_flags =3D GFP_KERNEL | __GFP_ZERO;
>         struct ublk_queue *ubq;
>         struct page *page;
> @@ -2711,7 +2711,8 @@ static int ublk_init_queue(struct ublk_device *ub, =
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
