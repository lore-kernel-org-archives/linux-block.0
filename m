Return-Path: <tglx@linutronix.de>
Date: Mon, 13 Feb 2017 15:14:12 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
    Gabriel C <nix.or.die@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
    Peter Zijlstra <peterz@infradead.org>,
    Linus Torvalds <torvalds@linux-foundation.org>
Subject: [BUG] Potential deadlock in the block layer
Message-ID: <alpine.DEB.2.20.1702131505580.3619@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

Gabriel reported the lockdep splat below while investigating something
different.

Explanation for the splat is in the function comment above
del_timer_sync().

I can reproduce it as well and it's clearly broken.

Thanks,

	tglx

---

[   81.518032] ======================================================
[   81.520151] [ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]
[   81.522276] 4.10.0-rc8-debug-dirty #1 Tainted: G          I
[   81.524445] ------------------------------------------------------
[   81.526560] (systemd)/1725 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[   81.528672]  (((&rwb->window_timer))){+.-...}, at: [<ffffffff810e38e0>] del_timer_sync+0x0/0xd0
[   81.530973]
                and this task is already holding:
[   81.535399]  (&(&q->__queue_lock)->rlock){-.-...}, at: [<ffffffff81378fc0>] cfq_set_request+0x80/0x2c0
[   81.537637] which would create a new lock dependency:
[   81.539870]  (&(&q->__queue_lock)->rlock){-.-...} -> (((&rwb->window_timer))){+.-...}
[   81.542145]
                but this new dependency connects a HARDIRQ-irq-safe lock:
[   81.546717]  (&(&q->__queue_lock)->rlock){-.-...}
[   81.546720]
                ... which became HARDIRQ-irq-safe at:
[   81.553643]   __lock_acquire+0x24f/0x19e0
[   81.555970]   lock_acquire+0xa5/0xd0
[   81.558302]   _raw_spin_lock_irqsave+0x54/0x90
[   81.560667]   ata_qc_schedule_eh+0x56/0x80 [libata]
[   81.563035]   ata_qc_complete+0x99/0x1c0 [libata]
[   81.565410]   ata_do_link_abort+0x93/0xd0 [libata]
[   81.567786]   ata_port_abort+0xb/0x10 [libata]
[   81.570150]   ahci_handle_port_interrupt+0x41e/0x570 [libahci]
[   81.572533]   ahci_handle_port_intr+0x74/0xb0 [libahci]
[   81.574918]   ahci_single_level_irq_intr+0x3b/0x60 [libahci]
[   81.577311]   __handle_irq_event_percpu+0x35/0x100
[   81.579696]   handle_irq_event_percpu+0x1e/0x50
[   81.582065]   handle_irq_event+0x34/0x60
[   81.584427]   handle_edge_irq+0x112/0x140
[   81.586776]   handle_irq+0x18/0x20
[   81.589109]   do_IRQ+0x87/0x110
[   81.591403]   ret_from_intr+0x0/0x20
[   81.593666]   cpuidle_enter_state+0x102/0x230
[   81.595939]   cpuidle_enter+0x12/0x20
[   81.598202]   call_cpuidle+0x38/0x40
[   81.600443]   do_idle+0x16e/0x1e0
[   81.602670]   cpu_startup_entry+0x5d/0x60
[   81.604890]   rest_init+0x12c/0x140
[   81.607080]   start_kernel+0x45f/0x46c
[   81.609252]   x86_64_start_reservations+0x2a/0x2c
[   81.611399]   x86_64_start_kernel+0xeb/0xf8
[   81.613505]   verify_cpu+0x0/0xfc
[   81.615574]
                to a HARDIRQ-irq-unsafe lock:
[   81.619611]  (((&rwb->window_timer))){+.-...}
[   81.619614]
                ... which became HARDIRQ-irq-unsafe at:
