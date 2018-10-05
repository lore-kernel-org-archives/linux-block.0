Return-Path: <bootc@boo.tc>
Subject: Re: Hard lockup in blk_mq_free_request() / wbt_done() / wake_up_all()
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <9788e0e6-a448-bf85-1f41-88f42dc0071d@boo.tc>
 <ac2c7156-f405-4047-564d-816159d5968b@kernel.dk>
 <7080a91c-8d9a-6305-2b67-dc27a374327a@boo.tc>
 <d8ba8949-259a-c0c0-d476-710bcf69c266@kernel.dk>
 <9c444ab8-2e50-c42a-dae1-86954358218e@boo.tc>
 <7dbe184d-5660-7b64-8027-bf4f82625ff2@I-love.SAKURA.ne.jp>
From: Chris Boot <bootc@boo.tc>
Message-ID: <296ff5ef-6d50-d895-2ba2-5c824e96c44b@boo.tc>
Date: Fri, 5 Oct 2018 18:05:06 +0100
MIME-Version: 1.0
In-Reply-To: <7dbe184d-5660-7b64-8027-bf4f82625ff2@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 30/06/2018 14:12, Tetsuo Handa wrote:
> On 2018/06/20 21:45, Chris Boot wrote:
>> Hi Jens,
>>
>> I got an opportunity yesterday to do some testing. I can't get this
>> system to crash with blk-mq disabled, or with blk-mq enabled but wbt
>> disabled. I have a reproducer workload I can launch against the system
>> and it seems to crash reliably with this, but I doubt I can share it
>> with you.
>>
>> I do, however, have a task state dump (SysRq+T) that I managed to get
>> out of the server once it started locking up. It's pretty large, so I
>> uploaded it to my Dropbox for now:
>>
>> https://www.dropbox.com/s/fyo1ab6mmcqk8fq/crash-1.log.gz?dl=0
>>
>> Hope this helps!
> 
> I'm not familiar with block layer, but checking Workqueue entries in SysRq-t.
> blk_mq_timeout_work was stuck at RCU synchronization and wb_workfn was
> stuck at wbt_wait() ?
[snip]
> 
> Impossible to tell whether these threads made progress over time.
> Please try https://akari.osdn.jp/capturing-kernel-messages.html#Tips5 .
> 
> But synchronize_rcu() in blk_mq_timeout_work() seems to be removed by
> commit 12f5b93145450c75 ("blk-mq: Remove generation seqeunce") which went to
> 4.18-rc1. Thus, trying to reproduce with latest linux.git would be helpful.

Hi Tetuso, Jens,

I upgraded the kernel on my affected system to a 4.18.6 kernel (Debian's
4.18.6-1~bpo9+1 in stretch-backports) and ran my test suite again. I'm
sorry to report that the issue occurred once more.

Logs below, it's all I managed to get out of it before my session locked up.

