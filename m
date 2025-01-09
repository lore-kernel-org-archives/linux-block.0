Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF2214A6D
	for <linux-block@vger.kernel.org>; Thu,  9 Jan 2025 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417998; cv=none; b=GgzuFgN5fQ6okuhP/MY72zLgjHMvofrPPgTa9BNZ4YYjFq42E8vGcoNJUMWYCBRh/VXERlUpagCI2D8RTQQg8kweAePZSa29a6/e3JHW87JkUB/R9qGVCnNg1AwUAKRqGNv7L7MTZW2Cq7jA457m/6tm6GJNbimx1XxcEw97gfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417998; c=relaxed/simple;
	bh=uGiQxFy1s5xeq1KoKnvvc/uBnnzYKHTfVcJoqj87jNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ro9Z2KZThr6ElV7JIC5zieaaTbrnuoSWjWBDVo85zn1xb+Wk4MBRZ/s1OcYtbWFccS8fd/icJ0fTA+Nd6yEjqPLmb5dTwqQtAZsldVZWB/3p3iQp+JLrbJDJ1BZCPDH7a2Ayn44v/N1qJnWkogzjOUUIN2t37+BVrnrSCMnA0AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4bFdzaj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4bFdzaj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736417995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mDFZvC9ufxrWv6tOwpxDjE36uvyXj6GJcVYLoUQ5PZw=;
	b=E4bFdzajmXshW12JYG50loP6sKqXi4QH7jSc8PMFmbJESUXpVZtc/Ub1HahoPY5Lu6Jik7
	3qGE4tD3QZBmbhyZmmvVrPlEhP5KZV9VPJYbkhh29ds4bZz1Qis6ZFXTRl1lA7H347XL81
	z1dkE10qLwY2s3pfdtXDMQaUbea8FSo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-dsUSWGubPd-DNtqF7_DKcQ-1; Thu, 09 Jan 2025 05:19:54 -0500
X-MC-Unique: dsUSWGubPd-DNtqF7_DKcQ-1
X-Mimecast-MFC-AGG-ID: dsUSWGubPd-DNtqF7_DKcQ
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d401852efcso730867a12.2
        for <linux-block@vger.kernel.org>; Thu, 09 Jan 2025 02:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736417993; x=1737022793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDFZvC9ufxrWv6tOwpxDjE36uvyXj6GJcVYLoUQ5PZw=;
        b=tfryXdvrScANvRmtgeWEQa1/7eg7WbyZtTsFvkCQNe0K51itqoOAi1B73sUNEvT7Oh
         DDY/iKypce3hbuXOi85OpcZTzunErwKqOGt4yJJwbgJqRk3f4MtV3YZjvTiO/kz0uHd3
         DGy8OF21N/zujrDZ90Xlugbvvt3TF1jRTKlfIl/a60cho2fEhj3E6irI0XG5zegb5Kbn
         b4v7LdtQ0UCAds/vyBu1HuNsM421tF+oTm0oNgt2KUPskSRTyJQpwdRNoHYyDVngFj+q
         e75yCrGlqVGE7h3pJZjx/OieuxUfRA1U8hUQbkFqUUYzWJj7GWqzuB2ZuYKedWb5OgQ4
         6pEw==
X-Forwarded-Encrypted: i=1; AJvYcCUG//08FpwzMSejV1/ke732u89BDCPJA9rLUkX5YQUrPKoOSTmSWXtWwCB2VHRSCCgeGiEMS4A6tG64VQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZUZ7hZTbWfP8+eNTC+1ma6W2PO/EgKeCOVjtr1iX5ypKZvYzF
	hEKwjncz30gw+VXk5tdDRwprt6JKHNVymA/xFP7SQ8fNuClJO+lUFzopAQBTRIP9KMx/8DBciZ2
	7TcivGRyxoWR16HpU1AaAYck4nxV2KcVlHnZ7nNEvBp+tWAIeHtM1EuThdisV
X-Gm-Gg: ASbGncsbcaIIQJCT+xQEekp34UoIj5usgsJfskzu265nsZzhaBoBvX2kbZatBjf+UP1
	cBuVP+GZJJTvSD8pkBqDUa2QWlxW0Ciky65LA9/q+usxinlrI8qUhGHK4y0dXlpUjtlPSWMfzKc
	76zQ4Rd5MgAxY6YH3A5eDaYB/7GqtcaZdcBriO+8PLD+7+7zuy8cPzYJnX3xTCy2BbkAPsDfW+6
	lQoewurzgJCGgT3JUNU/6rePlzTJokefDZwuEHbB8hptq77Mgg=
