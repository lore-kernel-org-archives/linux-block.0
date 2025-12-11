Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6324F2B2DA
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765467676; cv=none; b=LdPkZKo/V8/0+S92Fc99C93MkRVEMenrw+Acutyp+fKSUkLTAGl0EbKwEjNtWQVoniJRrq1qJ559UH2e8pdNXQ/nEBQa9b312X+X7TYecdD+HGugEh+JbKzTtTp10gy8JKGcAZQFHKkKp1lqQ5ey4RrY8cdn5sL5zloQyL01WVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765467676; c=relaxed/simple;
	bh=SaB39Sm838IRcMkPaQCtYmFLXFa0M/h3ao9ihOdaLD8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZEII1wb3+dhYFJC734b9xDLjQpKjNb6Sj1CeBhUdffLfbTlOKYFoaZXwUx94uEPIZgfvT2L+4cb4bBU1Hpvdld3InEUurcwbLr5+aTVaQQvwWneTiZeApr6O7hOYHzoZwONgGmZGHsICfRf1sfrC1aWibLXDlXiZRaZi4jpHF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCVJCrdM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HTHV4Q7m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCVJCrdM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTHV4Q7m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765467672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XER0gi0P9Eu2O/l3YIJe5+k6MYwx2x081H2m6084ITg=;
	b=SCVJCrdMCMXTSsyS1ro8KcBVfbXyZXDmxMsOL9KVW6TBCQhZapMF/h4XDPIRese94i/JDp
	O3wpbgtbg0dpVTFvDI/JWn/dyaq6qiahqzl9Pm+H7zdx0ayF341Gf2YF9tBedkpRADPKxn
	fbUL9VpXG9Xacy92iNuxywVuHv/mLRA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-PljbuHZ4PC2-RtbtEPRohQ-1; Thu, 11 Dec 2025 10:41:10 -0500
X-MC-Unique: PljbuHZ4PC2-RtbtEPRohQ-1
X-Mimecast-MFC-AGG-ID: PljbuHZ4PC2-RtbtEPRohQ_1765467669
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-37fa2c5c374so1308901fa.2
        for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 07:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765467666; x=1766072466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XER0gi0P9Eu2O/l3YIJe5+k6MYwx2x081H2m6084ITg=;
        b=HTHV4Q7mEET5Wa0RvKxHhChax2GnZzW70/SrejDKrTXfBJiLn/z3vZ4x8PJz9LmMtC
         4KAaROD0EU+GpTbQJqPpo+l+bXB4vtUcxr5S6RsvENDzGoGW600XmxM8rKhlcfNsJJhk
         LX7W8uwf0rgiy8RS4tGLmlE1/yQuYMigHZCvGoK0SLzYONn5f3t+ZfSvteS/Jd7OIdwT
         OvQUyvoziZ5YHMPLLwaz2+MfAV5IsUaLujViYKOmgQYHExLqvhSpJBlhlDM2XjjLa3/9
         c1wMEAhEwCzIziiIzeseXfHCDfdQF8s4CjEGvcdweAGW8P09d16OdE8NiE+miVdcfsyl
         qJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765467666; x=1766072466;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XER0gi0P9Eu2O/l3YIJe5+k6MYwx2x081H2m6084ITg=;
        b=LQbH/fWvcEk925/uYN92gEfvSHoUB2MpkhOUK5d1H6BRbyiBLb5pSjn7YbHg9e0S90
         ryCKNdvNDNZbzHA3+MiFhVbq+cgnjnqta/Rw+wvtSAe9C3NhV1wnHqsoC9wkezEjLfpU
         HjzbMpsJ+iMDr9Wzp7hxbsFNJEXQJ54IJfP1zuvxoeA5UlJ2RBB7/cEsGFY4h5zUvfdo
         OYq80hdDq9IDwT6x2QLO2s7+MvPdQCALM3u54Jkny2fpD84hrEg8IAQS97ADgDKePxg1
         4wpWdL9OZTPiYJ2Qcfa0u9ye0v7TTrhcB2ObqzBNkYiwVcyAZq7kWlHX04yRSp6EQEwN
         eAxg==
