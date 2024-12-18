Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C2D487A5
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 02:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734489392; cv=none; b=VRDdjEqxx5RCaGtGM0P7KxpdnKf5cDHly2TxJQe/dROEehuEmhsQfkWO6iBUk74GMGK7LaxNdkr8EUp99A0hwwbX3glAuNIqcQD8onrc7Pk6iLRHHZsRB3q3zztyeAo6h4qV8hG0w+KwpgG69aNwjMaj1bYeRqcWwGtv+OXknOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734489392; c=relaxed/simple;
	bh=hsdsyqKmhofb811PsgzKXzLjBJs7OHf4kS0LRTy7jPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXWjo+hCgr93s+r8a7nXa02LsvZRAi1mV0EwU7983Bz9MufuhLtBRGnFSCF91aKla3L4bVJKJ8cx/96xRWJeLClChrhSV0yB6T6CO1akRyTjCcjvOew2p0piuLOwu8Ndm71llxx8RgYEd0/PCOtRvgnKeNa3mEEnFR2MUAd2hCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdqdOcHv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdqdOcHv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734489389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NJcW79ovDm+qtYUxO5FhhfDWiJMRuMDIYWMjjeUpx5o=;
	b=ZdqdOcHv5pdwJOoK+Qh5mfObs8V/yJCflB/rd3ho2e5DEdr0+qrtZn89V2Uflu0f/7KaEK
	Nc1AsK2v5WBYzA9oKdssNzm019eabz7Et9xOjF1eiKJLD5npcO1c3gWthnKy0EgN8e1xTO
	ubJ65bBcq2P8P4EvlyleNCmsAPz7KcA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-qe6AfCQ_MPaEG5lhsHeh_A-1; Tue,
 17 Dec 2024 21:36:24 -0500
X-MC-Unique: qe6AfCQ_MPaEG5lhsHeh_A-1
X-Mimecast-MFC-AGG-ID: qe6AfCQ_MPaEG5lhsHeh_A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25A3719560B2;
	Wed, 18 Dec 2024 02:36:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.33])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C45419560AD;
	Wed, 18 Dec 2024 02:36:17 +0000 (UTC)
Date: Wed, 18 Dec 2024 10:36:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: 6.13/regression/bisected - after commit f1be1788a32e I see in
 the kernel log "possible circular locking dependency detected"
