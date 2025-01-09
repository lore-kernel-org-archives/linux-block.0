Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1DC21639C
	for <linux-block@vger.kernel.org>; Thu,  9 Jan 2025 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430164; cv=none; b=C+KKIjjAEHF3MapB9O5xwNSoRW97YxJC3jlR3/wj7u6KoypaTg/o7z4fibSNv0H1rYKRqq9zuKCgKb0KPsfldvIBe9HwQQYNkW8Udp5oEdWfLtf/+E7t9x0Sov3zrA1mJI5YLHvQfNLFptC9ZLQ2F55UqP03BntXOvOZLOMi0JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430164; c=relaxed/simple;
	bh=D1tjE5WV0xVZYCiZTVJnAnSFOYdaDTE40svfqGvt1G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dzz/okqfgJQZDafXJpO3ni6tbLVPxfPNSRNsozzeI1x+xXWZzA2ICaC6uqNMVYO30vMJmkD1332U/WOovSqPFILrVh5zQ+LS/JA9sjXKGZMhM/gYXV2sHeuxzdEOl/74LpyiD9njPeZzmpZxqadtmZOgJ+ih0JyEnmPdKb4vraI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3nKA7Hq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3nKA7Hq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736430161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgu9dbtLOnj3MXP8lMoAJCySQHxuL505OovVfJN6VOY=;
	b=K3nKA7HqQ6nYMotYCoaAPHIDHxNsRV792NkajE51kyJ97q/PEamGOw1ED/y45QAKJQVdae
	U8OK4lDVA8OsAlgA13vrMh3zjaCxnDnwozcFwAuHC2nLZoWRhD/MAyQLalTWo7g/ioUMT2
	eljkrFebNmVvIVJwyX/4TowII+9XYAQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-8f69VNWwNW-64PZHTBuzGw-1; Thu, 09 Jan 2025 08:42:40 -0500
X-MC-Unique: 8f69VNWwNW-64PZHTBuzGw-1
X-Mimecast-MFC-AGG-ID: 8f69VNWwNW-64PZHTBuzGw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-436723db6c4so6260735e9.3
        for <linux-block@vger.kernel.org>; Thu, 09 Jan 2025 05:42:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736430159; x=1737034959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgu9dbtLOnj3MXP8lMoAJCySQHxuL505OovVfJN6VOY=;
        b=J9fqBpvCfszrfy9YcXk1k+E6eOWEs3neKa2t4lwTpkraei6L3GrtiPG7RP5zUjZeec
         QA+RP+jyZEhgYV4hTq6/Yf1gImVM2ssJ+RtATEXFnImqtQ6hkCPHfp6lVO5Jc6gCtIWT
         9Ypd7zR1N4vUIKAr+c/NJq5YS9aQMbocW8vnZJzDqKvqLWmCreYF9PnVFiJVa4n0HemJ
         ujOPFj40a9+hjHip5uEm01xXhb4F7p5hduaasALxdxQj+749xqcO28zBzdCcyXOClMwP
         j6jxZJDkWTqEyxvLMyzTQRq4KwEEjfNt8jPwWRY+3T14pQWaLwkvhXEd6ctlquYxLICk
         Is/w==
X-Forwarded-Encrypted: i=1; AJvYcCXu6jklP7IFpkPVpR9kFLvlJksGn31yvbyKwpnSdnVNN0arx0eBZAZxlhEWE2ooq6hjJhZxcc0qtChxiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+6rv6vq5YvP+IJOJVvSnYoQed/Xfk/AjjYoD2aox9oJBwl8xF
	R8TqR4o31BoDEdHv3uZG1gYyeGRui7XmsUdYy+qApHuxJDWjMQ8O9BoBSRdHViBqwHtBmINUaz7
	3fK+VVyXCYwgs1vpopS65kgZ4c9Gz7hjZjR2dmS8tUvjp6EsFFhDoh8pLabOE
X-Gm-Gg: ASbGncuFzPf3eMsySttE//JKcHkWv4mLr42qlhT6/hJ1+YayR+heMOiWy3q5uPAwSSI
	vZ3BCCbqinB+wwqP+2Umd5Z7NovTuTvVTYzueKBcwSyXPhw7BJe+4cL4Vsu+JKvp0XDBhnoEL2/
	12C2IO5GrWkZB9+99UHvsWDSB1zy2mKJaBw8WwCePC8fNSTybYaNLYdTVVlSu5gAFc+SWEjjPdo
	SKSIxPTvkfuSgHRrFrbRhvYTo/YLMIMU9ZGEKlhvHjQ7AmCU0Q=
X-Received: by 2002:a05:600c:4446:b0:434:f335:849 with SMTP id 5b1f17b1804b1-436e271cce0mr60626595e9.29.1736430159391;
        Thu, 09 Jan 2025 05:42:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWDZ/uz1Nn0qr7lYuRqwiS3nX0As1S7bC6v6LIqtZB2UDhqaEg4XL3T6juiTHl0iuzd3D6AA==
X-Received: by 2002:a05:600c:4446:b0:434:f335:849 with SMTP id 5b1f17b1804b1-436e271cce0mr60626385e9.29.1736430158984;
        Thu, 09 Jan 2025 05:42:38 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e37d3bsm21221385e9.31.2025.01.09.05.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 05:42:38 -0800 (PST)
Date: Thu, 9 Jan 2025 08:42:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Andrew Boyer <andrew.boyer@amd.com>,
	Viktor Prutyanov <viktor@daynix.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: always post notifications under the lock
Message-ID: <20250109083907-mutt-send-email-mst@kernel.org>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>

On Thu, Jan 09, 2025 at 01:01:20PM +0100, Christian Borntraeger wrote:
> 
> 
> Am 07.01.25 um 19:25 schrieb Andrew Boyer:
> > Commit af8ececda185 ("virtio: add VIRTIO_F_NOTIFICATION_DATA feature
> > support") added notification data support to the core virtio driver
> > code. When this feature is enabled, the notification includes the
> > updated producer index for the queue. Thus it is now critical that
> > notifications arrive in order.
> > 
> > The virtio_blk driver has historically not worried about notification
> > ordering. Modify it so that the prepare and kick steps are both done
> > under the vq lock.
> > 
> > Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
> > Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> > Fixes: af8ececda185 ("virtio: add VIRTIO_F_NOTIFICATION_DATA feature support")
> > Cc: Viktor Prutyanov <viktor@daynix.com>
> > Cc: virtualization@lists.linux.dev
> > Cc: linux-block@vger.kernel.org
> > ---
> >   drivers/block/virtio_blk.c | 19 ++++---------------
> >   1 file changed, 4 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 3efe378f1386..14d9e66bb844 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> >   {
> >   	struct virtio_blk *vblk = hctx->queue->queuedata;
> >   	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> > -	bool kick;
> >   	spin_lock_irq(&vq->lock);
> > -	kick = virtqueue_kick_prepare(vq->vq);
> > +	virtqueue_kick(vq->vq);
> >   	spin_unlock_irq(&vq->lock);
> > -
> > -	if (kick)
> > -		virtqueue_notify(vq->vq);
> >   }
> 
> I would assume this will be a performance nightmare for normal IO.

Indeed.
AMD guys, can't device survive with reordered notifications?
Basically just drop a notification if you see index
going back?


-- 
MST

