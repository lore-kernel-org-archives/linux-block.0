Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342EC18B00
	for <linux-block@vger.kernel.org>; Sat, 13 Jan 2024 02:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJohBdcc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705111529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29rgx+fcdc+OGosBM+rz8Ay2WMsmo7j5/PhFnPhZLEY=;
	b=EJohBdcccDSs0XMufuRHmLX4ANJK0ccg4gu4XDOXg+aGRhWZ8ibCee8C7Ro5RicBIy/Goe
	t2m9jeREzqg5oXmC5uSr90oxIqMc2ZDPsMZK4IniIXBGS7Cn98yXw26MIUtbEpkFsAN8x3
	uugqpt8t3fXMVtLGjlMMSWi0UkIljCc=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-NNb6w-rTNZiextS_sP3nVQ-1; Fri, 12 Jan 2024 21:05:27 -0500
X-MC-Unique: NNb6w-rTNZiextS_sP3nVQ-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-467f038c918so719354137.0
        for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 18:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705111527; x=1705716327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29rgx+fcdc+OGosBM+rz8Ay2WMsmo7j5/PhFnPhZLEY=;
        b=ZC/mKXzsixNOgBvrSHT4TtOgshFVpZEh8nhQiSryRrJjlu1YBruGHB0/R6+37H3KVr
         pIjtGz23ClIcqg9EjN3u0/XQNxGhyROIEgYntF/8GAW3WFJhocDxy2PYgXd3KofYQ/1+
         c7Qpu7XwHTyjKM/dAtUpgYqMZTW1t1cE9hV4uznHci+zGRSi/jnZGdRpVDhpF3jVH6ta
         twgcY0lrSEyvcn3z444JWyFYyYrABRDO+5jPkjGWMphEQOTxZWdfQveeE7CM9JYkScBm
         5tEXN+snSrFaDqil1sjgO0ikUEziKNIyrY56PNAk530BOEduOENxXPbwCgrCI06gNdT5
         Hzow==
X-Gm-Message-State: AOJu0Ywnpx4XNqQ5xaYgpvIoLmQwm9/Ti5AjkZpFOZI/y/lApF7q3JuT
	/V6fajvwzN1sHWem8g7RKDc+EJsQLpqChsC92LZn1pdz0dVT4DjXEKgWAVxmYybOZn0SnAG24Y/
	Ob+CqS9VZBnCrvDAek35RP7mZ/wx2G2ThCG/CurTZFud2Br+wdoVSPGtfJ5mD
X-Received: by 2002:a05:6102:3f91:b0:468:e89:a42f with SMTP id o17-20020a0561023f9100b004680e89a42fmr3502386vsv.1.1705111526712;
        Fri, 12 Jan 2024 18:05:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJxsiSgFDNgZ/bDK3JcBbPi7WBTrGQtLjH1VQ6PQ3aUXkhUhbZCi8gnpVW6go5Ab7zPLlcw2JzQ0n1xK5ixr8=
X-Received: by 2002:a05:6102:3f91:b0:468:e89:a42f with SMTP id
 o17-20020a0561023f9100b004680e89a42fmr3502378vsv.1.1705111526354; Fri, 12 Jan
 2024 18:05:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <575be19c-01f4-4159-874b-d1e5dcbdc935@kernel.dk>
In-Reply-To: <575be19c-01f4-4159-874b-d1e5dcbdc935@kernel.dk>
From: Ming Lei <ming.lei@redhat.com>
Date: Sat, 13 Jan 2024 10:05:15 +0800
Message-ID: <CAFj5m9LdX+Jf6pJTPWqCWvqqmQ5yVhBN71p8WH_1FwjhQ-HjnQ@mail.gmail.com>
Subject: Re: [PATCH] block: ensure we hold a queue reference when using queue limits
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 12:15=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> q_usage_counter is the only thing preventing us from the limits changing
> under us in __bio_split_to_limits, but blk_mq_submit_bio doesn't hold
> it while calling into it.
>
> Move the splitting inside the region where we know we've got a queue
> reference. Ideally this could still remain a shared section of code, but
> let's keep the fix simple and defer any refactoring here to later.
>
> Reported-by: Christoph Hellwig <hch@lst.de>
> Fixes: 9d497e2941c3 ("block: don't protect submit_bio_checks by q_usage_c=
ounter")

The fixes tag is wrong, and it should be:

Fixes: 900e08075202 ("block: move queue enter logic into blk_mq_submit_bio(=
)")

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>
> ---
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f57b86d6de6a..e02c4b1af8c5 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2964,12 +2964,6 @@ void blk_mq_submit_bio(struct bio *bio)
>         blk_status_t ret;
>
>         bio =3D blk_queue_bounce(bio, q);
> -       if (bio_may_exceed_limits(bio, &q->limits)) {
> -               bio =3D __bio_split_to_limits(bio, &q->limits, &nr_segs);
> -               if (!bio)
> -                       return;
> -       }
> -
>         bio_set_ioprio(bio);
>
>         if (plug) {
> @@ -2978,6 +2972,11 @@ void blk_mq_submit_bio(struct bio *bio)
>                         rq =3D NULL;
>         }
>         if (rq) {
> +               if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
> +                       bio =3D __bio_split_to_limits(bio, &q->limits, &n=
r_segs);
> +                       if (!bio)
> +                               return;
> +               }
>                 if (!bio_integrity_prep(bio))
>                         return;
>                 if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
> @@ -2988,6 +2987,11 @@ void blk_mq_submit_bio(struct bio *bio)
>         } else {
>                 if (unlikely(bio_queue_enter(bio)))
>                         return;
> +               if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
> +                       bio =3D __bio_split_to_limits(bio, &q->limits, &n=
r_segs);
> +                       if (!bio)
> +                               goto fail;
> +               }

With "Fixes" tag fixed, the patch looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

