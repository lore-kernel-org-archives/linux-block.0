Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDD22040B6
	for <linux-block@vger.kernel.org>; Sat, 17 Jan 2026 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768648625; cv=none; b=KIk6LYliX7ceMRAV1GZPETl11nAgRbUrUxA956OqmeLlvIQPnbdWhiGJJIfgVikbwINKXyylQAZ0kHSD7JZ+SboaXoAIs8c1JkEv4EHScM7Dd1Y4siQzqTl77Zg4hW/PBlfYsBjaxJ3Kuq+5vemDRqTpvNLUuxhfOIOgGNyi3Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768648625; c=relaxed/simple;
	bh=JqAYO3YS1sIBl2Yf0AhYA5osVLZjSa9XwywoEptfwvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlS4eJUyryPzOjSKLDAp5/SOoOJ49ncHEyew3erkgi7jHM/vs/DbLkNCEJFu7xxtJmqmNkhPuOEX9BnW+L8nb0aQ9GFM7sk6keOvRsA27bn/C+xDwoHFVNbeYTgrZQAAooRZIOPn/GeBaEOXwqcwNCI3ybo7ijnrzAEk4kK6Wr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RqdvZ458; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqdvZ458"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768648623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6/KiGtA5gxoeaNwzoYsGO+4lk+MYFWP1WZBtCPpeyFA=;
	b=RqdvZ4588ptoz5TL6WiFb9kQOxI8WzJY2X4XoV2IgP22orKySHaV9KlKAilMqZRlTB8aak
	E+b/aoN+k61yzb9b8iqEesgV3AjnbohBYoXHswYLNcMG2jvZR3FwOfX0QHmjeyhsy1PNV5
	vV0VLCmCxgPevCdEQ33HnRLZoHHPEfs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-Y84OqkjGOMqchU1aI7o78Q-1; Sat,
 17 Jan 2026 06:16:59 -0500
X-MC-Unique: Y84OqkjGOMqchU1aI7o78Q-1
X-Mimecast-MFC-AGG-ID: Y84OqkjGOMqchU1aI7o78Q_1768648618
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 510B01956080;
	Sat, 17 Jan 2026 11:16:58 +0000 (UTC)
Received: from fedora (unknown [10.72.116.198])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E99CC19560A7;
	Sat, 17 Jan 2026 11:16:54 +0000 (UTC)
Date: Sat, 17 Jan 2026 19:16:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: huang-jl <huang-jl@deepseek.com>
Cc: linux-block@vger.kernel.org
Subject: Re: [BUG] ublk: ublk server hangs in D state during STOP_DEV
Message-ID: <aWtvoHe3Yt8xbmdb@fedora>
References: <aWpSHIBn_1W_Xo9h@fedora>
 <20260116171613.46312-1-huang-jl@deepseek.com>
 <aWs91n3yzPX9mZaV@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWs91n3yzPX9mZaV@fedora>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, Jan 17, 2026 at 03:44:22PM +0800, Ming Lei wrote:
> On Sat, Jan 17, 2026 at 01:16:13AM +0800, huang-jl wrote:
> > > I'd understand why ublk server is stuck in io_wq_put_and_exit() first, so
> > > far it is very likely caused by your ublk target logic...
> > 
> > I think the io-wq worker is stuck executing STOP_DEV uring cmd,
> > and not our target I/O logic causes the issue. Let me explain:
> > 
> > Looking at the iou-wrk thread (348911) stack trace, this iou-wrk is a thread
> > in my D-state ublk server, its stack is as follows:
> > 
> > $ cat /proc/348910/task/348911/stack 
> > [<0>] folio_wait_bit_common+0x136/0x330
> > [<0>] __folio_lock+0x17/0x30
> > [<0>] write_cache_pages+0x1cd/0x430
> > [<0>] blkdev_writepages+0x6f/0xb0
> > [<0>] do_writepages+0xcd/0x1f0
> > [<0>] filemap_fdatawrite_wbc+0x75/0xb0
> > [<0>] __filemap_fdatawrite_range+0x58/0x80
> > [<0>] filemap_write_and_wait_range+0x59/0xc0
> > [<0>] bdev_mark_dead+0x85/0xd0
> > [<0>] blk_report_disk_dead+0x87/0xf0
> > [<0>] del_gendisk+0x37f/0x3b0
> > [<0>] ublk_stop_dev+0x89/0x100 [ublk_drv]
> > [<0>] ublk_ctrl_uring_cmd+0x51a/0x750 [ublk_drv]
> > [<0>] io_uring_cmd+0x9f/0x140
> > [<0>] io_issue_sqe+0x193/0x410
> > [<0>] io_wq_submit_work+0xe2/0x380
> > [<0>] io_worker_handle_work+0xdf/0x340
> > [<0>] io_wq_worker+0xf9/0x350
> > [<0>] ret_from_fork+0x44/0x70
> > [<0>] ret_from_fork_asm+0x1b/0x30
> > 
> > This shows:
> > 
> > - The STOP_DEV command is being executed by an io-wq worker thread
> > - ublk_stop_dev() called del_gendisk()
> > - del_gendisk() is trying to flush dirty pages via bdev_mark_dead()
> > - The writeback is stuck waiting for a folio lock
> 
> > - Upon receiving SIGINT, our ublk server will sends UBLK_U_CMD_STOP_DEV to the
> >  driver.
> 
> Can you share how your server sends STOP_DEV when receiving SIGINT?
> 
> If it prevents normal IO command handling, ublk_stop_dev() will cause deadlock.
> 
> For example, follows the preferred IO handling in ublk server:
> 
> prepare UBLK_IO_FETCH_REQ uring_cmds;
> while (1) {
> 	io_uring_enter(submission & wait event);
> }
> 
> If you send STOP_DEV command inside the above loop, you will get the
> deadlock, because inflight and new IOs can't be handled any more.

If that is the case, you may remove the sending of STOP_DEV simply in your
implementation, and let ublk server exit. Then delete the ublk device before
ublk server is exiting to kernel, or let your monitor process remove the
ublk device, which becomes DEAD state after ublk server exits.

Otherwise, you may have to investigate why ublk server can't handle IO
command after sending STOP_DEV command.

STOP_DEV and DEL_DEV command may need to be documented for ublk server to
avoid deadlock.

Thanks,
Ming

