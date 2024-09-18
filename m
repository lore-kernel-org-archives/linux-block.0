Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8608A8493
	for <linux-block@vger.kernel.org>; Wed, 18 Sep 2024 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726675790; cv=none; b=WktNHcO48gQM4TRHy7gHHlMEy9NU/IAor4hzLB/UXbtNe274YLvyQLgMJqA+IzY6qqvUM9etwDH0Vqi+9lRNK8Ji7RJbhNiKTT+NThS7T1uQOQP1q+TresRcoi8E32Sdl4PrypiT1WbsYhjp8ji/ystcBN+DneTOy+mjJ/HqveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726675790; c=relaxed/simple;
	bh=6+4mfFUyZ3Zvi0DcRUP2wu4k3YgyKU3IIqPSQqHkO0w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=msLM9vDdxfi0rj2h5RVrSoWNNexVYGErFqK+xNwLcNiGY0ng5sPR6GDZAvArOfoKMaBLD7XgjyK/O45OOWW4kdtPDZLKHwreSnegBpLzEkbWLcUedmP9ENDYGlREUYEKINC1kmTmx+RhL4W9NwiqGer3Z3xsuBpUVc56taQUHbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CL/oL7lf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CL/oL7lf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726675787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bzxpKNdEzL66u3mMawPHAbJ94NRKmQ8CbAuJzjAM4SM=;
	b=CL/oL7lfz/r9UrpEUS7iwpDBlsaaVyTW5GD1npE/V8fHyvR6cL6ItQdCwcpWIo2KemXvQK
	rQpJMXKlN5TtUC1DLdax1cFwfECak9Ap0DOHckr6TakXghKKLqerIMXa4NzX29Otw/gIVp
	9GtRmi+5EMoMgEOvn2uhvq43+46ICQg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-qbdE8xFvPcS4GF7ggNVhVQ-1; Wed, 18 Sep 2024 12:09:46 -0400
X-MC-Unique: qbdE8xFvPcS4GF7ggNVhVQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d86e9da90cso7548939a91.2
        for <linux-block@vger.kernel.org>; Wed, 18 Sep 2024 09:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726675784; x=1727280584;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzxpKNdEzL66u3mMawPHAbJ94NRKmQ8CbAuJzjAM4SM=;
        b=JemSwoazOr6HCZ7re46QgLEHbBxwVP2zrr541aLpKd8YT4Sl0MN+qn1oh6GbelYyAx
         YhFZHWsr3KqamO+1xxESdcXCKaDhScnoSKLPrijMGVjEysrRn01QMClwMyd1Stgi1DKY
         drcv14dVYQCBF+5gpygnBupNkxTKJ2K9Wq9rc/aCzTZZDIaJihKGZkqlVneCMIwYyiM+
         WfBetYCjDO3OGQSVf6SMGaDma23bZD/7EmjkyXBKtHW9xy0PhES5QaIV8X4TQ2un1Ohz
         pLVWyALQV13ZS7lDyGidLJXgQVdWGExhYLjsUL0IXPV0IlGKnRna8AnbpK/2GccGvstk
         yajQ==
X-Gm-Message-State: AOJu0Yzhat2lSi0JXLXcTvEIITzMmt4NSQ4wd+Ti9ZYiPiV0S/AM/aay
	8imUDmTry86tcStMrCDCtvGT2eMT5Rm5YiHCXyZ7XSgcmvWOvJXUsVPYCk83iG6Dw8XrgCWKEJA
	OfrEb7o6o1xuqio8951ot66Sw/8E2gxXnpVZySx3fl4F9G4DIh5zyHH4BXOYSkBcHmi2eh8T6V4
	xR8HxAgd2J9BPyYylIJ7doEtbkQfTjUHY5ojaCuSPPf9SeA3Dj
X-Received: by 2002:a17:90b:4c0c:b0:2d3:c0e5:cbac with SMTP id 98e67ed59e1d1-2db9ffa11e4mr26842423a91.7.1726675784064;
        Wed, 18 Sep 2024 09:09:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH58SJqTzUyrH6m4BeNeN41YNP90pfkJFT83ZTdWWVj9gyABE9wVgu37wAnXCfb9suyNHW7kUttwygG123KvHs=
