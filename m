Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AAE1D5CD4
	for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737615192; cv=none; b=njIj4gaLS6W1jfD3u9lWaecp0vFuzFUyrBgGyoM6a0F85L3B5qJDxFoJGa8R3exXRt7tIePU0YyalqwDb83j31CJ7fERjFVrYzcjdTCwdHXaSpS+q7YCJzeA+ceQiUQoaNqUTvR/A9n0nHxI+V5PE6yGRQZu8JKxb6N0aQlEd9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737615192; c=relaxed/simple;
	bh=Gr6ZG8h9zIn+Uk4gz574c03M1oQ+qcvUKmmzZqd5i4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkI1n9SRP2fmLgqelAlmznVMdYHa/jp+sBC5ZICEHe4jMFyBIP9/1dt9YDgfyviOfkxBUnCh5p4U3k+pNtVIi5cswaNwrKTs7/h6IMvMeVJQc29yHo0nuD1tj6HoFAvaXotX87UhN9olRaJpKTkX8nRM5o+Q5pWDISVbptKWG5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tp31bNeQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tp31bNeQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737615189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQcO/l5DtwdzvIkCGyGlfnMe3JWtxE3sjvd0mTA7ILU=;
	b=Tp31bNeQAfDS5SgrV917mv/lYvEBAcfT2dGDUMz9PpT5B+1U+2TfRKSGneJqExAIbB7jdP
	1y8HLGMihrGHtKBcToFM2fdsAkl+mLeday4GcyDnEQoMJYijekRCc5oE0yms8bBIVbTs8a
	1/86GY/ReRqC/W5LdTAoI+YYaOvaldw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-xDrOyjhtOuem0H9iTeG3Rw-1; Thu, 23 Jan 2025 01:53:07 -0500
X-MC-Unique: xDrOyjhtOuem0H9iTeG3Rw-1
X-Mimecast-MFC-AGG-ID: xDrOyjhtOuem0H9iTeG3Rw
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa680e17f6dso38463466b.1
        for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 22:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737615186; x=1738219986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQcO/l5DtwdzvIkCGyGlfnMe3JWtxE3sjvd0mTA7ILU=;
        b=cF7uU4p94UjmNu96kP6cFxmKZrB2xRs+BU1QhrneLRhLB8eOXjZenB7BD/N9Bpnptc
         GSWSED/aGuM0xfd0oPLACDZ+kPKcQUoPQKan2AkMG/tsoMUMyVkpkHiUXjxtzXZ1iBDx
         3qOTCMeJQLmdEV5hqYBXWKcuZOg7C0yKytk7bfI0s1PsWTk7gRb7y48qUfUg5Ss3FIzA
         42O6VzGSTTwgAcw6ZEdmNZJUckJEP9bysISR08Umr/C7no+pYBKhE7V4zb3Yn1K1GqLZ
         NrwawAzALEIfhYm1fSuNNXnYdDzhRjr7Sn0eqgXAWtMuQnZp6Q5yYCO6EZB7MhYQoo00
         yRUw==
X-Forwarded-Encrypted: i=1; AJvYcCXMoHSVDLSJ9MYxz3r2Sr8avJrzVbxkJqOp53hdYCSTNnmTu5ePfJIkyoBt9dcutTA895I058xdQ504jw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yytc3zce5ccZcYJvrTzUY0+akwA+ENvHe7FirJ5mrdBMYx+SLIW
	EM+EXcLq+IP35DgAb0fEVKO6i+qbCDzrYLuNzJUntwY7q86cVOFO7o4rboxoG4Xj9Bw2j6Ibz8h
	UqBiLbZWaI+Lhh1frBS5dsfBzXdmtG4Tp1GCFkCcFWpGZwxzAhWOwtXAJPAnd
X-Gm-Gg: ASbGncvYzIPc5FiH5XvCaYEU1YTFYHGdPMYKhYimjzDFoun7ZjNb5rMMOq3mAL21F5o
	GK4iuhamkY+849xgS3VkoCMh5OGj5LNuFJ2qRT7EjMcwrBtPyXfClzEyTb3vYselOIqh/3HF8GU
	NgeOv8lL7oQcCTTzM1ppzoRwjXjkOsormoWobjvRh7tLsCm845akzOzTcx6yhdI+8YX1fRxLJFz
	gbvnjBU3xblGajmxAUkkGN6S2NSpTVVNa9isNzmhVKmlHhdBWNqJ7KEyII3zhqVkg==
X-Received: by 2002:a05:6402:40cd:b0:5dc:6c1:815d with SMTP id 4fb4d7f45d1cf-5dc06c18246mr5188183a12.8.1737615186428;
        Wed, 22 Jan 2025 22:53:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiFSNfIrCpShrvQeaKNzONEWfwNcni5pF1eO1NHnYMjq2F94J17WcN1+eFDmyllrY9yxzmqQ==
X-Received: by 2002:a05:6402:40cd:b0:5dc:6c1:815d with SMTP id 4fb4d7f45d1cf-5dc06c18246mr5188145a12.8.1737615186001;
        Wed, 22 Jan 2025 22:53:06 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:443:5f4e:8fd1:d298:3d75:448e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384c743e9sm1029538066b.10.2025.01.22.22.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 22:53:04 -0800 (PST)
Date: Thu, 23 Jan 2025 01:53:00 -0500
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
Message-ID: <20250123015147-mutt-send-email-mst@kernel.org>
References: <20250107182516.48723-1-andrew.boyer@amd.com>
 <7a4f03a0-9640-4d15-9f0d-4e1ceb82aa8c@linux.ibm.com>
 <20250109083907-mutt-send-email-mst@kernel.org>
 <FE77DD4F-AB39-4781-9D24-06F171F47FED@amd.com>
 <20250122100622-mutt-send-email-mst@kernel.org>
 <60290C9C-8975-4D7C-B1A2-8781EA5633AB@amd.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60290C9C-8975-4D7C-B1A2-8781EA5633AB@amd.com>

