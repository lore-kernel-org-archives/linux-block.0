Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB791F470D
	for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737617011; cv=none; b=iSq375Xtswq+pp5+5L3WatB3R4f3QjFlnnMkgtgaXbeP0daw4DylHUHlHc1C/GdtXqOzRpEBzPmr9IFflK6E5Qr2Un+RYPsLM4x9qGcJmauE9fbMnw3jNWb7T4LIZJNj32GQ51KDlo7inDtc5SRWq2JQPlof2UFk+yZEpENuFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737617011; c=relaxed/simple;
	bh=Cj26cskdJAfLewDEV5iNIb1OHKs1+zCO9WSBAIvdmIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ngvj757LWwPmNbe58mcK2YT7fBXBoxo5v1r5GHcvli1C68hR3yHbdvUlC5Rju6BN/4R3s88s9SA5nIfZfQXCWbUTx+Lm19zfjOOWLBfyseI/bfpS/TzQfVDw6cjrgzTyjrWwoB+5/vPs8/JdPzxv2XeN3KylfVQQZcvCQbY3pZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmPIAdfG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmPIAdfG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737617008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEjZ3DIkUiMscnADmgxdYLnNl1viSPj/Nq8G2dSYRQk=;
	b=dmPIAdfGNZdF/MJsiQ/TZYXsEh575hc5bgjWKNTVYEW0hBIEtbgF8gxy7kWKL8bCCxE3Bn
	ru8b4OxeYG2AeLILfUosSmJv5ea2f08DT5csA8+VDWtyoMS5Utw+QAe/ch5Hhi1eXCzKjT
	a3x/lD5mpk47uG2ya3BgdzdaVKquz3U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-QrBLoMokPIqAL84V3D25bQ-1; Thu, 23 Jan 2025 02:23:27 -0500
X-MC-Unique: QrBLoMokPIqAL84V3D25bQ-1
X-Mimecast-MFC-AGG-ID: QrBLoMokPIqAL84V3D25bQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38c24ac3706so378328f8f.0
        for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 23:23:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737617006; x=1738221806;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEjZ3DIkUiMscnADmgxdYLnNl1viSPj/Nq8G2dSYRQk=;
        b=F34cwbdwh2DIZ+MifKLbeNlMYcykGMj6eL/Wigig4bw/O/ZOApvKcZl35+07kj5Hou
         YefLxKw0GEq+pzL20aulrDPpBOZ5kZjXpYoQ5EdOlG3DOhJDhfuqpHmitu9TOx0Z0y+l
         h2QUm231oNHM4jHFbOohBWneyfO9K0VJkNaEx+PqI0hXPQHbUf9OLwSBjbM+Kfecujld
         oI/Tkr+TCvAh3cu4RRhbNTH7R6Z2pX58+u3ctF0P9Bc55byaYOMcuJEM1S469PJP2KA/
         0lE2US1MXEb4b5H2VLInKDwWznh552m/dwgQypYDoCZCm3T3jkkUKoIA59ooW9ZZwN6m
         UWkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQffsNI4RuVXqQrs5kW9ysuZ3vn2GPfxiQOWu6cJ7VeIvxnblervOQwozlYnOllykgdD/D5vEQconIYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLnVVdhmujsuNw5bj8+YphuhSPCcvIHQFc/XQzyNaHHX5R5OZN
	eAM3ao7reNVbAZgHSLrjcNCLo0/n1l5EdhfoZyjn9ks7RxQwJP7VR047qnYLAgjxSios4qkZCRU
	4KUjuFh6sOghg3VzkyGRLIpgnK4XgjjVmUBcbsgj3MzvjE3tyfssk7IJ+n9rK
X-Gm-Gg: ASbGncsReEk6mjjTypX8ygji4cmMthMHX0wGpyWcjEuBoCJ2i9oR/YrIyC+2bq0dxy5
	X2tUWwyPviw2z0cPFw0ojdJgUskZ2R9FtyKreRvjvzsS2+Jc2jswjJ9XJDGp7dB6EHs6HJkQuSs
	1b57E7YQfmNm25atiy+f4UpnoM8FFZzGkH6OGahgcWfK0eKRQKHW50yaHryjCZo2qorRya+YIP6
	7MPgQ2DGmfPqpGzDr2zT6joSERYjtXPPPo7IDm/G49aKDLWdn0WyPg8CX48POg=
