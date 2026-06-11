Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6457367F3D
	for <linux-block@vger.kernel.org>; Thu, 11 Jun 2026 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163749; cv=none; b=BiklbdYQtQoZH1V8WWsuO8P58eduDI9dVJ/7Ao0gdH/iRwNrtpo5Z7RZ8n13Xl/23ENLX4dIarFLixpELnS1kaLKF/QSmSCWnsWiaYrGBVRKlGmuk0GIxk9bzNNqDCnGDZZV8UfLPPX0G+8EbJuqvBV287in2SDaImTILwfqh7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163749; c=relaxed/simple;
	bh=9GxDRaCywwOpTuvoSFTJce7vCpkaF0H+U1t5TPoeuKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qRD5At69JYvPNWz0mHC/BWsh9fFVwrzQmyv7x1aeDG3fobNGcds/6PdGd3ToMamnJq5GCMEB1sW48ur1gjIhd/CI4Rm9TPpiQCzhsPsa60kVxmlk+pO+FwnDcx9oHR4quDwjhHrY+Gh/KVFR7gLHgblZ8JDOLi7QI6+QLD381GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bSfUvHPo; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bSfUvHPo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1781163747; x=1812699747;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9GxDRaCywwOpTuvoSFTJce7vCpkaF0H+U1t5TPoeuKs=;
  b=bSfUvHPoO9fHnbCLyDnw/Ir9AkxcHvwPzi23IYD/crafzYcS7aTOR2qp
   QI/G1B33far6iSw67edi76HlAw5h/Smt8PV2g/x+XdebfFrRKXFCUvmwr
   Auu0M6o9TdCoMvg2EOgcQrwvh0efShF82rQcEzZW6Uqgfwkcr8+eVLX0A
   CakVkO2NXg+JiZf0UeQ/F067BtobPmStojJmLWDqQyq2AZ6Y+QkxBY+tQ
   swKkFFE5qDOxDYyQZbp19teyXE1vvjto4J+Ob86y1obyIl0bylWFdKJH4
   imiZt1gRJfzQSf8YxWVpBapfIj3Zbvx3czrYloWNetfTQ3c/XSPRwLqPZ
   A==;
X-CSE-ConnectionGUID: icBSLomgRha533UJwgJ7sA==
X-CSE-MsgGUID: 8HwdiLiDR7yA6GnQFXkErA==
X-IronPort-AV: E=Sophos;i="6.24,198,1774281600"; 
   d="scan'208";a="147412566"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2026 15:42:21 +0800
X-CSE-ConnectionGUID: CWf6rS9KTDu0bUpUGiyyQQ==
X-CSE-MsgGUID: jGHidibXTEOv3blkklc+tA==
IronPort-SDR: 6a2a66c9_e5EA96BrRG1pw3Z1SJpiN6SbLvr/gJyIBYyQWpPeGE15rJS
 Rv1owMHB+ccHXrjPttXpZRex7cdSsDZMutGgr5Q==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jun 2026 00:42:01 -0700
X-CSE-ConnectionGUID: gmPXiLXQTx6juLWvHRNTNA==
X-CSE-MsgGUID: X4UU+5WxTQepn6Uq5IAX3w==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 11 Jun 2026 00:42:00 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <tom.leiming@gmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH RFC 0/1] block: fix concurrent elevator change failure
Date: Thu, 11 Jun 2026 16:41:59 +0900
Message-ID: <20260611074200.474676-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I observed that the blktests test case block/005 hangs on a specific
server hardware using a specific HDD as a block device. During the test
case run, the kernel reported a KASAN null-ptr-deref (and other memory
corruption symptoms) [2]. This failure looked sporadic and hardware-
dependent.

From the kernel message, I noticed that udev-worker wrote to the
queue/scheduler sysfs attribute to change the IO scheduler, or elevator.
The test case block/005 also wrote to the same sysfs attribute, which
indicated that a concurrent elevator change caused the failure. I
created a new blktests test case that simply does the concurrent
elevator change with a null_blk device [1]. It recreates the failure in
a stable manner on various server hardware.