X-Received: by 2002:a05:6402:5241:b0:5d0:f904:c23d with SMTP id 4fb4d7f45d1cf-5d972e6e094mr5985350a12.28.1736417992882;
        Thu, 09 Jan 2025 02:19:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeBBoWzpbGVe1gFjSBCCyHS+IRJ7sCY3Bae6DxEpGXChaWI3GoCv0AgWmxcGb5rxQohjRKQA==
X-Received: by 2002:a05:6402:5241:b0:5d0:f904:c23d with SMTP id 4fb4d7f45d1cf-5d972e6e094mr5985315a12.28.1736417992509;
        Thu, 09 Jan 2025 02:19:52 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c366sm460727a12.17.2025.01.09.02.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 02:19:50 -0800 (PST)
Date: Thu, 9 Jan 2025 05:19:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Boyer <andrew.boyer@amd.com>
Cc: Viktor Prutyanov <viktor@daynix.com>, Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: always post notifications under the lock
Message-ID: <20250109051337-mutt-send-email-mst@kernel.org>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107182516.48723-1-andrew.boyer@amd.com>

On Tue, Jan 07, 2025 at 10:25:16AM -0800, Andrew Boyer wrote:
> Commit af8ececda185 ("virtio: add VIRTIO_F_NOTIFICATION_DATA feature
> support") added notification data support to the core virtio driver
> code. When this feature is enabled, the notification includes the
> updated producer index for the queue. Thus it is now critical that
> notifications arrive in order.
> 
> The virtio_blk driver has historically not worried about notification
> ordering. Modify it so that the prepare and kick steps are both done
> under the vq lock.
> 
> Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Fixes: af8ececda185 ("virtio: add VIRTIO_F_NOTIFICATION_DATA feature support")
> Cc: Viktor Prutyanov <viktor@daynix.com>
> Cc: virtualization@lists.linux.dev
> Cc: linux-block@vger.kernel.org


Hmm. Not good, notify can be very slow, holding a lock is a bad idea.
Basically, virtqueue_notify must work ouside of locks, this
means af8ececda185 is broken and we did not notice.

Let's fix it please.

Try some kind of compare and swap scheme where we detect that index
was updated since? Will allow skipping a notification, too.




> ---
>  drivers/block/virtio_blk.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 3efe378f1386..14d9e66bb844 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct virtio_blk *vblk = hctx->queue->queuedata;
>  	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> -	bool kick;
>  
>  	spin_lock_irq(&vq->lock);
> -	kick = virtqueue_kick_prepare(vq->vq);
> +	virtqueue_kick(vq->vq);
>  	spin_unlock_irq(&vq->lock);
> -
> -	if (kick)
> -		virtqueue_notify(vq->vq);
>  }
>  
>  static blk_status_t virtblk_fail_to_queue(struct request *req, int rc)
> @@ -432,7 +428,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
>  	unsigned long flags;
>  	int qid = hctx->queue_num;
> -	bool notify = false;
>  	blk_status_t status;
>  	int err;
>  
> @@ -454,12 +449,10 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		return virtblk_fail_to_queue(req, err);
>  	}
>  
> -	if (bd->last && virtqueue_kick_prepare(vblk->vqs[qid].vq))
> -		notify = true;
> +	if (bd->last)
> +		virtqueue_kick(vblk->vqs[qid].vq);
>  	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
>  
> -	if (notify)
> -		virtqueue_notify(vblk->vqs[qid].vq);
>  	return BLK_STS_OK;
>  }
>  
> @@ -476,7 +469,6 @@ static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
>  {
>  	struct request *req;
>  	unsigned long flags;
> -	bool kick;
>  
>  	spin_lock_irqsave(&vq->lock, flags);
>  
> @@ -492,11 +484,8 @@ static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
>  		}
>  	}
>  
> -	kick = virtqueue_kick_prepare(vq->vq);
> +	virtqueue_kick(vq->vq);
>  	spin_unlock_irqrestore(&vq->lock, flags);
> -
> -	if (kick)
> -		virtqueue_notify(vq->vq);
>  }
>  
>  static void virtio_queue_rqs(struct rq_list *rqlist)
> -- 
> 2.17.1

