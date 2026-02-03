Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682A3318ECB
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121758; cv=pass; b=fH4PH5V/F5acstm/EACV3B3o+mPfJcC+Lr9Wfgu2AvWz43T5iCTXnkXGc4yo1JtxS8Um14ff3Tyc4emPfG/3qYzP8DSERUUC53ML7P02IHbh0mA39dc+kiGLNPqmUHHvg6GMrY5Jl6SvwS+bFQUAd7jQgGZFkaBHxPzOgPQceNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121758; c=relaxed/simple;
	bh=Ob/lrHNj7D05tuyPt1EGqbgeLujxAqKW7kG5t2NFnws=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=C8DGQqDzN16jUSBOJo77YpR40pNtIdDKr+ut3+DeU2tHmVwBoywyLacsOhRnEDa1Di+AkKd5fU+45XKu6+mQaLMNiaphqylQ/DOFJK/APCCDIvSrbiAu+GPMThJUm9Aq91efsxxa7GJuOdQ30tzvb4daELQwZZ1gfBGGrvNadl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8O8ekfB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLU4RpOJ; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8O8ekfB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLU4RpOJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770121756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=b3v7qXh8dLHy2074F6XoVLXkWVS0VD/XNrXmappg4PE=;
	b=N8O8ekfB02EWQ/rHrU/zQkYNfnHMYoFgtzVqRameYv7Mu1Ge26fzo/8DI11vhK70FUS3cU
	IX7CPKcz8WBfI38rGUQTABfJLnuah/PNmqujjxZW3dLqgDao0i3YbkFlK5Cls5qgXAJqen
	i9Zoqzfl9uHCywWivNGHE9oaCSldG04=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-UYN_dYb6PpWfmbDwllIbpQ-1; Tue, 03 Feb 2026 07:29:15 -0500
X-MC-Unique: UYN_dYb6PpWfmbDwllIbpQ-1
X-Mimecast-MFC-AGG-ID: UYN_dYb6PpWfmbDwllIbpQ_1770121754
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-385fed5fa78so35047781fa.1
        for <linux-block@vger.kernel.org>; Tue, 03 Feb 2026 04:29:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770121751; cv=none;
        d=google.com; s=arc-20240605;
        b=EFJNEUERQ86TcmfgHmTr1KYRTKkbFc1kIAMHU7ftSq44rDTfRwS/RmzIuQI7ryH8Cx
         0gy9MnWeFBAD0/Z8Hto+J8hlwkHN0acEYzzFf5/Kuke1PGNkVEULhBo6C+UIzS47QXdm
         jWYG5IyR0di4cY4c25u9+Dfo+j/w6XrKar3da0h60Bm8Qbky/Me9I+cALa6fFSI+Cj01
         zgpZPyTE5eyQNSJGph7wyePzxpO7BvPoGc1DN+jZRQ7MPhAGRyAnq1kIdxU9VHYKGbeN
         tZiCGGXonrCBehp5i/0A8Y4nMhM5cuQ6mRB8PrXrIJJKekJl6ruTPLI24a1ad/GTpdpQ
         D0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=b3v7qXh8dLHy2074F6XoVLXkWVS0VD/XNrXmappg4PE=;
        fh=fHepfjLRzhfCKHRP3y9TVjiB1lEI8Rd9ULIKhjFuUbg=;
        b=JYEck/dL2v8H+fsqbcTj1eo+HPUBMpnifSwmCcaiYTz4h40Jhwbv/TZKtkhzS3Hyoj
         eUHcxDmo1W3rNYZKGREFbfYIy99PCC+t4nf6+D5aVfD/Xlg5WwK4Jxg1KhBefk7mNrdy
         1G4MfXUEBwxWnu8sU1hQoH7235nNM3BOjwB80tI6SF4i8yfrngnFWWoE5rr8gMdCtv+B
         os/AWiXNajpDbWhSWnbUHYXjMuqwUsQZ0R4AFNkKgWQpuyoworNuAVQmlAGTSHGlrkny
         MisOCILhrt2c/TdPtQ3EOx3prsYjIP8bUlUl2ONWoq66pFS4B+dK/QEhC32tV4OXwruC
         4rOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770121751; x=1770726551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b3v7qXh8dLHy2074F6XoVLXkWVS0VD/XNrXmappg4PE=;
        b=TLU4RpOJhoy7DDGPg7yh0YWwUFenKhYk3Ed6QkPUuoGriGuBUZ8GN6EOAIU1WZCunu
         aSB2NItQqi8BquqtjX+RQ/eA/TgIwzOXeYkRnShZmSnNrYFXL+HnkbwMrlfIQLi6gXda
         FNarvCV1wAyn0L1hm04sj/MldfVdKE5H6Dn4AVLVHoOXa1emk2XpzkmpspqSRN9GKw0R
         yAmKsepXAK8as49JEy5JAdL3z0w3cDMV+8C3P2DxhlbiPh/bhuxY6KaBMVY6u0bE1SKw
         BdX1VvRn6hx/iBH2ieSDFzR5QKDO62OfNvtZWZ2kEbWCSLqR0b/zSdkhSm2zbO19I/Tz
         hEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770121751; x=1770726551;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3v7qXh8dLHy2074F6XoVLXkWVS0VD/XNrXmappg4PE=;
        b=UefjmwIz+j20onn76y/M76wI3gXWw65VeRvIkrX5VhiAwWeLpzdJu+4bzi1QoNd6JU
         1WVE6fVANmIRABXzskDIifGrGsNgemZRQPCjxwwrGNr8u3XPYpHaSaisQVVfyP3iv0HD
         2CqrmsflefpT401Y47KkepVpxqz9ePqx0bJMT9frgUoutu1qltPfp7XO7stjPZB5A3GB
         q/s88/yt7K3jIFe/bSVMmFhRlnPIx17KVyzTnwHyYH+HnNM9ibj5Vw4wpAjh3D44CL84
         g7MnlBNVxwQJChb3HCjh7o8mbZkrJz51H1WXjcDpZmArYoyX3KqyyT8say3DChy9ae5b
         208w==
