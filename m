Return-Path: <israelr@mellanox.com>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
To: "tj@kernel.org" <tj@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Bart Van Assche
 <Bart.VanAssche@wdc.com>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "hch@lst.de" <hch@lst.de>, "maxg@mellanox.com" <maxg@mellanox.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>
References: <20180410153812.GA3219@ming.t460p>
 <20180410154043.GP3126663@devbig577.frc2.facebook.com>
 <20180410213323.GC793541@devbig577.frc2.facebook.com>
 <d88becef654cde4b5382c1ebddb0aeba963c0578.camel@wdc.com>
 <20180410215456.GD793541@devbig577.frc2.facebook.com>
 <7a586854-33a5-fe3b-6d94-24d305696126@grimberg.me>
 <0da96ded-7bfc-e6a8-428c-1ce1e3db0378@mellanox.com>
 <20180411170733.GM793541@devbig577.frc2.facebook.com>
 <20180411213146.GS793541@devbig577.frc2.facebook.com>
 <0644e6d5-d6a9-420b-b465-4f6ce4466ca5@mellanox.com>
 <20180412133529.GU793541@devbig577.frc2.facebook.com>
From: Israel Rukshin <israelr@mellanox.com>
Message-ID: <0edc1097-3110-f632-a7cb-167ff751aab8@mellanox.com>
Date: Sun, 15 Apr 2018 15:28:32 +0300
MIME-Version: 1.0
In-Reply-To: <20180412133529.GU793541@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Return-Path: israelr@mellanox.com
List-ID: <linux-block@vger.kernel.org>

Hi,

On 4/12/2018 4:35 PM, tj@kernel.org wrote:
> Hello, Israel.
>
> On Thu, Apr 12, 2018 at 11:59:11AM +0300, Israel Rukshin wrote:
>> On 4/12/2018 12:31 AM, tj@kernel.org wrote:
>>> Hey, again.
>>>
>>> On Wed, Apr 11, 2018 at 10:07:33AM -0700, tj@kernel.org wrote:
>>>> Hello, Israel.
>>>>
>>>> On Wed, Apr 11, 2018 at 07:16:14PM +0300, Israel Rukshin wrote:
>>>>>> Just noticed this one, this looks interesting to me as well. Israel,
>>>>>> can you run your test with this patch?
>>>>> Yes, I just did and it looks good.
>>>> Awesome.
>>> Just to be sure, you tested the combined patch and saw the XXX debug
>>> messages, right?
>> I am not sure I understand.
>> What is the combined patch?
>> What are the debug messages that I need to see?
> There are total of three patches and I posted the combined patch + a
> debug message in another post.  Can you please test the following
> patch?  It'll print out something like the following (possibly many of
> them).

I tested this combined patch with your debug print and I got the 
following call trace:

