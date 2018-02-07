Return-Path: <efault@gmx.de>
Message-ID: <1517999473.6606.3.camel@gmx.de>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>, Jens Axboe
 <axboe@kernel.dk>,  linux-block <linux-block@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,  Ulf Hansson
 <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, 'Paolo Valente' via bfq-iosched
 <bfq-iosched@googlegroups.com>, Alban Browaeys <alban.browaeys@gmail.com>,
 Ming Lei <ming.lei@redhat.com>, Ivan Kozik <ivan@ludios.org>, SERENA
 ZIVIANI <169364@studenti.unimore.it>, Serena Ziviani
 <ziviani.serena@gmail.com>,  Holger =?ISO-8859-1?Q?Hoffst=E4tte?=
 <holger@applied-asynchrony.com>
Date: Wed, 07 Feb 2018 11:31:13 +0100
In-Reply-To: <5584030F-8F4E-4C98-84A5-79873A1BF775@linaro.org>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
	 <20180205190510.5499-2-paolo.valente@linaro.org>
	 <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
	 <1517903761.9843.12.camel@gmx.de>
	 <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
	 <1517918234.25841.31.camel@gmx.de>
	 <77124223e6116350a5184a5199850304@natalenko.name>
	 <1517924768.25841.32.camel@gmx.de>
	 <8842084cc8a26b7f46ae600bda8a7bd0@natalenko.name>
	 <CC8CDDA5-A232-41A6-BE1E-CDB0B361C3DB@linaro.org>
	 <82ffc96aacc3945861cbb708df346338@natalenko.name>
	 <E52CCDEA-279A-40D8-AD9B-F4D1AF351BF1@linaro.org>
	 <1517995431.25619.5.camel@gmx.de>
	 <FBF6DCBB-B0F5-446B-8FD1-106E2538A9C1@linaro.org>
	 <1517998516.6606.1.camel@gmx.de>
	 <5584030F-8F4E-4C98-84A5-79873A1BF775@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-02-07 at 11:27 +0100, Paolo Valente wrote:
> 
> 1. Could you paste a stack trace for this OOPS, just to understand how we
> get there?

[  442.421058] kernel BUG at block/bfq-iosched.c:4742!
[  442.421762] invalid opcode: 0000 [#1] SMP PTI
[  442.422436] Dumping ftrace buffer:
[  442.423116]    (ftrace buffer empty)
[  442.423785] Modules linked in: fuse(E) ebtable_filter(E) ebtables(E) af_packet(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) nf_conntrack_ipv6(E) nf_defrag_ipv6(E) ipt_REJECT(E) xt_tcpudp(E) iptable_filter(E) ip6table_>
[  442.426685]  pcbc(E) iTCO_wdt(E) aesni_intel(E) aes_x86_64(E) iTCO_vendor_support(E) crypto_simd(E) glue_helper(E) mei_me(E) i2c_i801(E) r8169(E) cryptd(E) lpc_ich(E) mfd_core(E) mii(E) mei(E) soundcore(E) pcspkr(E) shpchp(E) thermal>
[  442.429634]  dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) efivarfs(E) autofs4(E)
[  442.430166] CPU: 2 PID: 489 Comm: kworker/2:1H Tainted: G            E    4.15.0.ga2e5790-master #612
[  442.430675] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[  442.431195] Workqueue: kblockd blk_mq_requeue_work
[  442.431706] RIP: 0010:bfq_only_requeue_request+0xd1/0xe0
[  442.432221] RSP: 0018:ffff8803f7b8fcc0 EFLAGS: 00010246
[  442.432733] RAX: 0000000000002090 RBX: ffff8803dbda2580 RCX: 0000000000000000
[  442.433250] RDX: ffff8803fa3c8000 RSI: 0000000000000004 RDI: ffff8803dbda2580
[  442.433778] RBP: ffff8803f9ec85d0 R08: ffff8803fa3c81c0 R09: 0000000000000000
[  442.434296] R10: ffff8803fa3c81d0 R11: 0000000000001000 R12: ffff8803dbda2600
[  442.434815] R13: 000000000000000d R14: 0000000000000000 R15: ffff8803f7b8fd88
[  442.435334] FS:  0000000000000000(0000) GS:ffff88041ec80000(0000) knlGS:0000000000000000
[  442.435863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  442.436381] CR2: 00007f00e001e198 CR3: 0000000001e0a002 CR4: 00000000001606e0
[  442.436909] Call Trace:
[  442.437445]  __blk_mq_requeue_request+0x8f/0x120
[  442.437980]  blk_mq_dispatch_rq_list+0x342/0x550
[  442.438506]  ? kyber_dispatch_request+0xd0/0xd0
[  442.439041]  blk_mq_sched_dispatch_requests+0xf7/0x180
[  442.439568]  __blk_mq_run_hw_queue+0x58/0xd0
[  442.440103]  __blk_mq_delay_run_hw_queue+0x99/0xa0
[  442.440628]  blk_mq_run_hw_queue+0x54/0xf0
[  442.441157]  blk_mq_run_hw_queues+0x4b/0x60
[  442.441822]  blk_mq_requeue_work+0x13a/0x150
[  442.442518]  process_one_work+0x147/0x350
[  442.443205]  worker_thread+0x47/0x3e0
[  442.443887]  kthread+0xf8/0x130
[  442.444579]  ? rescuer_thread+0x360/0x360
[  442.445264]  ? kthread_stop+0x120/0x120
[  442.445965]  ? do_syscall_64+0x75/0x1a0
[  442.446651]  ? SyS_exit_group+0x10/0x10
[  442.447340]  ret_from_fork+0x35/0x40
[  442.448023] Code: ff 4c 89 f6 4c 89 ef e8 be ec 2e 00 48 c7 83 80 00 00 00 00 00 00 00 48 c7 83 88 00 00 00 00 00 00 00 5b 5d 41 5c 41 5d 41 5e c3 <0f> 0b 0f 0b 0f 0b 0f 0b 0f 1f 80 00 00 00 00 0f 1f 44 00 00 41
[  442.448668] RIP: bfq_only_requeue_request+0xd1/0xe0 RSP: ffff8803f7b8fcc0
