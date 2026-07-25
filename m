Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E36129AAEA
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785007149; cv=pass; b=YUwI2ZefbDEoEJvrozM4EgOv9Ud9j+l/U3lemInkl2RurQe1mI6wNiYH5XW/SyOenuQiE9dhnIBhRUvc5VSRythpoqpi0vSfbAdbbF5RbVJ7OQsReqsh3hkOSdCYNkVrYaEXhBhH39XNu+Apip933OU5rBalWoHKT/bB30IIszM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785007149; c=relaxed/simple;
	bh=T8zwm8QhLSuQA9+E3OX2J/oLjudjveeXT+7DImBd6TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFxAU2lIaJRhDAXHYnY5X2rIWPmYj+dud2wR3eiq8YXjQgQyIfk2Ld1L5e3evD5e2+uohKGYAX99rRoznHCTD3p9+A//lgkJ616WXijJMxgYdz+YYrJN3YgubKsEGKTdB6fSHHGRZMoZjL3RQj+Y39tDkNZnuEHR1zPQxo25XKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KFKzorcv; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KFKzorcv"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43ccd57a931so312945fac.0
        for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 12:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785007146; cv=none;
        d=google.com; s=arc-20260327;
        b=GT8GWW0LXMbSI93XhosBzsqgP7q5607jl6WkZ4rQrixEFzahl6BWJLU+sAEesHWpSE
         ecJYEjn04KZKUUVmRDagFPq9VM5X3CQbBH8k0MMu3p4451ulGfEESVLd60VKSvZnPIVT
         3R2QGZeY8AJq22wk7U1BKp8+/3wQCZGrPRFPWKrWc9HnnR9pjSp8IlLXXnTponuoJIG2
         zd4gvanUy0NQPxU2VfcqKTAGNaJcuWHh4ghnFvMa5xYHAoLbKDa9ZUe7H9+ioGaKCyYX
         jFc5wrWW2Q+8SSBRjDSUku0tHdCjX7UDUxsDpTxvvjNjtOZcfiWZ3r8lnqyHWdnDEtx9
         U5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jWgm6co6pXhHaItsuSR7VaMCmCnMpKZ8efD8kAtRia4=;
        fh=bUKAMZ46n2eZed/LcInT7yw/1lC3CRLgxkV23aQv6rY=;
        b=mS/Oh8O8o6hX48DLfkoClhlBBg6wkVGLvEFhHx+Ne+LfCjFH0jyfariOkW+wQE9afq
         pb10GvgqQV52MXLnB56ludBTw7c2GztmWkRROTy3VBauFNPHrbUcWLjqZjsWGKcWrlxF
         H6p8A/JXop/oYhaMp/qg+Nicrpg2PHWtqOgzevqKkLq9xffuf6xhZPNLl9QQnffictzT
         gF/N5mMrewkr+Jwzxg/ggtXuXLTOy8Q1GmpeGYK/a7ODxEiwlXOUJHNydJrQcOuhvzgx
         gVuSM5eK97ZvcJbhRU1n1wjW1rBRJvJE4qgle0l+qPyonK1zEbCDHGjKelrP2BilvE63
         e0Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785007146; x=1785611946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jWgm6co6pXhHaItsuSR7VaMCmCnMpKZ8efD8kAtRia4=;
        b=KFKzorcvQ98We58KSdOc2M0GpaZRsT+26Xq0o/z1OVD4SPTiNteG1jazgoQLNV9Qbh
         ZL10APPQkPplTamBgqp6OPP9tRO76ua0lImUbKe5EKcRrks2kH974KBtxiP7rDwaGbnt
         eZhTi80egnawPLAz3iDl8mztSg+IxDmDcY65QdXAxx+FyRY6ZQRENkV5UMuOt5kKtSOO
         29LpEv783Z/NrZT2+Fb34KCKJGHyqiHewJ/dj2ds+GY3AIu7tSeup6OfSOlNKBSs+L+j
         +zvxi8MV38y6k42wVKu3SJj9Cyp81+x8hruj5H9ShICU3v38wO3D/oPNSf/QbpiuDjdt
         tvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785007146; x=1785611946;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jWgm6co6pXhHaItsuSR7VaMCmCnMpKZ8efD8kAtRia4=;
        b=G2EZfLNO+iS6LrvhIBcv6OWs0GJYnbxh4P4Ky0uiDM1ZhES5YhIGUMFn5YkPgqV7Ve
         yzPZXwqS6XZxZjlipsXdf5HILkURBs2z/iZtb9Iw7qFDqFer5ZQIjKj5mJizAyIIrfui
         naNRsIKlGm2o1ED9EbjRIxjCS5/JdbU/rKYZekYPFEItZO0/+LUufeIUClTg3+S89y9B
         kG4zLzubj+X7xaHgkfNDF6dha9EsXr4Phf8pKj0XrcxXzGDaTRlL9eN884GlvvnbrPZP
         1tV4pOOk/6yKLvepszFe4isq/Wsb3Rtmu1kkF8pATL5FYW3Ed76yd6W5Ml7NKsB/uhgd
         el4Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr9mM1HiZKndH8ts0Fr2U+T+bgMiDZ6ItjXfhMxap4gIzR0bDr1erkJnjuvzbfKmGD108yL68Pvt0eMsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzikXuAR+DU8vdExJTKckFc7rJrX60PuZWnp8/NqyllKMm/DLwA
	6EANCyN0bfgfOHPBiZYO8VpRXa0Y7Sk6MHgJDPH91g1OEnUY1ep6yDq78HxQce7vSO+4zByendF
	ScUs3GMbkMfRH0Y5j7lDaDCqMIc+joMgfYrVI3dyu+g==
