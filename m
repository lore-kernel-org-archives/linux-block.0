Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ABA232373
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 07:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577753; cv=none; b=G/PiUo2HGCGueV9cJBH+6Qg4DVoTGY1bS/QAVWci/duuZGoShgGKMAImCyY1BO8LcG3f6t8YoWdW4ED2PMDUuGxrMdEtXHoukuWuuymCehGHhqDpiN7bSmL25SF6rxTS0ZHM0rwsn2mCTSNlG8be33LrsuBkCuACe7CRy4mBecA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577753; c=relaxed/simple;
	bh=6MoqfWOeWir2aQ3W4OsEpPzHGPqDoLFJg52PVH4s89w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMDgfXKzfwyR22VXcSW8DzOeP2d0X14KgelJCgli0+sAh+0tctZ3LJTcc+jSS5RvmJGGIH6Dv93gTPrKZIRZrqSToc2vzl04GZxg6QKP+mfZFJpbb5GSF9pWoqaTmeyA3AtAj4qeCrU8lsFnSdZztlFWV18TKfoF2hTVsoRKTHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oMsXBopM; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oMsXBopM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577751; x=1775113751;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6MoqfWOeWir2aQ3W4OsEpPzHGPqDoLFJg52PVH4s89w=;
  b=oMsXBopM3KdDJBOI+GNaE+0EGXgysuRxv+eFyznaFkFgYGqwYzMcjVRm
   laN4qv2p9sjfajS2DNXTwpOIBoIp7UmTzUzV9fnz+qEqY/OIcDwwQCllb
   i14yKtNVTAcPZFA8M3CaJuJRQupIuTgfGgOJlK6SQk602LJ3UWJiRcKt6
   X2kbdCTurohSWpgzyNz9+HvgHbMeSxMipmCkajZQJO5I9i3pQ8+oj4HJ4
   WddZ4iXW5pupPiXmI2PLo5dw/ATcIO9PjXTmxY3bHFFNiLQ0c7VXvqggy
   ZU4D1/bCtSy1XJzvmNhJwdG7giHgWp0Da9d0MuiqDH/gyGK0cCeWWfeXC
   A==;
X-CSE-ConnectionGUID: yrXHBP86TEiMgMvafDmgdw==
X-CSE-MsgGUID: hSCgMDTdTZu4tZQ59TwRdg==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="71367492"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:08 +0800
IronPort-SDR: 67ecd49d_ZusgFVKzTVwKISgx9769IY83v4bQP6OlqFlDPl8EwjunjEm
 8wxOX/QWquMTxZcKQelHMx3XvyEmuDB8yEe0W3w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:33 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:08 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 00/10] nvme: test cases for TLS support
Date: Wed,  2 Apr 2025 16:08:56 +0900
Message-ID: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hannes created two testcases and shared them as the GitHub PR 158 [1]. Quote:

 "This pull request adds two new testcases for nvme TLS support, one for 'plain'
  TLS with TLS PSKs, and the other one for testing 'secure concatenation' where
  TLS is started after DH-HMAC-CHAP authentication."

The testcases were missing a few requirement checks. They also modified
systemctl service status after test case runs. To address these problems, I took
the liberty to add some more patches and modified the testcases. Here I post the
modified patch series for wider review.

The first five patches are preparation patches to add several helper functions
for requirement checks and systemctl support. The last five patches are
originally created by Hannes to add the new testcases nvme/060 and nvme/061.

I ran the two test cases using the kernel v6.14 with the patch series titled
"[PATCHv15 00/10] nvme: implement secure concatenation" [2]. I observed nvme/060
passed, but nvme/061 failed. FYI, I share the failure logs [3]. Actions to fix
the failure will be appreciated.

P.S. Hannes, please check the Copyright year of the second test case nvme/061.
     It is 2022, but I guess you meant 2024 or 2025.

[1] https://github.com/osandov/blktests/pull/158
[2] https://lore.kernel.org/linux-nvme/20250224123818.42218-1-hare@kernel.org/
[3] nvme/061 failure symptom:

--- console log ----------------------------------------------------------------

nvme/061 (tr=tcp) (Create authenticated TCP connections with secure concatenation)
p    runtime  3.089s  ...
WARNING: Test did not clean up tcp device: nvme1
WARNING: Test did not clean up port: 0
WARNING: Test did not clean up subsystem: blktests-subsystem-1
rmdir: failed to remove '/sys/kernel/config/nvmet//subsystems/blktests-subsystem-1': Directory not empty
WARNING: Test did not clean up host: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
nvme/061 (tr=tcp) (Create authenticated TCP connections with secure concatenation) [failed]01fb42-9f7f-4856-b0b3-51e60    runtime  3.089s  ...  3.675sy
    --- tests/nvme/061.out      2025-04-02 15:24:52.080914400 +0900
    +++ /home/shin/Blktests/blktests/results/nodev_tr_tcp/nvme/061.out.bad      2025-04-02 15:27:58.105015254 +0900
    @@ -3,5 +3,4 @@
     Reset controller
     disconnected 1 controller(s)
     Test secure concatenation with SHA384
    -disconnected 1 controller(s)
    -Test complete
    +WARNING: connection is not encrypted
