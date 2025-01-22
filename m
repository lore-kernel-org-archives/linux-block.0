Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3F3149E17
	for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737584765; cv=none; b=ovXKZap23L3P58u6HbNKnvrtkyKVMX8/Ot7YsR/WPrHsMWm4GaqmeTfn6hV+q+yGZg5nGwyTNbwn2qltPvdbKpOyELJEEfCB7JS39uJVqNzZREbx8HhIDOeo1H6Nz3xpOXLzpYOJ++5aIj8EVRubT9RpN+gRQW9MZPN4hfyU5es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737584765; c=relaxed/simple;
	bh=5eXBoINOTvUSuoZiNuDWlz0bUkjdMqiKgAxp7RPGup4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aN9641BC6yExAccezdnmI1Mtl6clKkHaKZ61f2oresI01D0IgilPYYa0ZPOd/r//SJ0uDeHElt6hFJzmF6NlWs21HPy8MjylXj0x8RoGo6E0NsH4Nk7+5fdeorCkYOvHz9U+qe8ZFMk0x1WDhJPApjeC32nBekUrVyqKrGo/CmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=biSoGY3Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biSoGY3Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737584762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AHXhU6bWDw8TYDCC7oLhNKnJfNRqJA79QvQ44NI+/20=;
	b=biSoGY3YFj0cHSSju1lZDVUG04TI50fUYSpvZOU94oTCoJoIsdIIxRZN1MB33szjFi603p
	Sw2XUoRgtJfaoz1zK1Mmwexly3toaRm9leSK3azm+eR3b0lLK636Oxuxz5vL6jVIXULMpc
	gNEWAfDLHjWGGF3bXNy1uF3LDU37d7E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-QWune8V2MmujUFVPkjPU3w-1; Wed, 22 Jan 2025 17:26:00 -0500
X-MC-Unique: QWune8V2MmujUFVPkjPU3w-1
X-Mimecast-MFC-AGG-ID: QWune8V2MmujUFVPkjPU3w
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d3ff3c1b34so262624a12.1
        for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 14:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737584760; x=1738189560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHXhU6bWDw8TYDCC7oLhNKnJfNRqJA79QvQ44NI+/20=;
        b=Raps+gebTiNSgJAyiXLDFgWhXFGeRNDDZU4UrMwOpaSBLyRR4gA1BrBffx/ldlnHha
         cLtoxTba9lh8a+XpMKvotoJe2Uk+ttSvHt/S7zrxvSwDu/LXqFVM0CTQmAon3GJSRG0y
         K3/qZvODu/RDY2N3xC/cF4VxC3/v9Xwu0ViYDQ/ccqaehXSRvFRgGysdcxp0/jC94g8E
         xTWx4DU8zwIjAkDsr8gd3KGGa0AurbdlrbCJXCoFe3PJQgGO9Snm7+8PryMicGZyksp4
         tKDD6le+Iwy7TlC60Q/MzHVBbwisTggdoi59OtS7iqhocmNgZ8EHlEP/5vD+ZvKwqM1w
         HcbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBu6OKeOios4hTyQPaEsavWr82I6dQ97e/AymDUMmNhk7KZOGAz5GYhFwuKlIQwJN/CXFslyXBORh8Rg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo2Cool6/8VzKGjVc58THqwI6KnRrbJgLVRmT/NF6wMEObznv+
	C0PCfuQvcONAAU4N9r4WuIX4MLJOZoscz/DWW56aVg/Nv4Xdvn1ykDRfMgTY4yHQJK1z5rxHr4h
	zCfxk06h8bCUd+3seQDfYME9C8Mwer1qGaJMbhBsUtHiwkQY0dL8NIoecxSQs
X-Gm-Gg: ASbGnctGTu5Kq5x6c0Gu9VBdMwMqtX8HiZOsLyeeDeAaJagbUeVKM7mdfAlcyecfjrI
	OratrGp9qtmoMIHs8EvCwLJ+QE//iHqv21AEhEHfcyrDbPG6QgbZTR50lxp/9qx0AKBY3KDXdZp
	pdFEkTfcqxJ4AJLif8L4LNOqdAgoqaIeLDRBQRgj4lovs886Y7MNEewFayH4nhaaQrMgIbz+ZMl
	W37SfC/x2TxLcNPbvzgBZOcIxWNieo4At8dJS8jTFcuioSa04IBIFljqRrKMwOcpg==