Using the new test case, I bisected and found that the failure first
appears at the commit 370ac285f23a ("block: avoid cpu_hotplug_lock
depedency on freeze_lock") in the kernel tag v6.17-rc3. However, that
commit does not appear to explain the failure by itself: it changed the
queue freeze behavior and only unveiled a race, probably. Looking back
at the changes to elevator_change(), I think the actual cause is the
commit 559dc11143eb ("block: move elv_register[unregister]_queue out of
elevator_lock") in the kernel tag v6.16-rc1. This commit moved
elevator_change_done() out of the guard of ->elevator_lock and the queue
freeze. As a result, when two threads write to the same queue/scheduler
attribute concurrently, elevator_change_done() runs in parallel causing
the memory corruption and the hang.

As the fix attempt, I created the patch in this series. It adds a new
mutex that serializes the whole elevator switch sequence, including the
elevator_change_done() call. I ran the reproducer with lockdep enabled
and confirmed that the patch avoids the failure and new WARN was not
observed.

However, the fix patch adds a new lock, and I'm not sure if it is the best
solution. Comments on the patch, or suggestions for a better solution,
would be appreciated.

[1] https://github.com/kawasaki/blktests/commit/4f8c63ed7d049f5e9c935c3fe00=
142b2a3629826

[2]

[30102.760660] [ T186170] run blktests block/005 at 2026-05-11 05:53:53
[30104.969837] [ T186111] Oops: general protection fault, probably for non-=
canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
[30104.983590] [ T186111] KASAN: null-ptr-deref in range [0x000000000000000=
0-0x0000000000000007]
[30104.992929] [ T186111] CPU: 2 UID: 0 PID: 186111 Comm: (udev-worker) Not=
 tainted 7.1.0-rc2-kts+ #1 PREEMPT(lazy)
[30105.004019] [ T186111] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[30105.013216] [ T186111] RIP: 0010:blk_mq_debugfs_register_sched+0x46/0x210
[30105.020667] [ T186111] Code: 48 89 fa 48 c1 ea 03 48 83 ec 10 80 3c 02 0=
0 0f 85 83 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 6b 08 48 89 ea 48 c=
1 ea 03 <80> 3c 02 00 0f 85 57 01 00 00 48 c7 c0 24 a3 b3 97 4
8 8b 6d 00 48
[30105.041036] [ T186111] RSP: 0018:ffff88816b9c7708 EFLAGS: 00010246
[30105.048111] [ T186111] RAX: dffffc0000000000 RBX: ffff888117f18000 RCX: =
0000000000000000
[30105.057097] [ T186111] RDX: 0000000000000000 RSI: 0000000000000008 RDI: =
ffff888117f18008
[30105.066086] [ T186111] RBP: 0000000000000000 R08: ffffffff957c47ac R09: =
fffffbfff2f6633c
[30105.075083] [ T186111] R10: ffff88816b9c7730 R11: 0000000000000001 R12: =
ffff88814c1f2000
[30105.084088] [ T186111] R13: ffff88814c1f2018 R14: ffff8881b8a336ac R15: =
ffffffff95bfae30
[30105.093111] [ T186111] FS:  00007fc1c7970c40(0000) GS:ffff8887c534e000(0=
000) knlGS:0000000000000000
[30105.103093] [ T186111] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[30105.110751] [ T186111] CR2: 000055fa37e182c0 CR3: 0000000108350003 CR4: =
00000000001726f0
[30105.119796] [ T186111] Call Trace:
[30105.124154] [ T186111]  <TASK>
[30105.128301] [ T186111]  blk_mq_sched_reg_debugfs+0x8d/0x1a0
[30105.134193] [ T186111]  elevator_change_done+0x2f2/0x610
[30105.140037] [ T186111]  ? __pfx_elevator_change_done+0x10/0x10
[30105.146409] [ T186111]  ? __pfx_sysfs_kf_write+0x10/0x10
[30105.152246] [ T186111]  ? __pfx_sysfs_kf_write+0x10/0x10
[30105.158189] [ T186111]  elevator_change+0x283/0x4f0
[30105.163342] [ T186111]  ? __pfx_sysfs_kf_write+0x10/0x10
[30105.168932] [ T186111]  elv_iosched_store+0x30c/0x3a0
[30105.174265] [ T186111]  ? __pfx_elv_iosched_store+0x10/0x10
[30105.180797] [ T186111]  ? lock_acquire.part.0+0xb8/0x230
[30105.187066] [ T186111]  ? kernfs_fop_write_iter+0x25b/0x5e0
[30105.193594] [ T186111]  ? lock_acquire.part.0+0xb8/0x230
[30105.199931] [ T186111]  ? lock_acquire+0x126/0x140
[30105.205683] [ T186111]  ? __pfx_sysfs_kf_write+0x10/0x10
[30105.211924] [ T186111]  queue_attr_store+0x23f/0x360
[30105.217796] [ T186111]  ? __pfx_queue_attr_store+0x10/0x10
[30105.224180] [ T186111]  ? __lock_acquire+0x55d/0xbd0
[30105.230049] [ T186111]  ? lock_acquire.part.0+0xb8/0x230
[30105.236247] [ T186111]  ? sysfs_file_kobj+0x1d/0x1b0
[30105.242093] [ T186111]  ? find_held_lock+0x2b/0x80
[30105.247763] [ T186111]  ? __lock_release.isra.0+0x59/0x170
[30105.254122] [ T186111]  ? lock_release.part.0+0x1c/0x50
[30105.260226] [ T186111]  ? sysfs_file_kobj+0xb9/0x1b0
[30105.266048] [ T186111]  ? sysfs_kf_write+0x65/0x170
[30105.271778] [ T186111]  ? __pfx_sysfs_kf_write+0x10/0x10
[30105.277934] [ T186111]  kernfs_fop_write_iter+0x3da/0x5e0
[30105.284173] [ T186111]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[30105.290926] [ T186111]  vfs_write+0x524/0x1010
[30105.296215] [ T186111]  ? __pfx_vfs_write+0x10/0x10
[30105.301905] [ T186111]  ? kasan_quarantine_put+0xf5/0x240
[30105.308092] [ T186111]  ? kasan_quarantine_put+0xf5/0x240
[30105.314246] [ T186111]  ksys_write+0xff/0x200
[30105.319331] [ T186111]  ? __pfx_ksys_write+0x10/0x10
[30105.325007] [ T186111]  do_syscall_64+0xf4/0x1550
[30105.330407] [ T186111]  ? __pfx___x64_sys_openat+0x10/0x10
[30105.336566] [ T186111]  ? seccomp_run_filters+0xeb/0x560
[30105.342517] [ T186111]  ? do_syscall_64+0x1d7/0x1550
[30105.348096] [ T186111]  ? __seccomp_filter+0xa2/0x920
[30105.353749] [ T186111]  ? __pfx___seccomp_filter+0x10/0x10
[30105.359830] [ T186111]  ? trace_hardirqs_on_prepare+0x150/0x1a0
[30105.366344] [ T186111]  ? do_syscall_64+0x1b9/0x1550
[30105.371892] [ T186111]  ? do_syscall_64+0x1d7/0x1550
[30105.377422] [ T186111]  ? do_syscall_64+0x1d7/0x1550
[30105.382922] [ T186111]  ? do_syscall_64+0x1b9/0x1550
[30105.388401] [ T186111]  ? do_syscall_64+0x34/0x1550
[30105.393777] [ T186111]  ? do_syscall_64+0xab/0x1550
[30105.399129] [ T186111]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[30105.405624] [ T186111] RIP: 0033:0x7fc1c7c4fbbe
[30105.410647] [ T186111] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[30105.431611] [ T186111] RSP: 002b:00007ffefd3bdd90 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[30105.440716] [ T186111] RAX: ffffffffffffffda RBX: 000055fa3f0f4b80 RCX: =
00007fc1c7c4fbbe
[30105.449404] [ T186111] RDX: 000000000000000b RSI: 000055fa3ed9d550 RDI: =
0000000000000015
[30105.458090] [ T186111] RBP: 00007ffefd3bdda0 R08: 0000000000000000 R09: =
0000000000000000
[30105.466787] [ T186111] R10: 0000000000000000 R11: 0000000000000202 R12: =
000000000000000b
[30105.475479] [ T186111] R13: 000000000000000b R14: 000055fa3ed9d550 R15: =
000055fa3ed9d550
[30105.484182] [ T186111]  </TASK>
[30105.487920] [ T186111] Modules linked in: iscsi_target_mod tcm_loop targ=
et_core_pscsi target_core_file target_core_iblock xfs nft_masq nft_reject_i=
pv4 act_csum cls_u32 sch_htb nf_nat_tftp nf_conntrack_tftp bridge stp llc t=
arget_core_user target_core_mod rfkill nf_conntrack_netbios_ns nf_conntrack=
_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet n=
f_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat ip6table_nat i=
p6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntra=
ck nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_securit=
y nf_tables ip6table_filter ip6_tables iptable_filter ip_tables qrtr intel_=
rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp co=
retemp iTCO_wdt intel_pmc_bxt kvm_intel kvm irqbypass rapl sunrpc intel_cst=
ate intel_uncore pcspkr i2c_i801 i2c_smbus mei_me igb lpc_ich mei ioatdma d=
ca wmi binfmt_misc joydev acpi_power_meter acpi_pad btrfs raid6_pq xor ses =
enclosure loop dm_multipath nfnetlink zram lz4hc_compress lz4_compress
[30105.488278] [ T186111]  zstd_compress ast drm_client_lib i2c_algo_bit dr=
m_shmem_helper drm_kms_helper mpt3sas drm mpi3mr raid_class scsi_transport_=
sas scsi_dh_rdac scsi_dh_emc scsi_dh_alua i2c_dev fuse [last unloaded: zone=
fs]
[30105.609649] [ T186111] ---[ end trace 0000000000000000 ]---
[30105.648290] [ T186111] pstore: backend (erst) writing error (-28)
[30105.654739] [ T186111] RIP: 0010:blk_mq_debugfs_register_sched+0x46/0x210
[30105.662519] [ T186111] Code: 48 89 fa 48 c1 ea 03 48 83 ec 10 80 3c 02 0=
0 0f 85 83 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 6b 08 48 89 ea 48 c=
1 ea 03 <80> 3c 02 00 0f 85 57 01 00 00 48 c7 c0 24 a3 b3 97 48 8b 6d 00 48
[30105.683653] [ T186111] RSP: 0018:ffff88816b9c7708 EFLAGS: 00010246
[30105.691248] [ T186111] RAX: dffffc0000000000 RBX: ffff888117f18000 RCX: =
0000000000000000
[30105.700121] [ T186111] RDX: 0000000000000000 RSI: 0000000000000008 RDI: =
ffff888117f18008
[30105.708841] [ T186111] RBP: 0000000000000000 R08: ffffffff957c47ac R09: =
fffffbfff2f6633c
[30105.717829] [ T186111] R10: ffff88816b9c7730 R11: 0000000000000001 R12: =
ffff88814c1f2000
[30105.726550] [ T186111] R13: ffff88814c1f2018 R14: ffff8881b8a336ac R15: =
ffffffff95bfae30
[30105.735306] [ T186111] FS:  00007fc1c7970c40(0000) GS:ffff8887c54ce000(0=
000) knlGS:0000000000000000
[30105.745003] [ T186111] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[30105.752368] [ T186111] CR2: 00007f251f9bc0e8 CR3: 0000000108350002 CR4: =
00000000001726f0


Shin'ichiro Kawasaki (1):
  block: serialize whole elevator change steps for the same queue

 block/blk-core.c       | 1 +
 block/elevator.c       | 9 +++++++++
 include/linux/blkdev.h | 7 +++++++
 3 files changed, 17 insertions(+)

--=20
2.54.0

