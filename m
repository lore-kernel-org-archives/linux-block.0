Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:34809 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750719AbdBORYx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2017 12:24:53 -0500
Received: by mail-wr0-f171.google.com with SMTP id z61so7851254wrc.1
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2017 09:24:52 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] blk-mq-sched: don't hold queue_lock when calling exit_icq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <73cd0cf484e8b75a771d908c172cd3a931dc00a3.1486751329.git.osandov@fb.com>
Date: Wed, 15 Feb 2017 18:24:48 +0100
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com
Message-Id: <A71AF11B-8A3A-42A5-845A-B9FBEEF74FBA@linaro.org>
References: <73cd0cf484e8b75a771d908c172cd3a931dc00a3.1486751329.git.osandov@fb.com>
To: Omar Sandoval <osandov@osandov.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 10 feb 2017, alle ore 19:32, Omar Sandoval =
<osandov@osandov.com> ha scritto:
>=20
> From: Omar Sandoval <osandov@fb.com>
>=20
> None of the other blk-mq elevator hooks are called with this lock =
held.
> Additionally, it can lead to circular locking dependencies between
> queue_lock and the private scheduler lock.
>=20

Hi Omar,
I'm sorry but it seems that a new potential deadlock has showed up.
See lockdep splat below.

I've tried to think about different solutions than turning back to
deferring the body of exit_icq, but at no avail.

Thanks,
Paolo