Message-ID: <Z2I1HAKhKrCR51XO@fedora>
References: <CABXGCsMS-em+jU0M9TnoVwViUfDudv4juN9yccsh-p+kuAneBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsMS-em+jU0M9TnoVwViUfDudv4juN9yccsh-p+kuAneBw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Dec 18, 2024 at 06:51:31AM +0500, Mikhail Gavrilov wrote:
> Hi,
> After commit f1be1788a32e I see in the kernel log "possible circular
> locking dependency detected" with follow stack trace:
> [  740.877178] ======================================================
> [  740.877180] WARNING: possible circular locking dependency detected
> [  740.877182] 6.13.0-rc3-f44d154d6e3d+ #392 Tainted: G        W    L
> [  740.877184] ------------------------------------------------------
> [  740.877186] btrfs-transacti/839 is trying to acquire lock:
> [  740.877188] ffff888182336a50
> (&q->q_usage_counter(io)#2){++++}-{0:0}, at: __submit_bio+0x335/0x520
> [  740.877197]
>                but task is already holding lock:
> [  740.877198] ffff8881826f7048 (btrfs-tree-00){++++}-{4:4}, at:
> btrfs_tree_read_lock_nested+0x27/0x170
> [  740.877205]
>                which lock already depends on the new lock.
> 
> [  740.877206]
>                the existing dependency chain (in reverse order) is:
> [  740.877207]
>                -> #4 (btrfs-tree-00){++++}-{4:4}:
> [  740.877211]        lock_release+0x397/0xd90
> [  740.877215]        up_read+0x1b/0x30
> [  740.877217]        btrfs_search_slot+0x16c9/0x31f0
> [  740.877220]        btrfs_lookup_inode+0xa9/0x360
> [  740.877222]        __btrfs_update_delayed_inode+0x131/0x760
> [  740.877225]        btrfs_async_run_delayed_root+0x4bc/0x630
> [  740.877226]        btrfs_work_helper+0x1b5/0xa50
> [  740.877228]        process_one_work+0x899/0x14b0
> [  740.877231]        worker_thread+0x5e6/0xfc0
> [  740.877233]        kthread+0x2d2/0x3a0
> [  740.877235]        ret_from_fork+0x31/0x70
> [  740.877238]        ret_from_fork_asm+0x1a/0x30
> [  740.877240]
>                -> #3 (&delayed_node->mutex){+.+.}-{4:4}:
> [  740.877244]        __mutex_lock+0x1ab/0x12c0
> [  740.877247]        __btrfs_release_delayed_node.part.0+0xa0/0xd40
> [  740.877249]        btrfs_evict_inode+0x44d/0xc20
> [  740.877252]        evict+0x3a4/0x840
> [  740.877255]        dispose_list+0xf0/0x1c0
> [  740.877257]        prune_icache_sb+0xe3/0x160
> [  740.877259]        super_cache_scan+0x30d/0x4f0
> [  740.877261]        do_shrink_slab+0x349/0xd60
> [  740.877264]        shrink_slab+0x7a4/0xd20
> [  740.877266]        shrink_one+0x403/0x830
> [  740.877268]        shrink_node+0x2337/0x3a60
> [  740.877270]        balance_pgdat+0xa4f/0x1500
> [  740.877272]        kswapd+0x4f3/0x940
> [  740.877274]        kthread+0x2d2/0x3a0
> [  740.877276]        ret_from_fork+0x31/0x70
> [  740.877278]        ret_from_fork_asm+0x1a/0x30
> [  740.877280]
>                -> #2 (fs_reclaim){+.+.}-{0:0}:
> [  740.877283]        fs_reclaim_acquire+0xc9/0x110
> [  740.877286]        __kmalloc_noprof+0xeb/0x690
> [  740.877288]        sd_revalidate_disk.isra.0+0x4356/0x8e00
> [  740.877291]        sd_probe+0x869/0xfa0
> [  740.877293]        really_probe+0x1e0/0x8a0
> [  740.877295]        __driver_probe_device+0x18c/0x370
> [  740.877297]        driver_probe_device+0x4a/0x120
> [  740.877299]        __device_attach_driver+0x162/0x270
> [  740.877300]        bus_for_each_drv+0x115/0x1a0
> [  740.877303]        __device_attach_async_helper+0x1a0/0x240
> [  740.877305]        async_run_entry_fn+0x97/0x4f0
> [  740.877307]        process_one_work+0x899/0x14b0
> [  740.877309]        worker_thread+0x5e6/0xfc0
> [  740.877310]        kthread+0x2d2/0x3a0
> [  740.877312]        ret_from_fork+0x31/0x70
> [  740.877314]        ret_from_fork_asm+0x1a/0x30
> [  740.877316]
>                -> #1 (&q->limits_lock){+.+.}-{4:4}:
> [  740.877320]        __mutex_lock+0x1ab/0x12c0
> [  740.877321]        nvme_update_ns_info_block+0x476/0x2630 [nvme_core]
> [  740.877332]        nvme_update_ns_info+0xbe/0xa60 [nvme_core]
> [  740.877339]        nvme_alloc_ns+0x1589/0x2c40 [nvme_core]
> [  740.877346]        nvme_scan_ns+0x579/0x660 [nvme_core]
> [  740.877353]        async_run_entry_fn+0x97/0x4f0
> [  740.877355]        process_one_work+0x899/0x14b0
> [  740.877357]        worker_thread+0x5e6/0xfc0
> [  740.877358]        kthread+0x2d2/0x3a0
> [  740.877360]        ret_from_fork+0x31/0x70
> [  740.877362]        ret_from_fork_asm+0x1a/0x30
> [  740.877364]
>                -> #0 (&q->q_usage_counter(io)#2){++++}-{0:0}:


This is another deadlock caused by dependency between q->limits_lock and
q->q_usage_counter, same with the one under discussion:

https://lore.kernel.org/linux-block/20241216080206.2850773-2-ming.lei@redhat.com/

The dependency of queue_limits_start_update() over blk_mq_freeze_queue()
should be cut.


Thanks,
Ming