Apr 15 11:42:35 nvme nvme1: I/O 55 QID 10 timeout, reset controller
Apr 15 11:42:35 XXX blk_mq_timeout_reset_cleanup(): executed 1 missed 
completions
Apr 15 11:42:35 XXX blk_mq_timeout_reset_cleanup(): executed 1 missed 
completions
Apr 15 11:42:35 XXX blk_mq_timeout_reset_cleanup(): executed 1 missed 
completions
Apr 15 11:42:35 WARNING: CPU: 1 PID: 648 at block/blk-mq.c:534 
__blk_mq_complete_request+0x154/0x160
Apr 15 11:42:35 Modules linked in: nvme_rdma rdma_cm iw_cm ib_cm 
nvme_fabrics nfsv3 rpcsec_gss_krb5 nfsv4 nfs fscache iscsi_tcp 
libiscsi_tcp libiscsi scsi_transport_iscsi netconsole mlx4_ib ib_core 
mlx4_en mlx4_core xfs libcrc32c dm_mirror dm_region_hash dm_log 
dm_multipath scsi_dh_rdac scsi_dh_emc dm_mod dax scsi_dh_alua 
x86_pkg_temp_thermal coretemp kvm_intel kvm irqbypass 
ghash_clmulni_intel pcbc iTCO_wdt aesni_intel nfsd iTCO_vendor_support 
aes_x86_64 ipmi_si crypto_simd lpc_ich cryptd ipmi_devintf shpchp wmi 
acpi_pad glue_helper ipmi_msghandler pcspkr sg i2c_i801 mfd_core ioatdma 
auth_rpcgss nfs_acl lockd grace sunrpc ip_tables ext4 mbcache jbd2 
sd_mod igb i2c_algo_bit ahci i2c_core xhci_pci crc32c_intel xhci_hcd 
libahci dca configfs nvme nvme_core ipv6 crc_ccitt autofs4 [last 
unloaded: nvme_fabrics]
Apr 15 11:42:35 CPU: 1 PID: 648 Comm: kworker/1:1H Not tainted 4.16.0+ #8
Apr 15 11:42:35 Hardware name: Supermicro SYS-6018R-WTR/X10DRW-i, BIOS 
2.0 12/17/2015
Apr 15 11:42:35 Workqueue: kblockd blk_mq_timeout_work
Apr 15 11:42:35 RIP: 0010:__blk_mq_complete_request+0x154/0x160
Apr 15 11:42:35 RSP: 0018:ffffc9000407bd68 EFLAGS: 00010297
Apr 15 11:42:35 RAX: 0000000000000000 RBX: ffff8808310236c0 RCX: 
0000000000000009
Apr 15 11:42:35 RDX: 0000000000000009 RSI: 0000000000000000 RDI: 
ffff8808310236c0
Apr 15 11:42:35 RBP: ffffe8ffffae12c0 R08: 0000000000000000 R09: 
00000000000004ea
Apr 15 11:42:35 R10: 000000000000006c R11: ffffc90003dfda80 R12: 
0000000000000000
Apr 15 11:42:35 R13: 0000000000000010 R14: 0000000000000010 R15: 
0000000000000000
Apr 15 11:42:35 FS:  0000000000000000(0000) GS:ffff88047fa40000(0000) 
knlGS:0000000000000000
Apr 15 11:42:35 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Apr 15 11:42:35 CR2: 00007f6ab2db3140 CR3: 0000000001e0a006 CR4: 
00000000001606e0
Apr 15 11:42:35 Call Trace:
Apr 15 11:42:35  blk_mq_complete_request+0x4b/0x90
Apr 15 11:42:35  blk_mq_timeout_reset_cleanup+0x27/0x40
Apr 15 11:42:35  bt_iter+0x43/0x50
Apr 15 11:42:35  blk_mq_queue_tag_busy_iter+0xfb/0x230
Apr 15 11:42:35  ? blk_mq_complete_request+0x90/0x90
Apr 15 11:42:35  ? blk_mq_complete_request+0x90/0x90
Apr 15 11:42:35  ? __call_rcu.constprop.72+0x170/0x1c0
Apr 15 11:42:35  blk_mq_timeout_work+0x191/0x1f0
Apr 15 11:42:35  process_one_work+0x140/0x2a0
Apr 15 11:42:35  worker_thread+0x3f/0x3c0
Apr 15 11:42:35  kthread+0xeb/0x120
Apr 15 11:42:35  ? process_one_work+0x2a0/0x2a0
Apr 15 11:42:35  ? kthread_bind+0x10/0x10
Apr 15 11:42:35  ? SyS_exit_group+0xb/0x10
Apr 15 11:42:35  ret_from_fork+0x35/0x40
Apr 15 11:42:35 Code: 00 00 00 00 00 8b 7d 40 e8 0a 20 e7 ff e9 6e ff ff 
ff 48 8b 35 1e ca ba 00 48 83 c7 10 48 83 c6 64 e8 71 ee e5 ff e9 77 ff 
ff ff <0f> 0b e9 c3 fe ff ff 0f 1f 44 00 00 41 54 45 31 e4 55 53 48 8b
Apr 15 11:42:35 ---[ end trace fbf397c4b27ea0b8 ]---
Apr 15 11:42:35 XXX blk_mq_timeout_reset_cleanup(): executed 1 missed 
completions
Apr 15 11:42:35 BUG: unable to handle kernel NULL pointer dereference at 
0000000000000018

Regards,
Israel
