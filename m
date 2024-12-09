Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFEA3D76
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 03:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733714318; cv=none; b=dSh4qbu6Xs4KbGq8ssyF24SKSwC1KHnFq7IyptBZ+qJ4OL5G5RDwvT4PN8CxrWtXpxv9gsYiLl7/GdBqTgcW0jlUJpsg2ilag78XxkLSjaDUa3fsPf4rOCLYKiZSV+Li0O9p7M5H9TjAV3F45LKh8SL2IR3THbl6OtWtIIFta94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733714318; c=relaxed/simple;
	bh=sYlQiwMKskV/KnK2FaP8Wwkq/HVyFPIkyFQJ9T9Lsbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuUKmeM6ySEhrTL+Q/ma5OQUt7MWJH+YTKYFPAQQLW+193/x6OBbTNRQc0zMwVlhIQTvLLyR37COe+Ai+/suAiV7IJsUFBWmF7YjDOZp138m0DqzhgNHTJcjWu3YXTBxhMJUu5O3QQ0RIGDqL+ziFPDQWjisRfu9zBVz4HjsG6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXfsTk9S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXfsTk9S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733714312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqKAdDC4bBMcS5Kb0Zl2MqrDGAA/DGMxDICLb9E5k58=;
	b=VXfsTk9S6Yij/4XyML66MrN8DLq0xsf8W+FmC99RiE3S5XZcZ45AzltXvJhKzEVA0iTs7P
	HMdemK3uGp1fScYD/2VT0+V8NFDEwFBLhOc+ycGQeA22zbNC8IgIQ38Bby5sZdDj3yxG7I
	yjUvvoivlZgvA0WcUe2ZkIDgOwx7tPo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-Co8eBSz2PO6Ekq27C2yhAw-1; Sun, 08 Dec 2024 22:18:30 -0500
X-MC-Unique: Co8eBSz2PO6Ekq27C2yhAw-1
X-Mimecast-MFC-AGG-ID: Co8eBSz2PO6Ekq27C2yhAw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434edbbc3a7so10884235e9.3
        for <linux-block@vger.kernel.org>; Sun, 08 Dec 2024 19:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733714308; x=1734319108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqKAdDC4bBMcS5Kb0Zl2MqrDGAA/DGMxDICLb9E5k58=;
        b=bMlJKrkRACo+G0JjwXrID9hqG3/Z4zdveKxUCQlCqhWF/mvpZ/9QVlS5RDVSdoHp6K
         i2e6RDo+VuTX1MkIlRraECgSeULsqkIuI2iZ771y70JLcwcWBEJ0AuQHPCiXOSmd2vxa
         Wl+cgdfZ4nWObjscr1xD7wKmWxDCEvGr2/wklhOgwfbozZTvFxiOV0NyIKMl70FaLK4H
         PAk6DZyswD0Zd7YFde8UC0s+UaCKuT/VoKdxhLQDd/SSWkybzp5wLC9H5PQCVLDVBqDF
         j+/ah4sl4USZryodYKIiOsNijmK/A2NlOsH7p/39eCJWcsd6p6omlB5rW0V0N2qez9Ay
         4PlA==
X-Forwarded-Encrypted: i=1; AJvYcCVoN7oaY7lk7wFgLWP+WJ8GDHUsf5Dgz8tqd9R5divBsogC0Glyo1y0OC15Cx0SBvbPMzqIHqs65hxPpA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy0pl5jtWjQsM6PF7Y+n12lvbNHx2GevkwumMkaWcNwDLUqnDs
	ir/wIGuXI81tc49iFBwRKX7oj+sMYKw6oBfhxXBTUf2Beci8wNG8tIHDsQdFQpQcNxzdZL6KaJT
	fzDHyfZmd+kGh60zQLH+uOEl7qGzT0V4oZVJ+0d/qQs0wgfMUYR6dUIkQS0x6z3Qsng/IpTF4SP
	/6PZcbxqwdcoBtK2yosZGGTijo2KaqlXMY150=
