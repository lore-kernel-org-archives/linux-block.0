Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B19F311977
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581914; cv=none; b=G25AJb5RD4WbjtAq7vZnkGTMUgj6eCsvOt204l/TspTiRzWrwf9TPC7OLRMZPK+VxEYlI0KI3QbYJwi8OeWuFeiJRlBCnmugYmhq8ABadzhq//DC+tkgkVfTolCTrq0Kl+bRLkXWMjxsRLgkL5y78rlEmoBMBiHrntRXZGX7FAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581914; c=relaxed/simple;
	bh=bO+j/PvY5TEVJo8+1ruKwQwqMR5RXF6ReyVEGwwH37Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5MywP5H0OgvB3cB6qKPoUmlnj00Dp6mk4ccOQVQerXrmJGEQDUdKt3w22jTm5X1ZUy/6tRaJCNzZ0kgCwBdCYoEHklmEEWs7AraL59BDCNj66Pp4VOYAXneDyROJAi7EymdGQ+ntxiUw/NynHLFiyC51uUpruRyNL5Ez+ifCC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XvnBsVOg; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XvnBsVOg"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33257e0fb88so715071a91.1
        for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761581912; x=1762186712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5zRXIVQDgNQl8MjZbaWTaE8Q8S6ay1wxqt0gc/leLc=;
        b=XvnBsVOg/CrRr0yoO2l83CqWoPbZFCL+4hiiegHkaoNzWRHGotC31MiaYUPZ59ibMR
         a9y+11995KHnLGfWrq7lz54DNaf+uK4luRf84lg8/UdJ8RRTt+mnLhwcrmYlPya3yJJ/
         6icozbXZrF8UO5CqNEkP0Vny8IW74716v4iIl6mGRiPFapA3bzyCXGL7nwnyrsR8hMSu
         9CsXiChSDlAJLPb89x9GK+zdhdgT6nzckRh+XWM7Lg/S7VJqhTOVRrT/h5G2vxpnkTT/
         aRzm5KZN2XZ3cFmzdhgPn+7gOhlTeZJt0Vg3aXwRXBitZEXf3hmCTZkSPZvxeLKmpNq2
         QRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761581912; x=1762186712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5zRXIVQDgNQl8MjZbaWTaE8Q8S6ay1wxqt0gc/leLc=;
        b=dXTxHlhFNmNqIGWVNBJzlSYcb8QdMPzH7Q90WRlFDeyAgTDyzpL9rvwfZGrnPtrLAq
         ssiiPTDOgV9GT6sXDm6KrkAD1oZhUbGdfeeI7C+BD/cGA8WrnzilmSTUSokqtufLtW2S
         AiOSOCJqHH6hxIeI6GhDbWHCkXmRgsXbdEgHQ7Y+tiUpN2jezG05UDUpVLJNb5iO7wdK
         fIxa2DnjXvQsBSUXyu1SJaAPPkbNmmjE1o2NjUbuubXbRoQzq5NGHrVaJqy+Clm7EZP2
         AtYrn4Hhr3zYKiZtFbwbLoPwJEOC2XVL5vR34Y2yqwv7b/cGXMSl9iXefUAJva+EoaL4
         yQ8g==
X-Forwarded-Encrypted: i=1; AJvYcCWV6hDWRiYlI2xviY0jS6iwFiJujMPvWkVmgeJ2a1FU4cg9QOoc/qPIIFKCEBrpXrcHcTkDiA/+ULflYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+XZeOo8rH9hHHcTVXqhU66JUwwKvFekzgJfzoPnKEKYU3ti50
	PdC2pjRN1qc6EZHQv0euu/krIKpJSW5mGMDt+KiHGFgVdpBk4yFgvIedU0jjZr6Y9sfzgvqgumu
	sD39DUsc8oTicu1WHqDPI4cQLYB/pW3WtFKPgXRpyYQ==
