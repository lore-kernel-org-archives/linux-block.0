Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205F735CBC5
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 05:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763183521; cv=none; b=sqIaX5A92aetbIrSI6PjweerT1TAe2pBzi8ckrMpq3LH9M5skTW+LlzZcScjCFB+nqvvJxTUw19uAkb6VIB78HkWadRmXCn4qTv3j+s9palGxWAMIifQu8lrvhat0FxCDAwqh9GCkjX07sVRx4KldCPXvmsnDiO0wrOVDdj3ZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763183521; c=relaxed/simple;
	bh=olmrWzN4GVAzaWYHa+MLrY/WctxMS2ZjtTYvSNYLNfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ds5W/pwa4Ud2ccf6YVwVBPqVy5fvNtTQ70f/98kcDzDOgxoYtj7yb8idjmlItfU9NL4h0hp3UiJc4KttE/y3p3/REmCRC73CnEzLA/8QVVED9/qhLiiPws1qlzJWTdlMWSYcd5TunNTcnXz8F+gAhsIYZAaWlqUqOTNvS78DHLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=R9rwR5rt; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="R9rwR5rt"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3436b2dbff6so475272a91.2
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 21:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763183518; x=1763788318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GDISc4xvjrO0RVhk956G5qqdontSirylmMUhVLl4BA=;
        b=R9rwR5rtc0l0s2QtcYkOn9wgx5yvjAcf2bYXn1Nh72vUC1Odz1vjL/yQbYNopzpD/D
         m0tq4svXWKUKFXEQhcO4S6gUZvXTXIW7abFY0KDhbZR6S9q0FpqVjSbN9TQ3f1z1igbB
         tOBNdxipBKNSoLR+4CS3I9BMKVwwAUzr1eqqFIno9yuq/6JmhGYVrXzN8+GY0rkwgf/D
         xalBod98NJO5ivkduwCF5de5S9Ied2iemv/JZ2+2BTl5DpeV23aGAHdGmyeOI0k8t4Yp
         cixHKp19G+ihgfvI0ENL7NBktUeReZiY569IYQpkiL0I7pg/jcoEEdwbBMKjC/FEIc2B
         R1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763183518; x=1763788318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+GDISc4xvjrO0RVhk956G5qqdontSirylmMUhVLl4BA=;
        b=nFUKOZiGtQqb1SM2a+PbWM6kgoAhESC3Fiog9VIOUIIO0JnH3rEh3TwBqifPJ6Kuiz
         Q+gtvKhKqzsi6OFJORgmfFCibt6fMFa+gNcelsTQtPYCr/8dq7qcYN4RZPxQNnLYbqUM
         arlw3qZLpwd32jYNad8y0KBAHyIvymAitTV31rbv9obT+0cLJAr858/RNI+7qZg39xyg
         KSV9RGtS+oPhOMXwIhlDUZxdvqJugq/CM9P5SNUWgUjdqJSeYg7BRrosONRKzIYjzhTU
         FAGMqdpNyVfiQGuxYFlMUh+Rk6ZobdYDh2HDO98OlXs3HSp/4M5okw+oVTmgxVXWPtXM
         HhJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY67zL1c7BeQHES4l0FVrRou0yo0k8M9EuzA2yaTO8wxTEqrXOm1SEXpe6Ooh8YMPjZjbsr8lN53xdMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0VKKGgFX/SolNViD7TUo/FdfYmtpYrPw6pxG2BNW1IO93d/iB
	UODtqTjGZk3mOcuJKR5BQKuGadi+yRnugAq4PIXysqwETVw7C5BPdv/64eFMFY12bT8z10IrxnE
	yQCCmEyL0ZDg/505mnLiWTN38QfquVJA3wF9ux7PvZQ==
X-Gm-Gg: ASbGncug8yiAEzHRWLX03TduYoz56KHKdonA/GGum05zT+BTdXaVtM4NzNGwKre3moK
	Kdc33k5iTlgLNMotBZ7JJiA0A4RQLoOw7VPJ65K7+4zniIe/RJ2wlRhYeuKMmc0PiBf3rjMC1z8
	RwpvbBxmq+GqFufp2VvHEDHkkp5ByWjl3XV0ou7cmQvppoy6Q1fw4JsrOtgRvrHtIdLuGacSJv0
	pwg9C5X+1VqFBz52VE7IM5jRMQ+PYmjaEJCBC3C9qARMkmXWKKJDC/iJ/iUL/a7iMNhGqNe
X-Google-Smtp-Source: AGHT+IHEFhyHGegPrh4ykgeuh8FloFo6H7nMAwR8c9530m9u3UKP4SpyDS7BqcScB9VmR6sQqw/oWqgjhEvryeIEFwU=
X-Received: by 2002:a05:7022:224:b0:119:e56a:4fff with SMTP id
 a92af1059eb24-11b41405607mr1792089c88.4.1763183518099; Fri, 14 Nov 2025
 21:11:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112093808.2134129-1-ming.lei@redhat.com> <20251112093808.2134129-6-ming.lei@redhat.com>
In-Reply-To: <20251112093808.2134129-6-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 14 Nov 2025 21:11:46 -0800
X-Gm-Features: AWmQ_bnvdB0xCV5u630ISZ9V6ru46pqbQUbK_Di4i3O6RVvkRc38_B4pXOcPKGA
Message-ID: <CADUfDZp0vK9LOsso5aG3ZSBDbL-9o99q1BwSbg_o0akFEk3hRg@mail.gmail.com>
Subject: Re: [PATCH V3 05/27] ublk: pass const pointer to ublk_queue_is_zoned()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 1:38=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Pass const pointer to ublk_queue_is_zoned() because it is readonly.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  drivers/block/ublk_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index b36cd55eceb0..5e83c1b2a69e 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -265,7 +265,7 @@ static inline bool ublk_dev_is_zoned(const struct ubl=
k_device *ub)
>         return ub->dev_info.flags & UBLK_F_ZONED;
>  }
>
> -static inline bool ublk_queue_is_zoned(struct ublk_queue *ubq)
> +static inline bool ublk_queue_is_zoned(const struct ublk_queue *ubq)
>  {
>         return ubq->flags & UBLK_F_ZONED;
>  }
> --
> 2.47.0
>