WARNING: Test did not clean up subsystem: blktests-subsystem-1
rmdir: failed to remove '/sys/kernel/config/nvmet//subsystems/blktests-subsystem-1': Directory not empty
WARNING: Test did not clean up host: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
rmdir: failed to remove '/sys/kernel/config/nvmet//hosts/nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349': Device or resource busy

--- kenrel message -------------------------------------------------------------

[  115.238242] [   T1047] run blktests nvme/061 at 2025-04-02 15:27:54
[  115.388088] [   T1156] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  115.405501] [   T1157] nvmet: Allow non-TLS connections while TLS1.3 is enabled
[  115.414088] [   T1160] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  115.563757] [     T99] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[  115.577842] [     T48] nvme nvme1: qid 0: authenticated with hash hmac(sha256) dhgroup ffdhe2048
[  115.580005] [   T1171] nvme nvme1: qid 0: authenticated
[  115.583733] [   T1171] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.
[  115.668413] [     T99] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349, TLS.
[  115.674024] [   T1171] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.
[  115.675585] [   T1171] nvme nvme1: creating 4 I/O queues.
[  115.715223] [   T1171] nvme nvme1: mapped 4/0/0 default/read/poll queues.
[  115.720228] [   T1171] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  115.830330] [   T1209] nvme nvme1: resetting controller
[  115.839115] [     T99] nvmet: Created nvm controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[  115.850411] [   T1211] nvme nvme1: qid 0: authenticated with hash hmac(sha256) dhgroup ffdhe2048
[  115.851672] [     T13] nvme nvme1: qid 0: authenticated
[  115.855251] [     T13] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.
[  115.866619] [     T11] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349, TLS.
[  115.872041] [     T13] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.
[  115.874091] [     T13] nvme nvme1: creating 4 I/O queues.
[  115.918944] [     T13] ------------[ cut here ]------------
[  115.920252] [     T13] WARNING: CPU: 3 PID: 13 at block/blk-mq.c:330 blk_mq_unquiesce_queue+0x8f/0xb0
[  115.921132] [     T13] Modules linked in: tls nvmet_tcp nvmet nvme_tcp nvme_fabrics nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables qrtr sunrpc ppdev 9pnet_virtio 9pnet netfs parport_pc e1000 parport pcspkr i2c_piix4 i2c_smbus fuse loop nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock zram vmw_vmci bochs drm_client_lib drm_shmem_helper drm_kms_helper xfs nvme floppy drm sym53c8xx nvme_core scsi_transport_spi nvme_keyring nvme_auth serio_raw ata_generic pata_acpi dm_multipath qemu_fw_cfg
[  115.926085] [     T13] CPU: 3 UID: 0 PID: 13 Comm: kworker/u16:1 Not tainted 6.14.0+ #432
[  115.926702] [     T13] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
[  115.927473] [     T13] Workqueue: nvme-reset-wq nvme_reset_ctrl_work [nvme_tcp]
[  115.928050] [     T13] RIP: 0010:blk_mq_unquiesce_queue+0x8f/0xb0
[  115.928518] [     T13] Code: 01 48 89 de bf 09 00 00 00 e8 3d 94 fc ff 48 89 ee 4c 89 e7 e8 62 c4 7e 01 48 89 df be 01 00 00 00 5b 5d 41 5c e9 b1 fb ff ff <0f> 0b 5b 48 89 ee 4c 89 e7 5d 41 5c e9 40 c4 7e 01 e8 8b 7f 85 ff
[  115.930020] [     T13] RSP: 0018:ffff8881008dfb58 EFLAGS: 00010046
[  115.930490] [     T13] RAX: 0000000000000000 RBX: ffff888122352df0 RCX: ffffffff886c1c2a
[  115.931119] [     T13] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff888122352f40
[  115.931733] [     T13] RBP: 0000000000000246 R08: 0000000000000001 R09: ffffed102011bf59
[  115.932370] [     T13] R10: 0000000000000003 R11: 1ffffffff1be0e02 R12: ffff888122352f00
[  115.934392] [     T13] R13: ffff888137278108 R14: ffff888137278348 R15: ffff888137278450
[  115.936410] [     T13] FS:  0000000000000000(0000) GS:ffff88839f780000(0000) knlGS:0000000000000000
[  115.938518] [     T13] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  115.940463] [     T13] CR2: 00007f712c69f040 CR3: 000000042a074000 CR4: 00000000000006f0
[  115.942504] [     T13] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  115.944548] [     T13] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  115.946568] [     T13] Call Trace:
[  115.948220] [     T13]  <TASK>
[  115.949824] [     T13]  ? __warn.cold+0x5f/0x1f8
[  115.951571] [     T13]  ? blk_mq_unquiesce_queue+0x8f/0xb0
[  115.953356] [     T13]  ? report_bug+0x1ec/0x390
[  115.955008] [     T13]  ? handle_bug+0x58/0x90
[  115.956632] [     T13]  ? exc_invalid_op+0x13/0x40
[  115.958302] [     T13]  ? asm_exc_invalid_op+0x16/0x20
[  115.959954] [     T13]  ? do_raw_spin_lock+0x12a/0x270
[  115.961583] [     T13]  ? blk_mq_unquiesce_queue+0x8f/0xb0
[  115.963229] [     T13]  ? blk_mq_unquiesce_queue+0x1b/0xb0
[  115.964810] [     T13]  blk_mq_unquiesce_tagset+0xaf/0xe0
[  115.966412] [     T13]  nvme_tcp_setup_ctrl.cold+0x6f2/0xc5e [nvme_tcp]
[  115.968094] [     T13]  ? __pfx_nvme_tcp_setup_ctrl+0x10/0x10 [nvme_tcp]
[  115.969747] [     T13]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[  115.971335] [     T13]  ? nvme_change_ctrl_state+0x196/0x2e0 [nvme_core]
[  115.972965] [     T13]  nvme_reset_ctrl_work+0x1a1/0x250 [nvme_tcp]
[  115.974526] [     T13]  process_one_work+0x85a/0x1460
[  115.975989] [     T13]  ? __pfx_lock_acquire+0x10/0x10
[  115.977420] [     T13]  ? __pfx_process_one_work+0x10/0x10
[  115.978863] [     T13]  ? assign_work+0x16c/0x240
[  115.980240] [     T13]  ? lock_is_held_type+0xd5/0x130
[  115.981615] [     T13]  worker_thread+0x5e2/0xfc0
[  115.982948] [     T13]  ? __kthread_parkme+0xb1/0x1d0
[  115.984266] [     T13]  ? __pfx_worker_thread+0x10/0x10
[  115.985577] [     T13]  ? __pfx_worker_thread+0x10/0x10
[  115.986897] [     T13]  kthread+0x39d/0x750
[  115.988108] [     T13]  ? __pfx_kthread+0x10/0x10
[  115.989333] [     T13]  ? __pfx_kthread+0x10/0x10
[  115.990508] [     T13]  ? __pfx_kthread+0x10/0x10
[  115.991640] [     T13]  ret_from_fork+0x30/0x70
[  115.992753] [     T13]  ? __pfx_kthread+0x10/0x10
[  115.993843] [     T13]  ret_from_fork_asm+0x1a/0x30
[  115.994942] [     T13]  </TASK>
[  115.995860] [     T13] irq event stamp: 536690
[  115.996864] [     T13] hardirqs last  enabled at (536689): [<ffffffff8ae2c5cc>] _raw_spin_unlock_irqrestore+0x4c/0x60
[  115.998333] [     T13] hardirqs last disabled at (536690): [<ffffffff8ae2c2cf>] _raw_spin_lock_irqsave+0x5f/0x70
[  115.999763] [     T13] softirqs last  enabled at (536678): [<ffffffff88516b89>] __irq_exit_rcu+0x109/0x210
[  116.001117] [     T13] softirqs last disabled at (536669): [<ffffffff88516b89>] __irq_exit_rcu+0x109/0x210
[  116.002440] [     T13] ---[ end trace 0000000000000000 ]---
[  116.009015] [     T13] nvme nvme1: mapped 4/0/0 default/read/poll queues.
[  116.050331] [   T1230] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  118.536150] [     T11] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[  118.556429] [   T1211] nvme nvme1: qid 0: authenticated with hash hmac(sha384) dhgroup ffdhe3072
[  118.559328] [   T1247] nvme nvme1: qid 0: authenticated
[  118.563048] [   T1247] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.
[  118.673740] [     T99] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349, TLS.
[  118.681185] [   T1247] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.
[  118.684070] [   T1247] nvme nvme1: creating 4 I/O queues.
[  118.732513] [   T1247] nvme nvme1: mapped 4/0/0 default/read/poll queues.
[  118.737796] [   T1247] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  119.001229] [   T1308] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"



