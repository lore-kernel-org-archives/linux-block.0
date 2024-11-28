Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF92E1E480
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732797479; cv=none; b=AZF/f6PdRo4K3091TtgeR0j3vx6Jc44ugqiut9/6YXASeiNDn2JUvIpPw2vpnriA56Y26SPE6nb0A+GWf23b9VTQsjrwdWa1aePjjqlgwRsUBbwRw7aLhAgVlVFE8u6BLiODjxDie3I2r1NTBfHZLqEEGQJXIJm/DGjgaXUPwDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732797479; c=relaxed/simple;
	bh=TSutSaRNJEIBKoioA2DpkpF+qSM8uwNP8QqKCmXyIZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1DdaqSNyx0UBkJZ/lLyTt5f23tYDjq+SD7AsK4lSCphtJoI+5HmlXjVtr5VbaxpMSoWCgZFhsWGCICPLMzUS8+4Ggp/HpmvdVOnudzyGCNbSO/zftUZFZxXFYmCNG0MOa9KmBcyXKHfpVYPwj0cK2venbglZHjgLy2wfsVPWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Csrk2Lds; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Csrk2Lds"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732797476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTycFYp5qQtP06bfH9rKx4U2Ko4HpkiXHEvZHrmCX/U=;
	b=Csrk2LdsW0TWGO2eFTm+jk6tDD1r7ZH6POs1yL8ZmQVThKWAFPWRU3WEuqpZ74O6wXsgL9
	frjoTFoEIoQ+KyahGDmEK3CTkgD70xsJWfpDj5CspHNKo3xAuj4ujWYBERtYwl2d126jf7
	bVKpWK3z9FozBvzQyGtwwdslluqDENM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-mDCKoBzANvu39qpNG9G6pg-1; Thu,
 28 Nov 2024 07:37:53 -0500
X-MC-Unique: mDCKoBzANvu39qpNG9G6pg-1
X-Mimecast-MFC-AGG-ID: mDCKoBzANvu39qpNG9G6pg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03103195608C;
	Thu, 28 Nov 2024 12:37:52 +0000 (UTC)
Received: from fedora (unknown [10.72.116.159])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4D721955F41;
	Thu, 28 Nov 2024 12:37:47 +0000 (UTC)
Date: Thu, 28 Nov 2024 20:37:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: syzbot <syzbot+9b145229d11aa73e4571@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] possible deadlock in loop_set_status
Message-ID: <Z0hkFoFsW5Xv8iKw@fedora>
References: <6741e9d0.050a0220.1cc393.0014.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6741e9d0.050a0220.1cc393.0014.GAE@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sat, Nov 23, 2024 at 06:42:24AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    06afb0f36106 Merge tag 'trace-v6.13' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=125a81c0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=95b76860fd16c857
> dashboard link: https://syzkaller.appspot.com/bug?extid=9b145229d11aa73e4571
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.

This one is supposed to be reproduced 100%, :-(

> 
> -> #0 (fs_reclaim){+.+.}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3161 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>        validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
>        __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>        __fs_reclaim_acquire mm/page_alloc.c:3851 [inline]
>        fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3865
>        might_alloc include/linux/sched/mm.h:318 [inline]
>        slab_pre_alloc_hook mm/slub.c:4036 [inline]
>        slab_alloc_node mm/slub.c:4114 [inline]
>        __kmalloc_cache_noprof+0x3d/0x2c0 mm/slub.c:4290
>        kmalloc_noprof include/linux/slab.h:879 [inline]
>        kzalloc_noprof include/linux/slab.h:1015 [inline]
>        kobject_uevent_env+0x28b/0x8e0 lib/kobject_uevent.c:540
>        set_capacity_and_notify+0x206/0x240 block/genhd.c:95
>        loop_set_size drivers/block/loop.c:232 [inline]
>        loop_set_status+0x584/0x8f0 drivers/block/loop.c:1285
>        lo_ioctl+0xcbc/0x1f50
>        blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:906 [inline]
>        __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f

Looks one real deadlock because bio_queue_enter() may be called from
direct reclaim, which is under blk_mq_freeze_queue().


thanks,
Ming