X-Received: by 2002:a05:6000:2a7:b0:38a:615c:8225 with SMTP id ffacd0b85a97d-38bf577ff42mr24558328f8f.15.1737617005963;
        Wed, 22 Jan 2025 23:23:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPiImKfEJi/7FivTSc2UB3WJZJ0sYMW32d83TGxasXwFBmg/HvTr5DTVHuAiFshHvv5ywOeA==
X-Received: by 2002:a05:6000:2a7:b0:38a:615c:8225 with SMTP id ffacd0b85a97d-38bf577ff42mr24558293f8f.15.1737617005572;
        Wed, 22 Jan 2025 23:23:25 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:7f17:bbf:7fe7:5101:d895])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322236csm18572097f8f.39.2025.01.22.23.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 23:23:24 -0800 (PST)
Date: Thu, 23 Jan 2025 02:23:17 -0500
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
Message-ID: <20250123022305-mutt-send-email-mst@kernel.org>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
 <dcbce68c-f448-4bbf-8db9-c3cd3231b5dd@linux.ibm.com>
 <20250122165854-mutt-send-email-mst@kernel.org>
 <CB749FA4-79E2-49F0-9BDF-67B089A8EC35@amd.com>
 <20250122172108-mutt-send-email-mst@kernel.org>
 <CF92E813-EE94-4F61-A8A9-278CA1BD3629@amd.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CF92E813-EE94-4F61-A8A9-278CA1BD3629@amd.com>

On Wed, Jan 22, 2025 at 10:34:25PM +0000, Boyer, Andrew wrote:
> 
> > On Jan 22, 2025, at 5:25 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > On Wed, Jan 22, 2025 at 10:14:52PM +0000, Boyer, Andrew wrote:
> >> 
> >>> On Jan 22, 2025, at 5:07 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>> 
> >>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> >>> 
> >>> 
> >>> On Wed, Jan 22, 2025 at 06:33:04PM +0100, Christian Borntraeger wrote:
> >>>> Am 22.01.25 um 15:44 schrieb Boyer, Andrew:
> >>>> [...]
> >>>> 
> >>>>>>>> --- a/drivers/block/virtio_blk.c
> >>>>>>>> +++ b/drivers/block/virtio_blk.c
> >>>>>>>> @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> >>>>>>>> {
> >>>>>>>>  struct virtio_blk *vblk = hctx->queue->queuedata;
> >>>>>>>>  struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> >>>>>>>> -   bool kick;
> >>>>>>>>  spin_lock_irq(&vq->lock);
> >>>>>>>> -   kick = virtqueue_kick_prepare(vq->vq);
> >>>>>>>> +   virtqueue_kick(vq->vq);
> >>>>>>>>  spin_unlock_irq(&vq->lock);
> >>>>>>>> -
> >>>>>>>> -   if (kick)
> >>>>>>>> -           virtqueue_notify(vq->vq);
> >>>>>>>> }
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
> >>> thread 1:
> >>> 
> >>>       index = 1
> >>>               ->                      -> send 1 to hardware
> >>> 
> >>> 
> >>> thread 2:
> >>> 
> >>>       index = 2
> >>>               -> send 2 to hardware
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
> >> "Easily"?
> >> 
> >> This is a hardware doorbell block used for many different interfaces and devices. When the notification write comes through, the doorbell block updates the queue state and schedules the queue for work. If a second notification comes in and overwrites that update before the queue is able to run (going backwards but not wrapping), we'll have no way of detecting it.
> >> 
> >> -Andrew
> >> 
> > 
> > Does not this work?
> > 
> > notification includes two values:
> > 
> > 1. offset
> > 2. wrap_counter
> > 
> > if ((offset2 < offset1 && wrap_counter2 == wrap_counter1) ||
> >     offset1 > offset1 && wrap_counter2 != wrap_counter1)) {
> >        printf("going backwards, discard offset2");
> > }
> > 
> 
> No, Michael, this does not work in our programmable hardware device, because it is not software.
> 
> -Andrew
> 

Of course. The hardware equivalent.