[Oct 5 17:56] INFO: rcu_sched self-detected stall on CPU
[  +0.003914] INFO: rcu_sched detected stalls on CPUs/tasks:
[  +0.001271] 	82-....: (1 GPs behind) idle=47a/0/3 softirq=60148/60149
fqs=2234
[  +0.012840] 	
[  +0.000007] 	82-....: (1 GPs behind) idle=47a/0/3 softirq=60148/60149
fqs=2235
[  +0.000002]  (t=5255 jiffies g=82048 c=82047 q=35803)
[  +0.008936] 	
[  +0.000003] NMI backtrace for cpu 82
[  +0.000005] (detected by 87, t=5257 jiffies, g=82048, c=82047, q=35803)
[  +0.001598] CPU: 82 PID: 0 Comm: swapper/82 Not tainted
4.18.0-0.bpo.1-amd64 #1 Debian 4.18.6-1~bpo9+1
[  +0.000001] Hardware name: Supermicro SYS-8048B-TR4FT/X10QBi, BIOS
3.0a 05/30/2017
[  +0.000001] Call Trace:
[  +0.000004]  <IRQ>
[  +0.000011]  dump_stack+0x5c/0x7b
[  +0.000005]  nmi_cpu_backtrace+0x89/0x90
[  +0.000007]  ? lapic_can_unplug_cpu+0xa0/0xa0
[  +0.000002]  nmi_trigger_cpumask_backtrace+0xf5/0x130
[  +0.000007]  rcu_dump_cpu_stacks+0x9b/0xcb
[  +0.000003]  rcu_check_callbacks+0x79a/0x8e0
[  +0.000007]  ? sched_clock_cpu+0xc/0xa0
[  +0.000005]  ? tick_sched_do_timer+0x60/0x60
[  +0.000005]  update_process_times+0x28/0x50
[  +0.000003]  tick_sched_handle+0x22/0x60
[  +0.000002]  tick_sched_timer+0x37/0x70
[  +0.000002]  __hrtimer_run_queues+0xfc/0x270
[  +0.000003]  hrtimer_interrupt+0x101/0x240
[  +0.000004]  smp_apic_timer_interrupt+0x6a/0x130
[  +0.000002]  apic_timer_interrupt+0xf/0x20
[  +0.000006] RIP: 0010:_raw_spin_unlock_irqrestore+0x11/0x20
[  +0.000001] Code: 8b 00 a8 08 74 0b 65 81 25 d8 6b 11 48 ff ff ff 7f
44 89 e0 5b 5d 41 5c c3 0f 1f 44 00 00 c6 07 00 0f 1f 40 00 48 89 f7 57
9d <0f> 1f 44 00 00 c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 c6 07
[  +0.000030] RSP: 0000:ffff8bfdffc83de8 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff13
[  +0.000002] RAX: 00000000ff72b790 RBX: ffff8bedf5807768 RCX:
dead000000000200
[  +0.000001] RDX: ffffa8cc4fa87410 RSI: 0000000000000202 RDI:
0000000000000202
[  +0.000001] RBP: 00000000ff72b790 R08: ffff8bedf5807770 R09:
000003fffff00000
[  +0.000001] R10: 0000000000000052 R11: 0000000000000001 R12:
0000000000000202
[  +0.000001] R13: 0000000000000003 R14: 0000000000000000 R15:
0000000000000000
[  +0.000001]  ? apic_timer_interrupt+0xa/0x20
[  +0.000006]  __wake_up_common_lock+0x89/0xc0
[  +0.000007]  rwb_wake_all+0x30/0x40
[  +0.000003]  scale_up.part.25+0x24/0x40
[  +0.000002]  wb_timer_fn+0x295/0x430
[  +0.000007]  ? blk_mq_tag_update_depth+0x110/0x110
[  +0.000001]  call_timer_fn+0x2b/0x120
[  +0.000003]  run_timer_softirq+0x1d3/0x410
[  +0.000002]  ? enqueue_hrtimer+0x3a/0x90
[  +0.000002]  ? __hrtimer_run_queues+0x12c/0x270
[  +0.000002]  __do_softirq+0x10d/0x2a6
[  +0.000006]  irq_exit+0xb6/0xc0
[  +0.000003]  smp_apic_timer_interrupt+0x74/0x130
[  +0.000001]  apic_timer_interrupt+0xf/0x20
[  +0.000001]  </IRQ>
[  +0.000008] RIP: 0010:cpuidle_enter_state+0xa7/0x2b0
[  +0.000001] Code: c8 28 48 e8 bb b9 b2 ff 48 89 04 24 0f 1f 44 00 00
31 ff e8 4b c4 b2 ff 80 7c 24 0f 00 0f 85 b6 01 00 00 fb 66 0f 1f 44 00
00 <48> 8b 0c 24 48 ba cf f7 53 e3 a5 9b c4 20 4c 29 f9 48 89 c8 48 c1
[  +0.000028] RSP: 0000:ffffa8cc4c7cbe78 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff13
[  +0.000002] RAX: ffff8bfdffca1b80 RBX: 0000000000000001 RCX:
000000000000001f
[  +0.000001] RDX: 00000237c552d9f0 RSI: 0000000040000219 RDI:
0000000000000000
[  +0.000000] RBP: ffff8bfdffcaaf78 R08: 00000000ffffffff R09:
0000000000000008
[  +0.000001] R10: 00000000000000a9 R11: 00000000000000c2 R12:
ffffffffb88b3a78
[  +0.000001] R13: 0000000000000001 R14: 0000000000000001 R15:
00000237c55130a6
[  +0.000004]  ? cpuidle_enter_state+0x95/0x2b0
[  +0.000004]  do_idle+0x204/0x270
[  +0.000003]  cpu_startup_entry+0x6f/0x80
[  +0.000002]  start_secondary+0x1a4/0x1f0
[  +0.000005]  secondary_startup_64+0xa5/0xb0
[  +0.000058] Sending NMI from CPU 87 to CPUs 82:
[  +0.000163] NMI backtrace for cpu 82
[  +0.000001] CPU: 82 PID: 0 Comm: swapper/82 Not tainted
4.18.0-0.bpo.1-amd64 #1 Debian 4.18.6-1~bpo9+1
[  +0.000000] Hardware name: Supermicro SYS-8048B-TR4FT/X10QBi, BIOS
3.0a 05/30/2017
[  +0.000001] RIP: 0010:try_to_wake_up+0x49/0x4a0
[  +0.000000] Code: 41 89 d5 31 ed 48 83 ec 28 65 48 8b 04 25 28 00 00
00 48 89 44 24 20 31 c0 e8 b3 48 65 00 49 89 c6 48 8b 43 10 41 85 c7 75
30 <4c> 89 f6 4c 89 e7 e8 4c 47 65 00 48 8b 4c 24 20 65 48 33 0c 25 28
[  +0.000014] RSP: 0000:ffff8bfdffc83ab0 EFLAGS: 00000046
[  +0.000001] RAX: 0000000080200000 RBX: ffff8c1b0a3a3b00 RCX:
ffff8c1dfbb3bb00
[  +0.000001] RDX: 0000000000000000 RSI: 0000000000000069 RDI:
ffff8c1b0a3a3b00
[  +0.000000] RBP: 0000000000000001 R08: 0000000000000069 R09:
0000000000000052
[  +0.000001] R10: 0000000000000052 R11: 0000000000000000 R12:
ffff8c1b0a3a424c
[  +0.000001] R13: 0000000000000000 R14: 0000000000000046 R15:
0000000000021b80
[  +0.000001] FS:  0000000000000000(0000) GS:ffff8bfdffc80000(0000)
knlGS:0000000000000000
[  +0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 0000559c8105f094 CR3: 000000260e20a002 CR4:
00000000003606e0
[  +0.000000] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  +0.000001] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  +0.000000] Call Trace:
[  +0.000000]  <IRQ>
[  +0.000001]  autoremove_wake_function+0x11/0x50
[  +0.000000]  __wake_up_common+0x96/0x180
[  +0.000000]  __wake_up_common_lock+0x7c/0xc0
[  +0.000001]  irq_work_run_list+0x50/0x80
[  +0.000000]  ? tick_sched_do_timer+0x60/0x60
[  +0.000001]  update_process_times+0x3b/0x50
[  +0.000000]  tick_sched_handle+0x22/0x60
[  +0.000000]  tick_sched_timer+0x37/0x70
[  +0.000001]  __hrtimer_run_queues+0xfc/0x270
[  +0.000000]  hrtimer_interrupt+0x101/0x240
[  +0.000000]  smp_apic_timer_interrupt+0x6a/0x130
[  +0.000001]  apic_timer_interrupt+0xf/0x20
[  +0.000000] RIP: 0010:_raw_spin_unlock_irqrestore+0x11/0x20
[  +0.000001] Code: 8b 00 a8 08 74 0b 65 81 25 d8 6b 11 48 ff ff ff 7f
44 89 e0 5b 5d 41 5c c3 0f 1f 44 00 00 c6 07 00 0f 1f 40 00 48 89 f7 57
9d <0f> 1f 44 00 00 c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 c6 07
[  +0.000018] RSP: 0000:ffff8bfdffc83de8 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff13
[  +0.000001] RAX: 00000000ff72b790 RBX: ffff8bedf5807768 RCX:
dead000000000200
[  +0.000001] RDX: ffffa8cc4fa87410 RSI: 0000000000000202 RDI:
0000000000000202
[  +0.000000] RBP: 00000000ff72b790 R08: ffff8bedf5807770 R09:
000003fffff00000
[  +0.000001] R10: 0000000000000052 R11: 0000000000000001 R12:
0000000000000202
[  +0.000000] R13: 0000000000000003 R14: 0000000000000000 R15:
0000000000000000
[  +0.000001]  ? apic_timer_interrupt+0xa/0x20
[  +0.000000]  __wake_up_common_lock+0x89/0xc0
[  +0.000000]  rwb_wake_all+0x30/0x40
[  +0.000001]  scale_up.part.25+0x24/0x40
[  +0.000000]  wb_timer_fn+0x295/0x430
[  +0.000000]  ? blk_mq_tag_update_depth+0x110/0x110
[  +0.000001]  call_timer_fn+0x2b/0x120
[  +0.000000]  run_timer_softirq+0x1d3/0x410
[  +0.000001]  ? enqueue_hrtimer+0x3a/0x90
[  +0.000000]  ? __hrtimer_run_queues+0x12c/0x270
[  +0.000000]  __do_softirq+0x10d/0x2a6
[  +0.000001]  irq_exit+0xb6/0xc0
[  +0.000000]  smp_apic_timer_interrupt+0x74/0x130
[  +0.000000]  apic_timer_interrupt+0xf/0x20
[  +0.000001]  </IRQ>
[  +0.000000] RIP: 0010:cpuidle_enter_state+0xa7/0x2b0
[  +0.000000] Code: c8 28 48 e8 bb b9 b2 ff 48 89 04 24 0f 1f 44 00 00
31 ff e8 4b c4 b2 ff 80 7c 24 0f 00 0f 85 b6 01 00 00 fb 66 0f 1f 44 00
00 <48> 8b 0c 24 48 ba cf f7 53 e3 a5 9b c4 20 4c 29 f9 48 89 c8 48 c1
[  +0.000014] RSP: 0000:ffffa8cc4c7cbe78 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff13
[  +0.000001] RAX: ffff8bfdffca1b80 RBX: 0000000000000001 RCX:
000000000000001f
[  +0.000000] RDX: 00000237c552d9f0 RSI: 0000000040000219 RDI:
0000000000000000
[  +0.000001] RBP: ffff8bfdffcaaf78 R08: 00000000ffffffff R09:
0000000000000008
[  +0.000000] R10: 00000000000000a9 R11: 00000000000000c2 R12:
ffffffffb88b3a78
[  +0.000001] R13: 0000000000000001 R14: 0000000000000001 R15:
00000237c55130a6
[  +0.000000]  ? cpuidle_enter_state+0x95/0x2b0
[  +0.000000]  do_idle+0x204/0x270
[  +0.000001]  cpu_startup_entry+0x6f/0x80
[  +0.000000]  start_secondary+0x1a4/0x1f0
[  +0.000001]  secondary_startup_64+0xa5/0xb0
[Oct 5 17:57] watchdog: BUG: soft lockup - CPU#82 stuck for 23s!
[swapper/82:0]
[  +0.007179] Modules linked in: ipt_MASQUERADE nf_conntrack_netlink
nfnetlink xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype iptable_filter xt_conntrack
nf_nat nf_conntrack br_netfilter bridge stp llc overlay nfsv3
rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache bonding intel_rapl
sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel
iTCO_wdt kvm iTCO_vendor_support irqbypass crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel intel_cstate intel_uncore xfs intel_rapl_perf
libcrc32c pcspkr ast ttm drm_kms_helper tpm_tis tpm_tis_core drm tpm
mei_me sg joydev mei i2c_algo_bit ioatdma lpc_ich evdev wmi rng_core
acpi_pad pcc_cpufreq button nfsd auth_rpcgss nfs_acl ipmi_si lockd
ipmi_poweroff grace ipmi_devintf ipmi_msghandler sunrpc ip_tables
x_tables autofs4
[  +0.000066]  ext4 crc16 mbcache jbd2 crc32c_generic fscrypto ecb
dm_mod sd_mod hid_generic usbhid hid crc32c_intel aesni_intel aes_x86_64
crypto_simd cryptd glue_helper nvme nvme_core ahci libahci ehci_pci
ehci_hcd libata megaraid_sas scsi_mod usbcore i2c_i801 ixgbe usb_common
dca mdio
[  +0.000030] CPU: 82 PID: 0 Comm: swapper/82 Not tainted
4.18.0-0.bpo.1-amd64 #1 Debian 4.18.6-1~bpo9+1
[  +0.000001] Hardware name: Supermicro SYS-8048B-TR4FT/X10QBi, BIOS
3.0a 05/30/2017
[  +0.000013] RIP: 0010:_raw_spin_unlock_irqrestore+0x11/0x20
[  +0.000001] Code: 8b 00 a8 08 74 0b 65 81 25 d8 6b 11 48 ff ff ff 7f
44 89 e0 5b 5d 41 5c c3 0f 1f 44 00 00 c6 07 00 0f 1f 40 00 48 89 f7 57
9d <0f> 1f 44 00 00 c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 c6 07
[  +0.000029] RSP: 0000:ffff8bfdffc83de8 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff13
[  +0.000002] RAX: 00000000fec2e7a2 RBX: ffff8bedf5807768 RCX:
dead000000000200
[  +0.000001] RDX: ffffa8cc6028b410 RSI: 0000000000000202 RDI:
0000000000000202
[  +0.000001] RBP: 00000000fec2e7a2 R08: ffff8bedf5807770 R09:
0000000000000052
[  +0.000001] R10: 0000000000000052 R11: 0000000000000001 R12:
0000000000000202
[  +0.000001] R13: 0000000000000003 R14: 0000000000000000 R15:
0000000000000000
[  +0.000002] FS:  0000000000000000(0000) GS:ffff8bfdffc80000(0000)
knlGS:0000000000000000
[  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000002] CR2: 0000559c8105f094 CR3: 000000260e20a002 CR4:
00000000003606e0
[  +0.000001] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  +0.000001] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  +0.000000] Call Trace:
[  +0.000004]  <IRQ>
[  +0.000008]  __wake_up_common_lock+0x89/0xc0
[  +0.000009]  rwb_wake_all+0x30/0x40
[  +0.000003]  scale_up.part.25+0x24/0x40
[  +0.000003]  wb_timer_fn+0x295/0x430
[  +0.000008]  ? blk_mq_tag_update_depth+0x110/0x110
[  +0.000007]  call_timer_fn+0x2b/0x120
[  +0.000003]  run_timer_softirq+0x1d3/0x410
[  +0.000002]  ? enqueue_hrtimer+0x3a/0x90
[  +0.000002]  ? __hrtimer_run_queues+0x12c/0x270
[  +0.000004]  __do_softirq+0x10d/0x2a6
[  +0.000006]  irq_exit+0xb6/0xc0
[  +0.000002]  smp_apic_timer_interrupt+0x74/0x130
[  +0.000003]  apic_timer_interrupt+0xf/0x20
[  +0.000002]  </IRQ>
[  +0.000009] RIP: 0010:cpuidle_enter_state+0xa7/0x2b0
[  +0.000001] Code: c8 28 48 e8 bb b9 b2 ff 48 89 04 24 0f 1f 44 00 00
31 ff e8 4b c4 b2 ff 80 7c 24 0f 00 0f 85 b6 01 00 00 fb 66 0f 1f 44 00
00 <48> 8b 0c 24 48 ba cf f7 53 e3 a5 9b c4 20 4c 29 f9 48 89 c8 48 c1
[  +0.000028] RSP: 0000:ffffa8cc4c7cbe78 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff13
[  +0.000002] RAX: ffff8bfdffca1b80 RBX: 0000000000000001 RCX:
000000000000001f
[  +0.000001] RDX: 00000237c552d9f0 RSI: 0000000040000219 RDI:
0000000000000000
[  +0.000001] RBP: ffff8bfdffcaaf78 R08: 00000000ffffffff R09:
0000000000000008
[  +0.000001] R10: 00000000000000a9 R11: 00000000000000c2 R12:
ffffffffb88b3a78
[  +0.000001] R13: 0000000000000001 R14: 0000000000000001 R15:
00000237c55130a6
[  +0.000004]  ? cpuidle_enter_state+0x95/0x2b0
[  +0.000008]  do_idle+0x204/0x270
[  +0.000003]  cpu_startup_entry+0x6f/0x80
[  +0.000005]  start_secondary+0x1a4/0x1f0
[  +0.000005]  secondary_startup_64+0xa5/0xb0

