Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33192 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbdHGTqa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Aug 2017 15:46:30 -0400
Received: by mail-qt0-f176.google.com with SMTP id a18so8887584qta.0
        for <linux-block@vger.kernel.org>; Mon, 07 Aug 2017 12:46:29 -0700 (PDT)
Subject: Re: [PATCH V2 00/20] blk-mq-sched: improve SCSI-MQ performance
From: Laurence Oberman <loberman@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <df64b15d-a443-553c-a3c6-d834320648fd@redhat.com>
 <1502119672.6219.1.camel@wdc.com>
 <839ff581-6e8b-6d9c-6f85-28770fb96107@redhat.com>
 <899f9ca6-f143-b1f4-6f4f-15e2e35f65ee@redhat.com>
Message-ID: <2d8a0b37-1931-d636-85ca-659f0c9721db@redhat.com>
Date: Mon, 7 Aug 2017 15:46:26 -0400
MIME-Version: 1.0
In-Reply-To: <899f9ca6-f143-b1f4-6f4f-15e2e35f65ee@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 08/07/2017 02:46 PM, Laurence Oberman wrote:
> 
> 
> On 08/07/2017 01:29 PM, Laurence Oberman wrote:
>>
>>
>> On 08/07/2017 11:27 AM, Bart Van Assche wrote:
>>> On Mon, 2017-08-07 at 08:48 -0400, Laurence Oberman wrote:
>>>> I tested this series using Ming's tests as well as my own set of tests
>>>> typically run against changes to upstream code in my SRP test-bed.
>>>> My tests also include very large sequential buffered and un-buffered 
>>>> I/O.
>>>>
>>>> This series seems to be fine for me. I did uncover another issue 
>>>> that is
>>>> unrelated to these patches and also exists in 4.13-RC3 generic that 
>>>> I am
>>>> still debugging.
>>>
>>> Hello Laurence,
>>>
>>> What kind of tests did you run? Only functional tests or also 
>>> performance
>>> tests?
>>>
>>> Has the issue you encountered with kernel 4.13-rc3 already been 
>>> reported on
>>> the linux-rdma mailing list?
>>>
>>> Thanks,
>>>
>>> Bart.
>>>
>>
>> Hi Bart
>>
>> Actually I was focusing on just performance to see if we had any 
>> regressions with Mings new patches for the large sequential I/O cases.
>>
>> Ming had already tested the small I/O performance cases so I was 
>> making sure the large I/O sequential tests did not suffer.
>>
>> The 4MB un-buffered direct read tests to DM devices seems to perform 
>> much the same in my test bed.
>> The 4MB buffered and un-buffered 4MB writes also seem to be well 
>> behaved with not much improvement.
>>
>> These were not exhaustive tests and did not include my usual port 
>> disconnect and recovery tests either.
>> I was just making sure we did not regress with Ming's changes.
>>
>> I was only just starting to baseline test the mq-deadline scheduler as 
>> prior to 4.13-RC3 I had not been testing any of the new MQ schedulers.
>> I had always only tested with [none]
>>
>> The tests were with [none] and [mq-deadline]
>>
>> The new issue I started seeing was not yet reported yet as I was still 
>> investigating it.
>>
>> In summary:
>> With buffered writes we see the clone fail in blk_get_request in both 
>> Mings kernel and in the upstream 4.13-RC3 stock kernel
>>
>> [  885.271451] io scheduler mq-deadline registered
>> [  898.455442] device-mapper: multipath: blk_get_request() returned 
>> -11 - requeuing
>>
>> This is due to
>>
>> multipath_clone_and_map()
>>
>> /*
>>   * Map cloned requests (request-based multipath)
>>   */
>> static int multipath_clone_and_map(struct dm_target *ti, struct 
>> request *rq,
>>                                     union map_info *map_context,
>>                                     struct request **__clone)
>> {
>> ..
>> ..
>> ..
>>          clone = blk_get_request(q, rq->cmd_flags | REQ_NOMERGE, 
>> GFP_ATOMIC);
>>          if (IS_ERR(clone)) {
>>                  /* EBUSY, ENODEV or EWOULDBLOCK: requeue */
>>                  bool queue_dying = blk_queue_dying(q);
>>                  DMERR_LIMIT("blk_get_request() returned %ld%s - 
>> requeuing",
>>                              PTR_ERR(clone), queue_dying ? " (path 
>> offline)" : "");
>>                  if (queue_dying) {
>>                          atomic_inc(&m->pg_init_in_progress);
>>                          activate_or_offline_path(pgpath);
>>                          return DM_MAPIO_REQUEUE;
>>                  }
>>                  return DM_MAPIO_DELAY_REQUEUE;
>>          }
>>
>> Still investigating but it leads to a hard lockup
>>
>>
>> So I still need to see if the hard-lockup happens in the stock kernel 
>> with mq-deadline and some other work before coming up with a full 
>> summary of the issue.
>>
>> I also intend to re-run all tests including disconnect and reconnect 
>> tests on both mq-deadline and none.
>>
>> Trace below
>>
>>
>> [ 1553.167357] NMI watchdog: Watchdog detected hard LOCKUP on cpu 4
>> [ 1553.167359] Modules linked in: mq_deadline binfmt_misc 
>> dm_round_robin xt_CHECKSUM ipt_MASQUERADE nf_nat_masquerade_ipv4 tun 
>> ip6t_rpfilter ipt_REJECT nf_reject_ipv4 ip6t_REJECT nf_reject_ipv6 
>> xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp 
>> llc ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 rpcrdma 
>> ip6table_mangle ip6table_security ip6table_raw iptable_nat ib_isert 
>> nf_conntrack_ipv4 iscsi_target_mod nf_defrag_ipv4 nf_nat_ipv4 nf_nat 
>> nf_conntrack ib_iser libiscsi scsi_transport_iscsi iptable_mangle 
>> iptable_security iptable_raw ebtable_filter ebtables target_core_mod 
>> ip6table_filter ip6_tables iptable_filter ib_srp scsi_transport_srp 
>> ib_ipoib rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_cm mlx5_ib 
>> ib_core intel_powerclamp coretemp kvm_intel kvm irqbypass 
>> crct10dif_pclmul
>> [ 1553.167385]  crc32_pclmul ghash_clmulni_intel pcbc aesni_intel sg 
>> joydev ipmi_si hpilo crypto_simd hpwdt iTCO_wdt cryptd ipmi_devintf 
>> glue_helper gpio_ich iTCO_vendor_support shpchp ipmi_msghandler pcspkr 
>> acpi_power_meter i7core_edac lpc_ich pcc_cpufreq nfsd auth_rpcgss 
>> nfs_acl lockd grace sunrpc dm_multipath ip_tables xfs libcrc32c sd_mod 
>> amdkfd amd_iommu_v2 radeon i2c_algo_bit drm_kms_helper syscopyarea 
>> sysfillrect sysimgblt fb_sys_fops ttm mlx5_core drm mlxfw i2c_core ptp 
>> serio_raw hpsa crc32c_intel bnx2 pps_core devlink scsi_transport_sas 
>> dm_mirror dm_region_hash dm_log dm_mod [last unloaded: ib_srpt]
>> [ 1553.167410] CPU: 4 PID: 11532 Comm: dd Tainted: G          I 
>> 4.13.0-rc3lobeming.ming_V4+ #20
>> [ 1553.167411] Hardware name: HP ProLiant DL380 G7, BIOS P67 08/16/2015
>> [ 1553.167412] task: ffff9d9344b0d800 task.stack: ffffb5cb913b0000
>> [ 1553.167421] RIP: 0010:__blk_recalc_rq_segments+0xec/0x3d0
>> [ 1553.167421] RSP: 0018:ffff9d9377a83d08 EFLAGS: 00000046
>> [ 1553.167422] RAX: 0000000000001000 RBX: 0000000000001000 RCX: 
>> ffff9d91b8e9f500
>> [ 1553.167423] RDX: fffffcd56af20f00 RSI: ffff9d91b8e9f588 RDI: 
>> ffff9d91b8e9f488
>> [ 1553.167424] RBP: ffff9d9377a83d88 R08: 000000000003c000 R09: 
>> 0000000000000001
>> [ 1553.167424] R10: 0000000000000000 R11: 0000000000000000 R12: 
>> 0000000000000000
>> [ 1553.167425] R13: 0000000000000000 R14: 0000000000000000 R15: 
>> 0000000000000003
>> [ 1553.167426] FS:  00007f3061002740(0000) GS:ffff9d9377a80000(0000) 
>> knlGS:0000000000000000
>> [ 1553.167427] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1553.167428] CR2: 00007f305a511000 CR3: 0000000b1bfb2000 CR4: 
>> 00000000000006e0
>> [ 1553.167429] Call Trace:
>> [ 1553.167432]  <IRQ>
>> [ 1553.167437]  ? mempool_free+0x2b/0x80
>> [ 1553.167440]  blk_recalc_rq_segments+0x28/0x40
>> [ 1553.167442]  blk_update_request+0x249/0x310
>> [ 1553.167450]  end_clone_bio+0x46/0x70 [dm_mod]
>> [ 1553.167453]  bio_endio+0xa1/0x120
>> [ 1553.167454]  blk_update_request+0xb7/0x310
>> [ 1553.167457]  scsi_end_request+0x38/0x1d0
>> [ 1553.167458]  scsi_io_completion+0x13c/0x630
>> [ 1553.167460]  scsi_finish_command+0xd9/0x120
>> [ 1553.167462]  scsi_softirq_done+0x12a/0x150
>> [ 1553.167463]  __blk_mq_complete_request_remote+0x13/0x20
>> [ 1553.167466]  flush_smp_call_function_queue+0x52/0x110
>> [ 1553.167468]  generic_smp_call_function_single_interrupt+0x13/0x30
>> [ 1553.167470]  smp_call_function_single_interrupt+0x27/0x40
>> [ 1553.167471]  call_function_single_interrupt+0x93/0xa0
>> [ 1553.167473] RIP: 0010:radix_tree_next_chunk+0xcb/0x2e0
>> [ 1553.167474] RSP: 0018:ffffb5cb913b3a68 EFLAGS: 00000203 ORIG_RAX: 
>> ffffffffffffff04
>> [ 1553.167475] RAX: 0000000000000001 RBX: 0000000000000010 RCX: 
>> ffff9d9e2c556938
>> [ 1553.167476] RDX: ffff9d93053c5919 RSI: 0000000000000001 RDI: 
>> ffff9d9e2c556910
>> [ 1553.167476] RBP: ffffb5cb913b3ab8 R08: ffffb5cb913b3bc0 R09: 
>> 0000000ab7d52000
>> [ 1553.167477] R10: fffffcd56adf5440 R11: 0000000000000000 R12: 
>> 0000000000000230
>> [ 1553.167477] R13: 0000000000000000 R14: 000000000006e0fe R15: 
>> ffff9d9e2c556910
>> [ 1553.167478]  </IRQ>
>> [ 1553.167480]  ? radix_tree_next_chunk+0x10b/0x2e0
>> [ 1553.167481]  find_get_pages_tag+0x149/0x270
>> [ 1553.167485]  ? block_write_full_page+0xcd/0xe0
>> [ 1553.167487]  pagevec_lookup_tag+0x21/0x30
>> [ 1553.167488]  write_cache_pages+0x14c/0x510
>> [ 1553.167490]  ? __wb_calc_thresh+0x140/0x140
>> [ 1553.167492]  generic_writepages+0x51/0x80
>> [ 1553.167493]  blkdev_writepages+0x2f/0x40
>> [ 1553.167494]  do_writepages+0x1c/0x70
>> [ 1553.167495]  __filemap_fdatawrite_range+0xc6/0x100
>> [ 1553.167497]  filemap_write_and_wait+0x3d/0x80
>> [ 1553.167498]  __sync_blockdev+0x1f/0x40
>> [ 1553.167499]  __blkdev_put+0x74/0x200
>> [ 1553.167500]  blkdev_put+0x4c/0xd0
>> [ 1553.167501]  blkdev_close+0x25/0x30
>> [ 1553.167503]  __fput+0xe7/0x210
>> [ 1553.167504]  ____fput+0xe/0x10
>> [ 1553.167508]  task_work_run+0x83/0xb0
>> [ 1553.167511]  exit_to_usermode_loop+0x66/0x98
>> [ 1553.167512]  do_syscall_64+0x13a/0x150
>> [ 1553.167519]  entry_SYSCALL64_slow_path+0x25/0x25
>> [ 1553.167520] RIP: 0033:0x7f3060b25bd0
>> [ 1553.167521] RSP: 002b:00007ffc5e6b12c8 EFLAGS: 00000246 ORIG_RAX: 
>> 0000000000000003
>> [ 1553.167522] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
>> 00007f3060b25bd0
>> [ 1553.167522] RDX: 0000000000400000 RSI: 0000000000000000 RDI: 
>> 0000000000000001
>> [ 1553.167523] RBP: 0000000000000320 R08: ffffffffffffffff R09: 
>> 0000000000402003
>> [ 1553.167524] R10: 00007ffc5e6b1040 R11: 0000000000000246 R12: 
>> 0000000000000320
>> [ 1553.167525] R13: 0000000000000000 R14: 00007ffc5e6b2618 R15: 
>> 00007ffc5e6b1540
>> [ 1553.167526] Code: db 0f 84 92 01 00 00 45 89 f5 45 89 e2 4c 89 ee 
>> 48 c1 e6 04 48 03 71 78 8b 46 08 48 8b 16 44 29 e0 48 89 54 24 30 39 
>> d8 0f 47 c3 <44> 03 56 0c 45 84 db 89 44 24 38 44 89 54 24 3c 0f 85 2a 
>> 01 00
>> [ 1553.167540] Kernel panic - not syncing: Hard LOCKUP
>> [ 1553.167542] CPU: 4 PID: 11532 Comm: dd Tainted: G          I 
>> 4.13.0-rc3lobeming.ming_V4+ #20
>> [ 1553.167542] Hardware name: HP ProLiant DL380 G7, BIOS P67 08/16/2015
>> [ 1553.167543] Call Trace:
>> [ 1553.167543]  <NMI>
>> [ 1553.167545]  dump_stack+0x63/0x87
>> [ 1553.167548]  panic+0xeb/0x245
>> [ 1553.167550]  nmi_panic+0x3f/0x40
>> [ 1553.167553]  watchdog_overflow_callback+0xce/0xf0
>> [ 1553.167556]  __perf_event_overflow+0x54/0xe0
>> [ 1553.167559]  perf_event_overflow+0x14/0x20
>> [ 1553.167562]  intel_pmu_handle_irq+0x203/0x4b0
>> [ 1553.167566]  perf_event_nmi_handler+0x2d/0x50
>> [ 1553.167568]  nmi_handle+0x61/0x110
>> [ 1553.167569]  default_do_nmi+0x44/0x120
>> [ 1553.167571]  do_nmi+0x113/0x190
>> [ 1553.167573]  end_repeat_nmi+0x1a/0x1e
>> [ 1553.167574] RIP: 0010:__blk_recalc_rq_segments+0xec/0x3d0
>> [ 1553.167575] RSP: 0018:ffff9d9377a83d08 EFLAGS: 00000046
>> [ 1553.167576] RAX: 0000000000001000 RBX: 0000000000001000 RCX: 
>> ffff9d91b8e9f500
>> [ 1553.167576] RDX: fffffcd56af20f00 RSI: ffff9d91b8e9f588 RDI: 
>> ffff9d91b8e9f488
>> [ 1553.167577] RBP: ffff9d9377a83d88 R08: 000000000003c000 R09: 
>> 0000000000000001
>> [ 1553.167577] R10: 0000000000000000 R11: 0000000000000000 R12: 
>> 0000000000000000
>> [ 1553.167578] R13: 0000000000000000 R14: 0000000000000000 R15: 
>> 0000000000000003
>> [ 1553.167580]  ? __blk_recalc_rq_segments+0xec/0x3d0
>> [ 1553.167581]  ? __blk_recalc_rq_segments+0xec/0x3d0
>> [ 1553.167582]  </NMI>
>> [ 1553.167582]  <IRQ>
>> [ 1553.167584]  ? mempool_free+0x2b/0x80
>> [ 1553.167585]  blk_recalc_rq_segments+0x28/0x40
>> [ 1553.167586]  blk_update_request+0x249/0x310
>> [ 1553.167590]  end_clone_bio+0x46/0x70 [dm_mod]
>> [ 1553.167592]  bio_endio+0xa1/0x120
>> [ 1553.167593]  blk_update_request+0xb7/0x310
>> [ 1553.167594]  scsi_end_request+0x38/0x1d0
>> [ 1553.167595]  scsi_io_completion+0x13c/0x630
>> [ 1553.167597]  scsi_finish_command+0xd9/0x120
>> [ 1553.167598]  scsi_softirq_done+0x12a/0x150
>> [ 1553.167599]  __blk_mq_complete_request_remote+0x13/0x20
>> [ 1553.167601]  flush_smp_call_function_queue+0x52/0x110
>> [ 1553.167602]  generic_smp_call_function_single_interrupt+0x13/0x30
>> [ 1553.167603]  smp_call_function_single_interrupt+0x27/0x40
>> [ 1553.167604]  call_function_single_interrupt+0x93/0xa0
>> [ 1553.167605] RIP: 0010:radix_tree_next_chunk+0xcb/0x2e0
>> [ 1553.167606] RSP: 0018:ffffb5cb913b3a68 EFLAGS: 00000203 ORIG_RAX: 
>> ffffffffffffff04
>> [ 1553.167607] RAX: 0000000000000001 RBX: 0000000000000010 RCX: 
>> ffff9d9e2c556938
>> [ 1553.167607] RDX: ffff9d93053c5919 RSI: 0000000000000001 RDI: 
>> ffff9d9e2c556910
>> [ 1553.167608] RBP: ffffb5cb913b3ab8 R08: ffffb5cb913b3bc0 R09: 
>> 0000000ab7d52000
>> [ 1553.167609] R10: fffffcd56adf5440 R11: 0000000000000000 R12: 
>> 0000000000000230
>> [ 1553.167609] R13: 0000000000000000 R14: 000000000006e0fe R15: 
>> ffff9d9e2c556910
>> [ 1553.167610]  </IRQ>
>> [ 1553.167611]  ? radix_tree_next_chunk+0x10b/0x2e0
>> [ 1553.167613]  find_get_pages_tag+0x149/0x270
>> [ 1553.167615]  ? block_write_full_page+0xcd/0xe0
>> [ 1553.167616]  pagevec_lookup_tag+0x21/0x30
>> [ 1553.167617]  write_cache_pages+0x14c/0x510
>> [ 1553.167619]  ? __wb_calc_thresh+0x140/0x140
>> [ 1553.167621]  generic_writepages+0x51/0x80
>> [ 1553.167622]  blkdev_writepages+0x2f/0x40
>> [ 1553.167623]  do_writepages+0x1c/0x70
>> [ 1553.167627]  __filemap_fdatawrite_range+0xc6/0x100
>> [ 1553.167629]  filemap_write_and_wait+0x3d/0x80
>> [ 1553.167630]  __sync_blockdev+0x1f/0x40
>> [ 1553.167631]  __blkdev_put+0x74/0x200
>> [ 1553.167632]  blkdev_put+0x4c/0xd0
>> [ 1553.167633]  blkdev_close+0x25/0x30
>> [ 1553.167634]  __fput+0xe7/0x210
>> [ 1553.167635]  ____fput+0xe/0x10
>> [ 1553.167636]  task_work_run+0x83/0xb0
>> [ 1553.167637]  exit_to_usermode_loop+0x66/0x98
>> [ 1553.167638]  do_syscall_64+0x13a/0x150
>> [ 1553.167640]  entry_SYSCALL64_slow_path+0x25/0x25
>> [ 1553.167641] RIP: 0033:0x7f3060b25bd0
>> [ 1553.167641] RSP: 002b:00007ffc5e6b12c8 EFLAGS: 00000246 ORIG_RAX: 
>> 0000000000000003
>> [ 1553.167642] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
>> 00007f3060b25bd0
>> [ 1553.167643] RDX: 0000000000400000 RSI: 0000000000000000 RDI: 
>> 0000000000000001
>> [ 1553.167643] RBP: 0000000000000320 R08: ffffffffffffffff R09: 
>> 0000000000402003
>> [ 1553.167644] R10: 00007ffc5e6b1040 R11: 0000000000000246 R12: 
>> 0000000000000320
>> [ 1553.167645] R13: 0000000000000000 R14: 00007ffc5e6b2618 R15: 
>> 00007ffc5e6b1540
>> [ 1553.167829] Kernel Offset: 0x2f400000 from 0xffffffff81000000 
>> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>> [ 1558.119352] ---[ end Kernel panic - not syncing: Hard LOCKUP
>> [ 1558.151334] sched: Unexpected reschedule of offline CPU#0!
>> [ 1558.151342] ------------[ cut here ]------------
>> [ 1558.151347] WARNING: CPU: 4 PID: 11532 at arch/x86/kernel/smp.c:128 
>> native_smp_send_reschedule+0x3c/0x40
>> [ 1558.151348] Modules linked in: mq_deadline binfmt_misc 
>> dm_round_robin xt_CHECKSUM ipt_MASQUERADE nf_nat_masquerade_ipv4 tun 
>> ip6t_rpfilter ipt_REJECT nf_reject_ipv4 ip6t_REJECT nf_reject_ipv6 
>> xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp 
>> llc ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 rpcrdma 
>> ip6table_mangle ip6table_security ip6table_raw iptable_nat ib_isert 
>> nf_conntrack_ipv4 iscsi_target_mod nf_defrag_ipv4 nf_nat_ipv4 nf_nat 
>> nf_conntrack ib_iser libiscsi scsi_transport_iscsi iptable_mangle 
>> iptable_security iptable_raw ebtable_filter ebtables target_core_mod 
>> ip6table_filter ip6_tables iptable_filter ib_srp scsi_transport_srp 
>> ib_ipoib rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_cm mlx5_ib 
>> ib_core intel_powerclamp coretemp kvm_intel kvm irqbypass 
>> crct10dif_pclmul
>> [ 1558.151363]  crc32_pclmul ghash_clmulni_intel pcbc aesni_intel sg 
>> joydev ipmi_si hpilo crypto_simd hpwdt iTCO_wdt cryptd ipmi_devintf 
>> glue_helper gpio_ich iTCO_vendor_support shpchp ipmi_msghandler pcspkr 
>> acpi_power_meter i7core_edac lpc_ich pcc_cpufreq nfsd auth_rpcgss 
>> nfs_acl lockd grace sunrpc dm_multipath ip_tables xfs libcrc32c sd_mod 
>> amdkfd amd_iommu_v2 radeon i2c_algo_bit drm_kms_helper syscopyarea 
>> sysfillrect sysimgblt fb_sys_fops ttm mlx5_core drm mlxfw i2c_core ptp 
>> serio_raw hpsa crc32c_intel bnx2 pps_core devlink scsi_transport_sas 
>> dm_mirror dm_region_hash dm_log dm_mod [last unloaded: ib_srpt]
>> [ 1558.151377] CPU: 4 PID: 11532 Comm: dd Tainted: G          I 
>> 4.13.0-rc3lobeming.ming_V4+ #20
>> [ 1558.151378] Hardware name: HP ProLiant DL380 G7, BIOS P67 08/16/2015
>> [ 1558.151379] task: ffff9d9344b0d800 task.stack: ffffb5cb913b0000
>> [ 1558.151380] RIP: 0010:native_smp_send_reschedule+0x3c/0x40
>> [ 1558.151381] RSP: 0018:ffff9d9377a856a0 EFLAGS: 00010046
>> [ 1558.151382] RAX: 000000000000002e RBX: 0000000000000000 RCX: 
>> 0000000000000006
>> [ 1558.151383] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
>> ffff9d9377a8e010
>> [ 1558.151383] RBP: ffff9d9377a856a0 R08: 000000000000002e R09: 
>> ffff9d9fa7029552
>> [ 1558.151384] R10: 0000000000000732 R11: 0000000000000000 R12: 
>> ffff9d9377a1bb00
>> [ 1558.151384] R13: ffff9d936ef70000 R14: ffff9d9377a85758 R15: 
>> ffff9d9377a1bb00
>> [ 1558.151385] FS:  00007f3061002740(0000) GS:ffff9d9377a80000(0000) 
>> knlGS:0000000000000000
>> [ 1558.151386] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1558.151387] CR2: 00007f305a511000 CR3: 0000000b1bfb2000 CR4: 
>> 00000000000006e0
>> [ 1558.151387] Call Trace:
>> [ 1558.151388]  <NMI>
>> [ 1558.151391]  resched_curr+0xa1/0xc0
>> [ 1558.151392]  check_preempt_curr+0x79/0x90
>> [ 1558.151393]  ttwu_do_wakeup+0x1e/0x160
>> [ 1558.151395]  ttwu_do_activate+0x7a/0x90
>> [ 1558.151396]  try_to_wake_up+0x1e1/0x470
>> [ 1558.151398]  ? vsnprintf+0x1fa/0x4a0
>> [ 1558.151399]  default_wake_function+0x12/0x20
>> [ 1558.151403]  __wake_up_common+0x55/0x90
>> [ 1558.151405]  __wake_up_locked+0x13/0x20
>> [ 1558.151408]  ep_poll_callback+0xd3/0x2a0
>> [ 1558.151409]  __wake_up_common+0x55/0x90
>> [ 1558.151411]  __wake_up+0x39/0x50
>> [ 1558.151415]  wake_up_klogd_work_func+0x40/0x60
>> [ 1558.151419]  irq_work_run_list+0x4d/0x70
>> [ 1558.151421]  ? tick_sched_do_timer+0x70/0x70
>> [ 1558.151422]  irq_work_tick+0x40/0x50
>> [ 1558.151424]  update_process_times+0x42/0x60
>> [ 1558.151426]  tick_sched_handle+0x2d/0x60
>> [ 1558.151427]  tick_sched_timer+0x39/0x70
>> [ 1558.151428]  __hrtimer_run_queues+0xe5/0x230
>> [ 1558.151429]  hrtimer_interrupt+0xa8/0x1a0
>> [ 1558.151431]  local_apic_timer_interrupt+0x35/0x60
>> [ 1558.151432]  smp_apic_timer_interrupt+0x38/0x50
>> [ 1558.151433]  apic_timer_interrupt+0x93/0xa0
>> [ 1558.151435] RIP: 0010:panic+0x1fa/0x245
>> [ 1558.151435] RSP: 0018:ffff9d9377a85b30 EFLAGS: 00000246 ORIG_RAX: 
>> ffffffffffffff10
>> [ 1558.151436] RAX: 0000000000000030 RBX: ffff9d890c5d0000 RCX: 
>> 0000000000000006
>> [ 1558.151437] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
>> ffff9d9377a8e010
>> [ 1558.151438] RBP: ffff9d9377a85ba0 R08: 0000000000000030 R09: 
>> ffff9d9fa7029514
>> [ 1558.151438] R10: 0000000000000731 R11: 0000000000000000 R12: 
>> ffffffffb0e63f7f
>> [ 1558.151439] R13: 0000000000000000 R14: 0000000000000000 R15: 
>> 0000000000000000
>> [ 1558.151441]  nmi_panic+0x3f/0x40
>> [ 1558.151442]  watchdog_overflow_callback+0xce/0xf0
>> [ 1558.151444]  __perf_event_overflow+0x54/0xe0
>> [ 1558.151445]  perf_event_overflow+0x14/0x20
>> [ 1558.151446]  intel_pmu_handle_irq+0x203/0x4b0
>> [ 1558.151449]  perf_event_nmi_handler+0x2d/0x50
>> [ 1558.151450]  nmi_handle+0x61/0x110
>> [ 1558.151452]  default_do_nmi+0x44/0x120
>> [ 1558.151453]  do_nmi+0x113/0x190
>> [ 1558.151454]  end_repeat_nmi+0x1a/0x1e
>> [ 1558.151456] RIP: 0010:__blk_recalc_rq_segments+0xec/0x3d0
>> [ 1558.151456] RSP: 0018:ffff9d9377a83d08 EFLAGS: 00000046
>> [ 1558.151457] RAX: 0000000000001000 RBX: 0000000000001000 RCX: 
>> ffff9d91b8e9f500
>> [ 1558.151458] RDX: fffffcd56af20f00 RSI: ffff9d91b8e9f588 RDI: 
>> ffff9d91b8e9f488
>> [ 1558.151458] RBP: ffff9d9377a83d88 R08: 000000000003c000 R09: 
>> 0000000000000001
>> [ 1558.151459] R10: 0000000000000000 R11: 0000000000000000 R12: 
>> 0000000000000000
>> [ 1558.151459] R13: 0000000000000000 R14: 0000000000000000 R15: 
>> 0000000000000003
>> [ 1558.151461]  ? __blk_recalc_rq_segments+0xec/0x3d0
>> [ 1558.151463]  ? __blk_recalc_rq_segments+0xec/0x3d0
>> [ 1558.151463]  </NMI>
>> [ 1558.151464]  <IRQ>
>> [ 1558.151465]  ? mempool_free+0x2b/0x80
>> [ 1558.151467]  blk_recalc_rq_segments+0x28/0x40
>> [ 1558.151468]  blk_update_request+0x249/0x310
>> [ 1558.151472]  end_clone_bio+0x46/0x70 [dm_mod]
>> [ 1558.151473]  bio_endio+0xa1/0x120
>> [ 1558.151474]  blk_update_request+0xb7/0x310
>> [ 1558.151476]  scsi_end_request+0x38/0x1d0
>> [ 1558.151477]  scsi_io_completion+0x13c/0x630
>> [ 1558.151478]  scsi_finish_command+0xd9/0x120
>> [ 1558.151480]  scsi_softirq_done+0x12a/0x150
>> [ 1558.151481]  __blk_mq_complete_request_remote+0x13/0x20
>> [ 1558.151483]  flush_smp_call_function_queue+0x52/0x110
>> [ 1558.151484]  generic_smp_call_function_single_interrupt+0x13/0x30
>> [ 1558.151485]  smp_call_function_single_interrupt+0x27/0x40
>> [ 1558.151486]  call_function_single_interrupt+0x93/0xa0
>> [ 1558.151487] RIP: 0010:radix_tree_next_chunk+0xcb/0x2e0
>> [ 1558.151488] RSP: 0018:ffffb5cb913b3a68 EFLAGS: 00000203 ORIG_RAX: 
>> ffffffffffffff04
>> [ 1558.151489] RAX: 0000000000000001 RBX: 0000000000000010 RCX: 
>> ffff9d9e2c556938
>> [ 1558.151490] RDX: ffff9d93053c5919 RSI: 0000000000000001 RDI: 
>> ffff9d9e2c556910
>> [ 1558.151490] RBP: ffffb5cb913b3ab8 R08: ffffb5cb913b3bc0 R09: 
>> 0000000ab7d52000
>> [ 1558.151491] R10: fffffcd56adf5440 R11: 0000000000000000 R12: 
>> 0000000000000230
>> [ 1558.151492] R13: 0000000000000000 R14: 000000000006e0fe R15: 
>> ffff9d9e2c556910
>> [ 1558.151492]  </IRQ>
>> [ 1558.151494]  ? radix_tree_next_chunk+0x10b/0x2e0
>> [ 1558.151496]  find_get_pages_tag+0x149/0x270
>> [ 1558.151497]  ? block_write_full_page+0xcd/0xe0
>> [ 1558.151499]  pagevec_lookup_tag+0x21/0x30
>> [ 1558.151500]  write_cache_pages+0x14c/0x510
>> [ 1558.151502]  ? __wb_calc_thresh+0x140/0x140
>> [ 1558.151504]  generic_writepages+0x51/0x80
>> [ 1558.151505]  blkdev_writepages+0x2f/0x40
>> [ 1558.151506]  do_writepages+0x1c/0x70
>> [ 1558.151507]  __filemap_fdatawrite_range+0xc6/0x100
>> [ 1558.151509]  filemap_write_and_wait+0x3d/0x80
>> [ 1558.151510]  __sync_blockdev+0x1f/0x40
>> [ 1558.151511]  __blkdev_put+0x74/0x200
>> [ 1558.151512]  blkdev_put+0x4c/0xd0
>> [ 1558.151513]  blkdev_close+0x25/0x30
>> [ 1558.151514]  __fput+0xe7/0x210
>> [ 1558.151515]  ____fput+0xe/0x10
>> [ 1558.151517]  task_work_run+0x83/0xb0
>> [ 1558.151518]  exit_to_usermode_loop+0x66/0x98
>> [ 1558.151519]  do_syscall_64+0x13a/0x150
>> [ 1558.151521]  entry_SYSCALL64_slow_path+0x25/0x25
>> [ 1558.151522] RIP: 0033:0x7f3060b25bd0
>> [ 1558.151522] RSP: 002b:00007ffc5e6b12c8 EFLAGS: 00000246 ORIG_RAX: 
>> 0000000000000003
>> [ 1558.151523] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
>> 00007f3060b25bd0
>> [ 1558.151524] RDX: 0000000000400000 RSI: 0000000000000000 RDI: 
>> 0000000000000001
>> [ 1558.151524] RBP: 0000000000000320 R08: ffffffffffffffff R09: 
>> 0000000000402003
>> [ 1558.151525] R10: 00007ffc5e6b1040 R11: 0000000000000246 R12: 
>> 0000000000000320
>> [ 1558.151526] R13: 0000000000000000 R14: 00007ffc5e6b2618 R15: 
>> 00007ffc5e6b1540
>> [ 1558.151527] Code: dc 00 0f 92 c0 84 c0 74 14 48 8b 05 ff 9d a9 00 
>> be fd 00 00 00 ff 90 a0 00 00 00 5d c3 89 fe 48 c7 c7 90 4d e3 b0 e8 
>> c7 db 09 00 <0f> ff 5d c3 66 66 66 66 90 55 48 89 e5 48 83 ec 20 65 48 
>> 8b 04
>> [ 1558.151540] ---[ end trace 408c28f8c132530c ]---
> 
> Replying to my own email:
> 
> Hello Bart
> 
> So with the stock 4.13-RC3 using [none] I get the failing clones but no 
> hard lockup.
> 
> [  526.677611] multipath_clone_and_map: 148 callbacks suppressed
> [  526.707429] device-mapper: multipath: blk_get_request() returned -11 
> - requeuing
> [  527.283432] device-mapper: multipath: blk_get_request() returned -11 
> - requeuing
> [  528.324566] device-mapper: multipath: blk_get_request() returned -11 
> - requeuing
> [  528.367118] device-mapper: multipath: blk_get_request() returned -11 
> - requeuing
> 
> Then on the same  kernel
> modprobe mq-deadline and running with [mq-deadline] on stock upstream I 
> DO not get the clone failures and I don't seem to get hard lockups.
> 
> I will reach out to Ming once I confirm going back to his kernel gets me 
> back into hard lockups again.
> I will also mention to him that we see the clone failure when using his 
> kernel with [mq-deadline]
> 
> Perhaps his enhancements are indeed contributing
> 
> Thanks
> Laurence
> 
> 
> 
> I also intend to test qla2xxx and mq-deadline shortly
> 
> 

Hello Ming

I am able to force the hard lockup with your kernel if wait long enough 
after the blk_get_request() fails in the clone.

I will get a vmcore and do some analysis.

In summary running two dd writes in parallel to two separate dm devices 
with buffered 4MB I/O sizes gets into the hard lockup after a while.

I guess its good we focused more on the clone failure because all of 
your tests were not to the dm device, just to the single device.

My tests are always to the dm device.

I noticed the hard lockup this weekend but thought it was specific to 
the clone issue and not your patches but I can't create the hard lockup 
on stock upstream.

In both kernels I can create the clone failure which seems to recover on 
the upstream stock kernel but of course the requeue means we are throttled.

Thanks
Laurence
