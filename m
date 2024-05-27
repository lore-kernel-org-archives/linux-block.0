Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C061FDA;
	Mon, 27 May 2024 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825876; cv=none; b=sR7TKAhgBuG/UT0K1UjKnnnErQDCfWU8M04mW2DYPeOt/G5wEQM78u7GYT+gTJMRwq1LhsRqkYtpDkt4KmUBsNEz9rVeyO7uUPlI0vxgcBGb4DJNT4iVqzET/iY7NS9NCPHyRI78SrameQUs6Oal93sXEyGK1M+7ZOTtYKvwg8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825876; c=relaxed/simple;
	bh=ZwblT6MBdzg4nhMoXCxxpldI1YgwEdiNNDc5PkSN2X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STPjcHUyi1DAZkWDCNHymp7QYo/i2S6RYKbDNBM6+rajpp80f5Rb60hD5Tcf7aAecdBfv2hveOklgTfrMKg+YwmkxOc2jgphtdoa5HZqSJI664ubEdzsG21tcAe/c2MyWmaHhXHCRxGWl8A7jgaG2CUFLKbhAcqvEOtMgXKRJ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id C234C43ECE;
	Mon, 27 May 2024 18:04:23 +0200 (CEST)
Message-ID: <4d799672-378b-42b1-896b-38df2c5e9c84@proxmox.com>
Date: Mon, 27 May 2024 18:04:20 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] blk-flush: reuse rq queuelist in flush state
 machine
To: Chengming Zhou <chengming.zhou@linux.dev>, axboe@kernel.dk,
 ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20230717040058.3993930-1-chengming.zhou@linux.dev>
 <20230717040058.3993930-5-chengming.zhou@linux.dev>
 <14b89dfb-505c-49f7-aebb-01c54451db40@proxmox.com>
 <984f1f77-288c-441a-a649-5f320249b576@linux.dev>
Content-Language: en-US
From: Friedrich Weber <f.weber@proxmox.com>
In-Reply-To: <984f1f77-288c-441a-a649-5f320249b576@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chengming,

Thank you for taking a look at this!

On 27/05/2024 07:09, Chengming Zhou wrote:
>> I've used this reproducer for a bisect, which produced
>>
>>  81ada09cc25e (blk-flush: reuse rq queuelist in flush state machine)
>>
>> as the first commit with which I can reproduce the crashes. I'm not 100%
>> sure it is this one because the reproducer is a bit flaky. But it does
>> sound plausible, as the commit is included in our 6.8 kernel, and
>> touches `queuelist` which is AFAICT where blk_flush_complete_seq
>> dereferences the NULL pointer.
> 
> Ok, it will be better that I can reproduce it locally, will try later.

Interestingly, so far I haven't been able to reproduce the crash when
generating IO on the host itself, I only got crashes when generating IO
in a QEMU VM.

The reproducer in more detail:

- Compile Linux 6.9 with CONFIG_FAULT_INJECTION,
CONFIG_FAULT_INJECTION_DEBUG_FS, CONFIG_FAIL_MAKE_REQUEST and boot it on
the host

- On the host, I have root on ext4 on top of a RAID1 software raid, see
[0] for mdadm output. I have to enable the write-intent bitmap to
reproduce the crash.

- Run QEMU to start a Linux VM whose disk is backed by a qcow2 file on
root, see [1] for QEMU 8.2.2 command line. The VM is running Proxmox VE
here, but I don't think that matters.

- Run fio inside the VM as follows:

fio --name foo --size 1M --filename foo.bin --rw=write --bs=4k --iodepth
4 --ioengine libaio --numjobs 4 --time_based --runtime 600

- Inject faults on sdb1 on the host:

echo 1 > /sys/block/sdb/sdb1/make-it-fail
echo 1000 > /sys/kernel/debug/fail_make_request/times
echo 50 > /sys/kernel/debug/fail_make_request/interval
echo 5 > /sys/kernel/debug/fail_make_request/probability
echo 1 > /sys/kernel/debug/fail_make_request/verbose

- And usually (in somewhat 80% of cases) I get a host crash within ~5
minutes. Sometimes the software RAID declares sdb1 to be faulty and
disables it, in this case I have to try again.

