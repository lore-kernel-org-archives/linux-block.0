Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3827419EED7
	for <linux-block@vger.kernel.org>; Wed, 14 Aug 2024 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628739; cv=none; b=dVqIwruOYK9Vw4SDAEhY+ljAYrnHVW1g1EVBfuYZic/LoGo3I5JWPethB+XIpabpk2uwQSEZsr6CwZO/hcujAv+RE+A5bCz3ihrcbPQKu4B8AMnQnJsMVvrA5zxdlupbpiKCdmSqLbrA44Glt6PU4F4uE16O+IL/F5wLyeucLJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628739; c=relaxed/simple;
	bh=Ti/Zf51kEl+alJ3brHpunVBp5ba7bOLyXd8+PQAs/1M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FHsUzud4pKDiv8YE+ITOiFk06RgIfoSQ+IovHAx6Mshs3MGM6N1oTCwhUSEVZhU2hsSjITkxbR7RASG3+J+Y65+SG3AIeb/ISypiRih1u/n8cpyAm4LvMAYzlUStB0WLrVFjEzRBiOWxP/oyF5LbliM0n4eokXf9d7t80wDBP4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lJ6yaxe4; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJ6yaxe4"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4929f9a28c7so2216452137.1
        for <linux-block@vger.kernel.org>; Wed, 14 Aug 2024 02:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723628736; x=1724233536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AqTddAzKnNUZIAwEfzKnnscE8MqF5HGYJSDp7SE0qdk=;
        b=lJ6yaxe4TY9AzICQnwYzrS13mOqJnqP0x4ZVeLzDA2NOoxWkPJ9M0U7yb2LOMy0Rru
         Zm6dNmi49mT2FbwM9QG69LTmpvP+wa0VyIrmjzfBRgVT+sO9xcDsbipFrSMDx7PpFgO4
         wJpdye6xHXzH/rD7S+8uAHXl5KbprSO7Q/fjdNQiFXXbu6WuULoUrNzrul78cTvtvJek
         voCwzr5/9ago7JexKpb+i39lzbZoWeuN8zh4B5RpYsdIHVRvc5MkuKSyUKjOcfZ1VXja
         e29MhMaBBYXSTQy8TC6/jNbCp0g0yAHfKBBGv6hbmjKk+oEmDLgdE4LOcW89Vsh6sRc8
         3A1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723628736; x=1724233536;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AqTddAzKnNUZIAwEfzKnnscE8MqF5HGYJSDp7SE0qdk=;
        b=nfgnhWLk9Uq2Zx5xeae7POcgLDBzAiKmNXBCGVxn+CV+lcnSuNvNHHOkODWTUCeO3v
         UWl2o7LCs9/17Yshx+CzH/LCuLGO4HswfN8kBJ6hWrH4APBPRdIlYap7mBYMg1ovwp3T
         CeU/wma7KlHVXSNwGcVh0u/6iHFWmonJN8podBdXGvRuPPjX+PallUuKa6+fVckQAhhg
         JwVDThUxdfSKjNfLbIynbOpK7++RQf/5miK9TBggWS34En10AyxDVSOQw7pAdXHnhSFn
         grAjBixEuyNMRq01YqC3IACRwA7wF/001kAqlVgEw0ZQnOUKtzv0fa0O3QQ5P8CPUoaH
         fzRw==
X-Forwarded-Encrypted: i=1; AJvYcCUWuPt7vgGrHcOcT//v56Xp67CNFMbET7iaimGMcSNS6TjZTvd9yMJk7xtGcX8K35TDHbkBD2KTDsyvHg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Ojsu58gYFviIPrRu/W0OAOXV3Q/hnVehhMyqbtUoTWy52TK2
	gNs8vRnsd0hcIt3cYQbze8UP2+XX0ZEvLMTi37bJ7TEaAV+MwFuh8a2gKXDt7Psb/YRcCIJeOAq
	nhDmmo0H9ST3p0J9EF3a4xrkqVaDC/+szQUDe2g==
X-Google-Smtp-Source: AGHT+IEu4m8IvoB2eT7Lab+NoT1ZY4XAOC4ts3bgwowFq88amATwROVe4cIvi0Pv2rWtvrkoloA6dxkqDzUo5Q/ZIr8=
X-Received: by 2002:a05:6102:36ca:b0:494:3a8d:c793 with SMTP id
 ada2fe7eead31-497599d00a9mr2130293137.28.1723628735955; Wed, 14 Aug 2024
 02:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 14 Aug 2024 15:15:24 +0530
Message-ID: <CA+G9fYuD4-qKAX9nDS-3cy+HwGbyJ6WoD7bZ_QL0J__A++P9aA@mail.gmail.com>
Subject: next: x86_64: ahci 0000:00:1f.2: probe with driver ahci failed with
 error -12
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-block <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Christoph Hellwig <hch@lst.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The qemu-x86_64 boot failed with today's Linux next-20240814 tag due to
following crash.

