Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59B2202C24
	for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737615099; cv=none; b=CZEInXhwjvqDSmA4e1Ce0AskulJrvlN3ah0iThiV0Kyqb/dDMNKazcZY/tjwHN1NFPKlMI5wdMMIpgYgTSXuNXOi7i2Dp1f5cy3zRJxOdbSdJOGTqyUDAoPwyMhSuiOZzqX/ER9Oh8OR5NBDxybAuL1BBX8mhAEeyYrZFN572M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737615099; c=relaxed/simple;
	bh=Gd9ypQyot58b2a+7e+EmHzuaC0SRQ4SIeyMiB2cBhV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2uOZOBF4JnDzp0JbeMP6vviDbT3aJVPYhovdeFKmZ1Hw4oCUYIw4AOn15p3ZSRu2N3nRCPFVb8x2ntkfmMTr0dHd212FmWEFb9kG9xp9kZxad5tSG1kDG1DvOr6hC16a5HQlVNSdzljiRHeghIZbJGhhydwahz5rivFxXDtBpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eusFY2bJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eusFY2bJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737615096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTxtP5GEqA9QhBeJ2GYcRCTnsRZJGXevVMPD+6qXWRs=;
	b=eusFY2bJscxlMnBkygRKodsgVwBe0EfX50aEmkBiyv4FUm9q52XAPSX8dZtCF/giRXe9nN
	EeW63TpD1DVfF4VlXwCe6Qa6hv9zDIymuDxFlBjc2vMRreED4JN4eFLHySsT4Fg7hMx3V7
	L/xk84zAXgWY/XpoYNcKjYTQud/iJy8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-FFeMhoD8MRWOzuZJQvhHOQ-1; Thu, 23 Jan 2025 01:51:33 -0500
X-MC-Unique: FFeMhoD8MRWOzuZJQvhHOQ-1
X-Mimecast-MFC-AGG-ID: FFeMhoD8MRWOzuZJQvhHOQ
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa69e84128aso41601466b.1
        for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 22:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737615092; x=1738219892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTxtP5GEqA9QhBeJ2GYcRCTnsRZJGXevVMPD+6qXWRs=;
        b=fioSGaR5VJj0DLEf2uHxMr1GKXTngBZKD0unhCCBVD4Vi7+ETHDTByU50o8aZPoLrg
         yLxa9VwliUkKRq5zYYxEQaGIzmdoVYXq6D0sE99C+eZQOEUMY06BdtDBkhEN5tCso5TY
         1jBpbDIVCeUlDZB06dvQlBIuzgki/7sMqKxAbeBElDEZHaaJqVzwZE8DzFDNFZU/Hl7T
         qXwE7SBI5wnYlS9ifDcMQwVNP/aVwGoq3vgzkUSpWeElOMn89ZGsxjv+TzmMAZSYtNPR
         Pq451dFr4cB/D5WTzrM455L2RB7N2gYMSWM2YU7FeByjQ1drb+WLW2XprfrE+2bdodrS
         1veg==
X-Forwarded-Encrypted: i=1; AJvYcCWb8ikS+HllGUNNoayjjLdWrsc7vRg8LlAIOKMCw4jKcSq4g8rE5UjD94VMdD1iLxRjvUElEj/AI+Jgpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpT7+u13NONKryWIcJsW39vfDpIjjkJ8aeEw1hG04IPB5zq+64
	3wpi4IBCUVtsX00QYdk4X2JtlbLFRq7OmXC30q5nMHTfrI0kvqszHgHmpibSY49553BytKwOA5M
	ZYAFCSK5ptaTQ2THeMQtnbpY8LhNOeo28ArIngNOJzny2R6xxDTk8aFJTyZOU
X-Gm-Gg: ASbGnctFeCZaqTB3dhjREC0jD7Q/2y2cwOgrhZZ7cp0n9K+/2Sv9CpLStfhpvhB66wr
	FbuOL82ImVrLQ/CzYGbd3QCZvJ27uDEeNNWATXM9fLRe17cbtzhG9oVYvm11n68Rrcxl0FpCvqW
	7wBvDIdsjnEL2QQEegDjBKtCI5jt0FE/LHOE2erDqfxZqWzb5A3WKfUVniQii3OwlabVBdz6wRr
	FVLAu784Dc2pYUgx8RlIjLYrK2WReQdSGjRTEeRvGXNUtpw4dih3ZuepKBerU0nBw==
X-Received: by 2002:a17:907:7da5:b0:aab:8a9d:6d81 with SMTP id a640c23a62f3a-ab38b3afad9mr2437397766b.44.1737615091891;
        Wed, 22 Jan 2025 22:51:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCfe8A35vAG1ot6PB4Nlj6BGYBtkibvkWK+9XUCPly223g1+K17tOt4GvSJp7Z+sK7r+SnJg==
X-Received: by 2002:a17:907:7da5:b0:aab:8a9d:6d81 with SMTP id a640c23a62f3a-ab38b3afad9mr2437395566b.44.1737615091458;
        Wed, 22 Jan 2025 22:51:31 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:443:5f4e:8fd1:d298:3d75:448e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384c5c3e1sm1012134466b.7.2025.01.22.22.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 22:51:30 -0800 (PST)
