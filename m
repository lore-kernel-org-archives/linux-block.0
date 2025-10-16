Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7324A2367CF
	for <linux-block@vger.kernel.org>; Thu, 16 Oct 2025 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612557; cv=none; b=qBR0Dj+dR/Oq63Lce6BtgB1WeAGJG4+xj+tw9Q4rM7jFIbOIdXzLoTZLx37357sIP1B93t49kBXOBgCowp1czy7mcU17612nODSzH3Vi7jhRCWkBon+q3gIgi9Jwpk0tQTgWNTjCLWddVffGV7Frs97ENysssz8MdgFEyhGLLQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612557; c=relaxed/simple;
	bh=QfApUCjeA54oY/UI0rlOTppWTpEejp4a9h6j6gyUFlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coKiox3jL323sVp6aF8WwNWt1RUm0JPTslS8NPp0c7A1jq9MCVGIquf5xWSgSBv0VjOkm0EQSZQDDJA66YjI1QnRYvTcvC+DR7xG8ae9k4C0EgddeeeG8WgTuzqydHIpI7ArEKwzwmz1NP7+PcmmgKAVyKddHEXiq0BbS01hvxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAWylTVf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAWylTVf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760612553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EV67XLAliAWteGnv6LeupYn1YMdBJhusGkJrVtgTyoY=;
	b=eAWylTVfVJg0q6AgnS47DxKr9W2rjt305FRsXY8Gmh8gSxKDDH1hLKhA+gmmEs4QQVMl4A
	5URfh1a7ycIVaDGDTAI7PFCV3taAkfDfQNaxpUhDA149FJeXwYCoElTK8a0+tbsFlWQCAA
	kkt5SLekA4Te4RVo7MtvDlNDLsLU3B8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-i6akanTxO56IkvV9FiVnTA-1; Thu,
 16 Oct 2025 07:02:30 -0400
X-MC-Unique: i6akanTxO56IkvV9FiVnTA-1
X-Mimecast-MFC-AGG-ID: i6akanTxO56IkvV9FiVnTA_1760612549
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71F9D1956095;
	Thu, 16 Oct 2025 11:02:28 +0000 (UTC)
