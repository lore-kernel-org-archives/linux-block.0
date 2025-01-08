Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219D92AF0E
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 02:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736301754; cv=none; b=KDFK6+KTKVJHps4mjMnHAshwGQWoys15ByV2oXcDE1dlSsTWs2kkSWMTklBtsyojhtpad1w9JRiryO21qe4rphEOZyMCaUzv/P5Ctw/+OHHmzSHRbwJqdnkLAH23idpcl5WkUfwDxr9OYPrJjneV/e9B9SVdOAJpxpbD1tZUZ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736301754; c=relaxed/simple;
	bh=bnbdafSHoUIXiLJU0hLjv6jA35U7B1BBo1Y6D1ExIF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIQMZlXufWiOnk4wIbQa4HzrmgjEVzUg8BrdvXizr9FHXYQsC05yqbXbi679WJ2w/iXM+AKVKBfp1juRXlO7NPaWpOSHzXghdv8s8qZ2VS1Wfy5nSh+dmiJNIKgP8lAqKTRjrViStfXa7I3tRMl94z3s1eR9zlidN++B2+c86TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W/wdNTw2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/wdNTw2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736301751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3O4asXjraCLx5UW8S6Qn4t+5ED6yreicv33kZYqYIE=;
	b=W/wdNTw2vWBIDkYBFgQtdyfQ/Bqxr7LJNPClV1yv/g345ibMi56B+45OqbM3vQDtkr7m50
	ur+/bjBckHNy424wXAgzjriP6qzxAA/3XwfemReNe7IrvUDwcR4B5mzgODZjACR8FjF54a
	392DUuXVfG3wRWs9RXt3J33zQzmNSYA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-1I-rVsGJPJ6OC9ArXGBGGA-1; Tue, 07 Jan 2025 21:02:29 -0500
X-MC-Unique: 1I-rVsGJPJ6OC9ArXGBGGA-1
X-Mimecast-MFC-AGG-ID: 1I-rVsGJPJ6OC9ArXGBGGA
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so24371074a91.2
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2025 18:02:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736301745; x=1736906545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3O4asXjraCLx5UW8S6Qn4t+5ED6yreicv33kZYqYIE=;
        b=KzurfYShpVMr6fLCoMsch0Q7Z5yf7IWauc1Q71+nIS4ZQuMdOboI+EIahCOX6QwlnQ
         g2RNmOJaieeot0mR0HM3kL9ba0X5F19duX2todPGgEbVHApngIrZqJ+5lz/OrjbD1pIX
         ubBqsL1qz3woPFpI8eC3wqIuSskKkJN03bA0da15GVR7bBtUsr6ACaVnSP2hw6hxwqp6
         ZyOHZt4CL+02QviNwazd3jTg37e0Za/UD+74H9OQX4Fr7gtziHeSOcdinbWA68AhE4FZ
         smDEQ9CQQbaZaKRi5ZnudIs9C0rHCpan2CcEe+ZveN7shD19VTg7Az7gH+uSpJOV8ymz
         DVfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIKnvRC0LybPJecncdCK61wP1Cl1hOvkebdlzEhPvdl1ThxxuwMXCjrmuxUQicD2vrNyp76SIwnCmyKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGHkF5jo1SxOaoAJLdYG9XSvova3nSslnYQY8N7TTWeOFvmtuB
	N/iqzdrfvUxvMyXK9k966Oi9ThgvOTUONcY2WRPe/zH3ckZargV8p0BRC0y+IWOqD5p3473tLqH
	whwQUE2M/74/I53aGT9ADnXPoQ3VsfGey2Ch6qniCSvdvkERMbZqf9utbXoX3JQwHpxBRcANZV0
	Hpyysdfc4ZW/gkB8itZ7DxO1TqKvsdnf7R4TE=
X-Gm-Gg: ASbGncsZyXOcBCkkjglJhN+Dkmlbg6b70zmjYJC77UOSiXy7IHDAOBEZHTyWABneBa0
	gmufEMlV3rgYxLXUe4Hp54r8NdImxBqKG+aCzjhM=
X-Received: by 2002:aa7:9319:0:b0:725:e325:ab3a with SMTP id d2e1a72fcca58-72d21f4c187mr1867002b3a.14.1736301745057;
        Tue, 07 Jan 2025 18:02:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEZ9BFWxbThy9xqFzriMnomszTBHHhxQZJ4oGdMaqUnaNUKqZKdEG9BHYR70GXPA0r+I74eLe8+1UXXTotQPA=