Message from syslogd@talisker at Oct  5 17:57:15 ...
 kernel:[ 2484.753810] watchdog: BUG: soft lockup - CPU#82 stuck for
23s! [swapper/82:0]
[ +26.628991] INFO: rcu_sched detected stalls on CPUs/tasks:
[  +0.005528] 	44-...0: (1 GPs behind) idle=42e/0/1
softirq=100999/101000 fqs=2209
[  +0.007504] 	(detected by 60, t=5255 jiffies, g=82049, c=82048, q=42045)
[  +0.006727] Sending NMI from CPU 60 to CPUs 44:
[  +0.001017] NMI watchdog: Watchdog detected hard LOCKUP on cpu 44
[  +0.000000] Modules linked in: ipt_MASQUERADE nf_conntrack_netlink
nfnetlink xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype iptable_filter xt_conntrack
nf_nat nf_conntrack br_netfilter bridge stp llc overlay nfsv3
rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache bonding intel_rapl
sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel
iTCO_wdt kvm iTCO_vendor_support irqbypass crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel intel_cstate intel_uncore xfs intel_rapl_perf
libcrc32c pcspkr ast ttm drm_kms_helper tpm_tis tpm_tis_core drm tpm
mei_me sg joydev mei i2c_algo_bit ioatdma lpc_ich evdev wmi rng_core
acpi_pad pcc_cpufreq button nfsd auth_rpcgss nfs_acl ipmi_si lockd
ipmi_poweroff grace ipmi_devintf ipmi_msghandler sunrpc ip_tables
x_tables autofs4
[  +0.000036]  ext4 crc16 mbcache jbd2 crc32c_generic fscrypto ecb
dm_mod sd_mod hid_generic usbhid hid crc32c_intel aesni_intel aes_x86_64
crypto_simd cryptd glue_helper nvme nvme_core ahci libahci ehci_pci
ehci_hcd libata megaraid_sas scsi_mod usbcore i2c_i801 ixgbe usb_common
dca mdio
[  +0.000015] CPU: 44 PID: 0 Comm: swapper/44 Tainted: G             L
  4.18.0-0.bpo.1-amd64 #1 Debian 4.18.6-1~bpo9+1
