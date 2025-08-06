Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A37354764
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495368; cv=none; b=gNdeef7eci9kBt3CZpVZS+QYqPEKcojh+YtIb4ClP2swCVRgV1ltlIBmLXA/3/2f6NG0F4NWhWCjVCgHEKmLDs54RhxGG2WVWoyXVWUtWXeWflpggMAoqFWFVF3TR/BzZbv7MbWYK+sXoBS5a3t8jcz9ZD5UljmbmAQ4GbLSqhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495368; c=relaxed/simple;
	bh=f73B0SkQlNoDc/kIwb4tlHJBDE+Z54LiAVEzskAWP2w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rPx4bdu1bWYtFhVlnu2t1Obkcf4ZZRFHmLPJGxKqMy1Gzi+IuurtxQ64cGFxBgQIzpeVmaVDE5sQrWE6d6T/K+kdDXGULgnYQZyxqWGhfiVIxz0MaeebcFs/XEHlUCcvgHoyyhtziARzi3l4BLtZNk82EPwLNibZq8mkpWlFU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JXbo7sT9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXbo7sT9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754495365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=1xYLpP2qyd+MRQOpf5NC9eS/MsXIl2qcFRd3haePg58=;
	b=JXbo7sT9BYiRn5g8F0EFK8Zk8NKmbbt28pEREkm9uBArm4Gz7RgqhjtyT+KBHYRLr08U7z
	7Y8gkdYXCN1oDkydJdPeRDcYuYr3T3DUQB8VpH/bTfVtx2NAu2yAoXMemBBiOfLyJzKxsJ
	Agq+2NCHlz5uonbgalelz113pD17SrQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-Jt13RbSxPvi_f2iG5JlYBA-1; Wed, 06 Aug 2025 11:49:23 -0400
X-MC-Unique: Jt13RbSxPvi_f2iG5JlYBA-1
X-Mimecast-MFC-AGG-ID: Jt13RbSxPvi_f2iG5JlYBA_1754495362
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-33262a2f1ecso22514221fa.1
        for <linux-block@vger.kernel.org>; Wed, 06 Aug 2025 08:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754495361; x=1755100161;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1xYLpP2qyd+MRQOpf5NC9eS/MsXIl2qcFRd3haePg58=;
        b=CJX7YJsKiT1EwojqYiWtrnOrp9uY7kF6fZbYLGv55Zf+oJAIUg00FZw9xqsNIVFU46
         Fc3yo6R98bmZY2JQdeEKN2u69Ig9yCJAbDVsBH8Ka8tJRYV8L/+nKS5jIvOtIEM6mPDu
         XQdwC945pGD7YnqHFtp18sXOBEVxHZ/O8nIHTas1QWekcpDfy1444mW2I9CvbYXvXglc
         121L03l6tc2ZSfbpuXSaTUq3alKS1XRfYw77tA7HwNobkAw7sGyn49YnjkOKr7o234Ll
         7Su3Vvn5sAEmuJRQXF+qpFWfLXjtqIoWkxpcvyGpJ4fLDnnb8sZaBxGbI+pxaGgtMvqy
         HkOQ==
X-Gm-Message-State: AOJu0Yy+jgEQpaBTjhbyg1T5DUfAvy0+1VL/St7JF3Rt3xtjjh8opeWK
	WFREQIszMhdmwt7TlsK3azJP66iwBK48mzz98CX9e9dnpJAW0SgcfijdBdazm1Y1Wf3tkSPTkc9
	t79T6XhtklJoplH2oR+RX6hDQvZoylm9st4LT4Iba17RwtFOmn5sfNeHxjog36lmSMK8aeQthJ9
	yD//154VZpyLva4T7uiMigU104a72b+od34JsWlELbYdZKwO+q5Q==