Date: Thu, 23 Jan 2025 01:51:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Boyer, Andrew" <Andrew.Boyer@amd.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
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
Message-ID: <20250123014913-mutt-send-email-mst@kernel.org>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
 <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
 <20250122165854-mutt-send-email-mst@kernel.org>
 <CB749FA4-79E2-49F0-9BDF-67B089A8EC35@amd.com>
 <20250122172108-mutt-send-email-mst@kernel.org>
 <CF92E813-EE94-4F61-A8A9-278CA1BD3629@amd.com>
 <CACGkMEuf2PgrOYvVdLjgQT53AH7pJFtk9L3bC55JZbkM78V_yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuf2PgrOYvVdLjgQT53AH7pJFtk9L3bC55JZbkM78V_yA@mail.gmail.com>

On Thu, Jan 23, 2025 at 09:47:24AM +0800, Jason Wang wrote:
> On Thu, Jan 23, 2025 at 6:34 AM Boyer, Andrew <Andrew.Boyer@amd.com> wrote:
> >
> >
> > > On Jan 22, 2025, at 5:25 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > On Wed, Jan 22, 2025 at 10:14:52PM +0000, Boyer, Andrew wrote:
> > >>
> > >>> On Jan 22, 2025, at 5:07 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >>>
> > >>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > >>>
> > >>>
> > >>> On Wed, Jan 22, 2025 at 06:33:04PM +0100, Christian Borntraeger wrote:
> > >>>> Am 22.01.25 um 15:44 schrieb Boyer, Andrew:
> > >>>> [...]
> > >>>>
> > >>>>>>>> --- a/drivers/block/virtio_blk.c
> > >>>>>>>> +++ b/drivers/block/virtio_blk.c
> > >>>>>>>> @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> > >>>>>>>> {
> > >>>>>>>>  struct virtio_blk *vblk = hctx->queue->queuedata;
> > >>>>>>>>  struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> > >>>>>>>> -   bool kick;
> > >>>>>>>>  spin_lock_irq(&vq->lock);
> > >>>>>>>> -   kick = virtqueue_kick_prepare(vq->vq);
> > >>>>>>>> +   virtqueue_kick(vq->vq);
> > >>>>>>>>  spin_unlock_irq(&vq->lock);
> > >>>>>>>> -
> > >>>>>>>> -   if (kick)
> > >>>>>>>> -           virtqueue_notify(vq->vq);
> > >>>>>>>> }
> > >>>>>>>
> > >>>>>>> I would assume this will be a performance nightmare for normal IO.
> > >>>>>>
> > >>>>>
> > >>>>> Hello Michael and Christian and Jason,
> > >>>>> Thank you for taking a look.
> > >>>>>
> > >>>>> Is the performance concern that the vmexit might lead to the underlying virtual storage stack doing the work immediately? Any other job posting to the same queue would presumably be blocked on a vmexit when it goes to attempt its own notification. That would be almost the same as having the other job block on a lock during the operation, although I guess if you are skipping notifications somehow it would look different.
> > >>>>
> > >>>> The performance concern is that you hold a lock and then exit. Exits are expensive and can schedule so you will increase the lock holding time significantly. This is begging for lock holder preemption.
> > >>>> Really, dont do it.
> > >>>
> > >>>
> > >>> The issue is with hardware that wants a copy of an index sent to
> > >>> it in a notification. Now, you have a race:
> > >>>
> > >>> thread 1:
> > >>>
> > >>>       index = 1
> > >>>               ->                      -> send 1 to hardware
> > >>>
> > >>>
> > >>> thread 2:
> > >>>
> > >>>       index = 2
> > >>>               -> send 2 to hardware
> > >>>
> > >>> the spec unfortunately does not say whether that is legal.
> > >>>
> > >>> As far as I could tell, the device can easily use the
> > >>> wrap counter inside the notification to detect this
> > >>> and simply discard the "1" notification.
> > >>>
> > >>>
> > >>> If not, I'd like to understand why.
> > >>
> > >> "Easily"?
> > >>
> > >> This is a hardware doorbell block used for many different interfaces and devices. When the notification write comes through, the doorbell block updates the queue state and schedules the queue for work. If a second notification comes in and overwrites that update before the queue is able to run (going backwards but not wrapping), we'll have no way of detecting it.
> > >>
> > >> -Andrew
> > >>
> > >
> > > Does not this work?
> > >
> > > notification includes two values:
> > >
> > > 1. offset
> > > 2. wrap_counter
> > >
> > > if ((offset2 < offset1 && wrap_counter2 == wrap_counter1) ||
> > >     offset1 > offset1 && wrap_counter2 != wrap_counter1)) {
> > >        printf("going backwards, discard offset2");
> > > }
> > >
> >
> > No, Michael, this does not work in our programmable hardware device, because it is not software.
> >
> > -Andrew
> >
> 
> Should we send a patch to disable this feature and cc stable first
> then consider how to fix this?
> 
> Thanks

Given this has been out there for a long time, I do not see
how this will contribute anything useful.

-- 
MST

