Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53A83D3D07
	for <linux-block@vger.kernel.org>; Mon,  9 Mar 2026 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067471; cv=pass; b=bpFtfWPCWJdNLv+4tRusxd+vt7Rt4StBhBCK+ZeE3yzfLPixPxmbnaDmFuWgJAf+YmdSWgP7slTIt7MSyt9AYEIxMVMk6zopOsUW2XgKlEu8NAMCl4rYBLIrhDwwWKoUwi885Q1WPD7FNEvOKfU9+LO5xeEFBkTGAYBV16RoPBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067471; c=relaxed/simple;
	bh=cbf+eFE3aBzecWArkanZAAPrDKByH63lVqRuXhv278s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HYKukEOkl++yhrBiwYUt0FEmHdaiC6TJefV0J6yxJockxumg8jPBK5PsRkHukhMGZFnbV44q3gtXGUFlpwlJLMuzvqSjf2YR8TEeUgqDf4gc1MdyFTT3ZMguxhQ6TrVkXur+QAfPyA51FscZxSd2c2CfeYnKcFQtzP7wkPX1WtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1vB7DdS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nWVwX4tZ; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1vB7DdS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nWVwX4tZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773067465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=9BGdKQf31l3ycIxzt/ji6RrK4vHLFQ615lcPq4YgcGI=;
	b=K1vB7DdSBZ8GZdi3NRvL6yKrD/FigLXRQSsupTH28Q46JcU+Tv66myMgwzhLCmLJCbUpqJ
	hmk/w67VD2+ei+SCzAka5MP8E7yg7rOixefKtyAPMHM8W5FZMF0Prbwt3lgeeIGobpj1cS
	0hftLCEbG5JmJAZqHsfz8nWN6v3S6ew=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-9MUZyKTsNPenjGXvVrAzkA-1; Mon, 09 Mar 2026 10:44:23 -0400
X-MC-Unique: 9MUZyKTsNPenjGXvVrAzkA-1
X-Mimecast-MFC-AGG-ID: 9MUZyKTsNPenjGXvVrAzkA_1773067462
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-38a4106434eso8452201fa.2
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2026 07:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773067461; cv=none;
        d=google.com; s=arc-20240605;
        b=LoMgJJxI/7JwHTgYbvvTtKpCwRSlHdaQZcTBy2Mx91sKqQiXeCRHm3aqzJkZbyNgT6
         sKS+Q9NqpVdLNgkPMyl51OOIiy1ja6PIFk34XOl5hk496pbrLW9LWmbPP/vd4eNnMHOv
         yXf4jG9sKhslWu+pSRgP6YG7zpH565TnKqWijE2O/DaVAFpF/G5LdKU4IWHazzrS5b++
         Mhr16l1ednVpV/9ayRw33zeQpTxLSVGD8Oz4A9UQq9J3b5ze5bEiC/IdxRG0tT8knYIF
         mUAE6MPUTZz1GkWjDSdbywo3HE8m3Zvs6CE5WYC2SFv2PdI3EH74vJst2WjRII6nD+q0
         +zkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=9BGdKQf31l3ycIxzt/ji6RrK4vHLFQ615lcPq4YgcGI=;
        fh=5Ks51nBxLTEYAkAmhOtlLU0Jk2lwvRmDS6XUB6umXAY=;
        b=k/2qlXgIjhlxRaTRYeZtAc0AJzblo33zMf5mtZZgWwnnhLzMy4LnmxOdpnCVluKiac
         gGMNA72m6WouO7rFwJfVhl21eMBMZCEaRRm0fM3m+6JoIObf50HjUskN1vfqD3WQjETS
         Ky0LaZkR53hSB1pEijh59LInBY5/L6hD8J56EL5qyymhjE3oIe73iyFeBMTb3BxPptxg
         HFUcAtRlhpQpm8O0glf2pV8sd1BTAUXvaIbMeHEN9y6+MuENRkMCQnGRMNjSakZ8lde0
         aqw9JWxsGt4dArEvf1V4QGLkbZo4DUVYHebYEQ5ZtIDLFx+rSP1OIgVMbU6As7tkl09B
         oloQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773067461; x=1773672261; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9BGdKQf31l3ycIxzt/ji6RrK4vHLFQ615lcPq4YgcGI=;
        b=nWVwX4tZoHelZZQ+46cUj7bDpZjUPIqV2PdzY9HaUL8NwXpzLm5RjHktfehgLIYMRy
         caBZTpovTbMj7Dlxt7WE2+JctFDBddUWpu+iCW8VXJnxY41p0ZVRQygH9esnBbanLAQ2
         xnoyqDPCwauxsiYu5w2Gq2vsteeUfXbcUKAqO7ZaCJDH2qxobDR0DpU2up9XE2yDyUIy
         jBsYhZTX+AHqIgANSGqypmrUH1b9AoYF/jW2KpzkFlakydnBfm2uRRs392GMHHFUiidm
         t2iYs7uAaSW69IGW4dkOcE2K6E04ga3dp7GsfYXbLVgC4Vem0ak5SfTdrgpQKCQjKLSi
         tEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773067461; x=1773672261;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BGdKQf31l3ycIxzt/ji6RrK4vHLFQ615lcPq4YgcGI=;
        b=JcoCfIoEpGkI9u5M15pavm6Ybc1Z4d59/NKgfKjxal3tiZegySt0GHNxpU9U4lHYv1
         E4PN/jN3RKmlx+jpmzYjNXK3qMg6dAvOJ46xFTL7OatSHJA1vrbN+qp/D3OZTv96AxjW
         zDZ6hJxoGhxqyYlvxLZwSpMFRkG3lcoA6gRnuDcncpLXnHR4kIH4UqYhUrtHltUiCVnF
         CF0oAvwE3Bu0qUC+wmeeJ5KTHoQu9R0Wei+VqtpsghfYMiEDRSK4aHhOpGhPDNuFq2A5
         KXVs5wWeBNIzyMGe2gTrE5myCUYHnmUxvsVJbCQ5StYonw62QOh9TMSnY4oyzdLw5jiW
         N/yQ==