X-Received: by 2002:a17:90b:4c0c:b0:2d3:c0e5:cbac with SMTP id
 98e67ed59e1d1-2db9ffa11e4mr26842390a91.7.1726675783642; Wed, 18 Sep 2024
 09:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 19 Sep 2024 00:09:31 +0800
Message-ID: <CAHj4cs90xV1t2NbV6P3_z1oYwD0BcvMhC5V2mGgekRq8iae=NA@mail.gmail.com>
Subject: [bug report][regession] most of blktests nvme/tcp failed with the
 last linux code
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"

Hello

CKI reported most of the blktests nvme/tcp tests failed on the linux
tree[1], here is the reproducer and dmesg log, the issue cannot be
reproduced with 6.11.0, seems
it was introduced with the latest block code merge, please help check
it and let me know if you need any info/testing about it, thanks.


[1]
https://datawarehouse.cki-project.org/kcidb/tests/14394423

[2]
# nvme_trtype=tcp ./check nvme/003
nvme/003 (tr=tcp) (test if we're sending keep-alives to a discovery
controller) [failed]
    runtime  11.280s  ...  11.188s
    --- tests/nvme/003.out 2024-09-18 11:30:11.243366401 -0400
    +++ /root/blktests/results/nodev_tr_tcp/nvme/003.out.bad
2024-09-18 11:52:32.977112834 -0400
    @@ -1,3 +1,3 @@
     Running nvme/003
    -disconnected 1 controller(s)
    +disconnected 0 controller(s)
     Test complete
# dmesg
[  447.213539] run blktests nvme/003 at 2024-09-18 11:52:21
[  447.229285] loop0: detected capacity change from 0 to 2097152
[  447.233104] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  447.242398] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  447.251089] sysfs: cannot create duplicate filename
'/devices/virtual/nvme-fabrics/ctl/nvme0/reset_controller'
[  447.251810] CPU: 2 UID: 0 PID: 5241 Comm: nvme Kdump: loaded Not
tainted 6.12.0-0.rc0.adfc3ded5c33.2.test.el10.aarch64 #1
[  447.252540] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[  447.253006] Call trace:
[  447.253171]  dump_backtrace+0xd8/0x130
[  447.253432]  show_stack+0x20/0x38
[  447.253657]  dump_stack_lvl+0x80/0xa8
[  447.253925]  dump_stack+0x18/0x30
[  447.254152]  sysfs_warn_dup+0x6c/0x90
[  447.254406]  sysfs_add_file_mode_ns+0x12c/0x138
[  447.254713]  create_files+0xa8/0x1f8
[  447.254973]  internal_create_group+0x18c/0x358
[  447.255274]  internal_create_groups+0x58/0xe0
[  447.255558]  sysfs_create_groups+0x20/0x40
[  447.255826]  device_add_attrs+0x19c/0x218
[  447.256093]  device_add+0x310/0x6d0
[  447.256327]  cdev_device_add+0x58/0xc0
[  447.256579]  nvme_add_ctrl+0x78/0xd0 [nvme_core]
[  447.256895]  nvme_tcp_create_ctrl+0x3c/0x178 [nvme_tcp]
[  447.257248]  nvmf_create_ctrl+0x150/0x288 [nvme_fabrics]
[  447.257614]  nvmf_dev_write+0x98/0xf8 [nvme_fabrics]
[  447.257948]  vfs_write+0xdc/0x380
[  447.258174]  ksys_write+0x7c/0x120
[  447.258408]  __arm64_sys_write+0x24/0x40
[  447.258673]  invoke_syscall.constprop.0+0x74/0xd0
[  447.258994]  do_el0_svc+0xb0/0xe8
[  447.259225]  el0_svc+0x44/0x1a0
[  447.259449]  el0t_64_sync_handler+0x120/0x130
[  447.259745]  el0t_64_sync+0x1a4/0x1a8

-- 
Best Regards,
  Yi Zhang

