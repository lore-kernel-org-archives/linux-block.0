Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828A71D5147
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765527798; cv=none; b=mwhc+VHllCTlzICXLK8VmW227e3sOJPpFtxlO2Wu+TX4wiFCG/XttMN3IPyRIkbnJIKOlfuutJtnnwLNN7FbyhiF/mRCTLNERIJMobKvSr9as+xiNb/KcsHflpHSsApQKn3jxZ7Fon1bFwYZQKyQHq63ceMOuY8GWreYfokvTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765527798; c=relaxed/simple;
	bh=HJCYYPihd5VwkRkfhXPzRF4dmoMlF5CcCSIxsAPbujo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UllVn359XB3rGUeZX3RaeVK3q3uFBwXEPtK04AjNzEhHcA3JyOkT6ApQtu9U+rJWr90EXCeSt4wShD3SQxVpiWqwgyeCBqWlnCrxmzlHUFUY5k4aLlbV8Lcfh7eRvrRMI5XI8OTVx6CiVD/JsU0Fv9a2g8HFEhv6Ta9ATzuQdBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wd9EXhmY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wd9EXhmY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765527795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DWdzARIJkmkueujSHuzYfYoUjvfpiv/3+8T5UkDMLCI=;
	b=Wd9EXhmYOMTrD5mWEQkLF+Cvhfm1EJiVbAgqZQJaTKfnLT7a9Ja4GvzfRRkS37lRIibJK8
	ALeaBIs8y8j0CkbBsYFLHyuLC00YrCr6eaGavJ3TT2im8dILQsYIztLFGzEQXIe/QHktQ4
	TZIpu9CaY41J1JFH0VMX9flYCl25ra4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-uYGbusuSNr-P-POr_M3AYg-1; Fri,
 12 Dec 2025 03:23:14 -0500
X-MC-Unique: uYGbusuSNr-P-POr_M3AYg-1
X-Mimecast-MFC-AGG-ID: uYGbusuSNr-P-POr_M3AYg_1765527793
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DEEB18002DE;
	Fri, 12 Dec 2025 08:23:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.129])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A534030001A2;
	Fri, 12 Dec 2025 08:23:08 +0000 (UTC)
Date: Fri, 12 Dec 2025 16:22:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH] ublk: fix deadlock when reading partition table
Message-ID: <aTvQ4UokhqHtKGll@fedora>
References: <20251211083824.349210-1-ming.lei@redhat.com>
 <CADUfDZrVk_juib6yw8vrrYP0rrhrt7BxQPn89GeDi5q-XHNHOw@mail.gmail.com>
 <aTtFMvlgDvxfF5kN@fedora>
 <CADUfDZqh-jdJzK4E9bz0V12W=d4vGZOJMgC0F-EzXvd8dT_+4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqh-jdJzK4E9bz0V12W=d4vGZOJMgC0F-EzXvd8dT_+4Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Dec 11, 2025 at 08:56:46PM -0800, Caleb Sander Mateos wrote:
> On Thu, Dec 11, 2025 at 2:27 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Thu, Dec 11, 2025 at 12:30:35PM -0800, Caleb Sander Mateos wrote:
> > > On Thu, Dec 11, 2025 at 12:38 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > When one process(such as udev) opens ublk block device (e.g., to read
> > > > the partition table via bdev_open()), a deadlock[1] can occur:
> > > >
> > > > 1. bdev_open() grabs disk->open_mutex
> > > > 2. The process issues read I/O to ublk backend to read partition table
> > >
> > > I'm not sure I understand how a process could be issuing read I/O to
> > > the block device before bdev_open() has returned? Or do you mean that
> > > bdev_open() is issuing read I/O for the partition table via
> > > blkdev_get_whole() -> bdev_disk_changed() -> blk_add_partitions() ->
> > > check_partition()?
> >
> > Yes, disk->open_mutex is grabbed and waiting for reading partition table.
> >
> > >
> > > > 3. In __ublk_complete_rq(), blk_update_request() or blk_mq_end_request()
> > > >    runs bio->bi_end_io() callbacks
> > > > 4. If this triggers fput() on file descriptor of ublk block device, the
> > > >    work may be deferred to current task's task work (see fput() implementation)
> > >
> > > What is the bi_end_io implementation that results in an fput() call?
> >
> > libaio calls fput() via ->ki_complete() via bio->bi_end_io(), io-uring may
> > call it from io_free_rsrc_node().
> >
> > https://github.com/ublk-org/ublksrv/issues/170#issuecomment-3635162644
> >
> > >
> > > > 5. This eventually calls blkdev_release() from the same context
> > > > 6. blkdev_release() tries to grab disk->open_mutex again
> > > > 7. Deadlock: same task waiting for a mutex it already holds
> > > >
> > > > The fix is to run blk_update_request() and blk_mq_end_request() with bottom
> > > > halves disabled. This forces blkdev_release() to run in kernel work-queue
> > > > context instead of current task work context, and allows ublk server to make
> > > > forward progress, and avoids the deadlock.
> > >
> > > The idea here seems reasonable, but I can't say I understand all the
> > > pieces resulting in the deadlock.
> >
> > Please see the following scenarios:
> >
> > 1) task A: fio is running IO over /dev/ublkb0 for 5secs
> >
> > 2) task B: just when fio is exiting, another task is calling into ioctl(RRPART) on
> > /dev/ublkb0, waiting for reading partition with disk->open_mutex held.
> >
> > 3) in ublk server task, for some reason, fput() drops the `struct
> > file`'s last reference from task A, so bdev_release() is called from
> > task_work_run() in ublk server context. However, task B is holding
> > disk->open_mutex, so bdev_release() hangs forever, because this ublk server
> > can't handle IO for task B any more.
> 
> Ah okay this makes more sense, I thought the fput() was for the
> completion of the partition table read. But I see now it can be for
> any other process that happens to have opened the same ublk disk. The
> "userspace thread and not in interrupt/softirq" logic in
> __fput_deferred() to decide to close the file in task work seems
> pretty suspect. The assumption seems to be that blocking a userspace
> thread is fine since it won't be blocking any kernel threads, but
> that's clearly wrong for a userspace block device. I wonder if any
> similar deadlocks are possible with fuse? Pretending the ublk server

It should be one block only issue, cause it is related disk->open_disk.

> thread is in softirq context when completing the seems a bit hacky,
> but I can see it may be the simplest fix.
> 
> Do the blk_mq_end_request() calls in__ublk_do_auto_buf_reg() and
> __ublk_abort_rq() not also need this protection?

I think all needs this protection, will do it in v2.


Thanks,
Ming