X-Gm-Gg: ASbGncuYpe0RaAQaWwYMGCfdEuPgH06vRW5vvUwWku0KJYBnDtmt1L80o1tIBcqljhw
	UGgf3YWMPwGpmRpzpDovjh6sfq40kfwO/
X-Received: by 2002:a05:6000:186b:b0:385:e170:d5b8 with SMTP id ffacd0b85a97d-3862b3ceaf7mr8399682f8f.42.1733714307984;
        Sun, 08 Dec 2024 19:18:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXh1bSXqLx50Uqt/lP4rBmVcRrKM3JyDAym+vhC6UFjWpZ/NdG2+pXOm3+Vn3VVvBNgu1v0/3oL6SwgeQL5RI=
X-Received: by 2002:a05:6000:186b:b0:385:e170:d5b8 with SMTP id
 ffacd0b85a97d-3862b3ceaf7mr8399674f8f.42.1733714307673; Sun, 08 Dec 2024
 19:18:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206110427.976391-1-ming.lei@redhat.com>
In-Reply-To: <20241206110427.976391-1-ming.lei@redhat.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 9 Dec 2024 11:18:15 +0800
Message-ID: <CAHj4cs_TcSgM6fmSN5u5xEbUecEPDFwVRv0U6P1h+-W_cME=TA@mail.gmail.com>
Subject: Re: [PATCH] blktests: src/miniublk.c: fix unaligned mmap offset for
 64K page size
To: Ming Lei <ming.lei@redhat.com>
Cc: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Verified with 6.13-rc1 64k kernel.

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Fri, Dec 6, 2024 at 7:04=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> The 'offset' passed to mmap() has to be PAGE_SIZE aligned, which is
> always true for 4K page size, but not true for 64K page size.
>
> Fix it by adding helper of ublk_queue_max_cmd_buf_sz().
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  src/miniublk.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/src/miniublk.c b/src/miniublk.c
> index 565aa60..73791fd 100644
> --- a/src/miniublk.c
> +++ b/src/miniublk.c
> @@ -472,14 +472,24 @@ static struct ublk_dev *ublk_ctrl_init()
>         return dev;
>  }
>
> -static int ublk_queue_cmd_buf_sz(struct ublk_queue *q)
> +static int __ublk_queue_cmd_buf_sz(unsigned depth)
>  {
> -       int size =3D  q->q_depth * sizeof(struct ublksrv_io_desc);
> +       int size =3D  depth * sizeof(struct ublksrv_io_desc);
>         unsigned int page_sz =3D getpagesize();
>
>         return round_up(size, page_sz);
>  }
>
> +static int ublk_queue_max_cmd_buf_sz(void)
> +{
> +       return __ublk_queue_cmd_buf_sz(UBLK_MAX_QUEUE_DEPTH);
> +}
> +
> +static int ublk_queue_cmd_buf_sz(struct ublk_queue *q)
> +{
> +       return __ublk_queue_cmd_buf_sz(q->q_depth);
> +}
> +
>  static void ublk_queue_deinit(struct ublk_queue *q)
>  {
>         int i;
> @@ -516,8 +526,7 @@ static int ublk_queue_init(struct ublk_queue *q)
>         q->tid =3D gettid();
>
>         cmd_buf_size =3D ublk_queue_cmd_buf_sz(q);
> -       off =3D UBLKSRV_CMD_BUF_OFFSET +
> -               q->q_id * (UBLK_MAX_QUEUE_DEPTH * sizeof(struct ublksrv_i=
o_desc));
> +       off =3D UBLKSRV_CMD_BUF_OFFSET + q->q_id * ublk_queue_max_cmd_buf=
_sz();
>         q->io_cmd_buf =3D (char *)mmap(0, cmd_buf_size, PROT_READ,
>                         MAP_SHARED | MAP_POPULATE, dev->fds[0], off);
>         if (q->io_cmd_buf =3D=3D MAP_FAILED) {
> --
> 2.47.0
>
>


--=20
Best Regards,
  Yi Zhang

