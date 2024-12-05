Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5F014A90
	for <linux-block@vger.kernel.org>; Thu,  5 Dec 2024 04:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733374113; cv=none; b=OHWIIkZZfzlK6K+zJfLl41qBbePV1ZfhMKvGbI12B16fMGZhUYVoyokZLr07m+KpIrqd6gPvZxJucwUvV1BNIJF5kVlKee9dIhwF2/+TdC7Nqkx0PqVRWite7/5owBcKFCWAIs1A0sDnXgByfArN+dDSrY6X+x1iIx6rSEmDSHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733374113; c=relaxed/simple;
	bh=Hd087IB54DaBEER+B1bQ4LuZ6WFrovFs/B5p2ZrBTnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwMAEdl9St5/vgg2Tt2SFPIaFvRFEjzenBFndmvyP2bqORkAxaX/A0BXcd4fHthd5sISBYsOkmzZd503gvdzI2/qazOk04tmXUtox8Nvy3JBuUsx8nsbI4hyEhF95/fapmo9CU9N0Xg/rcDQK0LP+DB7er9kRLGHYQfI6PYNFwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i1KSTERA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1KSTERA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733374110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MyJ71Sm/SJL3FaGLqewdcEVkuuJhrCKvcnIxRgDdmAw=;
	b=i1KSTERAwIYHSTKOmT9VtQo9Va9nnvd9BHfKLG0pOXvQ4Y0TJaiKuCd6GwyEVjIPUpJBt/
	9gXEi3jQ+Pq9Kz58pa4SlVNfH+IWhKeuZRs6/lC269EK24qJ+vfoeBQZ924en4hIFFpbrE
	FI8/lxLlCI7gJtZ9odNW72Sn2KOVxLo=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-xoFcYeKqPHS20BUhy7tA9Q-1; Wed, 04 Dec 2024 23:48:28 -0500
X-MC-Unique: xoFcYeKqPHS20BUhy7tA9Q-1
X-Mimecast-MFC-AGG-ID: xoFcYeKqPHS20BUhy7tA9Q
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4afb0276095so115394137.1
        for <linux-block@vger.kernel.org>; Wed, 04 Dec 2024 20:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733374107; x=1733978907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyJ71Sm/SJL3FaGLqewdcEVkuuJhrCKvcnIxRgDdmAw=;
        b=COk2ihgTbnmk8n9f8aRtLJJE6Icbz/QAhmVHLzKypmTuFCXElwEWNRvaccCw13fF35
         X+wwGxSRcq2IIzoqrodcCyzftrT5j0ddGF/EyjcOCNn2r8zOFlJzXXXbkdCVLZsn+dqp
         7GxuQqu+KvOMqT878UuJ+MCVT2jLYuw5M9keC6kHGm3nLr4N+w0rSy3Nc9pgsYeCIHSD
         pfNPmP0kKQy5L7OIZhmo6g7uuZgADnjlTR9VslCmccjhROQP+tEg0tRD8FVgW108Ma5L
         yUgBel/D4aX9iNMQk+rWVNoRsMVdFRlqTRgokbeFvUlMMiENYFj6pDstMRNHnctQOUT6
         Q3eg==
X-Forwarded-Encrypted: i=1; AJvYcCUXRypqhtfB0P0FZU1lS/D3pPFH9DAXRTrZgs9Osxj07tIv1hViOS+lrqRAeLQAOWrY8LFv9WrWuZl39A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4GtzZ8JlvCcZupISo/0dMsKywacCwQ6/iRQMJEqcFWuTL151x
	qb/NhMHUOLrh+gi/OS21LXhbqTzknpUSkitvzoZGgQp2KW+9wxjIAVsnIIt7XE+z6sV7uMLu04J
	Wpz1Bmsxp6ygTOKfh/Gluhc6q6Og/p1ih2ZZ4sxeUhy3DM7x1MriT1e2M8hZA0ltk0u25UaYdDo
	ye4PkzWXnSh8DwICga/uvXRJwxFp92r1XlByM=
