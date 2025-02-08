Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D4B8F5C
	for <linux-block@vger.kernel.org>; Sat,  8 Feb 2025 02:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738980593; cv=none; b=JYuLQKSILQk49S37pQCs2gyEihtHg9wsQXqgeHgkBhaTsejzkH/AaziLqznCYPFNcePF2f1LRLsclon2UuvLZ71d1+3lMd6+WVmTKvKJ02LbUaFP4NMU5SrdtX0/ivC9Q4LlG2/hqg6qjeRcaPObsufHAP/f4TMqY/A69u67sjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738980593; c=relaxed/simple;
	bh=Kwys6Yos6rj734gxLEDSjHrgfeugqXZ4WQvmYLgFH8U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=S503j2B02Cv4iE0yALzezIwaJdBN2MTvUZ8Wc7tOFMOrEZHrlPeRStCmdt4HknXzXHLwqak/uyAA5gJCWewWtkiTjpPaydTkyDvu0ummvf1HyJUZEynJ0wysk8YCMVH7pQlbAJoFJSQs6FrSeG7DYmWzalbSQs8/HhiAM1IY2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSu9snl7; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSu9snl7"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e5b29779d74so2499224276.2
        for <linux-block@vger.kernel.org>; Fri, 07 Feb 2025 18:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738980590; x=1739585390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B7F5+YKw3cfP6u4EjZ/wBC2ChjcnxUSc8br9u3iG6OM=;
        b=gSu9snl7ew0JRTQI44eArIxjZDg7P5vRazlaQ8NcS18fqAr+FxZ2ZfRYjp6w4egS8t
         Lg5i9973oXF3C3lFS4DSxZj6eMQ29lgnMS5ZZd4Pnm5KJ/ZL4aXON4B55LWYESimimT3
         QSxkqpFFCU6gfnkp93BhKz/i3eb5usMcL4kv8Ig+4zUrNM/IdSaQ3ycaf194n6T0EdgP
         PRs1vnP+Twn85/bJMVzqOgNsjBujAFPavXs2CmRxSIEQIKyA79fFDmDUjbZWdcVnV4d6
         8aapoaWWYFUcXKcMHjx7wavhFkvBwG0YZ6IZXxsRDWKAxaavNf4Fi8J+xI2uPeCUQGQ7
         Xq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738980590; x=1739585390;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7F5+YKw3cfP6u4EjZ/wBC2ChjcnxUSc8br9u3iG6OM=;
        b=I24/Re9e2XscdEGSJmf/g5mIAOr3XuDIGXzE1IRkfiqQlRTzz7aoDgHjRB3lePqc50
         4nkf5Xi6oqEq8r4dS5RyB26IlxM6oXghII3Zt6SXccV+dZrZEUoiiBUWrWy33jNsYcfh
         2h6DpEgQ1L+4l5BzZ7XB6z4bDudZp2daGdVftoUyRdKl0bVJbdUUMxI9kzKrUqGGcclf
         gY2tltIL9+1s2t/IcECogkGFzNfePRjB9QrOciwO6VjI87f3liWFx7ymXppoo5B/7H12
         LBVUPZWgHtwbsBc8GoUAoDp/TVl/H/YbCg7tUwG0ue+3MQ1izINwFcu+WWTfVXLLstoF
         6Uig==
X-Gm-Message-State: AOJu0YzLGDxnYlQTcZyZHIZ5O30574cijnji4WehzkyhwSgylXtWK953
	R48wP4JiIylPxklFSo/37AYNCVAvzeFP0UpidOpcmI9vriMPZpLCmMY3vd3XzXTq8lwHUDyQp3z
	HPXbl87jPx9v/k1rvj2iTIUSkzRJKow8L
X-Gm-Gg: ASbGncv1ZkuiaskKss0WDe2WkyKxLe5idkbLI5mgr2G4uin+cqW83YToAlbbRTEXfv5
	+s/Y7o+IY0TKddmuaVchIYZQAsJGB1YwEmToRfbgCI5+hUuOEYAWAB9I/I0SimX05pCD1ojxN
X-Google-Smtp-Source: AGHT+IFeWNUAyqwrG5mbDYhTXxW6SrlU+jnCYeBOVAcZBoyBunHpRkaLk/MlBK4MeI6JgDhYBcGGrTjTy4KLFdGv8gs=
X-Received: by 2002:a05:6902:2185:b0:e5b:3e10:14f2 with SMTP id
 3f1490d57ef6-e5b46283135mr4476271276.43.1738980590427; Fri, 07 Feb 2025
 18:09:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cheyenne Wills <cheyenne.wills@gmail.com>
