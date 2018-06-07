Return-Path: <chuhu.ncepu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <015f6160-216a-31ba-e251-11336e7ff5d6@kernel.dk>
References: <CAEemH2fbPv2wphVBHxSSS+KEK5S-rercXhvgLJ7YMOZnrTpexg@mail.gmail.com>
 <20180606084105.GA10720@kmo-pixel> <015f6160-216a-31ba-e251-11336e7ff5d6@kernel.dk>
From: Chunyu Hu <chuhu.ncepu@gmail.com>
Date: Thu, 7 Jun 2018 14:33:41 +0800
Message-ID: <CABATaM7FHcXF7rO5kuMVFRFKFqhqnkoJ_t4w-y4=mNx42=b3Cg@mail.gmail.com>
Subject: Re: Block IO issue in kernel-v4.17
To: Jens Axboe <axboe@kernel.dk>
Cc: Kent Overstreet <kent.overstreet@gmail.com>, Li Wang <liwang@redhat.com>,
	Coly Li <colyli@suse.de>, hch@lst.de, darrick.wong@oracle.com, snitzer@redhat.com,
	linux-block@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

kasan reported a user-after-free. I'm using a kvm machine, it panic
during boot. I'm using the latest linux tree. which contains below.

commit d377535405686f735b90a8ad4ba269484cd7c96e
Author: Kent Overstreet <kent.overstreet@gmail.com>
Date:   Tue Jun 5 05:26:33 2018 -0400

    dm: Use kzalloc for all structs with embedded biosets/mempools


[   58.836774] ==================================================================
[   58.839974] BUG: KASAN: use-after-free in __wake_up_common+0x7c7/0x880
[   58.841988] Read of size 8 at addr ffff88025a47c3e8 by task kswapd0/66
[   58.843986]
[   58.845644]
[   58.846127] Allocated by task 956:
[   58.847249]
[   58.847731] Freed by task 956:
[   58.848856]
[   58.849336] The buggy address belongs to the object at ffff88025a47c000
[   58.849336]  which belongs to the cache names_cache of size 4096
[   58.853276] The buggy address is located 1000 bytes inside of
[   58.853276]  4096-byte region [ffff88025a47c000, ffff88025a47d000)
[   58.856924] The buggy address belongs to the page:
[   58.858411] page:ffffea0009691f00 count:1 mapcount:0
mapping:0000000000000000 index:0x0 compound_mapcount: 0
[   58.861443] flags: 0x6fffff80008100(slab|head)
[   58.862820] raw: 006fffff80008100 0000000000000000 0000000000000000
0000000100010001
[   58.865197] raw: dead000000000100 dead000000000200 ffff88012d940a00
0000000000000000
[   58.867590] page dumped because: kasan: bad access detected
[   58.869409]
[   58.869933] Memory state around the buggy address:
[   58.871116]  ffff88025a47c280: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[   58.872195]  ffff88025a47c300: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[   58.873295] >ffff88025a47c380: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[   58.874358]                                                           ^
[   58.875334]  ffff88025a47c400: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[   58.876395]  ffff88025a47c480: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[   58.877453] ==================================================================
[   58.878547] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000000
[   58.879708] PGD 0 P4D 0
[   58.880107] Oops: 0010 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN PTI
[   58.881013] CPU: 0 PID: 66 Comm: kswapd0 Tainted: G    B   W
 4.17.0.fi+ #41