X-Gm-Message-State: AOJu0YzyqVHc+eYRCoUk0fZW9KD3SOy0fWjkxk9k6UBh3gl0PIy2/7Rk
	AmVxAl4JqFhAFOAKo4Hdijg3pqOPGRoAvApumIkccg7hhKI5yp8dboAP/Xb5KxT5Ffh3F0nWbZQ
	K+XZJ15mMZu/uyMhXdgTW/Xki6uO5xFeV1OLNxQL2xCKeV+xIUPKIcYHXTPdZLSAi8FacAL6NjZ
	F20L2rI0naMB8+Ugo+cMdYB25XIWWnuwUC53GFg4gDnbrxwMXJ5DM/
X-Gm-Gg: AZuq6aL8o+T47VX5znelycFJAj2Ce5dnl13h6JnHut8v4RRZnYFfn2QilHBmT2Y05zK
	4lleuwRUWgpgtTXolsEfdH20EoCoZFxE+l6ZAzTokKUJjJoeCo7en/62lBJ5LGx98JQCv2ETUqT
	qVcbPxtRcdvixdA3CB1jHucIcR5Du3mIfSU9Cetmd5146B57UiidtQHr3BYBI/I7WIVOM=
X-Received: by 2002:a05:651c:154e:b0:378:e079:ecdb with SMTP id 38308e7fff4ca-386466b463dmr55460161fa.32.1770121751150;
        Tue, 03 Feb 2026 04:29:11 -0800 (PST)
X-Received: by 2002:a05:651c:154e:b0:378:e079:ecdb with SMTP id
 38308e7fff4ca-386466b463dmr55460081fa.32.1770121750707; Tue, 03 Feb 2026
 04:29:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 3 Feb 2026 20:28:56 +0800
X-Gm-Features: AZwV_QishAydBM0xNeTvJarIZYponRgq3_h2ExgRtRiuicXD-M3bXOXa5lsvzyI
Message-ID: <CAHj4cs9gNKEYAPagD9JADfO5UH+OiCr4P7OO2wjpfOYeM-RV=A@mail.gmail.com>
Subject: [bug report] WARNING: block/blk-mq-debugfs.c:620 at
 debugfs_create_files.isra.0+0x54/0x60, CPU#220: kworker/u1036:7/70421
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Ming Lei <ming.lei@redhat.com>, yukuai@fnnas.com, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

Hello

CKI reported the following failure today. Seems it was introduced from
the recently blk-mq-debugfs update, please help check and let me know
if you need any testing/info.

Reproducer: blktests nvme/tcp nvme/005
Commit message: Merge branch 'for-7.0/block' into for-next