[  +0.000001] Hardware name: Supermicro SYS-8048B-TR4FT/X10QBi, BIOS
3.0a 05/30/2017
[  +0.000001] RIP: 0010:try_to_wake_up+0x3b4/0x4a0
[  +0.000000] Code: 44 24 0c 0f 84 5a fe ff ff 49 8b 8c 2f 78 09 00 00
48 8b 11 eb 1c f6 c2 08 75 57 48 89 d6 48 89 d0 48 83 ce 08 f0 48 0f b1
31 <48> 39 c2 74 43 48 89 c2 f7 c2 00 00 20 00 75 dc 44 89 c7 44 89 04
[  +0.000022] RSP: 0018:ffff8c1dfee83c88 EFLAGS: 00000046
[  +0.000001] RAX: 0000000080200000 RBX: ffff8bedf328c9c0 RCX:
ffff8c0dfc2d8000
[  +0.000000] RDX: 0000000080200000 RSI: 0000000080200008 RDI:
ffff8bedf328c9f0
[  +0.000001] RBP: ffff8c0dff700000 R08: 0000000000000020 R09:
000000000000002c
[  +0.000000] R10: 000000000000002c R11: 0000000000000001 R12:
ffff8bedf328d10c
[  +0.000000] R13: 0000000000000000 R14: 0000000000000046 R15:
0000000000021b80
[  +0.000001] FS:  0000000000000000(0000) GS:ffff8c1dfee80000(0000)
knlGS:0000000000000000
[  +0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 00007fe833e00810 CR3: 000000260e20a004 CR4:
00000000003606e0
[  +0.000000] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000

Message from syslogd@talisker at Oct  5 17:57:42 ...
 kernel:[ 2511.411044] NMI watchdog: Watchdog detected hard LOCKUP on cpu 44
[  +0.000001] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  +0.000000] Call Trace:
[  +0.000000]  <IRQ>
[  +0.000001]  ? __wake_up_common+0x96/0x180
[  +0.000000]  autoremove_wake_function+0x11/0x50
[  +0.000001]  __wake_up_common+0x96/0x180
[  +0.000000]  __wake_up_common_lock+0x7c/0xc0
[  +0.000000]  wbt_done+0x4b/0x80
[  +0.000001]  blk_mq_free_request+0xae/0x150
[  +0.000000]  scsi_end_request+0x95/0x1e0 [scsi_mod]
[  +0.000000]  scsi_io_completion+0x404/0x6a0 [scsi_mod]
[  +0.000001]  blk_mq_complete_request+0x9c/0x100
[  +0.000000]  complete_cmd_fusion+0x23a/0x4a0 [megaraid_sas]
[  +0.000001]  megasas_isr_fusion+0x36/0x180 [megaraid_sas]
[  +0.000000]  __handle_irq_event_percpu+0x81/0x190
[  +0.000001]  handle_irq_event_percpu+0x30/0x80
[  +0.000000]  handle_irq_event+0x3c/0x60
[  +0.000000]  handle_edge_irq+0x94/0x1f0
[  +0.000001]  handle_irq+0x1f/0x30
[  +0.000000]  do_IRQ+0x49/0xd0
[  +0.000000]  common_interrupt+0xf/0xf
[  +0.000001]  </IRQ>
[  +0.000000] RIP: 0010:cpuidle_enter_state+0xa7/0x2b0
[  +0.000000] Code: c8 28 48 e8 bb b9 b2 ff 48 89 04 24 0f 1f 44 00 00
31 ff e8 4b c4 b2 ff 80 7c 24 0f 00 0f 85 b6 01 00 00 fb 66 0f 1f 44 00
00 <48> 8b 0c 24 48 ba cf f7 53 e3 a5 9b c4 20 4c 29 f9 48 89 c8 48 c1
[  +0.000014] RSP: 0018:ffffa8cc4c69be78 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffffdd
[  +0.000001] RAX: ffff8c1dfeea1b80 RBX: 0000000000000002 RCX:
000000000000001f
[  +0.000001] RDX: 00000243d61ca5da RSI: 0000000040000219 RDI:
0000000000000000
[  +0.000001] RBP: ffff8c1dfeeaaf78 R08: 00000000ffffffff R09:
0000000000000008
[  +0.000000] R10: 00000000000000c0 R11: 00000000000000de R12:
ffffffffb88b3ad8
[  +0.000001] R13: 0000000000000002 R14: 0000000000000002 R15:
00000243d61bae85
[  +0.000000]  ? cpuidle_enter_state+0x95/0x2b0
[  +0.000001]  do_idle+0x204/0x270
[  +0.000000]  cpu_startup_entry+0x6f/0x80
[  +0.000000]  start_secondary+0x1a4/0x1f0
[  +0.000001]  secondary_startup_64+0xa5/0xb0
[  +0.000000] NMI backtrace for cpu 44
[  +0.000001] CPU: 44 PID: 0 Comm: swapper/44 Tainted: G             L
  4.18.0-0.bpo.1-amd64 #1 Debian 4.18.6-1~bpo9+1
