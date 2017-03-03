Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Fri, 3 Mar 2017 17:18:27 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
 Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
Subject: WARN_ON() when booting with nvme loopback over zram
Message-ID: <20170303161826.GA26324@linux-x5ow.site>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Hi,

I get the following WARN_ON when trying to establish a nvmf loopback device
backed by zram.

My topmost commit is c82be9d2244aacea9851c86f4fb74694c99cd874


+ nvmet_cfs=3D/sys/kernel/config/nvmet/
+ nvmet_subsystem=3Dnvmf-test
+ mkdir -p /sys/kernel/config/nvmet//subsystems/nvmf-test
+ echo 1
+ mkdir /sys/kernel/config/nvmet//subsystems/nvmf-test/namespaces/1
[    6.163905] nvmet: adding nsid 1 to subsystem nvmf-test
+ echo -n /dev/zram1
+ echo -n 1
+ mkdir /sys/kernel/config/nvmet//ports/1
+ echo loop
+ ln -s /sys/kernel/config/nvmet//subsystems/nvmf-test /sys/kernel/config/n=
vmet//ports/1/subsystems/nvmf-test
+ echo transport=3Dloop,nqn=3Dnvmf-test
[    6.175710] ------------[ cut here ]------------
[    6.176181] WARNING: CPU: 1 PID: 207 at block/blk-mq-tag.c:114 blk_mq_ge=
t_tag+0x4ec/0x580
[    6.176922] Modules linked in: nvme_loop nvmet nvme_fabrics nvme_core
[    6.177523] CPU: 1 PID: 207 Comm: sh Not tainted 4.10.0+ #413
[    6.178048] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.9.1-0-gb3ef39f-prebuilt.qemu-project.org 04/01/2014
[    6.179089] Call Trace:
[    6.179331]  dump_stack+0x4d/0x68
[    6.179656]  __warn+0x107/0x130
[    6.179950]  warn_slowpath_null+0x18/0x20
[    6.180326]  blk_mq_get_tag+0x4ec/0x580
[    6.180679]  ? __blk_mq_tag_idle+0x40/0x40
[    6.181069]  ? save_stack_trace+0x16/0x20
[    6.181442]  ? wake_atomic_t_function+0x90/0x90
[    6.181512]  ? __vfs_write+0xd1/0x330
[    6.181512]  ? vfs_write+0x10e/0x270
[    6.181512]  ? SyS_write+0xa5/0x130
[    6.181512]  ? entry_SYSCALL_64_fastpath+0x13/0x94
[    6.181512]  ? blk_queue_enter+0x1ac/0x280
[    6.181512]  __blk_mq_alloc_request+0x1c/0x1b0
[    6.181512]  blk_mq_sched_get_request+0x333/0x420
[    6.181512]  ? __list_add_valid+0x2e/0xd0
[    6.181512]  blk_mq_alloc_request+0xb9/0x120
[    6.181512]  ? __blk_mq_alloc_request+0x1b0/0x1b0
[    6.181512]  ? kmemleak_disable+0x70/0x70
[    6.181512]  nvme_alloc_request+0x98/0xb0 [nvme_core]
[    6.181512]  __nvme_submit_sync_cmd+0x2c/0x110 [nvme_core]
[    6.181512]  nvmf_connect_admin_queue+0x216/0x2b0 [nvme_fabrics]
[    6.181512]  ? nvmf_log_connect_error.isra.0+0x130/0x130 [nvme_fabrics]
[    6.181512]  ? blk_mq_sched_init+0x2e/0x40
[    6.181512]  ? blk_mq_init_allocated_queue+0x791/0x7c0
[    6.181512]  nvme_loop_configure_admin_queue+0x168/0x270 [nvme_loop]
[    6.181512]  nvme_loop_create_ctrl+0x23e/0x8f8 [nvme_loop]
[    6.181512]  ? __delete_object+0x59/0xa0
[    6.181512]  ? delete_object_full+0x18/0x20
[    6.181512]  nvmf_dev_write+0xbb1/0xd77 [nvme_fabrics]
[    6.181512]  ? nvmf_check_required_opts.isra.2+0xa0/0xa0 [nvme_fabrics]
[    6.181512]  ? kasan_slab_free+0x12f/0x180
[    6.181512]  ? save_stack_trace+0x16/0x20
[    6.181512]  ? kasan_slab_free+0xae/0x180
[    6.181512]  ? kmem_cache_free+0x84/0x150
[    6.181512]  ? putname+0x7b/0x80
[    6.181512]  ? do_sys_open+0x23f/0x290
[    6.181512]  ? SyS_open+0x19/0x20
[    6.181512]  ? entry_SYSCALL_64_fastpath+0x13/0x94
[    6.181512]  ? __save_stack_trace+0x7e/0xd0
[    6.181512]  __vfs_write+0xd1/0x330
[    6.181512]  ? restore_nameidata+0x7a/0xa0
[    6.181512]  ? __vfs_read+0x320/0x320
[    6.181512]  ? ptep_set_access_flags+0x2b/0x50
[    6.181512]  ? __handle_mm_fault+0xc9d/0x14e0
[    6.181512]  ? vm_insert_page+0x320/0x320
[    6.181512]  ? locks_remove_posix+0x38/0x70
[    6.181512]  vfs_write+0x10e/0x270
[    6.181512]  SyS_write+0xa5/0x130
[    6.181512]  ? SyS_read+0x130/0x130
[    6.181512]  entry_SYSCALL_64_fastpath+0x13/0x94
[    6.181512] RIP: 0033:0x7fd6d0de8560
[    6.181512] RSP: 002b:00007ffd284d2278 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[    6.181512] RAX: ffffffffffffffda RBX: 000000000000001c RCX: 00007fd6d0d=
e8560
[    6.181512] RDX: 000000000000001d RSI: 00007fd6d194a000 RDI: 00000000000=
00001
[    6.181512] RBP: 00007fd6d10a9280 R08: 000000000000000a R09: 00007fd6d19=
4c700
[    6.181512] R10: 0000000001094b50 R11: 0000000000000246 R12: 00000000010=
94b50
[    6.181512] R13: 000000000000001c R14: 0000000000000000 R15: 00007ffd284=
d2228
[    6.203886] ---[ end trace 96b98033c328af9c ]---
[    6.204314] nvme nvme0: Connect command failed, error wo/DNR bit: -16395
sh: echo: write error: Resource temporarily unavailable
+ _fatal
+ echo 1
+ e[    6.226208] sysrq: SysRq : Power Off
cho o
+ sleep 2
[    7.880759] ACPI: Preparing to enter system sleep state S5
[    7.881327] reboot: Power down

Is this known or shall I re-test with Jens' latest tree?

Nice weekend,
	Joahnnes

-- =

Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