>> Does anyone have an idea what could be the cause for the crash, or how
>> to further debug this? Happy to provide more information if needed, as
>> well as the complete reproducer (I'd need to clean it up a little bit
>> first).
> 
> BUG shows it panic on 0000000000000008, not sure what it's accessing then,
> does it means rq->queuelist.next == 0 or something? Could you use add2line
> to show the exact source code line that panic? I use blk_flush_complete_seq+0x296/0x2e0
> and get block/blk-flush.c:190, which is "fq->flush_data_in_flight++;",
> obviously fq can't be NULL. (I'm using the v6.9 kernel)

Sorry for the confusion, the crash dump was from a kernel compiled at
81ada09cc25e -- with 6.9, the offset seems to be different. See [2] for
a kernel 6.9 crash dump.

I don't know too much about kernel debugging, but I tried to get
something useful out of addr2line:

# addr2line -f -e /usr/lib/debug/vmlinux-6.9.0-debug2
blk_flush_complete_seq+0x291/0x2d0
__list_del
/[...]./include/linux/list.h:195

I tried to find the relevant portions in `objdump -SD blk-flush.o`, see
[3]. If I'm not mistaken, blk_flush_complete_seq+0x291 should point to

351:   48 89 4f 08             mov    %rcx,0x8(%rdi)

To me this looks like part of

	list_move_tail(&rq->queuelist, pending);

What do you think?

FWIW, I've also compiled a 6.9 kernel with CONFIG_LIST_DEBUG, and when
running the reproducer it started reporting corruptions, see [4] for the
first one. It did not crash, though, maybe because CONFIG_LIST_DEBUG
prevents the NULL pointer dereference?

Hope this helps! If I can provide anything else, just let me know.

Best wishes,

Friedrich

[0]

# mdadm --detail /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Wed May 22 10:14:40 2024
        Raid Level : raid1
        Array Size : 33534976 (31.98 GiB 34.34 GB)
     Used Dev Size : 33534976 (31.98 GiB 34.34 GB)
      Raid Devices : 2
     Total Devices : 2
       Persistence : Superblock is persistent

     Intent Bitmap : Internal

       Update Time : Mon May 27 17:31:02 2024
             State : active
    Active Devices : 2
   Working Devices : 2
    Failed Devices : 0
     Spare Devices : 0

Consistency Policy : bitmap

              Name : reproflushfull:0  (local to host reproflushfull)
              UUID : fda4a959:d2dd0bef:d7094fb1:c6e3174c
            Events : 749

    Number   Major   Minor   RaidDevice State
       0       8        1        0      active sync   /dev/sda1
       1       8       17        1      active sync   /dev/sdb1

[1]

./qemu-8.2.2/qemu-system-x86_64 \
  -accel kvm \
  -name 'pve,debug-threads=on' \
  -chardev
'socket,id=qmp,path=/var/run/qemu-server/100.qmp,server=on,wait=off' \
  -mon 'chardev=qmp,mode=control' \
  -chardev 'socket,id=qmp-event,path=/var/run/qmeventd.sock,reconnect=5' \
  -mon 'chardev=qmp-event,mode=control' \
  -pidfile /var/run/qemu-server/100.pid \
  -smbios 'type=1,uuid=25a3012b-e72a-4121-9e57-f6f5a40ebe62' \
  -smp '4,sockets=1,cores=4,maxcpus=4' \
  -nodefaults \
  -vnc 'unix:/var/run/qemu-server/100.vnc,password=on' \
  -cpu host,+kvm_pv_eoi,+kvm_pv_unhalt \
  -m 4096 \
  -object 'iothread,id=iothread-virtioscsi0' \
  -device 'pci-bridge,id=pci.1,chassis_nr=1,bus=pci.0,addr=0x1e' \
  -device 'pci-bridge,id=pci.2,chassis_nr=2,bus=pci.0,addr=0x1f' \
  -device 'pci-bridge,id=pci.3,chassis_nr=3,bus=pci.0,addr=0x5' \
  -device 'vmgenid,guid=ab6d50e3-d574-4ba8-bb0c-3c0bbcc9cd2e' \
  -device 'piix3-usb-uhci,id=uhci,bus=pci.0,addr=0x1.0x2' \
  -device 'VGA,id=vga,bus=pci.0,addr=0x2' \
  -device
'virtio-scsi-pci,id=virtioscsi0,bus=pci.3,addr=0x1,iothread=iothread-virtioscsi0'
\
  -drive
'file=/var/lib/vz/images/100/vm-100-disk-0.qcow2,if=none,id=drive-scsi0,format=qcow2,cache=none,aio=io_uring,detect-zeroes=on'
\
  -device
