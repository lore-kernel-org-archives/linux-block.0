Return-Path: <francesco@dolcini.it>
Date: Thu, 6 Oct 2016 09:54:09 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: NeilBrown <neilb@suse.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, axboe@kernel.dk,
	tj@kernel.org, hch@lst.de, axboe@fb.com, akpm@linux-foundation.org,
	linux-block@vger.kernel.org
Subject: Re: blockdev kernel regression (bugzilla 173031)
Message-ID: <20161006075409.GA4059@dev1>
References: <20161004150350.GA27176@dev1>
 <8760p75zc6.fsf@notabene.neil.brown.name>
 <20161005111826.GA2430@dev1>
 <87k2dm3ueb.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87k2dm3ueb.fsf@notabene.neil.brown.name>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 06, 2016 at 04:42:52PM +1100, NeilBrown wrote:
cc
> Maybe there is a race, but that seems unlikely.

Consider that just hot removal while writing is not enough to 
reproduce systematically the bug.

while true; do [ ! -f /media/usb/.not_mounted ] \
	&& dd if=/dev/zero of=/media/usb/aaa bs=1k \
	count=1 2>/dev/null && echo -n '*' ; done

with lazy umount by mdev on USB flash drive removal

reproduce the problem pretty always

> The vfat issue is different, and is only a warning.
Why you say is only a warning? Here the Oops with vfat on ARM/i.MX6:

