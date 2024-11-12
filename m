Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDAF2123EF
	for <linux-block@vger.kernel.org>; Tue, 12 Nov 2024 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406536; cv=none; b=vDIdcsk+sAYrDH80YGfDoOsvBr2pJeO9Ht1cZpmz7GJKMEnb6XFbyQMJFhTAFVCBJk4/WkKrQkGYaZJ5wAwUAPMalBV4M6fr6GkaOJFViuPtGRwIY2mA8SYW8aFvaskH0/ILYTBxoaxZeSCUczZjhkMTU6HZb1T1LnXfEwb46VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406536; c=relaxed/simple;
	bh=guooStJXMaoDbFn7X3kTw0Ev4pBjDl2YVD85exGZwWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qK+UZmNj65jrL8ymAxcDT/awPeGycbLdjgo4ozJYAbKj49och/zGy1I4OqqNrTW/216BqcrR30r3hsmWXZsRDDjufp1D6cb38ub8gMLAMEMOQyiIh/sQfcJej7HU1IPsv8xXMyvYYJIm4LCVV8lfXQDn4DK9wPecQxlFXMPA9m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KAMY5OQJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAMY5OQJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731406533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqdPdoNBYDYxp2NGpvmW30sz/k0Y1JvkYQr+xowAiyM=;
	b=KAMY5OQJ+dDVNjsNJI0BjHbJ6hGI9tFr9ypq9DKrdm3WBjIfI/KDrYPUeseSbbi8rVDKQF
	7cqvB14hl91yk8qG4eOvAi+I1aZ13mKSB3mBrPQacajocLiITzo084B3S1DMkIRRlMklh5
	tFAHRiTH6fbwMn5/tgW897zMwIKRGs0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-v7Fywjj1MVWmUPQCIBD58Q-1; Tue,
 12 Nov 2024 05:15:30 -0500
X-MC-Unique: v7Fywjj1MVWmUPQCIBD58Q-1
X-Mimecast-MFC-AGG-ID: v7Fywjj1MVWmUPQCIBD58Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 263E619560AE;
	Tue, 12 Nov 2024 10:15:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD6BD30001A2;
	Tue, 12 Nov 2024 10:15:19 +0000 (UTC)
Date: Tue, 12 Nov 2024 18:15:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
Message-ID: <ZzMqsmCVwfSHC7Vb@fedora>
References: <20241025003722.3630252-1-ming.lei@redhat.com>
 <20241025003722.3630252-4-ming.lei@redhat.com>
 <CGME20241029111338eucas1p2bd56c697b825eef235604e892569207e@eucas1p2.samsung.com>
 <ca16370e-d646-4eee-b9cc-87277c89c43c@samsung.com>
 <ZyEGLdg744U_xBjp@fedora>
 <6551c33f-b9e1-45ab-b420-d022d6e4e402@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6551c33f-b9e1-45ab-b420-d022d6e4e402@samsung.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Nov 12, 2024 at 09:36:40AM +0100, Marek Szyprowski wrote:
