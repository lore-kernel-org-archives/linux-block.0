Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5257620B207
	for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737615829; cv=none; b=rprEyxXylhyld1TE/SLRlp+yKeX913uAgLGTbj6qBTmObgtQHkqOZOf/mhskbyZd9Sc8dQy1l+PAgsQ8hEFMDSKEQVFIFq/wZUlkWDWVHUyw071jBpYkrpxrhV5UrxCwY0BKXxX2suc9RiO3ZlZ8SDQ6fI8lUy44vfYF3agKphs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737615829; c=relaxed/simple;
	bh=s9QPfHCug/TTc7ih5INLxhU5stPSkgxsIUYeD5PQ7SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYsZVfYNC43WjQ1mxDuJZUV6jQzRrJxouxlNMpeNBvRaPLPMqI/+kfgCOn7zRoGNNNnmZ6LRJdC6EptKrEiLv4lZBw/SY4X3CwbT5mEck48kxsX0/3fOZqZ9jc6rEpL1+F+2e3hvDub/lkrpmQaK9mTFOPq8SrDlEGRdDvaOjnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQDcs1qj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQDcs1qj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737615826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YmWi+dVPUtT7M+4KcwcY+3ciCBE1YMwS0vc2Gr6Z8F4=;
	b=hQDcs1qj+fZJSfs1DLMqMNrOb4zQdmx454i5sAIUwq0rmq4tEWTMAQa9N36yoK4xvW++jS
	S/OImGYCqteEPPJJomfvZnc52Xcyi3xEcp7gdpKlq9uH45YU6eVTBpfiCKlv5aoUqiCjA7
	orJL39X4m2HwDH/UUAaSQKxFztmo9sI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-6RrPCreOPnm9KOuP2HRcxQ-1; Thu, 23 Jan 2025 02:03:43 -0500
X-MC-Unique: 6RrPCreOPnm9KOuP2HRcxQ-1
X-Mimecast-MFC-AGG-ID: 6RrPCreOPnm9KOuP2HRcxQ
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab39f65dc10so58437766b.1
        for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 23:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737615822; x=1738220622;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmWi+dVPUtT7M+4KcwcY+3ciCBE1YMwS0vc2Gr6Z8F4=;
        b=u5lID+ppCV9b5JUYv0BnCBiaKc3dWjY8R6H+yKyKbf7bhCVpIEN/mIb7wnitczbHGG
         082hAvzz2c70oKRSlZmPFyLgpSXn9j8OWvuI7ycj3/2aYBOQpmh0u4z7gfIVJGL2Ste6
         ZQsjlh1d5sykO4Q59pYCS9MkmKAnCci9o6SN1RFzLlcFw02dqWCS50v9vfTj+SS3JDc6
         wnNLqR95K5C24S7Gyv+ZtOn6BDNPM803Zx93VDg3iZkyEMd2+qbuvy2z4O+Px+2kmxb5
         N1ekfZixyEB7+P4bj7lG/mEiLlWzs/XKEmWzNh1k4KAiOOY6chLOucS0OGaw7T6TziHO
         bIPg==
X-Forwarded-Encrypted: i=1; AJvYcCX1Rmu+Vx5mouG0CdpLctnTnAX34Nc4CR6io3Sgp3ffcvbWHALeV0l3OqEwWsqK+DK6/GQTX8PoL6Q8Eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YySt5aOEgvGjk0o94/W028B2iYGXSB/zVO0zvUkfGzUcvp9NBFr
	srMXvuVnDlW4uBOFqCS7GM/eFKHKFY2M9rs0gRsdOQphFzV6PpA0Sc9WbF2ZW+ahkH567ZP5bsO
	lNeBXn9DKUkiWkyr0ZkkoXyLKtYFQ+ZdnNQZkEw27RHG81Na9r3nvTZcDQUjZJlB5lJiE