[  +0.000000] Hardware name: Supermicro SYS-8048B-TR4FT/X10QBi, BIOS
3.0a 05/30/2017
[  +0.000001] RIP: 0010:__list_del_entry_valid+0x28/0x90
[  +0.000000] Code: 00 00 48 8b 07 48 b9 00 01 00 00 00 00 ad de 48 8b
57 08 48 39 c8 74 26 48 b9 00 02 00 00 00 00 ad de 48 39 ca 74 2b 48 8b
12 <48> 39 d7 75 34 48 8b 50 08 48 39 d7 75 3c b8 01 00 00 00 c3 48 89
[  +0.000013] RSP: 0018:ffff8c1dfee83ce0 EFLAGS: 00000002
[  +0.000001] RAX: ffffa8cc604ef410 RBX: ffffa8cc604db3f8 RCX:
dead000000000200
[  +0.000001] RDX: ffffa8cc604db410 RSI: 0000000000000046 RDI:
ffffa8cc604db410
[  +0.000000] RBP: 0000000000000001 R08: 0000000000000057 R09:
000000000000002c
[  +0.000001] R10: 000000000000002c R11: 0000000000000001 R12:
ffffa8cc604db410
[  +0.000000] R13: ffff8bedf5807770 R14: 0000000000000000 R15:
ffffa8cc604ef3f8
[  +0.000000] FS:  0000000000000000(0000) GS:ffff8c1dfee80000(0000)
knlGS:0000000000000000
[  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000000] CR2: 00007fe833e00810 CR3: 000000260e20a004 CR4:
00000000003606e0
[  +0.000001] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  +0.000000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  +0.000001] Call Trace:
[  +0.000000]  <IRQ>
[  +0.000000]  autoremove_wake_function+0x2a/0x50
[  +0.000001]  __wake_up_common+0x96/0x180
[  +0.000000]  __wake_up_common_lock+0x7c/0xc0
[  +0.000000]  wbt_done+0x4b/0x80
[  +0.000001]  blk_mq_free_request+0xae/0x150
[  +0.000000]  scsi_end_request+0x95/0x1e0 [scsi_mod]
[  +0.000000]  scsi_io_completion+0x404/0x6a0 [scsi_mod]
[  +0.000001]  blk_mq_complete_request+0x9c/0x100
[  +0.000000]  complete_cmd_fusion+0x23a/0x4a0 [megaraid_sas]
[  +0.000001]  megasas_isr_fusion+0x36/0x180 [megaraid_sas]
[  +0.000000]  __handle_irq_event_percpu+0x81/0x190
[  +0.000000]  handle_irq_event_percpu+0x30/0x80
[  +0.000001]  handle_irq_event+0x3c/0x60
[  +0.000000]  handle_edge_irq+0x94/0x1f0
[  +0.000001]  handle_irq+0x1f/0x30
[  +0.000000]  do_IRQ+0x49/0xd0
[  +0.000000]  common_interrupt+0xf/0xf
[  +0.000001]  </IRQ>
[  +0.000000] RIP: 0010:cpuidle_enter_state+0xa7/0x2b0
[  +0.000000] Code: c8 28 48 e8 bb b9 b2 ff 48 89 04 24 0f 1f 44 00 00
31 ff e8 4b c4 b2 ff 80 7c 24 0f 00 0f 85 b6 01 00 00 fb 66 0f 1f 44 00
00 <48> 8b 0c 24 48 ba cf f7 53 e3 a5 9b c4 20 4c 29 f9 48 89 c8 48 c1
[  +0.000014] RSP: 0018:ffffa8cc4c69be78 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffffdd
[  +0.000001] RAX: ffff8c1dfeea1b80 RBX: 0000000000000002 RCX:
000000000000001f
[  +0.000000] RDX: 00000243d61ca5da RSI: 0000000040000219 RDI:
0000000000000000
[  +0.000001] RBP: ffff8c1dfeeaaf78 R08: 00000000ffffffff R09:
0000000000000008
[  +0.000000] R10: 00000000000000c0 R11: 00000000000000de R12:
ffffffffb88b3ad8
[  +0.000001] R13: 0000000000000002 R14: 0000000000000002 R15:
00000243d61bae85
[  +0.000000]  ? cpuidle_enter_state+0x95/0x2b0
[  +0.000001]  do_idle+0x204/0x270
[  +0.000000]  cpu_startup_entry+0x6f/0x80
[  +0.000001]  start_secondary+0x1a4/0x1f0
[  +0.000000]  secondary_startup_64+0xa5/0xb0
[Oct 5 17:58] watchdog: BUG: soft lockup - CPU#99 stuck for 23s!
[sshd:41460]
[  +0.007028] Modules linked in: ipt_MASQUERADE nf_conntrack_netlink
nfnetlink xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype iptable_filter xt_conntrack
nf_nat nf_conntrack br_netfilter bridge stp llc overlay nfsv3
rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache bonding intel_rapl
sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel
iTCO_wdt kvm iTCO_vendor_support irqbypass crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel intel_cstate intel_uncore xfs intel_rapl_perf
libcrc32c pcspkr ast ttm drm_kms_helper tpm_tis tpm_tis_core drm tpm
mei_me sg joydev mei i2c_algo_bit ioatdma lpc_ich evdev wmi rng_core
acpi_pad pcc_cpufreq button nfsd auth_rpcgss nfs_acl ipmi_si lockd
ipmi_poweroff grace ipmi_devintf ipmi_msghandler sunrpc ip_tables
x_tables autofs4
[  +0.000080]  ext4 crc16 mbcache jbd2 crc32c_generic fscrypto ecb
dm_mod sd_mod hid_generic usbhid hid crc32c_intel aesni_intel aes_x86_64
crypto_simd cryptd glue_helper nvme nvme_core ahci libahci ehci_pci
ehci_hcd libata megaraid_sas scsi_mod usbcore i2c_i801 ixgbe usb_common
dca mdio
[  +0.000035] CPU: 99 PID: 41460 Comm: sshd Tainted: G             L
4.18.0-0.bpo.1-amd64 #1 Debian 4.18.6-1~bpo9+1
[  +0.000001] Hardware name: Supermicro SYS-8048B-TR4FT/X10QBi, BIOS
3.0a 05/30/2017
[  +0.000011] RIP: 0010:smp_call_function_many+0x209/0x260
[  +0.000001] Code: a4 5c 00 3b 05 8c 55 01 01 0f 83 7e fe ff ff 48 63
d0 48 8b 0b 48 03 0c d5 00 b7 6c b8 8b 51 18 83 e2 01 74 0a f3 90 8b 51
18 <83> e2 01 75 f6 eb c8 0f b6 4c 24 14 48 83 c4 18 4c 89 ea 5b 4c 89
[  +0.000040] RSP: 0018:ffffa8cc61843c10 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff13
[  +0.000003] RAX: 000000000000002c RBX: ffff8c1dff1e2ac0 RCX:
ffff8c1dfeea7d80
[  +0.000001] RDX: 0000000000000003 RSI: 0000000000000000 RDI:
ffff8c1dff1e2ac8
[  +0.000002] RBP: ffff8c1dff1e2ac8 R08: 0000000000000000 R09:
ffff8c1dff1e2b08
[  +0.000001] R10: ffff8c1dff1e2ac8 R11: ffffa8cc61843d40 R12:
ffffffffb786b200

