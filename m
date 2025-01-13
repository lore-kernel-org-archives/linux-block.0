Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69C240259
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781140; cv=none; b=LaT8V0j3eWWffEyBpG2iz7ROnMmQ8h969ewjrRKsMXPo1u4kgvre1NJdv40h1LQX7zvArrxiCcNpa+q7tepMCxKpeEGCKsC0suQlgiYsQKMPeIdL7D1BszXiRcGMTX8PRoKl/P1RSb55/ljufFnw5Ef/3wTEzSJk2qglP6msBcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781140; c=relaxed/simple;
	bh=HjvUhQup3Kh1V1OT5Kid7Hl8jJhiJpfyWRPT+cmBBEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E03O7x8xjIsN7luvluOXNnm44Nq34e1jYDfZZwFcE1V2r4ttp1RY78G66H7KQb0iAGhB7NDRqKEGaaCF+oop1QlRu8DWyb65fmsegCgEjzGmRbtccFYeJ+Sh1NzgllfHBSh0DbqNruzzMslo2k3I+jrYcaJmaMxdgzeKfr46RPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EtmziSm5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtmziSm5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736781137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GzIowc1RemQBHD6lL2GvYSXQssD7sVWZSxbP9qaZSCc=;
	b=EtmziSm5oJSfOZKiNTbR4wFWrmtYgpYtCc4wbusCzMpNK9qrtuIAji1XFegjj6gbbvtmRb
	Ac4XSAcpFkVMcYAukIZqku1xrCUb4/QPS6rPsuEzarF7H4hY5NUj1r68GzYSQqRObuULk2
	CmBpKMnTQjh3DadOALT4RWdJjhQ9M+U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-zGohwfcPPECCjkOk2JFtkw-1; Mon,
 13 Jan 2025 10:12:14 -0500
X-MC-Unique: zGohwfcPPECCjkOk2JFtkw-1
X-Mimecast-MFC-AGG-ID: zGohwfcPPECCjkOk2JFtkw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B694419560B7;
	Mon, 13 Jan 2025 15:12:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.15])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 056A419560AB;
	Mon, 13 Jan 2025 15:12:01 +0000 (UTC)
Date: Mon, 13 Jan 2025 23:11:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: "Lai, Yi" <yi1.lai@linux.intel.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	yi1.lai@intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
Message-ID: <Z4UtPNtdgVrA9ztl@fedora>
References: <20241025003722.3630252-1-ming.lei@redhat.com>
 <20241025003722.3630252-4-ming.lei@redhat.com>
 <ZyHV7xTccCwN8j7b@ly-workstation>
 <ZyHchfaUe2cEzFMm@fedora>
 <ZyHzb8ExdDG4b8lo@ly-workstation>
 <CAFj5m9+bL23T7mMwR7g_8umTzkNJa14n8AhR3_g6QjB2YCcc5A@mail.gmail.com>
 <ZyIM0dWzxC9zBIuf@ly-workstation>
 <ZyITwN0ihIFiz9M2@fedora>
 <Z0/K0bDHBUWlt0Hl@ly-workstation>
 <Z4Ulmv7e0-Q4wMGq@debian.local>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Ulmv7e0-Q4wMGq@debian.local>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Jan 13, 2025 at 02:39:22PM +0000, Chris Bainbridge wrote:
> Hi,
> 
> With latest mainline 6.13-rc6, I have been getting intermittent lock
> warnings when using a btrfs filesystem. The warnings bisect to this
> commit:
> 
> f1be1788a32e8fa63416ad4518bbd1a85a825c9d is the first bad commit
> commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Fri Oct 25 08:37:20 2024 +0800
> 
>     block: model freeze & enter queue as lock for supporting lockdep
> 
> 
> On my system, these lockdep warnings are reproducible just by doing some
> large fs operation, like copying the whole linux kernel git repo to the
> btrfs filesystem.
> 
> The lockdep warning is:
> 
> [  437.745808] ======================================================
> [  437.745810] WARNING: possible circular locking dependency detected
> [  437.745811] 6.13.0-rc6-00037-gac70f027bab6 #112 Not tainted
> [  437.745813] ------------------------------------------------------
> [  437.745814] kswapd0/141 is trying to acquire lock:
> [  437.745815] ffff925c11095e90 (&delayed_node->mutex){+.+.}-{4:4}, at: __btrfs_release_delayed_node.part.0+0x3f/0x280 [btrfs]
> [  437.745862]
>                but task is already holding lock:
> [  437.745863] ffffffffb9cc8c80 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x578/0xa80
> [  437.745869]
>                which lock already depends on the new lock.
> 
> [  437.745870]
>                the existing dependency chain (in reverse order) is:
> [  437.745871]
>                -> #3 (fs_reclaim){+.+.}-{0:0}:
> [  437.745873]        fs_reclaim_acquire+0xbd/0xf0
> [  437.745877]        __kmalloc_node_noprof+0xa1/0x4f0
> [  437.745880]        __kvmalloc_node_noprof+0x24/0x100
> [  437.745881]        sbitmap_init_node+0x98/0x240
> [  437.745885]        scsi_realloc_sdev_budget_map+0xdd/0x1d0
> [  437.745889]        scsi_add_lun+0x458/0x760
> [  437.745891]        scsi_probe_and_add_lun+0x15e/0x480
> [  437.745892]        __scsi_scan_target+0xfb/0x230
> [  437.745893]        scsi_scan_channel+0x65/0xc0
> [  437.745894]        scsi_scan_host_selected+0xfb/0x160
> [  437.745896]        do_scsi_scan_host+0x9d/0xb0
> [  437.745897]        do_scan_async+0x1c/0x1a0
> [  437.745898]        async_run_entry_fn+0x2d/0x120
> [  437.745901]        process_one_work+0x210/0x730
> [  437.745903]        worker_thread+0x193/0x350
> [  437.745905]        kthread+0xf3/0x120
> [  437.745906]        ret_from_fork+0x40/0x70
> [  437.745910]        ret_from_fork_asm+0x11/0x20
> [  437.745912]
>                -> #2 (&q->q_usage_counter(io)#10){++++}-{0:0}:

Hello,

This one has been solved in for-6.14/block:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.14/block

Thanks,
Ming