Date: Fri, 7 Feb 2025 19:09:39 -0700
X-Gm-Features: AWEUYZlC5RnFarKlZl0Obg5b0zZnUule-Pe9EVBZld1tEOebYO-kTGGLGzXOIFY
Message-ID: <CAHpsFVeew-p9xB9DB52Pk_6mXfFxJbT8p14h5+YRTKabEfU3BQ@mail.gmail.com>
Subject: BUG: NULL pointer dereferenced within __blk_rq_map_sg
To: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"

While I was setting up to test with linux 6.14-rc1 (under Xen), I ran
into a consistent NULL ptr dereference within __blk_rq_map_sg when
booting the system.

Using git bisect I was able to narrow down the "bad" commit to:

block: add a dma mapping iterator (b7175e24d6acf79d9f3af9ce9d3d50de1fa748ec)

Building a kernel with the parent commit
(2caca8fc7aad9ea9a6ea3ed26ed146b1e5f06fab) using the same .config does
not fail.

Following is the console log showing the error as well as the Xen
(libvirt) configuration for the guest that I'm using.

Please let me know if there is any additional information that I can provide.

cheyenne.wills@gmail.com

Console log with error
----

[    6.535764] BUG: kernel NULL pointer dereference, address: 0000000000000028
[    6.547530] #PF: supervisor read access in kernel mode
[    6.556013] #PF: error_code(0x0000) - not-present page
[    6.566162] PGD 0 P4D 0
[    6.572427] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[    6.580457] CPU: 14 UID: 0 PID: 1433 Comm: kworker/14:1H Not
tainted 6.14.0-rc1+ #1
[    6.592054] Hardware name: Xen HVM domU, BIOS 4.19.1 01/17/2025
[    6.600738] Workqueue: kblockd blk_mq_requeue_work
[    6.610356] RIP: 0010:__blk_rq_map_sg+0x3d/0x410
[    6.618285] Code: 54 45 31 e4 55 48 89 cd 53 48 89 d3 48 83 ec 60
48 8b 4e 38 65 48 8b 04 25 28 00 00 00 48 89 44 24 58 31 c0 48 89 e8
44 89 e5 <44> 8b 69 28 44 8b 41 2c 49 89 c4 44 8b 79 30 e9 b0 00 00 00
48 85
[    6.640873] RSP: 0018:ffffbd02005ebb38 EFLAGS: 00010046
[    6.649672] RAX: ffffbd02005ebc08 RBX: ffffa18cc11a7200 RCX: 0000000000000000
[    6.660862] RDX: ffffa18cc11a7200 RSI: ffffa18cc11e6600 RDI: ffffa18cc23a8000
[    6.672288] RBP: 0000000000000000 R08: ffffa18cc23a0000 R09: ffffa18cc11e6600
[    6.683278] R10: ffffa18cc1642980 R11: ffffa18cc148e400 R12: 0000000000000000
[    6.695085] R13: ffffa18cc11e6600 R14: ffffa18cc23a0be0 R15: ffffa18cc23a0000
[    6.708417] FS:  0000000000000000(0000) GS:ffffa18dc6d80000(0000)
knlGS:0000000000000000
[    6.724049] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.736413] CR2: 0000000000000028 CR3: 000000010a5e2000 CR4: 0000000000750ef0
[    6.748664] PKRU: 55555554
[    6.755404] Call Trace:
[    6.761889]  <TASK>
[    6.766985]  ? __die+0x23/0x70
[    6.774405]  ? page_fault_oops+0x158/0x460
[    6.784689]  ? exc_page_fault+0x6b/0x150
[    6.793848]  ? asm_exc_page_fault+0x26/0x30
[    6.801585]  ? __blk_rq_map_sg+0x3d/0x410
[    6.808362]  blkif_queue_rq+0x1de/0x840
[    6.816009]  blk_mq_dispatch_rq_list+0x117/0x6b0
[    6.822869]  __blk_mq_sched_dispatch_requests+0xb0/0x5b0
[    6.830766]  ? __remove_hrtimer+0x39/0x90
[    6.837653]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.846842]  ? xas_load+0xd/0xd0
[    6.852211]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.858252]  ? xas_find+0x157/0x1a0
[    6.863941]  blk_mq_sched_dispatch_requests+0x2d/0x70
[    6.871505]  blk_mq_run_hw_queue+0x22c/0x2f0
[    6.879164]  blk_mq_run_hw_queues+0x67/0x120
[    6.887146]  blk_mq_requeue_work+0x162/0x1a0
[    6.896083]  process_one_work+0x148/0x360
[    6.905583]  worker_thread+0x2cb/0x3e0
[    6.914302]  ? __pfx_worker_thread+0x10/0x10
[    6.923801]  kthread+0xf1/0x1d0
[    6.931407]  ? __pfx_kthread+0x10/0x10
[    6.940421]  ret_from_fork+0x34/0x50
[    6.948756]  ? __pfx_kthread+0x10/0x10
[    6.956678]  ret_from_fork_asm+0x1a/0x30
[    6.965756]  </TASK>
[    6.971401] Modules linked in:
[    6.977370] CR2: 0000000000000028
[    6.983075] ---[ end trace 0000000000000000 ]---
[    6.989697] RIP: 0010:__blk_rq_map_sg+0x3d/0x410
[    6.998861] Code: 54 45 31 e4 55 48 89 cd 53 48 89 d3 48 83 ec 60
48 8b 4e 38 65 48 8b 04 25 28 00 00 00 48 89 44 24 58 31 c0 48 89 e8
44 89 e5 <44> 8b 69 28 44 8b 41 2c 49 89 c4 44 8b 79 30 e9 b0 00 00 00
48 85
[    7.027159] RSP: 0018:ffffbd02005ebb38 EFLAGS: 00010046
[    7.035909] RAX: ffffbd02005ebc08 RBX: ffffa18cc11a7200 RCX: 0000000000000000
[    7.047863] RDX: ffffa18cc11a7200 RSI: ffffa18cc11e6600 RDI: ffffa18cc23a8000
[    7.060227] RBP: 0000000000000000 R08: ffffa18cc23a0000 R09: ffffa18cc11e6600
[    7.070223] R10: ffffa18cc1642980 R11: ffffa18cc148e400 R12: 0000000000000000
[    7.079521] R13: ffffa18cc11e6600 R14: ffffa18cc23a0be0 R15: ffffa18cc23a0000
[    7.089842] FS:  0000000000000000(0000) GS:ffffa18dc6d80000(0000)
knlGS:0000000000000000
[    7.101846] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.110248] CR2: 0000000000000028 CR3: 000000010a5e2000 CR4: 0000000000750ef0
[    7.121235] PKRU: 55555554
[    7.126201] note: kworker/14:1H[1433] exited with irqs disabled
[    7.134082] note: kworker/14:1H[1433] exited with preempt_count 1
[    7.143106] kworker/14:1H (1433) used greatest stack depth: 12848 bytes left
[    1.295002] cpu 9 spinlock event irq 121