X-Received: by 2002:a05:6402:518f:b0:5da:7f7:b9b2 with SMTP id 4fb4d7f45d1cf-5db7d318b5dmr24529242a12.18.1737584759635;
        Wed, 22 Jan 2025 14:25:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtOQBkWecsa+n8gYIhL0MGyQXdaUw0SIgtV8J55JDs8OqFYs8KyRgpgIpQCWjOe3xHzWJEMw==
X-Received: by 2002:a05:6402:518f:b0:5da:7f7:b9b2 with SMTP id 4fb4d7f45d1cf-5db7d318b5dmr24529225a12.18.1737584759262;
        Wed, 22 Jan 2025 14:25:59 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:443:5f4e:8fd1:d298:3d75:448e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73edbfafsm9234974a12.68.2025.01.22.14.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 14:25:57 -0800 (PST)
Date: Wed, 22 Jan 2025 17:25:52 -0500
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
Subject: Re: [PATCH] virtio_blk: always post notifications under the lock
Message-ID: <20250122172108-mutt-send-email-mst@kernel.org>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
 <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
 <20250122165854-mutt-send-email-mst@kernel.org>
 <CB749FA4-79E2-49F0-9BDF-67B089A8EC35@amd.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CB749FA4-79E2-49F0-9BDF-67B089A8EC35@amd.com>

On Wed, Jan 22, 2025 at 10:14:52PM +0000, Boyer, Andrew wrote:
> 
> > On Jan 22, 2025, at 5:07 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > On Wed, Jan 22, 2025 at 06:33:04PM +0100, Christian Borntraeger wrote:
> >> Am 22.01.25 um 15:44 schrieb Boyer, Andrew:
> >> [...]
> >> 
> >>>>>> --- a/drivers/block/virtio_blk.c
> >>>>>> +++ b/drivers/block/virtio_blk.c
> >>>>>> @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> >>>>>> {
> >>>>>>   struct virtio_blk *vblk = hctx->queue->queuedata;
> >>>>>>   struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> >>>>>> -   bool kick;
> >>>>>>   spin_lock_irq(&vq->lock);
> >>>>>> -   kick = virtqueue_kick_prepare(vq->vq);
> >>>>>> +   virtqueue_kick(vq->vq);
> >>>>>>   spin_unlock_irq(&vq->lock);
> >>>>>> -
> >>>>>> -   if (kick)
> >>>>>> -           virtqueue_notify(vq->vq);
> >>>>>> }
> >>>>> 
> >>>>> I would assume this will be a performance nightmare for normal IO.
> >>>> 
> >>> 
> >>> Hello Michael and Christian and Jason,
> >>> Thank you for taking a look.
> >>> 
> >>> Is the performance concern that the vmexit might lead to the underlying virtual storage stack doing the work immediately? Any other job posting to the same queue would presumably be blocked on a vmexit when it goes to attempt its own notification. That would be almost the same as having the other job block on a lock during the operation, although I guess if you are skipping notifications somehow it would look different.
> >> 
> >> The performance concern is that you hold a lock and then exit. Exits are expensive and can schedule so you will increase the lock holding time significantly. This is begging for lock holder preemption.
> >> Really, dont do it.
> > 
> > 
> > The issue is with hardware that wants a copy of an index sent to
> > it in a notification. Now, you have a race:
> > 
> > thread 1:
> > 
> >        index = 1
> >                ->                      -> send 1 to hardware
> > 
> > 
> > thread 2:
> > 
> >        index = 2
> >                -> send 2 to hardware
> > 
> > the spec unfortunately does not say whether that is legal.
> > 
> > As far as I could tell, the device can easily use the
> > wrap counter inside the notification to detect this
> > and simply discard the "1" notification.
> > 
> > 
> > If not, I'd like to understand why.
> 
> "Easily"?
> 
> This is a hardware doorbell block used for many different interfaces and devices. When the notification write comes through, the doorbell block updates the queue state and schedules the queue for work. If a second notification comes in and overwrites that update before the queue is able to run (going backwards but not wrapping), we'll have no way of detecting it.
> 
> -Andrew
> 


Does not this work?

notification includes two values:


1. offset
2. wrap_counter


if ((offset2 < offset1 && wrap_counter2 == wrap_counter1) ||
     offset1 > offset1 && wrap_counter2 != wrap_counter1)) {
	printf("going backwards, discard offset2");
}
    



