Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D522F163
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690530; cv=none; b=tiQZmc44lQ9yO2EfTIp66hBSFyCtgCIiaJ3+/1+bIx6OWmuQmG2JbldL1eDE4foXCWtsovfbGIcOJ7scsP5ZmcF8LRoqdZiRvtRTqFu+9gsOWwWiP+gjA22zvtdr+kHwMJXQh3U2pFNMSXI+O07DXL8FlPr8YgutzM7ez5GvAH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690530; c=relaxed/simple;
	bh=EQrxc1BZyF4r574T33w/uQaFQjEGbC9c0q67r8Raty8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIFs72AIfZ23S/sjx41JekhywYOlOs0tqmlOTGsM21SyvWjje/wPX0IMW8FAmXVXrNVW1W5MIiIwtHvceOgh1NL5mZKXDM1sGBFcXQl6k5aduM8kF2sUHF1xhwmvrNQa1gVm4OQHRfQ8su7IDgqX0COg2zYyhEFhEGeswjW8y8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yy+7Mmwh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yy+7Mmwh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741690526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3aQh1m48XtZp/t5p6k08A/LCfUGkhdmMghBNlgQcBCg=;
	b=Yy+7Mmwh67e+Fu/YVUk6VSzTcTfVUIa/IMaYzJHjA0yzhPDlq/0ZjXEgpmDfAoJbUFSyNR
	u62z+oXav/Ox9sYQ8IKXwdavkJNri3WYsId4hf5kGq5lz9az4utSJD5CgijtY1PcO6ZXly
	0aTcbNaadFeoWmdQeKHEmTLR6xIR5vM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-NK1pnoxbOFOwFMU7KXEbjw-1; Tue,
 11 Mar 2025 06:55:22 -0400
X-MC-Unique: NK1pnoxbOFOwFMU7KXEbjw-1
X-Mimecast-MFC-AGG-ID: NK1pnoxbOFOwFMU7KXEbjw_1741690521
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B89F19560A1;
	Tue, 11 Mar 2025 10:55:21 +0000 (UTC)
Received: from fedora (unknown [10.72.120.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0703530001A2;
	Tue, 11 Mar 2025 10:55:17 +0000 (UTC)
Date: Tue, 11 Mar 2025 18:55:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [RESEND PATCH 4/5] loop: try to handle loop aio command via
 NOWAIT IO first
Message-ID: <Z9AWjoFLu56kQ7Ht@fedora>
References: <20250308162312.1640828-1-ming.lei@redhat.com>
 <20250308162312.1640828-5-ming.lei@redhat.com>
 <Z87JpLwpw-Fc2bkJ@infradead.org>
 <Z8-SzXD3tq7SKiiq@fedora>
 <Z8_tNiQOYeKSDt24@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8_tNiQOYeKSDt24@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Mar 11, 2025 at 12:58:46AM -0700, Christoph Hellwig wrote:
> On Tue, Mar 11, 2025 at 09:33:01AM +0800, Ming Lei wrote:
> > On Mon, Mar 10, 2025 at 12:14:44PM +0100, Christoph Hellwig wrote:
> > > On Sun, Mar 09, 2025 at 12:23:08AM +0800, Ming Lei wrote:
> > > > Try to handle loop aio command via NOWAIT IO first, then we can avoid to
> > > > queue the aio command into workqueue.
> > > > 
> > > > Fallback to workqueue in case of -EAGAIN.
> > > > 
> > > > BLK_MQ_F_BLOCKING has to be set for calling into .read_iter() or
> > > > .write_iter() which might sleep even though it is NOWAIT.
> > > 
> > > This needs performance numbers (or other reasons) justifying the
> > > change, especially as BLK_MQ_F_BLOCKING is a bit of an overhead.
> > 
> > The difference is just rcu_read_lock() vs. srcu_read_lock(), and not
> 
> Not, it also includes offloading to kblockd in more cases.

But loop doesn't run into these cases:

blk_execute_rq_nowait():
	blk_mq_run_hw_queue(hctx, hctx->flags & BLK_MQ_F_BLOCKING);

blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx)
	blk_mq_run_hw_queue(hctx, hctx->flags & BLK_MQ_F_BLOCKING);

blk_mq_start_stopped_hw_queues
	...

> 
> >
> >
> > see any difference in typical fio workload on loop device, and the gain
> > is pretty obvious, bandwidth is increased by > 4X in aio workloads:
> > 
> > https://lore.kernel.org/linux-block/f7c9d956-2b9b-8bb4-aa49-d57323fc8eb0@redhat.com/T/#md3a6154218cb6619d8af5432cf2dd3a4a7a3dcc6
> 
> Please document that in the commit log.
> 
> > > > +	if (cmd->ret == -EAGAIN) {
> > > > +		struct loop_device *lo = rq->q->queuedata;
> > > > +
> > > > +		loop_queue_work(lo, cmd);
> > > > +		return;
> > > > +	}
> > > 
> > > This looks like the wrong place for the rety, as -EAGAIN can only come from
> > > the submissions path.  i.e. we should never make it to the full completion
> > > path for that case.
> > 
> > That is not true, at least for XFS:
> 
> Your trace sees lo_rw_aio_complete called from the block layer
> splitting called from loop, I see nothing about XFS there.  But yes,
> this shows the issue discussed last week in the iomap IOCB_NOWAIT
> thread.

Looks I mis-parse the stack, but it is still returned from blkdev's ->ki_complete(),
and need to be handled.



Thanks,
Ming