----

Here is the libvirt/virtmanager configuration for the xen guest (if
this is of any help).
The xen hypervisor is: xen_version: 4.19.1 and the dom0 is gentoo with
a 6.6.67 kernel.

<domain type="xen">
  <name>linux614-test</name>
  <uuid>xxxxxxxxxxxxxxxxxx</uuid>
  <metadata>
    <libosinfo:libosinfo
xmlns:libosinfo="http://libosinfo.org/xmlns/libvirt/domain/1.0">
      <libosinfo:os id="http://gentoo.org/gentoo/rolling"/>
    </libosinfo:libosinfo>
  </metadata>
  <memory unit="KiB">8388608</memory>
  <currentMemory unit="KiB">8388608</currentMemory>
  <vcpu placement="static">16</vcpu>
  <os>
    <type arch="x86_64" machine="xenfv">hvm</type>
    <loader type="rom">/usr/lib/xen/boot/hvmloader</loader>
    <boot dev="hd"/>
  </os>
  <features>
    <acpi/>
    <apic/>
    <pae/>
  </features>
  <clock offset="utc"/>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>destroy</on_crash>
  <devices>
    <emulator>/usr/lib/xen/bin/qemu-system-i386</emulator>
    <disk type="file" device="disk">
      <driver name="qemu" type="raw"/>
      <source file="/var/lib/libvirt/images/linux614-test.img"/>
      <target dev="xvda" bus="xen"/>
    </disk>
    <controller type="xenbus" index="0"/>
    <controller type="ide" index="0"/>
    <interface type="bridge">
      <mac address="xxxxxxx"/>
      <source bridge="br0"/>
      <model type="e1000"/>
    </interface>
    <serial type="pty">
      <target port="0"/>
    </serial>
    <console type="pty">
      <target type="serial" port="0"/>
    </console>
    <input type="tablet" bus="usb"/>
    <input type="mouse" bus="ps2"/>
    <input type="keyboard" bus="ps2"/>
    <graphics type="vnc" port="-1" autoport="yes">
      <listen type="address"/>
    </graphics>
    <video>
      <model type="vga" vram="16384" heads="1" primary="yes"/>
    </video>
    <memballoon model="xen"/>
  </devices>
</domain>