Message from syslogd@talisker at Oct  5 17:58:15 ...
 kernel:[ 2544.790801] watchdog: BUG: soft lockup - CPU#99 stuck for
23s! [sshd:41460]
[  +0.000001] R13: 0000000000000000 R14: 0000000000000001 R15:
0000000000000200
[  +0.000003] FS:  00007f3e734bed40(0000) GS:ffff8c1dff1c0000(0000)
knlGS:0000000000000000
[  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000002] CR2: 00007f3e71647300 CR3: 0000003b6223e003 CR4:
00000000003606e0
[  +0.000001] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  +0.000002] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  +0.000001] Call Trace:
[  +0.000010]  ? load_new_mm_cr3+0xe0/0xe0
[  +0.000002]  on_each_cpu+0x28/0x60
[  +0.000004]  flush_tlb_kernel_range+0x48/0x90
[  +0.000007]  __purge_vmap_area_lazy+0x4d/0xc0
[  +0.000003]  vm_unmap_aliases+0xf5/0x130
[  +0.000003]  change_page_attr_set_clr+0xcb/0x440
[  +0.000004]  set_memory_ro+0x26/0x30
[  +0.000008]  bpf_prog_select_runtime+0x2d/0x110
[  +0.000006]  bpf_prepare_filter+0x3af/0x3f0
[  +0.000004]  bpf_prog_create_from_user+0xb9/0x110
[  +0.000004]  ? hardlockup_detector_perf_cleanup+0x80/0x80
[  +0.000002]  do_seccomp+0x289/0x6c0
[  +0.000004]  __x64_sys_prctl+0x162/0x4b0
[  +0.000007]  do_syscall_64+0x55/0x110
[  +0.000008]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  +0.000003] RIP: 0033:0x7f3e7164730a
[  +0.000000] Code: 48 8b 0d 91 fb 2a 00 f7 d8 64 89 01 48 83 c8 ff c3
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 9d 00 00 00 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5e fb 2a 00 f7 d8 64 89 01 48
[  +0.000041] RSP: 002b:00007ffdc84f6a58 EFLAGS: 00000246 ORIG_RAX:
000000000000009d
[  +0.000002] RAX: ffffffffffffffda RBX: 00005601c5718da0 RCX:
00007f3e7164730a
[  +0.000001] RDX: 00005601c4d1af50 RSI: 0000000000000002 RDI:
0000000000000016
[  +0.000001] RBP: 00005601c571b590 R08: 0000000000000000 R09:
0000000000000005
[  +0.000002] R10: 00007f3e7164730a R11: 0000000000000246 R12:
0000000000000000
[  +0.000001] R13: 0000000000000016 R14: 0000000000000000 R15:
00007ffdc84f6ea0
[ +27.993133] watchdog: BUG: soft lockup - CPU#99 stuck for 23s!
[sshd:41460]
[  +0.007011] Modules linked in: ipt_MASQUERADE nf_conntrack_netlink
nfnetlink xfrm_user xfrm_algo iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype iptable_filter xt_conntrack
nf_nat nf_conntrack br_netfilter bridge stp llc overlay nfsv3
rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache bonding intel_rapl
sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel
iTCO_wdt kvm iTCO_vendor_support irqbypass crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel intel_cstate intel_uncore xfs intel_rapl_perf
libcrc32c pcspkr ast ttm drm_kms_helper tpm_tis tpm_tis_core drm tpm
mei_me sg joydev mei i2c_algo_bit ioatdma lpc_ich evdev wmi rng_core
acpi_pad pcc_cpufreq button nfsd auth_rpcgss nfs_acl ipmi_si lockd
ipmi_poweroff grace ipmi_devintf ipmi_msghandler sunrpc ip_tables
x_tables autofs4
[  +0.000051]  ext4 crc16 mbcache jbd2 crc32c_generic fscrypto ecb
dm_mod sd_mod hid_generic usbhid hid crc32c_intel aesni_intel aes_x86_64
crypto_simd cryptd glue_helper nvme nvme_core ahci libahci ehci_pci
ehci_hcd libata megaraid_sas scsi_mod usbcore i2c_i801 ixgbe usb_common
dca mdio
[  +0.000024] CPU: 99 PID: 41460 Comm: sshd Tainted: G             L
4.18.0-0.bpo.1-amd64 #1 Debian 4.18.6-1~bpo9+1
[  +0.000002] Hardware name: Supermicro SYS-8048B-TR4FT/X10QBi, BIOS
3.0a 05/30/2017
[  +0.000004] RIP: 0010:smp_call_function_many+0x209/0x260