Hannes Reinecke (6):
  common/rc: introduce _have_systemctl_unit()
  common/nvme: add '--tls' argument to _nvme_connect_subsys()
  common/nvme: TLS target support
  common/nvme: handle option '--concat' for _nvme_connect_subsys
  nvme: add testcase for TLS-encrypted connections
  nvme: add testcase for secure concatenation

Shin'ichiro Kawasaki (4):
  common/rc: introduce _systemctl_start() and _systemctl_stop()
  common/rc,fio: factor out _compare_three_version_numbers()
  nvme/rc: introduce _have_tlshd_ver() and _have_systemd_tlshd_service()
  nvme/rc: introduce _have_libnvme_ver()

 common/fio         |   9 ++--
 common/nvme        |  36 ++++++++++++++-
 common/rc          |  57 +++++++++++++++++++++---
 tests/nvme/060     |  95 +++++++++++++++++++++++++++++++++++++++
 tests/nvme/060.out |  10 +++++
 tests/nvme/061     | 109 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/061.out |   7 +++
 tests/nvme/rc      |  47 +++++++++++++++++++
 8 files changed, 356 insertions(+), 14 deletions(-)
 create mode 100755 tests/nvme/060
 create mode 100644 tests/nvme/060.out
 create mode 100755 tests/nvme/061
 create mode 100644 tests/nvme/061.out

-- 
2.49.0