X-Gm-Gg: ASbGnculaPr5U4z6kN4n68tUcg0gZni9pGkQi2y4rtSI8yyMmqCn4XN/dOFpne6Lbc0
	yODJWKt/9gL2HgNIxbjB7vFj9teBOZ6To
X-Received: by 2002:a05:6102:5487:b0:4af:ba38:d04a with SMTP id ada2fe7eead31-4afba38de47mr1929140137.21.1733374107346;
        Wed, 04 Dec 2024 20:48:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMtnJ+xYZLF6bemAYJSyczSYetsc3KnEPqOG0UzcimwGLgpHyFKG258xJFjZSA6cNnvIf3EazwSY6xL1AIHUk=
X-Received: by 2002:a05:6102:5487:b0:4af:ba38:d04a with SMTP id
 ada2fe7eead31-4afba38de47mr1929137137.21.1733374107063; Wed, 04 Dec 2024
 20:48:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1225307.1733323625@warthog.procyon.org.uk>
In-Reply-To: <1225307.1733323625@warthog.procyon.org.uk>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 5 Dec 2024 12:48:16 +0800
Message-ID: <CAFj5m9KusEo=jQbt1AC=EQoOM-0EXmjjc_9WtSBCq+eMOSN8pw@mail.gmail.com>
Subject: Re: Possible locking bug in the block layer [was syzbot: Re: [syzbot]
 [netfs?] kernel BUG in iov_iter_revert (2)]