X-Gm-Gg: ASbGncvwNdAMcFhpEuE6owy5V5sm1tEghQPlu+yEGhaWc6PzDtBnWEhblP2R3kwyDx6
	L715b4kOw66ZavfzP+Qy5AlpVxJxv/yR4ZrjwHgYuvk6wTPfixR1JK20mA9OrSnRnUXsgj6xSIX
	+p+eApppw/E/UC1iiORFo2/g==
X-Received: by 2002:a05:651c:b0f:b0:310:81a0:64f7 with SMTP id 38308e7fff4ca-333813dd76fmr7985481fa.24.1754495360543;
        Wed, 06 Aug 2025 08:49:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7Ps4UsBdSGMYTnGoiWrmm0YAe8TsSbYACYGHQihcEec+VGAXNFGyHViDPtF13nSur1Z1Q3ZXdXn97Y2qkIVc=
X-Received: by 2002:a05:651c:b0f:b0:310:81a0:64f7 with SMTP id
 38308e7fff4ca-333813dd76fmr7985351fa.24.1754495360059; Wed, 06 Aug 2025
 08:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 6 Aug 2025 23:49:07 +0800
X-Gm-Features: Ac12FXxBvb7dCz1aBB7yP7U4S3pII2LP0y0hOi4wSKLuoj1-ysd4Fbjpz21zYMQ
Message-ID: <CAHj4cs96AfFQpyDKF_MdfJsnOEo=2V7dQgqjFv+k3t7H-=yGhA@mail.gmail.com>
Subject: [bug report] blktests nvme/005 lead kernel panic on the latest linux-block/for-next
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Maurizio Lombardi <mlombard@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hello

I found this panic issue on the latest linux-block/for-next, please
help check it and let me know if you need any info/testing for it,
thanks

commit: 20c74c073217 (HEAD -> for-next, origin/for-next) Merge branch
'block-6.17' into for-next
reproducer: blktests nvme/loop or nvme/tcp nvme/005

