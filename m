Return-Path: <barra_cuda@katamail.com>
Date: Fri, 8 Dec 2017 16:38:51 +0100
From: Michele Ballabio <barra_cuda@katamail.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Subject: block: oopses on 4.13.*, 4.14.* and 4.15-rc2 (bisected)
Message-ID: <20171208163851.0f3823b6@darkstar.example.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

Hi,
	kernels 4.13.*, 4.14.* 4.15-rc2 crash on occasion, especially
on x86-32 systems. To trigger the problem, run as root:

while true
do
        /sbin/udevadm trigger --type=subsystems --action=change
        /sbin/udevadm trigger --type=devices --action=change
        /sbin/udevadm settle --timeout=120
done

(Thanks to Patrick Volkerding for the reproducer).

Sometimes the kernel oopses immediately, sometimes a bit later (less than
five minutes).

The bisection pointed to commit caa4b02476e31fc7933d2138062f7f355d3cd8f7
(blk-map: call blk_queue_bounce from blk_rq_append_bio). A revert
fixes the problem (tested on 4.13 and master).

Some oopses caught while bisecting between 4.13 and 4.12:

kernel: [   80.454283] BUG: unable to handle kernel NULL pointer dereference at 00000204
kernel: [   80.484276] IP: bio_uncopy_user+0xab/0x120
kernel: [   80.513842] *pdpt = 0000000028a62001 *pde = 0000000000000000 
kernel: [   80.513843] 
kernel: [   80.572510] Oops: 0000 [#1] SMP
kernel: [   80.601546] Modules linked in:
kernel: [   80.630294] CPU: 4 PID: 1574 Comm: ata_id Not tainted 4.12.0-mike-1mike+ #150
kernel: [   80.659767] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [   80.689888] task: e935da00 task.stack: e6784000
kernel: [   80.719610] EIP: bio_uncopy_user+0xab/0x120
kernel: [   80.749158] EFLAGS: 00010246 CPU: 4
kernel: [   80.778630] EAX: e935da00 EBX: ea2ff740 ECX: 00000200 EDX: 802a0016
kernel: [   80.808763] ESI: 00000000 EDI: 00000000 EBP: e6785d78 ESP: e6785d4c
kernel: [   80.838955]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [   80.869167] CR0: 80050033 CR2: 00000204 CR3: 2c6e2ca0 CR4: 003406f0
kernel: [   80.899484] Call Trace:
kernel: [   80.928888]  ? mempool_free+0x23/0x80
kernel: [   80.957911]  __blk_rq_unmap_user+0x17/0x40
kernel: [   80.986843]  blk_rq_unmap_user+0x27/0x60
kernel: [   81.015344]  sg_io+0x1f7/0x390
kernel: [   81.043451]  scsi_cmd_ioctl+0x26a/0x3f0
kernel: [   81.070558]  ? path_openat+0x4f9/0x11f0
kernel: [   81.096595]  scsi_cmd_blk_ioctl+0x30/0x40
kernel: [   81.122461]  sd_ioctl+0x63/0x90
kernel: [   81.147568]  ? scsi_disk_put+0x40/0x40
kernel: [   81.172368]  blkdev_ioctl+0x47a/0x9a0
kernel: [   81.196645]  ? do_filp_open+0x73/0xb0
kernel: [   81.220480]  block_ioctl+0x34/0x40
kernel: [   81.243783]  ? __fd_install+0x19/0xb0
kernel: [   81.266664]  ? block_ioctl+0x34/0x40
kernel: [   81.289063]  ? blkdev_fallocate+0x220/0x220
kernel: [   81.310888]  do_vfs_ioctl+0x81/0x610
kernel: [   81.333067]  ? putname+0x4f/0x60
kernel: [   81.355059]  ? putname+0x4f/0x60
kernel: [   81.376632]  ? do_sys_open+0x139/0x230
kernel: [   81.398396]  SyS_ioctl+0x58/0x70
kernel: [   81.420242]  do_int80_syscall_32+0x3d/0xa0
kernel: [   81.442452]  entry_INT80_32+0x31/0x31
kernel: [   81.464791] EIP: 0xb75872c4
kernel: [   81.487128] EFLAGS: 00000246 CPU: 4
kernel: [   81.509633] EAX: ffffffda EBX: 00000003 ECX: 00002285 EDX: bf8d5b00
kernel: [   81.532916] ESI: bf8d6f13 EDI: bf8d5b40 EBP: bf8d6018 ESP: bf8d5a68
kernel: [   81.556051]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [   81.579126] Code: d4 8d 65 f4 5b 5e 5f 5d c3 8d b4 26 00 00 00 00 c7 45 d4 00 00 00 00 eb d6 8d b4 26 00 00 00 00 8b 4d d8 66 83 7b 50 00 8b 73 58 <8b> 41 04 89 45 dc 8b 41 08 
89 45 e0 8b 41 0c 89 45 e4 8b 41 10
kernel: [   81.628905] EIP: bio_uncopy_user+0xab/0x120 SS:ESP: 0068:e6785d4c
kernel: [   81.653871] CR2: 0000000000000204
kernel: [   81.678715] ---[ end trace 04eede085ec6ee5c ]---
kernel: [   81.981549] BUG: unable to handle kernel NULL pointer dereference at 00000004
kernel: [   81.981555] IP: bio_uncopy_user+0xab/0x120
kernel: [   81.981555] *pdpt = 0000000026631001 *pde = 0000000000000000 
kernel: [   81.981556] 
kernel: [   81.981558] Oops: 0000 [#2] SMP
kernel: [   81.981558] Modules linked in:
kernel: [   81.981561] CPU: 2 PID: 1704 Comm: ata_id Tainted: G      D         4.12.0-mike-1mike+ #150
kernel: [   81.981562] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [   81.981563] task: e888a800 task.stack: e7af8000
kernel: [   81.981564] EIP: bio_uncopy_user+0xab/0x120
kernel: [   81.981565] EFLAGS: 00010246 CPU: 2
kernel: [   81.981566] EAX: e888a800 EBX: e67dc480 ECX: 00000000 EDX: 00006679
kernel: [   81.981567] ESI: 00000000 EDI: 00000000 EBP: e7af9d78 ESP: e7af9d4c
kernel: [   81.981567]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [   81.981568] CR0: 80050033 CR2: 00000004 CR3: 2cec5640 CR4: 003406f0
kernel: [   81.981569] Call Trace:
kernel: [   81.981573]  ? mempool_free+0x23/0x80
kernel: [   81.981575]  __blk_rq_unmap_user+0x17/0x40
kernel: [   81.981577]  blk_rq_unmap_user+0x27/0x60
kernel: [   81.981579]  sg_io+0x1f7/0x390
kernel: [   81.981581]  scsi_cmd_ioctl+0x26a/0x3f0
kernel: [   81.981584]  ? path_openat+0x4f9/0x11f0
kernel: [   81.981585]  scsi_cmd_blk_ioctl+0x30/0x40
kernel: [   81.981588]  sd_ioctl+0x63/0x90
kernel: [   81.981589]  ? scsi_disk_put+0x40/0x40
kernel: [   81.981590]  blkdev_ioctl+0x47a/0x9a0
kernel: [   81.981592]  ? do_filp_open+0x73/0xb0
kernel: [   81.981594]  block_ioctl+0x34/0x40
kernel: [   81.981596]  ? __fd_install+0x19/0xb0
kernel: [   81.981597]  ? block_ioctl+0x34/0x40
kernel: [   81.981598]  ? blkdev_fallocate+0x220/0x220
kernel: [   81.981599]  do_vfs_ioctl+0x81/0x610
kernel: [   81.981600]  ? putname+0x4f/0x60
kernel: [   81.981602]  ? putname+0x4f/0x60
kernel: [   81.981604]  ? do_sys_open+0x139/0x230
kernel: [   81.981605]  SyS_ioctl+0x58/0x70
kernel: [   81.981607]  do_int80_syscall_32+0x3d/0xa0
kernel: [   81.981610]  entry_INT80_32+0x31/0x31
kernel: [   81.981611] EIP: 0xb75cd2c4
kernel: [   81.981611] EFLAGS: 00000246 CPU: 2
kernel: [   81.981612] EAX: ffffffda EBX: 00000003 ECX: 00002285 EDX: bfb07d00
kernel: [   81.981612] ESI: bfb09f12 EDI: bfb07d40 EBP: bfb08218 ESP: bfb07c68
kernel: [   81.981613]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [   81.981614] Code: d4 8d 65 f4 5b 5e 5f 5d c3 8d b4 26 00 00 00 00 c7 45 d4 00 00 00 00 eb d6 8d b4 26 00 00 00 00 8b 4d d8 66 83 7b 50 00 8b 73 58 <8b> 41 04 89 45 dc 8b 41 08 
89 45 e0 8b 41 0c 89 45 e4 8b 41 10
kernel: [   81.981631] EIP: bio_uncopy_user+0xab/0x120 SS:ESP: 0068:e7af9d4c
kernel: [   81.981632] CR2: 0000000000000004
kernel: [   81.981633] ---[ end trace 04eede085ec6ee5d ]---
kernel: [   81.992515] BUG: unable to handle kernel NULL pointer dereference at   (null)
kernel: [   81.992521] IP: dnotify_flush+0xe/0xe0
kernel: [   81.992521] *pdpt = 0000000026771001 *pde = 0000000000000000 
kernel: [   81.992522] 
kernel: [   81.992524] Oops: 0000 [#3] SMP
kernel: [   81.992525] Modules linked in:
kernel: [   81.992527] CPU: 6 PID: 1727 Comm: udevd Tainted: G      D         4.12.0-mike-1mike+ #150
kernel: [   81.992528] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [   81.992529] task: ea7e4600 task.stack: ea780000
kernel: [   81.992531] EIP: dnotify_flush+0xe/0xe0
kernel: [   81.992531] EFLAGS: 00010246 CPU: 6
kernel: [   81.992532] EAX: e67ddbc0 EBX: e67ddbc0 ECX: 00000000 EDX: ea596000
kernel: [   81.992533] ESI: ea596000 EDI: 00000000 EBP: ea781e5c ESP: ea781e50
kernel: [   81.992534]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [   81.992535] CR0: 80050033 CR2: 00000000 CR3: 2cfdf2c0 CR4: 003406f0
kernel: [   81.992535] Call Trace:
kernel: [   81.992538]  filp_close+0x35/0x70
kernel: [   81.992540]  do_close_on_exec+0xa9/0xf0
kernel: [   81.992542]  flush_old_exec+0x493/0x610
kernel: [   81.992545]  load_elf_binary+0x28e/0x10d0
kernel: [   81.992547]  ? page_address+0xcc/0xf0
kernel: [   81.992549]  ? __inode_permission+0x40/0xc0
kernel: [   81.992550]  search_binary_handler+0x75/0x1a0
kernel: [   81.992551]  do_execveat_common+0x551/0x690
kernel: [   81.992552]  SyS_execve+0x24/0x30
kernel: [   81.992555]  do_int80_syscall_32+0x3d/0xa0
kernel: [   81.992557]  entry_INT80_32+0x31/0x31
kernel: [   81.992558] EIP: 0xb7538394
kernel: [   81.992559] EFLAGS: 00000296 CPU: 6
kernel: [   81.992559] EAX: ffffffda EBX: bfb7e5d0 ECX: bfb7dfd0 EDX: 083ddf30
kernel: [   81.992560] ESI: bfb7dfd0 EDI: 00000008 EBP: ffffffff ESP: bfb7df08
kernel: [   81.992561]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [   81.992561] Code: e8 18 ff ff ff eb a7 8d b6 00 00 00 00 0f 0b 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 0f 1f 44 00 00 55 89 e5 57 56 53 8b 78 10 <0f> b7 0f 66 81 e1 00 f0 66 
81 f9 00 40 74 0b 5b 5e 5f 5d c3 8d
kernel: [   81.992578] EIP: dnotify_flush+0xe/0xe0 SS:ESP: 0068:ea781e50
kernel: [   81.992579] CR2: 0000000000000000
kernel: [   81.992580] ---[ end trace 04eede085ec6ee5e ]---
kernel: [   81.992612] BUG: unable to handle kernel NULL pointer dereference at   (null)
kernel: [   81.992614] IP: do_readv_writev+0x2d3/0x480
kernel: [   81.992615] *pdpt = 000000002a3d4001 *pde = 0000000000000000 
kernel: [   81.992615] 
kernel: [   81.992616] Oops: 0000 [#4] SMP
kernel: [   81.992616] Modules linked in:
kernel: [   81.992618] CPU: 6 PID: 1156 Comm: udevd Tainted: G      D         4.12.0-mike-1mike+ #150
kernel: [   81.992618] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [   81.992619] task: e7959e00 task.stack: e6470000
kernel: [   81.992620] EIP: do_readv_writev+0x2d3/0x480
kernel: [   81.992621] EFLAGS: 00010202 CPU: 6
kernel: [   81.992621] EAX: e67ddbc0 EBX: 00000000 ECX: 00000052 EDX: 00000000
kernel: [   81.992622] ESI: e67ddbc0 EDI: 00000001 EBP: e6471f3c ESP: e6471eb0
kernel: [   81.992623]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [   81.992623] CR0: 80050033 CR2: 00000000 CR3: 2ba78700 CR4: 003406f0
kernel: [   81.992624] Call Trace:
kernel: [   81.992626]  vfs_writev+0x30/0x60
kernel: [   81.992627]  do_writev+0x44/0xc0
kernel: [   81.992628]  SyS_writev+0x18/0x20
kernel: [   81.992629]  do_int80_syscall_32+0x3d/0xa0
kernel: [   81.992631]  entry_INT80_32+0x31/0x31
kernel: [   81.992631] EIP: 0xb75713a8
kernel: [   81.992632] EFLAGS: 00000246 CPU: 6
kernel: [   81.992632] EAX: ffffffda EBX: 0000000a ECX: bfb7d630 EDX: 00000005
kernel: [   81.992633] ESI: bfb7d5ec EDI: 0000000a EBP: bfb7d688 ESP: bfb7d560
kernel: [   81.992633]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [   81.992634] Code: 00 8d bc 27 00 00 00 00 8b 8b a4 00 00 00 8b 09 f6 41 0d 20 0f 85 74 fe ff ff e9 72 fe ff ff 89 f6 8d bc 27 00 00 00 00 8b 50 10 <0f> b7 02 66 25 00 f0 66 3d 
00 80 0f 84 16 01 00 00 8b 85 78 ff
kernel: [   81.992649] EIP: do_readv_writev+0x2d3/0x480 SS:ESP: 0068:e6471eb0
kernel: [   81.992649] CR2: 0000000000000000
kernel: [   81.992650] ---[ end trace 04eede085ec6ee5f ]---
kernel: [   81.992799] BUG: unable to handle kernel NULL pointer dereference at   (null)
kernel: [   81.992801] IP: dnotify_flush+0xe/0xe0
kernel: [   81.992801] *pdpt = 0000000000000000 *pde = f000eef3f000eef3 
kernel: [   81.992802] 
kernel: [   81.992803] Oops: 0000 [#5] SMP
kernel: [   81.992803] Modules linked in:
kernel: [   81.992804] CPU: 6 PID: 1156 Comm: udevd Tainted: G      D         4.12.0-mike-1mike+ #150
kernel: [   81.992804] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [   81.992805] task: e7959e00 task.stack: e6470000
kernel: [   81.992806] EIP: dnotify_flush+0xe/0xe0
kernel: [   81.992807] EFLAGS: 00010246 CPU: 6
kernel: [   81.992807] EAX: e67ddbc0 EBX: e67ddbc0 ECX: 00000000 EDX: e649da00
kernel: [   81.992808] ESI: e649da00 EDI: 00000000 EBP: e6471f38 ESP: e6471f2c
kernel: [   81.992808]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [   81.992809] CR0: 80050033 CR2: 00000000 CR3: 01f22000 CR4: 003406f0
kernel: [   81.992809] Call Trace:
kernel: [   81.992810]  filp_close+0x35/0x70
kernel: [   81.992811]  put_files_struct+0x6a/0xd0
kernel: [   81.992813]  exit_files+0x39/0x40
kernel: [   81.992814]  do_exit+0x69f/0xa00
kernel: [   81.992815]  rewind_stack_do_exit+0x11/0x13
kernel: [   81.992816] EIP: 0xb75713a8
kernel: [   81.992816] EFLAGS: 00000246 CPU: 6
kernel: [   81.992817] EAX: ffffffda EBX: 0000000a ECX: bfb7d630 EDX: 00000005
kernel: [   81.992817] ESI: bfb7d5ec EDI: 0000000a EBP: bfb7d688 ESP: bfb7d560
kernel: [   81.992818]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [   81.992818] Code: e8 18 ff ff ff eb a7 8d b6 00 00 00 00 0f 0b 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 0f 1f 44 00 00 55 89 e5 57 56 53 8b 78 10 <0f> b7 0f 66 81 e1 00 f0 66 
81 f9 00 40 74 0b 5b 5e 5f 5d c3 8d
kernel: [   81.992833] EIP: dnotify_flush+0xe/0xe0 SS:ESP: 0068:e6471f2c
kernel: [   81.992833] CR2: 0000000000000000
kernel: [   81.992834] ---[ end trace 04eede085ec6ee60 ]---

------------------------------

kernel: [   79.929907] BUG: unable to handle kernel NULL pointer dereference at 00000004
kernel: [   79.930929] IP: bio_uncopy_user+0xab/0x120
kernel: [   79.931513] *pdpt = 00000000272eb001 *pde = 0000000000000000 
kernel: [   79.931515] 
kernel: [   79.932544] Oops: 0000 [#1] SMP
kernel: [   79.932990] Modules linked in:
kernel: [   79.933436] CPU: 2 PID: 1286 Comm: ata_id Not tainted 4.12.0-mike-1mike+ #151
kernel: [   79.934453] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [   79.935797] task: ecea1e00 task.stack: e9afe000
kernel: [   79.936450] EIP: bio_uncopy_user+0xab/0x120
kernel: [   79.937048] EFLAGS: 00010246 CPU: 2
kernel: [   79.937543] EAX: ecea1e00 EBX: ea7f8300 ECX: 00000000 EDX: 802a0024
kernel: [   79.938426] ESI: 00000000 EDI: 00000000 EBP: e9affd78 ESP: e9affd4c
kernel: [   79.939311]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [   79.940079] CR0: 80050033 CR2: 00000004 CR3: 2cfee1c0 CR4: 003406f0
kernel: [   79.940959] Call Trace:
kernel: [   79.941308]  ? mempool_free+0x23/0x80
kernel: [   79.941827]  __blk_rq_unmap_user+0x17/0x40
kernel: [   79.942409]  blk_rq_unmap_user+0x27/0x60
kernel: [   79.942963]  sg_io+0x1f7/0x390
kernel: [   79.943397]  scsi_cmd_ioctl+0x26a/0x3f0
kernel: [   79.943943]  ? path_openat+0x4f9/0x11f0
kernel: [   79.944497]  scsi_cmd_blk_ioctl+0x30/0x40
kernel: [   79.945075]  sd_ioctl+0x63/0x90
kernel: [   79.945526]  ? scsi_disk_put+0x40/0x40
kernel: [   79.946059]  blkdev_ioctl+0x47a/0x9a0
kernel: [   79.946581]  ? do_filp_open+0x73/0xb0
kernel: [   79.947096]  block_ioctl+0x34/0x40
kernel: [   79.947574]  ? __fd_install+0x19/0xb0
kernel: [   79.948094]  ? block_ioctl+0x34/0x40
kernel: [   79.948597]  ? blkdev_fallocate+0x220/0x220
kernel: [   79.949186]  do_vfs_ioctl+0x81/0x610
kernel: [   79.949691]  ? putname+0x4f/0x60
kernel: [   79.950145]  ? putname+0x4f/0x60
kernel: [   79.950601]  ? do_sys_open+0x139/0x230
kernel: [   79.972240]  SyS_ioctl+0x58/0x70
kernel: [   79.993991]  do_int80_syscall_32+0x3d/0xa0
kernel: [   80.015751]  entry_INT80_32+0x31/0x31
kernel: [   80.037380] EIP: 0xb76352c4
kernel: [   80.059040] EFLAGS: 00000246 CPU: 2
kernel: [   80.080855] EAX: ffffffda EBX: 00000003 ECX: 00002285 EDX: bfd11700
kernel: [   80.103422] ESI: bfd11f12 EDI: bfd11740 EBP: bfd11c18 ESP: bfd11668
kernel: [   80.125851]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [   80.148218] Code: d4 8d 65 f4 5b 5e 5f 5d c3 8d b4 26 00 00 00 00 c7 45 d4 00 00 00 00 eb d6 8d b4 26 00 00 00 00 8b 4d d8 66 83 7b 50 00 8b 73 58 <8b> 41 04 89 45 dc 8b 41 08 
89 45 e0 8b 41 0c 89 45 e4 8b 41 10
kernel: [   80.196435] EIP: bio_uncopy_user+0xab/0x120 SS:ESP: 0068:e9affd4c
kernel: [   80.220501] CR2: 0000000000000004
kernel: [   80.244443] ---[ end trace 0e2ebd225c476c75 ]---
kernel: [   80.244443] BUG: unable to handle kernel paging request at 000270b8
kernel: [   80.244450] IP: get_unmapped_area.part.35+0x2a/0xb0
kernel: [   80.244450] *pdpt = 0000000027b43001 *pde = 0000000000000000 
kernel: [   80.244451] 
kernel: [   80.244452] Oops: 0000 [#2] SMP
kernel: [   80.244453] Modules linked in:
kernel: [   80.244455] CPU: 6 PID: 1303 Comm: udisks-part-id Tainted: G      D         4.12.0-mike-1mike+ #151
kernel: [   80.244456] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [   80.244457] task: e7268a00 task.stack: e7a1a000
kernel: [   80.244458] EIP: get_unmapped_area.part.35+0x2a/0xb0
kernel: [   80.244459] EFLAGS: 00010282 CPU: 6
kernel: [   80.244460] EAX: ea7f9c80 EBX: c11c0af0 ECX: 0002706c EDX: 08048000
kernel: [   80.244460] ESI: 00008000 EDI: 00000000 EBP: e7a1be00 ESP: e7a1bdf0
kernel: [   80.244461]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [   80.244462] CR0: 80050033 CR2: 000270b8 CR3: 2cfee780 CR4: 003406f0
kernel: [   80.244462] Call Trace:
kernel: [   80.244464]  do_mmap+0xef/0x310
kernel: [   80.244466]  ? expand_downwards+0x93/0x290
kernel: [   80.244467]  vm_mmap_pgoff+0x86/0xc0
kernel: [   80.244468]  vm_mmap+0x34/0x50
kernel: [   80.244471]  elf_map+0x80/0xa0
kernel: [   80.244472]  load_elf_binary+0x58c/0x10d0
kernel: [   80.244474]  ? __inode_permission+0x40/0xc0
kernel: [   80.244475]  search_binary_handler+0x75/0x1a0
kernel: [   80.244476]  do_execveat_common+0x551/0x690
kernel: [   80.244477]  SyS_execve+0x24/0x30
kernel: [   80.244478]  do_int80_syscall_32+0x3d/0xa0
kernel: [   80.244480]  entry_INT80_32+0x31/0x31
kernel: [   80.244481] EIP: 0xb75a0394
kernel: [   80.244482] EFLAGS: 00000292 CPU: 6
kernel: [   80.244482] EAX: ffffffda EBX: bfc090e0 ECX: bfc08ae0 EDX: 09093180
kernel: [   80.244483] ESI: bfc08ae0 EDI: 00000008 EBP: ffffffff ESP: bfc08a18
kernel: [   80.244483]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [   80.244483] Code: 00 0f 1f 44 00 00 55 89 e5 57 56 53 89 ce 64 8b 0d a8 69 f0 c1 83 ec 04 8b 89 6c 02 00 00 85 c0 8b 7d 08 8b 59 0c 74 59 8b 48 14 <8b> 49 4c 85 c9 0f 45 d9 ff 
75 0c 89 f1 57 ff d3 89 c3 81 fb 00
kernel: [   80.244497] EIP: get_unmapped_area.part.35+0x2a/0xb0 SS:ESP: 0068:e7a1bdf0
kernel: [   80.244497] CR2: 00000000000270b8
kernel: [   80.244498] ---[ end trace 0e2ebd225c476c76 ]---

------------------------------

kernel: [   96.485415] BUG: unable to handle kernel NULL pointer dereference at 00000004
kernel: [   96.516002] IP: bio_uncopy_user+0xab/0x120
kernel: [   96.545434] *pdpt = 0000000028891001 *pde = 0000000000000000 
kernel: [   96.545435] 
kernel: [   96.603817] Oops: 0000 [#1] SMP
kernel: [   96.632217] Modules linked in:
kernel: [   96.660043] CPU: 4 PID: 1949 Comm: ata_id Not tainted 4.12.0-mike-1mike+ #155
kernel: [   96.688444] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [   96.717374] task: ec7b6180 task.stack: e7682000
kernel: [   96.745900] EIP: bio_uncopy_user+0xab/0x120
kernel: [   96.774077] EFLAGS: 00010246 CPU: 4
kernel: [   96.801599] EAX: ec7b6180 EBX: e6a06cc0 ECX: 00000000 EDX: 00006ac1
kernel: [   96.830191] ESI: 00000000 EDI: 00000000 EBP: e7683d78 ESP: e7683d4c
kernel: [   96.858817]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [   96.887478] CR0: 80050033 CR2: 00000004 CR3: 2cfc3060 CR4: 003406f0
kernel: [   96.916671] Call Trace:
kernel: [   96.945743]  ? mempool_free+0x23/0x80
kernel: [   96.975049]  __blk_rq_unmap_user+0x17/0x40
kernel: [   97.004159]  blk_rq_unmap_user+0x27/0x60
kernel: [   97.033087]  sg_io+0x1f7/0x390
kernel: [   97.062137]  scsi_cmd_ioctl+0x26a/0x3f0
kernel: [   97.091237]  ? path_openat+0x4f9/0x11f0
kernel: [   97.120195]  scsi_cmd_blk_ioctl+0x30/0x40
kernel: [   97.149224]  sd_ioctl+0x63/0x90
kernel: [   97.177933]  ? scsi_disk_put+0x40/0x40
kernel: [   97.206493]  blkdev_ioctl+0x47a/0x9a0
kernel: [   97.234640]  ? do_filp_open+0x73/0xb0
kernel: [   97.262469]  block_ioctl+0x34/0x40
kernel: [   97.289935]  ? __fd_install+0x19/0xb0
kernel: [   97.317087]  ? block_ioctl+0x34/0x40
kernel: [   97.343791]  ? blkdev_fallocate+0x220/0x220
kernel: [   97.370195]  do_vfs_ioctl+0x81/0x610
kernel: [   97.396261]  ? putname+0x4f/0x60
kernel: [   97.421888]  ? putname+0x4f/0x60
kernel: [   97.446930]  ? do_sys_open+0x139/0x230
kernel: [   97.471980]  SyS_ioctl+0x58/0x70
kernel: [   97.496542]  do_int80_syscall_32+0x3d/0xa0
kernel: [   97.520851]  entry_INT80_32+0x31/0x31
kernel: [   97.544788] EIP: 0xb76322c4
kernel: [   97.568303] EFLAGS: 00000246 CPU: 4
kernel: [   97.591502] EAX: ffffffda EBX: 00000003 ECX: 00002285 EDX: bf82e300
kernel: [   97.615023] ESI: bf82ef12 EDI: bf82e340 EBP: bf82e818 ESP: bf82e268
kernel: [   97.638252]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [   97.661285] Code: d4 8d 65 f4 5b 5e 5f 5d c3 8d b4 26 00 00 00 00 c7 45 d4 00 00 00 00 eb d6 8d b4 26 00 00 00 00 8b 4d d8 66 83 7b 50 00 8b 73 58 <8b> 41 04 89 45 dc 8b 41 08 
89 45 e0 8b 41 0c 89 45 e4 8b 41 10
kernel: [   97.710312] EIP: bio_uncopy_user+0xab/0x120 SS:ESP: 0068:e7683d4c
kernel: [   97.735346] CR2: 0000000000000004
kernel: [   97.760249] ---[ end trace f4dc4e3e471c91b4 ]---
kernel: [  100.153930] ------------[ cut here ]------------
kernel: [  100.153935] WARNING: CPU: 4 PID: 1984 at kernel/rcu/tree.c:2834 rcu_process_callbacks+0x3e0/0x400
kernel: [  100.153935] Modules linked in:
kernel: [  100.153938] CPU: 4 PID: 1984 Comm: syslogd Tainted: G      D         4.12.0-mike-1mike+ #155
kernel: [  100.153939] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [  100.153940] task: e6a94440 task.stack: e7f40000
kernel: [  100.153942] EIP: rcu_process_callbacks+0x3e0/0x400
kernel: [  100.153942] EFLAGS: 00010002 CPU: 4
kernel: [  100.153943] EAX: 00000000 EBX: f78ff900 ECX: 00000017 EDX: 00000001
kernel: [  100.153944] ESI: f78ff920 EDI: c1d65540 EBP: ecdd9fc8 ESP: ecdd9f9c
kernel: [  100.153945]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [  100.153946] CR0: 80050033 CR2: b75860a0 CR3: 2c422b60 CR4: 003406f0
kernel: [  100.153946] Call Trace:
kernel: [  100.153948]  <SOFTIRQ>
kernel: [  100.153951]  __do_softirq+0xb1/0x26d
kernel: [  100.153953]  ? __softirqentry_text_start+0x8/0x8
kernel: [  100.153955]  do_softirq_own_stack+0x24/0x30
kernel: [  100.153955]  </SOFTIRQ>
kernel: [  100.153957]  irq_exit+0xad/0xc0
kernel: [  100.153958]  smp_apic_timer_interrupt+0x38/0x50
kernel: [  100.153960]  apic_timer_interrupt+0x39/0x40
kernel: [  100.153962] EIP: cfb_imageblit+0x4ce/0x530
kernel: [  100.153963] EFLAGS: 00000246 CPU: 4
kernel: [  100.153963] EAX: 00000000 EBX: f88c62dc ECX: 00000000 EDX: 00000018
kernel: [  100.153964] ESI: 00000000 EDI: c1a08488 EBP: e7f41bc4 ESP: e7f41b6c
kernel: [  100.153965]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [  100.153967]  ? __enqueue_entity+0x6d/0x80
kernel: [  100.153969]  bit_putcs+0x24e/0x3e0
kernel: [  100.153971]  ? hdmi_infoframe_log+0x6f/0x5a0
kernel: [  100.153972]  ? bit_clear+0xe0/0xe0
kernel: [  100.153974]  fbcon_putcs+0xbe/0xf0
kernel: [  100.153974]  ? bit_clear+0xe0/0xe0
kernel: [  100.153976]  fbcon_redraw.isra.22+0xd0/0x190
kernel: [  100.153977]  fbcon_scroll+0x2f6/0xd00
kernel: [  100.153979]  con_scroll+0x61/0x170
kernel: [  100.153981]  lf+0x7f/0x90
kernel: [  100.153982]  ? atomic_notifier_call_chain+0x14/0x20
kernel: [  100.153984]  do_con_write.part.25+0x3c0/0x1ed0
kernel: [  100.153985]  con_write+0x57/0x60
kernel: [  100.153987]  do_output_char+0x18d/0x210
kernel: [  100.153988]  n_tty_write+0x1b7/0x3e0
kernel: [  100.153990]  ? do_wait_intr_irq+0x80/0x80
kernel: [  100.153991]  ? process_echoes+0x60/0x60
kernel: [  100.153992]  tty_write+0x178/0x300
kernel: [  100.153993]  ? process_echoes+0x60/0x60
kernel: [  100.153995]  do_readv_writev+0x383/0x480
kernel: [  100.153997]  vfs_writev+0x30/0x60
kernel: [  100.153998]  do_writev+0x44/0xc0
kernel: [  100.153999]  SyS_writev+0x18/0x20
kernel: [  100.154001]  do_int80_syscall_32+0x3d/0xa0
kernel: [  100.154002]  entry_INT80_32+0x31/0x31
kernel: [  100.154003] EIP: 0xb768f3a8
kernel: [  100.154003] EFLAGS: 00000246 CPU: 4
kernel: [  100.154004] EAX: ffffffda EBX: 00000009 ECX: bfef042c EDX: 00000006
kernel: [  100.154004] ESI: bfef042c EDI: bfef01fb EBP: 08535948 ESP: bfef00f0
kernel: [  100.154005]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [  100.154006] Code: 8b 0b 89 f6 8d bc 27 00 00 00 00 8b 43 04 83 c3 0c 89 f2 ff d1 8b 0b 85 c9 75 f0 e9 5a fc ff ff 8d 76 00 0f ff e9 34 fd ff ff 90 <0f> ff e9 03 fe ff ff 8b 55 
e0 89 f0 e8 ff 77 88 00 e9 a1 fc ff
kernel: [  100.154022] ---[ end trace f4dc4e3e471c91b5 ]---
kernel: [  105.458911] BUG: unable to handle kernel NULL pointer dereference at 00000004
kernel: [  105.458916] IP: bio_uncopy_user+0xab/0x120
kernel: [  105.458916] *pdpt = 000000002a064001 *pde = 0000000000000000 
kernel: [  105.458917] 
kernel: [  105.458918] Oops: 0000 [#2] SMP
kernel: [  105.458919] Modules linked in:
kernel: [  105.458922] CPU: 1 PID: 3727 Comm: ata_id Tainted: G      D W       4.12.0-mike-1mike+ #155
kernel: [  105.458923] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [  105.458923] task: e749c440 task.stack: e7174000
kernel: [  105.458924] EIP: bio_uncopy_user+0xab/0x120
kernel: [  105.458925] EFLAGS: 00010246 CPU: 1
kernel: [  105.458926] EAX: e749c440 EBX: ea5e3440 ECX: 00000000 EDX: 0000aab0
kernel: [  105.458926] ESI: 00000000 EDI: 00000000 EBP: e7175d0c ESP: e7175ce0
kernel: [  105.458927]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [  105.458928] CR0: 80050033 CR2: 00000004 CR3: 2cfc34c0 CR4: 003406f0
kernel: [  105.458928] Call Trace:
kernel: [  105.458931]  ? mempool_free+0x23/0x80
kernel: [  105.458933]  __blk_rq_unmap_user+0x17/0x40
kernel: [  105.458934]  blk_rq_unmap_user+0x27/0x60
kernel: [  105.458936]  sg_io+0x1f7/0x390
kernel: [  105.458937]  scsi_cmd_ioctl+0x26a/0x3f0
kernel: [  105.458939]  scsi_cmd_blk_ioctl+0x30/0x40
kernel: [  105.458941]  cdrom_ioctl+0x2c/0xaa0
kernel: [  105.458943]  ? path_openat+0x4f9/0x11f0
kernel: [  105.458945]  ? scsi_block_when_processing_errors+0x13/0xb0
kernel: [  105.458947]  sr_block_ioctl+0x68/0xb0
kernel: [  105.458948]  ? sr_block_check_events+0x30/0x30
kernel: [  105.458949]  blkdev_ioctl+0x47a/0x9a0
kernel: [  105.458950]  ? do_filp_open+0x73/0xb0
kernel: [  105.458952]  block_ioctl+0x34/0x40
kernel: [  105.458953]  ? block_ioctl+0x34/0x40
kernel: [  105.458954]  ? blkdev_fallocate+0x220/0x220
kernel: [  105.458955]  do_vfs_ioctl+0x81/0x610
kernel: [  105.458956]  ? putname+0x4f/0x60
kernel: [  105.458957]  ? putname+0x4f/0x60
kernel: [  105.458958]  ? do_sys_open+0x139/0x230
kernel: [  105.458959]  SyS_ioctl+0x58/0x70
kernel: [  105.458961]  do_int80_syscall_32+0x3d/0xa0
kernel: [  105.458963]  entry_INT80_32+0x31/0x31
kernel: [  105.458964] EIP: 0xb762c2c4
kernel: [  105.458965] EFLAGS: 00000246 CPU: 1
kernel: [  105.458965] EAX: ffffffda EBX: 00000003 ECX: 00002285 EDX: bfe4f900
kernel: [  105.458966] ESI: bfe50d47 EDI: bfe4f940 EBP: bfe4fe18 ESP: bfe4f868
kernel: [  105.458966]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [  105.458967] Code: d4 8d 65 f4 5b 5e 5f 5d c3 8d b4 26 00 00 00 00 c7 45 d4 00 00 00 00 eb d6 8d b4 26 00 00 00 00 8b 4d d8 66 83 7b 50 00 8b 73 58 <8b> 41 04 89 45 dc 8b 41 08 
89 45 e0 8b 41 0c 89 45 e4 8b 41 10
kernel: [  105.458981] EIP: bio_uncopy_user+0xab/0x120 SS:ESP: 0068:e7175ce0
kernel: [  105.458982] CR2: 0000000000000004
kernel: [  105.458983] ---[ end trace f4dc4e3e471c91b6 ]---

------------------------------

kernel: [   97.963313] BUG: unable to handle kernel NULL pointer dereference at 0000002d
kernel: [   97.967108] VFS: Close: file count is 0
kernel: [   97.967109] VFS: Close: file count is 0
kernel: [   97.967109] VFS: Close: file count is 0
kernel: [   98.090800] IP: bio_uncopy_user+0xab/0x120
kernel: [   98.120839] *pdpt = 0000000027859001 *pde = 0000000000000000 
kernel: [   98.120840] 
kernel: [   98.180888] Oops: 0000 [#1] SMP
kernel: [   98.210465] Modules linked in:
kernel: [   98.239850] CPU: 4 PID: 1390 Comm: ata_id Not tainted 4.12.0-rc5-mike-1mike+ #156
kernel: [   98.270162] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [   98.301195] task: e780ce00 task.stack: e75fa000
kernel: [   98.331880] EIP: bio_uncopy_user+0xab/0x120
kernel: [   98.362206] EFLAGS: 00010246 CPU: 4
kernel: [   98.392237] EAX: e780ce00 EBX: e78bc9c0 ECX: 00000029 EDX: 802a0024
kernel: [   98.422897] ESI: 00000000 EDI: 00000000 EBP: e75fbd78 ESP: e75fbd4c
kernel: [   98.453651]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [   98.484450] CR0: 80050033 CR2: 0000002d CR3: 26aa62a0 CR4: 003406f0
kernel: [   98.515539] Call Trace:
kernel: [   98.546078]  ? mempool_free+0x23/0x80
kernel: [   98.576142]  __blk_rq_unmap_user+0x17/0x40
kernel: [   98.605737]  blk_rq_unmap_user+0x27/0x60
kernel: [   98.635187]  sg_io+0x1f7/0x390
kernel: [   98.664052]  scsi_cmd_ioctl+0x26a/0x3f0
kernel: [   98.692690]  ? path_openat+0x4f9/0x11f0
kernel: [   98.720210]  scsi_cmd_blk_ioctl+0x30/0x40
kernel: [   98.746760]  sd_ioctl+0x63/0x90
kernel: [   98.772963]  ? scsi_disk_put+0x40/0x40
kernel: [   98.798541]  blkdev_ioctl+0x47a/0x9a0
kernel: [   98.823661]  ? do_filp_open+0x73/0xb0
kernel: [   98.848256]  block_ioctl+0x34/0x40
kernel: [   98.872306]  ? __fd_install+0x19/0xb0
kernel: [   98.895830]  ? block_ioctl+0x34/0x40
kernel: [   98.918815]  ? blkdev_fallocate+0x220/0x220
kernel: [   98.941392]  do_vfs_ioctl+0x81/0x610
kernel: [   98.963265]  ? putname+0x4f/0x60
kernel: [   98.985423]  ? putname+0x4f/0x60
kernel: [   99.007143]  ? do_sys_open+0x139/0x230
kernel: [   99.028775]  SyS_ioctl+0x58/0x70
kernel: [   99.050478]  do_int80_syscall_32+0x3d/0xa0
kernel: [   99.072492]  entry_INT80_32+0x31/0x31
kernel: [   99.094438] EIP: 0xb76462c4
kernel: [   99.115981] EFLAGS: 00000246 CPU: 4
kernel: [   99.137343] EAX: ffffffda EBX: 00000003 ECX: 00002285 EDX: bfd04100
kernel: [   99.159623] ESI: bfd05f12 EDI: bfd04140 EBP: bfd04618 ESP: bfd04068
kernel: [   99.181758]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [   99.203841] Code: d4 8d 65 f4 5b 5e 5f 5d c3 8d b4 26 00 00 00 00 c7 45 d4 00 00 00 00 eb d6 8d b4 26 00 00 00 00 8b 4d d8 66 83 7b 50 00 8b 73 58 <8b> 41 04 89 45 dc 8b 41 08 
89 45 e0 8b 41 0c 89 45 e4 8b 41 10
kernel: [   99.250883] EIP: bio_uncopy_user+0xab/0x120 SS:ESP: 0068:e75fbd4c
kernel: [   99.274213] CR2: 000000000000002d
kernel: [   99.297787] ---[ end trace adb9edb57fc9ea71 ]---

------------------------------

kernel: [   78.216015] BUG: unable to handle kernel NULL pointer dereference at 00000004
kernel: [   78.249107] IP: bio_uncopy_user+0xab/0x120
kernel: [   78.249110] *pdpt = 00000000270cc001 *pde = 0000000000000000 
kernel: [   78.249111] 
kernel: [   78.249112] Oops: 0000 [#1] SMP
kernel: [   78.249113] Modules linked in:
kernel: [   78.249116] CPU: 8 PID: 1187 Comm: ata_id Not tainted 4.12.0-rc5-mike-1mike+ #157
kernel: [   78.249116] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [   78.249117] task: e888d7c0 task.stack: e7c42000
kernel: [   78.249118] EIP: bio_uncopy_user+0xab/0x120
kernel: [   78.249119] EFLAGS: 00010246 CPU: 8
kernel: [   78.249120] EAX: e888d7c0 EBX: ea5958c0 ECX: 00000000 EDX: 802a0026
kernel: [   78.249120] ESI: 00000000 EDI: 00000000 EBP: e7c43d78 ESP: e7c43d4c
kernel: [   78.249121]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [   78.249121] CR0: 80050033 CR2: 00000004 CR3: 2c509660 CR4: 003406f0
kernel: [   78.249122] Call Trace:
kernel: [   78.249126]  ? mempool_free+0x23/0x80
kernel: [   78.249128]  __blk_rq_unmap_user+0x17/0x40
kernel: [   78.249129]  blk_rq_unmap_user+0x27/0x60
kernel: [   78.249130]  sg_io+0x1f7/0x390
kernel: [   78.249131]  scsi_cmd_ioctl+0x26a/0x3f0
kernel: [   78.249134]  ? path_openat+0x4f9/0x11f0
kernel: [   78.249135]  scsi_cmd_blk_ioctl+0x30/0x40
kernel: [   78.249137]  sd_ioctl+0x63/0x90
kernel: [   78.249137]  ? scsi_disk_put+0x40/0x40
kernel: [   78.249138]  blkdev_ioctl+0x47a/0x9a0
kernel: [   78.249139]  ? do_filp_open+0x73/0xb0
kernel: [   78.249141]  block_ioctl+0x34/0x40
kernel: [   78.249142]  ? __fd_install+0x19/0xb0
kernel: [   78.249143]  ? block_ioctl+0x34/0x40
kernel: [   78.249143]  ? blkdev_fallocate+0x220/0x220
kernel: [   78.249145]  do_vfs_ioctl+0x81/0x610
kernel: [   78.249146]  ? putname+0x4f/0x60
kernel: [   78.249146]  ? putname+0x4f/0x60
kernel: [   78.249148]  ? do_sys_open+0x139/0x230
kernel: [   78.249149]  SyS_ioctl+0x58/0x70
kernel: [   78.249151]  do_int80_syscall_32+0x3d/0xa0
kernel: [   78.249153]  entry_INT80_32+0x31/0x31
kernel: [   78.249154] EIP: 0xb75d42c4
kernel: [   78.249154] EFLAGS: 00000246 CPU: 8
kernel: [   78.249154] EAX: ffffffda EBX: 00000003 ECX: 00002285 EDX: bfab3f00
kernel: [   78.249155] ESI: bfab4f12 EDI: bfab3f40 EBP: bfab4418 ESP: bfab3e68
kernel: [   78.249155]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [   78.249156] Code: d4 8d 65 f4 5b 5e 5f 5d c3 8d b4 26 00 00 00 00 c7 45 d4 00 00 00 00 eb d6 8d b4 26 00 00 00 00 8b 4d d8 66 83 7b 50 00 8b 73 58 <8b> 41 04 89 45 dc 8b 41 08 
89 45 e0 8b 41 0c 89 45 e4 8b 41 10
kernel: [   78.249169] EIP: bio_uncopy_user+0xab/0x120 SS:ESP: 0068:e7c43d4c
kernel: [   78.249169] CR2: 0000000000000004
kernel: [   78.249170] ---[ end trace c674fe608b9a2cef ]---
kernel: [   79.904487] ------------[ cut here ]------------
kernel: [   79.904492] WARNING: CPU: 6 PID: 0 at kernel/rcu/tree.c:2834 rcu_process_callbacks+0x3e0/0x400
kernel: [   79.904492] Modules linked in:
kernel: [   79.904495] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G      D         4.12.0-rc5-mike-1mike+ #157
kernel: [   79.904496] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [   79.904497] task: ecd49380 task.stack: ecd54000
kernel: [   79.904498] EIP: rcu_process_callbacks+0x3e0/0x400
kernel: [   79.904499] EFLAGS: 00210002 CPU: 6
kernel: [   79.904499] EAX: 00000000 EBX: f792b900 ECX: 00000004 EDX: 00000001
kernel: [   79.904500] ESI: f792b920 EDI: c1d67540 EBP: ece0dfc8 ESP: ece0df9c
kernel: [   79.904501]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [   79.904501] CR0: 80050033 CR2: 08542e80 CR3: 2b23abe0 CR4: 003406f0
kernel: [   79.904502] Call Trace:
kernel: [   79.904503]  <SOFTIRQ>
kernel: [   79.904506]  __do_softirq+0xb1/0x26d
kernel: [   79.904508]  ? __softirqentry_text_start+0x8/0x8
kernel: [   79.904510]  do_softirq_own_stack+0x24/0x30
kernel: [   79.904510]  </SOFTIRQ>
kernel: [   79.904512]  irq_exit+0xad/0xc0
kernel: [   79.904513]  smp_apic_timer_interrupt+0x38/0x50
kernel: [   79.904515]  apic_timer_interrupt+0x39/0x40
kernel: [   79.904516] EIP: acpi_idle_do_entry+0x32/0x50
kernel: [   79.904517] EFLAGS: 00200246 CPU: 6
kernel: [   79.904518] EAX: 00000000 EBX: ec4c2c00 ECX: 00000001 EDX: 00000002
kernel: [   79.904518] ESI: 00000001 EDI: ec4c2c58 EBP: ecd55f00 ESP: ecd55ee0
kernel: [   79.904519]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [   79.904521]  ? acpi_idle_enter+0xb1/0x210
kernel: [   79.904524]  cpuidle_enter_state+0x103/0x340
kernel: [   79.904525]  cpuidle_enter+0x14/0x20
kernel: [   79.904527]  call_cpuidle+0x21/0x40
kernel: [   79.904528]  do_idle+0x164/0x1a0
kernel: [   79.904529]  cpu_startup_entry+0x5d/0x60
kernel: [   79.904531]  start_secondary+0x12f/0x1a0
kernel: [   79.904533]  startup_32_smp+0x16b/0x16d
kernel: [   79.904533] Code: 8b 0b 89 f6 8d bc 27 00 00 00 00 8b 43 04 83 c3 0c 89 f2 ff d1 8b 0b 85 c9 75 f0 e9 5a fc ff ff 8d 76 00 0f ff e9 34 fd ff ff 90 <0f> ff e9 03 fe ff ff 8b 55 
e0 89 f0 e8 4f 6f 88 00 e9 a1 fc ff
kernel: [   79.904548] ---[ end trace c674fe608b9a2cf0 ]---

------------------------------

kernel: [  321.947093] BUG: unable to handle kernel NULL pointer dereference at 00000004
kernel: [  321.979748] IP: bio_uncopy_user+0xab/0x120
kernel: [  322.011523] *pdpt = 00000000288ce001 *pde = 0000000000000000 
kernel: [  322.011525] 
kernel: [  322.074245] Oops: 0000 [#1] SMP
kernel: [  322.104596] Modules linked in:
kernel: [  322.134658] CPU: 7 PID: 1881 Comm: ata_id Not tainted 4.12.0-rc5-mike-1mike+ #159
kernel: [  322.165576] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [  322.197263] task: e74ef500 task.stack: e884a000
kernel: [  322.228879] EIP: bio_uncopy_user+0xab/0x120
kernel: [  322.260383] EFLAGS: 00010246 CPU: 7
kernel: [  322.291570] EAX: e74ef500 EBX: ea349680 ECX: 00000000 EDX: 00005bbc
kernel: [  322.323073] ESI: 00000000 EDI: 00000000 EBP: e884bd78 ESP: e884bd4c
kernel: [  322.354320]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [  322.385451] CR0: 80050033 CR2: 00000004 CR3: 2c684da0 CR4: 003406f0
kernel: [  322.416937] Call Trace:
kernel: [  322.448142]  ? mempool_free+0x23/0x80
kernel: [  322.479417]  __blk_rq_unmap_user+0x17/0x40
kernel: [  322.510686]  blk_rq_unmap_user+0x27/0x60
kernel: [  322.541702]  sg_io+0x1f7/0x390
kernel: [  322.572004]  scsi_cmd_ioctl+0x26a/0x3f0
kernel: [  322.601853]  ? path_openat+0x4f9/0x11f0
kernel: [  322.631516]  scsi_cmd_blk_ioctl+0x30/0x40
kernel: [  322.660765]  sd_ioctl+0x63/0x90
kernel: [  322.689574]  ? scsi_disk_put+0x40/0x40
kernel: [  322.717383]  blkdev_ioctl+0x47a/0x9a0
kernel: [  322.744147]  ? do_filp_open+0x73/0xb0
kernel: [  322.770679]  block_ioctl+0x34/0x40
kernel: [  322.796452]  ? __fd_install+0x19/0xb0
kernel: [  322.821821]  ? block_ioctl+0x34/0x40
kernel: [  322.846648]  ? blkdev_fallocate+0x220/0x220
kernel: [  322.871077]  do_vfs_ioctl+0x81/0x610
kernel: [  322.894958]  ? putname+0x4f/0x60
kernel: [  322.918282]  ? putname+0x4f/0x60
kernel: [  322.940859]  ? do_sys_open+0x139/0x230
kernel: [  322.962827]  SyS_ioctl+0x58/0x70
kernel: [  322.985070]  do_int80_syscall_32+0x3d/0xa0
kernel: [  323.007327]  entry_INT80_32+0x31/0x31
kernel: [  323.029396] EIP: 0xb760a2c4
kernel: [  323.051477] EFLAGS: 00000246 CPU: 7
kernel: [  323.073718] EAX: ffffffda EBX: 00000003 ECX: 00002285 EDX: bf8c6700
kernel: [  323.096661] ESI: bf8c6f10 EDI: bf8c6740 EBP: bf8c6c18 ESP: bf8c6668
kernel: [  323.119447]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [  323.142191] Code: d4 8d 65 f4 5b 5e 5f 5d c3 8d b4 26 00 00 00 00 c7 45 d4 00 00 00 00 eb d6 8d b4 26 00 00 00 00 8b 4d d8 66 83 7b 50 00 8b 73 58 <8b> 41 04 89 45 dc 8b 41 08 
89 45 e0 8b 41 0c 89 45 e4 8b 41 10
kernel: [  323.191421] EIP: bio_uncopy_user+0xab/0x120 SS:ESP: 0068:e884bd4c
kernel: [  323.216369] CR2: 0000000000000004
kernel: [  323.241186] ---[ end trace a9050884aa2b54ec ]---
kernel: [  326.095066] BUG: unable to handle kernel NULL pointer dereference at 00000004
kernel: [  326.095072] IP: bio_uncopy_user+0xab/0x120
kernel: [  326.095073] *pdpt = 000000002a03f001 *pde = 0000000000000000 
kernel: [  326.095074] 
kernel: [  326.095075] Oops: 0000 [#2] SMP
kernel: [  326.095076] Modules linked in:
kernel: [  326.095078] CPU: 0 PID: 2851 Comm: ata_id Tainted: G      D         4.12.0-rc5-mike-1mike+ #159
kernel: [  326.095079] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [  326.095080] task: e70be180 task.stack: e6ac8000
kernel: [  326.095081] EIP: bio_uncopy_user+0xab/0x120
kernel: [  326.095081] EFLAGS: 00010246 CPU: 0
kernel: [  326.095082] EAX: e70be180 EBX: e7466f00 ECX: 00000000 EDX: 802a0020
kernel: [  326.095082] ESI: 00000000 EDI: 00000000 EBP: e6ac9d78 ESP: e6ac9d4c
kernel: [  326.095083]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [  326.095084] CR0: 80050033 CR2: 00000004 CR3: 2c4225c0 CR4: 003406f0
kernel: [  326.095084] Call Trace:
kernel: [  326.095087]  ? mempool_free+0x23/0x80
kernel: [  326.095089]  __blk_rq_unmap_user+0x17/0x40
kernel: [  326.095090]  blk_rq_unmap_user+0x27/0x60
kernel: [  326.095092]  sg_io+0x1f7/0x390
kernel: [  326.095093]  scsi_cmd_ioctl+0x26a/0x3f0
kernel: [  326.095095]  ? path_openat+0x4f9/0x11f0
kernel: [  326.095097]  scsi_cmd_blk_ioctl+0x30/0x40
kernel: [  326.095099]  sd_ioctl+0x63/0x90
kernel: [  326.095099]  ? scsi_disk_put+0x40/0x40
kernel: [  326.095100]  blkdev_ioctl+0x47a/0x9a0
kernel: [  326.095101]  ? do_filp_open+0x73/0xb0
kernel: [  326.095103]  block_ioctl+0x34/0x40
kernel: [  326.095104]  ? __fd_install+0x19/0xb0
kernel: [  326.095105]  ? block_ioctl+0x34/0x40
kernel: [  326.095105]  ? blkdev_fallocate+0x220/0x220
kernel: [  326.095107]  do_vfs_ioctl+0x81/0x610
kernel: [  326.095107]  ? putname+0x4f/0x60
kernel: [  326.095108]  ? putname+0x4f/0x60
kernel: [  326.095110]  ? do_sys_open+0x139/0x230
kernel: [  326.095111]  SyS_ioctl+0x58/0x70
kernel: [  326.095112]  do_int80_syscall_32+0x3d/0xa0
kernel: [  326.095115]  entry_INT80_32+0x31/0x31
kernel: [  326.095115] EIP: 0xb762e2c4
kernel: [  326.095116] EFLAGS: 00000246 CPU: 0
kernel: [  326.095116] EAX: ffffffda EBX: 00000003 ECX: 00002285 EDX: bfdf8900
kernel: [  326.095117] ESI: bfdfaf11 EDI: bfdf8940 EBP: bfdf8e18 ESP: bfdf8868
kernel: [  326.095117]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [  326.095118] Code: d4 8d 65 f4 5b 5e 5f 5d c3 8d b4 26 00 00 00 00 c7 45 d4 00 00 00 00 eb d6 8d b4 26 00 00 00 00 8b 4d d8 66 83 7b 50 00 8b 73 58 <8b> 41 04 89 45 dc 8b 41 08 
89 45 e0 8b 41 0c 89 45 e4 8b 41 10
kernel: [  326.095131] EIP: bio_uncopy_user+0xab/0x120 SS:ESP: 0068:e6ac9d4c
kernel: [  326.095131] CR2: 0000000000000004
kernel: [  326.095132] ---[ end trace a9050884aa2b54ed ]---
kernel: [  326.095549] BUG: unable to handle kernel NULL pointer dereference at 00000034
kernel: [  326.095551] IP: filp_close+0x19/0x70
kernel: [  326.095552] *pdpt = 000000002893b001 *pde = 0000000000000000 
kernel: [  326.095553] 
kernel: [  326.095554] Oops: 0000 [#3] SMP
kernel: [  326.095554] Modules linked in:
kernel: [  326.095556] CPU: 1 PID: 2855 Comm: udevd Tainted: G      D         4.12.0-rc5-mike-1mike+ #159
kernel: [  326.095557] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [  326.095557] task: e713a700 task.stack: e6ac8000
kernel: [  326.095558] EIP: filp_close+0x19/0x70
kernel: [  326.095559] EFLAGS: 00010286 CPU: 1
kernel: [  326.095559] EAX: 00000000 EBX: e7467ec0 ECX: 00000000 EDX: e88f7100
kernel: [  326.095560] ESI: e88f7100 EDI: bfba6210 EBP: e6ac9f70 ESP: e6ac9f64
kernel: [  326.095561]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [  326.095561] CR0: 80050033 CR2: 00000034 CR3: 2c422660 CR4: 003406f0
kernel: [  326.095561] Call Trace:
kernel: [  326.095563]  __close_fd+0x5e/0x80
kernel: [  326.095564]  SyS_close+0x1c/0x50
kernel: [  326.095565]  do_int80_syscall_32+0x3d/0xa0
kernel: [  326.095566]  entry_INT80_32+0x31/0x31
kernel: [  326.095566] EIP: 0xb755d7f0
kernel: [  326.095567] EFLAGS: 00000246 CPU: 1
kernel: [  326.095567] EAX: ffffffda EBX: 00000008 ECX: 00000000 EDX: 00000000
kernel: [  326.095568] ESI: bfba5c10 EDI: bfba6210 EBP: 0807604f ESP: bfba5b40
kernel: [  326.095568]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [  326.095569] Code: 01 00 5d c3 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 0f 1f 44 00 00 55 89 e5 57 56 53 89 c3 8b 40 20 85 c0 74 40 8b 43 14 89 d6 <8b> 48 34 85 c9 74 30 89 d8 
ff d1 89 c7 f6 43 29 40 75 12 89 f2
kernel: [  326.095581] EIP: filp_close+0x19/0x70 SS:ESP: 0068:e6ac9f64
kernel: [  326.095581] CR2: 0000000000000034
kernel: [  326.095582] ---[ end trace a9050884aa2b54ee ]---

kernel: [  326.095664] BUG: unable to handle kernel NULL pointer dereference at 00000020
kernel: [  326.095668] IP: ep_send_events_proc+0x5d/0x160
kernel: [  326.095668] *pdpt = 0000000026928001 *pde = 0000000000000000 
kernel: [  326.095669] 
kernel: [  326.095671] Oops: 0000 [#4] SMP
kernel: [  326.095671] Modules linked in:
kernel: [  326.095673] CPU: 2 PID: 1155 Comm: udevd Tainted: G      D         4.12.0-rc5-mike-1mike+ #159
kernel: [  326.095674] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [  326.095675] task: e90309c0 task.stack: e748e000
kernel: [  326.095677] EIP: ep_send_events_proc+0x5d/0x160
kernel: [  326.095677] EFLAGS: 00010246 CPU: 2
kernel: [  326.095678] EAX: e7467ec0 EBX: e93e6f8c ECX: 00000000 EDX: e748feb8
kernel: [  326.095679] ESI: e748fee4 EDI: 00000000 EBP: e748fecc ESP: e748fea8
kernel: [  326.095680]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [  326.095681] CR0: 80050033 CR2: 00000020 CR3: 2c422b40 CR4: 003406f0
kernel: [  326.095681] Call Trace:
kernel: [  326.095684]  ? ep_ptable_queue_proc+0x90/0x90
kernel: [  326.095686]  ep_scan_ready_list.constprop.15+0x7f/0x1c0
kernel: [  326.095687]  ? ep_ptable_queue_proc+0x90/0x90
kernel: [  326.095689]  ep_poll+0x18e/0x3a0
kernel: [  326.095691]  ? wake_up_q+0x60/0x60
kernel: [  326.095693]  SyS_epoll_pwait+0x143/0x1c0
kernel: [  326.095694]  ? ep_poll_wakeup_proc+0x20/0x20
kernel: [  326.095695]  do_int80_syscall_32+0x3d/0xa0
kernel: [  326.095697]  entry_INT80_32+0x31/0x31
kernel: [  326.095698] EIP: 0xb7570c7d
kernel: [  326.095698] EFLAGS: 00000246 CPU: 2
kernel: [  326.095699] EAX: ffffffda EBX: 0000000a ECX: bfba5be0 EDX: 00000004
kernel: [  326.095700] ESI: 0002c307 EDI: 00000000 EBP: 00000008 ESP: bfba5af0
kernel: [  326.095700]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [  326.095701] Code: 32 90 8d 74 26 00 89 f8 e8 b1 ab 39 00 8b 13 8b 43 04 89 42 04 89 10 8d 55 ec 8b 43 30 89 1b 89 5b 04 89 45 f0 8b 43 0c 8b 48 14 <ff> 51 20 23 43 30 75 63 8b 
06 39 c6 74 4b 8b 45 e4 8b 4d e8 39
kernel: [  326.095718] EIP: ep_send_events_proc+0x5d/0x160 SS:ESP: 0068:e748fea8
kernel: [  326.095719] CR2: 0000000000000020
kernel: [  326.095720] ---[ end trace a9050884aa2b54ef ]---
kernel: [  326.096049] BUG: unable to handle kernel NULL pointer dereference at 00000034
kernel: [  326.096052] IP: filp_close+0x19/0x70
kernel: [  326.096053] *pdpt = 0000000000000000 *pde = f000eef3f000eef3 
kernel: [  326.096054] 
kernel: [  326.096054] Oops: 0000 [#5] SMP
kernel: [  326.096055] Modules linked in:
kernel: [  326.096057] CPU: 2 PID: 1155 Comm: udevd Tainted: G      D         4.12.0-rc5-mike-1mike+ #159
kernel: [  326.096057] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [  326.096058] task: e90309c0 task.stack: e748e000
kernel: [  326.096058] EIP: filp_close+0x19/0x70
kernel: [  326.096059] EFLAGS: 00010286 CPU: 2
kernel: [  326.096060] EAX: 00000000 EBX: e7467ec0 ECX: 00000001 EDX: ea7ede00
kernel: [  326.096060] ESI: ea7ede00 EDI: ea7ede18 EBP: e748ff4c ESP: e748ff40
kernel: [  326.096061]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [  326.096061] CR0: 80050033 CR2: 00000034 CR3: 01f21000 CR4: 003406f0
kernel: [  326.096062] Call Trace:
kernel: [  326.096064]  put_files_struct+0x6a/0xd0
kernel: [  326.096065]  exit_files+0x39/0x40
kernel: [  326.096067]  do_exit+0x69f/0xa00
kernel: [  326.096068]  rewind_stack_do_exit+0x11/0x13
kernel: [  326.096069] EIP: 0xb7570c7d
kernel: [  326.096070] EFLAGS: 00000246 CPU: 2
kernel: [  326.096070] EAX: ffffffda EBX: 0000000a ECX: bfba5be0 EDX: 00000004
kernel: [  326.096071] ESI: 0002c307 EDI: 00000000 EBP: 00000008 ESP: bfba5af0
kernel: [  326.096071]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [  326.096072] Code: 01 00 5d c3 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 0f 1f 44 00 00 55 89 e5 57 56 53 89 c3 8b 40 20 85 c0 74 40 8b 43 14 89 d6 <8b> 48 34 85 c9 74 30 89 d8 
ff d1 89 c7 f6 43 29 40 75 12 89 f2
kernel: [  326.096086] EIP: filp_close+0x19/0x70 SS:ESP: 0068:e748ff40
kernel: [  326.096087] CR2: 0000000000000034
kernel: [  326.096087] ---[ end trace a9050884aa2b54f0 ]---

------------------------------

kernel: [   37.062664] BUG: unable to handle kernel NULL pointer dereference at 00000004
kernel: [   37.098001] IP: bio_uncopy_user+0xab/0x120
kernel: [   37.133955] *pdpt = 00000000269ae001 *pde = 0000000000000000 
kernel: [   37.133958] 
kernel: [   37.207044] Oops: 0000 [#1] SMP
kernel: [   37.242482] Modules linked in:
kernel: [   37.276880] CPU: 8 PID: 691 Comm: ata_id Not tainted 4.12.0-rc5-mike-1mike+ #160
kernel: [   37.313824] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [   37.351068] task: ea489d40 task.stack: e85b6000
kernel: [   37.387352] EIP: bio_uncopy_user+0xab/0x120
kernel: [   37.423297] EFLAGS: 00010246 CPU: 8
kernel: [   37.458880] EAX: ea489d40 EBX: ea7bc240 ECX: 00000000 EDX: 00001b1c
kernel: [   37.495385] ESI: 00000000 EDI: 00000000 EBP: e85b7d0c ESP: e85b7ce0
kernel: [   37.531349]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [   37.566682] CR0: 80050033 CR2: 00000004 CR3: 2a49eea0 CR4: 003406f0
kernel: [   37.602412] Call Trace:
kernel: [   37.637277]  ? mempool_free+0x23/0x80
kernel: [   37.671710]  __blk_rq_unmap_user+0x17/0x40
kernel: [   37.705378]  blk_rq_unmap_user+0x27/0x60
kernel: [   37.738707]  sg_io+0x1f7/0x390
kernel: [   37.771990]  scsi_cmd_ioctl+0x26a/0x3f0
kernel: [   37.804958]  scsi_cmd_blk_ioctl+0x30/0x40
kernel: [   37.837390]  cdrom_ioctl+0x2c/0xaa0
kernel: [   37.869422]  ? path_openat+0x4f9/0x11f0
kernel: [   37.901177]  ? scsi_block_when_processing_errors+0x13/0xb0
kernel: [   37.932874]  sr_block_ioctl+0x68/0xb0
kernel: [   37.963551]  ? sr_block_check_events+0x30/0x30
kernel: [   37.993772]  blkdev_ioctl+0x47a/0x9a0
kernel: [   38.023488]  ? do_filp_open+0x73/0xb0
kernel: [   38.052949]  block_ioctl+0x34/0x40
kernel: [   38.082319]  ? __fd_install+0x19/0xb0
kernel: [   38.111587]  ? block_ioctl+0x34/0x40
kernel: [   38.140058]  ? blkdev_fallocate+0x220/0x220
kernel: [   38.169023]  do_vfs_ioctl+0x81/0x610
kernel: [   38.197167]  ? putname+0x4f/0x60
kernel: [   38.224994]  ? putname+0x4f/0x60
kernel: [   38.252220]  ? do_sys_open+0x139/0x230
kernel: [   38.279598]  SyS_ioctl+0x58/0x70
kernel: [   38.306690]  do_int80_syscall_32+0x3d/0xa0
kernel: [   38.333605]  entry_INT80_32+0x31/0x31
kernel: [   38.359949] EIP: 0xb76342c4
kernel: [   38.385842] EFLAGS: 00000246 CPU: 8
kernel: [   38.411333] EAX: ffffffda EBX: 00000003 ECX: 00002285 EDX: bff15f00
kernel: [   38.436970] ESI: bff16d49 EDI: bff15f40 EBP: bff16418 ESP: bff15e68
kernel: [   38.462185]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [   38.487254] Code: d4 8d 65 f4 5b 5e 5f 5d c3 8d b4 26 00 00 00 00 c7 45 d4 00 00 00 00 eb d6 8d b4 26 00 00 00 00 8b 4d d8 66 83 7b 50 00 8b 73 58 <8b> 41 04 89 45 dc 8b 41 08 
89 45 e0 8b 41 0c 89 45 e4 8b 41 10
kernel: [   38.541297] EIP: bio_uncopy_user+0xab/0x120 SS:ESP: 0068:e85b7ce0
kernel: [   38.569047] CR2: 0000000000000004
kernel: [   38.596097] ---[ end trace 8f31c2df1c6d39c5 ]---

------------------------------

Thanks,
	Michele Ballabio