Message from syslogd@talisker at Oct  5 17:58:43 ...
 kernel:[ 2572.791275] watchdog: BUG: soft lockup - CPU#99 stuck for
23s! [sshd:41460]
[  +0.000000] Code: a4 5c 00 3b 05 8c 55 01 01 0f 83 7e fe ff ff 48 63
d0 48 8b 0b 48 03 0c d5 00 b7 6c b8 8b 51 18 83 e2 01 74 0a f3 90 8b 51
18 <83> e2 01 75 f6 eb c8 0f b6 4c 24 14 48 83 c4 18 4c 89 ea 5b 4c 89
[  +0.000041] RSP: 0018:ffffa8cc61843c10 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff13
[  +0.000003] RAX: 000000000000002c RBX: ffff8c1dff1e2ac0 RCX:
ffff8c1dfeea7d80
[  +0.000001] RDX: 0000000000000003 RSI: 0000000000000000 RDI:
ffff8c1dff1e2ac8
[  +0.000001] RBP: ffff8c1dff1e2ac8 R08: 0000000000000000 R09:
ffff8c1dff1e2b08
[  +0.000001] R10: ffff8c1dff1e2ac8 R11: ffffa8cc61843d40 R12:
ffffffffb786b200
[  +0.000000] R13: 0000000000000000 R14: 0000000000000001 R15:
0000000000000200
[  +0.000002] FS:  00007f3e734bed40(0000) GS:ffff8c1dff1c0000(0000)
knlGS:0000000000000000
[  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 00007f3e71647300 CR3: 0000003b6223e003 CR4:
00000000003606e0
[  +0.000001] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  +0.000001] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  +0.000001] Call Trace:
[  +0.000004]  ? load_new_mm_cr3+0xe0/0xe0
[  +0.000002]  on_each_cpu+0x28/0x60
[  +0.000002]  flush_tlb_kernel_range+0x48/0x90
[  +0.000004]  __purge_vmap_area_lazy+0x4d/0xc0
[  +0.000002]  vm_unmap_aliases+0xf5/0x130
[  +0.000002]  change_page_attr_set_clr+0xcb/0x440
[  +0.000003]  set_memory_ro+0x26/0x30
[  +0.000003]  bpf_prog_select_runtime+0x2d/0x110
[  +0.000003]  bpf_prepare_filter+0x3af/0x3f0
[  +0.000003]  bpf_prog_create_from_user+0xb9/0x110
[  +0.000003]  ? hardlockup_detector_perf_cleanup+0x80/0x80
[  +0.000002]  do_seccomp+0x289/0x6c0
[  +0.000003]  __x64_sys_prctl+0x162/0x4b0
[  +0.000003]  do_syscall_64+0x55/0x110
[  +0.000003]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  +0.000002] RIP: 0033:0x7f3e7164730a
[  +0.000001] Code: 48 8b 0d 91 fb 2a 00 f7 d8 64 89 01 48 83 c8 ff c3
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 9d 00 00 00 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5e fb 2a 00 f7 d8 64 89 01 48
[  +0.000040] RSP: 002b:00007ffdc84f6a58 EFLAGS: 00000246 ORIG_RAX:
000000000000009d
[  +0.000002] RAX: ffffffffffffffda RBX: 00005601c5718da0 RCX:
00007f3e7164730a
[  +0.000002] RDX: 00005601c4d1af50 RSI: 0000000000000002 RDI:
0000000000000016
[  +0.000001] RBP: 00005601c571b590 R08: 0000000000000000 R09:
0000000000000005
[  +0.000001] R10: 00007f3e7164730a R11: 0000000000000246 R12:
0000000000000000
[  +0.000002] R13: 0000000000000016 R14: 0000000000000000 R15:
00007ffdc84f6ea0
[  +1.612805] INFO: rcu_sched detected stalls on CPUs/tasks:
[  +0.005546] 	44-...0: (1 GPs behind) idle=42e/0/1
softirq=100999/101000 fqs=8947
[  +0.007499] 	(detected by 62, t=21010 jiffies, g=82049, c=82048, q=45933)
[  +0.006817] Sending NMI from CPU 62 to CPUs 44:
[  +0.001015] NMI backtrace for cpu 44
[  +0.000001] CPU: 44 PID: 0 Comm: swapper/44 Tainted: G             L
  4.18.0-0.bpo.1-amd64 #1 Debian 4.18.6-1~bpo9+1