[   81.625562] ...
[   81.625565]   __lock_acquire+0x2ba/0x19e0
[   81.629504]   lock_acquire+0xa5/0xd0
[   81.631467]   call_timer_fn+0x74/0x110
[   81.633397]   expire_timers+0xaa/0xd0
[   81.635287]   run_timer_softirq+0x72/0x140
[   81.637145]   __do_softirq+0x143/0x290
[   81.638974]   irq_exit+0x6a/0xd0
[   81.640818]   smp_trace_apic_timer_interrupt+0x79/0x90
[   81.642698]   smp_apic_timer_interrupt+0x9/0x10
[   81.644572]   apic_timer_interrupt+0x93/0xa0
[   81.646445]   cpuidle_enter_state+0x102/0x230
[   81.648332]   cpuidle_enter+0x12/0x20
[   81.650211]   call_cpuidle+0x38/0x40
[   81.652096]   do_idle+0x16e/0x1e0
[   81.653984]   cpu_startup_entry+0x5d/0x60
[   81.655855]   start_secondary+0x150/0x180
[   81.657696]   verify_cpu+0x0/0xfc
[   81.659497]
                other info that might help us debug this:

[   81.664802]  Possible interrupt unsafe locking scenario:

[   81.668296]        CPU0                    CPU1
[   81.670010]        ----                    ----
[   81.671685]   lock(((&rwb->window_timer)));
[   81.673358]                                local_irq_disable();
[   81.675018]                                lock(&(&q->__queue_lock)->rlock);
[   81.676659]                                lock(((&rwb->window_timer)));
[   81.678275]   <Interrupt>
[   81.679845]     lock(&(&q->__queue_lock)->rlock);
[   81.681419]
                 *** DEADLOCK ***

[   81.685989] 1 lock held by (systemd)/1725:
[   81.687518]  #0:  (&(&q->__queue_lock)->rlock){-.-...}, at: [<ffffffff81378fc0>] cfq_set_request+0x80/0x2c0
[   81.689125]
                the dependencies between HARDIRQ-irq-safe lock and the holding lock:
