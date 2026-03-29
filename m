Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B632FD7D3
	for <linux-block@vger.kernel.org>; Sun, 29 Mar 2026 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774795479; cv=none; b=oFcfzXEPjGF3tka3vvSVCdKctakr0gpmaXx+MiklE1+9O8revb+b6s3Q3I12L7g7yG34N7BROybeRt8mbmFuj4neoGWRcsYSdsDoXjBwoj54qOFcrK6TYtiOE77ZlBrA2Vsn7jdDAMQz6hFCteEAxCOsAz4lnm9SAKLXCZ1y+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774795479; c=relaxed/simple;
	bh=tYH6G+xNvmWKg3Bd11UmwPlUy3RaQCw8rvsQox8ZKGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPopB+NlAYcagMiPjDe2BHge5UgdNOAgLpubT9lTb3BpC/qBnJeHJWSlSSqZgIHRwuXYSJ4VrAzQ6OtReJ3z0dq1NkQOKtyoP7v/2NbzjziEmNEBZcnOMjFQIcRq8F+ooy8MAC8xtZaghN+5XHpRIIRM7YvDhi+Xg2mADUuqNfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKN64cf3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKN64cf3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774795477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKQq8nVliTj15X0Mppcmsnlag5NmdtYafNWnEAL6Gl4=;
	b=SKN64cf3LvzgVHmu8MMmPnS7ZinGjm6rTYlgl5HZNGja8puwZ0qTcFmvMQPLQk9GjIdJkr
	eJ4N8JH6cHspfKAB+LI+ldA+nFWCfGfEFuhdg8qx3quS16fPSBc9I2qcjNFZoZN96DVdd7
	fpioCNgTHLHAzcwYWi4jCHixmdAXUDM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-jEKr-xmcOv24gyeQmDpSWQ-1; Sun,
 29 Mar 2026 10:44:33 -0400
X-MC-Unique: jEKr-xmcOv24gyeQmDpSWQ-1
X-Mimecast-MFC-AGG-ID: jEKr-xmcOv24gyeQmDpSWQ_1774795472
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EABEA180044D;
	Sun, 29 Mar 2026 14:44:31 +0000 (UTC)