X-Received: by 2002:aa7:9319:0:b0:725:e325:ab3a with SMTP id
 d2e1a72fcca58-72d21f4c187mr1866956b3a.14.1736301744614; Tue, 07 Jan 2025
 18:02:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107182516.48723-1-andrew.boyer@amd.com>
In-Reply-To: <20250107182516.48723-1-andrew.boyer@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Jan 2025 10:02:13 +0800
X-Gm-Features: AbW1kvaXj1MjFHCsg5QMAHaUlm13FiHYH0_03Qv8TJOXkWflZr9GjLeuzmB2ppY
Message-ID: <CACGkMEt3iM2WZT08rpMHOFp_n2jWnjrG+YML5DgXrW2FbJC6vA@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: always post notifications under the lock
To: Andrew Boyer <andrew.boyer@amd.com>
Cc: Viktor Prutyanov <viktor@daynix.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Eugenio Perez <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux.dev, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 2:27=E2=80=AFAM Andrew Boyer <andrew.boyer@amd.com> =
wrote:
>
> Commit af8ececda185 ("virtio: add VIRTIO_F_NOTIFICATION_DATA feature
> support") added notification data support to the core virtio driver
> code. When this feature is enabled, the notification includes the
> updated producer index for the queue. Thus it is now critical that
> notifications arrive in order.
>
> The virtio_blk driver has historically not worried about notification
> ordering. Modify it so that the prepare and kick steps are both done
> under the vq lock.

Do we have performance numbers when VIRTIO_F_NOTIFICATION_DATA is not
negotiated?

We need to make sure it doesn't introduce any regression in the case
like virtualization setup since now there could be an vmexit when
holding the virtqueue lock.

Thanks

>
> Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Fixes: af8ececda185 ("virtio: add VIRTIO_F_NOTIFICATION_DATA feature supp=
ort")
> Cc: Viktor Prutyanov <viktor@daynix.com>
> Cc: virtualization@lists.linux.dev
> Cc: linux-block@vger.kernel.org
> ---
>  drivers/block/virtio_blk.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 3efe378f1386..14d9e66bb844 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx =
*hctx)
>  {
>         struct virtio_blk *vblk =3D hctx->queue->queuedata;
>         struct virtio_blk_vq *vq =3D &vblk->vqs[hctx->queue_num];
> -       bool kick;
>
>         spin_lock_irq(&vq->lock);
> -       kick =3D virtqueue_kick_prepare(vq->vq);
> +       virtqueue_kick(vq->vq);
>         spin_unlock_irq(&vq->lock);
> -
> -       if (kick)
> -               virtqueue_notify(vq->vq);
>  }
>
>  static blk_status_t virtblk_fail_to_queue(struct request *req, int rc)
> @@ -432,7 +428,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_=
ctx *hctx,
>         struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(req);
>         unsigned long flags;
>         int qid =3D hctx->queue_num;
> -       bool notify =3D false;
>         blk_status_t status;
>         int err;
>
> @@ -454,12 +449,10 @@ static blk_status_t virtio_queue_rq(struct blk_mq_h=
w_ctx *hctx,
>                 return virtblk_fail_to_queue(req, err);
>         }
>
> -       if (bd->last && virtqueue_kick_prepare(vblk->vqs[qid].vq))
> -               notify =3D true;
> +       if (bd->last)
> +               virtqueue_kick(vblk->vqs[qid].vq);
>         spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
>
> -       if (notify)
> -               virtqueue_notify(vblk->vqs[qid].vq);
>         return BLK_STS_OK;
>  }
>
> @@ -476,7 +469,6 @@ static void virtblk_add_req_batch(struct virtio_blk_v=
q *vq,
>  {
>         struct request *req;
>         unsigned long flags;
> -       bool kick;
>
>         spin_lock_irqsave(&vq->lock, flags);
>
> @@ -492,11 +484,8 @@ static void virtblk_add_req_batch(struct virtio_blk_=
vq *vq,
>                 }
>         }
>
> -       kick =3D virtqueue_kick_prepare(vq->vq);
> +       virtqueue_kick(vq->vq);
>         spin_unlock_irqrestore(&vq->lock, flags);
> -
> -       if (kick)
> -               virtqueue_notify(vq->vq);
>  }
>
>  static void virtio_queue_rqs(struct rq_list *rqlist)
> --
> 2.17.1
>