[   81.692327] -> (&(&q->__queue_lock)->rlock){-.-...} ops: 70140 {
[   81.693971]    IN-HARDIRQ-W at:
[   81.695606]                     __lock_acquire+0x24f/0x19e0
[   81.697262]                     lock_acquire+0xa5/0xd0
[   81.698906]                     _raw_spin_lock_irqsave+0x54/0x90
[   81.700568]                     ata_qc_schedule_eh+0x56/0x80 [libata]
[   81.702229]                     ata_qc_complete+0x99/0x1c0 [libata]
[   81.703884]                     ata_do_link_abort+0x93/0xd0 [libata]
[   81.705540]                     ata_port_abort+0xb/0x10 [libata]
[   81.707199]                     ahci_handle_port_interrupt+0x41e/0x570 [libahci]
[   81.708881]                     ahci_handle_port_intr+0x74/0xb0 [libahci]
[   81.710563]                     ahci_single_level_irq_intr+0x3b/0x60 [libahci]
[   81.712256]                     __handle_irq_event_percpu+0x35/0x100
[   81.713952]                     handle_irq_event_percpu+0x1e/0x50
[   81.715651]                     handle_irq_event+0x34/0x60
[   81.717350]                     handle_edge_irq+0x112/0x140
[   81.719050]                     handle_irq+0x18/0x20
[   81.720744]                     do_IRQ+0x87/0x110
[   81.722432]                     ret_from_intr+0x0/0x20
[   81.724123]                     cpuidle_enter_state+0x102/0x230
[   81.725823]                     cpuidle_enter+0x12/0x20
[   81.727509]                     call_cpuidle+0x38/0x40
[   81.729196]                     do_idle+0x16e/0x1e0
[   81.730879]                     cpu_startup_entry+0x5d/0x60
[   81.732565]                     rest_init+0x12c/0x140
[   81.734246]                     start_kernel+0x45f/0x46c
[   81.735927]                     x86_64_start_reservations+0x2a/0x2c
[   81.737617]                     x86_64_start_kernel+0xeb/0xf8
[   81.739297]                     verify_cpu+0x0/0xfc
[   81.740964]    IN-SOFTIRQ-W at:
[   81.742628]                     __lock_acquire+0x268/0x19e0
[   81.744311]                     lock_acquire+0xa5/0xd0
[   81.745994]                     _raw_spin_lock_irqsave+0x54/0x90
[   81.747699]                     scsi_end_request+0x144/0x1a0 [scsi_mod]
[   81.749417]                     scsi_io_completion+0x268/0x610 [scsi_mod]
[   81.751133]                     scsi_finish_command+0x103/0x110 [scsi_mod]
[   81.752856]                     scsi_softirq_done+0x11f/0x130 [scsi_mod]
[   81.754575]                     blk_done_softirq+0x9b/0xb0
[   81.756288]                     __do_softirq+0x143/0x290
[   81.757992]                     irq_exit+0x6a/0xd0
[   81.759688]                     smp_trace_apic_timer_interrupt+0x79/0x90
[   81.761407]                     smp_apic_timer_interrupt+0x9/0x10
[   81.763131]                     apic_timer_interrupt+0x93/0xa0
[   81.764862]                     _raw_spin_unlock_irqrestore+0x47/0x70
[   81.766606]                     release_pages+0x51/0x390
[   81.768347]                     free_pages_and_swap_cache+0x2a/0xb0
[   81.770100]                     tlb_flush_mmu_free+0x34/0x50
[   81.771851]                     tlb_finish_mmu+0x17/0x50
[   81.773592]                     unmap_region+0xe8/0x100
[   81.775322]                     do_munmap+0x264/0x3e0
[   81.777040]                     SyS_munmap+0x49/0x70
[   81.778752]                     entry_SYSCALL_64_fastpath+0x1f/0xc2
[   81.780483]    INITIAL USE at:
[   81.782221]                    __lock_acquire+0x1c9/0x19e0
[   81.783978]                    lock_acquire+0xa5/0xd0
[   81.785721]                    _raw_spin_lock_irq+0x48/0x80
[   81.787470]                    blkcg_init_queue+0xad/0x1b0
[   81.789217]                    blk_alloc_queue_node+0x27d/0x2d0
[   81.790959]                    blk_mq_init_queue+0x1b/0x60
[   81.792695]                    loop_add+0xf4/0x280
[   81.794427]                    loop_init+0x101/0x142
[   81.796166]                    do_one_initcall+0x6f/0x190
[   81.797914]                    kernel_init_freeable+0x321/0x3b7
[   81.799659]                    kernel_init+0x9/0xf0
[   81.801360]                    ret_from_fork+0x31/0x40
[   81.803029]  }
[   81.804660]  ... key      at: [<ffffffff82f1e728>] __key.42689+0x0/0x8
[   81.806315]  ... acquired at:
[   81.807937]    check_irq_usage+0x4d/0xa0
[   81.809555]    __lock_acquire+0x1110/0x19e0
[   81.811176]    lock_acquire+0xa5/0xd0
[   81.812783]    del_timer_sync+0x49/0xd0
[   81.814385]    wbt_disable_default+0x1e/0x60
[   81.815991]    check_blkcg_changed+0x22d/0x380
[   81.817594]    cfq_set_request+0xe5/0x2c0
[   81.819194]    elv_set_request+0x1a/0x20
[   81.820775]    get_request+0x88d/0x900
[   81.822355]    blk_queue_bio+0x1e9/0x320
[   81.823925]    generic_make_request+0xbe/0x170
[   81.825492]    submit_bio+0x121/0x150
[   81.827050]    btrfs_map_bio+0x282/0x2a0
[   81.828613]    btree_submit_bio_hook+0x71/0xe0
[   81.830181]    submit_one_bio+0x65/0x90
[   81.831750]    read_extent_buffer_pages+0x1fa/0x2f0
[   81.833336]    btree_read_extent_buffer_pages+0x59/0xf0
[   81.834932]    read_tree_block+0x2d/0x50
[   81.836528]    read_block_for_search.isra.10+0x296/0x2e0
[   81.838140]    btrfs_search_slot+0x6cc/0x920
[   81.839754]    btrfs_lookup_csum+0x3e/0x120
[   81.841370]    __btrfs_lookup_bio_sums+0x258/0x4d0
[   81.842993]    btrfs_lookup_bio_sums+0x11/0x20
[   81.844621]    btrfs_submit_compressed_read+0x3d0/0x4c0
[   81.846259]    btrfs_submit_bio_hook+0xbb/0x170
[   81.847889]    submit_one_bio+0x65/0x90
[   81.849516]    extent_readpages+0x1dd/0x1f0
[   81.851145]    btrfs_readpages+0x1a/0x20
[   81.852769]    __do_page_cache_readahead+0x249/0x320
[   81.854396]    ondemand_readahead+0x47e/0x4b0
[   81.856025]    page_cache_sync_readahead+0x3c/0x40
[   81.857656]    generic_file_read_iter+0x20e/0x770
[   81.859279]    __vfs_read+0xe5/0x120
[   81.860897]    vfs_read+0xc7/0x170
[   81.862503]    SyS_read+0x44/0xa0
[   81.864102]    entry_SYSCALL_64_fastpath+0x1f/0xc2

