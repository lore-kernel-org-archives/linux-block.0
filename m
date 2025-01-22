Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D4214203
	for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737558846; cv=none; b=PqOb9YYwRD3dokIP9a+DS/7VXqQCQs0vu+ue1rMlCo3XGR9EVTwzrJJmlSotfuiKAD8YqWy/tHyyT9I3PXDJb3nYrKxT/0WlkBQ26c0VtO4dzuYCkK5cjVUPOD650Ao4wSKfET7q5xM6RU5GDfsOXKz501Fg+7Sk4RGxMEV6d4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737558846; c=relaxed/simple;
	bh=lPpWLlbJJUl6vnHfBxOZiUWLcQ6TXq9Fpz0DN6GGV64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJMRJGEJ1usG62m1a5eR7DrhItBbwJF1P2mvwKPRys1wGbe/i8lQm3aQxUafvZFsYFVl0R2BIBNgTiUX4EYnLMMYQKT0nzvKjwA9G3O3u2n86l1lUr3jAmeN/A1G0vWp2Ht5NH3ppYyUT/xUjN8OylzceF+sEg+KZ4TYVdiT034=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ij3cyrtw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ij3cyrtw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737558843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ce/QjhBqtYOPMLAkiHTYh++zKrz+BhDW7xpfx4DdWe4=;
	b=Ij3cyrtwx2LPvZmJhlpL07NB7+A6bImK1n66tXbR30HvfU8gTMsj6cybnK3tml6uKkZTzg
	H6PG5qs6/xVP6lBM0Wuycig+gn/BdmrH0uF8xqtI7xjzdE0ZH3fkzJ41jkHfuaaDAnUSru
	h39he4u2ldrBCC0I+WLk0v0GRSOruAc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-zUpkq3PmNkiOOhnzdqzL9A-1; Wed, 22 Jan 2025 10:14:01 -0500
X-MC-Unique: zUpkq3PmNkiOOhnzdqzL9A-1
X-Mimecast-MFC-AGG-ID: zUpkq3PmNkiOOhnzdqzL9A
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38bf4913669so2899483f8f.2
        for <linux-block@vger.kernel.org>; Wed, 22 Jan 2025 07:14:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737558840; x=1738163640;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ce/QjhBqtYOPMLAkiHTYh++zKrz+BhDW7xpfx4DdWe4=;
        b=aOSXgOkLSfMq1hzq5ZlzSLePX+hoYy3hXTXSbPmdWYRFOoFIKVcxGmxxTpHkRhtvTx
         UMb/3aX69dQeo4R4gMLre0GD9hB1C615EFj3W3HWIEZKFoPZNRRNxKVpl5wTHaXoAoxW
         y8JSF1vxyBE7m8Q9JmBu2zpVr8Pf5vIe38RoIZlbqnbauNsJVn11eBRBW5A7NtdhJRgR
         R9+xkbOtkbLBtFF54IP1BhLDgaIwIjsize3eH+DALJ+kQSEnqLtiBhjwn6Df6gC9DonO
         bRtt5uKkXW7LQ+MZB9fRWCAF4w8PXYfN69v+lqSVoD1fQ4L/24nIynytZfwF48g5mpjv
         OmOg==
X-Forwarded-Encrypted: i=1; AJvYcCXUYjmDbFhw9D066aUk0UB35EnlfsXsZeQX/0OVaqlRbOwZ339tE0ISrmrebtJXJYZ2dfpx9NhDRa8BAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjZ6h6tM/QmAQBu8luJrPmny3wnIzuJ3aRuByyCZisgTYC9kVj
	+Ugq6Gpkez5FwfmybiKc1epg8lmsyXmoMztwya7Y+gQSDIN1OtttHZSgvLaZTbskJaus2TpdFhw
	zK7B4OvxZMzxemVqRcEN+r37ofAozw4sAbxrsZqtKW+g/QS2tHt5Rd+v1kSJz
X-Gm-Gg: ASbGncuZCruRUU51CScfLwK2B6ILIhdBCCa/2BY13GJPScjVIigq53OANN8HFFVaZdo
	kv8tbkRLU3raZgd4jqE7wlFvaJ1FUdTSZg9d5UvYSDytBNQKxq092qV7qZuzM3aDEjxig4KXYMa
	V1Wy01vCvEv+82+xzhkcU+AKqclI81u4nupVPFEYMQ/RpHNBez5KBL0hYv7L7ZyNX4gHmg4cP2r
	M02BjURRseCPPSPFZhn3yw4We11dYovbo7sxiJU9NU9EifHWnOje9q5PHPnNjIG
X-Received: by 2002:a5d:6a92:0:b0:386:3403:7b63 with SMTP id ffacd0b85a97d-38bf57b3d42mr14263210f8f.36.1737558840592;
        Wed, 22 Jan 2025 07:14:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG98aiW2exKzPtkQyluWhC+N2CzRYQXNIHtp1nt9tt6znbLOVgpTCijmWVYegbMuPepz+eENw==
X-Received: by 2002:a5d:6a92:0:b0:386:3403:7b63 with SMTP id ffacd0b85a97d-38bf57b3d42mr14263193f8f.36.1737558840228;
        Wed, 22 Jan 2025 07:14:00 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ee:98b0:e487:57f1:2425:c846])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327df79sm16929435f8f.91.2025.01.22.07.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 07:13:59 -0800 (PST)
Date: Wed, 22 Jan 2025 10:13:56 -0500
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
Message-ID: <20250122100622-mutt-send-email-mst@kernel.org>
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

