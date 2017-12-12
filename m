Return-Path: <adi@ddns.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 12 Dec 2017 12:11:48 +1100
From: Adi Pircalabu <adi@ddns.com.au>
To: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Xen PV DomU running Kernel 4.14.5-1.el7.elrepo.x86_64: xl -v vcpu-set
 <domU> <val> triggers domU kernel WARNING, then domU becomes unresponsive
Message-ID: <4b306e4f1c79ad48c4290ddd02cd3d27@ddns.com.au>
List-ID: <linux-block@vger.kernel.org>

Hi, first of all, I'm not subscribed to the linux-block@ list. Running 
"xl -v vcpu-set <domU> <val>" in Dom0 triggers the warning below, then a 
number of commands like top or ls stall. The only domU recovery solution 
is to terminate it immediately using "xl destroy".

I couldn't replicate it on:
- CentOS 6 running kernel-2.6.32-696.16.1.el6.x86_64, 
kernel-lt-4.4.105-1.el6.elrepo.x86_64
- CentOS 7 running 4.9.67-1.el7.centos.x86_64

But I can replicate it consistently on:
- CentOS 6 running 4.14.5-1.el6.elrepo.x86_64
- CentOS 7 running 4.14.5-1.el7.elrepo.x86_64

dom0 versions tested with similar results in the domU:
- 4.6.6-6.el7 on kernel 4.9.63-29.el7.x86_64
- 4.6.3-15.el6 on kernel 4.9.37-29.el6.x86_64

Noticed behaviour:
- These commands stall:
top
ls -l /var/tmp
ls -l /tmp
- Stuck in D state on the CentOS 7 domU:
root         5  0.0  0.0      0     0 ?        D    11:20   0:00 
[kworker/u8:0]
root       316  0.0  0.0      0     0 ?        D    11:20   0:00 
[jbd2/xvda1-8]
root      1145  0.0  0.2 116636  4776 ?        Ds   11:20   0:00 -bash
root      1289  0.0  0.1  25852  2420 ?        Ds   11:35   0:00 
/usr/bin/systemd-tmpfiles --clean
root      1290  0.0  0.1 125248  2696 pts/1    D+   11:44   0:00 ls 
--color=auto -l /tmp/
root      1293  0.0  0.1 125248  2568 pts/2    D+   11:44   0:00 ls 
--color=auto -l /var/tmp
root      1296  0.0  0.2 116636  4908 pts/3    Ds+  11:44   0:00 -bash
root      1358  0.0  0.1 125248  2612 pts/4    D+   11:47   0:00 ls 
--color=auto -l /var/tmp

At a first glance it appears the issue is the domU kernel. Stack traces 
follow:

-----CentOS 6 kernel-ml-4.14.5-1.el6.elrepo.x86_64 start here-----
------------[ cut here ]------------
WARNING: CPU: 4 PID: 60 at block/blk-mq.c:1144 
__blk_mq_run_hw_queue+0x9e/0xc0
Modules linked in: intel_cstate(-) ipt_REJECT nf_reject_ipv4 
nf_conntrack_ipv4 nf_defrag_ipv4 xt_multiport iptable_filter ip_tables 
ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 xt_state 
nf_conntrack libcrc32c ip6table_filter ip6_tables dm_mod dax 
xen_netfront crc32_pclmul crct10dif_pclmul ghash_clmulni_intel 
crc32c_intel pcbc aesni_intel glue_helper crypto_simd cryptd aes_x86_64 
coretemp hwmon x86_pkg_temp_thermal sb_edac intel_rapl_perf pcspkr ext4 
jbd2 mbcache xen_blkfront
CPU: 4 PID: 60 Comm: kworker/4:1H Not tainted 4.14.5-1.el6.elrepo.x86_64 
#1
Workqueue: kblockd blk_mq_run_work_fn
task: ffff8802711a2780 task.stack: ffffc90041af4000
RIP: e030:__blk_mq_run_hw_queue+0x9e/0xc0
RSP: e02b:ffffc90041af7c48 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff88027117fa80 RCX: 0000000000000001
RDX: ffff88026b053ee0 RSI: ffff88027351bca0 RDI: ffff88026b072800
RBP: ffffc90041af7c68 R08: ffffc90041af7eb8 R09: ffff8802711a2810
R10: 0000000000007ff0 R11: 0000000000000001 R12: ffff88026b072800
R13: ffffe8ffffd04d00 R14: 0000000000000000 R15: ffffe8ffffd04d05
FS:  00002b7b7c89b700(0000) GS:ffff880273500000(0000) 
knlGS:0000000000000000
CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 000000026d953000 CR4: 0000000000042660
Call Trace:
  blk_mq_run_work_fn+0x31/0x40
  process_one_work+0x174/0x440
  ? xen_mc_flush+0xad/0x1b0
  ? schedule+0x3a/0xa0
  worker_thread+0x6b/0x410
  ? default_wake_function+0x12/0x20
  ? __wake_up_common+0x84/0x130
  ? maybe_create_worker+0x120/0x120
  ? schedule+0x3a/0xa0
  ? _raw_spin_unlock_irqrestore+0x16/0x20
  ? maybe_create_worker+0x120/0x120
  kthread+0x111/0x150
  ? __kthread_init_worker+0x40/0x40
  ret_from_fork+0x25/0x30