[   81.867299]
                the dependencies between the lock to be acquired
[   81.867300]  and HARDIRQ-irq-unsafe lock:
[   81.872089] -> (((&rwb->window_timer))){+.-...} ops: 463 {
[   81.873716]    HARDIRQ-ON-W at:
[   81.875336]                     __lock_acquire+0x2ba/0x19e0
[   81.876969]                     lock_acquire+0xa5/0xd0
[   81.878598]                     call_timer_fn+0x74/0x110
[   81.880225]                     expire_timers+0xaa/0xd0
[   81.881853]                     run_timer_softirq+0x72/0x140
[   81.883486]                     __do_softirq+0x143/0x290
[   81.885127]                     irq_exit+0x6a/0xd0
[   81.886765]                     smp_trace_apic_timer_interrupt+0x79/0x90
[   81.888419]                     smp_apic_timer_interrupt+0x9/0x10
[   81.890066]                     apic_timer_interrupt+0x93/0xa0
[   81.891706]                     cpuidle_enter_state+0x102/0x230
[   81.893349]                     cpuidle_enter+0x12/0x20
[   81.894982]                     call_cpuidle+0x38/0x40
[   81.896610]                     do_idle+0x16e/0x1e0
[   81.898235]                     cpu_startup_entry+0x5d/0x60
[   81.899866]                     start_secondary+0x150/0x180
[   81.901497]                     verify_cpu+0x0/0xfc
[   81.903126]    IN-SOFTIRQ-W at:
[   81.904753]                     __lock_acquire+0x268/0x19e0
[   81.906402]                     lock_acquire+0xa5/0xd0
[   81.908052]                     call_timer_fn+0x74/0x110
[   81.909702]                     expire_timers+0xaa/0xd0
[   81.911347]                     run_timer_softirq+0x72/0x140
[   81.912980]                     __do_softirq+0x143/0x290
[   81.914605]                     irq_exit+0x6a/0xd0
[   81.916227]                     smp_trace_apic_timer_interrupt+0x79/0x90
[   81.917867]                     smp_apic_timer_interrupt+0x9/0x10
[   81.919510]                     apic_timer_interrupt+0x93/0xa0
[   81.921161]                     cpuidle_enter_state+0x102/0x230
[   81.922807]                     cpuidle_enter+0x12/0x20
[   81.924444]                     call_cpuidle+0x38/0x40
[   81.926082]                     do_idle+0x16e/0x1e0
[   81.927718]                     cpu_startup_entry+0x5d/0x60
[   81.929358]                     start_secondary+0x150/0x180
[   81.930996]                     verify_cpu+0x0/0xfc
[   81.932628]    INITIAL USE at:
[   81.934256]                    __lock_acquire+0x1c9/0x19e0
[   81.935907]                    lock_acquire+0xa5/0xd0
[   81.937550]                    call_timer_fn+0x74/0x110
[   81.939192]                    expire_timers+0xaa/0xd0
[   81.940826]                    run_timer_softirq+0x72/0x140
[   81.942456]                    __do_softirq+0x143/0x290
[   81.944075]                    irq_exit+0x6a/0xd0
[   81.945685]                    smp_trace_apic_timer_interrupt+0x79/0x90
[   81.947304]                    smp_apic_timer_interrupt+0x9/0x10
[   81.948926]                    apic_timer_interrupt+0x93/0xa0
[   81.950547]                    cpuidle_enter_state+0x102/0x230
[   81.952162]                    cpuidle_enter+0x12/0x20
[   81.953766]                    call_cpuidle+0x38/0x40
[   81.955369]                    do_idle+0x16e/0x1e0
[   81.956971]                    cpu_startup_entry+0x5d/0x60
[   81.958580]                    start_secondary+0x150/0x180
[   81.960191]                    verify_cpu+0x0/0xfc
[   81.961787]  }
[   81.963360]  ... key      at: [<ffffffff82f1f7e0>] __key.37597+0x0/0x8
[   81.964971]  ... acquired at:
[   81.966566]    check_irq_usage+0x4d/0xa0
[   81.968162]    __lock_acquire+0x1110/0x19e0
[   81.969767]    lock_acquire+0xa5/0xd0
[   81.971374]    del_timer_sync+0x49/0xd0
[   81.972973]    wbt_disable_default+0x1e/0x60
[   81.974574]    check_blkcg_changed+0x22d/0x380
[   81.976192]    cfq_set_request+0xe5/0x2c0
[   81.977800]    elv_set_request+0x1a/0x20
[   81.979384]    get_request+0x88d/0x900
[   81.980954]    blk_queue_bio+0x1e9/0x320
[   81.982506]    generic_make_request+0xbe/0x170
[   81.984057]    submit_bio+0x121/0x150
[   81.985606]    btrfs_map_bio+0x282/0x2a0
[   81.987157]    btree_submit_bio_hook+0x71/0xe0
[   81.988713]    submit_one_bio+0x65/0x90
[   81.990269]    read_extent_buffer_pages+0x1fa/0x2f0
[   81.991829]    btree_read_extent_buffer_pages+0x59/0xf0
[   81.993394]    read_tree_block+0x2d/0x50
[   81.994950]    read_block_for_search.isra.10+0x296/0x2e0
[   81.996513]    btrfs_search_slot+0x6cc/0x920
[   81.998073]    btrfs_lookup_csum+0x3e/0x120
[   81.999624]    __btrfs_lookup_bio_sums+0x258/0x4d0
[   82.001190]    btrfs_lookup_bio_sums+0x11/0x20
[   82.002767]    btrfs_submit_compressed_read+0x3d0/0x4c0
[   82.004352]    btrfs_submit_bio_hook+0xbb/0x170
[   82.005933]    submit_one_bio+0x65/0x90
[   82.007513]    extent_readpages+0x1dd/0x1f0
[   82.009092]    btrfs_readpages+0x1a/0x20
[   82.010667]    __do_page_cache_readahead+0x249/0x320
[   82.012241]    ondemand_readahead+0x47e/0x4b0
[   82.013816]    page_cache_sync_readahead+0x3c/0x40
[   82.015398]    generic_file_read_iter+0x20e/0x770
[   82.016989]    __vfs_read+0xe5/0x120
[   82.018577]    vfs_read+0xc7/0x170
[   82.020155]    SyS_read+0x44/0xa0
[   82.021731]    entry_SYSCALL_64_fastpath+0x1f/0xc2