[  138.167021] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  138.182073] [ INFO: possible circular locking dependency detected ]
[  138.185012] 4.10.0-rc5-bfq-mq+ #42 Not tainted
[  138.219651] -------------------------------------------------------
[  138.261149] aggthr-with-gre/2170 is trying to acquire lock:
[  138.313137]  (&(&bfqd->lock)->rlock){-.-...}, at: =
[<ffffffff84484435>] bfq_exit_icq_bfqq+0x55/0x140
[  138.364973]=20
[  138.364973] but task is already holding lock:
[  138.416588]  (&(&ioc->lock)->rlock){-.....}, at: [<ffffffff84447828>] =
ioc_clear_queue+0x48/0xa0
[  138.484352]=20
[  138.484352] which lock already depends on the new lock.
[  138.484352]=20
[  138.536768]=20
[  138.536768] the existing dependency chain (in reverse order) is:
[  138.599738]=20
[  138.599738] -> #2 (&(&ioc->lock)->rlock){-.....}:
[  138.650975]       =20
[  138.650981] [<ffffffff840ee6bb>] lock_acquire+0x11b/0x220
[  138.711657]       =20
[  138.711661] [<ffffffff8494324d>] _raw_spin_lock+0x3d/0x80
[  138.763924]       =20
[  138.763930] [<ffffffff84447af2>] ioc_create_icq+0x92/0x1a0
[  138.819460]       =20
[  138.819465] [<ffffffff84454619>] blk_mq_sched_get_request+0x359/0x370
[  138.875819]       =20
[  138.875824] [<ffffffff8444e950>] blk_sq_make_request+0x130/0xa50
[  138.923681]       =20
[  138.923688] [<ffffffff844408e6>] generic_make_request+0xf6/0x2b0
[  138.991605]       =20
[  138.991611] [<ffffffff84440b13>] submit_bio+0x73/0x150
[  139.041088]       =20
[  139.041094] [<ffffffff842b2aec>] submit_bh_wbc+0x14c/0x180
[  139.083607]       =20
[  139.083613] [<ffffffff842b35ff>] block_read_full_page+0x27f/0x370
[  139.124926]       =20
[  139.124932] [<ffffffff842b68b8>] blkdev_readpage+0x18/0x20
[  139.176346]       =20
[  139.176352] [<ffffffff841da963>] do_read_cache_page+0x313/0x590
[  139.177482]       =20
[  139.177484] [<ffffffff841dabf5>] read_cache_page+0x15/0x20
[  139.178550]       =20
[  139.178552] [<ffffffff84459285>] read_dev_sector+0x75/0xd0
[  139.179650]       =20
[  139.179652] [<ffffffff84461b4b>] read_lba+0x17b/0x260
[  139.180653]       =20
[  139.180655] [<ffffffff84462412>] efi_partition+0xf2/0x7c0
[  139.181708]       =20
[  139.181709] [<ffffffff8445bb4d>] check_partition+0x13d/0x220
[  139.182792]       =20
[  139.182794] [<ffffffff84459b60>] rescan_partitions+0xc0/0x380
[  139.183911]       =20
[  139.183914] [<ffffffff842b7cce>] __blkdev_get+0x3ae/0x4f0
[  139.184971]       =20
[  139.184972] [<ffffffff842b80fc>] blkdev_get+0x14c/0x3b0
[  139.186016]       =20
[  139.186018] [<ffffffff8445823f>] device_add_disk+0x45f/0x4f0
[  139.212232]       =20
[  139.212238] [<ffffffff8469da20>] sd_probe_async+0x110/0x1c0
[  139.223160]       =20
[  139.223165] [<ffffffff840bc327>] async_run_entry_fn+0x37/0x150
[  139.224742]       =20
[  139.224747] [<ffffffff840b1087>] process_one_work+0x207/0x750
[  139.235800]       =20
[  139.235809] [<ffffffff840b161b>] worker_thread+0x4b/0x4f0
[  139.236878]       =20
[  139.236880] [<ffffffff840b863f>] kthread+0x10f/0x150
[  139.237878]       =20
[  139.237881] [<ffffffff84944271>] ret_from_fork+0x31/0x40
[  139.238938]=20
[  139.238938] -> #1 (&(&q->__queue_lock)->rlock){-.....}:
[  139.239882]       =20
[  139.239885] [<ffffffff840ee6bb>] lock_acquire+0x11b/0x220
[  139.240945]       =20
[  139.240948] [<ffffffff84943e66>] _raw_spin_lock_irqsave+0x56/0x90
[  139.242117]       =20
[  139.242120] [<ffffffff84482645>] bfq_bic_lookup.isra.112+0x25/0x60
[  139.243333]       =20
[  139.243338] [<ffffffff844827bd>] bfq_request_merge+0x3d/0xe0
[  139.244427]       =20
[  139.244430] [<ffffffff84439b8f>] elv_merge+0xcf/0xe0
[  139.245416]       =20
[  139.245419] [<ffffffff84453ff6>] blk_mq_sched_try_merge+0x36/0x150
[  139.246599]       =20
[  139.246602] [<ffffffff8447feea>] bfq_bio_merge+0x5a/0xa0
[  139.247662]       =20
[  139.247665] [<ffffffff844548b0>] __blk_mq_sched_bio_merge+0x60/0x70
[  139.248839]       =20
[  139.248841] [<ffffffff8444ea94>] blk_sq_make_request+0x274/0xa50
[  139.250007]       =20
[  139.250011] [<ffffffff844408e6>] generic_make_request+0xf6/0x2b0
[  139.251156]       =20
[  139.251159] [<ffffffff84440b13>] submit_bio+0x73/0x150
[  139.252230]       =20
[  139.252234] [<ffffffff842b2aec>] submit_bh_wbc+0x14c/0x180
[  139.253306]       =20
[  139.253310] [<ffffffff842b35ff>] block_read_full_page+0x27f/0x370
[  139.254465]       =20
[  139.254467] [<ffffffff842b68b8>] blkdev_readpage+0x18/0x20
[  139.279873]       =20
[  139.279880] [<ffffffff841da963>] do_read_cache_page+0x313/0x590
[  139.281035]       =20
[  139.281036] [<ffffffff841dabf5>] read_cache_page+0x15/0x20
[  139.282111]       =20
[  139.282113] [<ffffffff84459285>] read_dev_sector+0x75/0xd0
[  139.283199]       =20
[  139.283201] [<ffffffff84461b4b>] read_lba+0x17b/0x260
[  139.284226]       =20
[  139.284228] [<ffffffff84462412>] efi_partition+0xf2/0x7c0
[  139.285336]       =20
[  139.285339] [<ffffffff8445bb4d>] check_partition+0x13d/0x220
[  139.286437]       =20
[  139.286439] [<ffffffff84459b60>] rescan_partitions+0xc0/0x380
[  139.287566]       =20
[  139.287568] [<ffffffff842b7cce>] __blkdev_get+0x3ae/0x4f0
[  139.288633]       =20
[  139.288635] [<ffffffff842b80fc>] blkdev_get+0x14c/0x3b0
[  139.289671]       =20
[  139.289672] [<ffffffff8445823f>] device_add_disk+0x45f/0x4f0
[  139.291916]       =20
[  139.291919] [<ffffffff8469da20>] sd_probe_async+0x110/0x1c0
[  139.293003]       =20
[  139.293005] [<ffffffff840bc327>] async_run_entry_fn+0x37/0x150
[  139.294126]       =20
[  139.294128] [<ffffffff840b1087>] process_one_work+0x207/0x750
[  139.295245]       =20
[  139.295247] [<ffffffff840b161b>] worker_thread+0x4b/0x4f0
[  139.296317]       =20
[  139.296319] [<ffffffff840b863f>] kthread+0x10f/0x150
[  139.301536]       =20
[  139.301539] [<ffffffff84944271>] ret_from_fork+0x31/0x40
[  139.316757]=20
[  139.316757] -> #0 (&(&bfqd->lock)->rlock){-.-...}:
[  139.317633]       =20
[  139.317638] [<ffffffff840edd24>] __lock_acquire+0x15e4/0x1890
[  139.318738]       =20
[  139.318747] [<ffffffff840ee6bb>] lock_acquire+0x11b/0x220
[  139.319814]       =20
[  139.319817] [<ffffffff849434da>] _raw_spin_lock_irq+0x4a/0x80
[  139.320917]       =20
[  139.320919] [<ffffffff84484435>] bfq_exit_icq_bfqq+0x55/0x140
[  139.332516]       =20
[  139.332522] [<ffffffff8448453c>] bfq_exit_icq+0x1c/0x30
[  139.333551]       =20
[  139.333554] [<ffffffff844471f8>] ioc_exit_icq+0x38/0x50
[  139.334580]       =20
[  139.334582] [<ffffffff844472c9>] ioc_destroy_icq+0x99/0x140
[  139.335701]       =20
[  139.335703] [<ffffffff84447832>] ioc_clear_queue+0x52/0xa0
[  139.336758]       =20
[  139.336760] [<ffffffff8443922c>] elevator_switch+0x7c/0x240
[  139.337828]       =20
[  139.337830] [<ffffffff844394f8>] __elevator_change+0x108/0x140
[  139.338992]       =20
[  139.338996] [<ffffffff8443a4d6>] elv_iosched_store+0x26/0x60
[  139.340111]       =20
[  139.340114] [<ffffffff844447a9>] queue_attr_store+0x59/0x90
[  139.341195]       =20
[  139.341198] [<ffffffff84308585>] sysfs_kf_write+0x45/0x60
[  139.342250]       =20
[  139.342252] [<ffffffff84307815>] kernfs_fop_write+0x135/0x1c0
[  139.343354]       =20
[  139.343358] [<ffffffff8426d5a7>] __vfs_write+0x37/0x160
[  139.351596]       =20
[  139.351602] [<ffffffff8426efee>] vfs_write+0xce/0x1f0
[  139.352608]       =20
[  139.352610] [<ffffffff84270518>] SyS_write+0x58/0xc0
[  139.353615]       =20
[  139.353618] [<ffffffff84943fc5>] entry_SYSCALL_64_fastpath+0x23/0xc6
[  139.354799]=20
[  139.354799] other info that might help us debug this:
[  139.354799]=20
[  139.355925] Chain exists of:
[  139.355925]   &(&bfqd->lock)->rlock --> &(&q->__queue_lock)->rlock =
--> &(&ioc->lock)->rlock
[  139.355925]=20
[  139.357666]  Possible unsafe locking scenario:
[  139.357666]=20
[  139.368477]        CPU0                    CPU1
[  139.369129]        ----                    ----
[  139.369774]   lock(&(&ioc->lock)->rlock);
[  139.370339]                                =
lock(&(&q->__queue_lock)->rlock);
[  139.390579]                                =
lock(&(&ioc->lock)->rlock);
[  139.391522]   lock(&(&bfqd->lock)->rlock);
[  139.392094]=20
[  139.392094]  *** DEADLOCK ***
[  139.392094]=20
[  139.392912] 6 locks held by aggthr-with-gre/2170:
[  139.393562]  #0:  (sb_writers#6){.+.+.+}, at: [<ffffffff8426f0cf>] =
vfs_write+0x1af/0x1f0
[  139.396183]  #1:  (&of->mutex){+.+.+.}, at: [<ffffffff843077e1>] =
kernfs_fop_write+0x101/0x1c0
[  139.397363]  #2:  (s_active#198){.+.+.+}, at: [<ffffffff843077e9>] =
kernfs_fop_write+0x109/0x1c0
[  139.437158]  #3:  (&q->sysfs_lock){+.+.+.}, at: [<ffffffff84444792>] =
queue_attr_store+0x42/0x90
[  139.438368]  #4:  (&(&q->__queue_lock)->rlock){-.....}, at: =
[<ffffffff84439224>] elevator_switch+0x74/0x240
[  139.439741]  #5:  (&(&ioc->lock)->rlock){-.....}, at: =
[<ffffffff84447828>] ioc_clear_queue+0x48/0xa0
[  139.441008]=20
[  139.441008] stack backtrace:
[  139.441624] CPU: 0 PID: 2170 Comm: aggthr-with-gre Not tainted =
4.10.0-rc5-bfq-mq+ #42
[  139.442704] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS =
VirtualBox 12/01/2006
[  139.443918] Call Trace:
[  139.444270]  dump_stack+0x85/0xc2
[  139.444734]  print_circular_bug+0x1e3/0x250
[  139.445336]  __lock_acquire+0x15e4/0x1890
[  139.445895]  lock_acquire+0x11b/0x220
[  139.446406]  ? bfq_exit_icq_bfqq+0x55/0x140
[  139.446989]  _raw_spin_lock_irq+0x4a/0x80
[  139.451750]  ? bfq_exit_icq_bfqq+0x55/0x140
[  139.452336]  bfq_exit_icq_bfqq+0x55/0x140
[  139.452898]  bfq_exit_icq+0x1c/0x30
[  139.453386]  ioc_exit_icq+0x38/0x50
[  139.453874]  ioc_destroy_icq+0x99/0x140
[  139.454408]  ioc_clear_queue+0x52/0xa0
[  139.454930]  elevator_switch+0x7c/0x240
[  139.455489]  ? kernfs_fop_write+0x101/0x1c0
[  139.456089]  __elevator_change+0x108/0x140
[  139.456657]  elv_iosched_store+0x26/0x60
[  139.457200]  queue_attr_store+0x59/0x90
[  139.489285]  sysfs_kf_write+0x45/0x60
[  139.505169]  kernfs_fop_write+0x135/0x1c0
[  139.543726]  __vfs_write+0x37/0x160
[  139.563645]  ? rcu_read_lock_sched_held+0x72/0x80
[  139.611773]  ? rcu_sync_lockdep_assert+0x2f/0x60
[  139.651981]  ? __sb_start_write+0xde/0x1e0
[  139.683576]  ? vfs_write+0x1af/0x1f0
[  139.703898]  vfs_write+0xce/0x1f0
[  139.735970]  SyS_write+0x58/0xc0
[  139.747901]  entry_SYSCALL_64_fastpath+0x23/0xc6
[  139.748543] RIP: 0033:0x7f862b9796e0
[  139.749039] RSP: 002b:00007ffdacc878b8 EFLAGS: 00000246 ORIG_RAX: =
0000000000000001
[  139.750075] RAX: ffffffffffffffda RBX: 00007f862bc47620 RCX: =
00007f862b9796e0
[  139.761064] RDX: 0000000000000005 RSI: 0000000001560008 RDI: =
0000000000000001
[  139.811601] RBP: 0000000000000004 R08: 00007f862bc48780 R09: =
00007f862c27f700
[  139.867906] R10: 0000000000000004 R11: 0000000000000246 R12: =
0000000000000004
[  139.881848] R13: 0000000001587b28 R14: 0000000000000000 R15: =
00000000004d09d9
> Reported-by: Paolo Valente <paolo.valente@linaro.org>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> block/blk-ioc.c | 22 ++++++++++++++++------
> 1 file changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index fe186a9eade9..b12f9c87b4c3 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -35,7 +35,10 @@ static void icq_free_icq_rcu(struct rcu_head *head)
> 	kmem_cache_free(icq->__rcu_icq_cache, icq);
> }
>=20
> -/* Exit an icq. Called with both ioc and q locked. */
> +/*
> + * Exit an icq. Called with both ioc and q locked for sq, only ioc =
locked for
> + * mq.
> + */
> static void ioc_exit_icq(struct io_cq *icq)
> {
> 	struct elevator_type *et =3D icq->q->elevator->type;
> @@ -166,6 +169,7 @@ EXPORT_SYMBOL(put_io_context);
>  */
> void put_io_context_active(struct io_context *ioc)
> {
> +	struct elevator_type *et;
> 	unsigned long flags;
> 	struct io_cq *icq;
>=20
> @@ -184,13 +188,19 @@ void put_io_context_active(struct io_context =
*ioc)
> 	hlist_for_each_entry(icq, &ioc->icq_list, ioc_node) {
> 		if (icq->flags & ICQ_EXITED)
> 			continue;
> -		if (spin_trylock(icq->q->queue_lock)) {
> +
> +		et =3D icq->q->elevator->type;
> +		if (et->uses_mq) {
> 			ioc_exit_icq(icq);
> -			spin_unlock(icq->q->queue_lock);
> 		} else {
> -			spin_unlock_irqrestore(&ioc->lock, flags);
> -			cpu_relax();
> -			goto retry;
> +			if (spin_trylock(icq->q->queue_lock)) {
> +				ioc_exit_icq(icq);
> +				spin_unlock(icq->q->queue_lock);
> +			} else {
> +				spin_unlock_irqrestore(&ioc->lock, =
flags);
> +				cpu_relax();
> +				goto retry;
> +			}
> 		}
> 	}
> 	spin_unlock_irqrestore(&ioc->lock, flags);
> --=20
> 2.11.1
>=20
