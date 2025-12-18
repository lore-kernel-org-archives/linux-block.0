Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676B1A01C6
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766056848; cv=none; b=fNbCaDOg5kKKpm4OzniJ1R1Ifo3K0mX9o74Mgw3umFkMnXeU0u/VLd7ZZNLzl6vA+taZ3+0CkDYR0c6/6D7MySMvtTt6BDu1Epy+MpAvxwHA7pwRgJTWpvDIwbe99daaWkfdlUI6HhRaMI8KNvAXI8ZavziCJG4uOz3vO9514jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766056848; c=relaxed/simple;
	bh=QvNNa9p6yMyVlqZPc3LVT96QtZq8cr71jeQOMECQThw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enY68xy70BlD537a4evXLUhe6jLVEsyPFWaTOOwaL9B9NxJjP7FvX36+iNaCB8x/rSptPNoF+A8Cx4aY2EaP2s28RDCv6jBcOmXaiND9dUD8V+wk7iyZNUS2v6kihkZKSU/HF2l/rP/tMAcb4MMU97F46SKPNlWIvUl8gsAm6hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVJu8+to; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVJu8+to"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766056845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8NAu0C3K8zUI4IJW/jsc/bg7Q0IBaiaz2wGpIwBEFbw=;
	b=dVJu8+toiw+xJShtxeGGvB6BEsRADp/VcastrEGBTevfee4+hH93QDqhmI391aqejNSnuT
	NR3fdM23RxP0D5y+AskEozvgAWiNELrv5xKRAa38Z0VBm+8kTMMtdHGRkiocqAA5bdOXxB
	1mwL+WhGxgKuW0znPwg0Uki17+WIZKw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-8SKfL6GvMn6QvqHba2jBSg-1; Thu,
 18 Dec 2025 06:20:42 -0500
X-MC-Unique: 8SKfL6GvMn6QvqHba2jBSg-1
X-Mimecast-MFC-AGG-ID: 8SKfL6GvMn6QvqHba2jBSg_1766056841
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56C04195DE48;
	Thu, 18 Dec 2025 11:20:41 +0000 (UTC)
Received: from fedora (unknown [10.72.116.190])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62C97180044F;
	Thu, 18 Dec 2025 11:20:34 +0000 (UTC)
Date: Thu, 18 Dec 2025 19:20:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jared Holzman <jholzman@nvidia.com>,
	Guy Eisenberg <geisenberg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	Ofer Oshri <ofer@nvidia.com>
Subject: Re: ublk: partition scan during START_DEV can block userspace
Message-ID: <aUPjeWYBGLb-GzzI@fedora>
References: <DM4PR12MB63280C5637917C071C2F0D65A9A8A@DM4PR12MB6328.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB63280C5637917C071C2F0D65A9A8A@DM4PR12MB6328.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Dec 18, 2025 at 10:11:18AM +0000, Yoav Cohen wrote:
> Hi,
> 
> Background:
> We expose a network-managed block device using ublk.
> 
> When issuing START_DEV, the kernel automatically attempts to scan the disk
> partitions. This results in synchronous reads from the device, as shown in the
> stack trace below:
> 
> [<0>] folio_wait_bit_common+0x138/0x310
> [<0>] filemap_read_folio+0x94/0xe0
> [<0>] do_read_cache_folio+0x80/0x1c0
> [<0>] read_cache_folio+0x12/0x30
> [<0>] read_part_sector+0x39/0xe0
> [<0>] read_lba+0x91/0x110
> [<0>] find_valid_gpt.constprop.0+0xe5/0x5d0
> [<0>] efi_partition+0x5b/0x360
> [<0>] check_partition+0x166/0x3c0
> [<0>] blk_add_partitions+0x3e/0x280
> [<0>] bdev_disk_changed+0x149/0x1c0
> [<0>] blkdev_get_whole+0x8c/0xb0
> [<0>] bdev_open+0x2ea/0x3c0
> [<0>] bdev_file_open_by_dev+0xde/0x140
> [<0>] disk_scan_partitions+0x68/0x130
> [<0>] add_disk_fwnode+0x46c/0x490
> [<0>] device_add_disk+0x10/0x20
> [<0>] ublk_ctrl_start_dev.isra.0+0x29d/0x3a0 [ublk_drv]
> [<0>] ublk_ctrl_uring_cmd+0x407/0x600 [ublk_drv]
> [<0>] io_uring_cmd+0xa4/0x150
> 
> Problems observed
> 
> Userspace crash can leave the process stuck
> 
> If the ublk userspace server crashes while this partition-scan I/O is in
> progress, the process may fail to terminate cleanly. For example:
> 
> yoav@nvme195:~$ sudo cat /proc/3083/stack
> [<0>] do_exit+0xd7/0xa50
> [<0>] do_group_exit+0x34/0x90
> [<0>] get_signal+0x928/0x950
> [<0>] arch_do_signal_or_restart+0x41/0x260
> [<0>] irqentry_exit_to_user_mode+0x13b/0x1d0
> [<0>] irqentry_exit+0x43/0x50
> [<0>] sysvec_reschedule_ipi+0x65/0x110
> [<0>] asm_sysvec_reschedule_ipi+0x1b/0x20
> 
> At this point, the server is no longer able to serve I/O, yet the kernel is
> still waiting for completion of the partition-scan reads, preventing proper
> shutdown and recovery.
> 
> Restart requires serving partition scan I/O
> 
> Even without a crash, restarting the userspace application requires handling
> these implicit partition-scan requests. This is undesirable for our use case,
> as the device contents are managed remotely and partition probing is not always
> meaningful or wanted.
> 
> No way to suppress partition scanning in ublk
> 
> We considered introducing an option to set GD_SUPPRESS_PART_SCAN at device
> startup, and possibly triggering partition scanning later from userspace when
> appropriate. However, it is not clear whether this is the correct approach, nor
> from which context such a rescan should safely be initiated.
> 
> Questions / discussion points
> 
> Is there an existing, recommended way for ublk devices to suppress automatic
> partition scanning at START_DEV time?

No, there isn't.

> 
> Would it make sense to add a ublk-specific option to control
> GD_SUPPRESS_PART_SCAN, similar to how some other drivers handle this?

Yes, I think it is reasonable to add this feature flag via `ublksrv_ctrl_dev_info`,
and it should be very useful & flexible for user to scan partitions by
themselves.

> 
> Are there alternative approaches to avoid blocking behavior during device
> startup without requiring kernel changes?

It should be triggered in case of UBLK_F_USER_RECOVERY only.

add_disk() is run with ub->mutex grabbed, so the following UBLK_U_CMD_DEL_DEV or
STOP_DEV command hangs forever on the ub->mutex.

I will think about how to fix this issue. Probably the lock needs to be
released when calling add_disk().


Thanks,
Ming