The catch here is the crash seen on both x86_64 device and qemu-x86_64
but x86_64 device is able to boot successfully.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Boot log:
---
[    0.000000] Linux version 6.11.0-rc3-next-20240814
(tuxmake@tuxmake) (x86_64-linux-gnu-gcc (Debian 13.3.0-1) 13.3.0, GNU
ld (GNU Binutils for Debian) 2.42.50.20240625) #1 SMP PREEMPT_DYNAMIC
@1723614704
...
<6>[    2.479915] scsi host0: ahci
<4>[    2.484371] sysfs: cannot create duplicate filename
'/devices/virtual/workqueue/scsi_tmf_-1073661392'
<4>[    2.486170] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted
6.11.0-rc3-next-20240814 #1
<4>[    2.486709] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
<4>[    2.486709] Call Trace:
<4>[    2.486709]  <TASK>
<4>[    2.486709]  dump_stack_lvl+0x96/0xb0
<4>[    2.486709]  dump_stack+0x14/0x20
<4>[    2.486709]  sysfs_warn_dup+0x5f/0x80
<4>[    2.486709]  sysfs_create_dir_ns+0xd0/0xf0
<4>[    2.486709]  kobject_add_internal+0xa8/0x2e0
<4>[    2.486709]  kobject_add+0x97/0x100
<4>[    2.486709]  ? get_device_parent+0x109/0x1d0
<4>[    2.486709]  device_add+0xe4/0x880
<4>[    2.486709]  ? hrtimer_init+0x2b/0x80
<4>[    2.486709]  device_register+0x1e/0x30
<4>[    2.486709]  workqueue_sysfs_register+0x91/0x140
<4>[    2.486709]  __alloc_workqueue+0x664/0x800
<4>[    2.486709]  ? trace_preempt_on+0x1e/0x70
<4>[    2.486709]  ? __kthread_create_on_node+0x108/0x170
<4>[    2.486709]  alloc_workqueue+0x5a/0x80
<4>[    2.486709]  ? __kthread_create_on_node+0x108/0x170
<4>[    2.486709]  scsi_host_alloc+0x365/0x470
<4>[    2.486709]  ata_scsi_add_hosts+0xc2/0x130
<4>[    2.486709]  ata_host_register+0xb5/0x260
<4>[    2.486709]  ata_host_activate+0xe9/0x140
<4>[    2.486709]  ahci_host_activate+0x16a/0x190
<4>[    2.486709]  ahci_init_one+0xe0f/0x1080
<4>[    2.486709]  ? trace_preempt_on+0x1e/0x70
<4>[    2.486709]  local_pci_probe+0x48/0xa0
<4>[    2.486709]  pci_device_probe+0xc6/0x1f0
<4>[    2.486709]  really_probe+0xcc/0x3b0
<4>[    2.486709]  __driver_probe_device+0x7d/0x160
<4>[    2.486709]  driver_probe_device+0x24/0xa0
<4>[    2.486709]  __driver_attach+0xdd/0x1d0
<4>[    2.486709]  ? __pfx___driver_attach+0x10/0x10
<4>[    2.486709]  bus_for_each_dev+0x91/0xe0
<4>[    2.486709]  driver_attach+0x22/0x30
<4>[    2.486709]  bus_add_driver+0x118/0x240
<4>[    2.486709]  driver_register+0x62/0x120
<4>[    2.486709]  ? __pfx_ahci_pci_driver_init+0x10/0x10
<4>[    2.486709]  __pci_register_driver+0x62/0x70
<4>[    2.486709]  ahci_pci_driver_init+0x22/0x30
<4>[    2.486709]  do_one_initcall+0x62/0x250
<4>[    2.486709]  kernel_init_freeable+0x1ba/0x310
<4>[    2.486709]  ? __pfx_kernel_init+0x10/0x10
<4>[    2.486709]  kernel_init+0x1e/0x1d0
<4>[    2.486709]  ret_from_fork+0x41/0x60
<4>[    2.486709]  ? __pfx_kernel_init+0x10/0x10
<4>[    2.486709]  ret_from_fork_asm+0x1a/0x30
<4>[    2.486709]  </TASK>
<3>[    2.508109] kobject: kobject_add_internal failed for
scsi_tmf_-1073661392 with -EEXIST, don't try to register things with
the same name in the same directory.
<4>[    2.519098] scsi host1: failed to create tmf workq
<6>[    2.524520] kworker/R-scsi_ (56) used greatest stack depth:
15464 bytes left
<6>[    2.528402] scsi_eh_1 (55) used greatest stack depth: 14872 bytes left
<3>[    2.540312] ahci 0000:00:1f.2: probe with driver ahci failed
with error -12

Full dmesg log:
-----------
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240814/testrun/24850492/suite/boot/test/gcc-13-lkftconfig-rcutorture/log

Reproduce script:
---
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2kdXPeyCZIUn4AYH0UrByWXzepD/reproducer
 - Qemu version: 8.2.4

Boot command: /usr/bin/qemu-system-x86_64 -cpu Nehalem -machine q35
-nographic -nic none -m 4G -monitor none -no-reboot -smp 2 -kernel
kernel/bzImage -append \"console=ttyS0,115200 rootwait root=/dev/sda
debug verbose console_msg_format=syslog systemd.log_level=warning rw
earlycon\" -drive file=rootfs.ext4,if=ide,format=raw"

Build link:
------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2kdXMb8C1EcMoXxMdKTWd4TB8Ef/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2kdXMb8C1EcMoXxMdKTWd4TB8Ef/config

metadata:
---
  git_ref: master
  git_describe: next-20240814
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  kernel_version: 6.11.0-rc3
  arch: x86
  device: qemu-x86_64

Please let me know if you need more information.

--
Linaro LKFT
https://lkft.linaro.org