'scsi-hd,bus=virtioscsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0,id=scsi0,bootindex=100'
\
  -machine 'type=pc'

[2]

[   85.282301] BUG: kernel NULL pointer dereference, address:
0000000000000008
[   85.283454] #PF: supervisor write access in kernel mode
[   85.284289] #PF: error_code(0x0002) - not-present page
[   85.285087] PGD 0 P4D 0
[   85.285500] Oops: 0002 [#1] PREEMPT SMP NOPTI
[   85.286211] CPU: 0 PID: 794 Comm: kvm Tainted: G            E
6.9.0-debug2 #27
[   85.287420] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   85.289177] RIP: 0010:blk_flush_complete_seq+0x291/0x2d0
[   85.289994] Code: 0f b6 f6 49 8d 56 01 49 c1 e6 04 4d 01 ee 48 c1 e2
04 49 8b 4e 10 4c 01 ea 48 39 ca 74 2b 48 8b 4b 50 48 8b 7b 48 48 8d 73
48 <48> 89 4f 08 48 89 39 49 8b 4e 18 49 89 76 18 48 89 53 48 48 89 4b
[   85.292894] RSP: 0018:ffff9c08c07f3998 EFLAGS: 00010046
[   85.293714] RAX: 0000000000000000 RBX: ffff8b9c8abad000 RCX:
ffff8b9c8abad048
[   85.294809] RDX: ffff8b9c80a3d6a0 RSI: ffff8b9c8abad048 RDI:
0000000000000000
[   85.295921] RBP: ffff9c08c07f39d8 R08: 0000000000000000 R09:
0000000000000000
[   85.297111] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000009801
[   85.298211] R13: ffff8b9c80a3d680 R14: ffff8b9c80a3d690 R15:
ffff8b9c8341ddc0
[   85.299353] FS:  0000776683e006c0(0000) GS:ffff8b9db7a00000(0000)
knlGS:0000000000000000
[   85.300825] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   85.301712] CR2: 0000000000000008 CR3: 000000010e6e4001 CR4:
0000000000372ef0
[   85.302810] Call Trace:
[   85.303242]  <TASK>
[   85.303597]  ? show_regs+0x6c/0x80
[   85.304169]  ? __die+0x24/0x80
[   85.304671]  ? page_fault_oops+0x175/0x5b0
[   85.305326]  ? do_user_addr_fault+0x311/0x680
[   85.306012]  ? exc_page_fault+0x82/0x1b0
[   85.306657]  ? asm_exc_page_fault+0x27/0x30
[   85.307297]  ? blk_flush_complete_seq+0x291/0x2d0
[   85.308023]  ? __blk_mq_alloc_requests+0x251/0x540
[   85.308785]  ? wbt_wait+0x33/0x100
[   85.309620]  blk_insert_flush+0xce/0x220
[   85.310307]  blk_mq_submit_bio+0x5cd/0x730
[   85.310948]  __submit_bio+0xb3/0x1c0
[   85.311535]  submit_bio_noacct_nocheck+0x2fc/0x3d0
[   85.312296]  submit_bio_noacct+0x1ba/0x6b0
[   85.312934]  ? ext4_file_write_iter+0x3b1/0x7e0
[   85.313663]  submit_bio+0xb1/0x110
[   85.314220]  md_super_write+0xcf/0x110
[   85.314816]  write_sb_page+0x148/0x300
[   85.315422]  filemap_write_page+0x5b/0x70
[   85.316058]  md_bitmap_unplug+0x99/0x1f0
[   85.316676]  flush_bio_list+0x107/0x110 [raid1]
[   85.317399]  raid1_unplug+0x3c/0xf0 [raid1]
[   85.318056]  __blk_flush_plug+0xbe/0x140
[   85.318673]  blk_finish_plug+0x30/0x50
[   85.319268]  io_submit_sqes+0x4c4/0x6c0
[   85.319872]  __do_sys_io_uring_enter+0x2f2/0x640
[   85.320590]  ? blk_mq_complete_request+0x26/0x40
[   85.321326]  __x64_sys_io_uring_enter+0x22/0x40
[   85.322044]  x64_sys_call+0x20b9/0x24b0
[   85.322656]  do_syscall_64+0x80/0x170
[   85.323243]  ? vring_interrupt+0x94/0x110
[   85.323878]  ? __x64_sys_ppoll+0xf2/0x170
[   85.324501]  ? handle_irq_event+0x52/0x80
[   85.325103]  ? _raw_spin_unlock+0xe/0x40
[   85.325728]  ? handle_edge_irq+0xda/0x250
[   85.326347]  ? irqentry_exit_to_user_mode+0x76/0x270
[   85.327114]  ? irqentry_exit+0x43/0x50
[   85.327703]  ? clear_bhb_loop+0x15/0x70
[   85.328286]  ? clear_bhb_loop+0x15/0x70
[   85.328897]  ? clear_bhb_loop+0x15/0x70
[   85.329541]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   85.330326] RIP: 0033:0x776695660b95
[   85.330908] Code: 00 00 00 44 89 d0 41 b9 08 00 00 00 83 c8 10 f6 87
d0 00 00 00 01 8b bf cc 00 00 00 44 0f 45 d0 45 31 c0 b8 aa 01 00 00 0f
05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 41 83 e2 02 74 c2 f0 48 83 0c 24
[   85.333736] RSP: 002b:0000776683dfafd8 EFLAGS: 00000246 ORIG_RAX:
00000000000001aa
[   85.334911] RAX: ffffffffffffffda RBX: 000077667c0039f0 RCX:
0000776695660b95
[   85.335999] RDX: 0000000000000000 RSI: 0000000000000003 RDI:
0000000000000033
[   85.337111] RBP: 000077667c0039f8 R08: 0000000000000000 R09:
0000000000000008
[   85.338210] R10: 0000000000000000 R11: 0000000000000246 R12:
000077667c003ae0
[   85.339304] R13: 0000000000000000 R14: 000064175d5afc68 R15:
000064178a3f9450
[   85.340408]  </TASK>
[   85.340772] Modules linked in: tcp_diag(E) inet_diag(E) veth(E)
cmac(E) nls_utf8(E) cifs(E) cifs_arc4(E) nls_ucs2_utils(E) rdma_cm(E)
iw_cm(E) ib_cm(E) ib_core(E) cifs_md4(E) netfs(E) ebtable_filter(E)
ebtables(E) ip_set(E) ip6table_raw(E) iptable_raw(E) ip6table_filter(E)
ip6_tables(E) iptable_filter(E) nf_tables(E) softdog(E) sunrpc(E)
binfmt_misc(E) bonding(E) tls(E) nfnetlink_log(E) nfnetlink(E)
intel_rapl_msr(E) intel_rapl_common(E) intel_uncore_frequency_common(E)
intel_pmc_core(E) intel_vsec(E) pmt_telemetry(E) pmt_class(E)
kvm_intel(E) kvm(E) hid_generic(E) crct10dif_pclmul(E)
polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E)
sha256_ssse3(E) sha1_ssse3(E) aesni_intel(E) crypto_simd(E) usbhid(E)
cryptd(E) hid(E) rapl(E) pcspkr(E) vmgenid(E) joydev(E) input_leds(E)
serio_raw(E) mac_hid(E) vhost_net(E) vhost(E) vhost_iotlb(E) tap(E)
efi_pstore(E) dmi_sysfs(E) qemu_fw_cfg(E) ip_tables(E) x_tables(E)
autofs4(E) raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E)
async_pq(E) async_xor(E) async_tx(E)
[   85.340859]  xor(E) raid6_pq(E) libcrc32c(E) raid0(E) raid1(E)
crc32_pclmul(E) bochs(E) drm_vram_helper(E) drm_ttm_helper(E) psmouse(E)
uhci_hcd(E) ehci_hcd(E) ttm(E) i2c_piix4(E) pata_acpi(E) floppy(E)
[   85.357137] CR2: 0000000000000008
[   85.358209] ---[ end trace 0000000000000000 ]---
[   85.358926] RIP: 0010:blk_flush_complete_seq+0x291/0x2d0
[   85.360004] Code: 0f b6 f6 49 8d 56 01 49 c1 e6 04 4d 01 ee 48 c1 e2
04 49 8b 4e 10 4c 01 ea 48 39 ca 74 2b 48 8b 4b 50 48 8b 7b 48 48 8d 73
48 <48> 89 4f 08 48 89 39 49 8b 4e 18 49 89 76 18 48 89 53 48 48 89 4b
[   85.362891] RSP: 0018:ffff9c08c07f3998 EFLAGS: 00010046
[   85.363695] RAX: 0000000000000000 RBX: ffff8b9c8abad000 RCX:
ffff8b9c8abad048
[   85.364800] RDX: ffff8b9c80a3d6a0 RSI: ffff8b9c8abad048 RDI:
0000000000000000
[   85.365902] RBP: ffff9c08c07f39d8 R08: 0000000000000000 R09:
0000000000000000
[   85.366993] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000009801
[   85.368089] R13: ffff8b9c80a3d680 R14: ffff8b9c80a3d690 R15:
ffff8b9c8341ddc0
[   85.369190] FS:  0000776683e006c0(0000) GS:ffff8b9db7a00000(0000)
knlGS:0000000000000000
[   85.370440] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   85.371327] CR2: 0000000000000008 CR3: 000000010e6e4001 CR4:
0000000000372ef0
[   85.372440] note: kvm[794] exited with irqs disabled
[   85.373340] note: kvm[794] exited with preempt_count 1
[   85.374238] ------------[ cut here ]------------
[   85.374943] WARNING: CPU: 0 PID: 794 at kernel/exit.c:827
do_exit+0x8a2/0xab0
[   85.376047] Modules linked in: tcp_diag(E) inet_diag(E) veth(E)
cmac(E) nls_utf8(E) cifs(E) cifs_arc4(E) nls_ucs2_utils(E) rdma_cm(E)
iw_cm(E) ib_cm(E) ib_core(E) cifs_md4(E) netfs(E) ebtable_filter(E)
ebtables(E) ip_set(E) ip6table_raw(E) iptable_raw(E) ip6table_filter(E)
ip6_tables(E) iptable_filter(E) nf_tables(E) softdog(E) sunrpc(E)
binfmt_misc(E) bonding(E) tls(E) nfnetlink_log(E) nfnetlink(E)
intel_rapl_msr(E) intel_rapl_common(E) intel_uncore_frequency_common(E)
intel_pmc_core(E) intel_vsec(E) pmt_telemetry(E) pmt_class(E)
kvm_intel(E) kvm(E) hid_generic(E) crct10dif_pclmul(E)
polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E)
sha256_ssse3(E) sha1_ssse3(E) aesni_intel(E) crypto_simd(E) usbhid(E)
cryptd(E) hid(E) rapl(E) pcspkr(E) vmgenid(E) joydev(E) input_leds(E)
serio_raw(E) mac_hid(E) vhost_net(E) vhost(E) vhost_iotlb(E) tap(E)
efi_pstore(E) dmi_sysfs(E) qemu_fw_cfg(E) ip_tables(E) x_tables(E)
autofs4(E) raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E)
async_pq(E) async_xor(E) async_tx(E)
[   85.376128]  xor(E) raid6_pq(E) libcrc32c(E) raid0(E) raid1(E)
crc32_pclmul(E) bochs(E) drm_vram_helper(E) drm_ttm_helper(E) psmouse(E)
uhci_hcd(E) ehci_hcd(E) ttm(E) i2c_piix4(E) pata_acpi(E) floppy(E)
[   85.392395] CPU: 0 PID: 794 Comm: kvm Tainted: G      D     E
6.9.0-debug2 #27
[   85.393594] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   85.395347] RIP: 0010:do_exit+0x8a2/0xab0
[   85.395975] Code: 38 0c 00 00 e9 2d fe ff ff 49 8d 7d 18 e8 b6 83 07
00 e9 5a f8 ff ff 48 8b bb f8 09 00 00 31 f6 e8 b3 e0 ff ff e9 c1 fd ff
ff <0f> 0b e9 d4 f7 ff ff 0f 0b e9 8f f7 ff ff 4c 89 e6 bf 05 06 00 00
[   85.398793] RSP: 0018:ffff9c08c07f3ec8 EFLAGS: 00010286
[   85.399625] RAX: 0000000000000000 RBX: ffff8b9c82e90000 RCX:
0000000000000000
[   85.400720] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000