Received: from fedora (unknown [10.72.120.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 825CE19560AD;
	Thu, 16 Oct 2025 11:02:22 +0000 (UTC)
Date: Thu, 16 Oct 2025 19:02:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, nbd@other.debian.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2] nbd: override creds to kernel when calling
 sock_{send,recv}msg()
Message-ID: <aPDQuZzIHHzYq7vt@fedora>
References: <20251010080900.1680512-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010080900.1680512-1-omosnace@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Oct 10, 2025 at 10:09:00AM +0200, Ondrej Mosnacek wrote:
> sock_{send,recv}msg() internally calls security_socket_{send,recv}msg(),
> which does security checks (e.g. SELinux) for socket access against the
> current task. However, _sock_xmit() in drivers/block/nbd.c may be called
> indirectly from a userspace syscall, where the NBD socket access would
> be incorrectly checked against the calling userspace task (which simply
> tries to read/write a file that happens to reside on an NBD device).
> 
> To fix this, temporarily override creds to kernel ones before calling
> the sock_*() functions. This allows the security modules to recognize
> this as internal access by the kernel, which will normally be allowed.
> 
> A way to trigger the issue is to do the following (on a system with
> SELinux set to enforcing):
> 
>     ### Create nbd device:
>     truncate -s 256M /tmp/testfile
>     nbd-server localhost:10809 /tmp/testfile
> 
>     ### Connect to the nbd server:
>     nbd-client localhost
> 
>     ### Create mdraid array
>     mdadm --create -l 1 -n 2 /dev/md/testarray /dev/nbd0 missing
> 
> After these steps, assuming the SELinux policy doesn't allow the
> unexpected access pattern, errors will be visible on the kernel console:
> 
> [  142.204243] nbd0: detected capacity change from 0 to 524288
> [  165.189967] md: async del_gendisk mode will be removed in future, please upgrade to mdadm-4.5+
> [  165.252299] md/raid1:md127: active with 1 out of 2 mirrors
> [  165.252725] md127: detected capacity change from 0 to 522240
> [  165.255434] block nbd0: Send control failed (result -13)
> [  165.255718] block nbd0: Request send failed, requeueing
> [  165.256006] block nbd0: Dead connection, failed to find a fallback
> [  165.256041] block nbd0: Receive control failed (result -32)
> [  165.256423] block nbd0: shutting down sockets
> [  165.257196] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
> [  165.257736] Buffer I/O error on dev md127, logical block 0, async page read
> [  165.258263] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
> [  165.259376] Buffer I/O error on dev md127, logical block 0, async page read
> [  165.259920] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
> [  165.260628] Buffer I/O error on dev md127, logical block 0, async page read
> [  165.261661] ldm_validate_partition_table(): Disk read failed.
> [  165.262108] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
> [  165.262769] Buffer I/O error on dev md127, logical block 0, async page read
> [  165.263697] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
> [  165.264412] Buffer I/O error on dev md127, logical block 0, async page read
> [  165.265412] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
> [  165.265872] Buffer I/O error on dev md127, logical block 0, async page read
> [  165.266378] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
> [  165.267168] Buffer I/O error on dev md127, logical block 0, async page read
> [  165.267564]  md127: unable to read partition table
> [  165.269581] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
> [  165.269960] Buffer I/O error on dev nbd0, logical block 0, async page read
> [  165.270316] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
> [  165.270913] Buffer I/O error on dev nbd0, logical block 0, async page read
> [  165.271253] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
> [  165.271809] Buffer I/O error on dev nbd0, logical block 0, async page read
> [  165.272074] ldm_validate_partition_table(): Disk read failed.
> [  165.272360]  nbd0: unable to read partition table
> [  165.289004] ldm_validate_partition_table(): Disk read failed.
> [  165.289614]  nbd0: unable to read partition table
> 
> The corresponding SELinux denial on Fedora/RHEL will look like this
> (assuming it's not silenced):
> type=AVC msg=audit(1758104872.510:116): avc:  denied  { write } for  pid=1908 comm="mdadm" laddr=::1 lport=32772 faddr=::1 fport=10809 scontext=system_u:system_r:mdadm_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=tcp_socket permissive=0
> 
> The respective backtrace looks like this:
> @security[mdadm, -13,
>         handshake_exit+221615650
>         handshake_exit+221615650
>         handshake_exit+221616465
>         security_socket_sendmsg+5
>         sock_sendmsg+106
>         handshake_exit+221616150
>         sock_sendmsg+5
>         __sock_xmit+162
>         nbd_send_cmd+597
>         nbd_handle_cmd+377
>         nbd_queue_rq+63
>         blk_mq_dispatch_rq_list+653
>         __blk_mq_do_dispatch_sched+184
>         __blk_mq_sched_dispatch_requests+333
>         blk_mq_sched_dispatch_requests+38
>         blk_mq_run_hw_queue+239
>         blk_mq_dispatch_plug_list+382
>         blk_mq_flush_plug_list.part.0+55
>         __blk_flush_plug+241
>         __submit_bio+353
>         submit_bio_noacct_nocheck+364
>         submit_bio_wait+84
>         __blkdev_direct_IO_simple+232
>         blkdev_read_iter+162
>         vfs_read+591
>         ksys_read+95
>         do_syscall_64+92
>         entry_SYSCALL_64_after_hwframe+120
> ]: 1
> 
> The issue has started to appear since commit 060406c61c7c ("block: add
> plug while submitting IO").
> 
> Cc: Ming Lei <ming.lei@redhat.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2348878
> Fixes: 060406c61c7c ("block: add plug while submitting IO")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
> 
> Changes in v2:
>  * Move put_cred() after destroy_workqueue() in nbd_cleanup() to avoid a UAF
>  * Add some more details into the commit message
>  * Add a Fixes: tag

Hello Jens,

Any chance to pull this patch into v6.18 if you are fine?


Thanks,
Ming