[   82.024866]
                stack backtrace:
[   82.027929] CPU: 13 PID: 1725 Comm: (systemd) Tainted: G          I     4.10.0-rc8-debug-dirty #1
[   82.029530] Hardware name: FUJITSU                          PRIMERGY TX200 S5             /D2709, BIOS 6.00 Rev. 1.14.2709              02/04/2013
[   82.031213] Call Trace:
[   82.032870]  dump_stack+0x86/0xc1
[   82.034527]  check_usage+0x5fc/0x630
[   82.036191]  check_irq_usage+0x4d/0xa0
[   82.037852]  __lock_acquire+0x1110/0x19e0
[   82.039510]  ? __lock_acquire+0x18f0/0x19e0
[   82.041160]  ? __lock_acquire+0x18f0/0x19e0
[   82.042792]  lock_acquire+0xa5/0xd0
[   82.044425]  ? collect_expired_timers+0xb0/0xb0
[   82.046069]  del_timer_sync+0x49/0xd0
[   82.047711]  ? collect_expired_timers+0xb0/0xb0
[   82.049366]  wbt_disable_default+0x1e/0x60
[   82.051024]  check_blkcg_changed+0x22d/0x380
[   82.052678]  ? cfq_pd_offline+0x110/0x110
[   82.054327]  ? debug_smp_processor_id+0x17/0x20
[   82.055977]  ? get_lock_stats+0x19/0x50
[   82.057623]  ? cfq_set_request+0x80/0x2c0
[   82.059276]  cfq_set_request+0xe5/0x2c0
[   82.060926]  ? _raw_spin_unlock_irq+0x27/0x50
[   82.062656]  ? __this_cpu_preempt_check+0x13/0x20
[   82.064314]  ? trace_hardirqs_on_caller+0x1db/0x210
[   82.065976]  ? trace_hardirqs_on+0xd/0x10
[   82.067630]  ? _raw_spin_unlock_irq+0x38/0x50
[   82.069291]  elv_set_request+0x1a/0x20
[   82.070937]  get_request+0x88d/0x900
[   82.072568]  ? get_request+0x47/0x900
[   82.074202]  ? prepare_to_wait_event+0x180/0x180
[   82.075842]  blk_queue_bio+0x1e9/0x320
[   82.077476]  generic_make_request+0xbe/0x170
[   82.079117]  submit_bio+0x121/0x150
[   82.080754]  ? __percpu_counter_add+0x8b/0xb0
[   82.082390]  btrfs_map_bio+0x282/0x2a0
[   82.084027]  ? free_root_pointers+0x60/0x60
[   82.085673]  btree_submit_bio_hook+0x71/0xe0
[   82.087320]  submit_one_bio+0x65/0x90
[   82.088969]  read_extent_buffer_pages+0x1fa/0x2f0
[   82.090628]  ? free_root_pointers+0x60/0x60
[   82.092284]  btree_read_extent_buffer_pages+0x59/0xf0
[   82.093952]  read_tree_block+0x2d/0x50
[   82.095612]  read_block_for_search.isra.10+0x296/0x2e0
[   82.097282]  btrfs_search_slot+0x6cc/0x920
[   82.098946]  ? __this_cpu_preempt_check+0x13/0x20
[   82.100617]  btrfs_lookup_csum+0x3e/0x120
[   82.102280]  __btrfs_lookup_bio_sums+0x258/0x4d0
[   82.103951]  ? kmem_cache_alloc+0x11a/0x130
[   82.105613]  btrfs_lookup_bio_sums+0x11/0x20
[   82.107280]  btrfs_submit_compressed_read+0x3d0/0x4c0
[   82.108953]  btrfs_submit_bio_hook+0xbb/0x170
[   82.110610]  submit_one_bio+0x65/0x90
[   82.112260]  extent_readpages+0x1dd/0x1f0
[   82.113910]  ? btrfs_direct_IO+0x320/0x320
[   82.115559]  ? alloc_pages_current+0x14a/0x1e0
[   82.117219]  ? __page_cache_alloc+0xcc/0x150
[   82.118873]  btrfs_readpages+0x1a/0x20
[   82.120524]  __do_page_cache_readahead+0x249/0x320
[   82.122181]  ? __do_page_cache_readahead+0xb4/0x320
[   82.123836]  ondemand_readahead+0x47e/0x4b0
[   82.125491]  page_cache_sync_readahead+0x3c/0x40
[   82.127148]  generic_file_read_iter+0x20e/0x770
[   82.128817]  ? __do_page_fault+0x325/0x410
[   82.130490]  __vfs_read+0xe5/0x120
[   82.132152]  vfs_read+0xc7/0x170
[   82.133809]  SyS_read+0x44/0xa0
[   82.135479]  entry_SYSCALL_64_fastpath+0x1f/0xc2
[   82.137166] RIP: 0033:0x7f4eace2ff27
[   82.138825] RSP: 002b:00007ffdd7f77318 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
[   82.140477] RAX: ffffffffffffffda RBX: ffffffff813b0823 RCX: 00007f4eace2ff27
[   82.142106] RDX: 0000000000000340 RSI: 00007ffdd7f77408 RDI: 0000000000000008
[   82.143751] RBP: ffffc9000ccb7f88 R08: 0000000090000002 R09: 00007ffdd7f773ef
[   82.145408] R10: 00007f4eace310d0 R11: 0000000000000202 R12: 00007ffdd7f773ef
[   82.147072] R13: 0000000000000340 R14: 0000000000000008 R15: 00007ffdd7f77400
[   82.148745]  ? __this_cpu_preempt_check+0x13/0x20
