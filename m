Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D45D2D7DF3
	for <linux-block@vger.kernel.org>; Sun,  7 Dec 2025 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765093509; cv=none; b=mNdUnrimE0zJFhdEDWpFu3WoCT8uU0JmNDQ5QMeWBRW/vBhaQCFA/NJ5jEmi0iwS44zmafH/4mxyyKGxEZKERq9zQheLucFL90IvG7MQaGGD4g0nIw0DrX98lH+eKVrTcreW9KcrjWaZDRd2nNRli21Z8GTgsZXPSLC57e5Kuts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765093509; c=relaxed/simple;
	bh=xE18S0HTScxsy8TOmsZHqOxcR52s9PfaVSET2eKkGak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDd8eUFIJQF5UsPDijSVQUzGyQbJXstlfYfs7cZ11JWf29/vfzC+iz/GJmNWTa81bAlhscwIp/yBrrA7Zl5qpayd1dvi3xlDlLhEou8wAFscSSO2Fdw6pH6bBwO8Qe3WxuubBMaUvAdxXmcO+lqNDQ+idAX6mGpjkv/Q6yUhkMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Wrr5BVzI; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Wrr5BVzI"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3436b2dbfb9so549790a91.0
        for <linux-block@vger.kernel.org>; Sat, 06 Dec 2025 23:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765093507; x=1765698307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ogpv9VihoW4RCSF67gmJdVNoxbffZh1qEXc6QJ6HPIk=;
        b=Wrr5BVzIp3BrMahYS3PXP535Y6EwazbXm18ilV29EM71wCGwCMoUR04FGUT8GavfLh
         09JquAknk7fZf7smP9Q2q0/QXNYEUyPRLeQWbbDwuj1BSWcavMRzIxgzJE5tY0G4wshY
         KIoDlZInRPTcnGmkbMCHl2zFaKa3NAQ/EW761CDUh4xTms4VdHb95UG8ySw7Zb0LXVo3
         AmKBt8CpD1Hq2c+qhKOsC9NHIEqxvx9TDoB2MsOZ3wUWhQ8jNsnlKD7SV+hWbcltwfrl
         n12pQSeNzNO7w5BHzPgXbk7Ell7GsXCy5bAM0RY1A5Wcu3JnWDHz7JJyMbLEsjk5TgFn
         J0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765093507; x=1765698307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ogpv9VihoW4RCSF67gmJdVNoxbffZh1qEXc6QJ6HPIk=;
        b=O2q5enuK+JgBZwh0nh74bhToWyawN6mZ78uVDpI4RAIiC1xiYghXSYoTB09bXL3/a6
         FukUs00Ow+UWLQIJ+ifPw+7RgqG8baG+utyvj5cYJJwyigouwUhjK6kVRNC1sGQibV/w
         wMsd61lveV/qaF+T0HYqPuhBdalsD+r+q8svt9biCi31KP/rHeGluVL/tm9pQdwswoPj
         bkchztBePHsTMUUfYZ3ND1cgpY7C3I46xucFWmfuRfOqoXeS3Q5MkvVX/sPiP/6GC0Ew
         K72RP2QtxGvDyb5a92tkgdraaz5X6p+ZUNmxSIAfkadvInITSohzyoo+LdpU3n5CjJeN
         P6Yw==
X-Forwarded-Encrypted: i=1; AJvYcCW7ksfmEOCa/j4LK7yfItn+AW/BQR8Uomgp6b6E+lx3DCeiX4UqIM8jbI43WH33Ur+Wxenq/b2ylbzBEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcmIomdsQEh3LnvdwGS0jlwCu2J6jQo4F2XyH6AMiBatVlRhYo
	tKgl6eFHfXCliJqojk86FFuob9u9nFtLnRBsSfaIE6wJVG8qs4Tgeyk7g5JqXybY2RtCjlNeTYu
	gWFATg72YAYPQV12MW+T+8R+DkzAPiuWCdocgR1snRg==
