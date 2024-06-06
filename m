Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5519755B;
	Thu,  6 Jun 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689915; cv=none; b=dEBxTYLA+iXgBjgfn1WZXsOBWPtqbXnLabsDCMlsTSU8KQizGFkOHRIgUcSeAisVYlEcoj0u4VOoKwZvnIf2bMkrZXOjyfCrQRsWkKGBJtNM8rLVJFu/gfD8KJt+1qzgXpHW2e+E+A9TCjZqjXwZQQyrrEenBsdPjzKGBvHExig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689915; c=relaxed/simple;
	bh=K95CGJHofbZP/t+PheO5JSwrsm72bTgMD8eUhXv5s1w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SygGx+xBnq11pkRASMFjARfZfk+vU2G94PGFN3PTEEGmkeazsxwleAsTRKB9Lgub2W8oTGpvZA0sgPSyW163tocHzY4iFaHrKD8t8Q0oPmAiQFnu8ji551Duey8lCPSCEl34oGvaR8otKGDnzkCnuRMnKSJc3Ngmx8iQvUGBRP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id E67D044EC0;
	Thu,  6 Jun 2024 18:05:02 +0200 (CEST)
Message-ID: <da23559e-c4df-4aaf-9832-57ea6e625d18@proxmox.com>
Date: Thu, 6 Jun 2024 18:05:00 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix request.queuelist usage in flush
From: Friedrich Weber <f.weber@proxmox.com>
To: Chengming Zhou <chengming.zhou@linux.dev>, axboe@kernel.dk,
 ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com, Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20240604064745.808610-1-chengming.zhou@linux.dev>
 <c9d03ff7-27c5-4ebd-b3f6-5a90d96f35ba@proxmox.com>
 <1344640f-b22d-4791-aed4-68fc62fb6e36@linux.dev>
 <ec27da86-b84a-430b-98aa-9971f90c8c87@proxmox.com>
 <7193e02e-7347-48db-b1a0-67b44730480b@proxmox.com>
 <448721f2-8e0b-4c5a-9764-bde65a5ee981@linux.dev>
 <343166f4-ac11-4f0e-ad13-6dc14dbf573d@proxmox.com>
Content-Language: en-US
In-Reply-To: <343166f4-ac11-4f0e-ad13-6dc14dbf573d@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/06/2024 10:44, Friedrich Weber wrote:
> On 05/06/2024 16:27, Chengming Zhou wrote:
>> On 2024/6/5 21:34, Friedrich Weber wrote:
>>> On 05/06/2024 12:54, Friedrich Weber wrote:
>>> [...]
>>>
>>> My results:
>>>
>>> Booting the Debian (virtual) machine with mainline kernel v6.10-rc2
>>> (c3f38fa61af77b49866b006939479069cd451173):
>>> works fine, no crash
>>>
>>> Booting the Debian (virtual) machine with patch "block: fix
>>> request.queuelist usage in flush" applied on top of v6.10-rc2: The
>>> Debian (virtual) machine crashes during boot with [1].
>>>
>>> Hope this helps! If I can provide anything else, just let me know.
>>
>> Thanks for your help, I still can't reproduce it myself, don't know why.
> 
> Weird -- when booting the Debian machine into mainline kernel v6.10-rc2
> with "block: fix request.queuelist usage in flush" applied on top, it
> crashes reliably for me. The machine having its root on LVM seems to be
> essential to reproduce the crash, though.
> 
> Maybe the fact that I'm running the Debian machine virtualized makes the
> crash more likely to trigger. I'll try to reproduce on bare metal to
> narrow down the reproducer and get back to you.

The crashing Debian VM (QEMU/KVM) has its root on an LVM Logical Volume.
As it turns out, whether there is an in-guest kernel crash on boot
depends on the cache mode of the disk backing the LVM Physical Volume
(Christoph also mentioned the write cache being relevant for the
original issue with software RAID [1]). Steps to reproduce:

- Install kernel v6.10-rc2 with "block: fix request.queuelist usage in
flush" applied inside the Debian VM

- Start the Debian VM with `cache=writethrough` for its disk (see [2]
for upstream QEMU 8.2.2 command line)
  => no in-guest crash on boot

- Start the VM with `cache=writeback` for its disk (see [3] for diff to
previous command line)
  => in-guest crash [4] on boot

Maybe the cache=writeback was missing to reproduce the crash on your
end? If you still cannot reproduce the crash, let me know -- I'll
provide more detailed steps how to generate the VM disk then.

I was also able to reproduce the crash on bare metal, with a Proxmox VE
8.2 installation -- if needed I can also retry with e.g. a bare-metal
Debian installation.

However, also here the write cache seems to be relevant:

- Running kernel is again mainline v6.10-rc2 with "block: fix
request.queuelist usage in flush" applied. root is on LVM (see [5]).

- If I enable write caching for the disk backing the LVM PV via `hdparm
-W1 /dev/sdb` and reboot, I see the crash in blk_mq_requeue_work on boot.

- If I disable write caching via `hdparm -W0 /dev/sdb` and reboot, I see
no crash.