X-Gm-Message-State: AOJu0YyNjzpl2mOgGpGvzytqUxt+OxoQYCOw3N2krFfW/sS2FclU9Gd/
	1gTa/0b4noMqJBn6bb3gS/0jCBF7C5YSVv2rI9lshK4pS0C13qryMGyWqdieXtJ4+UYFVUuK1A7
	NhrbH9hS8b+qWNtGwBUnsKPUT6ykHwBA7/HStF2Ia+hT97DS9WsuiRxDAZjohNQ0AeCwXf1dGhh
	uPanTBdF5q7XZYc8LjwLRythg1PIjY7fDcbbGfAi306Hw4Sd+/IG2x
X-Gm-Gg: ATEYQzyhry2jgvEMBl7yYa/KAH4LprjkjVneNxe7Ia6Og/+Wav6+jv7bR1kwqGayw4v
	uplMR9Af69u9SduQUYod7OJjoeE08eh98Fc+T0AM1tmbZtxEGW4MgHkx4Ysb29hODJ3kGPwUscL
	PL1N5Mbnmw3r4DKP6pO/QqriiImmD7JBnT+ZliCpj3tqJSZwDD3sZ0yO96/uWpIMbjUQC/oQAAX
	D3jvvF8+B0eOIy6NPheMDCafUEgBMnI5/rK3bsC/ogWH/cJsok=
X-Received: by 2002:a05:651c:1994:b0:38a:5284:9382 with SMTP id 38308e7fff4ca-38a5284961fmr13653861fa.20.1773067460890;
        Mon, 09 Mar 2026 07:44:20 -0700 (PDT)
X-Received: by 2002:a05:651c:1994:b0:38a:5284:9382 with SMTP id
 38308e7fff4ca-38a5284961fmr13653691fa.20.1773067460071; Mon, 09 Mar 2026
 07:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 9 Mar 2026 22:43:38 +0800
