Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964422101
	for <linux-block@vger.kernel.org>; Tue,  2 Jan 2024 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B33JKf3y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704181104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20j0482Fdaq4UWw24yM7rJf98orkusLkXiPgQ9lpD0o=;
	b=B33JKf3ykbTdo+g6WKlm48hudv17JTcp3IZfQ3IlzKyX39z+kVwW9QFv6lH/5vNQqgB97W
	R94vGAynf9+ncZZMXUMf82H2Zk2nkzG85WAwyxMyrZQCuPhP5MbYlfPjmWduAVXvXTgozE
	lzyW+Vrk5Us20rRvwIQG6kW8soLtNYc=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-1MUGYWmLMHqB_3Zf5GDwYw-1; Tue, 02 Jan 2024 02:38:23 -0500
X-MC-Unique: 1MUGYWmLMHqB_3Zf5GDwYw-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7ccffc4bef4so234377241.1
        for <linux-block@vger.kernel.org>; Mon, 01 Jan 2024 23:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704181102; x=1704785902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20j0482Fdaq4UWw24yM7rJf98orkusLkXiPgQ9lpD0o=;
        b=HAbYCboHkhiY+u7RLO5rGMo8UKnApOqCTmGZ9IDXXN1uKQkppyj0uXRUqP8IfJkSSx
         zL5vcYk+SMiA18yz9MbSkWWGWdDHQfv6q13XXe+s6qv0BZM0E9UcZd5k8oqtXH61AjNk
         erPFYDdZ6NhNh73VclJvUIyb0eZL6HXuVM+nGeyrdsNADvR4mN/mkiCv/h4fRJyJDXkq
         c2s/T/sXji9bok4eD0xG+bRDkSaCXcTG/661NYrsiojHBt5c7Wh4/Zlj0O+4/cAP9MJm
         wJEUSRa/LuHxPGHzQ+lo2EU9k6vrl8IffJ4eTzgxRwImMa/WJwdFc1/aypjQtd6vkvmj
         U38g==
X-Gm-Message-State: AOJu0YzP0gg+b7FQAfMGW6qY1ZKLXluyDbz7th68Vnoi20QzNNO0ZzUy
	+MjrCvHKYwwmgb848TxYRYUyvM9aFToVqdSTMOgjCVstZ7ddwKnbXp5NWrrBEG0WNFj/U8AThtY
	gzGfehHyB0tMAquVkknv0l2A0qKDa1uYCJCdfxy4PU8qpSKg=
X-Received: by 2002:a05:6102:2ca:b0:467:4e1d:e42a with SMTP id h10-20020a05610202ca00b004674e1de42amr6286012vsh.2.1704181102574;
        Mon, 01 Jan 2024 23:38:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfWjpO89uZT/3U/sOkXjQXK1yh9L3iB40D7oIyXpX3ix8A/CPovysEh7QlAJpnuuiC247op4TvgYC5WlhV088=
X-Received: by 2002:a05:6102:2ca:b0:467:4e1d:e42a with SMTP id
 h10-20020a05610202ca00b004674e1de42amr6286005vsh.2.1704181102312; Mon, 01 Jan
 2024 23:38:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219012833.2129540-1-ming.lei@redhat.com>
In-Reply-To: <20231219012833.2129540-1-ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 2 Jan 2024 15:38:10 +0800
Message-ID: <CAFj5m9KQ=cvODNGP_vcqtRT=EzbncUqe_vHbqUPsvYEu6d_PZw@mail.gmail.com>
Subject: Re: [PATCH] blk-cgroup: fix rcu lockdep warning in blkg_lookup()
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Changhui Zhong <czhong@redhat.com>, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 9:28=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> blkg_lookup() is called with either queue_lock or rcu read lock, so
> use rcu_dereference_check(lockdep_is_held(&q->queue_lock)) for
> retrieving 'blkg', which way models the check exactly for covering
> queue lock or rcu read lock.
>
> Fix lockdep warning of "block/blk-cgroup.h:254 suspicious rcu_dereference=
_check() usage!"
> from blkg_lookup().
>
> Tested-by: Changhui Zhong <czhong@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-cgroup.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
> index fd482439afbc..b927a4a0ad03 100644
> --- a/block/blk-cgroup.h
> +++ b/block/blk-cgroup.h
> @@ -252,7 +252,8 @@ static inline struct blkcg_gq *blkg_lookup(struct blk=
cg *blkcg,
>         if (blkcg =3D=3D &blkcg_root)
>                 return q->root_blkg;
>
> -       blkg =3D rcu_dereference(blkcg->blkg_hint);
> +       blkg =3D rcu_dereference_check(blkcg->blkg_hint,
> +                       lockdep_is_held(&q->queue_lock));
>         if (blkg && blkg->q =3D=3D q)
>                 return blkg;

Hello,

Ping...

Thanks,