[  103.493761] Unable to handle kernel paging request at virtual address 50886000
[  103.500996] pgd = cecec000
[  103.503709] [50886000] *pgd=00000000
[  103.507310] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[  103.512626] Modules linked in:
[  103.515707] CPU: 3 PID: 2071 Comm: umount Tainted: G        W       4.1.33-01808-gab8d223 #4
[  103.524150] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  103.530684] task: ce67cc00 ti: cecd8000 task.ti: cecd8000
[  103.536096] PC is at __percpu_counter_add+0x2c/0x104
[  103.541068] LR is at __percpu_counter_add+0x24/0x104
[  103.546044] pc : [<801dcca0>]    lr : [<801dcc98>]    psr: 200c0093
[  103.546044] sp : cecd9e08  ip : 00000000  fp : 00000000
[  103.557525] r10: d1970ba0  r9 : 00000001  r8 : 00000000
[  103.562755] r7 : ffffffff  r6 : ffffffff  r5 : 00000018  r4 : ce411150
[  103.569288] r3 : 00000000  r2 : 50886000  r1 : 805eb7d0  r0 : 00000003
[  103.575821] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  103.583049] Control: 10c53c7d  Table: 5ecec04a  DAC: 00000015
[  103.588800] Process umount (pid: 2071, stack limit = 0xcecd8210)
[  103.594812] Stack: (0xcecd9e08 to 0xcecda000)
[  103.599180] 9e00:                   200c0013 cc024b5c ffffffff cc024b5c 00000000 00000001
[  103.607365] 9e20: d1970ba0 8009599c 00000018 d1970ba0 00040831 cecd9f00 00000000 80095bc4
[  103.615550] 9e40: 0000000e ce06b900 d0f22640 00000004 00000001 00000000 00000002 cecd9e78
[  103.623736] 9e60: 800954d0 cc024b5c ffffe000 000003c6 00000002 00000000 d1970ba0 d1960620
[  103.631922] 9e80: cecd8000 800b5b90 ffffe000 cc36bee0 a00c0013 00000001 ffffe000 00000001
[  103.640107] 9ea0: cecd9eb4 80043108 cecd9f00 cecd9efc 000ac998 cc024b5c cecd9f00 00000000
[  103.648293] 9ec0: 00000000 8000ebc4 cecd8000 00000000 000ac998 80095cf8 cecd9ed8 cecd9ed8
[  103.656478] 9ee0: cecd9ee0 cecd9ee0 cecd9ee8 cecd9ee8 cc024b5c cc024b5c 00000000 8008e7cc
[  103.664662] 9f00: 7fffffff 00000000 00000000 00000000 ffffffff 7fffffff 00000000 00000000
[  103.672847] 9f20: ce73b800 804aaf00 00000034 8008e868 ffffffff 7fffffff 00000000 cc024a90
[  103.681033] 9f40: ce73b800 800e0090 ce73b800 ce73b864 804aaf00 800bcec8 cc024a00 00000083
[  103.689218] 9f60: 806c95a0 800bd184 ce73b800 806aac0c 806c95a0 800bd448 cebf39c0 00000000
[  103.697404] 9f80: 806c95a0 800d44c4 ce67cc00 8003c6c8 8000ebc4 cecd8000 cecd9fb0 800116bc
[  103.705589] 9fa0: 011fd408 011fd428 011fd408 8000ea8c 00000000 00000002 00000000 00000000
[  103.713774] 9fc0: 011fd408 011fd428 011fd408 00000034 00000002 011fd438 011fd408 000ac998
[  103.721959] 9fe0: 76e0a441 7ef6abac 00050fe0 76e0a446 800c0030 011fd428 00000000 00000000
[  103.730163] [<801dcca0>] (__percpu_counter_add) from [<8009599c>] (clear_page_dirty_for_io+0xac/0xd8)
[  103.739401] [<8009599c>] (clear_page_dirty_for_io) from [<80095bc4>] (write_cache_pages+0x1fc/0x2f4)
[  103.748550] [<80095bc4>] (write_cache_pages) from [<80095cf8>] (generic_writepages+0x3c/0x60)
[  103.757090] [<80095cf8>] (generic_writepages) from [<8008e7cc>] (__filemap_fdatawrite_range+0x64/0x6c)
[  103.766412] [<8008e7cc>] (__filemap_fdatawrite_range) from [<8008e868>] (filemap_flush+0x24/0x2c)
[  103.775306] [<8008e868>] (filemap_flush) from [<800e0090>] (sync_filesystem+0x60/0xa8)
[  103.783240] [<800e0090>] (sync_filesystem) from [<800bcec8>] (generic_shutdown_super+0x28/0xd4)
[  103.791953] [<800bcec8>] (generic_shutdown_super) from [<800bd184>] (kill_block_super+0x18/0x64)
[  103.800750] [<800bd184>] (kill_block_super) from [<800bd448>] (deactivate_locked_super+0x4c/0x7c)
[  103.809638] [<800bd448>] (deactivate_locked_super) from [<800d44c4>] (cleanup_mnt+0x4c/0x6c)
[  103.818097] [<800d44c4>] (cleanup_mnt) from [<8003c6c8>] (task_work_run+0xb4/0xc8)
[  103.825688] [<8003c6c8>] (task_work_run) from [<800116bc>] (do_work_pending+0x90/0xa4)
[  103.833623] [<800116bc>] (do_work_pending) from [<8000ea8c>] (work_pending+0xc/0x20)
[  103.841378] Code: e59f00d8 ebfff186 e5943018 ee1d2f90 (e7933002) 
[  103.847477] ---[ end trace 5b641bdc50ddcfe7 ]---
[  103.852101] Kernel panic - not syncing: Fatal exception
[  103.857337] CPU1: stopping
[  103.860059] CPU: 1 PID: 277 Comm: sh Tainted: G      D W       4.1.33-01808-gab8d223 #4
[  103.868068] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  103.874623] [<80014bc4>] (unwind_backtrace) from [<80011a60>] (show_stack+0x10/0x14)
[  103.882384] [<80011a60>] (show_stack) from [<80495e24>] (dump_stack+0x70/0x8c)
[  103.889623] [<80495e24>] (dump_stack) from [<80013b44>] (handle_IPI+0xd0/0x174)
[  103.896945] [<80013b44>] (handle_IPI) from [<800093c0>] (gic_handle_irq+0x58/0x60)
[  103.904527] [<800093c0>] (gic_handle_irq) from [<80012784>] (__irq_usr+0x44/0x60)
[  103.912015] Exception stack(0xce753fb0 to 0xce753ff8)
[  103.917074] 3fa0:                                     0000012c 76f07a90 76f07a98 76f07a90
[  103.925260] 3fc0: 76f077d8 76f077a8 76f077d8 0000270f 00000808 76f07228 76eea6d4 000001ff
[  103.933445] 3fe0: 000aa34c 7eb60028 76f077a8 76e6fefc 600d0030 ffffffff
[  103.940066] CPU2: stopping
[  103.942788] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D W       4.1.33-01808-gab8d223 #4
[  103.951231] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  103.957781] [<80014bc4>] (unwind_backtrace) from [<80011a60>] (show_stack+0x10/0x14)
[  103.965539] [<80011a60>] (show_stack) from [<80495e24>] (dump_stack+0x70/0x8c)
[  103.972775] [<80495e24>] (dump_stack) from [<80013b44>] (handle_IPI+0xd0/0x174)
[  103.980096] [<80013b44>] (handle_IPI) from [<800093c0>] (gic_handle_irq+0x58/0x60)
[  103.987676] [<800093c0>] (gic_handle_irq) from [<800124c0>] (__irq_svc+0x40/0x74)
[  103.995163] Exception stack(0xce097f70 to 0xce097fb8)
[  104.000222] 7f60:                                     ce097fb8 00000018 2e2a9789 00000018
[  104.008408] 7f80: 00000000 d0f15ce8 2e2a9789 00000018 2df279a6 00000018 00000000 806a05f4
[  104.016594] 7fa0: 00000009 ce097fb8 8006a850 802ef9cc 600c0013 ffffffff
[  104.023226] [<800124c0>] (__irq_svc) from [<802ef9cc>] (cpuidle_enter_state+0xc4/0x1a0)
[  104.031250] [<802ef9cc>] (cpuidle_enter_state) from [<80052aa8>] (cpu_startup_entry+0x1a4/0x264)
[  104.040049] [<80052aa8>] (cpu_startup_entry) from [<1000946c>] (0x1000946c)
[  104.047019] CPU0: stopping
[  104.049740] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D W       4.1.33-01808-gab8d223 #4
[  104.058184] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  104.064733] [<80014bc4>] (unwind_backtrace) from [<80011a60>] (show_stack+0x10/0x14)
[  104.072491] [<80011a60>] (show_stack) from [<80495e24>] (dump_stack+0x70/0x8c)
[  104.079724] [<80495e24>] (dump_stack) from [<80013b44>] (handle_IPI+0xd0/0x174)
[  104.087045] [<80013b44>] (handle_IPI) from [<800093c0>] (gic_handle_irq+0x58/0x60)
[  104.094625] [<800093c0>] (gic_handle_irq) from [<800124c0>] (__irq_svc+0x40/0x74)
[  104.102112] Exception stack(0x8069ff38 to 0x8069ff80)
[  104.107170] ff20:                                                       8069ff80 00000018
[  104.115356] ff40: 2e2a963c 00000018 00000000 d0efdce8 2e2a963c 00000018 2df282c4 00000018
[  104.123543] ff60: 00000000 806a05f4 00000009 8069ff80 8006a850 802ef9cc 600c0013 ffffffff
[  104.131735] [<800124c0>] (__irq_svc) from [<802ef9cc>] (cpuidle_enter_state+0xc4/0x1a0)
[  104.139754] [<802ef9cc>] (cpuidle_enter_state) from [<80052aa8>] (cpu_startup_entry+0x1a4/0x264)
[  104.148555] [<80052aa8>] (cpu_startup_entry) from [<80667b90>] (start_kernel+0x2d8/0x330)
[  104.156741] Rebooting in 60 seconds..


> > Regression is on commit 6cd18e7 ("block: destroy bdi before blockdev is unregistered.")
> >
> > Commit: bdfe0cbd746a ("Revert "ext4: remove block_device_ejected") is already present on 4.1 stable I am currently working on (2a6f417 on 4.1 branch)
> >
> > I wonder if commit b02176f ("block: don't release bdi while request_queue has live references") is the correct fix for this also in kernel 4.1.
> 
> Maybe.  It is worth a try.
> 
> Below is a a backport to 4.1.33.  It compiles, but I haven't tested.
> If it works for you, I can recommend it for -stable.

I confirm that it works!

Thanks,
Francesco