X-Gm-Features: AaiRm53qxA7DZ5cQzsy3MBKGngXjtaYRqK0FpqgaBP4qtBl30BircqIy6CtZ7vc
Message-ID: <CAHj4cs_J3qGYWUjdfY7pE=Qv5m18t=hgok0HZhmLUTfgTEUDfw@mail.gmail.com>
Subject: [bug report] blktests nbd/002 failed with possible circular locking
 dependency detected at: prepare_alloc_pages+0x16f/0x610 and lock_mm_and_find_vma+0x2f/0xc90
To: linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi

I reproduced the blktests nbd/002 failure on the latest
linux-block/for-next, please help check it and let me know if you need
any info/test for it, thanks.

commit: 8e58f73b78f0 (HEAD -> for-next, origin/for-next) Merge branch
'for-7.1/io_uring' into for-next

[ 7346.815323] run blktests nbd/002 at 2026-03-09 10:24:12
[ 7347.657141] nbd0: detected capacity change from 0 to 20971520

[ 7348.021852] ======================================================
[ 7348.028043] WARNING: possible circular locking dependency detected
[ 7348.034229] 7.0.0-rc2+ #1 Not tainted
[ 7348.037894] ------------------------------------------------------
[ 7348.044072] nbd-server/26688 is trying to acquire lock:
[ 7348.049298] ffffffff938b8340 (fs_reclaim){+.+.}-{0:0}, at:
prepare_alloc_pages+0x16f/0x610
[ 7348.057575]
               but task is already holding lock:
[ 7348.063406] ffff88ab2b4f7610 (&mm->mmap_lock){++++}-{4:4}, at:
lock_mm_and_find_vma+0x2f/0xc90
[ 7348.072029]
               which lock already depends on the new lock.

[ 7348.080201]
               the existing dependency chain (in reverse order) is:
[ 7348.087681]
               -> #6 (&mm->mmap_lock){++++}-{4:4}:
[ 7348.093695]        __lock_acquire+0x506/0xbf0
[ 7348.098063]        lock_acquire.part.0+0xc7/0x280
[ 7348.102767]        __might_fault+0xc5/0x140
[ 7348.106954]        _inline_copy_from_user+0x22/0xa0
[ 7348.111841]        do_ipv6_setsockopt+0x244e/0x3220
[ 7348.116728]        ipv6_setsockopt+0x82/0x100
[ 7348.121087]        do_sock_setsockopt+0x167/0x3b0
[ 7348.125792]        __sys_setsockopt+0xe4/0x160
[ 7348.130239]        __x64_sys_setsockopt+0xbd/0x190
[ 7348.135032]        do_syscall_64+0x140/0x14e0
[ 7348.139398]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 7348.144970]
               -> #5 (sk_lock-AF_INET6){+.+.}-{0:0}:
[ 7348.151159]        __lock_acquire+0x506/0xbf0
[ 7348.155516]        lock_acquire.part.0+0xc7/0x280
[ 7348.160224]        lock_sock_nested+0x36/0xf0
[ 7348.164591]        tcp_recvmsg+0x101/0x500
[ 7348.168697]        inet6_recvmsg+0x117/0x690
[ 7348.172970]        sock_recvmsg+0xf1/0x190
[ 7348.177071]        __sock_xmit+0x324/0x4e0 [nbd]
[ 7348.181699]        nbd_handle_reply+0x6df/0xe80 [nbd]
[ 7348.186757]        recv_work+0x218/0x770 [nbd]
[ 7348.191213]        process_one_work+0x8b1/0x15e0
[ 7348.195839]        worker_thread+0x5e9/0xfc0
[ 7348.200113]        kthread+0x36b/0x470
[ 7348.203866]        ret_from_fork+0x5bf/0x910
[ 7348.208144]        ret_from_fork_asm+0x1a/0x30
[ 7348.212592]
               -> #4 (&cmd->lock){+.+.}-{4:4}:
