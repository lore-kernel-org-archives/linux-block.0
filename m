Return-Path: <khlebnikov@yandex-team.ru>
Subject: Re: 4.10 lockdep: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
To: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <f84551e2-a837-8c39-bbae-e22fc1429a75@yandex-team.ru>
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <2ba533d7-8cc3-19cb-268f-571426c945ec@yandex-team.ru>
Date: Wed, 8 Feb 2017 16:10:18 +0300
MIME-Version: 1.0
In-Reply-To: <f84551e2-a837-8c39-bbae-e22fc1429a75@yandex-team.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Looks like this caused by del_timer_sync() in wbt_disable_default() under irq-safe lock.

Here

void wbt_disable_default(struct request_queue *q)
{
	struct rq_wb *rwb = q->rq_wb;

	if (rwb && rwb->enable_state == WBT_STATE_ON_DEFAULT) {
		del_timer_sync(&rwb->window_timer);
		rwb->win_nsec = rwb->min_lat_nsec = 0;
		wbt_update_limits(rwb);
	}
}
EXPORT_SYMBOL_GPL(wbt_disable_default);


On 08.02.2017 12:51, Konstantin Khlebnikov wrote:
> [   41.715309] ======================================================
> [   41.715410] [ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]
> [   41.715513] 4.10.0-rc7+ #2 Not tainted
> [   41.715607] ------------------------------------------------------
> [   41.715708] Starter.procman/1467 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> [   41.715833]  (((&rwb->window_timer))){+.-...}, at: [<ffffffff812fe7c5>] del_timer_sync+0x5/0x100
> [   41.715974]
>                and this task is already holding:
> [   41.716094]  (&(&q->__queue_lock)->rlock){-.-...}, at: [<ffffffff81c192ff>] cfq_set_request+0x18f/0xd50
> [   41.716230] which would create a new lock dependency:
> [   41.716327]  (&(&q->__queue_lock)->rlock){-.-...} -> (((&rwb->window_timer))){+.-...}
> [   41.716457]
>                but this new dependency connects a HARDIRQ-irq-safe lock:
> [   41.716582]  (&(&q->__queue_lock)->rlock){-.-...}
> [   41.716585]
>                ... which became HARDIRQ-irq-safe at:
> [   41.716801]
> [   41.716807] [<ffffffff812a457a>] __lock_acquire+0x14ba/0x3a20
> [   41.716994]
> [   41.716997] [<ffffffff812a7663>] lock_acquire+0x173/0x330
> [   41.717182]
> [   41.717186] [<ffffffff82b0a700>] _raw_spin_lock_irqsave+0x50/0x70
> [   41.717374]
> [   41.717376] [<ffffffff81c17ce4>] cfq_idle_slice_timer+0xa4/0x3b0
> [   41.717563]
> [   41.717567] [<ffffffff81307704>] __hrtimer_run_queues+0x294/0xb50
> [   41.717754]
> [   41.717756] [<ffffffff81309827>] hrtimer_interrupt+0x187/0x5e0
> [   41.717943]
> [   41.717948] [<ffffffff810f50d4>] local_apic_timer_interrupt+0x74/0xe0
> [   41.718136]
> [   41.718140] [<ffffffff82b0d576>] smp_apic_timer_interrupt+0x76/0xa0
> [   41.718327]
> [   41.718330] [<ffffffff82b0c633>] apic_timer_interrupt+0x93/0xa0
> [   41.718516]
> [   41.718520] [<ffffffff825b781b>] cpuidle_enter_state+0x11b/0x820
> [   41.718707]
> [   41.718709] [<ffffffff825b7fb7>] cpuidle_enter+0x17/0x20
> [   41.718894]
> [   41.718897] [<ffffffff81288147>] call_cpuidle+0x47/0xc0
> [   41.719082]
> [   41.719084] [<ffffffff8128854e>] do_idle+0x21e/0x2e0
> [   41.719269]
> [   41.719272] [<ffffffff81288b1d>] cpu_startup_entry+0x1d/0x20
> [   41.719458]
> [   41.719461] [<ffffffff810f110d>] start_secondary+0x29d/0x370
> [   41.719647]
> [   41.719651] [<ffffffff810001c4>] verify_cpu+0x0/0xfc
> [   41.719835]
>                to a HARDIRQ-irq-unsafe lock:
> [   41.719954]  (((&rwb->window_timer))){+.-...}
> [   41.719957]
>                ... which became HARDIRQ-irq-unsafe at:
> [   41.720172] ...
> [   41.720172]
> [   41.720263] [<ffffffff812a4289>] __lock_acquire+0x11c9/0x3a20
> [   41.720450]
> [   41.720452] [<ffffffff812a7663>] lock_acquire+0x173/0x330
> [   41.720638]
> [   41.720641] [<ffffffff812fe9e8>] call_timer_fn+0x118/0x520
> [   41.720827]
> [   41.720829] [<ffffffff812ff6d7>] run_timer_softirq+0x537/0x1450
> [   41.721017]
> [   41.721020] [<ffffffff82b0dc2e>] __do_softirq+0x21e/0x8a9
> [   41.721205]
> [   41.721209] [<ffffffff811b5093>] irq_exit+0x1a3/0x1d0
> [   41.721394]
> [   41.721397] [<ffffffff82b0d57b>] smp_apic_timer_interrupt+0x7b/0xa0
> [   41.721584]
> [   41.721586] [<ffffffff82b0c633>] apic_timer_interrupt+0x93/0xa0
> [   41.721772]
> [   41.721774] [<ffffffff825b781b>] cpuidle_enter_state+0x11b/0x820
> [   41.721961]
> [   41.721963] [<ffffffff825b7fb7>] cpuidle_enter+0x17/0x20
> [   41.722148]
> [   41.722151] [<ffffffff81288147>] call_cpuidle+0x47/0xc0
> [   41.722336]
> [   41.722338] [<ffffffff8128854e>] do_idle+0x21e/0x2e0
> [   41.722522]
> [   41.722524] [<ffffffff81288b1d>] cpu_startup_entry+0x1d/0x20
> [   41.722709]
> [   41.722712] [<ffffffff810f110d>] start_secondary+0x29d/0x370
> [   41.722897]
> [   41.722899] [<ffffffff810001c4>] verify_cpu+0x0/0xfc
> [   41.723083]
>                other info that might help us debug this:
>
> [   41.723320]  Possible interrupt unsafe locking scenario:
>
> [   41.723443]        CPU0                    CPU1
> [   41.723538]        ----                    ----
> [   41.723634]   lock(((&rwb->window_timer)));
> [   41.723730]                                local_irq_disable();
> [   41.723829]                                lock(&(&q->__queue_lock)->rlock);
> [   41.723931]                                lock(((&rwb->window_timer)));
> [   41.724033]   <Interrupt>
> [   41.724124]     lock(&(&q->__queue_lock)->rlock);
> [   41.724221]
>                 *** DEADLOCK ***
>
> [   41.730049] 3 locks held by Starter.procman/1467:
> [   41.730144]  #0:  (&sig->cred_guard_mutex){+.+.+.}, at: [<ffffffff816b2c53>] prepare_bprm_creds+0x53/0x100
> [   41.730280]  #1:  (&type->i_mutex_dir_key#2){++++++}, at: [<ffffffff816cdb67>] path_openat+0x1317/0x2730
> [   41.730415]  #2:  (&(&q->__queue_lock)->rlock){-.-...}, at: [<ffffffff81c192ff>] cfq_set_request+0x18f/0xd50
> [   41.730550]
>                the dependencies between HARDIRQ-irq-safe lock and the holding lock:
> [   41.730701] -> (&(&q->__queue_lock)->rlock){-.-...} ops: 68816 {
> [   41.730804]    IN-HARDIRQ-W at:
> [   41.730897]
> [   41.730900] [<ffffffff812a457a>] __lock_acquire+0x14ba/0x3a20
> [   41.731091]
> [   41.731093] [<ffffffff812a7663>] lock_acquire+0x173/0x330
> [   41.731283]
> [   41.731285] [<ffffffff82b0a700>] _raw_spin_lock_irqsave+0x50/0x70
> [   41.731476]
> [   41.731478] [<ffffffff81c17ce4>] cfq_idle_slice_timer+0xa4/0x3b0
> [   41.731669]
> [   41.731672] [<ffffffff81307704>] __hrtimer_run_queues+0x294/0xb50
> [   41.731862]
> [   41.731865] [<ffffffff81309827>] hrtimer_interrupt+0x187/0x5e0
> [   41.732056]
> [   41.732058] [<ffffffff810f50d4>] local_apic_timer_interrupt+0x74/0xe0
> [   41.732250]
> [   41.732253] [<ffffffff82b0d576>] smp_apic_timer_interrupt+0x76/0xa0
> [   41.732444]
> [   41.732447] [<ffffffff82b0c633>] apic_timer_interrupt+0x93/0xa0
> [   41.732637]
> [   41.732639] [<ffffffff825b781b>] cpuidle_enter_state+0x11b/0x820
> [   41.732830]
> [   41.732832] [<ffffffff825b7fb7>] cpuidle_enter+0x17/0x20
> [   41.733021]
> [   41.733023] [<ffffffff81288147>] call_cpuidle+0x47/0xc0
> [   41.733212]
> [   41.733214] [<ffffffff8128854e>] do_idle+0x21e/0x2e0
> [   41.733401]
> [   41.733404] [<ffffffff81288b1d>] cpu_startup_entry+0x1d/0x20
> [   41.733593]
> [   41.733596] [<ffffffff810f110d>] start_secondary+0x29d/0x370
> [   41.733785]
> [   41.733787] [<ffffffff810001c4>] verify_cpu+0x0/0xfc
> [   41.733975]    IN-SOFTIRQ-W at:
> [   41.734068]
> [   41.734071] [<ffffffff812a4258>] __lock_acquire+0x1198/0x3a20
> [   41.734261]
> [   41.734264] [<ffffffff812a7663>] lock_acquire+0x173/0x330
> [   41.734453]
> [   41.734455] [<ffffffff82b0a700>] _raw_spin_lock_irqsave+0x50/0x70
> [   41.734646]
> [   41.734650] [<ffffffff8221f4a2>] scsi_end_request+0x272/0x5a0
> [   41.734841]
> [   41.734844] [<ffffffff8222acb5>] scsi_io_completion+0x465/0x1800
> [   41.735034]
> [   41.735037] [<ffffffff8220b353>] scsi_finish_command+0x393/0x560
> [   41.735227]
> [   41.735230] [<ffffffff82228f35>] scsi_softirq_done+0x2a5/0x350
> [   41.735420]
> [   41.735423] [<ffffffff81ba3ff8>] blk_done_softirq+0x208/0x360
> [   41.735614]
> [   41.735616] [<ffffffff82b0dc2e>] __do_softirq+0x21e/0x8a9
> [   41.735805]
> [   41.735807] [<ffffffff811b4d36>] run_ksoftirqd+0x26/0xf0
> [   41.735996]
> [   41.735999] [<ffffffff81210c14>] smpboot_thread_fn+0x3d4/0x7f0
> [   41.736190]
> [   41.736193] [<ffffffff81205d4e>] kthread+0x2ce/0x3d0
> [   41.736381]
> [   41.736383] [<ffffffff82b0aae1>] ret_from_fork+0x31/0x40
> [   41.736572]    INITIAL USE at:
> [   41.736665]
> [   41.736668] [<ffffffff812a3b74>] __lock_acquire+0xab4/0x3a20
> [   41.736857]
> [   41.736860] [<ffffffff812a7663>] lock_acquire+0x173/0x330
> [   41.737049]
> [   41.737051] [<ffffffff82b09e94>] _raw_spin_lock_irq+0x44/0x60
> [   41.737240]
> [   41.737245] [<ffffffff81bfb294>] blkcg_init_queue+0xb4/0x2e0
> [   41.737526]
> [   41.737529] [<ffffffff81b7630a>] blk_alloc_queue_node+0x5ea/0x7e0
> [   41.737720]
> [   41.737722] [<ffffffff81b76513>] blk_alloc_queue+0x13/0x20
> [   41.737911]
> [   41.737914] [<ffffffff82161919>] brd_alloc+0xf9/0x590
> [   41.738103]
> [   41.738107] [<ffffffff83a40642>] brd_init+0x62/0x2ad
> [   41.738294]
> [   41.738297] [<ffffffff81002261>] do_one_initcall+0x91/0x230
> [   41.738486]
> [   41.738491] [<ffffffff8399eb3d>] kernel_init_freeable+0x44f/0x4e1
> [   41.738682]
> [   41.738685] [<ffffffff82af0ba3>] kernel_init+0x13/0x120
> [   41.738873]
> [   41.738875] [<ffffffff82b0aae1>] ret_from_fork+0x31/0x40
> [   41.739065]  }
> [   41.739157]  ... key      at: [<ffffffff849414c0>] __key.51360+0x0/0x40
> [   41.739258]  ... acquired at:
> [   41.739349]
> [   41.739352] [<ffffffff812a0a3a>] check_irq_usage+0x7a/0x180
> [   41.739538]
> [   41.739540] [<ffffffff812a559b>] __lock_acquire+0x24db/0x3a20
> [   41.739727]
> [   41.739730] [<ffffffff812a7663>] lock_acquire+0x173/0x330
> [   41.739915]
> [   41.739918] [<ffffffff812fe80e>] del_timer_sync+0x4e/0x100
> [   41.740103]
> [   41.740107] [<ffffffff81c33ee6>] wbt_disable_default+0x76/0x210
> [   41.740294]
> [   41.740296] [<ffffffff81c183c7>] check_blkcg_changed+0x3d7/0xee0
> [   41.740483]
> [   41.740485] [<ffffffff81c193f8>] cfq_set_request+0x288/0xd50
> [   41.740670]
> [   41.740674] [<ffffffff81b6b583>] elv_set_request+0x83/0xf0
> [   41.740860]
> [   41.740862] [<ffffffff81b8032d>] get_request+0x16ad/0x1dc0
> [   41.741048]
> [   41.741050] [<ffffffff81b890c5>] blk_queue_bio+0x335/0xe20
> [   41.741235]
> [   41.741238] [<ffffffff81b81ca0>] generic_make_request+0x2e0/0x730
> [   41.741425]
> [   41.741427] [<ffffffff81b82228>] submit_bio+0x138/0x4c0
> [   41.741612]
> [   41.741615] [<ffffffff817528c0>] submit_bh_wbc+0x400/0x5c0
> [   41.741801]
> [   41.741803] [<ffffffff81754566>] ll_rw_block+0xc6/0x160
> [   41.741989]
> [   41.741992] [<ffffffff81890650>] ext4_find_entry+0xc60/0x1230
> [   41.742179]
> [   41.742181] [<ffffffff81891ed2>] ext4_lookup+0x112/0x770
> [   41.742366]
> [   41.742368] [<ffffffff816c3ee1>] lookup_open+0xd41/0x1520
> [   41.742553]
> [   41.742555] [<ffffffff816cdb8a>] path_openat+0x133a/0x2730
> [   41.742741]
> [   41.742743] [<ffffffff816d25b5>] do_filp_open+0x175/0x230
> [   41.742928]
> [   41.742931] [<ffffffff816ad999>] do_open_execat+0xb9/0x480
> [   41.743116]
> [   41.743119] [<ffffffff816b3351>] do_execveat_common.isra.39+0x651/0x1ec0
> [   41.743308]
> [   41.743310] [<ffffffff816b546a>] SyS_execve+0x3a/0x50
> [   41.743495]
> [   41.743498] [<ffffffff8100768d>] do_syscall_64+0x18d/0x450
> [   41.743683]
> [   41.743686] [<ffffffff82b0a90d>] return_from_SYSCALL_64+0x0/0x7a
>
> [   41.743961]
>                the dependencies between the lock to be acquired
> [   41.743962]  and HARDIRQ-irq-unsafe lock:
> [   41.744181] -> (((&rwb->window_timer))){+.-...} ops: 362 {
> [   41.744282]    HARDIRQ-ON-W at:
> [   41.744375]
> [   41.744378] [<ffffffff812a4289>] __lock_acquire+0x11c9/0x3a20
> [   41.744568]
> [   41.744570] [<ffffffff812a7663>] lock_acquire+0x173/0x330
> [   41.744760]
> [   41.744762] [<ffffffff812fe9e8>] call_timer_fn+0x118/0x520
> [   41.744951]
> [   41.744954] [<ffffffff812ff6d7>] run_timer_softirq+0x537/0x1450
> [   41.745144]
> [   41.745147] [<ffffffff82b0dc2e>] __do_softirq+0x21e/0x8a9
> [   41.745336]
> [   41.745338] [<ffffffff811b5093>] irq_exit+0x1a3/0x1d0
> [   41.745527]
> [   41.745529] [<ffffffff82b0d57b>] smp_apic_timer_interrupt+0x7b/0xa0
> [   41.745720]
> [   41.745723] [<ffffffff82b0c633>] apic_timer_interrupt+0x93/0xa0
> [   41.745913]
> [   41.745915] [<ffffffff825b781b>] cpuidle_enter_state+0x11b/0x820
> [   41.746106]
> [   41.746108] [<ffffffff825b7fb7>] cpuidle_enter+0x17/0x20
> [   41.746297]
> [   41.746299] [<ffffffff81288147>] call_cpuidle+0x47/0xc0
> [   41.746488]
> [   41.746490] [<ffffffff8128854e>] do_idle+0x21e/0x2e0
> [   41.746678]
> [   41.746680] [<ffffffff81288b1d>] cpu_startup_entry+0x1d/0x20
> [   41.746870]
> [   41.746872] [<ffffffff810f110d>] start_secondary+0x29d/0x370
> [   41.752819]
> [   41.752821] [<ffffffff810001c4>] verify_cpu+0x0/0xfc
> [   41.753009]    IN-SOFTIRQ-W at:
> [   41.753102]
> [   41.753105] [<ffffffff812a4258>] __lock_acquire+0x1198/0x3a20
> [   41.753295]
> [   41.753297] [<ffffffff812a7663>] lock_acquire+0x173/0x330
> [   41.753487]
> [   41.753489] [<ffffffff812fe9e8>] call_timer_fn+0x118/0x520
> [   41.753679]
> [   41.753681] [<ffffffff812ff6d7>] run_timer_softirq+0x537/0x1450
> [   41.753872]
> [   41.753874] [<ffffffff82b0dc2e>] __do_softirq+0x21e/0x8a9
> [   41.754063]
> [   41.754065] [<ffffffff811b5093>] irq_exit+0x1a3/0x1d0
> [   41.754254]
> [   41.754256] [<ffffffff82b0d57b>] smp_apic_timer_interrupt+0x7b/0xa0
> [   41.754447]
> [   41.754450] [<ffffffff82b0c633>] apic_timer_interrupt+0x93/0xa0
> [   41.754640]
> [   41.754642] [<ffffffff825b781b>] cpuidle_enter_state+0x11b/0x820
> [   41.754833]
> [   41.754835] [<ffffffff825b7fb7>] cpuidle_enter+0x17/0x20
> [   41.755024]
> [   41.755026] [<ffffffff81288147>] call_cpuidle+0x47/0xc0
> [   41.755214]
> [   41.755216] [<ffffffff8128854e>] do_idle+0x21e/0x2e0
> [   41.755404]
> [   41.755406] [<ffffffff81288b1d>] cpu_startup_entry+0x1d/0x20
> [   41.755596]
> [   41.755598] [<ffffffff810f110d>] start_secondary+0x29d/0x370
> [   41.755788]
> [   41.755790] [<ffffffff810001c4>] verify_cpu+0x0/0xfc
> [   41.755978]    INITIAL USE at:
> [   41.756070]
> [   41.756073] [<ffffffff812a3b74>] __lock_acquire+0xab4/0x3a20
> [   41.756262]
> [   41.756265] [<ffffffff812a7663>] lock_acquire+0x173/0x330
> [   41.756454]
> [   41.756456] [<ffffffff812fe9e8>] call_timer_fn+0x118/0x520
> [   41.756645]
> [   41.756648] [<ffffffff812ff6d7>] run_timer_softirq+0x537/0x1450
> [   41.756838]
> [   41.756841] [<ffffffff82b0dc2e>] __do_softirq+0x21e/0x8a9
> [   41.757029]
> [   41.757031] [<ffffffff811b5093>] irq_exit+0x1a3/0x1d0
> [   41.757220]
> [   41.757222] [<ffffffff82b0d57b>] smp_apic_timer_interrupt+0x7b/0xa0
> [   41.757413]
> [   41.757416] [<ffffffff82b0c633>] apic_timer_interrupt+0x93/0xa0
> [   41.757606]
> [   41.757608] [<ffffffff825b781b>] cpuidle_enter_state+0x11b/0x820
> [   41.757798]
> [   41.757800] [<ffffffff825b7fb7>] cpuidle_enter+0x17/0x20
> [   41.757989]
> [   41.757991] [<ffffffff81288147>] call_cpuidle+0x47/0xc0
> [   41.758180]
> [   41.758182] [<ffffffff8128854e>] do_idle+0x21e/0x2e0
> [   41.758371]
> [   41.758373] [<ffffffff81288b1d>] cpu_startup_entry+0x1d/0x20
> [   41.758562]
> [   41.758565] [<ffffffff810f110d>] start_secondary+0x29d/0x370
> [   41.758754]
> [   41.758756] [<ffffffff810001c4>] verify_cpu+0x0/0xfc
> [   41.758943]  }
> [   41.759034]  ... key      at: [<ffffffff849430c0>] __key.42825+0x0/0x40
> [   41.759135]  ... acquired at:
> [   41.759227]
> [   41.759229] [<ffffffff812a0a3a>] check_irq_usage+0x7a/0x180
> [   41.759415]
> [   41.759418] [<ffffffff812a559b>] __lock_acquire+0x24db/0x3a20
> [   41.759604]
> [   41.759607] [<ffffffff812a7663>] lock_acquire+0x173/0x330
> [   41.759792]
> [   41.759795] [<ffffffff812fe80e>] del_timer_sync+0x4e/0x100
> [   41.759981]
> [   41.759983] [<ffffffff81c33ee6>] wbt_disable_default+0x76/0x210
> [   41.760170]
> [   41.760172] [<ffffffff81c183c7>] check_blkcg_changed+0x3d7/0xee0
> [   41.760359]
> [   41.760361] [<ffffffff81c193f8>] cfq_set_request+0x288/0xd50
> [   41.760547]
> [   41.760550] [<ffffffff81b6b583>] elv_set_request+0x83/0xf0
> [   41.760735]
> [   41.760737] [<ffffffff81b8032d>] get_request+0x16ad/0x1dc0
> [   41.760923]
> [   41.760925] [<ffffffff81b890c5>] blk_queue_bio+0x335/0xe20
> [   41.761111]
> [   41.761113] [<ffffffff81b81ca0>] generic_make_request+0x2e0/0x730
> [   41.761300]
> [   41.761302] [<ffffffff81b82228>] submit_bio+0x138/0x4c0
> [   41.761487]
> [   41.761490] [<ffffffff817528c0>] submit_bh_wbc+0x400/0x5c0
> [   41.761675]
> [   41.761678] [<ffffffff81754566>] ll_rw_block+0xc6/0x160
> [   41.761863]
> [   41.761865] [<ffffffff81890650>] ext4_find_entry+0xc60/0x1230
> [   41.762052]
> [   41.762054] [<ffffffff81891ed2>] ext4_lookup+0x112/0x770
> [   41.762239]
> [   41.762241] [<ffffffff816c3ee1>] lookup_open+0xd41/0x1520
> [   41.762427]
> [   41.762429] [<ffffffff816cdb8a>] path_openat+0x133a/0x2730
> [   41.762614]
> [   41.762616] [<ffffffff816d25b5>] do_filp_open+0x175/0x230
> [   41.762802]
> [   41.762805] [<ffffffff816ad999>] do_open_execat+0xb9/0x480
> [   41.762990]
> [   41.762993] [<ffffffff816b3351>] do_execveat_common.isra.39+0x651/0x1ec0
> [   41.763182]
> [   41.763184] [<ffffffff816b546a>] SyS_execve+0x3a/0x50
> [   41.763369]
> [   41.763371] [<ffffffff8100768d>] do_syscall_64+0x18d/0x450
> [   41.763557]
> [   41.763559] [<ffffffff82b0a90d>] return_from_SYSCALL_64+0x0/0x7a
>
> [   41.763834]
>                stack backtrace:
> [   41.763952] CPU: 20 PID: 1467 Comm: Starter.procman Not tainted 4.10.0-rc7+ #2
> [   41.764076] Hardware name: Supermicro X9DRW/X9DRW, BIOS 3.0c 10/30/2014
> [   41.764178] Call Trace:
> [   41.764272]  dump_stack+0x85/0xc4
> [   41.764367]  check_usage+0xb80/0xdd0
> [   41.764463]  ? check_usage_backwards+0x2f0/0x2f0
> [   41.764562]  ? unwind_next_frame+0x1f3/0x9d0
> [   41.764659]  ? entry_SYSCALL64_slow_path+0x25/0x25
> [   41.764756]  ? unwind_get_return_address+0x17e/0x260
> [   41.764854]  ? __unwind_start+0x390/0x390
> [   41.764950]  ? __unwind_start+0x1d0/0x390
> [   41.765046]  check_irq_usage+0x7a/0x180
> [   41.765142]  __lock_acquire+0x24db/0x3a20
> [   41.765239]  ? debug_check_no_locks_freed+0x290/0x290
> [   41.765338]  ? debug_check_no_locks_freed+0x290/0x290
> [   41.765439]  ? alloc_debug_processing+0x73/0x1b0
> [   41.765537]  lock_acquire+0x173/0x330
> [   41.765632]  ? del_timer_sync+0x5/0x100
> [   41.765728]  del_timer_sync+0x4e/0x100
> [   41.765824]  ? del_timer_sync+0x5/0x100
> [   41.766008]  wbt_disable_default+0x76/0x210
> [   41.766104]  check_blkcg_changed+0x3d7/0xee0
> [   41.766200]  ? check_blkcg_changed+0xbe/0xee0
> [   41.766296]  ? cfq_idle_slice_timer+0x3b0/0x3b0
> [   41.766394]  ? cfq_set_request+0x18f/0xd50
> [   41.766490]  cfq_set_request+0x288/0xd50
> [   41.766587]  ? debug_lockdep_rcu_enabled+0x77/0x90
> [   41.766684]  ? cfq_exit_icq+0x170/0x170
> [   41.766780]  ? mark_held_locks+0xc8/0x120
> [   41.766875]  ? _raw_spin_unlock_irq+0x2c/0x40
> [   41.766972]  ? trace_hardirqs_on_caller+0x3fe/0x580
> [   41.767070]  ? trace_hardirqs_on+0xd/0x10
> [   41.767165]  ? _raw_spin_unlock_irq+0x2c/0x40
> [   41.767263]  ? ioc_create_icq+0x403/0x6a0
> [   41.767359]  elv_set_request+0x83/0xf0
> [   41.767454]  get_request+0x16ad/0x1dc0
> [   41.767549]  ? get_request+0xb0/0x1dc0
> [   41.767645]  ? trace_event_raw_event_block_rq_with_error+0x680/0x680
> [   41.767747]  ? wake_atomic_t_function+0x2a0/0x2a0
> [   41.767844]  ? elv_merge+0x25e/0x300
> [   41.767939]  blk_queue_bio+0x335/0xe20
> [   41.768034]  ? blk_flush_plug_list+0x920/0x920
> [   41.768131]  ? blk_exit_rl+0x40/0x40
> [   41.768226]  ? generic_make_request+0x365/0x730
> [   41.768323]  generic_make_request+0x2e0/0x730
> [   41.768419]  ? generic_make_request+0x2d3/0x730
> [   41.768516]  ? blk_queue_enter+0x510/0x510
> [   41.768612]  ? __find_get_block+0x5b8/0x800
> [   41.768709]  submit_bio+0x138/0x4c0
> [   41.768803]  ? __getblk_gfp+0x14a/0x6f0
> [   41.768899]  ? do_execveat_common.isra.39+0x651/0x1ec0
> [   41.768997]  ? generic_make_request+0x730/0x730
> [   41.769095]  submit_bh_wbc+0x400/0x5c0
> [   41.769190]  ll_rw_block+0xc6/0x160
> [   41.769285]  ext4_find_entry+0xc60/0x1230
> [   41.769381]  ? ext4_search_dir+0x4b0/0x4b0
> [   41.769478]  ? d_alloc_parallel+0x595/0x1550
> [   41.769574]  ? d_alloc_parallel+0x5b4/0x1550
> [   41.769670]  ? lookup_open+0x430/0x1520
> [   41.769766]  ? __d_lookup+0x1aa/0x5e0
> [   41.775578]  ext4_lookup+0x112/0x770
> [   41.775673]  ? __d_lookup+0x1c9/0x5e0
> [   41.775767]  ? __d_lookup+0x3e/0x5e0
> [   41.775862]  ? ext4_cross_rename+0x11a0/0x11a0
> [   41.775958]  ? ext4_cross_rename+0x11a0/0x11a0
> [   41.776055]  lookup_open+0xd41/0x1520
> [   41.776150]  ? vfs_link+0xa90/0xa90
> [   41.776245]  path_openat+0x133a/0x2730
> [   41.776340]  ? path_lookupat+0x3d0/0x3d0
> [   41.776435]  ? save_stack+0xb5/0xd0
> [   41.776530]  ? save_stack_trace+0x1b/0x20
> [   41.776625]  ? save_stack+0x46/0xd0
> [   41.776718]  ? kasan_kmalloc+0xad/0xe0
> [   41.776813]  ? kasan_slab_alloc+0x12/0x20
> [   41.776908]  ? kmem_cache_alloc+0xcc/0x2b0
> [   41.777005]  ? prepare_creds+0x26/0x2b0
> [   41.777099]  ? prepare_exec_creds+0x11/0xe0
> [   41.777195]  ? prepare_bprm_creds+0x5e/0x100
> [   41.777291]  ? do_execveat_common.isra.39+0x2a1/0x1ec0
> [   41.777389]  ? SyS_execve+0x3a/0x50
> [   41.777483]  ? do_syscall_64+0x18d/0x450
> [   41.777578]  ? entry_SYSCALL64_slow_path+0x25/0x25
> [   41.777675]  do_filp_open+0x175/0x230
> [   41.777770]  ? may_open_dev+0xc0/0xc0
> [   41.777865]  ? __slab_alloc+0x5e/0x90
> [   41.777961]  ? debug_lockdep_rcu_enabled+0x77/0x90
> [   41.778058]  do_open_execat+0xb9/0x480
> [   41.778153]  ? setup_arg_pages+0x760/0x760
> [   41.778250]  do_execveat_common.isra.39+0x651/0x1ec0
> [   41.778347]  ? do_execveat_common.isra.39+0x38a/0x1ec0
> [   41.778446]  ? kasan_check_write+0x14/0x20
> [   41.778541]  ? rcu_read_lock_sched_held+0x80/0x130
> [   41.778639]  ? prepare_bprm_creds+0x100/0x100
> [   41.778735]  ? getname_flags+0x102/0x510
> [   41.778831]  SyS_execve+0x3a/0x50
> [   41.778925]  ? ptregs_sys_vfork+0x10/0x10
> [   41.779020]  do_syscall_64+0x18d/0x450
> [   41.779115]  ? setup_new_exec+0x7e0/0x7e0
> [   41.779222]  entry_SYSCALL64_slow_path+0x25/0x25
> [   41.779327] RIP: 0033:0x7f50f1d88bc7
> [   41.779420] RSP: 002b:00007ffcfc1d7b98 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
> [   41.779546] RAX: ffffffffffffffda RBX: 00007f50f336ef80 RCX: 00007f50f1d88bc7
> [   41.779649] RDX: 0000000001a1fdd0 RSI: 0000000001a7af70 RDI: 0000000001a7aef0
> [   41.779751] RBP: 0000000000000009 R08: 0000000000000000 R09: 000000000000000f
> [   41.779854] R10: 0000000000000598 R11: 0000000000000202 R12: 0000000001a7af70
> [   41.779956] R13: 0000000000000001 R14: 00007f50eac83cb0 R15: 0000000001a7af70