Hope this helps. Let me know if I can provide any more information.

Best,

Friedrich

[1] https://lore.kernel.org/all/20240531061708.GB18075@lst.de/
[2]

[...]/qemu-stable-8.2/qemu-8.2.2/build/qemu-system-x86_64 \
  -accel kvm \
  -name 'kernel684deb,debug-threads=on' \
  -chardev
'socket,id=qmp,path=/var/run/qemu-server/198.qmp,server=on,wait=off' \
  -mon 'chardev=qmp,mode=control' \
  -chardev 'socket,id=qmp-event,path=/var/run/qmeventd.sock,reconnect=5' \
  -mon 'chardev=qmp-event,mode=control' \
  -pidfile /var/run/qemu-server/198.pid \
  -smbios 'type=1,uuid=49351322-c4a0-420b-a780-d445a638973a' \
  -smp '1,sockets=1,cores=1,maxcpus=1' \
  -nodefaults \
  -vnc 'unix:/var/run/qemu-server/198.vnc,password=on' \
  -cpu qemu64,enforce,+kvm_pv_eoi,+kvm_pv_unhalt \
  -m 8192 \
  -device 'pci-bridge,id=pci.1,chassis_nr=1,bus=pci.0,addr=0x1e' \
  -device 'pci-bridge,id=pci.2,chassis_nr=2,bus=pci.0,addr=0x1f' \
  -device 'vmgenid,guid=78d4ee6d-a73a-43bd-9e3a-5395449af862' \
  -chardev
'socket,id=serial0,path=/var/run/qemu-server/198.serial0,server=on,wait=off'
\
  -device 'isa-serial,chardev=serial0' \
  -device 'VGA,id=vga,bus=pci.0,addr=0x2' \
  -device 'ahci,id=ahci0,multifunction=on,bus=pci.0,addr=0x7' \
  -drive
'file=/dev/pve/vm-198-disk-0,if=none,id=drive-sata0,format=raw,aio=threads,detect-zeroes=on,cache=writethrough'
\
  -device 'ide-hd,bus=ahci0.0,drive=drive-sata0,id=sata0,bootindex=100' \
  -machine 'type=pc'

[3]
--- run-198-nocrash.sh	2024-06-06 17:19:10.725256488 +0200
+++ run-198-crash.sh	2024-06-06 17:18:39.444974266 +0200
@@ -19,6 +19,6 @@
   -device 'isa-serial,chardev=serial0' \
   -device 'VGA,id=vga,bus=pci.0,addr=0x2' \
   -device 'ahci,id=ahci0,multifunction=on,bus=pci.0,addr=0x7' \
-  -drive
'file=/dev/pve/vm-198-disk-0,if=none,id=drive-sata0,format=raw,aio=threads,detect-zeroes=on,cache=writethrough'
\
+  -drive
'file=/dev/pve/vm-198-disk-0,if=none,id=drive-sata0,format=raw,aio=threads,detect-zeroes=on,cache=writeback'
\
   -device 'ide-hd,bus=ahci0.0,drive=drive-sata0,id=sata0,bootindex=100' \
   -machine 'type=pc'