X-Gm-Gg: ASbGnctc5O1nEGsut3ymQqml0iFjBHcaB9H9Z3aLSbSJ6+tDT0QPYhQjQZF6QFP7BdE
	zFzSgBsmp0w4HJrpaAaJrhjrPYcUA57TtKE5qpN9uBKj2O+1PHt5oEgrfnuuRIqXs5XbHqZCmZo
	Dqvxgh02ePBca4XHUqgpwzGgE9BZ7JRZltzdgQOIe/TIKSlfySMZRtzoykXoMqjmz229K6Dq9Uw
	HG/eySH6hgMHu9RLrMG3WlYvu5vymsXMwhp6SyPuJSa0g0Mnq/gATmUvDPH6uQuG339aqmmpBh+
	XG2K2EqNzN3GB/2HKS1cGJoaeXqk
X-Google-Smtp-Source: AGHT+IF+U0+JPxygQDcLS4EnXZA4SATIEvqgFk4pH1K+CJB3ZS4a/KMkLzBdjAEQiPtBFclKsqbUVzjMEiWxt09FcMw=
X-Received: by 2002:a17:903:38cd:b0:290:8d7b:4041 with SMTP id
 d9443c01a7336-294cb53417fmr2913805ad.10.1761581911751; Mon, 27 Oct 2025
 09:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027114950.129414-1-ming.lei@redhat.com> <20251027114950.129414-2-ming.lei@redhat.com>
In-Reply-To: <20251027114950.129414-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 27 Oct 2025 09:18:19 -0700
X-Gm-Features: AWmQ_bkkqPw_4RHPBRa9XTYF9J5P_IZenXVc5EFu4b6HPbadyDtHesyQgQA9SzU
Message-ID: <CADUfDZqkfmARPB80pqCcB3ANzWbPvirUT77rjFUj_efoC9xL4w@mail.gmail.com>
Subject: Re: [PATCH 1/4] ublk: reorder tag_set initialization before queue allocation
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:50=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Move ublk_add_tag_set() before ublk_init_queues() in the device
> initialization path. This allows us to use the blk-mq CPU-to-queue
> mapping established by the tag_set to determine the appropriate
> NUMA node for each queue allocation.
>
> The error handling paths are also reordered accordingly.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  drivers/block/ublk_drv.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 0c74a41a6753..2569566bf5e6 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -3178,17 +3178,17 @@ static int ublk_ctrl_add_dev(const struct ublksrv=
_ctrl_cmd *header)
>                         ub->dev_info.nr_hw_queues, nr_cpu_ids);
>         ublk_align_max_io_size(ub);
>
> -       ret =3D ublk_init_queues(ub);
> +       ret =3D ublk_add_tag_set(ub);
>         if (ret)
>                 goto out_free_dev_number;
>
> -       ret =3D ublk_add_tag_set(ub);
> +       ret =3D ublk_init_queues(ub);
>         if (ret)
> -               goto out_deinit_queues;
> +               goto out_free_tag_set;
>
>         ret =3D -EFAULT;
>         if (copy_to_user(argp, &ub->dev_info, sizeof(info)))
> -               goto out_free_tag_set;
> +               goto out_deinit_queues;
>
>         /*
>          * Add the char dev so that ublksrv daemon can be setup.
> @@ -3197,10 +3197,10 @@ static int ublk_ctrl_add_dev(const struct ublksrv=
_ctrl_cmd *header)
>         ret =3D ublk_add_chdev(ub);
>         goto out_unlock;
>
> -out_free_tag_set:
> -       blk_mq_free_tag_set(&ub->tag_set);
>  out_deinit_queues:
>         ublk_deinit_queues(ub);
> +out_free_tag_set:
> +       blk_mq_free_tag_set(&ub->tag_set);
>  out_free_dev_number:
>         ublk_free_dev_number(ub);
>  out_free_ub:
> --
> 2.47.0
>
