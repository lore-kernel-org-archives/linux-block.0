Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404CC25487C
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 03:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769137483; cv=pass; b=uhkifkTMkB+igBvYi7g2gsN6VnSlQ7piEA6iyrUoeuYGOSNwpJDmj+9XhfC1tbR+Qu5ixvscigwjh7JyX9mJ7wMiaoznHPwspz/PpQEgO1Ktab7oRGPaf2ZxzKwHbd3u2H36SL8+VtGz5BYWgeHcYrwff0eMcKFcH/0KBL4L318=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769137483; c=relaxed/simple;
	bh=Cpgb40uV1NYUGZaLYm5XKQrq8FCIo0aYhFqtXSp+YxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLqKmehQLWBmQGYoO+flO0tr6syeNsoXINDkTwTgZLqQRyYCArFMmC3/HgqvvvcBs0a2jJVAqj94Or/H013JtTPmUv2kSeNmLQMob+Vo0cJwSlWKugqaSqufsEpPHbeYsTqeU9mBL3deHjO1jhDxxrutj5KhUJWAn5am2W1FSSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OJiRKK40; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OJiRKK40"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1232c98f98cso129465c88.3
        for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 19:04:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769137453; cv=none;
        d=google.com; s=arc-20240605;
        b=MD+mguDOIE+vSiBNs9ZiJHQf2/MJ4FBRu5xhd3h9t2mTDxPDkgMcBwrl4r05Qgtqlf
         9q2hnc/hQFPKW8k9fjm2I4gNMZND4+gJimb7MpRzKJmk95tEiucmYUBHrTa1gNm0OExp
         x2XrTtbK/MYBZEcLU6TE8lMaSdjh31NneEyj4UHRcw215yruAvZhis/wU/zLfQBtA33C
         UergaTS0C4+Rjc+UkSBOKdGKq/xzPZ+JEPvteWYRi386AzjeD8P6oN9ryOkXozJIy2G9
         joAsgBHyxZtZcS0h/Jfeind9HJOuclXOKpf9yGsj6l4QmEkJkpsh6B4txuGDxCVNbQMW
         wZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cBRSDXB6JMN9S/RlVBs3/WNTXTn6Eip0qhz4zK0c2Ds=;
        fh=dgmJBPyO/P6mcodWSf34g+ujrPmfMmYCDxfiN4gLzSo=;
        b=CF+EEnl+PIIv1DpycQgjoLS3WxIhKTcESyYXAcXAXZS5z/iTG8+ApV8e53Gbtc552N
         HRaHUzhZZyWuzH1/cHf73i42aIV2sB54Qv32PUhJVzy2MTAerXzra7EAUy78DWheM1Wr
         yEZBll6o2QSL7aDob6kT8ZCekiBLdcC18hmi/TIkRM2utcAwHORAgEq8sxublHocRpYd
         JGBuG3/8gOwkbO8fYst1dX36OaHOxj3vCQq/NVqA97akM+zT0+bpLQQGQiPa4DxNontF
         QEVWvO1gwiGMy/PFJtedu3jBUiC21HnCbE16xvuiIml44yaNuJR4VgWnZAo075TugKdC
         dHfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769137453; x=1769742253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBRSDXB6JMN9S/RlVBs3/WNTXTn6Eip0qhz4zK0c2Ds=;
        b=OJiRKK40DK35n9HER9PkiUWFLfDBoRQEJyMAcp9wPDswXrhzR3XANejXpyi3qhXOE/
         lwu9sMxwqnTgbFlDDhvws2EhZWuTWNsE0NfE959Q41QogZi4s5iTsTaxZe0qIfMWrFWD
         5u0KHBj1XiE5mMt9t3OOppqsoYl3VwsPgCNVa35tXpiRWVYS+2OqZ+eeLXmeHA4uMhmk
         ptpLa805YJ8/BgsxO/pXYn1Ibx0obvoy3ZKwfjRpuKbF6sGd3NcosTUErisiFvbMe0Aj
         sgkgM8BnnjX7xaJvdG0N7esBFCiAIVHTsq7OASQRc0fFyrnlUsVqt4Htq2BZ7aw5mfq9
         LVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769137453; x=1769742253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cBRSDXB6JMN9S/RlVBs3/WNTXTn6Eip0qhz4zK0c2Ds=;
        b=pGF7VfVve3e3rjyf/1IgXWgcU7MPt4EgNE6W7HCafinInU4o0v19rV5Sw0ncep2xJb
         l44IhkKNYWA6FqS7N9qVFugypVZw5GTJxhrTHZ3IVW8/UfWGiPUeMFRH38yNUqTYgLNZ
         jfwd5pgPr/XX/M3doL45ZI+wUOzQMMkES9hoUgAB/EHcB6sr1uKwmUqvfO25TCzeIff2
         d58LpjIF8cAtV0xWeGMBIUjvUEGaD1xEBKdiFlibmduJT2fTQU9uh5/92RhxuQiOH3Bj
         xHfJPwfiwgxyFf++Rh8ThwWElPvVDXP1rmfSeECXUcFXQIrel+pTK2lXKLlBZLIcv1lz
         NaJA==
X-Forwarded-Encrypted: i=1; AJvYcCVFdhqb9GziLCYgMrc7CBq/urQ91ybpX1BWkCV/hkY2yzw98yIerihx+CIaPdn8Y6Oy2IOCWt9G5B4A2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaEWwy/qCK+y4fK20ogANsgp99O62LQaK3ySaGS1C9uuLsKa1e
	645CERJhHkxRSe2K9UVS8oCpKRhdMtEvmv0os0H0GvB/AD7IavOMh/JEKzIHNhoougCFTGwiOU9
	CAxMM5CXcMo80Qe0k/c7FswFUT0ad8f8B91sNRbKGAA==