console log:
[  341.092092] loop: module loaded
[  341.246981] run blktests nvme/005 at 2025-08-06 15:32:53
[  341.537716] loop0: detected capacity change from 0 to 2097152
[  341.594066] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  341.679693] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  341.931127] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  341.959026] nvme nvme1: creating 80 I/O queues.
[  342.105359] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  342.256079] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  342.850745] nvmet: Created nvm controller 2 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  342.858886] nvme nvme1: creating 80 I/O queues.
[  343.254225] nvme nvme1: mapped 80/0/0 default/read/poll queues.
[  343.539107] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  343.711101] block nvme1n1: no available path - failing I/O
[  343.711476] block nvme1n1: no available path - failing I/O
[  343.711691] Buffer I/O error on dev nvme1n1, logical block 262143,
async page read
[  348.367529] Unable to handle ker
** replaying previous printk message **
[  348.367529] Unable to handle kernel paging request at virtual
address dfff800000000032
[  348.367589] KASAN: null-ptr-deref in range
[0x0000000000000190-0x0000000000000197]
[  348.367593] Mem abort info:
[  348.367595]   ESR = 0x0000000096000005
[  348.367597]   EC = 0x25: DABT (current EL), IL = 32 bits
[  348.367601]   SET = 0, FnV = 0
[  348.367603]   EA = 0, S1PTW = 0
[  348.367606]   FSC = 0x05: level 1 translation fault
[  348.367608] Data abort info:
[  348.367610]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[  348.367612]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  348.367615]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  348.367618] [dfff800000000032] address between user and kernel address ranges
[  348.367758] Internal error: Oops: 0000000096000005 [#1]  SMP
[  348.444121] Modules linked in: loop nvmet(-) rfkill sunrpc mlx5_ib
ib_uverbs macsec mgag200 acpi_ipmi ib_core ipmi_ssif arm_spe_pmu
i2c_algo_bit mlx5_fwctl fwctl ipmi_devintf ipmi_msghandler arm_cmn
arm_dmc620_pmu vfat fat arm_dsu_pmu cppc_cpufreq fuse xfs mlx5_core
nvme nvme_core mlxfw nvme_keyring ghash_ce tls sbsa_gwdt nvme_auth
hpwdt psample pci_hyperv_intf i2c_designware_platform xgene_hwmon
i2c_designware_core dm_mirror dm_region_hash dm_log dm_mod [last
unloaded: nvmet_tcp]
[  348.486730] CPU: 53 UID: 0 PID: 7580 Comm: modprobe Not tainted
6.16.0+ #3 PREEMPT_{RT,(full)}
[  348.495418] Hardware name: HPE ProLiant RL300 Gen11/ProLiant RL300
Gen11, BIOS 1.60 03/07/2024
[  348.504018] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  348.510969] pc : kasan_byte_accessible+0xc/0x20
[  348.515492] lr : __kasan_check_byte+0x20/0x70
[  348.519839] sp : ffff8000c07679d0
[  348.523142] x29: ffff8000c07679d0 x28: ffff0800b09d29b0 x27: 0000000000000190
[  348.530269] x26: ffffd1b95babfe28 x25: 0000000000000000 x24: 0000000000000002
[  348.537395] x23: 0000000000000001 x22: 0000000000000000 x21: ffffd1b95b1e89dc
[  348.544521] x20: 0000000000000190 x19: 0000000000000190 x18: 0000000000000000
[  348.551647] x17: ffffd1b922a23714 x16: ffffd1b95bc6e288 x15: ffffd1b95b2e9248
[  348.558773] x14: ffffd1b922a236a8 x13: ffffd1b95d7d5c2c x12: ffff7000180ecf1b
[  348.565900] x11: 1ffff000180ecf1a x10: ffff7000180ecf1a x9 : 0000000000000035
[  348.573026] x8 : ffff07ffdb8e0000 x7 : 0000000000000000 x6 : ffffd1b95babfe28
[  348.580152] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
[  348.587278] x2 : 0000000000000000 x1 : dfff800000000000 x0 : 0000000000000032
[  348.594405] Call trace:
[  348.596840]  kasan_byte_accessible+0xc/0x20 (P)
[  348.601361]  lock_acquire.part.0+0x5c/0x2b8
[  348.605536]  lock_acquire+0x9c/0x190
[  348.609102]  down_write_nested+0x70/0xc0
[  348.613015]  __simple_recursive_removal+0x80/0x4b8
[  348.617797]  simple_recursive_removal+0x1c/0x30
[  348.622317]  debugfs_remove+0x60/0x90
[  348.625971]  nvmet_debugfs_subsys_free+0x3c/0x60 [nvmet]
[  348.631289]  nvmet_subsys_free+0x50/0x108 [nvmet]
[  348.635995]  nvmet_subsys_put+0x8c/0x100 [nvmet]
[  348.640614]  nvmet_exit_discovery+0x20/0x38 [nvmet]
[  348.645492]  nvmet_exit+0x1c/0x68 [nvmet]
[  348.649502]  __do_sys_delete_module.constprop.0+0x298/0x548
[  348.655065]  __arm64_sys_delete_module+0x38/0x58
[  348.659672]  invoke_syscall.constprop.0+0x78/0x1f0
[  348.664455]  do_el0_svc+0x164/0x1e0
[  348.667933]  el0_svc+0x54/0x180
[  348.671065]  el0t_64_sync_handler+0xa0/0xe8
[  348.675239]  el0t_64_sync+0x1ac/0x1b0
[  348.678892] Code: d65f03c0 d343fc00 d2d00001 f2fbffe1 (38616800)
[  348.684976] ---[ end trace 0000000000000000 ]---
[  348.689583] Kernel panic - not syncing: Oops: Fatal exception
[  348.695319] SMP: stopping secondary CPUs
[  348.699383] Kernel Offset: 0x51b8daeb0000 from 0xffff800080000000
[  348.705465] PHYS_OFFSET: 0x80000000
[  348.708941] CPU features: 0x10000,00002e00,048098a1,0441720b
[  348.714590] Memory Limit: none
[  348.892994] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---


-- 
Best Regards,
  Yi Zhang

