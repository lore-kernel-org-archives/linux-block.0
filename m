Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4916328682
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 01:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752630163; cv=none; b=dzE96VhGfXsCwxcQJVWG3xqrC8rSp+wakLxI1EWWwwvGjUAhBvGM9LloSG3rZjzblre0KqDazGQo19SOTM2Hp3YRJPkAsUuhY1qgo3uWfCimqGFa39hAKYJ0buzKMl8TsCtpywhUbeuSUtR7C9P5lRkOt4DnEIFaFY44LPNg3DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752630163; c=relaxed/simple;
	bh=aoGxpPICNXP/SKP+lXk7Yl+ZJYHClfB6xnbLfoDT38Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qNO1ggeGm5TMXxn5xeoC0l6RJew8WJrX1v8mWnYtRKO/7gu6wp5YRU27UeZ5fKqh6j31T6M54HbwtoRckPAl0nTjZCjfTfyE4Mkc3SyV6XPQUbR0dFgpdogB2jugusWG6jJRKXv0UPL8JhBz6yh7il/7x1E/E3IpIJCaNZnNy9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LuhRkT7E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LuhRkT7E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752630159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=LwaS2TQ4VNQtddgLCiYfhvgAXj+19w1LppF4JjvPLaw=;
	b=LuhRkT7EZm7sy5i40ACqmC/YB2IR1krGF6CkWKJYneJXNNBjdIdZPCCPGks74cZ5Y39NXW
	XC75LloMsNkroB7caRVZcMY1w8ax2857N2bDZBIpknXprjyBuEDyiwmqj+pGKuM2beNADx
	gFBvysSCln9F5Laa2GHvAGaHAQDVMe8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-bQrnmRGFOv--CoG8AQDRGQ-1; Tue, 15 Jul 2025 21:42:37 -0400
X-MC-Unique: bQrnmRGFOv--CoG8AQDRGQ-1
X-Mimecast-MFC-AGG-ID: bQrnmRGFOv--CoG8AQDRGQ_1752630155
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-557e35aad50so3426279e87.0
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 18:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752630153; x=1753234953;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LwaS2TQ4VNQtddgLCiYfhvgAXj+19w1LppF4JjvPLaw=;
        b=JrrhzSlutAvNp+3A2LQNTaeMEc4VdpS5pIv/WX2r/pqQjjrHLh+zn7AYDbdnboyVy9
         wHdo97Zzfa9dw/TgGtUd54QrX1+jexL4qDQWU2PGvRZx1/1ImKfezRFXksgILI2FcGY0
         D/8tYuuveyKP7ZNAdhYT6FJfN/oRbWC6ybUg54vE3clu4nbRfEt9cXcY5RdF+1osS5o8
         q5SXHZtRi6xEQPqI6KE+XleS1kAQjIgkUMHyP7hQt9+qHCkFIqTXnPjdRA72w9NRTSyu
         mqQOP8xa5mprycUgghktozPP32OOR5jfpn0K1gT0HwtAg/1IX9puApX1WVRibhwSf8MJ
         j3dQ==
X-Gm-Message-State: AOJu0YxtYpItfiBUJc8r2L2IaT0V6Si3NuOOLHA3lEltGiAtU1caVg3m
	LSj3tyZ95aiDWXl7ZuE2aj2M0obAq0oQoWQBNTUgKAGk64oTMCIfnaM4kRwNjqn4Bu14R+7HWEH
	KKdcyFwQymWpWym8hxXrwq0JKFk4B7oNoUhRiYnNb9KP/mvMNcIqXj8cyygU+z1xHpqbe542ZO3
	u5z2hF6lDBtDrGUYVN7kq/6H3KyyW2jzkz1kmpc3abOgkljIeVaGHA
X-Gm-Gg: ASbGncvw3okyuVGx23R30R/ei29C8IAmdhAmarKlZIHgrK7AhKryV58TthhtJ19ngbZ
	+MilTDAa21/hfFndGCWmQrNnyb+JLtNRazp18blPLLxU+yuQ+anfmWTcLQH7VyByd5/Ye/i36cu
	h6LzZkUVmVd21yUPRC3Om+mw==
