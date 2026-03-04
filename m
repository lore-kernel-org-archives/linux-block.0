Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE42382F29
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772656996; cv=pass; b=u4JYFcHXJ5Gz/dBwN4Q6H3Ry+WoBEVw2lo9wBAYV36kq+lmNTNnkTAdxhBl9TaE3MVF2s5hY7Bfn2cEnQIYYwl6ctiq1qSD60wgqXMGctiEg96AgmUjXClbXijfZIn2EDzRkAQzXqdyTbSVmHwb0DcZtOZ2fuypfLnK0LWAURWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772656996; c=relaxed/simple;
	bh=kXRayUzc0An2ekWDRIOOqFAJEDxQRDrtTjDBta3tJG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZ9+kOgmDWOcQ81IgY9X/vJJVxxHODVJTD7urkwpz/uNbCXpdPKBhnbIeVkQpzMFygHVofNppX32BM2TjnyhIlYTskjAI1cHnS6ZLX8sCEKJBox8nhBVQhYo4Wrr0XWMysaZ1n5G2EsNJsr8jzW40AC/uxyUcNRFLxG99N2ij3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=P9bWBzmq; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="P9bWBzmq"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-41574fa6a87so129474fac.3
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 12:43:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772656994; cv=none;
        d=google.com; s=arc-20240605;
        b=VUXHzH41w07d4V9xQnFX36YQ6vWQXSPGeilW6RkLCddKW/PxIcJ9t3ndxXoWWXNF9z
         itmT1bNUqtHPoTJvILS4JWjKPv3WO+kSwHrFLrsXiFNhBrKj7jfyKLr29joMdb8iV3U0
         MKtCsGJSAnhDfXr9wdug/w7Mi19Lf6LGitxUsN1QBajy1OGHb8oRIaYM9DwxDDfClWFk
         ty06kwdAMiMtl0LOPP7slE4/TWfjkdhyu5+M4kqp8iYiLpVNChEgvBBxzlLmMU/FioTi
         rtWdhr65ScfJd23+YVD1YEmb0j6m0Ki1IG0E/P/LPEWV1LBxR0T2DO5qKR2gagcDdNXr
         aptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=isxQMFWkq85udAXUyQfVQLfE6hxAvcAVxO3u9Yrqbmw=;
        fh=s9EWEF7sMjmzA2cZ9NkmTNZwDptiJsEyi6ECb3lgCBU=;
        b=anGJ/3Fm4306Umx59jib69KwBtzNyVy4AHZKTYuioSfT++euZUa+xX/bp9UGudS6iv
         CQ5qaHbAOZl5IM8CFfW7QQxn4KWdf+nY9PiqVrs0UxDPpJ50XDVsylm/zadUPawRNQdy
         AF9u6TrEcv7j/80WDWuCzesR/4jiJqjEhOHck+bk1Bmy0Zutag1aZTaEnh7IZ5r/EyGb
         +bRAhiTNBSDBc5H8RhmpVDd5ePa+iZQ/3TY4apjXuKRdLYyylyN8J5Oy/y9GJbVZ0CVR
         BQIGW+ndT2QwBE2EbWO7gIbMYApNoymY3OwECcEo/wgqG9ZF6UM/oXM/qU4RY15OFWhT
         W/JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772656994; x=1773261794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isxQMFWkq85udAXUyQfVQLfE6hxAvcAVxO3u9Yrqbmw=;
        b=P9bWBzmqO60j6pxK/0swqXtuDx5SchavjBCMZgSXOBRWJ5bR0E1s4CeXyp0ckGoOYL
         g0ax429V7f9Afn8ITLKrgxeJW7aVqn2aItwolRiwP6luMq8VvLRj6si5bTTuxy44maO3
         z+nTsu9FXsEp1hU5QpWmExSqxSaN1QUrAt3C9FwzQVJP4QaiTqHJrIn5X9JEc3gmvKT/
         2BG1xblyvWttp0DOWM4GqkUUhfxuGI+AZGtqn8eLGXPmu0yo3cbL7jqagMGnvXBZCGSZ
         jVNHXaUJ8c48EpJdKe/pLB6nA7fi+dBjVRKF1mplcV5HaQE9L4LgDAvsozel66F9JQVg
         DiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772656994; x=1773261794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=isxQMFWkq85udAXUyQfVQLfE6hxAvcAVxO3u9Yrqbmw=;
        b=uNnp9kgjPsw3JDXgG7IIpAlcOcw2gSfdihCOR/ljWhO7zs5DrYtwHr+I2Re/mKtPKp
         IKpdlW083EDrf1Kff8qws1n0k0IJnHFbcH8BdfKXNzBG4lvhYPBDzQIDz2+f1DGHpEGJ
         FZraH7B1Y4JcKAiaJfM7O3OXWCLZbCE4BfL7MvIHgqoCiKvvmFBoHM+c/7jAC/qGkY6/
         MYCv9yuViT7dnVrE6dnpo2g7qowJxj05Be3E5Ul3T5htEgyRQf0rB5BdY5p1LZ+N6mX5
         v6x1+SguuVaUqe5jMHQP/r2St+0S2PQV/BXr724B7Y11tnhoko2HXiTPGtnkNqeAVdE0
         KXeA==