Received: from fedora (unknown [10.72.116.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6A2D30001A1;
	Sun, 29 Mar 2026 14:44:28 +0000 (UTC)
Date: Sun, 29 Mar 2026 22:44:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk: use unchecked copy helpers for bio page data
Message-ID: <ack6x5tm2pc4hslL@fedora>
References: <20260328134258.3206825-1-ming.lei@redhat.com>
 <CADUfDZo2pbwTsp_uJcTG+GYyBFmoU-5UPYu6dvAguRfgB_QWCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZo2pbwTsp_uJcTG+GYyBFmoU-5UPYu6dvAguRfgB_QWCA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Mar 28, 2026 at 10:40:31AM -0700, Caleb Sander Mateos wrote:
> On Sat, Mar 28, 2026 at 6:43 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Bio pages may originate from slab caches that lack SLAB_USERCOPY
> 
> What is SLAB_USERCOPY? The only references to it I can find are in
> comments in commit aa981a665d587 ("lkdtm: add usercopy tests").
> 

Oops, I should have included the panic log here:

[   41.604744] usercopy: Kernel memory exposure attempt detected from SLUB object 'jbd2_1k' (offset 0, size 1024)!
[   41.607063] ------------[ cut here ]------------
[   41.607290] kernel BUG at mm/usercopy.c:102!
[   41.607502] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[   41.607794] CPU: 0 UID: 0 PID: 2020 Comm: kublk Not tainted 7.0.0-rc3_next+ #616 PREEMPT(full)
[   41.608261] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-8.fc42 06/10/2025
[   41.608722] RIP: 0010:usercopy_abort+0x7a/0x7c
[   41.608995] Code: 48 c7 c6 ab 55 2c 8b eb 0e 48 c7 c7 b0 92 2e 8b 48 c7 c6 b9 87 2b 8b 52 48 89 fa 48 c7 c7 30 73 1f 8b 50 41 52 e8 66 25 fe ff <0f> 0b 48 89 d9 49 89 e8 44 89 f2 31 f6 48 29 c1 48 c7 c7 00 56 2c
[   41.609985] RSP: 0018:ffffd3dcca79fae0 EFLAGS: 00010246
[   41.610286] RAX: 0000000000000063 RBX: ffff8d87ec655000 RCX: 0000000000000000
[   41.610707] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8d87b5c1d440
[   41.611111] RBP: 0000000000000400 R08: 0000000000000000 R09: 00000000fffeffff
[   41.611556] R10: ffffffff8bc8c040 R11: ffffd3dcca79f968 R12: ffff8d87ec655400
[   41.611913] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8d85c400b000
[   41.612375] FS:  00007f2ef3f066c0(0000) GS:ffff8d8828a82000(0000) knlGS:0000000000000000
[   41.612832] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   41.613186] CR2: 00007f2efc137000 CR3: 000000032c7f2006 CR4: 0000000000772ef0
[   41.613623] PKRU: 55555554
[   41.613811] Call Trace:
[   41.613973]  <TASK>
[   41.614108]  __check_heap_object+0xb8/0xd0
[   41.614345]  __check_object_size+0x1b8/0x250
[   41.614639]  ublk_copy_user_bvec.isra.0+0x65/0xf0 [ublk_drv]
[   41.614981]  ublk_copy_user_pages.isra.0+0xc5/0x130 [ublk_drv]
[   41.615360]  ublk_start_io+0xff/0x160 [ublk_drv]
[   41.615669]  ublk_dispatch_req+0x99/0x240 [ublk_drv]
[   41.615969]  ublk_cmd_list_tw_cb+0x2d/0x40 [ublk_drv]
[   41.616248]  __io_run_local_work_loop+0x7c/0x80
[   41.616449]  __io_run_local_work+0x159/0x230
[   41.616634]  io_run_local_work+0x31/0x50
[   41.616977]  io_cqring_wait+0x28e/0x680
[   41.617292]  ? __io_issue_sqe+0x3b/0x1b0
[   41.617607]  ? __pfx_io_wake_function+0x10/0x10
[   41.617894]  __do_sys_io_uring_enter+0x601/0x8b0
[   41.618183]  do_syscall_64+0x11c/0x15d0
[   41.618443]  ? switch_fpu_return+0x56/0xf0
[   41.618719]  ? do_syscall_64+0x2d6/0x15d0
[   41.618994]  ? do_syscall_64+0x11c/0x15d0
[   41.619262]  ? do_syscall_64+0x11c/0x15d0
[   41.619525]  ? clear_bhb_loop+0x30/0x80
[   41.619785]  ? clear_bhb_loop+0x30/0x80
[   41.620049]  ? clear_bhb_loop+0x30/0x80
[   41.620302]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   41.620598] RIP: 0033:0x7f2f045876fc
[   41.620853] Code: 0f b6 c0 48 8b 79 20 8b 3f 83 e7 01 44 0f 45 d0 41 83 ca 01 8b b9 cc 00 00 00 45 31 c0 41 b9 08 00 00 00 b8 aa 01 00 00 0f 05 <c3> 0f 1f 00 89 30 eb 9b 0f 1f 40 00 41 f6 c2 04 74 32 44 89 d0 41
[   41.621710] RSP: 002b:00007f2ef3f05c38 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
[   41.622112] RAX: ffffffffffffffda RBX: 00007f2ef3f05cc0 RCX: 00007f2f045876fc
[   41.622493] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 0000000000000000
[   41.622901] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000008
[   41.623281] R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000002
[   41.623649] R13: 0000000000000001 R14: 00007f2f0410c558 R15: 00000000000a6042
[   41.624015]  </TASK>
[   41.624239] Modules linked in: iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi target_core_pscsi target_core_file target_core_iblock iscsi_target_mod target_core_mod isofs nfsd auth_rpcgss nfs_acl lockd grace nfs_localio sunrpc vfat fat intel_rapl_msr intel_rapl_common kvm_intel kvm ppdev virtio_gpu virtio_net parport_pc parport net_failover i2c_i801 rapl i2c_smbus failover virtio_dma_buf bochs joydev vfio_pci vfio_pci_core vfio_iommu_type1 vfio irqbypass ublk_drv configs loop zram nvme uas nvme_core usb_storage virtio_scsi ghash_clmulni_intel virtio_blk nvme_keyring nvme_auth serio_raw scsi_dh_rdac scsi_dh_emc scsi_dh_alua fuse dm_multipath qemu_fw_cfg
[   41.626838] Dumping ftrace buffer:
[   41.627085]    (ftrace buffer empty)
[   41.627354] ---[ end trace 0000000000000000 ]---


Thanks,
Ming