X-Gm-Gg: AZuq6aLitfwSXywknx8jXM5EAw5r3yhlR5JH+hgFY+xvbH7BT/58rqtFLEPxNH4HCb+
	bw4azjq84TnGPyraD0g7d+Z/pQbrkNw42+TTS4k/19h83GjYWt5CbOXa/s38BKi5HPuxC8FOKlm
	Qh8GRJrksAtlW8+B9y92Vv95Yq0K8Nlq22u2oQRJQ6YxTv5RUvoM7YqbzRgkNMhHU1dyMYpZ7Kw
	PeFMPuLvIl4Z6RbyNqQDOHNAHNLnNp3wCvq//LY+edhV0tH2rjoYocvIof+6HY08+n94cj42BZ5
	kCDgqH0=
X-Received: by 2002:a05:7022:e08:b0:123:308f:667b with SMTP id
 a92af1059eb24-1247dbb12bdmr443508c88.2.1769137452891; Thu, 22 Jan 2026
 19:04:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116141859.719929-1-ming.lei@redhat.com> <20260116141859.719929-10-ming.lei@redhat.com>
In-Reply-To: <20260116141859.719929-10-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 22 Jan 2026 19:04:01 -0800
X-Gm-Features: AZwV_Qg4kTv8WAIcovM9chxaCTMyKwsNggpME3leC6I9Jmr-qsPviCRs5TvtBdc
Message-ID: <CADUfDZrZ36pyELN8KGKiFHC_M-sB=2ek0a7TAv9RbvZ1xhuu-w@mail.gmail.com>
Subject: Re: [PATCH V6 09/24] ublk: refactor ublk_queue_rq() and add ublk_batch_queue_rq()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 6:19=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Extract common request preparation and cancellation logic into
> __ublk_queue_rq_common() helper function. Add dedicated
> ublk_batch_queue_rq() for batch mode operations to eliminate runtime chec=
k
> in ublk_queue_rq().
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  drivers/block/ublk_drv.c | 56 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 46 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index aa1852bd6b77..5e960ff54714 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1975,16 +1975,22 @@ static blk_status_t ublk_prep_req(struct ublk_que=
ue *ubq, struct request *rq,
>         return BLK_STS_OK;
>  }
>
> -static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
> -               const struct blk_mq_queue_data *bd)
> +/*
> + * Common helper for queue_rq that handles request preparation and
> + * cancellation checks. Returns status and sets should_queue to indicate
> + * whether the caller should proceed with queuing the request.
> + */
> +static inline blk_status_t __ublk_queue_rq_common(struct ublk_queue *ubq=
,
> +                                                  struct request *rq,
> +                                                  bool *should_queue)
>  {
> -       struct ublk_queue *ubq =3D hctx->driver_data;
> -       struct request *rq =3D bd->rq;
>         blk_status_t res;
>
>         res =3D ublk_prep_req(ubq, rq, false);
> -       if (res !=3D BLK_STS_OK)
> +       if (res !=3D BLK_STS_OK) {
> +               *should_queue =3D false;
>                 return res;
> +       }
>
>         /*
>          * ->canceling has to be handled after ->force_abort and ->fail_i=
o
> @@ -1992,14 +1998,44 @@ static blk_status_t ublk_queue_rq(struct blk_mq_h=
w_ctx *hctx,
>          * of recovery, and cause hang when deleting disk
>          */
>         if (unlikely(ubq->canceling)) {
> +               *should_queue =3D false;
>                 __ublk_abort_rq(ubq, rq);
>                 return BLK_STS_OK;
>         }
>
> -       if (ublk_support_batch_io(ubq))
> -               ublk_batch_queue_cmd(ubq, rq, bd->last);
> -       else
> -               ublk_queue_cmd(ubq, rq);
> +       *should_queue =3D true;
> +       return BLK_STS_OK;
> +}
> +
> +static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
> +               const struct blk_mq_queue_data *bd)
> +{
> +       struct ublk_queue *ubq =3D hctx->driver_data;
> +       struct request *rq =3D bd->rq;
> +       bool should_queue;
> +       blk_status_t res;
> +
> +       res =3D __ublk_queue_rq_common(ubq, rq, &should_queue);
> +       if (!should_queue)
> +               return res;
> +
> +       ublk_queue_cmd(ubq, rq);
> +       return BLK_STS_OK;
> +}
> +
> +static blk_status_t ublk_batch_queue_rq(struct blk_mq_hw_ctx *hctx,
> +               const struct blk_mq_queue_data *bd)
> +{
> +       struct ublk_queue *ubq =3D hctx->driver_data;
> +       struct request *rq =3D bd->rq;
> +       bool should_queue;
> +       blk_status_t res;
> +
> +       res =3D __ublk_queue_rq_common(ubq, rq, &should_queue);
> +       if (!should_queue)
> +               return res;
> +
> +       ublk_batch_queue_cmd(ubq, rq, bd->last);
>         return BLK_STS_OK;
>  }
>
> @@ -2122,7 +2158,7 @@ static const struct blk_mq_ops ublk_mq_ops =3D {
>
>  static const struct blk_mq_ops ublk_batch_mq_ops =3D {
>         .commit_rqs     =3D ublk_commit_rqs,
> -       .queue_rq       =3D ublk_queue_rq,
> +       .queue_rq       =3D ublk_batch_queue_rq,
>         .queue_rqs      =3D ublk_batch_queue_rqs,
>         .init_hctx      =3D ublk_init_hctx,
>         .timeout        =3D ublk_timeout,
> --
> 2.47.0
>