X-Received: by 2002:a05:651c:40d5:b0:32b:8778:6f0a with SMTP id 38308e7fff4ca-3308f5dbdd0mr1804571fa.27.1752630152539;
        Tue, 15 Jul 2025 18:42:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwNp75bF46OKB07gkqJv4a30lZh84X0uLU7eM5S/mV1N9plzP4GortmbPAy2rI76mDAh4Ss6Q2KwOaMuA3xOA=
X-Received: by 2002:a05:651c:40d5:b0:32b:8778:6f0a with SMTP id
 38308e7fff4ca-3308f5dbdd0mr1804541fa.27.1752630152122; Tue, 15 Jul 2025
 18:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 16 Jul 2025 09:42:20 +0800
X-Gm-Features: Ac12FXw7xQ0Z8ftSEYgSDR5BIlxk9LxN0CiUiJIq22z82xiotrIRgWzgnzzUWgU
Message-ID: <CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com>
Subject: [bug report] kmemleak issue observed during blktests
To: linux-block <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

Hi

I found the following kmemleak issue on the latest
linux-block/for-next, please help check it and let me know if you need
any info/testing for it, thanks.

commit: linux-block/for-next: 8192f418ee2f (HEAD -> for-next,
origin/for-next) Merge branch 'for-6.17/io_uring' into for-next

# dmesg | grep kmemleak
[31404.993877] kmemleak: 608 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)

unreferenced object 0xffff8882e7fb9000 (size 2048):
  comm "check", pid 10460, jiffies 4324980514
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc c47e6a37):
    __kvmalloc_node_noprof+0x55d/0x7a0
    sbitmap_init_node+0x15a/0x6a0
    kyber_init_hctx+0x316/0xb90
    blk_mq_init_sched+0x416/0x580
    elevator_switch+0x18b/0x630
    elv_update_nr_hw_queues+0x219/0x2c0
    __blk_mq_update_nr_hw_queues+0x36a/0x6f0
    blk_mq_update_nr_hw_queues+0x3a/0x60
    find_fallback+0x510/0x540 [nbd]
    nbd_send_cmd+0x24b/0x1480 [nbd]
    configfs_write_iter+0x2ae/0x470
    vfs_write+0x524/0xe70
    ksys_write+0xff/0x200
    do_syscall_64+0x98/0x3c0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8882e7fbb000 (size 2048):
  comm "check", pid 10460, jiffies 4324980514
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc c47e6a37):
    __kvmalloc_node_noprof+0x55d/0x7a0
    sbitmap_init_node+0x15a/0x6a0
    kyber_init_hctx+0x316/0xb90
    blk_mq_init_sched+0x416/0x580
    elevator_switch+0x18b/0x630
    elv_update_nr_hw_queues+0x219/0x2c0
    __blk_mq_update_nr_hw_queues+0x36a/0x6f0
    blk_mq_update_nr_hw_queues+0x3a/0x60
    find_fallback+0x510/0x540 [nbd]
    nbd_send_cmd+0x24b/0x1480 [nbd]
    configfs_write_iter+0x2ae/0x470
    vfs_write+0x524/0xe70
    ksys_write+0xff/0x200
    do_syscall_64+0x98/0x3c0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff88819e855000 (size 2048):
  comm "check", pid 10460, jiffies 4324980514
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc c47e6a37):
    __kvmalloc_node_noprof+0x55d/0x7a0
    sbitmap_init_node+0x15a/0x6a0
    kyber_init_hctx+0x316/0xb90
    blk_mq_init_sched+0x416/0x580
    elevator_switch+0x18b/0x630
    elv_update_nr_hw_queues+0x219/0x2c0
    __blk_mq_update_nr_hw_queues+0x36a/0x6f0
    blk_mq_update_nr_hw_queues+0x3a/0x60
    find_fallback+0x510/0x540 [nbd]
    nbd_send_cmd+0x24b/0x1480 [nbd]
    configfs_write_iter+0x2ae/0x470
    vfs_write+0x524/0xe70
    ksys_write+0xff/0x200
    do_syscall_64+0x98/0x3c0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e


-- 
Best Regards,
  Yi Zhang

