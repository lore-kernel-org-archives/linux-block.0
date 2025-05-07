Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721FD28C5BF
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638984; cv=none; b=QwBBR5zysRk3PJtHP+JNWEn4bh1BMYcIgLGIRpDc1feKcTViX800xbqxabSFWZ80wsQtaAr10uU72KhXplCDHaWMfz80mhpfpfbKMPDmu3BQ19iIypL2cMBH2CR4qCjZtc9Q3cnwoXGt3F3EWYWOxy/bDY7vsHJktxHLZP2A7fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638984; c=relaxed/simple;
	bh=57sSPNVXnPHVASy9hsHEQjdYRdvIeI5foqb7I1935LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c50A3p07MLL/JAQsmytx4WYHQ5drtXCb2VfAL1bFqFeWWm10KDfwOUEmtTBK4jZw8tMF5lwSX6v9Ufnne9m1Js+yytpSfkfr3KHZ690narAqS+Mr/sV6YSHF5PYbcwLi7nABlX9i78pBknasCChGTwk7j3CSZKALQA7iuN7LL2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IgCUpteQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IgCUpteQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746638981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LV12ISBHwfBmHWlF5a5gaM+a8rwry9L63SShCcNqLy4=;
	b=IgCUpteQxQbUsUyzdkXd6R6P3WitlSioC1tVbGqdd2qt3ZIAYaWEgdSXgf1r+EMDpBSG/8
	WS+mhm7v1NFWxRzHmzm2sbXSgsFCRHWa1hPgy9fpYzuWiTfrP9tKWDVKTU6lAdQ4Vsog4h
	PXikLtoWB32ZWajJFfyLAQntiidnyqs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-IVTwZM8SOEG_3mjQOPyM2Q-1; Wed, 07 May 2025 13:29:40 -0400
X-MC-Unique: IVTwZM8SOEG_3mjQOPyM2Q-1
X-Mimecast-MFC-AGG-ID: IVTwZM8SOEG_3mjQOPyM2Q_1746638979
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-acb90bccc16so3994366b.3
        for <linux-block@vger.kernel.org>; Wed, 07 May 2025 10:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746638978; x=1747243778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LV12ISBHwfBmHWlF5a5gaM+a8rwry9L63SShCcNqLy4=;
        b=obFhs03T0cZWn1PJ5P1C5iL4AXZ9fKcOC3NBij3lJivZ3zhTxVq7zn/mywctmn8GsD
         /snFg2iZWhvwuksScDsxIDi4IeJdVHLIa0meUBEZUWWDg++mp7G1fx1d4fMo6TDC1xNh
         E1BQdk+JNb5rIIaCW6DtTNeO6j81Y4+xyPoCO8kQgdbq3bSWGHfLbh4Y3Ekgl6jli6hJ
         F7Teh+RdJ2V6Cd2+BHbUktZJy/kM64KkxR1FPdABIG5G4yFuPzP79FPck/xYTtuko9KI
         lv0dv87DfsonL0OdBh+UOOn7/b7VAJ2qAmaDaaC2tVoMYbeYUNx5KwRX9jbl8rIdk0ZL
         th3g==
X-Forwarded-Encrypted: i=1; AJvYcCVrtSbTNHyu8QxS9ZTrW7IZ1Z3fdOTXsn+doZPBJfN48P9T9EfiWcU0lN6sfLtEbu7+GelVwLdk5HmQ6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdcEz1wKImbNf3vIeG80Ygvih3ADiXiQ8ZxPfvVGYHL/lMpY3y
	ZTSv9KkC1dMqHsnB4laIrbOqiiHSXDkbOlAqdheUdKlGX65/E+ys2lbhCX90HJjbybsLhdR2bJc
	qteRTKg4vZEIM3sr0UyTeZqpkQdjehmw0JhiCA6KzdbCQM4io5oTX+Mc+kAr9PyBoxzg8
