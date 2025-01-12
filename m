Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BE11B87E9
	for <linux-block@vger.kernel.org>; Sun, 12 Jan 2025 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736697056; cv=none; b=LFYlIHc1waZQB2K25n+HkTV38iAp6bg62kNO6mY8MaLpR/A3FJqLaXYvsnAvdxrbPKVu/k7EvQ12BXadl6hmVsuZ7ui43it/mt+SL1v8jR13F8HDDMR3/H4/cShe4EroSWTLbFM5i8HAI9u174ljUX7KCJ3jBwToXkA4ub12fRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736697056; c=relaxed/simple;
	bh=qgoLwzzSRRCp6jrdi1AOdsPU1R7RZjj5IECppZ/ORY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFJRu6YwNw7fM1g653zFikV6EWYyHrwAVD51LP5GI9xt3MjtutZNjvwAievjdegLZyh/Y0cQK1M6QBbRkJIp2JR+4Plo8XTcuQpRANEG+u/mX8gj5s07DwnkKwG9Aoirtiu7/VmaE8tntVZv/35ud5Yu+25FWbSKXu11T4mMl9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJkVJgwT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJkVJgwT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736697053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWwCLZeNMQhmNouULVj53EnShTT8r3qGH7RFzGxXHXc=;
	b=OJkVJgwTCH8vv8J730JKVuk6YKFcqB+IuzRi0MBXyTTCAQW0LXLPCgeR8PXFqIimITBpsp
	jvb2w5n44L/coYlZiJ+7EdLx/Br9fBttfnjBytQsZvQtnFwKNPA9LspeYt6dZTUZXiF5e9
	4DSPCcaMql+3AxkLyE7Ld2S77z/Vun4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-ffscstWRPWOFAgYhcGZwvA-1; Sun,
 12 Jan 2025 10:50:50 -0500
X-MC-Unique: ffscstWRPWOFAgYhcGZwvA-1
X-Mimecast-MFC-AGG-ID: ffscstWRPWOFAgYhcGZwvA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F7DE195608A;
	Sun, 12 Jan 2025 15:50:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A1191956056;
	Sun, 12 Jan 2025 15:50:43 +0000 (UTC)
Date: Sun, 12 Jan 2025 23:50:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org
Subject: Re: Blockdev 6.13-rc lockdep splat regressions
Message-ID: <Z4PkzbFVrSJWOrE4@fedora>
References: <65a8ef7321bf905ab27c383395016fe299f6dfd9.camel@linux.intel.com>
 <Z4EO6YMM__e6nLNr@fedora>
 <7017f6bf8df5bbd8824f9f69e627c3f33b9aa7cd.camel@linux.intel.com>
 <Z4HgDJjMRv4s5phx@fedora>
 <ead7c5ce5138912c1f3179d62370b84a64014a38.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ead7c5ce5138912c1f3179d62370b84a64014a38.camel@linux.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sun, Jan 12, 2025 at 12:33:13PM +0100, Thomas Hellström wrote:
> On Sat, 2025-01-11 at 11:05 +0800, Ming Lei wrote:

...

> 
> Ah, You're right, it's a different warning this time. Posted the
> warning below. (Note: This is also with Christoph's series applied on
> top).
> 
> May I also humbly suggest the following lockdep priming to be able to
> catch the reclaim lockdep splats early without reclaim needing to
> happen. That will also pick up splat #2 below.
> 
> 8<-------------------------------------------------------------
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 32fb28a6372c..2dd8dc9aed7f 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -458,6 +458,11 @@ struct request_queue *blk_alloc_queue(struct
> queue_limits *lim, int node_id)
>  
>         q->nr_requests = BLKDEV_DEFAULT_RQ;
>  
> +       fs_reclaim_acquire(GFP_KERNEL);
> +       rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
> +       rwsem_release(&q->io_lockdep_map, _RET_IP_);
> +       fs_reclaim_release(GFP_KERNEL);
> +
>         return q;

Looks one nice idea for injecting fs_reclaim, maybe it can be
added to inject framework?

>  
>  fail_stats:
> 
> 8<-------------------------------------------------------------
> 
> #1:
>   106.921533] ======================================================
> [  106.921716] WARNING: possible circular locking dependency detected
> [  106.921725] 6.13.0-rc6+ #121 Tainted: G     U            
> [  106.921734] ------------------------------------------------------
> [  106.921743] kswapd0/117 is trying to acquire lock:
> [  106.921751] ffff8ff4e2da09f0 (&q->q_usage_counter(io)){++++}-{0:0},
> at: __submit_bio+0x80/0x220
> [  106.921769] 
>                but task is already holding lock:
> [  106.921778] ffffffff8e65e1c0 (fs_reclaim){+.+.}-{0:0}, at:
> balance_pgdat+0xe2/0xa10
> [  106.921791] 
>                which lock already depends on the new lock.
> 
> [  106.921803] 
>                the existing dependency chain (in reverse order) is:
> [  106.921814] 
>                -> #1 (fs_reclaim){+.+.}-{0:0}:
> [  106.921824]        fs_reclaim_acquire+0x9d/0xd0
> [  106.921833]        __kmalloc_cache_node_noprof+0x5d/0x3f0
> [  106.921842]        blk_mq_init_tags+0x3d/0xb0
> [  106.921851]        blk_mq_alloc_map_and_rqs+0x4e/0x3d0
> [  106.921860]        blk_mq_init_sched+0x100/0x260
> [  106.921868]        elevator_switch+0x8d/0x2e0
> [  106.921877]        elv_iosched_store+0x174/0x1e0
> [  106.921885]        queue_attr_store+0x142/0x180
> [  106.921893]        kernfs_fop_write_iter+0x168/0x240
> [  106.921902]        vfs_write+0x2b2/0x540
> [  106.921910]        ksys_write+0x72/0xf0
> [  106.921916]        do_syscall_64+0x95/0x180
> [  106.921925]        entry_SYSCALL_64_after_hwframe+0x76/0x7e

That is another regression from commit

	af2814149883 block: freeze the queue in queue_attr_store

and queue_wb_lat_store() has same risk too.

I will cook a patch to fix it.

Thanks,
Ming

