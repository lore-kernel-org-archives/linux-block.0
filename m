Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590E3BBF4
	for <linux-block@vger.kernel.org>; Mon, 15 Apr 2024 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713172464; cv=none; b=QshH8Xo/ts4u7pfriSkIsazbLd4CFrru3x6fJavaETZIHMiYmDmZ59vVzbD8NHfgw6WcWsNtA7HGiw1jEvjzHTbI/TSBRz1+Sahwo6KMHCsHPRVdhC1pULD/4FPO8sCT5seb1zXVu7d62XYFx+DGLfNyPVk9XY0vMxp6QGlMFXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713172464; c=relaxed/simple;
	bh=g0oOtP9x1JtixgltpWuhdML1p0gYgaoJ21yzkgvnSPY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=neNN99Q0TH2+5vGSUpzBWD3d4Ffbncb1AdNCKon+Cd3wACVEBP2yIxPz7weqPWA7tP47R4d15J0F7T0f+qyOtrh6zrkEVuhOC8TFDauOK71uE+wJQkrYv+BlavxjsGNWSWN7Twltod9w4V4A1RVHwdtFWOHZ5PlwXTHRpyWG9Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=POP2E0X7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POP2E0X7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713172461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jTHU8T4ujkriJmus3xKv/40uZ54QsTQ9Y6PAOi3S2AY=;
	b=POP2E0X7zedHKdDE2iLjRqWyBLCPK4aDmnN2pcSwzDkWyppcz/j7W5a5quccnRIQN7ISlQ
	3ZK6LHRfV0q4qPGzDQE6Bl5SOJdJA8S5DX/MWoT2AYLKpVAmVywoz6EEdIe78WCC5XaFzn
	97fYlztanS5Yf7aApZZMeAT9CNS8BcE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-v5oRLKsWOgSDC08rLf7-bg-1; Mon, 15 Apr 2024 05:14:19 -0400
X-MC-Unique: v5oRLKsWOgSDC08rLf7-bg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a2fec91d48so2822419a91.2
        for <linux-block@vger.kernel.org>; Mon, 15 Apr 2024 02:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713172458; x=1713777258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTHU8T4ujkriJmus3xKv/40uZ54QsTQ9Y6PAOi3S2AY=;
        b=eOJkPkmkGWiXKNJUbu6nipTFy5qEIMYKMdtwYvED+MgIR92I0TWbbbWG1WMv53fjSt
         gzsjzpMoRdH2jS4kXPzIC3yR5uPOWq0DCuCEabK6uqy5DOwNSlrWOjl5qBTx0pTitXQ/
         SuDbrNw78PPTNefn8rr712uv7Wwwjw7ce/lYiCtSsc1WIUU4xv6Nh+3zIz0MHIi4Twnp
         67+dz0pzA8KhGWpdSsWXIc9dxznVxvJsCo5Lcwr/jNszS28rp5KNmO/IQpE5vSzwvyxo
         ErfNagVBTPy765JLtzwQXXbi/6/pw4R/sl08/aqbrEn/jwOK3MQeemxLWPvUjbhFIjaA
         Qi8w==
X-Gm-Message-State: AOJu0YzIAAqFm69gzvAKfYzA8z6iRUDMyWVjIrwO0rszLri+VnMUu2Ik
	JTzk6licxuWnF63ULn+UExkgVzVsP6b2mjUieec8MX/XRa3lNVDb/IqJmlR1xRdzKuAn0rgdiiF
	T7eqJ2q+3z26UWZxHVG5m+fvvZBVCfswo99BpjEohSQE/uaZNEnmcDbSnpFg7Or5ZU8coTb6NzY
	SkDoaEwtxJ0oZgmeL6Eqzq9SwLogLWCFtNLuhuFgUSyx9SgrM90fQ=
X-Received: by 2002:a17:90a:d918:b0:2a5:2f48:1eba with SMTP id c24-20020a17090ad91800b002a52f481ebamr6580282pjv.13.1713172458097;
        Mon, 15 Apr 2024 02:14:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4nv9iDYteH7jrZl1469SN3tReYejLvU6SOZ5hMiNlJvv1K+d6Qa6Ad1rSjM/WUH20PdQZQELofANJlrGrVGo=
X-Received: by 2002:a17:90a:d918:b0:2a5:2f48:1eba with SMTP id
 c24-20020a17090ad91800b002a52f481ebamr6580267pjv.13.1713172457769; Mon, 15
 Apr 2024 02:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Changhui Zhong <czhong@redhat.com>
