Return-Path: <francesco@dolcini.it>
Date: Wed, 5 Oct 2016 13:18:26 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: NeilBrown <neilb@suse.com>, axboe@kernel.dk
Cc: tj@kernel.org, hch@lst.de, axboe@fb.com, akpm@linux-foundation.org,
	linux-block@vger.kernel.org
Subject: Re: blockdev kernel regression (bugzilla 173031)
Message-ID: <20161005111826.GA2430@dev1>
References: <20161004150350.GA27176@dev1>
 <8760p75zc6.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8760p75zc6.fsf@notabene.neil.brown.name>
List-ID: <linux-block@vger.kernel.org>

Hi all,
Adding linux-block in CC for this bug report.


On Wed, Oct 05, 2016 at 01:00:57PM +1100, NeilBrown wrote:
> On Wed, Oct 05 2016, Francesco Dolcini wrote:
> > Hi all,
> > moving from kernel 3.14 to kernel 4.1 I had a kernel regression on block device.
> >
> > Problem first arise while removing a usb flash drive while writing was in
> > progress (details here: https://bugzilla.kernel.org/show_bug.cgi?id=173031).
> >
> > I was able to bisect the issue to commit 6cd18e711dd8075da9d78cfc1239f912ff28968a.
> >
> > Any suggestion? 
> >
> > Maybe b02176f30cd30acccd3b633ab7d9aed8b5da52ff is the correct fix also for v4.1 stable?
> >
> > Andrew Morton in copy since I originally assigned the bug, by mistake, to mm.
> >
> > Thanks,
> > Francesco
> 
> You probably just need
> 
> Commit: bdfe0cbd746a ("Revert "ext4: remove block_device_ejected"")
> 
> NeilBrown

Hi NeilBrown,
bdfe0cbd746a is already present on 4.1-stable, moreover Oops is reproduced also using vfat.


Short recap of the situation, if someone does not need the long story on bugzilla.

Regression in kernel 4.1, Kernel Oops on USB flash drive removal while writing.
Problem was reproduced with ext4 and fat, on x86 and ARM arch.

[   90.740733] BUG: unable to handle kernel paging request at 1dcb5000
[   90.744026] IP: [<c121ca3c>] __percpu_counter_add+0x2c/0xf0
[   90.744026] *pde = 00000000 
[   90.744026] Oops: 0000 [#1] PREEMPT SMP 
[   90.744026] Modules linked in: arc4 ath9k ath9k_common ath9k_hw ath mac80211 cfg80211 rfkill
[   90.744026] CPU: 0 PID: 1534 Comm: dd Tainted: G        W       4.1.33_11 #2
[   90.744026] task: dee12880 ti: defca000 task.ti: defca000
[   90.744026] EIP: 0060:[<c121ca3c>] EFLAGS: 00010002 CPU: 0
[   90.744026] EIP is at __percpu_counter_add+0x2c/0xf0
[   90.744026] EAX: 00000000 EBX: ded84bfc ECX: 00000002 EDX: 00000001
[   90.744026] ESI: ffffffff EDI: de80eb68 EBP: defcbc84 ESP: defcbc68
[   90.744026]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[   90.744026] CR0: 8005003b CR2: 1dcb5000 CR3: 1efa5000 CR4: 000006d0
[   90.744026] Stack:
[   90.744026]  c15ed780 00000019 00000001 00000000 ded84bdc ffffffff de80eb68 defcbc98
[   90.744026]  c10c58ca 00000008 df6bf800 de80eb58 defcbcb4 c1121447 00000000 00000282
[   90.744026]  df6bf800 de040400 de040400 defcbcc0 c11215a4 dd553000 defcbcf4 c1189c5a
[   90.744026] Call Trace:
[   90.744026]  [<c10c58ca>] account_page_dirtied+0x6a/0xc0
[   90.744026]  [<c1121447>] __set_page_dirty+0x37/0xb0
[   90.744026]  [<c11215a4>] mark_buffer_dirty+0x44/0x80
[   90.744026]  [<c1189c5a>] ext4_commit_super+0x17a/0x230
[   90.744026]  [<c118a38b>] __ext4_abort+0x2b/0x110
[   90.744026]  [<c1124f1d>] ? sync_dirty_buffer+0xd/0x10
[   90.744026]  [<c1189c7a>] ? ext4_commit_super+0x19a/0x230
[   90.744026]  [<c119c3c8>] ext4_journal_check_start+0x88/0x90
[   90.744026]  [<c119c495>] __ext4_journal_start_sb+0x15/0x60
[   90.744026]  [<c117f7c4>] ext4_dirty_inode+0x34/0x70
[   90.744026]  [<c111b577>] __mark_inode_dirty+0x27/0x290
[   90.744026]  [<c111039c>] ? setattr_copy+0x6c/0xd0
[   90.744026]  [<c117f36e>] ext4_setattr+0x23e/0x660
[   90.744026]  [<c1173fb7>] ? ext4_file_open+0x37/0x140
[   90.744026]  [<c11107c5>] notify_change+0x1d5/0x350
[   90.744026]  [<c121cac4>] ? __percpu_counter_add+0xb4/0xf0
[   90.744026]  [<c105c17b>] ? get_parent_ip+0xb/0x40
[   90.744026]  [<c10f4b33>] do_truncate+0x53/0x90
[   90.744026]  [<c10c71bd>] ? file_ra_state_init+0xd/0x30
[   90.744026]  [<c11030a8>] do_last.isra.48+0x778/0xe90
[   90.744026]  [<c121c36f>] ? __this_cpu_preempt_check+0xf/0x20
[   90.744026]  [<c1104788>] path_openat+0x68/0x4d0
[   90.744026]  [<c1105c3d>] do_filp_open+0x2d/0x80
[   90.744026]  [<c10f5e31>] do_sys_open+0x111/0x200
[   90.744026]  [<c10f4376>] ? filp_close+0x46/0x60
[   90.744026]  [<c10f5f3f>] SyS_open+0x1f/0x30
[   90.744026]  [<c1418ba2>] syscall_call+0x7/0x7
[   90.744026] Code: 89 e5 57 56 53 89 c3 b8 01 00 00 00 8d 64 24 f0 89 55 ec 89 4d f0 e8 84 f7 e3 ff b8 1b b1 53 c1 e8 2a f9 ff ff 8b 55 ec 8b 43 0c <64> 8b 30 89 f7 8b 4d f0 c1 ff 1f 01 d6 89 75 ec 8b 75 08 11 cf
[   90.744026] EIP: [<c121ca3c>] __percpu_counter_add+0x2c/0xf0 SS:ESP 0068:defcbc68
[   90.744026] CR2: 000000001dcb5000
[   90.744026] ---[ end trace faf081e4d1712537 ]---
[   90.744026] Kernel panic - not syncing: Fatal exception
[   90.744026] Kernel Offset: disabled


Regression is on commit 6cd18e7 ("block: destroy bdi before blockdev is unregistered.")

Commit: bdfe0cbd746a ("Revert "ext4: remove block_device_ejected") is already present on 4.1 stable I am currently working on (2a6f417 on 4.1 branch)

I wonder if commit b02176f ("block: don't release bdi while request_queue has live references") is the correct fix for this also in kernel 4.1.


Thanks for your help,
Francesco