X-Gm-Gg: ASbGncuzSt3baGzfgaVySRtZm24NgX+45wDcGUtIHTuY6NrAJymejqKz1MdZoJVM0FB
	ysc/c0F+HoT7mKbbXMSvCPyMQPdxTsI3QO5QCieo7PKiqqvG2CjgC6rQ/aa4m9hWYA/8WKPG4K6
	zrO3drJp27q4i9uxyc0xH21cLGjQxqeCFb8jU8qGGzKw1OB+7FYkXO50/JmtRKFORB+o1B2AEo+
	S4tiA4Qfs0Xq7HZ+gyETwAild4L7WMO6QmuVL44VICJMfB5R0gfxoihdzMftHWKnJ/GGDX3Dtkr
	ihMN5EoaQgAcj1ICzU8LFk9fcPJY+M7K2XVP1SSNCeEvmZILMBg0kk7rDDrZXHq93/kVdnhV6j7
	GUVoDeCapY88JmnHi0TP+BLBG+DneqFS/Z4ciRgYJJW7vQUlg066+4x2zM6lbFA==
X-Received: by 2002:a17:907:97c1:b0:acf:8d:bf9a with SMTP id a640c23a62f3a-ad1e8dbeb9emr432022466b.47.1746638978227;
        Wed, 07 May 2025 10:29:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyUqEP8UVjT8dZuCfbKJ85/XGTluJ+Mph2Mw+fQaZT46JZj0SSrsHM0Chd3wXm+/xc3TNhLQ==
X-Received: by 2002:a17:907:97c1:b0:acf:8d:bf9a with SMTP id a640c23a62f3a-ad1e8dbeb9emr432019366b.47.1746638977627;
        Wed, 07 May 2025 10:29:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891490afsm937731666b.23.2025.05.07.10.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 10:29:37 -0700 (PDT)
Message-ID: <07bc782f-b618-4181-a5e0-a4e8da86c3fc@redhat.com>
Date: Wed, 7 May 2025 19:29:36 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.15-rc1/regression/bisected - commit ffa1e7ada456 introduced
 circular locking dependency at udev-worker
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 homas.hellstrom@linux.intel.com, axboe@kernel.dk,
 linux-block@vger.kernel.org,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Ming Lei <ming.lei@redhat.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <CABXGCsMM3L+9_eGiDxjyhr4s2cW-2m+nntqgA49JS_eN9TEwog@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CABXGCsMM3L+9_eGiDxjyhr4s2cW-2m+nntqgA49JS_eN9TEwog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