Date: Mon, 15 Apr 2024 17:14:06 +0800
Message-ID: <CAGVVp+WzC1yKiLHf8z0PnNWutse7BgY9HuwgQwwsvT4UYbUZXQ@mail.gmail.com>
Subject: [bug report] WARNING: CPU: 5 PID: 679 at io_uring/io_uring.c:2835 io_ring_exit_work+0x2b6/0x2e0
To: Linux Block Devices <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

repo:https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
branch:for-next
commit HEAD:f2738f2440eb573094ef6f09cca915ae37f2f8bc

hit this issue on recent upstream=EF=BC=8Creproduced with ubdsrv, trigger t=
his
issue on "running generic/005" and "running generic/006",

# cd ubdsrv
# make test T=3Dgeneric

[  993.347470] WARNING: CPU: 13 PID: 4628 at io_uring/io_uring.c:2835
io_ring_exit_work+0x2b6/0x2e0
[  993.357304] Modules linked in: ext4 mbcache jbd2 rfkill sunrpc
dm_multipath intel_rapl_msr intel_rapl_common intel_uncore_frequency
intel_uncore_frequency_common i10nm_edac nfit libnvdimm
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm ipmi_ssif
rapl intel_cstate mgag200 iTCO_wdt dax_hmem iTCO_vendor_support
cxl_acpi mei_me i2c_algo_bit cxl_core i2c_i801 drm_shmem_helper
isst_if_mmio isst_if_mbox_pci drm_kms_helper intel_uncore mei einj
ioatdma pcspkr i2c_smbus isst_if_common intel_vsec intel_pch_thermal
ipmi_si dca ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter drm
fuse xfs libcrc32c sd_mod t10_pi sg ahci crct10dif_pclmul libahci
crc32_pclmul crc32c_intel libata tg3 ghash_clmulni_intel wmi dm_mirror
dm_region_hash dm_log dm_mod
[  993.431516] CPU: 13 PID: 4628 Comm: kworker/u96:2 Not tainted 6.9.0-rc3+=
 #1
[  993.439297] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
BIOS AFE120G-1.40 09/20/2022
[  993.449015] Workqueue: iou_exit io_ring_exit_work
[  993.454275] RIP: 0010:io_ring_exit_work+0x2b6/0x2e0
[  993.459729] Code: 89 e7 e8 6d de ff ff 48 8b 44 24 58 65 48 2b 04
25 28 00 00 00 75 2e 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc
cc cc cc <0f> 0b 41 be 60 ea 00 00 e9 45 fe ff ff 0f 0b e9 1d ff ff ff
e8 c1
[  993.480695] RSP: 0018:ff70b0c247657dd0 EFLAGS: 00010287
[  993.486533] RAX: 00000001000a94c0 RBX: ff26a781c5b48448 RCX: 00000000000=
00000
[  993.494506] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff26a781c5b=
48040
[  993.502475] RBP: ff70b0c247657e60 R08: 0000000000000000 R09: ffffffffbb2=
54ca0
[  993.510445] R10: 0000000000000000 R11: 0000000000000000 R12: ff26a781c5b=
48000
[  993.518415] R13: ff26a781c5b48040 R14: 0000000000000032 R15: 00000000000=
00000
[  993.526387] FS:  0000000000000000(0000) GS:ff26a784efa80000(0000)
knlGS:0000000000000000
[  993.535427] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  993.541848] CR2: 00007ff5a794f004 CR3: 000000003ea20006 CR4: 00000000007=
71ef0
[  993.549820] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  993.557790] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  993.565761] PKRU: 55555554
[  993.568787] Call Trace:
[  993.571523]  <TASK>
[  993.573871]  ? __warn+0x7f/0x130
[  993.577486]  ? io_ring_exit_work+0x2b6/0x2e0
[  993.582259]  ? report_bug+0x18a/0x1a0
[  993.586358]  ? handle_bug+0x3c/0x70
[  993.590262]  ? exc_invalid_op+0x14/0x70
[  993.594551]  ? asm_exc_invalid_op+0x16/0x20
[  993.599234]  ? io_ring_exit_work+0x2b6/0x2e0
[  993.604006]  ? try_to_wake_up+0x21e/0x600
[  993.608490]  process_one_work+0x193/0x3d0
[  993.612969]  worker_thread+0x2fc/0x410
[  993.617161]  ? __pfx_worker_thread+0x10/0x10
[  993.621934]  kthread+0xdc/0x110
[  993.625448]  ? __pfx_kthread+0x10/0x10
[  993.629640]  ret_from_fork+0x2d/0x50
[  993.633640]  ? __pfx_kthread+0x10/0x10
[  993.637830]  ret_from_fork_asm+0x1a/0x30
[  993.642219]  </TASK>
[  993.644661] ---[ end trace 0000000000000000 ]---

Thanks,