X-Gm-Gg: AR+sD13FCC6dph0nbyKl6WTB08OSTJK8ZokjIMz4gYgE4He/VeVZa5S1sz10YceYOGj
	MGeajRGjYRV+o91uZkqz22dauTVr4XrxCdNHOx5DAsVelHQ+DnyItAo+KY2DldpklJMTdqTlfIi
	RYWRWFObCth6D3muohce8uR7bxQss/CB1QMh86iygkEbN7S8GAj4sd7Kb1Il5L+8ZLz43IFG7Qj
	TBDuGRXpEuj47gJ/qWKYwqrYLiSIrlYqAKRDYn6GNNc18fcwUg5cFgMzm0gBOA=
X-Received: by 2002:a05:6871:2008:b0:441:21b4:c9ee with SMTP id
 586e51a60fabf-457f23abf4bmr1646409fac.1.1785007145763; Sat, 25 Jul 2026
 12:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724100327.43482-1-yangxiuwei@kylinos.cn>
In-Reply-To: <20260724100327.43482-1-yangxiuwei@kylinos.cn>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 25 Jul 2026 12:18:55 -0700
X-Gm-Features: AUfX_myLJlM_9VyHEwWjEzSp6A4ddQ9jj_m2Z8XqxUUiqXR57zxHxOs-6sctL1I
Message-ID: <CADUfDZq1djzvp0rmG48jwavAZGWAZ4Fe3BUCCFxLMUPewbcH5Q@mail.gmail.com>
Subject: Re: [PATCH] ublk: configure io buffer before taking uring_cmd
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 3:05=E2=80=AFAM Yang Xiuwei <yangxiuwei@kylinos.cn>=
 wrote:
>
> With UBLK_F_AUTO_BUF_REG, ublk_config_io_buf() may fail on invalid
> auto buffer register data in sqe->addr. Calling ublk_fill_io_cmd()
> first leaves UBLK_IO_FLAG_ACTIVE set while io_uring has already
> completed the uring_cmd. The tag can no longer be fetched, and
> device teardown may hang or complete a stale command.
>
> Fixes: 52460dda3a77 ("ublk: move auto buffer register handling into one d=
edicated helper")
> Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
> ---
>  drivers/block/ublk_drv.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index c2c11f2a01e7..d932a4026031 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -3295,9 +3295,9 @@ static int ublk_fetch(struct io_uring_cmd *cmd, str=
uct ublk_device *ub,
>          * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
>          */
>         mutex_lock(&ub->mutex);
> -       ret =3D __ublk_fetch(cmd, ub, io, q_id);
> +       ret =3D ublk_config_io_buf(ub, io, cmd, buf_addr, NULL);
>         if (!ret)
> -               ret =3D ublk_config_io_buf(ub, io, cmd, buf_addr, NULL);
> +               ret =3D __ublk_fetch(cmd, ub, io, q_id);

I'm not sure this ordering works either. __ublk_fetch() is responsible
for checking that the I/O is in a valid state to fetch (device not yet
started, I/O not yet fetched). It wouldn't be safe to overwrite
io->buf before this check. Probably it would make sense to perform the
sqe->addr validation before calling __ublk_fetch() and then make
ublk_config_io_buf() infallible.

Best,
Caleb


>         if (!ret)
>                 ublk_mark_io_ready(ub, q_id, io);
>         mutex_unlock(&ub->mutex);
> @@ -3447,19 +3447,18 @@ static int ublk_ch_uring_cmd_local(struct io_urin=
g_cmd *cmd,
>                 if (ret)
>                         goto out;
>                 io->res =3D result;
> -               req =3D ublk_fill_io_cmd(io, cmd);
>                 ret =3D ublk_config_io_buf(ub, io, cmd, addr, &buf_idx);
>                 if (buf_idx !=3D UBLK_INVALID_BUF_IDX)
>                         io_buffer_unregister_bvec(cmd, buf_idx, issue_fla=
gs);
> +               if (ret)
> +                       goto out;
> +               req =3D ublk_fill_io_cmd(io, cmd);
>                 compl =3D ublk_need_complete_req(ub, io);
>
>                 if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
>                         req->__sector =3D addr;
>                 if (compl)
>                         __ublk_complete_rq(req, io, ublk_dev_need_map_io(=
ub), NULL);
> -
> -               if (ret)
> -                       goto out;
>                 break;
>         case UBLK_IO_NEED_GET_DATA:
>                 /*
> --
> 2.25.1
>
>
