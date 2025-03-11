Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0FF2AD04
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741656799; cv=none; b=Mq1hkk/OrP0DRYeTUiGk/wbCgtwI3nLIwX3TGT9dUA8H+C3TS8ReUU2GRPJ1w7dxZg/Osl8zwm66E/WPDpXu//50Qv0h7bNgv496U6xbzakw9JIQLrh+BXUhkceYsrjrvzaFjkvmsUSQU5xCuiXpYk801vPdnt5aVTHi9jZa3ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741656799; c=relaxed/simple;
	bh=S/x95t1V/xmAIplp7zoK+vQYyevJPiUDsTneaQDNai4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yyeet553Pi3a6gMvHMkbSL6WPPIByOTYMuKWajovYnKUwwj4Q6L50Gbd/YNNlsCgK6+sVQVxezedeWAeUIbIuWZ53bWBZEj61Rth0YqjbbEDMj6M6iswy06CIt07BI6kxAS9qsIPE81K+CatA7Gh+HSmBH3hb1xxcpLz13hV+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNMXP9py; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNMXP9py"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741656795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A1yz98/AdOLHLVzt4V9VN/QrTKETQev7yKHc9VKhz5o=;
	b=YNMXP9pycbcTKmtUyHItUTH4ew4j1fVpiML4o5WMlOnh91hKMMPDANuXkhE36RIWQ1xhaA
	N8i2CXf4UOZjoUBaOOo0nUYJ5zXs8Ji1eaBFw2EQ//K50B2e10o08rWgg4sBfcN8qUYYhG
	DkJP3UNVd5TiSGyYhhod3JRfHZ2tipg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-vxXElG8pOcSwXn17beAW0g-1; Mon,
 10 Mar 2025 21:33:12 -0400
X-MC-Unique: vxXElG8pOcSwXn17beAW0g-1
X-Mimecast-MFC-AGG-ID: vxXElG8pOcSwXn17beAW0g_1741656791
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E01051801A1A;
	Tue, 11 Mar 2025 01:33:10 +0000 (UTC)
Received: from fedora (unknown [10.72.120.11])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF3671944F12;
	Tue, 11 Mar 2025 01:33:07 +0000 (UTC)
Date: Tue, 11 Mar 2025 09:33:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [RESEND PATCH 4/5] loop: try to handle loop aio command via
 NOWAIT IO first
Message-ID: <Z8-SzXD3tq7SKiiq@fedora>
References: <20250308162312.1640828-1-ming.lei@redhat.com>
 <20250308162312.1640828-5-ming.lei@redhat.com>
 <Z87JpLwpw-Fc2bkJ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z87JpLwpw-Fc2bkJ@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Mar 10, 2025 at 12:14:44PM +0100, Christoph Hellwig wrote:
> On Sun, Mar 09, 2025 at 12:23:08AM +0800, Ming Lei wrote:
> > Try to handle loop aio command via NOWAIT IO first, then we can avoid to
> > queue the aio command into workqueue.
> > 
> > Fallback to workqueue in case of -EAGAIN.
> > 
> > BLK_MQ_F_BLOCKING has to be set for calling into .read_iter() or
> > .write_iter() which might sleep even though it is NOWAIT.
> 
> This needs performance numbers (or other reasons) justifying the
> change, especially as BLK_MQ_F_BLOCKING is a bit of an overhead.

The difference is just rcu_read_lock() vs. srcu_read_lock(), and not
see any difference in typical fio workload on loop device, and the gain
is pretty obvious, bandwidth is increased by > 4X in aio workloads:

https://lore.kernel.org/linux-block/f7c9d956-2b9b-8bb4-aa49-d57323fc8eb0@redhat.com/T/#md3a6154218cb6619d8af5432cf2dd3a4a7a3dcc6

> 
> >  static DEFINE_IDR(loop_index_idr);
> >  static DEFINE_MUTEX(loop_ctl_mutex);
> >  static DEFINE_MUTEX(loop_validate_mutex);
> > @@ -380,8 +382,17 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
> >  
> >  	if (!atomic_dec_and_test(&cmd->ref))
> >  		return;
> > +
> > +	if (cmd->ret == -EAGAIN) {
> > +		struct loop_device *lo = rq->q->queuedata;
> > +
> > +		loop_queue_work(lo, cmd);
> > +		return;
> > +	}
> 
> This looks like the wrong place for the rety, as -EAGAIN can only come from
> the submissions path.  i.e. we should never make it to the full completion
> path for that case.

That is not true, at least for XFS:

[root@ktest-40 io]# bpftrace -e 'kretfunc:lo_rw_aio_complete /args->ret == -11/ { @eagain[kstack] = count() } '
Attaching 1 probe...
^C

@eagain[
    bpf_prog_6deef7357e7b4530_sd_fw_ingress+28250
    bpf_prog_6deef7357e7b4530_sd_fw_ingress+28250
    bpf_trampoline_367219848433+108
    lo_rw_aio_complete+9
    blkdev_bio_end_io_async+63
    bio_submit_split+347
    blk_mq_submit_bio+395
    __submit_bio+116
    submit_bio_noacct_nocheck+773
    submit_bio_wait+87
    xfs_rw_bdev+348
    xlog_do_io+131
    xlog_write_log_records+451
    xlog_find_tail+829
    xlog_recover+61
    xfs_log_mount+259
    xfs_mountfs+1232
    xfs_fs_fill_super+1507
    get_tree_bdev_flags+303
    vfs_get_tree+38
    vfs_cmd_create+89
    __do_sys_fsconfig+1286
    do_syscall_64+130
    entry_SYSCALL_64_after_hwframe+118
]: 2


> 
> >  static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd, loff_t pos)
> > +{
> > +	unsigned int nr_bvec = lo_cmd_nr_bvec(cmd);
> > +	int ret;
> > +
> > +	cmd->iocb.ki_flags &= ~IOCB_NOWAIT;
> > +	ret = lo_submit_rw_aio(lo, cmd, pos, nr_bvec);
> > +	if (ret != -EIOCBQUEUED)
> > +		lo_rw_aio_complete(&cmd->iocb, ret);
> > +	return 0;
> 
> This needs an explanation that it is for the fallback path and thus
> clears the nowait flag.

OK.

> 
> > +}
> > +
> > +static int lo_rw_aio_nowait(struct loop_device *lo, struct loop_cmd *cmd, loff_t pos)
> 
> Overly long line.
> 
> > @@ -1926,6 +1955,17 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
> >  		break;
> >  	}
> >  
> > +	if (cmd->use_aio) {
> > +		loff_t pos = ((loff_t) blk_rq_pos(rq) << 9) + lo->lo_offset;
> > +		int ret = lo_rw_aio_nowait(lo, cmd, pos);
> > +
> > +		if (!ret)
> > +			return BLK_STS_OK;
> > +		if (ret != -EAGAIN)
> > +			return BLK_STS_IOERR;
> > +		/* fallback to workqueue for handling aio */
> > +	}
> 
> Why isn't all the logic in this branch in lo_rw_aio_nowait?

Good catch, I just found we have BLK_STS_AGAIN.


Thanks,
Ming

