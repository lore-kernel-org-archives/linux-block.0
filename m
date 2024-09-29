Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7177B5680
	for <linux-block@vger.kernel.org>; Sun, 29 Sep 2024 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727620870; cv=none; b=k8tmFFA6K1LxjtRVgVT1PUZi2R6E3Txwas2HLQXlXclYk7UKl0yerq+Or3+x1IQsQFt4aB+WECGJjzJMdGzbK7rXO99ibDmbfCDLsAguHVvjjTxbrxNxdCtXAO2mrbEqeH957Pmfu26AJkTOkn3YnZ1plx1V0AXqFUlQ8YZvy+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727620870; c=relaxed/simple;
	bh=I0gAQcMvlsgjwIQSwIaZF/C0GN5LaL4Pz92DsGRPjk4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JwQ4RIT39sS863yFHw+9rIMis5lABw72Iqqp93535oWJf03gMIGRIYJDdZ13sclkuBmtoReVDD7zG7scTCJNhCL1ti1dulKwu08cwaminE2YrNwSlcHiE4ju4nHGMymScI6116UBQ/oglOSmBdm0TUr5WZt9yB+7YxChMJdq6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=il2eXk4U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="il2eXk4U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727620866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=NqHZZaOqWeNqajWykkvWXi1sZz7X8XzfOjglQje9A5I=;
	b=il2eXk4UThuUFzwcAXA6WST8SAg814+AYu8yQ/o0TS05eKa+owMrAErwa5Cniee+3rz/WL
	+kkFnV2Ony3lVxRoMG3bEJU04aohssjwxjmk5PajmhSArjKb6IJFQuUcp3mypcCeR1GjXT
	euKz/Vm9Mu4zeXkd64FKhIogr0z4OkU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-LTJKR5bvPkKxDs4_RuvsSA-1; Sun, 29 Sep 2024 10:41:04 -0400
X-MC-Unique: LTJKR5bvPkKxDs4_RuvsSA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d8e7e427d5so3386299a91.0
        for <linux-block@vger.kernel.org>; Sun, 29 Sep 2024 07:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727620862; x=1728225662;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqHZZaOqWeNqajWykkvWXi1sZz7X8XzfOjglQje9A5I=;
        b=Dv6gDGXj5L4Enli4VAfua92f1PZ30LEe7sWBR+fqte3EXLpQDbPkvNjMuRCduWAPwt
         jo1jR4VzOPU8/Vnl7rJOpZzvw9gIKQ8UUrNMvmhqM26KTlopPP7lh8O8Bk4k22JFwQuv
         SrCfESDhgo2ItJk6U59/1ftQXnrfMDln3Ce32c2jbMaumgithyhTGVopsikLJgx5CnSq
         2Wb9SfaMGAJ2WwRlzPvuDUSB6B6KlzpLtCWTJ53Hh7Q6oQxXBPSOvtFJlZIX5RQ/02AH
         tQB4L1zaVnmXzbAi8wGMKBXopwqHhHNXPxueC3E9NaaxmyhfNLkTFbOIpA9r553h7W4j
         c9mQ==
X-Gm-Message-State: AOJu0YxD7PhAq4s8L8Lf/sPYix8JiXJcKmnNjKLKT1FEQqd22jUtMVFV
	arzdzUEJ/X/1WTGFQeaOaJ6LttAZLNYYQUpxVLiciTGthnUvsgDcDjs9njBwHx6rtdhM88Muxj5
	YHFvIKLeYJgjift+NgaExpNW7nKGkHCBZvPdBawsBav27MgnhXDzfBrddmYQFmHQy8i5ipHxvyN
	aOtHd615ZC/MgxWxkEayTv7GqYDLOyRDskSCV7gS1AWe/j5fMp
X-Received: by 2002:a17:90a:c287:b0:2c9:5a71:1500 with SMTP id 98e67ed59e1d1-2e0b6fa0cd5mr15315069a91.0.1727620861719;
        Sun, 29 Sep 2024 07:41:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5qQPrRepdBsI+NHO0QoF3oJcpqSwM8trt/yNZgMyC07vbUyUvUz6oq9+oJruKFjfqSJf+JY+oqOuu/Wynv8o=
X-Received: by 2002:a17:90a:c287:b0:2c9:5a71:1500 with SMTP id
 98e67ed59e1d1-2e0b6fa0cd5mr15315052a91.0.1727620861351; Sun, 29 Sep 2024
 07:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sun, 29 Sep 2024 22:40:49 +0800
Message-ID: <CAHj4cs9YCCcfmdxN43-9H3HnTYQsRtTYw1Kzq-L468GfLKAENA@mail.gmail.com>
Subject: [bug report] kmemleak observed after blktests block/001
To: linux-block <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"

Hello

The kmemleak issue was easily triggered during blktests block/001 on
the latest linux-block/for-next,
please help check it and let me know if you need any info/test for it, thanks.


$ cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff888cc28666c0 (size 32):
  comm "modprobe", pid 11054, jiffies 4305180646
  hex dump (first 32 bytes):
    73 64 65 62 75 67 5f 71 75 65 75 65 64 5f 63 6d  sdebug_queued_cm
    64 00 a6 02 7d c0 f5 04 00 00 00 00 00 00 00 00  d...}...........
  backtrace (crc 6250ed84):
    [<ffffffffb378fa9b>] __kmalloc_node_track_caller_noprof+0x36b/0x440
    [<ffffffffb36513a6>] kstrdup+0x36/0x60
    [<ffffffffb5555d13>] kobject_set_name_vargs+0x43/0x120
    [<ffffffffb555639b>] kobject_init_and_add+0xdb/0x160
    [<ffffffffb378f6c4>] sysfs_slab_add+0x194/0x1f0
    [<ffffffffb3792286>] do_kmem_cache_create+0x256/0x2c0
    [<ffffffffb367436f>] __kmem_cache_create_args+0x20f/0x310
    [<ffffffffc36f45b8>] null_init+0x5a8/0xff0 [null_blk]
    [<ffffffffb2c03cec>] do_one_initcall+0x11c/0x5c0
    [<ffffffffb30da9e8>] do_init_module+0x238/0x790
    [<ffffffffb30de801>] init_module_from_file+0xd1/0x130
    [<ffffffffb30deaa0>] idempotent_init_module+0x230/0x770
    [<ffffffffb30df25e>] __x64_sys_finit_module+0xbe/0x130
    [<ffffffffb56bba12>] do_syscall_64+0x92/0x180
    [<ffffffffb580012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff888c82cf69c0 (size 32):
  comm "modprobe", pid 11104, jiffies 4305186132
  hex dump (first 32 bytes):
    73 64 65 62 75 67 5f 71 75 65 75 65 64 5f 63 6d  sdebug_queued_cm
    64 00 ef 42 3d 89 fa 04 40 68 1d 36 00 ea ff ff  d..B=...@h.6....
  backtrace (crc 46e1640c):
    [<ffffffffb378fa9b>] __kmalloc_node_track_caller_noprof+0x36b/0x440
    [<ffffffffb36513a6>] kstrdup+0x36/0x60
    [<ffffffffb5555d13>] kobject_set_name_vargs+0x43/0x120
    [<ffffffffb555639b>] kobject_init_and_add+0xdb/0x160
    [<ffffffffb378f6c4>] sysfs_slab_add+0x194/0x1f0
    [<ffffffffb3792286>] do_kmem_cache_create+0x256/0x2c0
    [<ffffffffb367436f>] __kmem_cache_create_args+0x20f/0x310
    [<ffffffffc36f65b8>] 0xffffffffc36f65b8
    [<ffffffffb2c03cec>] do_one_initcall+0x11c/0x5c0
    [<ffffffffb30da9e8>] do_init_module+0x238/0x790
    [<ffffffffb30de801>] init_module_from_file+0xd1/0x130
    [<ffffffffb30deaa0>] idempotent_init_module+0x230/0x770
    [<ffffffffb30df25e>] __x64_sys_finit_module+0xbe/0x130
    [<ffffffffb56bba12>] do_syscall_64+0x92/0x180
    [<ffffffffb580012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff888c49ee9700 (size 32):
  comm "modprobe", pid 12268, jiffies 4305219508
  hex dump (first 32 bytes):
    73 64 65 62 75 67 5f 71 75 65 75 65 64 5f 63 6d  sdebug_queued_cm
    64 00 ce 89 f6 a8 04 c4 00 00 00 00 00 00 00 00  d...............
  backtrace (crc 267cbe53):
    [<ffffffffb378fa9b>] __kmalloc_node_track_caller_noprof+0x36b/0x440
    [<ffffffffb36513a6>] kstrdup+0x36/0x60
    [<ffffffffb5555d13>] kobject_set_name_vargs+0x43/0x120
    [<ffffffffb555639b>] kobject_init_and_add+0xdb/0x160
    [<ffffffffb378f6c4>] sysfs_slab_add+0x194/0x1f0
    [<ffffffffb3792286>] do_kmem_cache_create+0x256/0x2c0
    [<ffffffffb367436f>] __kmem_cache_create_args+0x20f/0x310
    [<ffffffffc36f65b8>] 0xffffffffc36f65b8
    [<ffffffffb2c03cec>] do_one_initcall+0x11c/0x5c0
    [<ffffffffb30da9e8>] do_init_module+0x238/0x790
    [<ffffffffb30de801>] init_module_from_file+0xd1/0x130
    [<ffffffffb30deaa0>] idempotent_init_module+0x230/0x770
    [<ffffffffb30df25e>] __x64_sys_finit_module+0xbe/0x130
    [<ffffffffb56bba12>] do_syscall_64+0x92/0x180
    [<ffffffffb580012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e



--
Best Regards,
  Yi Zhang