[ 7348.218258]        __lock_acquire+0x506/0xbf0
[ 7348.222617]        lock_acquire.part.0+0xc7/0x280
[ 7348.227324]        __mutex_lock+0x1b2/0x24e0
[ 7348.231595]        nbd_queue_rq+0x4c/0xe0 [nbd]
[ 7348.236138]        blk_mq_dispatch_rq_list+0x3c9/0x1550
[ 7348.241370]        __blk_mq_do_dispatch_sched+0x8d7/0x960
[ 7348.246771]        __blk_mq_sched_dispatch_requests+0x3bf/0x510
[ 7348.252688]        blk_mq_sched_dispatch_requests+0xab/0x150
[ 7348.258347]        blk_mq_run_hw_queue+0x1dd/0x590
[ 7348.263140]        blk_mq_dispatch_list+0x4ff/0xdc0
[ 7348.268017]        blk_mq_flush_plug_list+0x115/0x6b0
[ 7348.273071]        __blk_flush_plug+0x2a3/0x550
[ 7348.277612]        __submit_bio+0x4cb/0x640
[ 7348.281797]        submit_bio_noacct_nocheck+0x41b/0x600
[ 7348.287111]        block_read_full_folio+0x391/0x6f0
[ 7348.292083]        filemap_read_folio+0xda/0x320
[ 7348.296711]        do_read_cache_folio+0x205/0x550
[ 7348.301504]        read_part_sector+0xbd/0x310
[ 7348.305957]        read_lba+0x1ad/0x370
[ 7348.309797]        find_valid_gpt.constprop.0+0x25e/0xd50
[ 7348.315197]        efi_partition+0x131/0xcd0
[ 7348.319468]        check_partition+0x334/0x660
[ 7348.323914]        blk_add_partitions+0x98/0x600
[ 7348.328532]        bdev_disk_changed+0x29f/0x450
[ 7348.333151]        blkdev_get_whole+0x142/0x200
[ 7348.337685]        bdev_open+0x71e/0xc60
[ 7348.341609]        blkdev_open+0x2ab/0x450
[ 7348.345707]        do_dentry_open+0x433/0x1320
[ 7348.350156]        vfs_open+0x7a/0x440
[ 7348.353907]        do_open+0x406/0xe20
[ 7348.357660]        path_openat+0x1d3/0x590
[ 7348.361767]        do_file_open+0x209/0x480
[ 7348.365953]        do_sys_openat2+0xde/0x170
[ 7348.370226]        __x64_sys_openat+0x10e/0x210
[ 7348.374756]        do_syscall_64+0x140/0x14e0
[ 7348.379116]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 7348.384687]
               -> #3 (set->srcu){.+.+}-{0:0}:
[ 7348.390268]        __lock_acquire+0x506/0xbf0
[ 7348.394628]        lock_sync.part.0+0x71/0xe0
[ 7348.398987]        __synchronize_srcu+0xc0/0x2d0
[ 7348.403605]        elevator_switch+0x2bd/0x670
[ 7348.408053]        elevator_change+0x2e7/0x500
[ 7348.412499]        elevator_set_none+0xae/0x100
[ 7348.417031]        blk_unregister_queue+0x162/0x2e0
[ 7348.421909]        __del_gendisk+0x28b/0xad0
[ 7348.426182]        del_gendisk+0x11e/0x1d0
[ 7348.430280]        recv_work+0x428/0x770 [nbd]
[ 7348.434735]        nbd_start_device+0x36c/0xb10 [nbd]
[ 7348.439794]        configfs_rmdir+0x6e9/0xb50
[ 7348.444155]        vfs_rmdir+0x2c0/0x7a0
[ 7348.448078]        filename_rmdir+0x35d/0x5a0
[ 7348.452437]        __x64_sys_unlinkat+0xdc/0x110
[ 7348.457056]        do_syscall_64+0x140/0x14e0
[ 7348.461415]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 7348.466989]
               -> #2 (&q->elevator_lock){+.+.}-{4:4}:
