Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp2.provo.novell.com ([137.65.250.81]:38010 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeACJGY (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Wed, 3 Jan 2018 04:06:24 -0500
Subject: Re: Bug report - issue with bfq?
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>,
        DAVIDE FERRARI <162996@studenti.unimore.it>
References: <c0e98cce-b8b9-643a-40f2-5f2bbd492a0c@suse.com>
 <1A0B436A-62B0-4739-8B3F-67F9D53051F3@linaro.org>
From: Guoqing Jiang <gqjiang@suse.com>
Message-ID: <af514644-16c0-03dc-f40c-f32347ca028f@suse.com>
Date: Wed, 3 Jan 2018 17:06:10 +0800
MIME-Version: 1.0
In-Reply-To: <1A0B436A-62B0-4739-8B3F-67F9D53051F3@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 01/03/2018 03:44 PM, Paolo Valente wrote:
>
>> Il giorno 03 gen 2018, alle ore 04:58, Guoqing Jiang <gqjiang@suse.com> ha scritto:
>>
>> Hi,
>>
> Hi
>
>> In my test, I found some issues when try bfq with xfs.
>> The test basically just set the disk's scheduler to bfq,
>> create xfs on top of it, mount fs and write something,
>> then umount the fs. After several rounds of iteration,
>> I can see different calltraces appeared.
>>
>> For example, the one which happened frequently:
>>
>> Jan 03 11:35:19 linux-mainline kernel: XFS (vdd): Mounting V5 Filesystem
>> Jan 03 11:35:19 linux-mainline kernel: XFS (vdd): Ending clean mount
>> Jan 03 11:35:19 linux-mainline kernel: XFS (vdd): Unmounting Filesystem
>> Jan 03 11:35:19 linux-mainline kernel: XFS (vdd): Mounting V5 Filesystem
>> Jan 03 11:35:19 linux-mainline kernel: XFS (vdd): Ending clean mount
>> Jan 03 11:35:19 linux-mainline kernel: BUG: unable to handle kernel paging request at 0000000000029ec0
>> Jan 03 11:35:19 linux-mainline kernel: IP: __mod_node_page_state+0x5/0x50
>> Jan 03 11:35:19 linux-mainline kernel: PGD 0 P4D 0
>> Jan 03 11:35:19 linux-mainline kernel: Oops: 0000 [#1] SMP KASAN
>> Jan 03 11:35:19 linux-mainline kernel: Modules linked in: bfq(E) joydev(E) uinput(E) fuse(E) af_packet(E) iscsi_ibft(E) iscsi_boot_sysfs(E) snd_hda_codec_generic(E) crct10dif_pclmul(E) crc32_pclmul(E) xfs(E) ghash_clmulni_intel(E) libcrc32c(E) crc32c_intel(E) pcbc(E) snd_hda_intel(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) ppdev(E) aesni_intel(E) snd_timer(E) aes_x86_64(E) crypto_simd(E) snd(E) glue_helper(E) cryptd(E) pcspkr(E) virtio_balloon(E) virtio_net(E) parport_pc(E) parport(E) soundcore(E) i2c_piix4(E) ext4(E) crc16(E) mbcache(E) jbd2(E) virtio_console(E) virtio_rng(E) virtio_blk(E) ata_generic(E) ata_piix(E) ahci(E) libahci(E) floppy(E) ehci_pci(E) qxl(E) serio_raw(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) fb_sys_fops(E) sym53c8xx(E) scsi_transport_spi(E) button(E) libata(E)
>> Jan 03 11:35:19 linux-mainline kernel:  ttm(E) drm(E) uhci_hcd(E) ehci_hcd(E) usbcore(E) virtio_pci(E) virtio_ring(E) virtio(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) autofs4(E)
>> Jan 03 11:35:19 linux-mainline kernel: CPU: 0 PID: 3349 Comm: ps Tainted: G            E    4.15.0-rc1-69-default #1
>> Jan 03 11:35:19 linux-mainline kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.9.1-0-gb3ef39f-prebuilt.qemu-project.org 04/01/2014
>> Jan 03 11:35:19 linux-mainline kernel: task: ffff880061efce80 task.stack: ffff880058bd0000
>> Jan 03 11:35:19 linux-mainline kernel: RIP: 0010:__mod_node_page_state+0x5/0x50
>> Jan 03 11:35:19 linux-mainline kernel: RSP: 0018:ffff880058bd7ce8 EFLAGS: 00010a07
>> Jan 03 11:35:19 linux-mainline kernel: RAX: 00000000000003ff RBX: ffffea00011a3d80 RCX: 00000000011a3d80
>> Jan 03 11:35:19 linux-mainline kernel: RDX: ffffffffffffffff RSI: 000000000000000d RDI: 0000000000000000
>> Jan 03 11:35:19 linux-mainline kernel: RBP: ffffffffffffffff R08: ffff88006378a630 R09: ffff880058bd7d98
>> Jan 03 11:35:19 linux-mainline kernel: R10: 00007f7f4d806280 R11: 0000000000000000 R12: ffffea00011a3d80
>> Jan 03 11:35:19 linux-mainline kernel: R13: 00007f7f4f318000 R14: 00007f7f4f31c000 R15: ffff880058bd7e18
>> Jan 03 11:35:19 linux-mainline kernel: FS:  0000000000000000(0000) GS:ffff880066c00000(0000) knlGS:0000000000000000
>> Jan 03 11:35:19 linux-mainline kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> Jan 03 11:35:19 linux-mainline kernel: CR2: 0000000000029ec0 CR3: 0000000001c0d006 CR4: 00000000001606f0
>> Jan 03 11:35:19 linux-mainline kernel: Call Trace:
>> Jan 03 11:35:19 linux-mainline kernel: page_remove_rmap+0x11a/0x2b0
>> Jan 03 11:35:19 linux-mainline kernel: unmap_page_range+0x547/0xa30
>> Jan 03 11:35:19 linux-mainline kernel:  unmap_vmas+0x42/0x90
>> Jan 03 11:35:19 linux-mainline kernel:  exit_mmap+0x86/0x180
>> Jan 03 11:35:19 linux-mainline kernel:  mmput+0x4a/0x110
>> Jan 03 11:35:19 linux-mainline kernel:  do_exit+0x25d/0xae0
>> Jan 03 11:35:19 linux-mainline kernel:  do_group_exit+0x39/0xa0
>> Jan 03 11:35:19 linux-mainline kernel:  SyS_exit_group+0x10/0x10
>> Jan 03 11:35:19 linux-mainline kernel: entry_SYSCALL_64_fastpath+0x1a/0x7d
>> Jan 03 11:35:19 linux-mainline kernel: RIP: 0033:0x7f7f4eb8c338
>> Jan 03 11:35:19 linux-mainline kernel: RSP: 002b:00007ffca4400d48 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
>> Jan 03 11:35:19 linux-mainline kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7f4eb8c338
>> Jan 03 11:35:19 linux-mainline kernel: RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
>> Jan 03 11:35:19 linux-mainline kernel: RBP: 00007ffca4400d40 R08: 00000000000000e7 R09: fffffffffffffef8
>> Jan 03 11:35:19 linux-mainline kernel: R10: 00007f7f4d806280 R11: 0000000000000246 R12: 00007f7f4f756000
>> Jan 03 11:35:19 linux-mainline kernel: R13: 00007ffca4400cc8 R14: 00007f7f4f732b20 R15: 00007f7f4d5ebc70
>> Jan 03 11:35:19 linux-mainline kernel: Code: f7 d9 48 39 ca 7c 05 65 88 50 0f c3 f0 48 01 94 f7 00 05 00 00 f0 48 01 14 f5 c0 c4 c0 81 31 d2 eb e5 0f 1f 40 00 0f 1f 44 00 00 <48> 8b 8f c0 9e 02 00 89 f6 48 8d 04 31 65 44 8a 40 01 4d 0f be
>> Jan 03 11:35:19 linux-mainline kernel: RIP: __mod_node_page_state+0x5/0x50 RSP: ffff880058bd7ce8
>> Jan 03 11:35:19 linux-mainline kernel: CR2: 0000000000029ec0
>> Jan 03 11:35:19 linux-mainline kernel: ---[ end trace b5314eeef943a473 ]---
>> Jan 03 11:35:19 linux-mainline kernel: Fixing recursive fault but reboot is needed!
>> Jan 03 11:35:19 linux-mainline kernel: XFS (vdd): Unmounting Filesystem
>>
>>
> Yes, this call trace may be related with bfq, because it concerns
> (non-bfq) code that may get executed only when bfq is set as I/O
> scheduler.  In fact, the failure happens on an exit_group, and bfq
> supports cgroups, while either mq-deadline or kyber don't.
>
> Did you also check what __mod_node_page_state+0x5 corresponds to in
> your sources?  Maybe this piece of information could ring some bell, at
> least for people more expert than me on the involved code.


Seems it is a null dereferenced since RDI is 0000000000000000.

(gdb) l *__mod_node_page_state+0x5
0x385 is in __mod_node_page_state 
(/usr/src/kernels/4.15.0-rc1-69-default/mm/vmstat.c:338).
333    EXPORT_SYMBOL(__mod_zone_page_state);
334
335    void __mod_node_page_state(struct pglist_data *pgdat, enum 
node_stat_item item,
336                    long delta)
337    {
338        struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
339        s8 __percpu *p = pcp->vm_node_stat_diff + item;
340        long x;
341        long t;
342

Let me know if you need anything else.

>> Occasionally mount process hangs forever.
>> linux-mainline:~ # cat /proc/19627/stack
>> [<ffffffff810a65f2>] io_schedule+0x12/0x40
>> [<ffffffff8119fbb7>] wait_on_page_bit+0xd7/0x100
>> [<ffffffff811b3713>] truncate_inode_pages_range+0x423/0x7c0
>> [<ffffffff81273768>] set_blocksize+0x98/0xb0
>> [<ffffffff81273798>] sb_set_blocksize+0x18/0x40
>> [<ffffffffa06a2e58>] xfs_fs_fill_super+0x1b8/0x590 [xfs]
>> [<ffffffff8123bd4d>] mount_bdev+0x17d/0x1b0
>> [<ffffffff8123c6d4>] mount_fs+0x34/0x150
>> [<ffffffff81259702>] vfs_kern_mount+0x62/0x110
>> [<ffffffff8125bd1a>] do_mount+0x1ca/0xc30
>> [<ffffffff8125ca6e>] SyS_mount+0x7e/0xd0
>> [<ffffffff8172fff3>] entry_SYSCALL_64_fastpath+0x1a/0x7d
>> [<ffffffffffffffff>] 0xffffffffffffffff
> Maybe this hang has to do with the one already recently reported for
> USB drives.  We have already found the cause of that one, and are
> finalizing our fix.

I am not sure it is the same one since the test is run against virtio disk
not usb, but anyway I can try the fix.

Thanks,
Guoqing