[3]

00000000000000c0 <blk_flush_complete_seq>:
{
[...]
       struct list_head *pending = &fq->flush_queue[fq->flush_pending_idx];
 32a:   49 8d 56 01             lea    0x1(%r14),%rdx
 32e:   49 c1 e6 04             shl    $0x4,%r14
 332:   4d 01 ee                add    %r13,%r14
 335:   48 c1 e2 04             shl    $0x4,%rdx
        return READ_ONCE(head->next) == head;
 339:   49 8b 4e 10             mov    0x10(%r14),%rcx
 33d:   4c 01 ea                add    %r13,%rdx
                if (list_empty(pending))
 340:   48 39 ca                cmp    %rcx,%rdx
 343:   74 2b                   je     370 <blk_flush_complete_seq+0x2b0>
        __list_del(entry->prev, entry->next);
 345:   48 8b 4b 50             mov    0x50(%rbx),%rcx
 349:   48 8b 7b 48             mov    0x48(%rbx),%rdi
                list_move_tail(&rq->queuelist, pending);
 34d:   48 8d 73 48             lea    0x48(%rbx),%rsi
        next->prev = prev;
 351:   48 89 4f 08             mov    %rcx,0x8(%rdi)
        WRITE_ONCE(prev->next, next);
 355:   48 89 39                mov    %rdi,(%rcx)
        __list_add(new, head->prev, head);
 358:   49 8b 4e 18             mov    0x18(%r14),%rcx
        next->prev = new;
 35c:   49 89 76 18             mov    %rsi,0x18(%r14)
        new->next = next;
 360:   48 89 53 48             mov    %rdx,0x48(%rbx)
        new->prev = prev;
 364:   48 89 4b 50             mov    %rcx,0x50(%rbx)
        WRITE_ONCE(prev->next, new);
 368:   48 89 31                mov    %rsi,(%rcx)
}
 36b:   e9 30 fe ff ff          jmp    1a0 <blk_flush_complete_seq+0xe0>
                        fq->flush_pending_since = jiffies;
 370:   48 8b 0d 00 00 00 00    mov    0x0(%rip),%rcx        # 377