[ 7348.473263]        __lock_acquire+0x506/0xbf0
[ 7348.477621]        lock_acquire.part.0+0xc7/0x280
[ 7348.482329]        __mutex_lock+0x1b2/0x24e0
[ 7348.486599]        elevator_change+0x197/0x500
[ 7348.491047]        elv_iosched_store+0x393/0x430
[ 7348.495664]        queue_attr_store+0x263/0x3f0
[ 7348.500197]        kernfs_fop_write_iter+0x3da/0x5e0
[ 7348.505161]        vfs_write+0x4b7/0xf80
[ 7348.509087]        ksys_write+0x116/0x250
[ 7348.513099]        do_syscall_64+0x140/0x14e0
[ 7348.517459]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 7348.523032]
               -> #1 (&q->q_usage_counter(io)){++++}-{0:0}:
[ 7348.529827]        __lock_acquire+0x506/0xbf0
[ 7348.534183]        lock_acquire.part.0+0xc7/0x280
[ 7348.538889]        blk_alloc_queue+0x613/0x7b0
[ 7348.543334]        blk_mq_alloc_queue+0x16c/0x280
[ 7348.548041]        scsi_alloc_sdev+0x882/0xcf0
[ 7348.552486]        scsi_probe_and_add_lun+0x654/0xcc0
[ 7348.557539]        __scsi_scan_target+0x18b/0x3b0
[ 7348.562245]        scsi_scan_channel+0x105/0x1b0
[ 7348.566864]        scsi_scan_host_selected+0x216/0x2d0
[ 7348.572001]        do_scan_async+0x42/0x480
[ 7348.576189]        async_run_entry_fn+0x97/0x550
[ 7348.580807]        process_one_work+0x8b1/0x15e0
[ 7348.585425]        worker_thread+0x5e9/0xfc0
[ 7348.589697]        kthread+0x36b/0x470
[ 7348.593452]        ret_from_fork+0x5bf/0x910
[ 7348.597722]        ret_from_fork_asm+0x1a/0x30
[ 7348.602168]
               -> #0 (fs_reclaim){+.+.}-{0:0}:
[ 7348.607837]        check_prev_add+0xdb/0xce0
[ 7348.612109]        validate_chain+0x554/0x780
[ 7348.616467]        __lock_acquire+0x506/0xbf0
[ 7348.620827]        lock_acquire.part.0+0xc7/0x280
[ 7348.625531]        fs_reclaim_acquire+0xd9/0x130
[ 7348.630150]        prepare_alloc_pages+0x16f/0x610
[ 7348.634943]        __alloc_frozen_pages_noprof+0x160/0x570
[ 7348.640430]        alloc_pages_mpol+0x14d/0x420
[ 7348.644970]        folio_alloc_mpol_noprof+0x1d/0x2a0
[ 7348.650023]        vma_alloc_folio_noprof+0xc9/0x180
[ 7348.654988]        alloc_anon_folio+0x3ae/0xb70
[ 7348.659521]        do_anonymous_page+0x434/0xfa0
[ 7348.664137]        handle_pte_fault+0x614/0x890
[ 7348.668672]        __handle_mm_fault+0xa3f/0xf20
[ 7348.673289]        handle_mm_fault+0x2c4/0x9c0
[ 7348.677736]        do_user_addr_fault+0x2f2/0xf50
[ 7348.682450]        exc_page_fault+0x98/0x140
[ 7348.686722]        asm_exc_page_fault+0x26/0x30
[ 7348.691255]        rep_movs_alternative+0x4a/0x90
[ 7348.695959]        _copy_to_iter+0x1f7/0x19d0
[ 7348.700319]        __skb_datagram_iter+0x44d/0x820
[ 7348.705113]        skb_copy_datagram_iter+0x6e/0x1d0
[ 7348.710076]        tcp_recvmsg_locked+0x15d6/0x2590
[ 7348.714957]        tcp_recvmsg+0x11c/0x500
[ 7348.719054]        inet6_recvmsg+0x117/0x690
[ 7348.723327]        sock_recvmsg+0xf1/0x190
[ 7348.727426]        sock_read_iter+0x253/0x500
[ 7348.731785]        vfs_read+0x7e5/0xb20
[ 7348.735623]        ksys_read+0x1b0/0x250
[ 7348.739550]        do_syscall_64+0x140/0x14e0
[ 7348.743910]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 7348.749481]
               other info that might help us debug this:

