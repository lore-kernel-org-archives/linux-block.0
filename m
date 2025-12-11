Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51D2A937
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765492032; cv=none; b=LkAYNhV/VEhjHYdYMpLjwVps8UOQIVo8wR5lfraHGWzJ60YG93UrckJBuzh/zGgaTfFu1xpChPjAFipHLZjxy/Xli1Br13KZZNFWP2MPmsUTM3NvcnPNOUxRaBacEv8sERcpnlXRXBJgypb2dmrBXzn1edzYs9sTGjTI3tVs+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765492032; c=relaxed/simple;
	bh=Kbwp2z6SiC+0qfEYfPzvVOCnLVNvlbTdEJpS2qQcm7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0x/huFNCE7JDCQ8Xf7URGKD/poe2XRWhBzMPPSmaiKeihIdMinKUaoBU66nZGizMUhSIRXGSMZ796re4Nvm+4qOrtnGHqXJmN9nQNFFkj90hvL9yk81H5ihLsyzRGz1byGDgOKxtlxTAMIfcNb0JhLrD52tIy1WHQEpKmRGF7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sij5l4VL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sij5l4VL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765492029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uq6wcxNQG1dTQXCRnCx7LuNwOWO3kRtlh2He56Kcbw=;
	b=Sij5l4VLqIJj/DhTtX+b8keuUADjJYY8vpo+EBX3T1y41l+wuho3Lt8j2BLboBAKHXsHCy
	b3iE77cPvzuyghvH6hM5yvfl5E/HNK+FMqcRYiZs+RFWGWXRg+urXMdcDOtYEnc3Ol9TYW
	gBUHTjCWT6E4UU/kX3mP6Bxmllg5Qgo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-dvb7zVaNPje1BYY2xyntwQ-1; Thu,
 11 Dec 2025 17:27:08 -0500
X-MC-Unique: dvb7zVaNPje1BYY2xyntwQ-1
X-Mimecast-MFC-AGG-ID: dvb7zVaNPje1BYY2xyntwQ_1765492027
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D413B195DE48;
	Thu, 11 Dec 2025 22:27:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.129])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 716201800451;
	Thu, 11 Dec 2025 22:27:03 +0000 (UTC)
Date: Fri, 12 Dec 2025 06:26:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH] ublk: fix deadlock when reading partition table
Message-ID: <aTtFMvlgDvxfF5kN@fedora>
References: <20251211083824.349210-1-ming.lei@redhat.com>
 <CADUfDZrVk_juib6yw8vrrYP0rrhrt7BxQPn89GeDi5q-XHNHOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrVk_juib6yw8vrrYP0rrhrt7BxQPn89GeDi5q-XHNHOw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Dec 11, 2025 at 12:30:35PM -0800, Caleb Sander Mateos wrote:
> On Thu, Dec 11, 2025 at 12:38 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > When one process(such as udev) opens ublk block device (e.g., to read
> > the partition table via bdev_open()), a deadlock[1] can occur:
> >
> > 1. bdev_open() grabs disk->open_mutex
> > 2. The process issues read I/O to ublk backend to read partition table
> 
> I'm not sure I understand how a process could be issuing read I/O to
> the block device before bdev_open() has returned? Or do you mean that
> bdev_open() is issuing read I/O for the partition table via
> blkdev_get_whole() -> bdev_disk_changed() -> blk_add_partitions() ->
> check_partition()?

Yes, disk->open_mutex is grabbed and waiting for reading partition table.

> 
> > 3. In __ublk_complete_rq(), blk_update_request() or blk_mq_end_request()
> >    runs bio->bi_end_io() callbacks
> > 4. If this triggers fput() on file descriptor of ublk block device, the
> >    work may be deferred to current task's task work (see fput() implementation)
> 
> What is the bi_end_io implementation that results in an fput() call?

libaio calls fput() via ->ki_complete() via bio->bi_end_io(), io-uring may
call it from io_free_rsrc_node().

https://github.com/ublk-org/ublksrv/issues/170#issuecomment-3635162644

> 
> > 5. This eventually calls blkdev_release() from the same context
> > 6. blkdev_release() tries to grab disk->open_mutex again
> > 7. Deadlock: same task waiting for a mutex it already holds
> >
> > The fix is to run blk_update_request() and blk_mq_end_request() with bottom
> > halves disabled. This forces blkdev_release() to run in kernel work-queue
> > context instead of current task work context, and allows ublk server to make
> > forward progress, and avoids the deadlock.
> 
> The idea here seems reasonable, but I can't say I understand all the
> pieces resulting in the deadlock.

Please see the following scenarios:

1) task A: fio is running IO over /dev/ublkb0 for 5secs

2) task B: just when fio is exiting, another task is calling into ioctl(RRPART) on
/dev/ublkb0, waiting for reading partition with disk->open_mutex held.

3) in ublk server task, for some reason, fput() drops the `struct
file`'s last reference from task A, so bdev_release() is called from
task_work_run() in ublk server context. However, task B is holding
disk->open_mutex, so bdev_release() hangs forever, because this ublk server
can't handle IO for task B any more.

Jiri Pospisil has verified this patch and closes https://github.com/ublk-org/ublksrv/issues/170.


Thanks,
Ming