[  +0.000000] Hardware name: Supermicro SYS-8048B-TR4FT/X10QBi, BIOS
3.0a 05/30/2017
[  +0.000001] RIP: 0010:enqueue_task_fair+0x73/0x850
[  +0.000000] Code: 01 00 00 f6 83 88 04 00 00 02 0f 85 4d 07 00 00 48
85 ed 74 4a 44 8b 93 c0 00 00 00 45 85 d2 74 14 e9 8a 00 00 00 44 8b 4d
40 <41> bc 01 00 00 00 45 85 c9 75 7b 48 8b 9d 58 01 00 00 44 89 e2 48
[  +0.000015] RSP: 0018:ffff8c1dfee83bf0 EFLAGS: 00000086
[  +0.000001] RAX: 0000000000000000 RBX: ffff8c1df8c3d200 RCX:
0000000000000000
[  +0.000001] RDX: 0000000000000001 RSI: ffff8c1df8c3d230 RDI:
ffff8c1353b45918
[  +0.000000] RBP: ffff8c1df8c3ce00 R08: ffff8c1353b45900 R09:
0000000000000001
[  +0.000001] R10: 000000000000031f R11: 0000000000000001 R12:
0000000000000009
[  +0.000000] R13: ffffffffb7d81220 R14: 0000000000000046 R15:
0000000000021b80
[  +0.000001] FS:  0000000000000000(0000) GS:ffff8c1dfee80000(0000)
knlGS:0000000000000000
[  +0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000001] CR2: 00007fe833e00810 CR3: 000000260e20a004 CR4:
00000000003606e0
[  +0.000000] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  +0.000001] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  +0.000000] Call Trace:
[  +0.000000]  <IRQ>
[  +0.000001]  ? check_preempt_wakeup+0x103/0x250
[  +0.000000]  ttwu_do_activate+0x44/0x80
[  +0.000000]  try_to_wake_up+0x1ce/0x4a0
[  +0.000001]  ? __wake_up_common+0x96/0x180
[  +0.000000]  autoremove_wake_function+0x11/0x50
[  +0.000001]  __wake_up_common+0x96/0x180
[  +0.000000]  __wake_up_common_lock+0x7c/0xc0
[  +0.000000]  wbt_done+0x4b/0x80
[  +0.000001]  blk_mq_free_request+0xae/0x150
[  +0.000000]  scsi_end_request+0x95/0x1e0 [scsi_mod]
[  +0.000001]  scsi_io_completion+0x404/0x6a0 [scsi_mod]
[  +0.000000]  blk_mq_complete_request+0x9c/0x100
[  +0.000000]  complete_cmd_fusion+0x23a/0x4a0 [megaraid_sas]
[  +0.000001]  megasas_isr_fusion+0x36/0x180 [megaraid_sas]
[  +0.000000]  __handle_irq_event_percpu+0x81/0x190
[  +0.000000]  handle_irq_event_percpu+0x30/0x80
[  +0.000001]  handle_irq_event+0x3c/0x60
[  +0.000000]  handle_edge_irq+0x94/0x1f0
[  +0.000001]  handle_irq+0x1f/0x30
[  +0.000000]  do_IRQ+0x49/0xd0
[  +0.000000]  common_interrupt+0xf/0xf
[  +0.000001]  </IRQ>
[  +0.000000] RIP: 0010:cpuidle_enter_state+0xa7/0x2b0
[  +0.000000] Code: c8 28 48 e8 bb b9 b2 ff 48 89 04 24 0f 1f 44 00 00
31 ff e8 4b c4 b2 ff 80 7c 24 0f 00 0f 85 b6 01 00 00 fb 66 0f 1f 44 00
00 <48> 8b 0c 24 48 ba cf f7 53 e3 a5 9b c4 20 4c 29 f9 48 89 c8 48 c1
[  +0.000014] RSP: 0018:ffffa8cc4c69be78 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffffdd
[  +0.000001] RAX: ffff8c1dfeea1b80 RBX: 0000000000000002 RCX:
000000000000001f
[  +0.000001] RDX: 00000243d61ca5da RSI: 0000000040000219 RDI:
0000000000000000
[  +0.000000] RBP: ffff8c1dfeeaaf78 R08: 00000000ffffffff R09:
0000000000000008
[  +0.000001] R10: 00000000000000c0 R11: 00000000000000de R12:
ffffffffb88b3ad8
[  +0.000000] R13: 0000000000000002 R14: 0000000000000002 R15:
00000243d61bae85
[  +0.000001]  ? cpuidle_enter_state+0x95/0x2b0
[  +0.000000]  do_idle+0x204/0x270
[  +0.000000]  cpu_startup_entry+0x6f/0x80
[  +0.000001]  start_secondary+0x1a4/0x1f0
[  +0.000000]  secondary_startup_64+0xa5/0xb0

-- 
Chris Boot
bootc@boo.tc
