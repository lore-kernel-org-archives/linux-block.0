Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540E6199EA2
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606664; cv=none; b=IjpcrJ0D6tSQ8BUTBw1OcmSgn1PADxUV2Qj3oce/2P6SWEhitVr3lsfmcC2qzuFq1b9UHAcIKyaOl69Tl9o8jmK/vQ+47C5qN6G/+BvrtTvEwXCWLte6ShpO0KQxz1hyg/4xpu59jx5Jni5Vd3IJt5lOe2v8H9Fd3bOAt13utE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606664; c=relaxed/simple;
	bh=8jDEKxLSsx1rwZXC6X2DbXk2k8+102jufOYFQJxOPis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JGxVVUshLZkjJLlcwk8horAzavL5YdQG53hWdZwpIz8xhTzGKv/k7KizdThrD9GKipzpCUigHdcsgnH0C0RCs5wGiruBcyE0zj/eEdMbcl59uyuF2LR95iiZn2xD1T5nBiOy9wzbm8J9zOR9awYZ9zwXRxwElJSnPQi/NpYrU70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=skxwb2c6; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="skxwb2c6"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e34339d41bso46956567b3.0
        for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 23:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732606662; x=1733211462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzJ8y3qThHAT3ji1jGc3KKyhMYzUDWpdeImJOBfn8s8=;
        b=skxwb2c6/CfrR08MOcrKW5f7IEBEqTvCH1ZLCZ49XTPZMBcOaRhEPgP7WpbH6u0/uR
         mzwL+XA7d6hPiThiMBN6xNdatsXtH+tVrlxB+AjsLUZVi56dVqx8GYPqartCZt1/MqeJ
         M6ZX8x/8a15rQ3zcOGE9jgpGkymFiXq5aJ3XaIDVYxNXZVKQqOoxIOlXfPNoezZL9eL/
         PMUuYZRY8Zm59mzH8WTGIUUroZqwdLoaj77ps3GbpJ4Iv1ekTivd9cAmhwSEVjbyz/A0
         0kMbhp04wIwVtZq1y2GZyjkYs1aWfizScnyLflZxmEWiu+4a5fq0MEwcXCmUL3MEBdr1
         +xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732606662; x=1733211462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzJ8y3qThHAT3ji1jGc3KKyhMYzUDWpdeImJOBfn8s8=;
        b=fR97TubXpQh84JxQI116qgms1MMx14Q3fNXgyyYoCODDoaAWnmQH/oCsmx0dNPuept
         rjROUEANmYrgd8hsS9cJUn7AhaShigzgzYaYJX8ocy7fo7huhsh68fOEtKXtg7drJ+MR
         wEkmVBgfrf6bbpGfmBQ7RmSlx2JRklXok+U9WCsd8IwBM76hORNnLR6tjU2SXvqstniq
         E1FdG3mLGjjKwTd/D2QMaFbztfYtvoYj0pf/7F6bbJKr/3wrVhPXVE+bvJTeEUnhccA5
         RS7Rjfo9LgSNIyGfsnUs3jn2qNA6SDAx7l4PblDcEZLdfrrk4siz9z1A4q+lWDA+2qeK
         JiqA==
X-Forwarded-Encrypted: i=1; AJvYcCUhgbH+rCNm/4vdHieDF9v925ofE92UFUVTyIizJuJS6uId/fwcVO2gxpORzUcmqT8MXzIJLdueQIYlow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkj83hR/8fiRxbuwpoJljZ8LTCcPshUDWBcaJD4h3WVACDA1Cx
	JthrnHpB/RD8ecj8W8FQoVM2ZIZiMMs2mKKAJ59XrCiGotPW/6HqohwSe+RPDZasNsGtCWqxC13
	HQ04Bnm+czUKRZkIYuVNC8mmnNomdJgA+UAqqMA==
X-Gm-Gg: ASbGncsiWqoBCdGngR6jlrqTeCKaNtzwnhOcrOOiFNL8Nl6VuXBXU+v6xMLbgC5Oo2c
	yLhLniJEtH2yTrLi/K5imwZ5CDdVudy4=
X-Google-Smtp-Source: AGHT+IG25CYHixpJ7nOq5l+BobwqKzKUEHt9Mf8gk84f32pc2M+oiSy7++GIyqdSuhvD+RneIJuhEgFfvcnF51MQCdY=
X-Received: by 2002:a05:690c:3386:b0:6ee:a70c:8727 with SMTP id
 00721157ae682-6eee0a2f97cmr145845267b3.41.1732606662315; Mon, 25 Nov 2024
 23:37:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112170050.1612998-3-hch@lst.de> <20241122050419.21973-1-semen.protsenko@linaro.org>
 <20241122120444.GA25679@lst.de> <CAPLW+4==a515TCD93Kp-8zC8iYyYdh92U=j_emnG5sT_d7z64w@mail.gmail.com>
 <20241125073658.GA15834@lst.de> <CAPLW+4=kuHze3=+g80CsY6OkLno5gyjRfMWLXTFHu3N_=XcmqA@mail.gmail.com>
 <20241126065253.GB1133@lst.de>
In-Reply-To: <20241126065253.GB1133@lst.de>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 26 Nov 2024 01:37:31 -0600
Message-ID: <CAPLW+4=0Ojg58pa7iFkgY=5S6wr-dYseJVvXL466W+ROAh0r8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: remove the ioprio field from struct request
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 12:52=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> Hi Sam,
>
> please try the patch below:
>

I can confirm the patch fixes the issue on my side. Please add me to
Cc: if you're going to send the fix. And I'm always available to run
more tests on E850-96 board if you need it.

Thanks!

> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index acdc28756d9d..91b3789f710e 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -685,10 +685,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *=
hctx, struct request *rq,
>
>         prio =3D ioprio_class_to_prio[ioprio_class];
>         per_prio =3D &dd->per_prio[prio];
> -       if (!rq->elv.priv[0]) {
> +       if (!rq->elv.priv[0])
>                 per_prio->stats.inserted++;
> -               rq->elv.priv[0] =3D (void *)(uintptr_t)1;
> -       }
> +       rq->elv.priv[0] =3D per_prio;
>
>         if (blk_mq_sched_try_insert_merge(q, rq, free))
>                 return;
> @@ -753,18 +752,14 @@ static void dd_prepare_request(struct request *rq)
>   */
>  static void dd_finish_request(struct request *rq)
>  {
> -       struct request_queue *q =3D rq->q;
> -       struct deadline_data *dd =3D q->elevator->elevator_data;
> -       const u8 ioprio_class =3D dd_rq_ioclass(rq);
> -       const enum dd_prio prio =3D ioprio_class_to_prio[ioprio_class];
> -       struct dd_per_prio *per_prio =3D &dd->per_prio[prio];
> +       struct dd_per_prio *per_prio =3D rq->elv.priv[0];
>
>         /*
>          * The block layer core may call dd_finish_request() without havi=
ng
>          * called dd_insert_requests(). Skip requests that bypassed I/O
>          * scheduling. See also blk_mq_request_bypass_insert().
>          */
> -       if (rq->elv.priv[0])
> +       if (per_prio)
>                 atomic_inc(&per_prio->stats.completed);
>  }
>
