Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4261C8621
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433061; cv=none; b=QQfSDUVASGBEvtjA4El3UvQDyek9GqEh0FiOXwJsgir/UsweZ+hiTZWDZczQis3iamXdD6rQofMLjPP2+OqStEgRB+PMFlaOEBf2llJ9OGhMb+OrY4kB9R4PaNPNiSkb9ttLyQkax5g7iSTJYpf/Z0pmlUuhb8zK3C7RZJHC1c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433061; c=relaxed/simple;
	bh=WDOBWl1sMkKgUNmWDFSxppjd/IWKtGa4uvrGTm/miu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOxYvCx4K6SRadHiSehEp9bOLwJ3nJcy7bD0hqhFXq5cIcp667EUpbjl2UrSRb3wmBTZo4aDTFjE/12XNK2rrZApLSm7HCRk8NO092YtzfMTp10/jafLk75Q1IX61eSHuJr8V+dmh9PGs0ZnfntoCMqezW4lDiUJqNT0zahpnPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJQNXb2d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJQNXb2d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740433058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6V2M27vpsQ9gTyks7D6yUY1ng9ahm9dI23s803ex/g=;
	b=OJQNXb2dA24US3Gn/7ngHbz7WG2bvFiaHP9N4TQklLjIl/YKQW4enGirUoSp1qY+hEsrjz
	QlRAUSM98S/0w7fxfxp9ICOEXUpWRHF+l3VP09+iQkK76lwOF7/49VSKzIgLrsSfa4vEP5
	ruLOpB1hOJumm7vVA4RVy0UJ8t66zJU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-OnG2xsR8PeeEDDNZ9cuf7g-1; Mon, 24 Feb 2025 16:37:36 -0500
X-MC-Unique: OnG2xsR8PeeEDDNZ9cuf7g-1
X-Mimecast-MFC-AGG-ID: OnG2xsR8PeeEDDNZ9cuf7g_1740433055
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab39f65dc10so531540066b.1
        for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 13:37:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433055; x=1741037855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6V2M27vpsQ9gTyks7D6yUY1ng9ahm9dI23s803ex/g=;
        b=rVGHSV6nxHn7ZhjQOWHN15mHpWOZxZpJE0JSf+oPpT5y4dujFF2dXBxHjezDszpJsJ
         KLdCNTd98gCx+45+GswYOlvD2vl78omf4C+vvLxeIrZnqA4LTzHCGE0XXAkvrjyQgGJJ
         3Lcw21TJ3VKHijg94wkNl46R9lNpv6IyIkh/XtS4mw9L5shkwDx63mB1aFyNhIPXAZA5
         lEfePL9V8uINGvpga3cgcjiotoEwozEh3QCHDeLCg2J0susNP57edBEaeTjFYDrK/0D4
         dbc7bU87KGpoI+eCGhEl5MsrgZ3mJfVxac/1Tl0uE/5VXBqtf1Qt+WOQ0fpTDkAtsgtr
         sBhw==
X-Forwarded-Encrypted: i=1; AJvYcCVtpp2cRoVXtrt0ZjhrlATcXOZPbxnymmphODyLKjfzXGKPidhD9n9+fTfvFuRKGk3dv2rPMh8kQtJVpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzspLlD5+9fqD/Ua9pmUw3W8R11vllXJ8QqUp7FJf2ME77qUxM+
	gQmiX6GnSjI+ckXHhSscgcx3jTwnblfGVp6eBV2140P/9IC+VlCx407T1OzSwIfZWsydkd62Mcv
	p8XWKVqUOVFfvoRk85Y4o7ajF6r/w1kEzbOjYw4oZK2ResoHj89kimT5AWiv7
X-Gm-Gg: ASbGnctwyASpSE6PwSeOGnHSWjMt6pbJza0F+4aqKKgQxyo3strDCbYi4QSDt4Pc791
	A+OXfKaJDJ90DifOi/3g7hLjz7o/vGiF5hADBsHn95yo+xVvdXdQ7iUdc/sTis3hpEib5QgAyLM
	Bswr6VJLH9Lh42sUx+jZV4V0siTyJb8joOpbmqxi9oqhTKbByu+lf2LvlgiqWvDXcX+NSPY+gvQ
	onmiwm5gBgxMsx1DJsdIGDLzshRgtIYYwLCTYA15pg6NxXpPlun4aG7wWyWx/XnRcfY4dtHCwbH
	1dXijRCW4Q==
X-Received: by 2002:a17:907:d407:b0:abb:a8bb:5da0 with SMTP id a640c23a62f3a-abed0d762damr72543366b.26.1740433055411;
        Mon, 24 Feb 2025 13:37:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLx8zttoX9X6XdwqGGj4vktbpOYpC8f1Gz1u7RfvclZ761C7U56MVWUAyaydF6nH/gt6yf5g==