X-Forwarded-Encrypted: i=1; AJvYcCVTOlD81Bvg/cIqWcuIOTSLy8+7IDUrEftOCabcYIZAXkTLhnm1Lhw4aRyUIRnhauZpFIyPAmJZBw5b7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuhDRPq6czyJVoF9kflBaq9qwtbNCmjT/mGf6avFcqFMKiEUso
	HUDUN37QqUnePA2ic/N4QyUo4tiUUEcQBznFwwpaesZUwiYulbkEx001Mcnp68UrvxG+Nly2wkD
	SOB60hGLiJqg0Og+Um/8BzuRVxTFs9evsrM1SMPrpOWVItH+n0pce/wc=
X-Gm-Gg: ATEYQzyzUdCwBGQ8cGFTYgU1RDKT//SYTZ0KZGPtFeH/WlyzVJMOvk0rYn32fGixESV
	BLcQ1LrZrDglAGEafsLD2//Q4Ef4m1fAO73yKCaHGbyOcUXM2Hd3p/+v10AZnNxZXRrgHkRxQhZ
	eaSGYuH8O3kgoAqaGHEDjn+ZE6G2jQI2s24jAJ+pKYht8aQANvmj03nyLBZQsAn1g+O60Mm6irF
	A5/OtRc6HgUG3keuIezdmi7GimTe/4BhSsXsKApGW1QSiXkGtTEziFJ+ZQH0OYUsmeYVLt33OBj
	NV6clIs=
X-Received: by 2002:a05:6808:1b12:b0:463:7120:b576 with SMTP id
 5614622812f47-4651ad99f83mr1488998b6e.8.1772656993876; Wed, 04 Mar 2026
 12:43:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304194843.760669-1-bvanassche@acm.org> <20260304194843.760669-12-bvanassche@acm.org>
In-Reply-To: <20260304194843.760669-12-bvanassche@acm.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 4 Mar 2026 12:43:03 -0800
X-Gm-Features: AaiRm51qtzDzNSnwyS1nx1hPr68Fv6n6MmCnp2UdIPtdP_QDzVlfDYKd4MJFcq8
Message-ID: <CADUfDZon_tUuZzH3we4NdPg_MB-LQsMWbeRrLAiqzBbSM9hG-g@mail.gmail.com>
Subject: Re: [PATCH 11/14] ublk: Fix the lock context annotations
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, 
	Marco Elver <elver@google.com>, linux-block@vger.kernel.org, 
	Ming Lei <ming.lei@redhat.com>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 11:50=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> Add the lock context annotations that are required by Clang. Remove the
> __must_hold(&ub->mutex) annotation from ublk_mark_io_ready() because not
> all callers hold ub->mutex.
>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/ublk_drv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 34ed4f6a02ef..70f2ebde3be9 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -353,11 +353,13 @@ static inline bool ublk_support_batch_io(const stru=
ct ublk_queue *ubq)
>  }
>
>  static inline void ublk_io_lock(struct ublk_io *io)
> +       __acquires(&io->lock)
>  {
>         spin_lock(&io->lock);
>  }
>
>  static inline void ublk_io_unlock(struct ublk_io *io)
> +       __releases(&io->lock)
>  {
>         spin_unlock(&io->lock);
>  }
> @@ -2926,7 +2928,6 @@ static void ublk_queue_reset_io_flags(struct ublk_q=
ueue *ubq)
>
>  /* device can only be started after all IOs are ready */
>  static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id)
> -       __must_hold(&ub->mutex)

I don't think this is right. Both callers of ublk_mark_io_ready() hold
the mutex: ublk_fetch() acquires it directly, and ublk_batch_prep_io()
is called with it having been acquired in
ublk_handle_batch_prep_cmd(). The stores to ub->unprivileged_daemons
and ub->nr_queue_ready would be data races if the mutex weren't held.

Best,
Caleb

>  {
>         struct ublk_queue *ubq =3D ublk_get_queue(ub, q_id);
>
> @@ -3160,6 +3161,7 @@ static int ublk_check_fetch_buf(const struct ublk_d=
evice *ub, __u64 buf_addr)
>
>  static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub=
,
>                         struct ublk_io *io, u16 q_id)
> +       __must_hold(&ub->mutex)
>  {
>         /* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
>         if (ublk_dev_ready(ub))
> @@ -3598,9 +3600,11 @@ static int ublk_batch_prep_io(struct ublk_queue *u=
bq,
>         }
>
>         ublk_io_lock(io);
> +       __acquire(&data->ub->mutex);
>         ret =3D __ublk_fetch(data->cmd, data->ub, io, ubq->q_id);
>         if (!ret)
>                 io->buf =3D buf;
> +       __release(&data->ub->mutex);
>         ublk_io_unlock(io);
>
>         if (!ret)
>
