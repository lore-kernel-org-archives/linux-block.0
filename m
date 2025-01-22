Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD95214205
	for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737558909; cv=none; b=FrBmuqoEMCPBTku4kgie179imtX3posVszqr18DkhvPBCTU6xBLtw+guuXmKm8+Uney1IRMK9R0Sso4lcKT/6b1iuHECwMjE2Z0SWVdCT/So2QRJ0mKuQXLuG+bXDZQ+iHJk64A761JLZospXZZFB5RbDAc/I9x8OrY4V1HVnx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737558909; c=relaxed/simple;
	bh=lPpWLlbJJUl6vnHfBxOZiUWLcQ6TXq9Fpz0DN6GGV64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+KbyHe69E/ZHSblMSau8OygS6ogrY8BCLNgcdgRxTJ3v3aHUmwSITtwBBg/0U2WVU61E+6ucDf/MCXuASMyABPzyF66fs8sxoMPFrbZFIuCBU2EBV3efo/YTmwpnAbpUMIQck03kc/vKFLIBV6Tbwih2k72r8NYnH9259cFFg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2uL7Kgh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2uL7Kgh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737558906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ce/QjhBqtYOPMLAkiHTYh++zKrz+BhDW7xpfx4DdWe4=;
	b=B2uL7KghsRc9eFMu3qjTGoIMCbUu2e6Tg5xHWTs0Pw0zRWKyw/qtqjjGcfvkZ+sQ83g1Uu
	KfiIJyouSX1bY8EGA72gWiu8tXlZpJJfkTsJvqlUHtcc1MWUJfvHc0C4D0FEikKptLwZS8
	zOjl4+brSpZJ0nc84LMirM2bnNdHwSE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-cSiLSTwPMGW-wVkAyq42hQ-1; Wed, 22 Jan 2025 10:15:05 -0500
X-MC-Unique: cSiLSTwPMGW-wVkAyq42hQ-1
X-Mimecast-MFC-AGG-ID: cSiLSTwPMGW-wVkAyq42hQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e00ebb16so2790315f8f.3
        for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 07:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737558904; x=1738163704;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ce/QjhBqtYOPMLAkiHTYh++zKrz+BhDW7xpfx4DdWe4=;
        b=J2Fx9QuJ7+sE3LIEEwsdn8tPB4SCdZ6QvO1tFe5bIV4Gj8X0tRc5SRq6QeJ3gNJXJf
         SQNloktP3PbjAI31siz08IaPPgzTmOaKPESgbrsJc/pmUfdRr2I2nW3Rk81MInAIA7MA
         KxDxxpw+rXHydG9BE8hCBFJF0GNBEpT9IabldJVWunuFZ8sP/D2B+u8t2/eXj2uobI23
         7yoJc/8R5gIo/KJLuDV+iRTuZbqt+FmC5gFK/WiRvAcKxzTYUFAJiRD/lV3glYxIXqv+
         m4wZx65A8VQvOXYyRJWiNRJmv/iZgA55cGTCzgNCXl1qOF8EimZJ+CczkPs56oYtqvvY
         7TJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoM1Ot4bFA4JKuMyoDq9Shh4EebUeL/F7N++WpqhWFZ6UESUKR30fIjxIr2JJ/06c7QyVFXbr9V4+NYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmmByz/0bUHz5xcOa8qlcYQS5v3iwj4UcLG2la9cXcLErgY4wE
	VoniMy9ksY9LnflP0lAzy+D0oHNLjI1uW8w7ZgjmNtYzmVl4xOaAXdqxRylSxvVRdQIF4aiRt+l
	yfoGE9Z7qAIQPifyKW95DcLhqoHhpYESPD4mVQaTxGv481N3zLUl4hHFgxUQP
X-Gm-Gg: ASbGncvbyBVYlTJiUz5FarcT2G1Emp/W6woZlRRR7OOfiKqUpp5SbYTQ1NmJWsBp4jY
	wQ00XDU22uYfFvMzGZ7bcxtpLplnVbFWJ2SGxYbt0xRS/rz2HhHKyTu8HpKgfQM/zfEu09Uv6op
	EeuEiXJbJWCVpOKDGy35wKVTjNpRs/jI+lITcnAdnqUWrWk6vRDXmAl7PSpAK0PQBQuz12H6iXT
	k9fKcutxlpw5ZCU5fiB0FZvc71fIMUahOquuV0nFQYAhGJMOsGsyASoTXh7wUmf
X-Received: by 2002:a05:6000:144f:b0:38a:615b:9ec0 with SMTP id ffacd0b85a97d-38bf57c0670mr20994576f8f.54.1737558904489;
        Wed, 22 Jan 2025 07:15:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWxbfA/SDt4BIMqHMb03+C8Lkaoo8RRwpEoMVY535ijCwj1N9P4T9iUGlJ8w8iJUU5Mj2ZIg==
