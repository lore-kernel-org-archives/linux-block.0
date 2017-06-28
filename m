Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0044.outbound.protection.outlook.com ([104.47.41.44]:52075
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751526AbdF1O7E (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 10:59:04 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
CC: =?iso-8859-1?Q?Matias_Bj=F8rling?= <matias@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: LightNVM pblk: read/write of random kernel memory
Date: Wed, 28 Jun 2017 14:58:55 +0000
Message-ID: <CE85E6EB-69AF-4A02-B7DF-F70F2F7E54A3@cnexlabs.com>
References: <42c49a3a-447b-8a31-91b5-92264f196085@gmx.net>
 <BE9E3136-5D3F-44E7-ACE4-49FEC95B330A@cnexlabs.com>
 <7a0a2821-0007-7af0-7eb8-d58650123718@gmx.net>
In-Reply-To: <7a0a2821-0007-7af0-7eb8-d58650123718@gmx.net>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_5513BC81-B814-4018-BBC7-3CFDAE73B4A8";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_5513BC81-B814-4018-BBC7-3CFDAE73B4A8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 28 Jun 2017, at 16.33, Carl-Daniel Hailfinger =
<c-d.hailfinger.devel.2006@gmx.net> wrote:
>=20
> Hi Javier,
>=20
> thanks for the pointer to the github reporting page.
> I'll answer your questions here (to make then indexable by search
> engines in case someone else stumbles upon this) and link to newly
> created github issues for the various problems I encountered.
>=20

Ok. I answered each issue directly on the github. A couple og things
inline though, for completion.

> On 28.06.2017 13:07, Javier Gonzalez wrote:
>> I'll take the question here, but please use our github [1] to report
>> errors and ask questions instead (including this thread). No need to
>> spam the rest of the linux-block mailing list for LightNVM specific
>> matters - unless of course, you want to discuss specific parts of the
>> code.
>>=20
>> [1] https://github.com/OpenChannelSSD
>>=20
>>> On 28 Jun 2017, at 01.30, Carl-Daniel Hailfinger =
<c-d.hailfinger.devel.2006@gmx.net> wrote:
>>>=20
>>> I'm currently having trouble with LightNVM pblk with kernel 4.12-rc7 =
on
>>> Ubuntu 16.04.2 x86_64 in a Qemu VM using latest
>>> https://github.com/OpenChannelSSD/qemu-nvme .
>>>=20
>>> I'm creating a pblk device inside the VM with the following command:
>>> nvme lvnm create -d nvme0n1 --lun-begin=3D0 --lun-end=3D0 -n
>>> mylightnvmdevice -t pblk
>> First of all, can you create qemu configuration and pblk instance =
over
>> more than 1 LUN? There are some assumptions in QEMU on how we do the
>> sparse to linear address space transformation that assume several =
LUNs.
>=20
> Ah, sure, can try. Please document this restriction so others won't =
step
> into that particular trap.
> Filed as https://github.com/OpenChannelSSD/linux/issues/29
>=20
>=20
>> It is possible to change this, if you have a particular use case for
>> using a single LUN.
>=20
> I just thought this would make things simpler, but that was an =
erroneous
> conclusion on my side.
>=20
>=20
>> Also, for this type of testing add the option -f to the create =
command.
>> It will create the instance faster (skipping recovery).
>>=20
>> nvme lvnm create -d nvme0n1 --lun-begin=3D0 --lun-end=3D0 -n
>> mylightnvmdevice -t pblk -f
>>=20
>>> Writing to the pblk device is only partially successful. I can see =
some
>>> of the content which was written to the pblk device turn up in the
>>> backing store file nvmebackingstore10G.nvme, but mostly the backing
>>> store file contains random kernel memory from the VM. Reading back =
the
>>> just written contents from the pblk device in the VM also yields =
random
>>> kernel memory (or at least that's what I think that stuff is, i.e. =
lots
>>> of strings present in various printk calls).
>> Can you better define partially succesful?
>=20
> Some of the contents written to the pblk device inside the vm end up
> being written to the backing store, and some regions of the backing
> store contain random kernel memory of the vm after a write. I am =
unable
> to detect a pattern there, but random kernel memory should never be
> written to disk in any case.
>=20
>=20
>> Which workload are you
>> running on top of the block device exposed by the pblk instance? Is =
it
>> failing in any way?
>=20
> I run fdisk on the instance to create a single partition with maximum
> size, then
> mkfs.ext4 /dev/mylightnvmdevice1
> mount /dev/mylightnvmdevice1 /mnt
> yes yes|head -n 4096 >/mnt/yes
> umount /mnt
>=20
> Sometimes this results in an immediate hang during writing /mnt/yes,
> sometimes it hangs on umount.
> Filed as https://github.com/OpenChannelSSD/linux/issues/28
>=20
>=20
> Inspecting the backing store sometimes yields the expected amount of
> data written, sometimes parts of the backing store contain random vm
> kernel memory. This random kernel memory can also be read from inside
> the vm by hexdumping /dev/mylightnvmdevice .
> Filed as https://github.com/OpenChannelSSD/linux/issues/30
>=20
>=20
>> The backend file is a binary, so reading it will not
>> giv you much information about the data being stored.
>=20
> The backend file is binary, but a hexdump shows that the contents of =
any
> written sector ends up there without changes. It's just the location =
of
> the data inside the backing file which is not straightforward (due to
> the mapping part of the pblk FTL).
>=20
>=20
>>> qemu command line follows:
>>> qemu-nvme.git/x86_64-softmmu/qemu-system-x86_64 -m 4096 -machine
>>> q35,accel=3Dkvm -vga qxl -spice =
port=3D5901,addr=3D127.0.0.1,disable-ticketing
>>> -net nic,model=3De1000 -net user -hda
>>> =
/storage2/vmimages/usefulimages/ubuntu-16.04.2-server-kernel412rc6.qcow2
>>> -drive
>>> file=3D/storage2/vmimages/nvmebackingstore10G.nvme,if=3Dnone,id=3Dmynv=
me
>>> -device
>>> =
nvme,drive=3Dmynvme,serial=3Ddeadbeef,namespaces=3D1,lver=3D1,lmetasize=3D=
16,ll2pmode=3D0,nlbaf=3D5,lba_index=3D3,mdts=3D10,lnum_lun=3D1,
>> As mentioned above, try several with several LUNs.
>>=20
>>> =
lnum_pln=3D2,lsec_size=3D4096,lsecs_per_pg=3D4,lpgs_per_blk=3D512,lbbtable=
=3D/storage2/vmimages/nvmebackingstore10G.bbtable,lmetadata=3D/storage2/vm=
images/nvmebackingstore10G.meta,ldebug=3D1
>>>=20
>>> The backing store file was created with
>>> truncate -s 10G /storage2/vmimages/nvmebackingstore10G.nvme
>>>=20
>>> This might either be a bug in the OpenChannelSSD qemu tree, or it =
might
>>> be a kernel bug.
>>>=20
>>> I also got warnings like the below:
>> In the 4.12 patches for pblk we do not have an error state machine. =
This
>> is, when writes fail on the device (on qemu in this case), we did not
>> communicate this to the application. This bad error handling results =
in
>> unexpected side-errors like the one you are experiencing. On the =
patches
>> for 4.13, we have implemented the error state machine, so this type =
of
>> errors should be better handled.
>=20
> Oh. Shouldn't a minimal version of those patches get merged into 4.12
> (or 4.12-stable once 4.12 is released) to avoid releasing a kernel =
with
> a data corruption bug?

This is only in case the device fails, how we handle the error on the
host. If the device is not accepting writes for some reason, data is
lost anyway. So I don't think we need the fix for stable.

>=20
>=20
>> You can pick up the code from out github (linux.git - branch:
>> pblk.for-4.13) or take it directly form Jens' for-4.13/core
>=20
> Thanks. A full kernel compile will take some time, though. Do you =
happen
> to have a Ubuntu-compatible kernel .deb for the new code?

We thought about, but never actually did it (to share at least). I see
it might be useful :) For the time being, I'll share a minimal .config
for qemu, which takes a couple of minutes to compile.