<blk_flush_complete_seq+0x2b7>
 377:   49 89 4d 08             mov    %rcx,0x8(%r13)
 37b:   eb c8                   jmp    345 <blk_flush_complete_seq+0x285>

[4] May 27 11:12:53 reproflushfull kernel: list_del corruption.
prev->next should be ffff8ad44ab63788, but was ffff8ad44ab63400.
(prev=ffff8ad44ab63788)
May 27 11:12:53 reproflushfull kernel: WARNING: CPU: 0 PID: 797 at
lib/list_debug.c:62 __list_del_entry_valid_or_report+0xd4/0x100
May 27 11:12:53 reproflushfull kernel: Modules linked in: veth(E)
cmac(E) nls_utf8(E) cifs(E) cifs_arc4(E) nls_ucs2_utils(E) rdma_cm(E)
iw_cm(E) ib_cm(E) ib_core(E) cifs_md4(E) netfs(E) ebtable_filter(E)
ebtables(E) ip_set(E) ip6table_raw(E) iptable_raw(E) ip6table_filter(E)
ip6_tables(E) iptable_filter(E) nf_tables(E) softdog(E) sunrpc(E)
binfmt_misc(E) bonding(E) tls(E) nfnetlink_log(E) nfnetlink(E)
intel_rapl_msr(E) intel_rapl_common(E) intel_uncore_frequency_common(E)
intel_pmc_core(E) intel_vsec(E) pmt_telemetry(E) pmt_class(E)
kvm_intel(E) kvm(E) crct10dif_pclmul(E) polyval_clmulni(E)
polyval_generic(E) hid_generic(E) ghash_clmulni_intel(E) sha256_ssse3(E)
sha1_ssse3(E) aesni_intel(E) crypto_simd(E) usbhid(E) cryptd(E) hid(E)
rapl(E) pcspkr(E) vmgenid(E) joydev(E) input_leds(E) mac_hid(E)
serio_raw(E) vhost_net(E) vhost(E) vhost_iotlb(E) tap(E) efi_pstore(E)
dmi_sysfs(E) qemu_fw_cfg(E) ip_tables(E) x_tables(E) autofs4(E)
raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E)
async_xor(E) async_tx(E) xor(E) raid6_pq(E)
May 27 11:12:53 reproflushfull kernel:  libcrc32c(E) raid0(E) raid1(E)
crc32_pclmul(E) bochs(E) psmouse(E) drm_vram_helper(E) drm_ttm_helper(E)
uhci_hcd(E) ttm(E) i2c_piix4(E) ehci_hcd(E) pata_acpi(E) floppy(E)
May 27 11:12:53 reproflushfull kernel: CPU: 0 PID: 797 Comm: kvm
Tainted: G            E      6.9.0-debug #25
May 27 11:12:53 reproflushfull kernel: Hardware name: QEMU Standard PC
(i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org
04/01/2014
May 27 11:12:53 reproflushfull kernel: RIP:
0010:__list_del_entry_valid_or_report+0xd4/0x100
May 27 11:12:53 reproflushfull kernel: Code: 48 89 fe 48 89 ca 48 c7 c7
78 77 9f a1 e8 84 3a 8e ff 0f 0b 31 c0 eb b0 48 89 fe 48 89 c2 48 c7 c7
b0 77 9f a1 e8 6c 3a 8e ff <0f> 0b 31 c0 eb 98 48 89 d1 48 c7 c7 f8 77
9f a1 48 89 f2 48 89 c6
May 27 11:12:53 reproflushfull kernel: RSP: 0018:ffffb1dd80673740
EFLAGS: 00010046
May 27 11:12:53 reproflushfull kernel: RAX: 0000000000000000 RBX:
ffff8ad440be12c0 RCX: 0000000000000000
May 27 11:12:53 reproflushfull kernel: RDX: 0000000000000000 RSI:
0000000000000000 RDI: 0000000000000000
May 27 11:12:53 reproflushfull kernel: RBP: ffffb1dd80673740 R08:
0000000000000000 R09: 0000000000000000
May 27 11:12:53 reproflushfull kernel: R10: 0000000000000000 R11:
0000000000000000 R12: ffff8ad44a8c1e00
May 27 11:12:53 reproflushfull kernel: R13: ffff8ad440be12c0 R14:
ffff8ad44ab63788 R15: ffff8ad44ab63740
May 27 11:12:53 reproflushfull kernel: FS:  00007e8a67c006c0(0000)
GS:ffff8ad577a00000(0000) knlGS:0000000000000000
May 27 11:12:53 reproflushfull kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
May 27 11:12:53 reproflushfull kernel: CR2: 00007e8a5801a008 CR3:
000000010e022001 CR4: 0000000000372ef0
May 27 11:12:53 reproflushfull kernel: Call Trace:
May 27 11:12:53 reproflushfull kernel:  <TASK>
May 27 11:12:53 reproflushfull kernel:  ? show_regs+0x6c/0x80
May 27 11:12:53 reproflushfull kernel:  ? __warn+0x88/0x140
May 27 11:12:53 reproflushfull kernel:  ?
__list_del_entry_valid_or_report+0xd4/0x100
May 27 11:12:53 reproflushfull kernel:  ? report_bug+0x182/0x1b0
May 27 11:12:53 reproflushfull kernel:  ? handle_bug+0x46/0x90
May 27 11:12:53 reproflushfull kernel:  ? exc_invalid_op+0x18/0x80
May 27 11:12:53 reproflushfull kernel:  ? asm_exc_invalid_op+0x1b/0x20
May 27 11:12:53 reproflushfull kernel:  ?
__list_del_entry_valid_or_report+0xd4/0x100
May 27 11:12:53 reproflushfull kernel:  blk_flush_complete_seq+0x2f3/0x360
May 27 11:12:53 reproflushfull kernel:  ? wbt_wait+0x33/0x100
May 27 11:12:53 reproflushfull kernel:  blk_insert_flush+0xce/0x220
May 27 11:12:53 reproflushfull kernel:  blk_mq_submit_bio+0x5cd/0x730
May 27 11:12:53 reproflushfull kernel:  __submit_bio+0xb3/0x1c0
May 27 11:12:53 reproflushfull kernel:
submit_bio_noacct_nocheck+0x2fc/0x3d0
May 27 11:12:53 reproflushfull kernel:  submit_bio_noacct+0x1ba/0x6b0
May 27 11:12:53 reproflushfull kernel:  submit_bio+0xb1/0x110
May 27 11:12:53 reproflushfull kernel:  md_super_write+0xcf/0x110
May 27 11:12:53 reproflushfull kernel:  write_sb_page+0x148/0x300
May 27 11:12:53 reproflushfull kernel:  filemap_write_page+0x5b/0x70
May 27 11:12:53 reproflushfull kernel:  md_bitmap_unplug+0x99/0x1f0
May 27 11:12:53 reproflushfull kernel:  flush_bio_list+0x107/0x110 [raid1]
May 27 11:12:53 reproflushfull kernel:  raid1_unplug+0x3c/0xf0 [raid1]
May 27 11:12:53 reproflushfull kernel:  __blk_flush_plug+0xd9/0x170
May 27 11:12:53 reproflushfull kernel:  blk_finish_plug+0x30/0x50
May 27 11:12:53 reproflushfull kernel:  io_submit_sqes+0x4c4/0x6c0
May 27 11:12:53 reproflushfull kernel:  __do_sys_io_uring_enter+0x2f2/0x640
May 27 11:12:53 reproflushfull kernel:  __x64_sys_io_uring_enter+0x22/0x40
May 27 11:12:53 reproflushfull kernel:  x64_sys_call+0x20b9/0x24b0
May 27 11:12:53 reproflushfull kernel:  do_syscall_64+0x80/0x170
May 27 11:12:53 reproflushfull kernel:  ? do_mprotect_pkey+0x198/0x620
May 27 11:12:53 reproflushfull kernel:  ?
__memcg_slab_post_alloc_hook+0x18e/0x230
May 27 11:12:53 reproflushfull kernel:  ? policy_nodemask+0x145/0x180
May 27 11:12:53 reproflushfull kernel:  ?
__mod_memcg_lruvec_state+0x87/0x120
May 27 11:12:53 reproflushfull kernel:  ? __mod_lruvec_state+0x36/0x50
May 27 11:12:53 reproflushfull kernel:  ? __lruvec_stat_mod_folio+0x70/0xc0
May 27 11:12:53 reproflushfull kernel:  ? set_ptes.constprop.0+0x2b/0xb0
May 27 11:12:53 reproflushfull kernel:  ? _raw_spin_unlock+0xe/0x40
May 27 11:12:53 reproflushfull kernel:  ? do_anonymous_page+0x23d/0x790
May 27 11:12:53 reproflushfull kernel:  ? __pte_offset_map+0x1c/0x1b0
May 27 11:12:53 reproflushfull kernel:  ? __handle_mm_fault+0xc1a/0xe90
May 27 11:12:53 reproflushfull kernel:  ? do_syscall_64+0x8c/0x170
May 27 11:12:53 reproflushfull kernel:  ? __count_memcg_events+0x6f/0xe0
May 27 11:12:53 reproflushfull kernel:  ?
count_memcg_events.constprop.0+0x2a/0x50
May 27 11:12:53 reproflushfull kernel:  ? handle_mm_fault+0xaf/0x340
May 27 11:12:53 reproflushfull kernel:  ? do_user_addr_fault+0x365/0x680
May 27 11:12:53 reproflushfull kernel:  ?
irqentry_exit_to_user_mode+0x76/0x270
May 27 11:12:53 reproflushfull kernel:  ? irqentry_exit+0x43/0x50
May 27 11:12:53 reproflushfull kernel:  ? clear_bhb_loop+0x15/0x70
May 27 11:12:53 reproflushfull kernel:  ? clear_bhb_loop+0x15/0x70
May 27 11:12:53 reproflushfull kernel:  ? clear_bhb_loop+0x15/0x70
May 27 11:12:53 reproflushfull kernel:
entry_SYSCALL_64_after_hwframe+0x76/0x7e
May 27 11:12:53 reproflushfull kernel: RIP: 0033:0x7e8a75069b95
May 27 11:12:53 reproflushfull kernel: Code: 00 00 00 44 89 d0 41 b9 08
00 00 00 83 c8 10 f6 87 d0 00 00 00 01 8b bf cc 00 00 00 44 0f 45 d0 45
31 c0 b8 aa 01 00 00 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 41 83 e2
02 74 c2 f0 48 83 0c 24
May 27 11:12:53 reproflushfull kernel: RSP: 002b:00007e8a67bfafd8
EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
May 27 11:12:53 reproflushfull kernel: RAX: ffffffffffffffda RBX:
00007e8a580039f0 RCX: 00007e8a75069b95
May 27 11:12:53 reproflushfull kernel: RDX: 0000000000000000 RSI:
0000000000000020 RDI: 0000000000000033
May 27 11:12:53 reproflushfull kernel: RBP: 00007e8a580039f8 R08:
0000000000000000 R09: 0000000000000008
May 27 11:12:53 reproflushfull kernel: R10: 0000000000000000 R11:
0000000000000246 R12: 00007e8a58003ae0
May 27 11:12:53 reproflushfull kernel: R13: 0000000000000000 R14:
000064a145ca1c68 R15: 000064a183935450
May 27 11:12:53 reproflushfull kernel:  </TASK>
May 27 11:12:53 reproflushfull kernel: ---[ end trace 0000000000000000 ]---

