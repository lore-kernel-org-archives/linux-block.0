Return-Path: <bauerman@linux.vnet.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4 v2] BDI lifetime fix
Date: Mon, 06 Feb 2017 12:48:42 -0200
In-Reply-To: <20170131125429.14303-1-jack@suse.cz>
References: <20170131125429.14303-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2851869.q2N89k4IqL@morokweng>
List-ID: <linux-block@vger.kernel.org>

Hello,

Am Dienstag, 31. Januar 2017, 13:54:25 BRST schrieb Jan Kara:
> this is a second version of the patch series that attempts to solve the
> problems with the life time of a backing_dev_info structure. Currently it
> lives inside request_queue structure and thus it gets destroyed as soon as
> request queue goes away. However the block device inode still stays around
> and thus inode_to_bdi() call on that inode (e.g. from flusher worker) may
> happen after request queue has been destroyed resulting in oops.
> 
> This patch set tries to solve these problems by making backing_dev_info
> independent structure referenced from block device inode. That makes sure
> inode_to_bdi() cannot ever oops. I gave some basic testing to the patches
> in KVM and on a real machine, Dan was running them with libnvdimm test suite
> which was previously triggering the oops and things look good. So they
> should be reasonably healthy. Laurent, if you can give these patches
> testing in your environment where you were triggering the oops, it would be
> nice.

I know you posted a v3, but we are seeing this crash on v2 and looking at
v3's changelog it doesn't seem it would make a difference:

6:mon> th
[c000000003e6b940] c00000000037d15c writeback_sb_inodes+0x30c/0x590
[c000000003e6ba50] c00000000037d4c4 __writeback_inodes_wb+0xe4/0x150
[c000000003e6bab0] c00000000037d91c wb_writeback+0x2fc/0x440
[c000000003e6bb80] c00000000037e778 wb_workfn+0x268/0x580
[c000000003e6bc90] c0000000000f3890 process_one_work+0x1e0/0x590
[c000000003e6bd20] c0000000000f3ce8 worker_thread+0xa8/0x660
[c000000003e6bdc0] c0000000000fd124 kthread+0x154/0x1a0
[c000000003e6be30] c00000000000b4e8 ret_from_kernel_thread+0x5c/0x74
--- Exception: 0  at 0000000000000000
6:mon> r
R00 = c00000000037d15c   R16 = c0000001fca60160
R01 = c000000003e6b8e0   R17 = c0000001fca600d8
R02 = c0000000014c3800   R18 = c0000001fca601c8
R03 = c0000001fca600d8   R19 = 0000000000000000
R04 = c0000000036478d0   R20 = 0000000000000000
R05 = 0000000000000000   R21 = c000000003e68000
R06 = 00000001fee70000   R22 = c0000001f49d17c0
R07 = 0001c6ce3a83dfca   R23 = c0000001f49d17a0
R08 = 0000000000000000   R24 = 0000000000000000
R09 = 0000000000000000   R25 = c0000001fca60160
R10 = 0000000080000006   R26 = 0000000000000000
R11 = c0000000fb627b68   R27 = 0000000000000000
R12 = 0000000000002200   R28 = 0000000000000001
R13 = c00000000fb83600   R29 = c0000001fca600d8
R14 = c0000000000fcfd8   R30 = c000000003e6bbe0
R15 = 0000000000000000   R31 = 0000000000000000
pc  = c0000000003799a0 locked_inode_to_wb_and_lock_list+0x50/0x290
cfar= c0000000005f5568 iowrite16+0x38/0xb0
lr  = c00000000037d15c writeback_sb_inodes+0x30c/0x590
msr = 800000000280b033   cr  = 24e62882
ctr = c00000000012c110   xer = 0000000000000000   trap =  300
dar = 0000000000000000   dsisr = 40000000
6:mon> sh
[312489.344110] INFO: rcu_sched detected stalls on CPUs/tasks:
[312489.396998] INFO: rcu_sched detected stalls on CPUs/tasks:
[312489.397003]         3-...: (4 ticks this GP) idle=59b/140000000000001/0 softirq=18323196/18323196 fqs=2
[312489.397005]         6-...: (1 GPs behind) idle=86f/140000000000001/0 softirq=18012373/18012374 fqs=2
[312489.397005]         (detected by 2, t=47863798 jiffies, g=9340524, c=9340523, q=170)
[312489.505361] rcu_sched kthread starved for 47863823 jiffies! g9340524 c9340523 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1
[312489.537334]         3-...: (26 ticks this GP) idle=59b/140000000000000/0 softirq=18323196/18323196 fqs=2
[312489.537395]         6-...: (1 GPs behind) idle=86f/140000000000001/0 softirq=18012373/18012374 fqs=2
[312489.537454]         (detected by 0, t=47863836 jiffies, g=9340524, c=9340523, q=170)
[312489.537528] rcu_sched kthread starved for 47863832 jiffies! g9340524 c9340523 f0x2 RCU_GP_WAIT_FQS(3) ->state=0x0
[312489.672967] Unable to handle kernel paging request for data at address 0x00000000
[312489.673028] Faulting instruction address: 0xc0000000003799a0
cpu 0x6: Vector: 300 (Data Access) at [c000000003e6b660]
    pc: c0000000003799a0: locked_inode_to_wb_and_lock_list+0x50/0x290
    lr: c00000000037d15c: writeback_sb_inodes+0x30c/0x590
    sp: c000000003e6b8e0
   msr: 800000000280b433
   dar: 0
 dsisr: 40000000
  current = 0xc000000003646e00
  paca    = 0xc00000000fb83600   softe: 0        irq_happened: 0x01
    pid   = 8569, comm = kworker/u16:5
Linux version 4.10.0-rc3jankarav2+ (bauermann@u1604le) (gcc version 5.4.0 20160609 (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) ) #3 SMP Wed Feb 1 13:22:47 BRST 2017
enter ? for help
6:mon>                      

It took more than a day under I/O stress test to crash, so it seems to be a
hard to hit race condition. PC is at:

$ addr2line -e /usr/lib/debug/vmlinux-4.10.0-rc3jankarav2+ c0000000003799a0
wb_get at /home/bauermann/src/linux/./include/linux/backing-dev-defs.h:218
 (inlined by) locked_inode_to_wb_and_lock_list at /home/bauermann/src/linux/fs/fs-writeback.c:281

Which is:

216 static inline void wb_get(struct bdi_writeback *wb)
217 {
218         if (wb != &wb->bdi->wb)
219                 percpu_ref_get(&wb->refcnt);
220 }

So it looks like wb->bdi is NULL.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