X-Received: by 2002:a17:907:d407:b0:abb:a8bb:5da0 with SMTP id a640c23a62f3a-abed0d762damr72541466b.26.1740433054971;
        Mon, 24 Feb 2025 13:37:34 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:441:1929:22c5:4595:d9bc:489e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed204f677sm24664866b.126.2025.02.24.13.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:37:34 -0800 (PST)
Date: Mon, 24 Feb 2025 16:37:30 -0500
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
Message-ID: <20250224163258-mutt-send-email-mst@kernel.org>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
 <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
 <20250122165854-mutt-send-email-mst@kernel.org>
 <5952f58f-9b80-4706-adb4-555f1489f2cf@linux.ibm.com>
 <20250224160208-mutt-send-email-mst@kernel.org>
 <575C32BA-63C3-4A2A-BC95-0E4F910DFA67@amd.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <575C32BA-63C3-4A2A-BC95-0E4F910DFA67@amd.com>

On Mon, Feb 24, 2025 at 09:31:24PM +0000, Boyer, Andrew wrote:
> 
> > On Feb 24, 2025, at 4:03 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > On Thu, Jan 23, 2025 at 09:39:44AM +0100, Christian Borntraeger wrote:
> >> 
> >> Am 22.01.25 um 23:07 schrieb Michael S. Tsirkin:
> >>> On Wed, Jan 22, 2025 at 06:33:04PM +0100, Christian Borntraeger wrote:
> >>>> Am 22.01.25 um 15:44 schrieb Boyer, Andrew:
> >>>> [...]
> >>>> 
> >>>>>>>> --- a/drivers/block/virtio_blk.c
> >>>>>>>> +++ b/drivers/block/virtio_blk.c
> >>>>>>>> @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> >>>>>>>>  {
> >>>>>>>>    struct virtio_blk *vblk = hctx->queue->queuedata;
> >>>>>>>>    struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> >>>>>>>> -   bool kick;
> >>>>>>>>    spin_lock_irq(&vq->lock);
> >>>>>>>> -   kick = virtqueue_kick_prepare(vq->vq);
> >>>>>>>> +   virtqueue_kick(vq->vq);
> >>>>>>>>    spin_unlock_irq(&vq->lock);
> >>>>>>>> -
> >>>>>>>> -   if (kick)
> >>>>>>>> -           virtqueue_notify(vq->vq);
> >>>>>>>>  }
> >>>>>>> 
> >>>>>>> I would assume this will be a performance nightmare for normal IO.
> >>>>>> 
> >>>>> 
> >>>>> Hello Michael and Christian and Jason,
> >>>>> Thank you for taking a look.
> >>>>> 
> >>>>> Is the performance concern that the vmexit might lead to the underlying virtual storage stack doing the work immediately? Any other job posting to the same queue would presumably be blocked on a vmexit when it goes to attempt its own notification. That would be almost the same as having the other job block on a lock during the operation, although I guess if you are skipping notifications somehow it would look different.
> >>>> 
> >>>> The performance concern is that you hold a lock and then exit. Exits are expensive and can schedule so you will increase the lock holding time significantly. This is begging for lock holder preemption.
> >>>> Really, dont do it.
> >>> 
> >>> 
> >>> The issue is with hardware that wants a copy of an index sent to
> >>> it in a notification. Now, you have a race:
> >>> 
> >>> 
> >>> thread 1:
> >>> 
> >>>    index = 1
> >>>            ->                      -> send 1 to hardware
> >>> 
> >>> thread 2:
> >>> 
> >>>    index = 2
> >>>            -> send 2 to hardware
> >>> 
> >>> 
> >>> 
> >>> 
> >>> the spec unfortunately does not say whether that is legal.
> >>> 
> >>> As far as I could tell, the device can easily use the
> >>> wrap counter inside the notification to detect this
> >>> and simply discard the "1" notification.
> >>> 
> >>> 
> >>> If not, I'd like to understand why.
> >> 
> >> Yes I agree with you here.
> >> I just want to emphasize that holding a lock during notify is not a workable solution.
> > 
> > 
> > Andrew, what do you say?
> > 
> > --
> > MST
> > 
> 
> "can *easily* use" -> No.
> 
> Our doorbell hardware is configurable, but not infinitely programmable. None of the suggested workarounds are feasible for hardware in the face of incorrect driver behavior. We have marked the feature as broken in the linux kernel driver and moved on.
> 
> Thanks,
> Andrew
> 

Thanks Andrew, I understand.
My question would be, is the feature worth it for you?

I see two way to move forward
1.- amend spec to say notifications can be reordered
2.- amend spec to say they can not be reordered and add a new feature bit
    saying they can be
    add a new lock for driver to hold in case the feature is off


1 is less work but if 2 gives you a big performance advantage, I can do it.

-- 
MST