>=20
>=20
>>> [   40.842852] pblk: double invalidate
>>> [   40.842872] ------------[ cut here ]------------
>>> [   40.842879] WARNING: CPU: 0 PID: 1065 at =
/home/kernel/COD/linux/drivers/lightnvm/pblk-core.c:87 =
__pblk_map_invalidate+0x107/0x150 [pblk]
>>> [   40.842880] Modules linked in: pblk ppdev joydev input_leds =
mac_hid serio_raw lpc_ich parport_pc pvpanic parport ib_iser rdma_cm =
iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi =
autofs4 btrfs raid10 r
>>> aid456 async_raid6_recov async_memcpy async_pq async_xor async_tx =
xor raid6_pq libcrc32c raid1 raid0 multipath linear qxl ttm =
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops psmouse drm =
floppy ahci libahci nvme nvm
>>> e_core e1000
>>> [   40.842906] CPU: 0 PID: 1065 Comm: nvme Not tainted =
4.12.0-999-generic #201706212201
>>> [   40.842906] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org =
04/01/2014
>>> [   40.842907] task: ffff923077ed6a40 task.stack: ffffa3c2c0a64000
>>> [   40.842910] RIP: 0010:__pblk_map_invalidate+0x107/0x150 [pblk]
>>> [   40.842911] RSP: 0018:ffffa3c2c0a67ab0 EFLAGS: 00010282
>>> [   40.842913] RAX: 0000000000000017 RBX: ffff9230777400a4 RCX: =
0000000000000000
>>> [   40.842914] RDX: 0000000000000000 RSI: ffff92307fc0dcc8 RDI: =
ffff92307fc0dcc8
>>> [   40.842914] RBP: ffffa3c2c0a67ad0 R08: 0000000000000001 R09: =
000000000000020b
>>> [   40.842915] R10: 0000000000000000 R11: 000000000000020b R12: =
ffff923077740000
>>> [   40.842916] R13: ffff923077eb3000 R14: 0000000000000008 R15: =
ffff923077eb3000
>>> [   40.842918] FS:  00007f95e8dfa700(0000) GS:ffff92307fc00000(0000) =
knlGS:0000000000000000
>>> [   40.842919] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   40.842919] CR2: 000056365f4d6ce8 CR3: 0000000171e93000 CR4: =
00000000000006f0
>>> [   40.842923] Call Trace:
>>> [   40.842928]  pblk_map_invalidate+0x91/0xa0 [pblk]
>>> [   40.842931]  pblk_update_map+0x62/0x270 [pblk]
>>> [   40.842934]  pblk_recov_l2p+0x338/0x960 [pblk]
>>> [   40.842937]  pblk_init+0x9ca/0xc70 [pblk]
>>> [   40.842940]  ? pblk_init+0x9ca/0xc70 [pblk]
>>> [   40.842943]  ? blkcg_init_queue+0x95/0xe0
>>> [   40.842946]  nvm_ioctl_dev_create.isra.18+0x75e/0xa20
>>> [   40.842948]  ? nvm_ioctl_dev_create.isra.18+0x75e/0xa20
>>> [   40.842951]  nvm_ctl_ioctl+0x23c/0x4c0
>>> [   40.842954]  ? __check_object_size+0xb3/0x190
>>> [   40.842956]  do_vfs_ioctl+0xa3/0x600
>>> [   40.842958]  ? putname+0x54/0x60
>>> [   40.842960]  SyS_ioctl+0x79/0x90
>>> [   40.842962]  entry_SYSCALL_64_fastpath+0x1e/0xa9
>>> [   40.842964] RIP: 0033:0x7f95e8911f07
>>> [   40.842964] RSP: 002b:00007fff007cb048 EFLAGS: 00000246 ORIG_RAX: =
0000000000000010
>>> [   40.842966] RAX: ffffffffffffffda RBX: 00007fff007cd8ca RCX: =
00007f95e8911f07
>>> [   40.842967] RDX: 00007fff007cb060 RSI: 0000000040804c22 RDI: =
0000000000000003
>>> [   40.842967] RBP: 0000000000000000 R08: 0000000000000000 R09: =
0000000000000000
>>> [   40.842968] R10: 00007fff007cd900 R11: 0000000000000246 R12: =
0000000000000000
>>> [   40.842969] R13: 0000000000000000 R14: 0000000000000004 R15: =
00007fff007cd8f9
>>> [   40.842970] Code: 07 00 0f 1f 40 00 5b 41 5c 41 5d 41 5e 5d c3 80 =
3d 6e e3 00 00 00 75 15 48 c7 c7 4c cb 75 c0 c6 05 5e e3 00 00 01 e8 f0 =
f6 a5 ca <0f> ff 48 89 df c6 07 00 0f 1f 40 00 5b 41 5c 41 5d 41 5e 5d =
c3
>>> [   40.842994] ---[ end trace 3232b0c9b6044a9f ]---
>>> [   41.018252] pblk: failed to recover L2P
>>> [   41.057078] pblk: failed to recover L2P
>>> [   41.093799] pblk: failed to recover L2P
>>> [   41.130127] pblk: failed to recover L2P
>>> [   41.166476] pblk: failed to recover L2P
>>> [   41.202939] pblk: failed to recover L2P
>>> [   41.239758] pblk: failed to recover L2P
>>> [   41.275851] pblk: failed to recover L2P
>>> [   41.281475] pblk init: luns:1, lines:638, secs:2613248, buf =
entries:128
>>> [   41.282849]  mylightnvmdevice: mylightnvmdevice1
>>> [  303.375062] EXT4-fs (mylightnvmdevice1): mounted filesystem with =
ordered data mode. Opts: (null)
>>> [  307.023723] ------------[ cut here ]------------
>>> [  307.023743] WARNING: CPU: 0 PID: 1162 at =
/home/kernel/COD/linux/drivers/lightnvm/pblk-core.c:1323 =
pblk_line_put+0xb7/0xc0 [pblk]
>>> [  307.023745] Modules linked in: pblk ppdev joydev input_leds =
mac_hid serio_raw lpc_ich parport_pc pvpanic parport ib_iser rdma_cm =
iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi =
autofs4 btrfs raid10 r
>>> aid456 async_raid6_recov async_memcpy async_pq async_xor async_tx =
xor raid6_pq libcrc32c raid1 raid0 multipath linear qxl ttm =
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops psmouse drm =
floppy ahci libahci nvme nvm
>>> e_core e1000
>>> [  307.023861] CPU: 0 PID: 1162 Comm: ext4lazyinit Tainted: G        =
W       4.12.0-999-generic #201706212201
>>> [  307.023862] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org =
04/01/2014
>>> [  307.023863] task: ffff923072ff8000 task.stack: ffffa3c2c0c80000
>>> [  307.023868] RIP: 0010:pblk_line_put+0xb7/0xc0 [pblk]
>>> [  307.023869] RSP: 0018:ffffa3c2c0c83ac8 EFLAGS: 00010293
>>> [  307.023871] RAX: 0000000000000000 RBX: ffff923077eb3000 RCX: =
0000000000000000
>>> [  307.023873] RDX: 0000000000000001 RSI: ffff9230777405e0 RDI: =
ffff9230777405e4
>>> [  307.023874] RBP: ffffa3c2c0c83ae8 R08: 8000000000000009 R09: =
ffff923078c44040
>>> [  307.023875] R10: ffffa3c2c0a5fd30 R11: 00000000000003af R12: =
ffff9230777405e0
>>> [  307.023876] R13: ffff9230777405e4 R14: ffff923077740540 R15: =
ffff9230777405e0
>>> [  307.023878] FS:  0000000000000000(0000) GS:ffff92307fc00000(0000) =
knlGS:0000000000000000
>>> [  307.023880] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  307.023881] CR2: 0000000001701808 CR3: 00000001788ee000 CR4: =
00000000000006f0
>>> [  307.023886] Call Trace:
>>> [  307.023893]  __pblk_rb_update_l2p+0xcb/0xd0 [pblk]
>>> [  307.023898]  pblk_rb_may_write_user+0x15f/0x180 [pblk]
>>> [  307.023902]  pblk_write_to_cache+0x6f/0x1b0 [pblk]
>>> [  307.023906]  pblk_make_rq+0x71/0x120 [pblk]
>>> [  307.023909]  ? pblk_make_rq+0x71/0x120 [pblk]
>>> [  307.023914]  generic_make_request+0x11e/0x2d0
>>> [  307.023916]  submit_bio+0x73/0x150
>>> [  307.023918]  ? submit_bio+0x73/0x150
>>> [  307.023921]  next_bio+0x38/0x40
>>> [  307.023923]  __blkdev_issue_zeroout+0x159/0x200
>>> [  307.023926]  blkdev_issue_zeroout+0x6c/0xc0
>>> [  307.023931]  ext4_init_inode_table+0x18a/0x380
>>> [  307.023934]  ? ext4_init_inode_table+0x18a/0x380
>>> [  307.023938]  ext4_lazyinit_thread+0x296/0x3b0
>>> [  307.023942]  kthread+0x109/0x140
>>> [  307.023945]  ? init_once+0x80/0x80
>>> [  307.023948]  ? kthread_create_on_node+0x70/0x70
>>> [  307.023951]  ret_from_fork+0x25/0x30
>>> [  307.023952] Code: 49 89 44 24 88 48 89 10 83 43 64 01 c6 07 00 0f =
1f 40 00 48 8d bb 68 02 00 00 4c 89 f6 e8 a2 7c 00 00 5b 41 5c 41 5d 41 =
5e 5d c3 <0f> ff e9 7a ff ff ff 66 90 0f 1f 44 00 00 55 48 89 e5 41 57 =
41
>>> [  307.023986] ---[ end trace 3232b0c9b6044aa0 ]---
>>> [  307.023989] refcount_t: underflow; use-after-free.
>>> [  307.024001] ------------[ cut here ]------------
>>> [  307.024006] WARNING: CPU: 0 PID: 1162 at =
/home/kernel/COD/linux/lib/refcount.c:184 =
refcount_sub_and_test+0x45/0x50
>>> [  307.024006] Modules linked in: pblk ppdev joydev input_leds =
mac_hid serio_raw lpc_ich parport_pc pvpanic parport ib_iser rdma_cm =
iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi =
autofs4 btrfs raid10 raid456 async_raid6_recov async_memcpy async_pq =
async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear =
qxl ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops =
psmouse drm floppy ahci libahci nvme nvme_core e1000
>>> [  307.024033] CPU: 0 PID: 1162 Comm: ext4lazyinit Tainted: G        =
W       4.12.0-999-generic #201706212201
>>> [  307.024034] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org =
04/01/2014
>>> [  307.024035] task: ffff923072ff8000 task.stack: ffffa3c2c0c80000
>>> [  307.024037] RIP: 0010:refcount_sub_and_test+0x45/0x50
>>> [  307.024038] RSP: 0018:ffffa3c2c0c83ad8 EFLAGS: 00010286
>>> [  307.024040] RAX: 0000000000000026 RBX: 0000000000000001 RCX: =
0000000000000006
>>> [  307.024041] RDX: 0000000000000000 RSI: 0000000000000082 RDI: =
ffff92307fc0dcc0
>>> [  307.024043] RBP: ffffa3c2c0c83ad8 R08: 0000000000000001 R09: =
0000000000000264
>>> [  307.024044] R10: ffffa3c2c0c83a50 R11: 0000000000000264 R12: =
ffff923077eb3220
>>> [  307.024045] R13: ffffa3c2c08f1048 R14: ffff923077eb3208 R15: =
ffff9230777405e0
>>> [  307.024047] FS:  0000000000000000(0000) GS:ffff92307fc00000(0000) =
knlGS:0000000000000000
>>> [  307.024048] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  307.024049] CR2: 0000000001701808 CR3: 00000001788ee000 CR4: =
00000000000006f0
>>> [  307.024052] Call Trace:
>>> [  307.024055]  refcount_dec_and_test+0x11/0x20
>>> [  307.024059]  __pblk_rb_update_l2p+0x7a/0xd0 [pblk]
>>> [  307.024063]  pblk_rb_may_write_user+0x15f/0x180 [pblk]
>>> [  307.024067]  pblk_write_to_cache+0x6f/0x1b0 [pblk]
>>> [  307.024071]  pblk_make_rq+0x71/0x120 [pblk]
>>> [  307.024074]  ? pblk_make_rq+0x71/0x120 [pblk]
>>> [  307.024076]  generic_make_request+0x11e/0x2d0
>>> [  307.024079]  submit_bio+0x73/0x150
>>> [  307.024081]  ? submit_bio+0x73/0x150
>>> [  307.024083]  next_bio+0x38/0x40
>>> [  307.024085]  __blkdev_issue_zeroout+0x159/0x200
>>> [  307.024087]  blkdev_issue_zeroout+0x6c/0xc0
>>> [  307.024091]  ext4_init_inode_table+0x18a/0x380
>>> [  307.024094]  ? ext4_init_inode_table+0x18a/0x380
>>> [  307.024097]  ext4_lazyinit_thread+0x296/0x3b0
>>> [  307.024100]  kthread+0x109/0x140
>>> [  307.024103]  ? init_once+0x80/0x80
>>> [  307.024105]  ? kthread_create_on_node+0x70/0x70
>>> [  307.024107]  ret_from_fork+0x25/0x30
>>> [  307.024109] Code: 75 e6 85 d2 0f 94 c0 c3 31 c0 c3 80 3d 19 55 b2 =
00 00 75 f4 55 48 c7 c7 88 cd ce 8b c6 05 08 55 b2 00 01 48 89 e5 e8 22 =
4f d5 ff <0f> ff 31 c0 5d c3 0f 1f 44 00 00 55 48 89 fe bf 01 00 00 00 =
48
>>> [  307.024142] ---[ end trace 3232b0c9b6044aa1 ]---
>>> [  484.430925] INFO: task jbd2/mylightnvm:1160 blocked for more than =
120 seconds.
>>> [  484.432106]       Tainted: G        W       4.12.0-999-generic =
#201706212201
>>> [  484.432340] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" =
disables this message.
>>> [  484.432567] jbd2/mylightnvm D    0  1160      2 0x00000000
>>> [  484.432570] Call Trace:
>>> [  484.432606]  __schedule+0x3c9/0x850
>>> [  484.432616]  ? __enqueue_entity+0x6c/0x70
>>> [  484.432619]  ? wake_atomic_t_function+0x60/0x60
>>> [  484.432621]  schedule+0x36/0x80
>>> [  484.432628]  jbd2_journal_commit_transaction+0x25e/0x1710
>>> [  484.432630]  ? update_load_avg+0x429/0x5a0
>>>=20
>>>=20
>>> AFAICS pblk should not cause such problems.
>>>=20
>>> Reproducing with qemu is easy. One or two reboots of the VM might be =
needed.
>>>=20
>>> Side note: I have to recreate the pblk device after every reboot =
because
>>> it is not recognized automatically.
>>> nvme lvnm create -d nvme0n1 --lun-begin=3D0 --lun-end=3D0 -n
>>> mylightnvmdevice -t pblk
>> You need to re-create the instance each time. Think of it as mounting =
a
>> file system.
>=20
> Oh. I had assumed that this operation was more akin to creating a LVM
> logical volume.
> If I re-create the instance with differing values (e.g. different =
LUNs),
> will the data still be there or will creation be refused to avoid data =
loss?
> Filed as https://github.com/OpenChannelSSD/linux/issues/31
>=20
> Regards,
> Carl-Daniel

