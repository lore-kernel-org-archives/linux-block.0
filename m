Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A3323F422
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615628; cv=none; b=pmtbMA1KtQvgIYmql2WbmA19IioDnk6PWnQFi+FNCykFBd/7v8UwNhHZgIyUEWZ8TcAmLCH7DkwB0MKCArdhx7uxUzSzVGAceiXFyCFgRAm0R3cwpLQW4jMIEgt1Ne7FRO+clJ0Jk0uv3ScYwMBMq6q3U8shvWepthpsnDNEyMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615628; c=relaxed/simple;
	bh=9AWf5vbTHAWWuvTwgvN9Gj1hj02TRojnnRmmmBS0lZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjRM7tRv9RgidY3s9zZujgXi91zcucLlQ91vjglILyoFFTx4TFEoQpWZPrnxHeFYUEWQEr0m/TKniEXa5KyC8hUqN/uG7qf3EnUyFcN/AldeVnr971tbK/1F0XRx9zyyiQ7zYHiBQbutWlxu/mcMGigvIsdLSdsnvQ5J+PQHJvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Kej3MKuX; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Kej3MKuX"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b9da0ae5763so320839a12.0
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 11:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764615615; x=1765220415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+5ZZusDifZJpTmOBK3SWpR3xAND9tCnGPIiSfEMP4Y=;
        b=Kej3MKuXYaLV/rtNALs65BXMXCd2cChDpv46IeulQ9OBb0rcRYT09ZSHcyFGOM9uLq
         UbQQttjYEY9SUNwShJI0OFrOelY6wLC/gDSvkj8/tZhj9jyRoqpfvjZtf85tDB+GTYXN
         Z6/fdkitrePAm0AtiPdpiYtKQGIH44IzhztglIGEerzGZsnxcAbRjoACsYtOCHx4ig3g
         QxXbtIimhlgzDpDEsWZyJLd3moTSmLui3wsb5igeN0SJlvCx2ewsfCet22+q3hPk9gVY
         RZTeqBljS1zLc/HYKTpsZrfBC7jnXsMLK+baVrax894qMj7BUJDlVK6WWyQyC0954A1i
         sWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764615615; x=1765220415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F+5ZZusDifZJpTmOBK3SWpR3xAND9tCnGPIiSfEMP4Y=;
        b=kQw2Wpupu7j0fYNaDTNxmanvy3YsQZoG8InUVDh3c+cnvuloStSlyuG5GyqTte6XyS
         tlJPY+Kh2RfzzKHAFeYDHJ6jeAiQv+aOgNGFGSQ7UM57s6EbnbJ+hhPimwj1fk5h/pYi
         W1sEZVScbOddkEgQiAMdT5Xjx+7M30kDn8S6hrEURz6TjDzEU1gTUGk+bZbV/TO9JaC/
         FhPnUCgFCkgxop7KkLpKHV99H5Mq6CFjfHQZ7+qW3vKfWsOBGBOu2jf0GE6al/mKpCnf
         LKo7Xy6RKX7fpugEtHMjrb6Tx+U8gdrr5yIVbFJw4UPO1zElAwNv5JG/Y56LQG+BMcp/
         KnzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkvYziEtn5VJe9/7mqhMeeObrFYmD2xgXLrfyfiAqfOW2T8glIoJSqhUr3+lO5GmP1A8ChReyXLXyIAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVgNtn/GIBKsateYCi/57Lw9cI+u+oXXJDGkMKK0rneh+4rU9d
	hDs+1fHaHAgwHkaJlDQmtgyRtpx3GhRVZAIoBKgVILsR5V+yEGt+kHFj7G+PgPOAtKVrCVToEiQ
	40EJ/1xXCak8mWTNUBF+NdnB7NT0HKgF4prYOT3iocg==
X-Gm-Gg: ASbGnct3KnW6XrJvQyO+qGowT4tBKxzvpCLMU2d9vMtf+jP20VjUfHFf1cKqrFVr7xt
	mEWn2OOYSxw3rIsweqrM1U2hOawGIY8wL6JTZ1/vJwqAMVrk/Jy3PoiIK1h3Cwn6S4ogsX1TSit
	Q2XkW/W6kPg/mSWZ1XcdWSCvkTUJ4wh0J4m23mIXm2yTTyu/6f5IlEsOmylBnyVjUrG9/a9ufPN
	5ZhaWmM0+XTOTRd2NLi1t5+F0b41fHGMeFg/XYbOPXFzG0AffKVyBMpXJfs4FaO/0/fwkjP
X-Google-Smtp-Source: AGHT+IHXVLPSz9cfkNLZDabTSsQ2qowAKPhIcPIBMbZL4q4rqJkWtWHbX7Kr0d2f3zXF1NiWsszp4sjl3xvo/4v8HQI=
X-Received: by 2002:a05:7022:ea48:10b0:11b:aff2:4cd5 with SMTP id
 a92af1059eb24-11c9d717ef2mr17645537c88.2.1764615615041; Mon, 01 Dec 2025
 11:00:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-16-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-16-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 1 Dec 2025 11:00:03 -0800
X-Gm-Features: AWmQ_bmhRUF1eWGy7-En1_856BmeNfxxKcPTqJvh_FOdDVA9v_eLPYVOunqLx8A
Message-ID: <CADUfDZoTueDL9ReuGO0TntffmT4JfpUdt0=QfepBJYKVRWwDyA@mail.gmail.com>
Subject: Re: [PATCH V4 15/27] ublk: abort requests filled in event kfifo
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 6:00=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> In case of BATCH_IO, any request filled in event kfifo, they don't get
> chance to be dispatched any more when releasing ublk char device, so
> we have to abort them too.
>
> Add ublk_abort_batch_queue() for aborting this kind of requests.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2e5e392c939e..849199771f86 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2241,7 +2241,8 @@ static int ublk_ch_mmap(struct file *filp, struct v=
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
> @@ -2251,6 +2252,26 @@ static void __ublk_fail_req(struct ublk_device *ub=
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
> +       while (true) {
> +               struct request *req;
> +               short tag;
> +
> +               if (!kfifo_out(&ubq->evts_fifo, &tag, 1))
> +                       break;

This loop could also be written a bit more simply as while
(kfifo_out(&ubq->evts_fifo, &tag, 1)).

Best,
Caleb

> +
> +               req =3D blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag=
);
> +               if (req && blk_mq_request_started(req))
> +                       __ublk_fail_req(ub, &ubq->ios[tag], req);
> +       }
> +}
> +
>  /*
>   * Called from ublk char device release handler, when any uring_cmd is
>   * done, meantime request queue is "quiesced" since all inflight request=
s
> @@ -2269,6 +2290,9 @@ static void ublk_abort_queue(struct ublk_device *ub=
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