[   58.881944] Hardware name: Red Hat KVM, BIOS 0.0.0 02/06/2015
[   58.882646] RIP: 0010:          (null)
[   58.883106] Code: Bad RIP value.
[   58.883520] RSP: 0018:ffff88012ec07818 EFLAGS: 00010086
[   58.884158] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   58.885020] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffff88025a47c3d0
[   58.886576] RBP: ffff880257960418 R08: ffff88025a47c3d0 R09: fffffbfff09587a4
[   58.888370] R10: fffffbfff09587a4 R11: ffffffff84ac3d23 R12: ffffffffffffffe8
[   58.890257] R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88012ec07910
[   58.892113] FS:  0000000000000000(0000) GS:ffff88012ec00000(0000)
knlGS:0000000000000000
[   58.894194] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.895648] CR2: ffffffffffffffd6 CR3: 0000000004214000 CR4: 00000000001406f0
[   58.897468] Call Trace:
[   58.898117]  <IRQ>
[   58.898716]  ? __wake_up_common+0x18e/0x880
[   58.899843]  ? wait_woken+0x340/0x340
[   58.900842]  ? do_raw_spin_lock+0xcf/0x220
[   58.901665]  ? __wake_up_common_lock+0xe3/0x170
[   58.902439]  ? __wake_up_common+0x880/0x880
[   58.903077]  ? time_hardirqs_off+0x3e/0x4f0
[   58.903742]  ? _raw_spin_unlock_irqrestore+0x45/0xa0
[   58.904486]  ? mempool_free+0x270/0x3a0
[   58.905185]  ? bio_free+0x104/0x190
[   58.905722]  ? bio_put+0xb9/0x120
[   58.906235]  ? dec_pending+0x3cd/0xbe0 [dm_mod]
[   58.906960]  ? time_hardirqs_off+0x30/0x4f0
[   58.907602]  ? debug_check_no_locks_freed+0x260/0x260
[   58.908389]  ? alloc_io+0x820/0x820 [dm_mod]
[   58.909130]  ? linear_status+0x1b0/0x1b0 [dm_mod]
[   58.909839]  ? clone_endio+0x1ed/0x890 [dm_mod]
[   58.910691]  ? bio_disassociate_task+0x16e/0x450
[   58.911453]  ? dm_get_queue_limits+0x110/0x110 [dm_mod]
[   58.912288]  ? check_preemption_disabled+0x36/0x2a0
[   58.913075]  ? dm_get_queue_limits+0x110/0x110 [dm_mod]
[   58.913919]  ? bio_endio+0x423/0x8b0
[   58.914513]  ? blk_update_request+0x295/0xe40
[   58.915215]  ? virtqueue_get_buf_ctx+0x3b0/0xa60 [virtio_ring]
[   58.916171]  ? blk_mq_end_request+0x56/0x390
[   58.916877]  ? blk_mq_complete_request+0x36a/0x6e0
[   58.917857]  ? virtblk_done+0x1bc/0x450 [virtio_blk]
[   58.918690]  ? 0xffffffffa0158000
[   58.919260]  ? __lock_is_held+0xb6/0x170
[   58.919917]  ? check_preemption_disabled+0x36/0x2a0
[   58.920730]  ? 0xffffffffa0158000
[   58.921300]  ? vring_interrupt+0x170/0x280 [virtio_ring]
[   58.922176]  ? vring_alloc_queue+0x400/0x400 [virtio_ring]
[   58.923080]  ? __handle_irq_event_percpu+0x117/0x9a0
[   58.923908]  ? handle_irq_event_percpu+0x77/0x180
[   58.924691]  ? __handle_irq_event_percpu+0x9a0/0x9a0
[   58.925519]  ? do_raw_spin_unlock+0x156/0x250
[   58.926257]  ? handle_irq_event+0xc6/0x1a0
[   58.926943]  ? handle_edge_irq+0x229/0xd40
[   58.927747]  ? handle_irq+0x2e2/0x5fd
[   58.928528]  ? check_preemption_disabled+0x36/0x2a0
[   58.929545]  ? do_IRQ+0xa7/0x240
[   58.930241]  ? common_interrupt+0xf/0xf
[   58.931072]  </IRQ>
[   58.931576]  ? lock_acquire+0x184/0x470
[   58.932395]  ? list_lru_count_one+0xb8/0x3a0
[   58.933330]  ? list_lru_count_one+0x86/0x3a0
[   58.934362]  ? super_cache_count+0x152/0x2f0
[   58.935268]  ? shrink_slab.part.24+0x1fe/0xc60
[   58.936205]  ? mem_cgroup_from_task+0x180/0x180
[   58.937162]  ? prepare_kswapd_sleep+0x160/0x160
[   58.938101]  ? mem_cgroup_iter+0x165/0xc60
[   58.938955]  ? shrink_slab+0x9e/0xd0
[   58.939707]  ? shrink_node+0x3f1/0x17b0
[   58.940675]  ? shrink_node_memcg+0x1f10/0x1f10
[   58.941794]  ? mem_cgroup_iter+0x165/0xc60
[   58.942668]  ? mem_cgroup_nr_lru_pages+0xe0/0xe0
[   58.943642]  ? inactive_list_is_low+0x1f3/0x6e0
[   58.944598]  ? balance_pgdat+0x2c9/0x950
[   58.945436]  ? mem_cgroup_shrink_node+0x7d0/0x7d0
[   58.946432]  ? preempt_count_sub+0x101/0x190
[   58.947340]  ? check_preemption_disabled+0x36/0x2a0
[   58.948373]  ? kswapd+0x5c1/0x1060
[   58.949109]  ? balance_pgdat+0x950/0x950
[   58.949948]  ? __kthread_parkme+0x84/0x240
[   58.950816]  ? __kthread_parkme+0xff/0x240
[   58.951685]  ? finish_wait+0x3f0/0x3f0
[   58.952484]  ? schedule+0x92/0x230
[   58.953202]  ? balance_pgdat+0x950/0x950
[   58.954030]  ? balance_pgdat+0x950/0x950
[   58.954861]  ? kthread+0x37d/0x500
[   58.955592]  ? kthread_create_worker_on_cpu+0xe0/0xe0
[   58.956654]  ? ret_from_fork+0x3a/0x50
[   58.957457] Modules linked in: sunrpc snd_hda_codec_generic
crct10dif_pclmul snd_hda_intel crc32_pclmul ghash_clmulni_intel
snd_hda_codec snd_hda_core snd_hwdep vfat fat iTCO_wdt
iTCO_vendor_support snd_seq snd_seq_device snd_pcm pcspkr
virtio_balloon snd_timer i2c_i801 sg lpc_ich snd soundcore shpchp
ip_tables xfs libcrc32c sr_mod cdrom virtio_net net_failover
virtio_scsi failover virtio_blk virtio_console bochs_drm
drm_kms_helper syscopyarea sysfillrect 8139too sysimgblt fb_sys_fops
ttm drm crc32c_intel ahci libahci 8139cp libata serio_raw mii i2c_core
virtio_pci virtio_ring virtio dm_mirror dm_region_hash dm_log dm_mod
[   58.968856] CR2: 0000000000000000
[   58.969583] ---[ end trace 70ad259a1fd9713f ]---
[   58.970624] RIP: 0010:          (null)
[   58.971417] Code: Bad RIP value.
[   58.972095] RSP: 0018:ffff88012ec07818 EFLAGS: 00010086
[   58.973181] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   58.974635] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffff88025a47c3d0
[   58.976060] RBP: ffff880257960418 R08: ffff88025a47c3d0 R09: fffffbfff09587a4
[   58.977495] R10: fffffbfff09587a4 R11: ffffffff84ac3d23 R12: ffffffffffffffe8
[   58.978922] R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88012ec07910
[   58.980365] FS:  0000000000000000(0000) GS:ffff88012ec00000(0000)
knlGS:0000000000000000
[   58.981984] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.983139] CR2: ffffffffffffffd6 CR3: 0000000004214000 CR4: 00000000001406f0
[   58.984568] Kernel panic - not syncing: Fatal exception in interrupt
[   60.070024] Shutting down cpus with NMI
[   60.070741] Kernel Offset: disabled
[   60.071317] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---

On 6 June 2018 at 22:18, Jens Axboe <axboe@kernel.dk> wrote:
> On 6/6/18 2:41 AM, Kent Overstreet wrote:
>> On Wed, Jun 06, 2018 at 04:37:25PM +0800, Li Wang wrote:
>>> Hi BIO experts,
>>>
>>> I catch this panic issue on some kind of arches(x86_64, ppc64,
>>> ppc64le..), it seems the root cause is very probably from BIO changes
>>> from kernel-4.17-rc7. Plz take a look.
>>
>> That's the bioset changes, the fix is out and on its way in
>
> It's already in mainline, since about lunch time yesterday.
>
>
> --
> Jens Axboe
>