[4]
[    1.911631] BUG: kernel NULL pointer dereference, address:
0000000000000000
[    1.912249] #PF: supervisor write access in kernel mode
[    1.912723] #PF: error_code(0x0002) - not-present page
[    1.913157] PGD 0 P4D 0
[    1.913405] Oops: Oops: 0002 [#1] PREEMPT SMP PTI
[    1.913787] CPU: 0 PID: 45 Comm: kworker/0:1H Tainted: G            E
     6.10.0-rc2-patch0604-6-10rc2+ #37
[    1.915161] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    1.916098] Workqueue: kblockd blk_mq_requeue_work
[    1.916501] RIP: 0010:_raw_spin_lock+0x13/0x60
[    1.916895] Code: 31 db c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 0f 1f 44 00 00 65 ff 05 3c 42 4a 59 31 c0 ba 01 00 00
00 <3e> 0f b1 17 75 1b 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9
[    1.918434] RSP: 0000:ffffa31fc0177d78 EFLAGS: 00010246
[    1.918880] RAX: 0000000000000000 RBX: ffff8dcf4dcd0400 RCX:
00000000ffffffe0
[    1.919393] RDX: 0000000000000001 RSI: 0000000000000001 RDI:
0000000000000000
[    1.920014] RBP: ffffa31fc0177d98 R08: 0000000000000000 R09:
0000000000000000
[    1.920615] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000000000
[    1.921216] R13: 0000000000000001 R14: ffffc31fbfc013c0 R15:
ffff8dcf4dcd3c54
[    1.921811] FS:  0000000000000000(0000) GS:ffff8dd077c00000(0000)
knlGS:0000000000000000
[    1.922471] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.922964] CR2: 0000000000000000 CR3: 000000010235a000 CR4:
00000000000006f0
[    1.923566] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[    1.924166] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[    1.924768] Call Trace:
[    1.924968]  <TASK>
[    1.925120]  ? show_regs+0x6c/0x80
[    1.925366]  ? __die+0x24/0x80
[    1.925580]  ? page_fault_oops+0x175/0x5e0
[    1.925862]  ? _raw_spin_lock+0x13/0x60
[    1.926127]  ? kernelmode_fixup_or_oops.constprop.0+0x69/0x90
[    1.926523]  ? __bad_area_nosemaphore+0x19f/0x280
[    1.926844]  ? bad_area_nosemaphore+0x16/0x30
[    1.927143]  ? do_user_addr_fault+0x2ce/0x690
[    1.927450]  ? exc_page_fault+0x82/0x1b0
[    1.927719]  ? asm_exc_page_fault+0x27/0x30
[    1.928006]  ? _raw_spin_lock+0x13/0x60
[    1.928273]  ? blk_mq_request_bypass_insert+0x20/0xe0
[    1.928617]  blk_mq_insert_request+0x120/0x1e0
[    1.928922]  blk_mq_requeue_work+0x18f/0x230
[    1.929216]  process_one_work+0x199/0x3e0
[    1.929496]  worker_thread+0x32a/0x500
[    1.929754]  ? __pfx_worker_thread+0x10/0x10
[    1.930047]  kthread+0xe4/0x110
[    1.930271]  ? __pfx_kthread+0x10/0x10
[    1.930531]  ret_from_fork+0x47/0x70
[    1.930781]  ? __pfx_kthread+0x10/0x10
[    1.931040]  ret_from_fork_asm+0x1a/0x30
[    1.931318]  </TASK>
[    1.931473] Modules linked in: efi_pstore(E) dmi_sysfs(E)
qemu_fw_cfg(E) ip_tables(E) x_tables(E) autofs4(E) psmouse(E) bochs(E)
drm_vram_helper(E) drm_ttm_helper(E) ahci(E) ttm(E) libahci(E)
i2c_piix4(E) pata_acpi(E) floppy(E)
[    1.932778] CR2: 0000000000000000
[    1.932993] ---[ end trace 0000000000000000 ]---
[    1.933289] RIP: 0010:_raw_spin_lock+0x13/0x60
[    1.933572] Code: 31 db c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90
90 90 90 90 90 90 0f 1f 44 00 00 65 ff 05 3c 42 4a 59 31 c0 ba 01 00 00
00 <3e> 0f b1 17 75 1b 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9
[    1.934720] RSP: 0000:ffffa31fc0177d78 EFLAGS: 00010246
[    1.935049] RAX: 0000000000000000 RBX: ffff8dcf4dcd0400 RCX:
00000000ffffffe0
[    1.935510] RDX: 0000000000000001 RSI: 0000000000000001 RDI:
0000000000000000
[    1.935967] RBP: ffffa31fc0177d98 R08: 0000000000000000 R09:
0000000000000000
[    1.936437] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000000000
[    1.937001] R13: 0000000000000001 R14: ffffc31fbfc013c0 R15:
ffff8dcf4dcd3c54
[    1.937481] FS:  0000000000000000(0000) GS:ffff8dd077c00000(0000)
knlGS:0000000000000000
[    1.937995] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.938599] CR2: 0000000000000000 CR3: 000000010235a000 CR4:
00000000000006f0
[    1.939320] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[    1.940067] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400

[5]
# lsblk --ascii
NAME               MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda                  8:0    1 465.8G  0 disk
sdb                  8:16   1 119.2G  0 disk
|-sdb1               8:17   1  1007K  0 part
|-sdb2               8:18   1     1G  0 part /boot/efi
`-sdb3               8:19   1 118.2G  0 part
  |-pve-swap       252:0    0     8G  0 lvm  [SWAP]
  |-pve-root       252:2    0  39.6G  0 lvm  /
  |-pve-data_tmeta 252:3    0     1G  0 lvm
  | `-pve-data     252:5    0  53.9G  0 lvm
  `-pve-data_tdata 252:4    0  53.9G  0 lvm
    `-pve-data     252:5    0  53.9G  0 lvm
sdc                  8:32   1 476.9G  0 disk
sdd                  8:48   1 446.9G  0 disk
# pvs
  PV         VG  Fmt  Attr PSize    PFree
  /dev/sdb3  pve lvm2 a--  <118.24g 14.75g
# vgs
  VG  #PV #LV #SN Attr   VSize    VFree
  pve   1   3   0 wz--n- <118.24g 14.75g
# lvs
  LV   VG  Attr       LSize   Pool Origin Data%  Meta%  Move Log
Cpy%Sync Convert
  data pve twi-a-tz-- <53.93g             0.00   1.59
  root pve -wi-ao---- <39.56g
  swap pve -wi-ao----   8.00g
# findmnt -ascii
TARGET    SOURCE               FSTYPE OPTIONS
/         /dev/mapper/pve-root ext4   errors=remount-ro
/boot/efi UUID=6314-15A9       vfat   defaults
none      /dev/mapper/pve-swap swap   sw
/proc     proc                 proc   defaults

