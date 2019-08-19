Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809CAC3A59B
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 07:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2522086C
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 07:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfHSHev (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:34:51 -0400
Received: from guest-port.merlins.org ([173.11.111.148]:39531 "EHLO
        mail1.merlins.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfHSHev (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 03:34:51 -0400
X-Greylist: delayed 1579 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Aug 2019 03:34:51 EDT
Received: from svh-gw.merlins.org ([173.11.111.145]:36936 helo=saruman.merlins.org)
        by mail1.merlins.org with esmtps 
        (Cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.92 #3)
        id 1hzbmC-0007pq-2f; Mon, 19 Aug 2019 00:08:28 -0700
Received: from merlin by saruman.merlins.org with local (Exim 4.80)
        (envelope-from <marc@merlins.org>)
        id 1hzbmB-0003Zn-Q3; Mon, 19 Aug 2019 00:08:23 -0700
Date:   Mon, 19 Aug 2019 00:08:23 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org
Message-ID: <20190819070823.GH12521@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 173.11.111.145
X-SA-Exim-Mail-From: marc@merlins.org
Subject: 5.1.21 Dell 2950 terrible swraid5 I/O performance with swraid on top
 of Perc 5/i raid0/jbod
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

(Please Cc me on replies so that I can see them more quickly)

Dear Block Folks,

I just inherited a Dell 2950 with a Perc 5/i.
I really don't want to use that Perc 5/i card, but from all the reading
I did, there is no IT/unraid mode for it, so I was stuck setting the 6
2TB drives as 6 independent raid0 drives using the card.
I wish I could just bypass the card and connect the drives directly to a
sata card, but the case and backplane do not seem to make this possible.

I'm getting very weird and effectively unusable I/O performance if
do I do swraid resync which is throttled at 5MB/s

By bad, I mean bad, see this (in more details below):
 Timing buffered disk reads:   2 MB in 36.15 seconds =  56.65 kB/sec

Dear linux-raid folks,

I realize I have a perc 5/i card underneath I've very much like to remove,
but can't on that system.
Still, I'm hitting some quite unexpected swraid performance, including
a kernel warning and raid unclean shutdown on sysrq poweroff.


So, the 6 perc5/i raid0 drives show up in linux as 6 drives, I
partitioned them and created various software raid slices on top
(raid1, raid5 and raid6).  They work fine, but there is something very
wrong with a block layer somewhere. If I send a bunch of writes, the
IO scheduler seems to introduce terrible latency where my whole system
hangs for a few seconds trying to read simple binaries while from what I
can tell, the I/O platters spend all their time writing the backlog of
what's being sent.

You'll read below that somehow I have a swraid6 running on those 6 drives
and that seems to run at ok speed. But I have a bigger swraid5 across the
same 6 drives, and that runs at terrible speed right now.


I tried to disable the card's write cache to let linux and its 32GB of
RAM, do it better, but I didn't see a real improvement:
newmagic:~# megacli -LDSetProp -DisDskCache -L0 -a0  (0,1,2,3,4,5)
newmagic:~# megacli -LDGetProp -DskCache -Lall -a0
> Adapter 0-VD 0(target id: 0): Disk Write Cache : Disabled
> Adapter 0-VD 1(target id: 1): Disk Write Cache : Disabled
> Adapter 0-VD 2(target id: 2): Disk Write Cache : Disabled
> Adapter 0-VD 3(target id: 3): Disk Write Cache : Disabled
> Adapter 0-VD 4(target id: 4): Disk Write Cache : Disabled
> Adapter 0-VD 5(target id: 5): Disk Write Cache : Disabled

For the raid card, I installed the last bios I could find, and here is what it says.
> megasas: 07.707.51.00-rc1
> megaraid_sas 0000:02:0e.0: PCI IRQ 78 -> rerouted to legacy IRQ 18
> megaraid_sas 0000:02:0e.0: FW now in Ready state
> megaraid_sas 0000:02:0e.0: 63 bit DMA mask and 32 bit consistent mask
> megaraid_sas 0000:02:0e.0: firmware supports msix	: (0)
> megaraid_sas 0000:02:0e.0: current msix/online cpus	: (0/4)
> megaraid_sas 0000:02:0e.0: RDPQ mode	: (disabled)
> megaraid_sas 0000:02:0e.0: controller type	: MR(256MB)
> megaraid_sas 0000:02:0e.0: Online Controller Reset(OCR)	: Enabled
> megaraid_sas 0000:02:0e.0: Secure JBOD support	: No
> megaraid_sas 0000:02:0e.0: NVMe passthru support	: No
> megaraid_sas 0000:02:0e.0: FW provided TM TaskAbort/Reset timeout	: 0 secs/0 secs
> megaraid_sas 0000:02:0e.0: megasas_init_mfi: fw_support_ieee=0
> megaraid_sas 0000:02:0e.0: INIT adapter done
> megaraid_sas 0000:02:0e.0: fw state:c0000000
> megaraid_sas 0000:02:0e.0: Jbod map is not supported megasas_setup_jbod_map 5388
> megaraid_sas 0000:02:0e.0: fwstate:c0000000, dis_OCR=0
> megaraid_sas 0000:02:0e.0: MR_DCMD_PD_LIST_QUERY not supported by firmware
> megaraid_sas 0000:02:0e.0: DCMD not supported by firmware - megasas_ld_list_query 4590
> megaraid_sas 0000:02:0e.0: pci id		: (0x1028)/(0x0015)/(0x1028)/(0x1f03)
> megaraid_sas 0000:02:0e.0: unevenspan support	: no
> megaraid_sas 0000:02:0e.0: firmware crash dump	: no
> megaraid_sas 0000:02:0e.0: jbod sync map		: no

I'm also only getting about 5MB/s sustained write speed, which is
pathetic. I have lots of servers with normal sata cards, software raid,
and I get 50 to 100MB/s normally.
I'm hoping the Perc 5/i card is not _that_ bad?  See below.
md0 : active raid1 sde1[4] sdb1[1] sdd1[3] sda1[0] sdc1[2] sdf1[5]
      975872 blocks super 1.2 [6/6] [UUUUUU]
md1 : active raid6 sde3[4] sdb3[1] sdd3[3] sdf3[5] sda3[0] sdc3[2]
      419164160 blocks super 1.2 level 6, 512k chunk, algorithm 2 [6/6] [UUUUUU]

md2 : active raid6 sde5[4] sdb5[1] sdf5[5] sdd5[3] sdc5[2] sda5[0]
      1677193216 blocks super 1.2 level 6, 512k chunk, algorithm 2 [6/6] [UUUUUU]
      bitmap: 1/4 pages [4KB], 65536KB chunk

md3 : active raid5 sde6[4] sdb6[1] sdd6[3] sdf6[6] sdc6[2] sda6[0]
      7118330880 blocks super 1.2 level 5, 512k chunk, algorithm 2 [6/5] [UUUUU_]
      [=>...................]  recovery =  7.7% (109702192/1423666176) finish=5790.5min speed=3781K/sec
      bitmap: 0/11 pages [0KB], 65536KB chunk

If I access drives plugged directly into the motherboard's sata port, I
get perfect speed. I've also added an SSD with bcache to frontload one
of the raid arrays that is so slow, and sure enough, it becomes usuable.
When my system is slow as crap due to this issue, I can do full speed
I/O to a different drive plugged into the motherboard's Sata chip (but due 
to the case, the drive is actually sitting on the motherboard, there is 
nowhere to mount it).

The main problem is all my raids are using the same 6 devices, so if
anything spams them with a huge queue, I/O is completely starved for the
other devices.
The terrible write performance, which on top of being bad, prevents
pretty much any other I/O to those drives.

After an unclean shutdown explained below, a resync on the same drives but the other 2 raid arrays,
is much faster and does not make the system unresponsive.
md1 : active raid6 sda3[0] sdb3[1] sdf3[5] sdc3[2] sde3[4] sdd3[3]
      419164160 blocks super 1.2 level 6, 512k chunk, algorithm 2 [6/6] [UUUUUU]
      [==================>..]  resync = 91.1% (95553272/104791040) finish=1.7min speed=86952K/sec


If I start the recovery or a big copy/rsync towards md2, things get so slow that other IO
hangs for multiple seconds or even 2mn or more sometimes. Yes, that was the stock debian 
kernel, but similar problems with 5.1.21:
> [13900.007277] INFO: task sendmail:30862 blocked for more than 120 seconds.
> [13900.030181]       Not tainted 4.19.0-5-amd64 #1 Debian 4.19.37-5+deb10u2
> [13900.053131] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [13900.078495] sendmail        D    0 30862  30812 0x00000000
> [13900.099272] Call Trace:
> [13900.113941]  ? __schedule+0x2a2/0x870
> [13900.131022]  ? lookup_fast+0xc8/0x2e0
> [13900.148085]  schedule+0x28/0x80
> [13900.163959]  rwsem_down_write_failed+0x183/0x3a0
> [13900.182741]  ? inode_permission+0xbe/0x180
> [13900.200431]  call_rwsem_down_write_failed+0x13/0x20
> [13900.219731]  down_write+0x29/0x40
> [13900.235849]  path_openat+0x615/0x15c0
> [13900.252665]  ? mem_cgroup_commit_charge+0x7a/0x560
> [13900.271680]  do_filp_open+0x93/0x100
> [13900.288163]  ? __check_object_size+0x15d/0x189
> [13900.306276]  do_sys_open+0x186/0x210
> [13900.322529]  do_syscall_64+0x53/0x110
> [13900.338867]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [13900.358047] RIP: 0033:0x7fa715212c8b
> [13900.374306] Code: Bad RIP value.
> [13900.389850] RSP: 002b:00007ffc26ba42a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> [13900.414289] RAX: ffffffffffffffda RBX: 00005584ee809978 RCX: 00007fa715212c8b
> [13900.437957] RDX: 00000000000000c2 RSI: 00005584ee8198f0 RDI: 00000000ffffff9c
> [13900.461660] RBP: 00005584ee8198f0 R08: 0000000000007fdd R09: 0000000000000000
> [13900.485361] R10: 00000000000001a0 R11: 0000000000000246 R12: 0000000000000000
> [13900.509096] R13: 0000000000000000 R14: 000000000000000a R15: 0000000000000000

I know I can slow down raid recovery speed, to be able to use the system I actually have to do this:
echo 1000 > /proc/sys/dev/raid/speed_limit_min
of course, at 1MB/s, it will take weeks to resync...

At this point, you could ask if my drives are ok speed wise, and we already have the raid6 resync
I showed above at over 80MB/s

I did some basic I/O read-write tests when the resync wasn't running:
> dd if=/dev/mdx of=/dev/null bs=1M count=40000
> f=/var/space/test; dd if=/dev/zero of=$f bs=1M count=3000 conv=fdatasync; \rm $f
> 
> dd read test: /dev/md0 419430400 bytes (419 MB, 400 MiB) copied, 3.13387 s, 134 MB/s, hdparm -t 208.18MB/s
> dd104857600 bytes (105 MB, 100 MiB) copied, 16.1961 s, 6.5 MB/s
> 
> /dev/md1 419430400 bytes (419 MB, 400 MiB) copied, 1.58549 s, 265 MB/s, hdparm -t 335.11MB/s
> 3145728000 bytes (3.1 GB, 2.9 GiB) copied, 6.51223 s, 483 MB/s
> 
> /dev/md2 419430400 bytes (419 MB, 400 MiB) copied, 1.75172 s, 239 MB/s, hdparm -t 256.08MB/s
> 3145728000 bytes (3.1 GB, 2.9 GiB) copied, 5.25801 s, 598 MB/s
> 
> /dev/md3 419430400 bytes (419 MB, 400 MiB) copied, 1.81613 s, 231 MB/s, hdparm -t 382.33MB/s

Then, when it's running at a mere 4MB/s and apparently spamming all the I/O available:
newmagic:~# for i in md0 md1 md2 md3; do hdparm -t /dev/$i; done

/dev/md0:
 HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
 Timing buffered disk reads: 190 MB in  3.00 seconds =  63.26 MB/sec

/dev/md1:
 HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
 Timing buffered disk reads:   4 MB in  3.21 seconds =   1.25 MB/sec
^[
/dev/md2:
 HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
 Timing buffered disk reads:   6 MB in  9.08 seconds = 676.33 kB/sec

/dev/md3:
 HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
 Timing buffered disk reads:   2 MB in 36.15 seconds =  56.65 kB/sec


I also maybe found a bug in software raid during shutoff:
> [14847.171978] sysrq: SysRq : Power Off
> [14852.341924] WARNING: CPU: 0 PID: 2530 at drivers/md/md.c:8180 md_write_inc+0x15/0x40 [md_mod]
> [14852.359192] Modules linked in: fuse ufs qnx4 hfsplus hfs minix vfat msdos fat jfs xfs dm_mod cpuid ipt_MASQUERADE ipt_REJECT nf_reject_ipv4 xt_tcpudp xt_state xt_conntrack nf_log_ipv4 nf_log_common xt_LOG nft_compat nft_counter nft_chain_nat_ipv4 nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_chain_route_ipv4 nf_tables nfnetlink binfmt_misc ext4 crc16 mbcache jbd2 fscrypto ecb crypto_simd cryptd glue_helper aes_x86_64 ipmi_ssif radeon coretemp ttm drm_kms_helper kvm drm evdev dcdbas iTCO_wdt iTCO_vendor_support serio_raw irqbypass sg pcspkr rng_core i2c_algo_bit ipmi_si i5000_edac ipmi_devintf i5k_amb ipmi_msghandler button ip_tables x_tables autofs4 btrfs zstd_decompress zstd_compress xxhash raid10 raid0 multipath linear sata_sil24 e1000e r8169 realtek libphy mii uas usb_storage
> [14852.502352]  raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid1 raid6_pq libcrc32c crc32c_generic hid_generic bcache crc64 usbhid md_mod hid ses enclosure sr_mod scsi_transport_sas cdrom sd_mod ata_generic uhci_hcd ehci_pci ehci_hcd ata_piix libata psmouse lpc_ich megaraid_sas usbcore scsi_mod usb_common bnx2
> [14852.562340] CPU: 0 PID: 2530 Comm: sendmail Not tainted 4.19.0-5-amd64 #1 Debian 4.19.37-5+deb10u2
> [14852.580463] Hardware name: Dell Inc. PowerEdge 2950/0DT021, BIOS 2.7.0 10/30/2010
> [14852.595607] RIP: 0010:md_write_inc+0x15/0x40 [md_mod]
> [14852.605820] Code: ff e8 9f 54 32 f3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 66 66 66 66 90 f6 46 10 01 74 1b 8b 97 c4 01 00 00 85 d2 74 12 <0f> 0b 48 8b 87 e0 02 00 00 a8 03 75 0e 65 48 ff 00 c3 8b 47 40 85
> [14852.643807] RSP: 0000:ffffb1c287767ac0 EFLAGS: 00010002
> [14852.654378] RAX: ffff9615c93a4cf8 RBX: ffff9615c93a4910 RCX: 0000000000000001
> [14852.668807] RDX: 0000000000000001 RSI: ffff96162aa17f00 RDI: ffff961625000000
> [14852.683235] RBP: ffff9615c93a4978 R08: 0000000000000000 R09: ffff961624c3a918
> [14852.697661] R10: 0000000000000000 R11: ffff961625a1f800 R12: 0000000000000001
> [14852.712089] R13: 0000000000000001 R14: ffff961623b6e000 R15: ffff96162aa17f00
> [14852.726518] FS:  00007f2ca54d3f40(0000) GS:ffff96162fa00000(0000) knlGS:0000000000000000
> [14852.742891] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [14852.754505] CR2: 00007f8e63e501c0 CR3: 000000031fb6e000 CR4: 00000000000006f0
> [14852.768931] Call Trace:
> [14852.773891]  add_stripe_bio+0x205/0x7c0 [raid456]
> [14852.783405]  raid5_make_request+0x1bd/0xb60 [raid456]
> [14852.793619]  ? finish_wait+0x80/0x80
> [14852.800851]  ? finish_wait+0x80/0x80
> [14852.808093]  md_handle_request+0x119/0x190 [md_mod]
> [14852.817964]  md_make_request+0x78/0x160 [md_mod]
> [14852.827311]  generic_make_request+0x1a4/0x410
> [14852.836116]  submit_bio+0x45/0x140
> [14852.842991]  ? guard_bio_eod+0x32/0x100
> [14852.850747]  submit_bh_wbc+0x163/0x190
> [14852.858377]  write_all_supers+0x22f/0xa60 [btrfs]
> [14852.867905]  btrfs_commit_transaction+0x581/0x870 [btrfs]
> [14852.878819]  ? finish_wait+0x80/0x80
> [14852.886071]  btrfs_sync_file+0x380/0x3d0 [btrfs]
> [14852.895415]  do_fsync+0x38/0x70
> [14852.901764]  __x64_sys_fsync+0x10/0x20
> [14852.909342]  do_syscall_64+0x53/0x110
> [14852.916742]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [14852.926952] RIP: 0033:0x7f2ca6944a71
> [14852.934185] Code: 6d a5 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b1 0f 1f 80 00 00 00 00 8b 05 da e9 00 00 85 c0 75 16 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 3f c3 66 0f 1f 44 00 00 53 89 fb 48 83 ec 10
> [14852.972172] RSP: 002b:00007fffe32a0368 EFLAGS: 00000246 ORIG_RAX: 000000000000004a
> [14852.987483] RAX: ffffffffffffffda RBX: 000056297ca540d0 RCX: 00007f2ca6944a71
> [14853.001908] RDX: 0000000000000000 RSI: 000056297ca541b0 RDI: 0000000000000004
> [14853.016334] RBP: 00000000000001d7 R08: 000056297ca541b0 R09: 00007f2ca54d3f40
> [14853.030760] R10: 7541203831202c6e R11: 0000000000000246 R12: 000056297bfbe369
> [14853.045189] R13: 00007fffe32a03b0 R14: 000000000000000a R15: 0000000000000000
> [14853.059617] ---[ end trace 407005be9d52ae9f ]---
> [14854.715315] md: md3: recovery interrupted.
> [14877.083807] bcache: bcache_reboot() Stopping all devices:
> [14879.097334] bcache: bcache_reboot() Timeout waiting for devices to be closed
> [14879.111948] sd 4:0:0:0: [sdh] Synchronizing SCSI cache
> [14879.122617] sd 4:0:0:0: [sdh] Stopping disk
> [14879.615609] sd 3:0:0:0: [sdg] Synchronizing SCSI cache
> [14879.626667] sd 3:0:0:0: [sdg] Stopping disk
> [14881.520158] sd 0:2:2:0: [sdc] tag#684 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
> [14881.538216] sd 0:2:2:0: [sdc] tag#684 CDB: Write(10) 2a 00 13 17 1f e8 00 00 08 00
> [14881.553614] print_req_error: I/O error, dev sdc, sector 320282600
> [14881.566001] sd 0:2:4:0: [sde] tag#684 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
> [14881.583982] sd 0:2:4:0: [sde] tag#684 CDB: Write(10) 2a 00 13 17 1f e8 00 00 08 00
> [14881.599303] print_req_error: I/O error, dev sde, sector 320282600
> [14881.611638] sd 0:2:5:0: [sdf] tag#684 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
> [14881.629587] sd 0:2:5:0: [sdf] tag#684 CDB: Write(10) 2a 00 13 17 1f e8 00 00 08 00
> [14881.661536] print_req_error: I/O error, dev sdf, sector 320282600
> [14881.690648] sd 0:2:5:0: [sdf] tag#684 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
> [14881.725455] sd 0:2:5:0: [sdf] tag#684 CDB: Write(10) 2a 00 13 17 20 00 00 02 80 00
> [14881.757640] print_req_error: I/O error, dev sdf, sector 320282624
> [14881.786840] sd 0:2:3:0: [sdd] tag#684 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
> [14881.821202] sd 0:2:3:0: [sdd] tag#684 CDB: Write(10) 2a 00 13 17 1f e8 00 00 08 00
> [14881.852497] print_req_error: I/O error, dev sdd, sector 320282600
> [14881.880392] sd 0:2:0:0: [sda] tag#684 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
> [14881.913429] sd 0:2:0:0: [sda] tag#684 CDB: Write(10) 2a 00 13 17 1f e8 00 00 08 00
> [14881.943303] print_req_error: I/O error, dev sda, sector 320282600
> [14881.969675] sd 0:2:1:0: [sdb] tag#684 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
> [14882.001626] sd 0:2:1:0: [sdb] tag#684 CDB: Write(10) 2a 00 13 17 1f e8 00 00 08 00
> [14882.030904] print_req_error: I/O error, dev sdb, sector 320282600
> [14882.057411] sd 0:2:4:0: [sde] tag#299 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
> [14882.088845] sd 0:2:4:0: [sde] tag#299 CDB: Write(10) 2a 00 13 17 20 00 00 02 80 00
> [14882.117051] print_req_error: I/O error, dev sde, sector 320282624
> [14882.142352] sd 0:2:5:0: [sdf] tag#299 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
> [14882.142430] sd 0:2:4:0: [sde] tag#300 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
> [14882.173313] sd 0:2:5:0: [sdf] tag#299 CDB: Write(10) 2a 00 13 17 22 80 00 01 80 00
> [14882.173315] print_req_error: I/O error, dev sdf, sector 320283264
> [14882.257818] sd 0:2:4:0: [sde] tag#300 CDB: Write(10) 2a 00 13 17 22 80 00 01 80 00
> [14882.286196] print_req_error: I/O error, dev sde, sector 320283264
> [14882.372678] md: super_written gets error=10
> [14882.394226] md/raid:md2: Disk failure on sdc5, disabling device.
> [14882.394226] md/raid:md2: Operation continuing on 5 devices.
> [14882.396634] md: super_written gets error=10
> [14882.443706] md: super_written gets error=10
> [14882.465231] md/raid:md2: Disk failure on sde5, disabling device.
> [14882.465231] md/raid:md2: Operation continuing on 4 devices.
> [14885.396071] bcache: bch_count_backing_io_errors() md2: IO error on backing device, unrecoverable
> [14885.423090] bcache: bch_count_backing_io_errors() md2: IO error on backing device, unrecoverable
> [14885.450404] bcache: bch_count_backing_io_errors() md2: IO error on backing device, unrecoverable
> [14885.476946] bcache: bch_count_backing_io_errors() md2: IO error on backing device, unrecoverable
> [14885.503344] bcache: bch_count_backing_io_errors() md2: IO error on backing device, unrecoverable
> [14885.530389] bcache: bch_count_backing_io_errors() md2: IO error on backing device, unrecoverable
> [14885.563027] bcache: bch_count_backing_io_errors() md2: IO error on backing device, unrecoverable
> [14885.589494] bcache: bch_count_backing_io_errors() md2: IO error on backing device, unrecoverable
> [14885.615995] bcache: bch_count_backing_io_errors() md2: IO error on backing device, unrecoverable
> [14885.642142] bcache: bch_count_backing_io_errors() md2: IO error on backing device, unrecoverable
> [14885.667968] bcache: bch_count_backing_io_errors() md2: IO error on backing device, unrecoverable
> [14885.693224] bcache: bch_count_backing_io_errors() md2: IO error on backing device, unrecoverable
> [14885.717937] bcache: bch_count_backing_io_errors() md2: IO error on backing device, unrecoverable
> [14885.743191] bcache: bch_count_backing_io_errors() md2: IO error on backing device, unrecoverable
> [14885.767407] bcache: bch_count_backing_io_errors() md2: IO error on backing device, unrecoverable
> [14885.792214] bcache: bch_count_backing_io_errors() md2: IO error on backing device, unrecoverable
> [14890.416424] btrfs_dev_stat_print_on_error: 1409 callbacks suppressed
> [14890.416429] BTRFS error (device bcache0): bdev /dev/bcache0 errs: wr 1417, rd 0, flush 0, corrupt 0, gen 0
> [14890.460838] BTRFS error (device bcache0): bdev /dev/bcache0 errs: wr 1418, rd 0, flush 0, corrupt 0, gen 0
> [14890.486347] BTRFS error (device bcache0): bdev /dev/bcache0 errs: wr 1419, rd 0, flush 0, corrupt 0, gen 0
> [14890.511308] BTRFS error (device bcache0): bdev /dev/bcache0 errs: wr 1420, rd 0, flush 0, corrupt 0, gen 0
> [14890.536129] Emergency Sync complete
> [14891.398791] ACPI: Preparing to enter system sleep state S5
> [14891.460410] reboot: Power down
> [14891.471830] acpi_power_off called


megacli -LdPdInfo -a0  output for the first drive below.  
> Number of Virtual Disks: 6
> Virtual Drive: 0 (Target Id: 0)
> Name                :0
> RAID Level          : Primary-0, Secondary-0, RAID Level Qualifier-0
> Size                : 1.818 TB
> Sector Size         : 512
> Parity Size         : 0
> State               : Optimal
> Strip Size          : 64 KB
> Number Of Drives    : 1
> Span Depth          : 1
> Default Cache Policy: WriteBack, ReadAheadNone, Direct, No Write Cache if Bad BBU
> Current Cache Policy: WriteBack, ReadAheadNone, Direct, No Write Cache if Bad BBU
> Default Access Policy: Read/Write
> Current Access Policy: Read/Write
> Disk Cache Policy   : Disabled
> Encryption Type     : None
> Is VD Cached: No
> Number of Spans: 1
> Span: 0 - Number of PDs: 1
> 
> PD: 0 Information
> Enclosure Device ID: 8
> Slot Number: 0
> Drive's position: DiskGroup: 0, Span: 0, Arm: 0
> Enclosure position: N/A
> Device Id: 0
> WWN: 
> Sequence Number: 2
> Media Error Count: 0
> Other Error Count: 1
> Predictive Failure Count: 0
> Last Predictive Failure Event Seq Number: 0
> PD Type: SATA
> 
> Raw Size: 1.819 TB [0xe8e088b0 Sectors]
> Non Coerced Size: 1.818 TB [0xe8d088b0 Sectors]
> Coerced Size: 1.818 TB [0xe8d00000 Sectors]
> Sector Size:  0
> Firmware state: Online, Spun Up
> Device Firmware Level: AB50
> Shield Counter: 0
> Successful diagnostics completion on :  N/A
> SAS Address(0):
>  0x1221000000000000
> Connected Port Number: 0 
> Inquiry Data:      WD-WMAZA0374092WDC WD20EARS-00MVWB0                    50.0AB50
> FDE Capable: Not Capable
> FDE Enable: Disable
> Secured: Unsecured
> Locked: Unlocked
> Needs EKM Attention: No
> Foreign State: None 
> Device Speed: Unknown 
> Link Speed: Unknown 
> Media Type: Hard Disk Device
> Drive Temperature : N/A
> PI Eligibility:  No 
> Drive is formatted for PI information:  No
> PI: No PI
> Port-0 :
> Port status: Active
> Port's Linkspeed: Unknown 
> Drive has flagged a S.M.A.R.T alert : No

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