To: David Howells <dhowells@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 11:39=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
>
> Hi Jens,
>
> Whilst testing my netfslib patch, syzbot seems to have found an unrelated
> deadlock bug in the block layer, if you could take a look?
>
> https://lore.kernel.org/linux-fsdevel/1203250.1733323398@warthog.procyon.=
org.uk/T/#mc15e733720bedf2664b4347a823469a03b635132
>
> David
>
>
>
>
> ---------- Forwarded message ----------
> From: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
> To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.or=
g, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, syzkaller-bugs@goog=
legroups.com
> Cc:
> Bcc:
> Date: Wed, 04 Dec 2024 06:39:03 -0800
> Subject: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggeri=
ng an issue:
> possible deadlock in __submit_bio
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.13.0-rc1-syzkaller-dirty #0 Not tainted
> ------------------------------------------------------
> kswapd0/75 is trying to acquire lock:
> ffff888034c41438 (&q->q_usage_counter(io)#37){++++}-{0:0}, at: __submit_b=
io+0x2c6/0x560 block/blk-core.c:629
>
> but task is already holding lock:
> ffffffff8ea35b00 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:=
6864 [inline]
> ffffffff8ea35b00 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x36f0 mm/vms=
can.c:7246
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (fs_reclaim){+.+.}-{0:0}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>        __fs_reclaim_acquire mm/page_alloc.c:3851 [inline]
>        fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3865
>        might_alloc include/linux/sched/mm.h:318 [inline]
>        slab_pre_alloc_hook mm/slub.c:4055 [inline]
>        slab_alloc_node mm/slub.c:4133 [inline]
>        __do_kmalloc_node mm/slub.c:4282 [inline]
>        __kmalloc_node_noprof+0xb2/0x4d0 mm/slub.c:4289
>        __kvmalloc_node_noprof+0x72/0x190 mm/util.c:650
>        sbitmap_init_node+0x2d4/0x670 lib/sbitmap.c:132
>        scsi_realloc_sdev_budget_map+0x2a7/0x460 drivers/scsi/scsi_scan.c:=
246
>        scsi_add_lun drivers/scsi/scsi_scan.c:1106 [inline]
>        scsi_probe_and_add_lun+0x3173/0x4bd0 drivers/scsi/scsi_scan.c:1287
>        __scsi_add_device+0x228/0x2f0 drivers/scsi/scsi_scan.c:1622
>        ata_scsi_scan_host+0x236/0x740 drivers/ata/libata-scsi.c:4575
>        async_run_entry_fn+0xa8/0x420 kernel/async.c:129
>        process_one_work kernel/workqueue.c:3229 [inline]
>        process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
>        worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>        kthread+0x2f0/0x390 kernel/kthread.c:389
>        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> -> #0 (&q->q_usage_counter(io)#37){++++}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3161 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>        validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
>        __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>        bio_queue_enter block/blk.h:75 [inline]
>        blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3091
>        __submit_bio+0x2c6/0x560 block/blk-core.c:629
>        __submit_bio_noacct_mq block/blk-core.c:710 [inline]
>        submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
>        swap_writepage_bdev_async mm/page_io.c:451 [inline]
>        __swap_writepage+0x5fc/0x1400 mm/page_io.c:474
>        swap_writepage+0x8f4/0x1170 mm/page_io.c:289
>        pageout mm/vmscan.c:689 [inline]
>        shrink_folio_list+0x3c0e/0x8cb0 mm/vmscan.c:1367
>        evict_folios+0x5568/0x7be0 mm/vmscan.c:4593
>        try_to_shrink_lruvec+0x9a6/0xc70 mm/vmscan.c:4789
>        shrink_one+0x3b9/0x850 mm/vmscan.c:4834
>        shrink_many mm/vmscan.c:4897 [inline]
>        lru_gen_shrink_node mm/vmscan.c:4975 [inline]
>        shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
>        kswapd_shrink_node mm/vmscan.c:6785 [inline]
>        balance_pgdat mm/vmscan.c:6977 [inline]
>        kswapd+0x1ca9/0x36f0 mm/vmscan.c:7246
>        kthread+0x2f0/0x390 kernel/kthread.c:389
>        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(fs_reclaim);
>                                lock(&q->q_usage_counter(io)#37);
>                                lock(fs_reclaim);
>   rlock(&q->q_usage_counter(io)#37);
>
>  *** DEADLOCK ***
>
> 1 lock held by kswapd0/75:
>  #0: ffffffff8ea35b00 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmsc=
an.c:6864 [inline]
>  #0: ffffffff8ea35b00 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x36f0 m=
m/vmscan.c:7246
>
> stack backtrace:
> CPU: 0 UID: 0 PID: 75 Comm: kswapd0 Not tainted 6.13.0-rc1-syzkaller-dirt=
y #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
>  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
>  check_prev_add kernel/locking/lockdep.c:3161 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>  validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
>  __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>  bio_queue_enter block/blk.h:75 [inline]
>  blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3091
>  __submit_bio+0x2c6/0x560 block/blk-core.c:629
>  __submit_bio_noacct_mq block/blk-core.c:710 [inline]
>  submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
>  swap_writepage_bdev_async mm/page_io.c:451 [inline]
>  __swap_writepage+0x5fc/0x1400 mm/page_io.c:474
>  swap_writepage+0x8f4/0x1170 mm/page_io.c:289
>  pageout mm/vmscan.c:689 [inline]
>  shrink_folio_list+0x3c0e/0x8cb0 mm/vmscan.c:1367
>  evict_folios+0x5568/0x7be0 mm/vmscan.c:4593
>  try_to_shrink_lruvec+0x9a6/0xc70 mm/vmscan.c:4789
>  shrink_one+0x3b9/0x850 mm/vmscan.c:4834
>  shrink_many mm/vmscan.c:4897 [inline]
>  lru_gen_shrink_node mm/vmscan.c:4975 [inline]
>  shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
>  kswapd_shrink_node mm/vmscan.c:6785 [inline]
>  balance_pgdat mm/vmscan.c:6977 [inline]
>  kswapd+0x1ca9/0x36f0 mm/vmscan.c:7246
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
>
>
> Tested on:
>
> commit:         40384c84 Linux 6.13-rc1
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git v6.13-rc1
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D101560f858000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D58639d2215ba9=
a07
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D404b4b745080b62=
10c6c
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D138c4de858=
0000

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-bloc=
k.git
for-6.14/block