On Wed, Jan 22, 2025 at 05:45:28PM +0000, Boyer, Andrew wrote:
> 
> 
> > On Jan 22, 2025, at 10:13 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > On Wed, Jan 22, 2025 at 02:44:50PM +0000, Boyer, Andrew wrote:
> >> 
> >> 
> >>    On Jan 9, 2025, at 8:42 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> 
> >>    On Thu, Jan 09, 2025 at 01:01:20PM +0100, Christian Borntraeger wrote:
> >> 
> >> 
> >>        Am 07.01.25 um 19:25 schrieb Andrew Boyer:
> >> 
> >>            Commit af8ececda185 ("virtio: add VIRTIO_F_NOTIFICATION_DATA
> >>            feature
> >>            support") added notification data support to the core virtio driver
> >>            code. When this feature is enabled, the notification includes the
> >>            updated producer index for the queue. Thus it is now critical that
> >>            notifications arrive in order.
> >> 
> >>            The virtio_blk driver has historically not worried about
> >>            notification
> >>            ordering. Modify it so that the prepare and kick steps are both
> >>            done
> >>            under the vq lock.
> >> 
> >>            Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
> >>            Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> >>            Fixes: af8ececda185 ("virtio: add VIRTIO_F_NOTIFICATION_DATA
> >>            feature support")
> >>            Cc: Viktor Prutyanov <viktor@daynix.com>
> >>            Cc: virtualization@lists.linux.dev
> >>            Cc: linux-block@vger.kernel.org
> >>            ---
> >>             drivers/block/virtio_blk.c | 19 ++++---------------
> >>             1 file changed, 4 insertions(+), 15 deletions(-)
> >> 
> >>            diff --git a/drivers/block/virtio_blk.c b/drivers/block/
> >>            virtio_blk.c
> >>            index 3efe378f1386..14d9e66bb844 100644
> >>            --- a/drivers/block/virtio_blk.c
> >>            +++ b/drivers/block/virtio_blk.c
> >>            @@ -379,14 +379,10 @@ static void virtio_commit_rqs(struct
> >>            blk_mq_hw_ctx *hctx)
> >>             {
> >>               struct virtio_blk *vblk = hctx->queue->queuedata;
> >>               struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> >>            -   bool kick;
> >>               spin_lock_irq(&vq->lock);
> >>            -   kick = virtqueue_kick_prepare(vq->vq);
> >>            +   virtqueue_kick(vq->vq);
> >>               spin_unlock_irq(&vq->lock);
> >>            -
> >>            -   if (kick)
> >>            -           virtqueue_notify(vq->vq);
> >>             }
> >> 
> >> 
> >>        I would assume this will be a performance nightmare for normal IO.
> >> 
> >> 
> >> 
> >> 
> >> Hello Michael and Christian and Jason,
> >> Thank you for taking a look.
> >> 
> >> Is the performance concern that the vmexit might lead to the underlying virtual
> >> storage stack doing the work immediately? Any other job posting to the same
> >> queue would presumably be blocked on a vmexit when it goes to attempt its own
> >> notification. That would be almost the same as having the other job block on a
> >> lock during the operation, although I guess if you are skipping notifications
> >> somehow it would look different.
> >> 
> >> I don't have any sort of setup where I can try it but I would appreciate it if
> >> someone else could.
> >> 
> >> 
> >>    Hmm. Not good, notify can be very slow, holding a lock is a bad idea.
> >>    Basically, virtqueue_notify must work ouside of locks, this
> >>    means af8ececda185 is broken and we did not notice.
> >> 
> >>    Let's fix it please.
> >> 
> >> 
> >> With so many broken kernels already in the wild, I think disabling
> >> F_NOTIFICATION_DATA for virtio-blk would be a reasonable solution.
> > 
> > Some devices might fail feature negotiation then.
> > I am not sure they are broken, devices might simply be able to
> > handle out of order values.
> > 
> 
> A driver which does not support F_NOTIFICATION_DATA should just clear that bit. Surely devices which support it would also support not enabling it? Otherwise pre-6.4 kernels wouldn't work at all.
> 
> > 
> >> 
> >>    Try some kind of compare and swap scheme where we detect that index
> >>    was updated since? Will allow skipping a notification, too.
> >> 
> >> 
> >> Do you have an idea of how this might be done? Anything I've come up with
> >> involves a lock.
> >> 
> >> Would it be doable to have a lock for the vq management stuff
> >> and a second one to post notifications?
> > 
> > 
> > and only for when F_NOTIFICATION_DATA is set. not terrible ok I think.
> > 
> >> 
> >>    AMD guys, can't device survive with reordered notifications?
> >>    Basically just drop a notification if you see index
> >>    going back?
> >> 
> >> 
> >> This is the driver lying to us about the state of the queue; it's not going to
> >> be possible for us to work around it in hardware. For starters, how would we
> >> detect queue wrap around?
> >> 
> >> Thank you,
> >> Andrew
> > 
> > The index is a running value for split, for wrap arounds, there is
> > a special bit for that. No?
> > 
> 
> This is a hardware block used for many different interfaces and devices. When the notification write comes through, the doorbell block updates the queue state and schedules the queue for work. If a second notification comes in and overwrites that update before the queue is able to run (going backwards but not wrapping), we'll have no way of detecting it.
> 
> -Andrew

Do you not have programmable hardware that can compare current queue state
and the doorbell *before* overwriting it?