[ 7348.757480] Chain exists of:
                 fs_reclaim --> sk_lock-AF_INET6 --> &mm->mmap_lock

[ 7348.767826]  Possible unsafe locking scenario:

[ 7348.773747]        CPU0                    CPU1
[ 7348.778278]        ----                    ----
[ 7348.782811]   rlock(&mm->mmap_lock);
[ 7348.786388]                                lock(sk_lock-AF_INET6);
[ 7348.792567]                                lock(&mm->mmap_lock);
[ 7348.798575]   lock(fs_reclaim);
[ 7348.801720]
                *** DEADLOCK ***

[ 7348.807637] 2 locks held by nbd-server/26688:
[ 7348.811997]  #0: ffff88a88b304740 (sk_lock-AF_INET6){+.+.}-{0:0},
at: tcp_recvmsg+0x101/0x500
[ 7348.820525]  #1: ffff88ab2b4f7610 (&mm->mmap_lock){++++}-{4:4}, at:
lock_mm_and_find_vma+0x2f/0xc90
[ 7348.829572]
               stack backtrace:
[ 7348.833934] CPU: 15 UID: 0 PID: 26688 Comm: nbd-server Not tainted
7.0.0-rc2+ #1 PREEMPT(full)
[ 7348.833939] Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
2.22.2 09/12/2024
[ 7348.833942] Call Trace:
[ 7348.833945]  <TASK>
[ 7348.833947]  dump_stack_lvl+0x84/0xd0
[ 7348.833955]  print_circular_bug.cold+0x38/0x46
[ 7348.833964]  check_noncircular+0x173/0x1a0
[ 7348.833972]  check_prev_add+0xdb/0xce0
[ 7348.833975]  ? lockdep_hardirqs_on_prepare.part.0+0x92/0x170
[ 7348.833981]  validate_chain+0x554/0x780
[ 7348.833987]  __lock_acquire+0x506/0xbf0
[ 7348.833994]  lock_acquire.part.0+0xc7/0x280
[ 7348.833998]  ? prepare_alloc_pages+0x16f/0x610
[ 7348.834003]  ? local_clock+0x15/0x30
[ 7348.834008]  ? __lock_release.isra.0+0x1a2/0x370
[ 7348.834012]  ? rcu_is_watching+0x15/0xe0
[ 7348.834018]  ? lock_acquire+0x130/0x150
[ 7348.834023]  fs_reclaim_acquire+0xd9/0x130
[ 7348.834027]  ? prepare_alloc_pages+0x16f/0x610
[ 7348.834031]  ? __netif_rx+0x2bf/0x370
[ 7348.834036]  prepare_alloc_pages+0x16f/0x610
[ 7348.834041]  ? loopback_xmit+0x26a/0x600
[ 7348.834049]  __alloc_frozen_pages_noprof+0x160/0x570
[ 7348.834054]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10
[ 7348.834057]  ? trace_hardirqs_on+0x18/0x1b0
[ 7348.834063]  ? lockdep_hardirqs_on+0x90/0x130
[ 7348.834068]  ? __local_bh_enable_ip+0xb1/0x170
[ 7348.834076]  ? netif_rx_internal+0xc4/0x480
[ 7348.834083]  alloc_pages_mpol+0x14d/0x420
[ 7348.834088]  ? __pfx_alloc_pages_mpol+0x10/0x10
[ 7348.834093]  ? lock_acquire.part.0+0xc7/0x280
[ 7348.834099]  folio_alloc_mpol_noprof+0x1d/0x2a0
[ 7348.834104]  ? local_clock_noinstr+0xf/0x130
[ 7348.834108]  vma_alloc_folio_noprof+0xc9/0x180
[ 7348.834113]  ? local_clock+0x15/0x30
[ 7348.834116]  ? __pfx_vma_alloc_folio_noprof+0x10/0x10
[ 7348.834124]  alloc_anon_folio+0x3ae/0xb70
[ 7348.834129]  ? rcu_is_watching+0x15/0xe0
[ 7348.834135]  do_anonymous_page+0x434/0xfa0
[ 7348.834143]  handle_pte_fault+0x614/0x890
[ 7348.834148]  ? find_held_lock+0x2b/0x80
[ 7348.834155]  ? __pfx_handle_pte_fault+0x10/0x10
[ 7348.834160]  ? __lock_release.isra.0+0x1a2/0x370
[ 7348.834164]  ? __pfx_pmd_val+0x10/0x10
[ 7348.834169]  __handle_mm_fault+0xa3f/0xf20
[ 7348.834176]  ? __pfx___handle_mm_fault+0x10/0x10
[ 7348.834186]  ? find_vma+0xa1/0x120
[ 7348.834193]  handle_mm_fault+0x2c4/0x9c0
[ 7348.834198]  ? lock_mm_and_find_vma+0x4b/0xc90
[ 7348.834204]  do_user_addr_fault+0x2f2/0xf50
[ 7348.834211]  exc_page_fault+0x98/0x140
[ 7348.834216]  asm_exc_page_fault+0x26/0x30
[ 7348.834220] RIP: 0010:rep_movs_alternative+0x4a/0x90
[ 7348.834225] Code: cc cc cc 66 90 66 66 2e 0f 1f 84 00 00 00 00 00
48 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 db 83 f9 08 73
e8 eb c5 <f3> a4 c3 cc cc cc cc 48 8b 06 48 89 07 48 8d 47 08 48 83 e0
f8 48
[ 7348.834228] RSP: 0018:ffffc90020177448 EFLAGS: 00050206
[ 7348.834232] RAX: 0000000000000001 RBX: ffffc900201779d0 RCX: 00000000000023c0
[ 7348.834235] RDX: 0000000000000000 RSI: ffff88aaaf160e38 RDI: 000056008ba0b000
[ 7348.834237] RBP: 0000000000003000 R08: ffffffff8fd4bc26 R09: ffffed1555e2c040
[ 7348.834240] R10: ffffed1555e2c63f R11: 0000000000000000 R12: 000056008ba0a3c0
[ 7348.834242] R13: ffffc900201779d8 R14: ffffc900201779e8 R15: ffff88aaaf1601f8
[ 7348.834247]  ? _copy_to_iter+0x1e6/0x19d0
[ 7348.834254]  _copy_to_iter+0x1f7/0x19d0
[ 7348.834261]  ? __pfx__copy_to_iter+0x10/0x10
[ 7348.834265]  ? check_heap_object+0x254/0x590
[ 7348.834274]  ? __check_object_size+0x77/0x160
[ 7348.834281]  __skb_datagram_iter+0x44d/0x820
[ 7348.834284]  ? __pfx_simple_copy_to_iter+0x10/0x10
[ 7348.834289]  ? local_clock_noinstr+0xf/0x130
[ 7348.834293]  ? local_clock_noinstr+0xf/0x130
[ 7348.834297]  ? local_clock+0x15/0x30
[ 7348.834301]  skb_copy_datagram_iter+0x6e/0x1d0
[ 7348.834307]  tcp_recvmsg_locked+0x15d6/0x2590
[ 7348.834318]  ? __pfx_tcp_recvmsg_locked+0x10/0x10
[ 7348.834323]  ? local_clock+0x15/0x30
[ 7348.834330]  tcp_recvmsg+0x11c/0x500
[ 7348.834335]  ? __pfx_tcp_recvmsg+0x10/0x10
[ 7348.834342]  ? __pfx_sock_has_perm+0x10/0x10
[ 7348.834350]  inet6_recvmsg+0x117/0x690
[ 7348.834354]  ? __pfx_avc_has_perm+0x10/0x10
[ 7348.834360]  ? __pfx_inet6_recvmsg+0x10/0x10
[ 7348.834364]  ? __lock_acquire+0x506/0xbf0
[ 7348.834371]  sock_recvmsg+0xf1/0x190
[ 7348.834375]  sock_read_iter+0x253/0x500
[ 7348.834379]  ? __pfx_file_has_perm+0x10/0x10
[ 7348.834382]  ? lock_acquire.part.0+0xc7/0x280
[ 7348.834387]  ? __pfx_sock_read_iter+0x10/0x10
[ 7348.834391]  ? local_clock+0x15/0x30
[ 7348.834397]  ? rw_verify_area+0x7b/0x650
[ 7348.834403]  vfs_read+0x7e5/0xb20
[ 7348.834407]  ? lock_acquire.part.0+0xc7/0x280
[ 7348.834412]  ? __pfx_vfs_read+0x10/0x10
[ 7348.834424]  ksys_read+0x1b0/0x250
[ 7348.834429]  ? __pfx_ksys_read+0x10/0x10
[ 7348.834434]  ? rcu_is_watching+0x15/0xe0
[ 7348.834439]  do_syscall_64+0x140/0x14e0
[ 7348.834444]  ? __pfx_handle_pte_fault+0x10/0x10
[ 7348.834449]  ? __pfx_pmd_val+0x10/0x10
[ 7348.834455]  ? local_clock_noinstr+0xf/0x130
[ 7348.834459]  ? local_clock+0x15/0x30
[ 7348.834462]  ? __lock_acquire+0x506/0xbf0
[ 7348.834467]  ? __pfx_css_rstat_updated+0x10/0x10
[ 7348.834474]  ? lock_acquire.part.0+0xc7/0x280
[ 7348.834477]  ? count_memcg_events_mm.constprop.0+0x22/0x130
[ 7348.834484]  ? local_clock+0x15/0x30
[ 7348.834486]  ? __lock_release.isra.0+0x1a2/0x370
[ 7348.834493]  ? local_clock+0x15/0x30
[ 7348.834496]  ? __lock_release.isra.0+0x1a2/0x370
[ 7348.834503]  ? do_user_addr_fault+0x86e/0xf50
[ 7348.834508]  ? rcu_is_watching+0x15/0xe0
[ 7348.834512]  ? irqentry_exit+0x94/0x600
[ 7348.834516]  ? trace_hardirqs_on_prepare+0x153/0x1a0
[ 7348.834520]  ? lockdep_hardirqs_on_prepare.part.0+0x92/0x170
[ 7348.834524]  ? irqentry_exit+0x99/0x600
[ 7348.834529]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 7348.834533] RIP: 0033:0x7fa9f9280ff2
[ 7348.834537] Code: 08 0f 85 91 41 ff ff 49 89 fb 48 89 f0 48 89 d7
48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24
08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 55 bf
01 00
[ 7348.834540] RSP: 002b:00007ffc91b29ee8 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[ 7348.834543] RAX: ffffffffffffffda RBX: 000056008ba08c40 RCX: 00007fa9f9280ff2
[ 7348.834546] RDX: 0000000000003000 RSI: 000056008ba0a3c0 RDI: 0000000000000005
[ 7348.834548] RBP: 00007ffc91b29f10 R08: 0000000000000000 R09: 0000000000000000
[ 7348.834550] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000003000
[ 7348.834552] R13: 000056008ba0a3c0 R14: 0000000000000005 R15: 000056008ba08c40
[ 7348.834561]  </TASK>
[ 7349.605037]  nbd0:
[ 7349.898687] block nbd0: NBD_DISCONNECT
[ 7349.902992] block nbd0: Disconnected due to user request.
[ 7349.908715] block nbd0: shutting down sockets
[ 7350.126833] nbd0: detected capacity change from 0 to 20971520
[ 7350.146781]  nbd0: p1
[ 7350.422625] block nbd0: NBD_DISCONNECT
[ 7350.427990] block nbd0: Disconnected due to user request.
[ 7350.433706] block nbd0: shutting down sockets
[ 7351.527690] nbd0: detected capacity change from 0 to 20971520
[ 7351.548081]  nbd0: p1
[ 7351.929434] block nbd0: NBD_DISCONNECT
[ 7351.933386] block nbd0: Disconnected due to user request.
[ 7351.940668] block nbd0: shutting down sockets

-- 
Best Regards,
  Yi Zhang