X-Gm-Gg: ASbGncsyVwDHENzlRlDtqkZ1ligub72A/I+eDzHmM7WQWy+3gONeeQWkr6dwHVWMF1z
	MH1cVRjY/41ARZE3IDOiBT6vsSaAtSc279NNMlwIU2PqKN+gV5JVz41adbQWTEalzIzEw9hBiNh
	kPxEJiQwrzU6U9FGLQds1iZ8buscaKcNz8JFKHu+OLxoQlK91LBoCv4TzmaQrdBM/YMFhhN5CXc
	Al5b+V70+/5WOqiZ+1G0qscGEP0p/6J9ppj1Qo780SUzsDYfb21KVifoFsF7CGu6g==
X-Received: by 2002:a17:907:7291:b0:aaf:3f57:9d2e with SMTP id a640c23a62f3a-ab38ad88887mr2332080766b.0.1737615821973;
        Wed, 22 Jan 2025 23:03:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6ZQ0xkB6wBE4/B7eKO7BqqlMTsLZBg+wFi6z+YZoVIIe62IALNtl9z3EO7Cew94iZ5rOxLg==
X-Received: by 2002:a17:907:7291:b0:aaf:3f57:9d2e with SMTP id a640c23a62f3a-ab38ad88887mr2332078066b.0.1737615821558;
        Wed, 22 Jan 2025 23:03:41 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:443:5f4e:8fd1:d298:3d75:448e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce2105sm1026949766b.67.2025.01.22.23.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 23:03:40 -0800 (PST)
Date: Thu, 23 Jan 2025 02:03:37 -0500
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
Message-ID: <20250123015428-mutt-send-email-mst@kernel.org>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
 <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
 <6BD82C41-B1C5-44C6-B485-9648C0ED964B@amd.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6BD82C41-B1C5-44C6-B485-9648C0ED964B@amd.com>

On Wed, Jan 22, 2025 at 05:49:18PM +0000, Boyer, Andrew wrote:
> 
> 
> > On Jan 22, 2025, at 12:33 PM, Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
> > 
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > Am 22.01.25 um 15:44 schrieb Boyer, Andrew:
> > [...]
> > 
> >>>>> --- a/drivers/block/virtio_blk.c
> >>>>> +++ b/drivers/block/virtio_blk.c
> >>>>> @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> >>>>> {
> >>>>>   struct virtio_blk *vblk = hctx->queue->queuedata;
> >>>>>   struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> >>>>> -   bool kick;
> >>>>>   spin_lock_irq(&vq->lock);
> >>>>> -   kick = virtqueue_kick_prepare(vq->vq);
> >>>>> +   virtqueue_kick(vq->vq);
> >>>>>   spin_unlock_irq(&vq->lock);
> >>>>> -
> >>>>> -   if (kick)
> >>>>> -           virtqueue_notify(vq->vq);
> >>>>> }
> >>>> 
> >>>> I would assume this will be a performance nightmare for normal IO.
> >>> 
> >> 
> >> Hello Michael and Christian and Jason,
> >> Thank you for taking a look.
> >> 
> >> Is the performance concern that the vmexit might lead to the underlying virtual storage stack doing the work immediately? Any other job posting to the same queue would presumably be blocked on a vmexit when it goes to attempt its own notification. That would be almost the same as having the other job block on a lock during the operation, although I guess if you are skipping notifications somehow it would look different.
> > 
> > The performance concern is that you hold a lock and then exit. Exits are expensive and can schedule so you will increase the lock holding time significantly. This is begging for lock holder preemption.
> > Really, dont do it.
> 
> If holding a lock at all is unworkable, do you have a suggestion for how we might fix the correctness issue?
> Because this is definitely a correctness issue.
> 
> I don't see anything in the spec about requiring support for out-of-order notifications.
> 
> -Andrew

Yes we didn't think it through in the spec :(
So driver made one assumption, for performance,
and the device made another one, for simplicity.

The data needed for the device to solve it, is there in the
notification. We can make the safe choice with the lock, and add a
feature flag for devices who can handle out of order,
or make the current choice and add a feature flag for
devices that need a lock.

Let's continue the discussion in another thread whether
a hardware workaround is possible.


-- 
MST