dmesg:
[  951.319384] run blktests nvme/005 at 2026-02-02 17:59:35
[  951.346116] loop0: detected capacity change from 0 to 2097152
[  951.356428] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  951.370823] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  951.397438] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  951.412081] nvme nvme0: creating 128 I/O queues.
[  951.425914] nvme nvme0: mapped 128/0/0 default/read/poll queues.
[  951.467027] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  951.784608] nvmet: Created nvm controller 2 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  951.798920] nvme nvme0: creating 128 I/O queues.
[  951.871600] nvme nvme0: mapped 128/0/0 default/read/poll queues.
[  951.880680] ------------[ cut here ]------------
[  951.885309] WARNING: block/blk-mq-debugfs.c:620 at
debugfs_create_files.isra.0+0x54/0x60, CPU#220: kworker/u1036:7/70421
[  951.896190] Modules linked in: nvmet_tcp nvmet nvme_tcp
nvme_fabrics nvme nvme_core nvme_keyring nvme_auth rtrs_core rdma_cm
iw_cm ib_cm hkdf nbd loop mlx5_ib ib_uverbs macsec sunrpc ib_core
mlx5_fwctl fwctl rfkill vfat fat amd_atl intel_rapl_msr
intel_rapl_common amd64_edac edac_mce_amd jc42 kvm_amd ee1004 joydev
wmi_bmof mlx5_core kvm irqbypass mlxfw rapl psample tls ptdma ipmi_si
ipmi_devintf pcspkr ipmi_msghandler acpi_cpufreq i2c_piix4 k10temp
i2c_smbus fuse nfnetlink zram lz4hc_compress lz4_compress xfs ast
i2c_algo_bit ghash_clmulni_intel wmi sp5100_tco i2c_dev [last
unloaded: nvmet]
[  951.948577] CPU: 220 UID: 0 PID: 70421 Comm: kworker/u1036:7 Not
tainted 6.19.0-rc7 #1 PREEMPT(lazy)
[  951.957814] Hardware name: AMD Corporation DAYTONA_X/DAYTONA_X,
BIOS RYM100GA 01/13/2025
[  951.965941] Workqueue: nvme-reset-wq nvme_reset_ctrl_work [nvme_tcp]
[  951.972321] RIP: 0010:debugfs_create_files.isra.0+0x54/0x60
[  951.977911] Code: 48 89 d9 4d 89 e0 48 89 ea 49 c7 c1 20 20 73 9a
48 83 c3 28 e8 bd 57 d9 ff 48 8b 3b 48 85 ff 75 db 5b 5d 41 5c e9 f7
b6 51 ff <0f> 0b eb be 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
90 90
[  951.996673] RSP: 0018:ffffd137f8ee3c90 EFLAGS: 00010202
[  952.001919] RAX: ffff8e3a49aa6c00 RBX: ffffffff9a731e00 RCX: ffffffff9a731e00
[  952.009070] RDX: ffff8e3a831ab000 RSI: ffff8e3a49aa6c00 RDI: 0000000000000001
[  952.016227] RBP: ffff8e3a49aa6c00 R08: 0000000000000064 R09: 0000000000000000
[  952.023396] R10: ffff8e3a1c6a2540 R11: 0000000000000000 R12: ffff8e3a831ab000
[  952.030607] R13: ffff8e3a64c03620 R14: ffffd137f8ee3d38 R15: ffff8e3a8c43e400
[  952.037815] FS:  0000000000000000(0000) GS:ffff8e5601f7b000(0000)
knlGS:0000000000000000
[  952.045946] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  952.051708] CR2: 00007f310853ef58 CR3: 00000037aac2e003 CR4: 0000000000f70ef0
[  952.058856] PKRU: 55555554
[  952.061579] Call Trace:
[  952.064048]  <TASK>
[  952.066159]  blk_mq_debugfs_register_hctx+0x97/0x150
[  952.071136]  ? srso_alias_return_thunk+0x5/0xfbef5
[  952.075945]  blk_mq_debugfs_register_hctxs+0x4e/0x70
[  952.080924]  __blk_mq_update_nr_hw_queues+0x218/0x390
[  952.085991]  blk_mq_update_nr_hw_queues+0x39/0x50
[  952.090714]  nvme_tcp_configure_io_queues.cold+0x1ac/0x35e [nvme_tcp]
[  952.097175]  nvme_tcp_setup_ctrl+0xab/0x250 [nvme_tcp]
[  952.102327]  ? nvme_change_ctrl_state+0x135/0x1b0 [nvme_core]
[  952.108090]  nvme_reset_ctrl_work+0x9a/0xd0 [nvme_tcp]
[  952.113246]  process_one_work+0x18d/0x340
[  952.117266]  worker_thread+0x256/0x3a0
[  952.121030]  ? __pfx_worker_thread+0x10/0x10
[  952.125320]  kthread+0xfc/0x240
[  952.128481]  ? __pfx_kthread+0x10/0x10
[  952.132245]  ? __pfx_kthread+0x10/0x10
[  952.136009]  ret_from_fork+0x126/0x190
[  952.139773]  ? __pfx_kthread+0x10/0x10
[  952.143539]  ret_from_fork_asm+0x1a/0x30
[  952.147484]  </TASK>
[  952.149687] ---[ end trace 0000000000000000 ]---
[  952.167930] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[  952.195424] block nvme0n1: no available path - failing I/O
[  952.200938] block nvme0n1: no available path - failing I/O
[  952.206483] buffer_io_error: 439 callbacks suppressed
[  952.206486] Buffer I/O error on dev nvme0n1, logical block 262142,
async page read



-- 
Best Regards,
  Yi Zhang