X-Received: by 2002:a05:6000:144f:b0:38a:615b:9ec0 with SMTP id ffacd0b85a97d-38bf57c0670mr20994540f8f.54.1737558904146;
        Wed, 22 Jan 2025 07:15:04 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ee:98b0:e487:57f1:2425:c846])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3214fc9sm16205499f8f.6.2025.01.22.07.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 07:15:03 -0800 (PST)
Date: Wed, 22 Jan 2025 10:15:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Boyer, Andrew" <Andrew.Boyer@amd.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jens Axboe <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"Nelson, Shannon" <Shannon.Nelson@amd.com>,
	"Creeley, Brett" <Brett.Creeley@amd.com>,
	"Hubbe, Allen" <Allen.Hubbe@amd.com>
Subject: (repost) Re: [PATCH] virtio_blk: always post notifications under the
 lock
Message-ID: <20250122100622-mutt-send-email-mst-v2@kernel.org>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>

On Wed, Jan 22, 2025 at 02:44:50PM +0000, Boyer, Andrew wrote:
> 
> 
>     On Jan 9, 2025, at 8:42 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     On Thu, Jan 09, 2025 at 01:01:20PM +0100, Christian Borntraeger wrote:
> 
> 
>         Am 07.01.25 um 19:25 schrieb Andrew Boyer:
> 
>             Commit af8ececda185 ("virtio: add VIRTIO_F_NOTIFICATION_DATA
>             feature
>             support") added notification data support to the core virtio driver
>             code. When this feature is enabled, the notification includes the
>             updated producer index for the queue. Thus it is now critical that
>             notifications arrive in order.
> 
>             The virtio_blk driver has historically not worried about
>             notification
>             ordering. Modify it so that the prepare and kick steps are both
>             done
>             under the vq lock.
> 
>             Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
>             Reviewed-by: Brett Creeley <brett.creeley@amd.com>
>             Fixes: af8ececda185 ("virtio: add VIRTIO_F_NOTIFICATION_DATA
>             feature support")
>             Cc: Viktor Prutyanov <viktor@daynix.com>
>             Cc: virtualization@lists.linux.dev
>             Cc: linux-block@vger.kernel.org
>             ---
>              drivers/block/virtio_blk.c | 19 ++++---------------
>              1 file changed, 4 insertions(+), 15 deletions(-)
> 
>             diff --git a/drivers/block/virtio_blk.c b/drivers/block/
>             virtio_blk.c
>             index 3efe378f1386..14d9e66bb844 100644
>             --- a/drivers/block/virtio_blk.c
>             +++ b/drivers/block/virtio_blk.c
>             @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct
>             blk_mq_hw_ctx *hctx)
>              {
>                struct virtio_blk *vblk = hctx->queue->queuedata;
>                struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
>             -   bool kick;
>                spin_lock_irq(&vq->lock);
>             -   kick = virtqueue_kick_prepare(vq->vq);
>             +   virtqueue_kick(vq->vq);
>                spin_unlock_irq(&vq->lock);
>             -
>             -   if (kick)
>             -           virtqueue_notify(vq->vq);
>              }
> 
> 
>         I would assume this will be a performance nightmare for normal IO.
> 
> 
> 
> 
> Hello Michael and Christian and Jason,
> Thank you for taking a look.
> 
> Is the performance concern that the vmexit might lead to the underlying virtual
> storage stack doing the work immediately? Any other job posting to the same
> queue would presumably be blocked on a vmexit when it goes to attempt its own
> notification. That would be almost the same as having the other job block on a
> lock during the operation, although I guess if you are skipping notifications
> somehow it would look different.
> 
> I don't have any sort of setup where I can try it but I would appreciate it if
> someone else could.
> 
> 
>     Hmm. Not good, notify can be very slow, holding a lock is a bad idea.
>     Basically, virtqueue_notify must work ouside of locks, this
>     means af8ececda185 is broken and we did not notice.
> 
>     Let's fix it please.
> 
> 
> With so many broken kernels already in the wild, I think disabling
> F_NOTIFICATION_DATA for virtio-blk would be a reasonable solution.

Some devices might fail feature negotiation then.
I am not sure they are broken, devices might simply be able to
handle out of order values.


> 
>     Try some kind of compare and swap scheme where we detect that index
>     was updated since? Will allow skipping a notification, too.
> 
> 
> Do you have an idea of how this might be done? Anything I've come up with
> involves a lock.
>
> Would it be doable to have a lock for the vq management stuff
> and a second one to post notifications?


and only for when F_NOTIFICATION_DATA is set. not terrible ok I think.

> 
>     AMD guys, can't device survive with reordered notifications?
>     Basically just drop a notification if you see index
>     going back?
> 
> 
> This is the driver lying to us about the state of the queue; it's not going to
> be possible for us to work around it in hardware. For starters, how would we
> detect queue wrap around?
> 
> Thank you,
> Andrew

The index is a running value for split, for wrap arounds, there is
a special bit for that. No?


> 
> 
>     --
>     MST
> 
> 