Code: 89 df e8 06 2f d9 ff 4c 89 e7 41 89 c5 e8 0b 6e 00 00 44 89 ee 48 
89 df e8 20 2f d9 ff 48 8b 5d e8 4c 8b 65 f0 4c 8b 6d f8 c9 c3 <0f> ff 
eb aa 4c 89 e7 e8 e6 6d 00 00 48 8b 5d e8 4c 8b 65 f0 4c
---[ end trace fe2aaf4e723042fd ]---
-----CentOS 6 kernel-ml-4.14.5-1.el6.elrepo.x86_64 end here-----

-----CentOS 7 kernel-ml-4.14.5-1.el7.elrepo.x86_64 start here-----
[  116.528885] ------------[ cut here ]------------
[  116.528894] WARNING: CPU: 3 PID: 38 at block/blk-mq.c:1144 
__blk_mq_run_hw_queue+0x89/0xa0
[  116.528898] Modules linked in: intel_cstate(-) ip_set_hash_ip ip_set 
nfnetlink x86_pkg_temp_thermal coretemp crct10dif_pclmul crc32_pclmul 
ghash_clmulni_intel pcbc aesni_intel crypto_simd glue_helper cryptd 
intel_rapl_perf pcspkr nfsd auth_rpcgss nfs_acl lockd grace sunrpc 
ip_tables ext4 mbcache jbd2 xen_netfront xen_blkfront crc32c_intel
[  116.528919] CPU: 3 PID: 38 Comm: kworker/3:1H Not tainted 
4.14.5-1.el7.elrepo.x86_64 #1
[  116.529007] Code: 00 e8 7c c5 45 00 4c 89 e7 e8 14 4b d7 ff 48 89 df 
41 89 c5 e8 19 66 00 00 44 89 ee 4c 89 e7 e8 2e 4b d7 ff 5b 41 5c 41 5d 
5d c3 <0f> ff eb b4 48 89 df e8 fb 65 00 00 5b 41 5c 41 5d 5d c3 0f ff
[  116.529034] ---[ end trace a7814e3ec9a330c6 ]---
[  147.424117] ------------[ cut here ]------------
[  147.424150] WARNING: CPU: 2 PID: 24 at block/blk-mq.c:1144 
__blk_mq_run_hw_queue+0x89/0xa0
[  147.424160] Modules linked in: ip_set_hash_ip ip_set nfnetlink 
x86_pkg_temp_thermal coretemp crct10dif_pclmul crc32_pclmul 
ghash_clmulni_intel pcbc aesni_intel crypto_simd glue_helper cryptd 
intel_rapl_perf pcspkr nfsd auth_rpcgss nfs_acl lockd grace sunrpc 
ip_tables ext4 mbcache jbd2 xen_netfront xen_blkfront crc32c_intel
[  147.424222] CPU: 2 PID: 24 Comm: kworker/2:0H Tainted: G        W     
   4.14.5-1.el7.elrepo.x86_64 #1
[  147.424238] Workqueue: kblockd blk_mq_run_work_fn
[  147.424247] task: ffff88007c539840 task.stack: ffffc900403e4000
[  147.424259] RIP: e030:__blk_mq_run_hw_queue+0x89/0xa0
[  147.424270] RSP: e02b:ffffc900403e7e30 EFLAGS: 00010202
[  147.424279] RAX: 0000000000000001 RBX: ffff880003b83800 RCX: 
ffff88007d11bca0
[  147.424288] RDX: ffff88007c656c88 RSI: 00000000000000a0 RDI: 
ffff880003b83800
[  147.424298] RBP: ffffc900403e7e48 R08: 0000000000000000 R09: 
0000000000000000
[  147.424309] R10: 0000000000007ff0 R11: 00000000000074e5 R12: 
ffff88007c436900
[  147.424319] R13: ffff88007d11bc80 R14: ffff88007d121b00 R15: 
ffff880003b83848
[  147.424340] FS:  0000000000000000(0000) GS:ffff88007d100000(0000) 
knlGS:ffff88007d100000
[  147.424350] CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
[  147.424359] CR2: 00007f504f19a700 CR3: 0000000079bed000 CR4: 
0000000000042660
[  147.424370] Call Trace:
[  147.424384]  blk_mq_run_work_fn+0x2c/0x30
[  147.424400]  process_one_work+0x149/0x360
[  147.424411]  worker_thread+0x4d/0x3e0
[  147.424421]  kthread+0x109/0x140
[  147.424432]  ? rescuer_thread+0x380/0x380
[  147.424441]  ? kthread_park+0x60/0x60
[  147.424455]  ret_from_fork+0x25/0x30
[  147.424463] Code: 00 e8 7c c5 45 00 4c 89 e7 e8 14 4b d7 ff 48 89 df 
41 89 c5 e8 19 66 00 00 44 89 ee 4c 89 e7 e8 2e 4b d7 ff 5b 41 5c 41 5d 
5d c3 <0f> ff eb b4 48 89 df e8 fb 65 00 00 5b 41 5c 41 5d 5d c3 0f ff
[  147.424554] ---[ end trace a7814e3ec9a330c7 ]---
-----CentOS 7 kernel-ml-4.14.5-1.el7.elrepo.x86_64 end here-----

-- 
Adi Pircalabu