Javier

--Apple-Mail=_5513BC81-B814-4018-BBC7-3CFDAE73B4A8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZU8QuAAoJECF+MVChUZ50iwsP/RjrasHj/v5aRKU4T2gnDWNc
eI8wn1BHM4eNOiHYNxARtRxqI0+T0SXw2nBeNWrwWeHD7jxQhUTkeYasWm73gbie
x3wylfcjPVoymXQw1+OgVP54iGuU+LI7NPEmB0Rx+6MRAj9DbGEn1QnnKDA48KGB
52erApXxmaSjh2OJcxw7yLZxV83uyZ9cTOBJpZ8QBJXNFX5gAn/KJuYNT0C840VA
Wm/mMzuFuj8YEEsrY9fdWTWeMsrruEXissjj/Q0HpJ4kn/JJxwuD4pLc+ISTdfWC
gPl6sRgK5+mKV7oDBTKYthTKSPbg3gxoe5Vjn0HR/G0fpMYC2Xn5POCAvzeai4d4
Y0cZXNDP3/X/zeXhZjpViZOpX4EOx1POpQiuI4l6O3LyNEU0STZ1q6p1BzKpes6c
rJnkE9eZVFx/LYjUKjTfDZdh93l2LEtf2l/epYDbiSryXHYnySYS6O0tZ/+kJsm+
gWa/tJAhOXaA7eUW0zZuCeSzpfJm2QWRTrkjPIShQrQChBPw81s8PRsjcx7O5l7e
pXw0cLBWeHlplRRgenKRe+hgyfN8MgyNu4XZolGHLxIShrO4DzYvEdLiBlcJ2f1b
6tTepDLSzOc6XepXC5/7CkM0qjakcLjf3wkMRVooLVo2QogKEeuBkFvzMJD5wL33
LF5yYatqhz/E6/Dd5guZ
=ml5O
-----END PGP SIGNATURE-----

--Apple-Mail=_5513BC81-B814-4018-BBC7-3CFDAE73B4A8--