On 7-Apr-25 5:57 PM, Mikhail Gavrilov wrote:
> Hi,
> In the new 6.15 release cycle, I spotted a new possible circular
> locking dependency in the kernel log, which was never before.
> 
> [   19.601251] ======================================================
> [   19.601252] WARNING: possible circular locking dependency detected
> [   19.601254] 6.15.0-rc1 #4 Tainted: G        W    L
> [   19.601257] ------------------------------------------------------
> [   19.601258] (udev-worker)/1069 is trying to acquire lock:
> [   19.601260] ffff888188934578 (&q->elevator_lock){+.+.}-{4:4}, at:
> elv_iosched_store+0x17c/0x4e0
> [   19.601272]
>                but task is already holding lock:
> [   19.601273] ffff888188933fe0
> (&q->q_usage_counter(io)#5){++++}-{0:0}, at:
> blk_mq_freeze_queue_nomemsave+0x12/0x20
> [   19.601283]
>                which lock already depends on the new lock.
> 
> [   19.601284]
>                the existing dependency chain (in reverse order) is:
> [   19.601285]
>                -> #2 (&q->q_usage_counter(io)#5){++++}-{0:0}:
> [   19.601290]        __lock_acquire+0x551/0xbb0
> [   19.601294]        lock_acquire.part.0+0xc8/0x270
> [   19.601296]        blk_alloc_queue+0x5ca/0x710
> [   19.601298]        blk_mq_alloc_queue+0x152/0x240
> [   19.601299]        scsi_alloc_sdev+0x85c/0xc90
> [   19.601302]        scsi_probe_and_add_lun+0x4d6/0xbd0
> [   19.601303]        __scsi_scan_target+0x18d/0x3b0
> [   19.601305]        scsi_scan_channel+0xfa/0x1a0
> [   19.601306]        scsi_scan_host_selected+0x1ff/0x2b0
> [   19.601308]        do_scan_async+0x42/0x450
> [   19.601309]        async_run_entry_fn+0x97/0x4f0
> [   19.601311]        process_one_work+0x88d/0x14b0
> [   19.601313]        worker_thread+0x5f3/0xfe0
> [   19.601314]        kthread+0x3b1/0x770
> [   19.601316]        ret_from_fork+0x31/0x70
> [   19.601318]        ret_from_fork_asm+0x1a/0x30
> [   19.601320]
>                -> #1 (fs_reclaim){+.+.}-{0:0}:
> [   19.601322]        __lock_acquire+0x551/0xbb0
> [   19.601324]        lock_acquire.part.0+0xc8/0x270
> [   19.601326]        fs_reclaim_acquire+0xc9/0x110
> [   19.601327]        kmem_cache_alloc_noprof+0x56/0x4d0
> [   19.601329]        __kernfs_new_node+0xcb/0x780
> [   19.601331]        kernfs_new_node+0xef/0x1b0
> [   19.601332]        kernfs_create_dir_ns+0x2b/0x150
> [   19.601334]        sysfs_create_dir_ns+0x130/0x280
> [   19.601335]        kobject_add_internal+0x272/0x800
> [   19.601337]        kobject_add+0x135/0x1a0
> [   19.601339]        elv_register_queue+0xbb/0x220
> [   19.601340]        blk_register_queue+0x31e/0x480
> [   19.601341]        add_disk_fwnode+0x716/0x1030
> [   19.601343]        sd_probe+0x887/0xe30
> [   19.601346]        really_probe+0x1e0/0x8a0
> [   19.601348]        __driver_probe_device+0x18c/0x370
> [   19.601349]        driver_probe_device+0x4a/0x120
> [   19.601350]        __device_attach_driver+0x162/0x270
> [   19.601351]        bus_for_each_drv+0x114/0x1a0
> [   19.601353]        __device_attach_async_helper+0x19e/0x240
> [   19.601354]        async_run_entry_fn+0x97/0x4f0
> [   19.601355]        process_one_work+0x88d/0x14b0
> [   19.601357]        worker_thread+0x5f3/0xfe0
> [   19.601358]        kthread+0x3b1/0x770
> [   19.601360]        ret_from_fork+0x31/0x70
> [   19.601361]        ret_from_fork_asm+0x1a/0x30
> [   19.601362]
>                -> #0 (&q->elevator_lock){+.+.}-{4:4}:
> [   19.601364]        check_prev_add+0xf1/0xcd0
> [   19.601366]        validate_chain+0x463/0x590
> [   19.601367]        __lock_acquire+0x551/0xbb0
> [   19.601368]        lock_acquire.part.0+0xc8/0x270
> [   19.601370]        __mutex_lock+0x1a9/0x1a70
> [   19.601371]        elv_iosched_store+0x17c/0x4e0
> [   19.601373]        queue_attr_store+0x237/0x300
> [   19.601374]        kernfs_fop_write_iter+0x3a0/0x5a0
> [   19.601376]        vfs_write+0x5f8/0xe90
> [   19.601378]        ksys_write+0xf9/0x1c0
> [   19.601379]        do_syscall_64+0x97/0x190
> [   19.601382]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   19.601383]
>                other info that might help us debug this:
> 
> [   19.601384] Chain exists of:
>                  &q->elevator_lock --> fs_reclaim --> &q->q_usage_counter(io)#5
> 
> [   19.601387]  Possible unsafe locking scenario:
> 
> [   19.601387]        CPU0                    CPU1
> [   19.601388]        ----                    ----
> [   19.601388]   lock(&q->q_usage_counter(io)#5);
> [   19.601389]                                lock(fs_reclaim);
> [   19.601391]                                lock(&q->q_usage_counter(io)#5);
> [   19.601392]   lock(&q->elevator_lock);
> [   19.601393]
>                 *** DEADLOCK ***
> 
> [   19.601393] 5 locks held by (udev-worker)/1069:
> [   19.601394]  #0: ffff8881144a2450 (sb_writers#4){.+.+}-{0:0}, at:
> ksys_write+0xf9/0x1c0
> [   19.601399]  #1: ffff88819d1f6090 (&of->mutex#2){+.+.}-{4:4}, at:
> kernfs_fop_write_iter+0x260/0x5a0
> [   19.601402]  #2: ffff888191d42d98 (kn->active#102){.+.+}-{0:0}, at:
> kernfs_fop_write_iter+0x283/0x5a0
> [   19.601406]  #3: ffff888188933fe0
> (&q->q_usage_counter(io)#5){++++}-{0:0}, at:
> blk_mq_freeze_queue_nomemsave+0x12/0x20
> [   19.601410]  #4: ffff888188934020
> (&q->q_usage_counter(queue)#5){++++}-{0:0}, at:
> blk_mq_freeze_queue_nomemsave+0x12/0x20
> [   19.601413]
>                stack backtrace:
> [   19.601415] CPU: 3 UID: 0 PID: 1069 Comm: (udev-worker) Tainted: G
>       W    L      6.15.0-rc1 #4 PREEMPT(lazy)
> [   19.601418] Tainted: [W]=WARN, [L]=SOFTLOCKUP
> [   19.601419] Hardware name: ASUS System Product Name/ROG STRIX
> B650E-I GAMING WIFI, BIOS 3222 03/05/2025
> [   19.601421] Call Trace:
> [   19.601422]  <TASK>
> [   19.601423]  dump_stack_lvl+0x84/0xd0
> [   19.601426]  print_circular_bug.cold+0x38/0x45
> [   19.601428]  check_noncircular+0x148/0x160
> [   19.601431]  check_prev_add+0xf1/0xcd0
> [   19.601433]  validate_chain+0x463/0x590
> [   19.601435]  __lock_acquire+0x551/0xbb0
> [   19.601437]  ? finish_task_switch.isra.0+0x1c5/0x880
> [   19.601439]  lock_acquire.part.0+0xc8/0x270
> [   19.601441]  ? elv_iosched_store+0x17c/0x4e0
> [   19.601442]  ? rcu_is_watching+0x12/0xc0
> [   19.601444]  ? lock_acquire+0xee/0x130
> [   19.601446]  __mutex_lock+0x1a9/0x1a70
> [   19.601447]  ? elv_iosched_store+0x17c/0x4e0
> [   19.601449]  ? elv_iosched_store+0x17c/0x4e0
> [   19.601450]  ? mark_held_locks+0x40/0x70
> [   19.601451]  ? __raw_spin_unlock_irqrestore+0x5d/0x80
> [   19.601453]  ? __pfx___mutex_lock+0x10/0x10
> [   19.601454]  ? __raw_spin_unlock_irqrestore+0x46/0x80
> [   19.601456]  ? blk_mq_freeze_queue_wait+0x15e/0x170
> [   19.601458]  ? __pfx_autoremove_wake_function+0x10/0x10
> [   19.601459]  ? lock_acquire+0xee/0x130
> [   19.601461]  ? elv_iosched_store+0x17c/0x4e0
> [   19.601462]  elv_iosched_store+0x17c/0x4e0
> [   19.601464]  ? __pfx_elv_iosched_store+0x10/0x10
> [   19.601465]  ? kernfs_fop_write_iter+0x260/0x5a0
> [   19.601467]  ? kernfs_fop_write_iter+0x260/0x5a0
> [   19.601469]  ? __pfx_sysfs_kf_write+0x10/0x10
> [   19.601470]  queue_attr_store+0x237/0x300
> [   19.601472]  ? __pfx_queue_attr_store+0x10/0x10
> [   19.601474]  ? __lock_acquire+0x551/0xbb0
> [   19.601476]  ? local_clock_noinstr+0xd/0x100
> [   19.601479]  ? __lock_release.isra.0+0x1a8/0x2f0
> [   19.601481]  ? sysfs_file_kobj+0xb3/0x1c0
> [   19.601483]  ? sysfs_file_kobj+0xbd/0x1c0
> [   19.601485]  ? __pfx_sysfs_kf_write+0x10/0x10
> [   19.601487]  kernfs_fop_write_iter+0x3a0/0x5a0
> [   19.601489]  vfs_write+0x5f8/0xe90
> [   19.601491]  ? __pfx_vfs_write+0x10/0x10
> [   19.601494]  ? __lock_release.isra.0+0x1a8/0x2f0
> [   19.601496]  ksys_write+0xf9/0x1c0
> [   19.601498]  ? __pfx_ksys_write+0x10/0x10
> [   19.601501]  do_syscall_64+0x97/0x190
> [   19.601502]  ? __pfx_sched_clock_cpu+0x10/0x10
> [   19.601505]  ? irqentry_exit_to_user_mode+0xa2/0x290
> [   19.601506]  ? rcu_is_watching+0x12/0xc0
> [   19.601508]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   19.601509] RIP: 0033:0x7f2b95e7d406
> [   19.601514] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75
> 19 83 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45
> 10 0f 05 <48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83
> ec 08
> [   19.601515] RSP: 002b:00007ffe6800fe20 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000001
> [   19.601517] RAX: ffffffffffffffda RBX: 000055a2dbb57460 RCX: 00007f2b95e7d406
> [   19.601518] RDX: 0000000000000003 RSI: 00007ffe68010170 RDI: 0000000000000013
> [   19.601519] RBP: 00007ffe6800fe40 R08: 0000000000000000 R09: 0000000000000000
> [   19.601520] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
> [   19.601521] R13: 0000000000000003 R14: 00007ffe68010170 R15: 00007ffe68010170
> [   19.601527]  </TASK>
> 
> Git bisect find this commit:
> 
> commit ffa1e7ada456087c2402b37cd6b2863ced29aff0
> Author: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Date:   Tue Mar 18 10:55:48 2025 +0100
> 
>     block: Make request_queue lockdep splats show up earlier

<snip>

I'm also seeing a similar lockdep report and I can confirm that reverting
ffa1e7ada456 gets rid of the lockdep report. In my case this is seen
with a rootfs on a eMMC.

But this seems to be ffa1e7ada456 having its intended effect and it looks
like we have one or more actual locking issues in the storage/block layers
which this commit now exposes. Although I guess the locking issues might
be runtime vs driver-probe only in which case these can never happen in
real life ...

Anyways FWIW here is my somewhat different lockdep report:

[   23.950489] ======================================================
[   23.950528] WARNING: possible circular locking dependency detected
[   23.950567] 6.15.0-rc5+ #20 Not tainted
[   23.950594] ------------------------------------------------------
[   23.950631] (udev-worker)/585 is trying to acquire lock:
[   23.950665] ffff8de089926258 (&q->elevator_lock){+.+.}-{4:4}, at: elv_iosched_store+0xce/0x250
[   23.950737] 
               but task is already holding lock:
[   23.950772] ffff8de089925d28 (&q->q_usage_counter(io)){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x12/0x20
[   23.950839] 
               which lock already depends on the new lock.

[   23.950885] 
               the existing dependency chain (in reverse order) is:
[   23.950928] 
               -> #2 (&q->q_usage_counter(io)){++++}-{0:0}:
[   23.950978]        blk_alloc_queue+0x30c/0x350
[   23.951012]        blk_mq_alloc_queue+0x4e/0xb0
[   23.951044]        __blk_mq_alloc_disk+0x14/0x60
[   23.951077]        mmc_alloc_disk+0xd8/0x2e0 [mmc_block]
[   23.951122]        mmc_init_queue+0x120/0x150 [mmc_block]
[   23.951163]        mmc_blk_alloc_req+0xe9/0x300 [mmc_block]
[   23.951202]        mmc_blk_probe+0x188/0x6a0 [mmc_block]
[   23.951242]        really_probe+0xde/0x340
[   23.951273]        __driver_probe_device+0x78/0x140
[   23.951306]        driver_probe_device+0x1f/0xa0
[   23.951338]        __driver_attach+0xcb/0x1e0
[   23.951369]        bus_for_each_dev+0x66/0xa0
[   23.951401]        bus_add_driver+0x10a/0x1f0
[   23.951429]        driver_register+0x71/0xe0
[   23.951460]        0xffffffffc06510bf
[   23.951489]        do_one_initcall+0x57/0x390
[   23.952205]        do_init_module+0x62/0x230
[   23.952924]        __do_sys_init_module+0x164/0x190
[   23.953666]        do_syscall_64+0x92/0x190
[   23.953675]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   23.953680] 
               -> #1 (fs_reclaim){+.+.}-{0:0}:
[   23.953690]        fs_reclaim_acquire+0xa5/0xe0
[   23.953696]        kmem_cache_alloc_noprof+0x37/0x3f0
[   23.953704]        __kernfs_new_node+0x50/0x280
[   23.953710]        kernfs_new_node+0x62/0x90
[   23.953716]        kernfs_create_dir_ns+0x2b/0xa0
[   23.953722]        sysfs_create_dir_ns+0x5d/0xb0
[   23.953727]        kobject_add_internal+0xbc/0x260
[   23.953734]        kobject_add+0x68/0x80
[   23.963542]        elv_register_queue+0x43/0xd0
[   23.963555]        blk_register_queue+0x1ae/0x250
[   23.963562]        add_disk_fwnode+0x2aa/0x490
[   23.963568]        mmc_blk_alloc_req.cold+0x11e/0x174 [mmc_block]
[   23.963582]        mmc_blk_probe+0x188/0x6a0 [mmc_block]
[   23.963590]        really_probe+0xde/0x340
[   23.963597]        __driver_probe_device+0x78/0x140
[   23.963602]        driver_probe_device+0x1f/0xa0
[   23.963606]        __driver_attach+0xcb/0x1e0
[   23.963611]        bus_for_each_dev+0x66/0xa0
[   23.971957]        bus_add_driver+0x10a/0x1f0
[   23.971970]        driver_register+0x71/0xe0
[   23.971976]        0xffffffffc06510bf
[   23.971983]        do_one_initcall+0x57/0x390
[   23.971990]        do_init_module+0x62/0x230
[   23.971995]        __do_sys_init_module+0x164/0x190
[   23.971999]        do_syscall_64+0x92/0x190
[   23.972007]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   23.972012] 
               -> #0 (&q->elevator_lock){+.+.}-{4:4}:
[   23.972024]        __lock_acquire+0x1433/0x2220
[   23.972031]        lock_acquire+0xc9/0x2c0
[   23.972036]        __mutex_lock+0x9f/0xed0
[   23.972043]        elv_iosched_store+0xce/0x250
[   23.972049]        kernfs_fop_write_iter+0x161/0x240
[   23.972055]        vfs_write+0x206/0x550
[   23.972061]        ksys_write+0x5d/0xd0
[   23.972065]        do_syscall_64+0x92/0x190
[   23.972071]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   23.972075] 
               other info that might help us debug this:

[   23.972077] Chain exists of:
                 &q->elevator_lock --> fs_reclaim --> &q->q_usage_counter(io)

[   23.972088]  Possible unsafe locking scenario:

[   23.972089]        CPU0                    CPU1
[   23.972091]        ----                    ----
[   23.972092]   lock(&q->q_usage_counter(io));
[   23.972096]                                lock(fs_reclaim);
[   23.972101]                                lock(&q->q_usage_counter(io));
[   23.972105]   lock(&q->elevator_lock);
[   23.972109] 
                *** DEADLOCK ***

[   23.972110] 5 locks held by (udev-worker)/585:
[   23.972113]  #0: ffff8de0881de420 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x5d/0xd0
[   23.972129]  #1: ffff8de08ba3ea88 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x117/0x240
[   23.972143]  #2: ffff8de0898af9a8 (kn->active#87){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x120/0x240
[   23.972157]  #3: ffff8de089925d28 (&q->q_usage_counter(io)){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x12/0x20
[   23.972171]  #4: ffff8de089925d60 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x12/0x20
[   23.972184] 
               stack backtrace:
[   23.972189] CPU: 3 UID: 0 PID: 585 Comm: (udev-worker) Not tainted 6.15.0-rc5+ #20 PREEMPT(lazy) 
[   23.972195] Hardware name: ASUSTeK COMPUTER INC. T100TA/T100TA, BIOS T100TA.314 08/13/2015
[   23.972198] Call Trace:
[   23.972204]  <TASK>
[   23.972209]  dump_stack_lvl+0x68/0x90
[   23.972220]  print_circular_bug.cold+0x185/0x1d0
[   23.972230]  check_noncircular+0x10f/0x130
[   23.972242]  __lock_acquire+0x1433/0x2220
[   23.972254]  lock_acquire+0xc9/0x2c0
[   23.972260]  ? elv_iosched_store+0xce/0x250
[   23.972272]  __mutex_lock+0x9f/0xed0
[   23.972278]  ? elv_iosched_store+0xce/0x250
[   23.972285]  ? mark_held_locks+0x40/0x70
[   23.972291]  ? elv_iosched_store+0xce/0x250
[   23.972297]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[   23.972303]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[   23.972312]  ? elv_iosched_store+0xce/0x250
[   23.972318]  elv_iosched_store+0xce/0x250
[   23.972327]  kernfs_fop_write_iter+0x161/0x240
[   23.972335]  vfs_write+0x206/0x550
[   23.972340]  ? find_held_lock+0x2b/0x80
[   23.972351]  ksys_write+0x5d/0xd0
[   23.972359]  do_syscall_64+0x92/0x190
[   23.972365]  ? lock_release+0x1a0/0x2d0
[   23.972374]  ? lock_acquire+0xc9/0x2c0
[   23.972380]  ? ktime_get_coarse_real_ts64+0xe/0x60
[   23.972387]  ? find_held_lock+0x2b/0x80
[   23.972391]  ? file_has_perm+0x78/0xb0
[   23.972400]  ? ktime_get_coarse_real_ts64+0xe/0x60
[   23.972412]  ? lockdep_hardirqs_on+0x88/0x130
[   23.972418]  ? do_syscall_64+0x9f/0x190
[   23.972422]  ? do_syscall_64+0x9f/0x190
[   23.972430]  ? __lock_acquire+0x40a/0x2220
[   23.972437]  ? __lock_acquire+0x40a/0x2220
[   23.972446]  ? lock_is_held_type+0xd5/0x140
[   23.972453]  ? lock_is_held_type+0xd5/0x140
[   23.972458]  ? find_held_lock+0x2b/0x80
[   23.972463]  ? note_gp_changes+0x99/0xd0
[   23.972469]  ? lock_release+0x1a0/0x2d0
[   23.972475]  ? rcu_gpnum_ovf+0x7d/0x90
[   23.972480]  ? lock_is_held_type+0xd5/0x140
[   23.972488]  ? sched_clock+0xc/0x30
[   23.972493]  ? sched_clock_cpu+0xd/0x1e0
[   23.972501]  ? irqtime_account_irq+0x96/0x100
[   23.972508]  ? lockdep_softirqs_on+0xc3/0x140
[   23.972514]  ? __irq_exit_rcu+0xe8/0x160
[   23.972520]  ? handle_softirqs+0x44d/0x470
[   23.972532]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   23.972538] RIP: 0033:0x7f4910ef4484
[   23.972545] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d 45 9c 10 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
[   23.972549] RSP: 002b:00007ffe5ffc4ee8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   23.972554] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f4910ef4484
[   23.972557] RDX: 0000000000000003 RSI: 00007ffe5ffc51f0 RDI: 000000000000001a
[   23.972560] RBP: 00007ffe5ffc4f10 R08: 00007f4910ff51c8 R09: 00007ffe5ffc4fc0
[   23.972562] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
[   23.972565] R13: 00007ffe5ffc51f0 R14: 000055788a41db00 R15: 00007f4910ff4e80
[   23.972577]  </TASK>

Regards,

Hans