X-Gm-Message-State: AOJu0YwX0jqr042B6s82Zad+oTRyJCA67IgC71n3oSevnzlfmbKWf5em
	26NPzK7CdKCMy2tCK5t5q/AxuPoDxlp2sZGSL74AxDV51X92XbcokEVK6ggTPSxF9s+v0gSqXiN
	45/6vcyvz8bAb7T+CwAolZLm69+SONvvijtre+jWa83zucAgqVmAGQU4nQ1G+DCQovmQ4o8eFES
	tUX/iOjEMAz4fvYxNs6XoFgis6C2H7hT0pOZpd6YF9V+PKpb0ADWqd
X-Gm-Gg: AY/fxX6Wd1DlKH7xnI4CCBWOjMrcU/HRv2hikw+Iudjb7k5wPa8BHcner2uCx44En9t
	vJo9aqNOl4J2j2+DaYxuA5L/D9uQyxqgdUNJyIMY1s2dki7RgezYVUyofqkNQzvF73O2ovOYOvX
	C0PFvDr0825mUtihFWc6KppoPhv1exvnQJWc0Ul1IIw4FiBugSrwo4HPWF/Jl4rHVr6BE=
X-Received: by 2002:a05:651c:1508:b0:37a:455e:f2fc with SMTP id 38308e7fff4ca-37fb2152acamr18379521fa.43.1765467666295;
        Thu, 11 Dec 2025 07:41:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV+wr655qzsjqLP7T1IVlB6YclIVXoe1Iz43J9qZE7N/ayL5NczpGkFZpArOkCiHpM7gRdcQUFwDYgUfFcJOA=
X-Received: by 2002:a05:651c:1508:b0:37a:455e:f2fc with SMTP id
 38308e7fff4ca-37fb2152acamr18379411fa.43.1765467665839; Thu, 11 Dec 2025
 07:41:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 11 Dec 2025 23:40:52 +0800
X-Gm-Features: AQt7F2pT_YFn9Ij3s8QGwKq_vywEOzVerk7FehyBknEkeqIpDyo0RNj-5CNMzs8
Message-ID: <CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com>
Subject: [bug report] kmemleak observed during blktests nvme/fc
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"

Hi
The following kmemleak was observed during blktests nvme/fc, please
help check it and let me know if you need any info/test for it,
thanks.

commit d678712ead7318d5650158aa00113f63ccd4e210
Merge: 95ed689e9f30 a0750fae73c5
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Dec 10 13:41:17 2025 -0700

    Merge branch 'block-6.19' into for-next

    * block-6.19:
      blk-mq-dma: always initialize dma state

# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff88826cab51c0 (size 2488):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    60 1a be c1 ff ff ff ff c0 2b 05 73 77 60 00 00  `........+.sw`..
  backtrace (crc 155ec6c5):
    kmem_cache_alloc_node_noprof+0x5e4/0x830
    blk_alloc_queue+0x30/0x700
    blk_mq_alloc_queue+0x14b/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8883428ec400 (size 96):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 32 bytes):
    00 c4 8e 42 83 88 ff ff 00 c4 8e 42 83 88 ff ff  ...B.......B....
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
  backtrace (crc 1deeea82):
    __kmalloc_cache_noprof+0x5de/0x820
    blk_alloc_queue_stats+0x3f/0x100
    blk_alloc_queue+0xc0/0x700
    blk_mq_alloc_queue+0x14b/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object (percpu) 0x60777301a898 (size 8):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 8 bytes on cpu 9):
    00 00 00 00 00 00 00 00                          ........
  backtrace (crc 0):
    pcpu_alloc_noprof+0x5e0/0xf10
    percpu_ref_init+0x2c/0x330
    blk_alloc_queue+0x533/0x700
    blk_mq_alloc_queue+0x14b/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8881a20fbf80 (size 64):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 80 9e db 8f ff ff ff ff  ................
    00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00  ................
  backtrace (crc 8cfdd87d):
    __kmalloc_cache_noprof+0x5de/0x820
    percpu_ref_init+0xbf/0x330
    blk_alloc_queue+0x533/0x700
    blk_mq_alloc_queue+0x14b/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8883428ec600 (size 96):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 c6 8e 42 83 88 ff ff  ...........B....
    08 c6 8e 42 83 88 ff ff 00 00 00 00 00 00 00 00  ...B............
  backtrace (crc af4dc711):
    __kmalloc_cache_noprof+0x5de/0x820
    blk_mq_init_allocated_queue+0xce/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object (percpu) 0x607773052bc0 (size 256):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 32 bytes on cpu 9):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff 60 3c 17 97 ff ff ff ff  ........`<......
  backtrace (crc ce57ad5e):
    pcpu_alloc_noprof+0x5e0/0xf10
    blk_mq_init_allocated_queue+0xf0/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8881459079e0 (size 8):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 8 bytes):
    00 a0 9e 43 82 88 ff ff                          ...C....
  backtrace (crc 69c4a0b3):
    __kmalloc_node_noprof+0x6ab/0x970
    __blk_mq_realloc_hw_ctxs+0x361/0x5a0
    blk_mq_init_allocated_queue+0x2e9/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8882439ea000 (size 1024):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff e0 3c 17 97 ff ff ff ff  .........<......
  backtrace (crc 66835ea5):
    __kmalloc_cache_node_noprof+0x5f9/0x840
    blk_mq_alloc_hctx+0x52/0x810
    blk_mq_alloc_and_init_hctx+0x5b9/0x840
    __blk_mq_realloc_hw_ctxs+0x20a/0x5a0
    blk_mq_init_allocated_queue+0x2e9/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8881459072a0 (size 8):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 8 bytes):
    ff ff 00 00 00 00 00 00                          ........
  backtrace (crc b47d4cd6):
    __kmalloc_node_noprof+0x6ab/0x970
    alloc_cpumask_var_node+0x56/0xb0
    blk_mq_alloc_hctx+0x74/0x810
    blk_mq_alloc_and_init_hctx+0x5b9/0x840
    __blk_mq_realloc_hw_ctxs+0x20a/0x5a0
    blk_mq_init_allocated_queue+0x2e9/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff88814b47b400 (size 128):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 32 bytes):
    c0 6b f1 fb ff e8 ff ff c0 6b 31 fc ff e8 ff ff  .k.......k1.....
    c0 6b 71 fc ff e8 ff ff c0 6b b1 fc ff e8 ff ff  .kq......k......
  backtrace (crc d04b4dbc):
    __kmalloc_node_noprof+0x6ab/0x970
    blk_mq_alloc_hctx+0x43a/0x810
    blk_mq_alloc_and_init_hctx+0x5b9/0x840
    __blk_mq_realloc_hw_ctxs+0x20a/0x5a0
    blk_mq_init_allocated_queue+0x2e9/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff888256326c00 (size 512):
  comm "nvme", pid 84134, jiffies 4304631753
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a9e88d35):
    __kvmalloc_node_noprof+0x814/0xb30
    sbitmap_init_node+0x184/0x730
    blk_mq_alloc_hctx+0x4b3/0x810
    blk_mq_alloc_and_init_hctx+0x5b9/0x840
    __blk_mq_realloc_hw_ctxs+0x20a/0x5a0
    blk_mq_init_allocated_queue+0x2e9/0x1210
    blk_mq_alloc_queue+0x17f/0x230
    nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
    0xffffffffc11de07f
    0xffffffffc11dfc28
    nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
    nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
    vfs_write+0x1d0/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x95/0x520
    entry_SYSCALL_64_after_hwframe+0x76/0x7e



-- 
Best Regards,
  Yi Zhang