X-Gm-Gg: ASbGncsykojbgYHcrx4nqMDCZbeCPmvUm72ij0mmIHxRE1wH0TJygt11Wbm90nJF4TL
	HvO9tO45EFa1CC43QzlHaELi20PjS9ZkvcphAjgl4gPJ/wEhzdxlUo1lbx7+gcch7kcQqzKZfRc
	qvq1vkBLkTx4b3o8bNKQiPc5lnEDpQTEBK4UGdDSXGJEq3Dl8QBqme8ruwqY7JfiLf0VXYV0COZ
	BiXoz0/bhCDgTlZgFGo9uiQZSx7v734aTNiCvakpze5NqAzjY9WtZxjeA4/LER7hXoHvN8C
X-Google-Smtp-Source: AGHT+IFee9PQZ/ZyrNRqbYGSKIF9LPCMQWimGxNwSXR0blfGR8bGMHoKq3u+m5r59we88KqaWvyd1XtgPnopQjLdJuU=
X-Received: by 2002:a05:7022:6624:b0:119:e55a:95a0 with SMTP id
 a92af1059eb24-11e0326c0bdmr2101684c88.2.1765093506452; Sat, 06 Dec 2025
 23:45:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202121917.1412280-1-ming.lei@redhat.com> <20251202121917.1412280-10-ming.lei@redhat.com>
In-Reply-To: <20251202121917.1412280-10-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 6 Dec 2025 23:44:55 -0800
X-Gm-Features: AQt7F2rTodG4grH1-6mrIV9iNejLvj1YsJcaX6ugjxZfUY-538X6BzP616F5Kwk
Message-ID: <CADUfDZqqR4TBsVdAqd5_MbeBdM3MeB6QtP+9Z38O5S5Ztv_MUA@mail.gmail.com>
Subject: Re: [PATCH V5 09/21] ublk: abort requests filled in event kfifo
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 4:21=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> In case of BATCH_IO, any request filled in event kfifo, they don't get
> chance to be dispatched any more when releasing ublk char device, so
> we have to abort them too.
>
> Add ublk_abort_batch_queue() for aborting this kind of requests.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  drivers/block/ublk_drv.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index de6ce0e17b1b..3865edabe1e6 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2265,7 +2265,8 @@ static int ublk_ch_mmap(struct file *filp, struct v=
m_area_struct *vma)
>  static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
>                 struct request *req)
>  {
> -       WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
> +       WARN_ON_ONCE(!ublk_dev_support_batch_io(ub) &&
> +                       io->flags & UBLK_IO_FLAG_ACTIVE);
>
>         if (ublk_nosrv_should_reissue_outstanding(ub))
>                 blk_mq_requeue_request(req, false);
> @@ -2275,6 +2276,24 @@ static void __ublk_fail_req(struct ublk_device *ub=
, struct ublk_io *io,
>         }
>  }
>
> +/*
> + * Request tag may just be filled to event kfifo, not get chance to
> + * dispatch, abort these requests too
> + */
> +static void ublk_abort_batch_queue(struct ublk_device *ub,
> +                                  struct ublk_queue *ubq)
> +{
> +       unsigned short tag;
> +
> +       while (kfifo_out(&ubq->evts_fifo, &tag, 1)) {
> +               struct request *req =3D blk_mq_tag_to_rq(
> +                               ub->tag_set.tags[ubq->q_id], tag);
> +
> +               if (!WARN_ON_ONCE(!req || !blk_mq_request_started(req)))
> +                       __ublk_fail_req(ub, &ubq->ios[tag], req);
> +       }
> +}
> +
>  /*
>   * Called from ublk char device release handler, when any uring_cmd is
>   * done, meantime request queue is "quiesced" since all inflight request=
s
> @@ -2293,6 +2312,9 @@ static void ublk_abort_queue(struct ublk_device *ub=
, struct ublk_queue *ubq)
>                 if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
>                         __ublk_fail_req(ub, io, io->req);
>         }
> +
> +       if (ublk_support_batch_io(ubq))
> +               ublk_abort_batch_queue(ub, ubq);
>  }
>
>  static void ublk_start_cancel(struct ublk_device *ub)
> --
> 2.47.0
>