> On 29.10.2024 16:58, Ming Lei wrote:
> > On Tue, Oct 29, 2024 at 12:13:35PM +0100, Marek Szyprowski wrote:
> >> On 25.10.2024 02:37, Ming Lei wrote:
> >>> Recently we got several deadlock report[1][2][3] caused by
> >>> blk_mq_freeze_queue and blk_enter_queue().
> >>>
> >>> Turns out the two are just like acquiring read/write lock, so model them
> >>> as read/write lock for supporting lockdep:
> >>>
> >>> 1) model q->q_usage_counter as two locks(io and queue lock)
> >>>
> >>> - queue lock covers sync with blk_enter_queue()
> >>>
> >>> - io lock covers sync with bio_enter_queue()
> >>>
> >>> 2) make the lockdep class/key as per-queue:
> >>>
> >>> - different subsystem has very different lock use pattern, shared lock
> >>>    class causes false positive easily
> >>>
> >>> - freeze_queue degrades to no lock in case that disk state becomes DEAD
> >>>     because bio_enter_queue() won't be blocked any more
> >>>
> >>> - freeze_queue degrades to no lock in case that request queue becomes dying
> >>>     because blk_enter_queue() won't be blocked any more
> >>>
> >>> 3) model blk_mq_freeze_queue() as acquire_exclusive & try_lock
> >>> - it is exclusive lock, so dependency with blk_enter_queue() is covered
> >>>
> >>> - it is trylock because blk_mq_freeze_queue() are allowed to run
> >>>     concurrently
> >>>
> >>> 4) model blk_enter_queue() & bio_enter_queue() as acquire_read()
> >>> - nested blk_enter_queue() are allowed
> >>>
> >>> - dependency with blk_mq_freeze_queue() is covered
> >>>
> >>> - blk_queue_exit() is often called from other contexts(such as irq), and
> >>> it can't be annotated as lock_release(), so simply do it in
> >>> blk_enter_queue(), this way still covered cases as many as possible
> >>>
> >>> With lockdep support, such kind of reports may be reported asap and
> >>> needn't wait until the real deadlock is triggered.
> >>>
> >>> For example, lockdep report can be triggered in the report[3] with this
> >>> patch applied.
> >>>
> >>> [1] occasional block layer hang when setting 'echo noop > /sys/block/sda/queue/scheduler'
> >>> https://bugzilla.kernel.org/show_bug.cgi?id=219166
> >>>
> >>> [2] del_gendisk() vs blk_queue_enter() race condition
> >>> https://lore.kernel.org/linux-block/20241003085610.GK11458@google.com/
> >>>
> >>> [3] queue_freeze & queue_enter deadlock in scsi
> >>> https://lore.kernel.org/linux-block/ZxG38G9BuFdBpBHZ@fedora/T/#u
> >>>
> >>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >> This patch landed yesterday in linux-next as commit f1be1788a32e
> >> ("block: model freeze & enter queue as lock for supporting lockdep").
> >> In my tests I found that it introduces the following 2 lockdep warnings:
> >>
> >> > ...
> >>
> >>
> >> 2. On QEMU's ARM64 virt machine, observed during system suspend/resume
> >> cycle:
> >>
> >> # time rtcwake -s10 -mmem
> >> rtcwake: wakeup from "mem" using /dev/rtc0 at Tue Oct 29 11:54:30 2024
> >> PM: suspend entry (s2idle)
> >> Filesystems sync: 0.004 seconds
> >> Freezing user space processes
> >> Freezing user space processes completed (elapsed 0.007 seconds)
> >> OOM killer disabled.
> >> Freezing remaining freezable tasks
> >> Freezing remaining freezable tasks completed (elapsed 0.004 seconds)
> >>
> >> ======================================================
> >> WARNING: possible circular locking dependency detected
> >> 6.12.0-rc4+ #9291 Not tainted
> >> ------------------------------------------------------
> >> rtcwake/1299 is trying to acquire lock:
> >> ffff80008358a7f8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock+0x1c/0x28
> >>
> >> but task is already holding lock:
> >> ffff000006136d68 (&q->q_usage_counter(io)#5){++++}-{0:0}, at:
> >> virtblk_freeze+0x24/0x60
> >>
> >> which lock already depends on the new lock.
> >>
> >>
> >> the existing dependency chain (in reverse order) is:
> > This one looks a real thing, at least the added lockdep code works as
> > expected, also the blk_mq_freeze_queue() use in virtio-blk's ->suspend()
> > is questionable. I will take a further look.
> 
> Did you find a way to fix this one? I still observe such warnings in my 
> tests, even though your lockdep fixes are already merged to -next: 
> https://lore.kernel.org/all/20241031133723.303835-1-ming.lei@redhat.com/

The lockdep fixes in ->next is just for making the added lockdep work
correctly, and virtio-blk is another story.

It might be fine to annotate it with blk_mq_freeze_queue_no_owner(),
but it looks very fragile to call freeze queue in ->suspend(), and the lock
is just kept as being grabbed in the whole suspend code path.

Can you try the following patch?

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 194417abc105..21488740eb15 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1594,6 +1594,7 @@ static int virtblk_freeze(struct virtio_device *vdev)
 
 	/* Ensure no requests in virtqueues before deleting vqs. */
 	blk_mq_freeze_queue(vblk->disk->queue);
+	blk_mq_unfreeze_queue(vblk->disk->queue);
 
 	/* Ensure we don't receive any more interrupts */
 	virtio_reset_device(vdev);
@@ -1617,8 +1618,6 @@ static int virtblk_restore(struct virtio_device *vdev)
 		return ret;
 
 	virtio_device_ready(vdev);
-
-	blk_mq_unfreeze_queue(vblk->disk->queue);
 	return 0;
 }
 #endif



Thanks,
Ming

