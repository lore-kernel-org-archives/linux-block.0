Return-Path: <prvs=80595d6f51=shli@fb.com>
Date: Thu, 8 Sep 2016 10:33:29 -0700
From: Shaohua Li <shli@fb.com>
To: Jens Axboe <axboe@kernel.dk>
CC: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: kernel 4.8-rc5 kernel BUG at block/blk-core.c:2032!
Message-ID: <20160908173328.GA58334@shli-mbp.local>
References: <56e78c6a-5996-d106-2952-d985ceca9e34@profihost.ag>
 <7ad7efe2-ef46-e1d5-bb0d-c7ed0e8d47db@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <7ad7efe2-ef46-e1d5-bb0d-c7ed0e8d47db@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 08, 2016 at 10:16:59AM -0600, Jens Axboe wrote:
> On 09/08/2016 02:23 AM, Stefan Priebe - Profihost AG wrote:
> > Hi,
> > 
> > while trying Kernel 4.8-rc5 my raid5 breaks every few minutes.
> > 
> > Trace:
> > ------------[ cut here ]------------
> > kernel BUG at block/blk-core.c:2032!
> > invalid opcode: 0000 [#1] SMP
> > Modules linked in: netconsole ipt_REJECT nf_reject_ipv4 xt_multiport
> > iptable_filter ip_tables x_tables 8021q garp bonding sb_edac edac_core
> > x86_pkg_temp_thermal coretemp kvm_intel kvm i2c_i801 irqbypass i2c_smbus
> > ipmi_si crc32_pclmul i2c_core ghash_clmulni_intel shpchp ipmi_msghandler
> > button loop fuse btrfs dm_mod raid10 raid0 multipath linear raid456
> > async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq
> > raid1 md_mod sg sd_mod ixgbe i40e mdio usbhid ehci_pci ehci_hcd ahci
> > usbcore ptp libahci usb_common megaraid_sas pps_core
> > CPU: 8 PID: 1105 Comm: md0_raid5 Not tainted 4.8.0-rc5-00003-g3abda5c #2
> > Hardware name: Supermicro X10DRH/X10DRH-iT, BIOS 1.0c 02/18/2015
> > task: ffff97de5e1e0000 task.stack: ffff97de597a0000
> > RIP: 0010:[<ffffffffbc3b3890>] [<ffffffffbc3b3890>]
> > generic_make_request+0x1c0/0x1d0
> > RSP: 0018:ffff97de597a3aa0 EFLAGS: 00010286
> > RAX: ffff97de5e1e0000 RBX: ffff97dd227e5030 RCX: 0000000000000000
> > RDX: ffffffffc0000001 RSI: 0000000000000001 RDI: ffff97de5e7d9db8
> > RBP: ffff97de597a3ad8 R08: 0000000000000008 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000001 R12: 00000000ffffffff
> > R13: ffff97de5aa20c00 R14: 00000000000002f0 R15: ffff97e65dce0e00
> > FS: 0000000000000000(0000) GS:ffff97e67f200000(0000) knlGS:0000000000000000
> > CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f0e4e1ec000 CR3: 0000000078c06000 CR4: 00000000001406e0Stack:
> > ffff97de597a3b50 0000000000001000 0000000000000000 ffff97dd227e4c80
> > ffff97de5aa20c00 00000000000002f0 ffff97e65dce0e00 ffff97de597a3ba0
> > ffffffffc02595db ffffffffc025e04b 00000001597a3b01 0000000200000006
> > Call Trace:
> > [<ffffffffc02595db>] ops_run_io+0x3bb/0x990 [raid456]
> > [<ffffffffc025e04b>] ? raid_run_ops+0xefb/0x1520 [raid456]
> > [<ffffffffc0261d16>] handle_stripe+0x9a6/0x2280 [raid456]
> > [<ffffffffbc0ae6b2>] ? default_wake_function+0x12/0x20
> > [<ffffffffbc0c7d22>] ? autoremove_wake_function+0x12/0x40
> > [<ffffffffc0263783>] handle_active_stripes.isra.54+0x193/0x4b0 [raid456]
> > [<ffffffffc02571d5>] ? __release_stripe+0x15/0x20 [raid456]
> > [<ffffffffc0263f49>] raid5d+0x4a9/0x740 [raid456]
> > [<ffffffffbc0e88f0>] ? init_timer_key+0xa0/0xa0
> > [<ffffffffc019a7eb>] md_thread+0x12b/0x130 [md_mod]
> > [<ffffffffbc0c7d10>] ? wait_woken+0x90/0x90
> > [<ffffffffc019a6c0>] ? find_pers+0x70/0x70 [md_mod]
> > [<ffffffffbc0a395b>] kthread+0xdb/0x100
> > [<ffffffffbc6de57f>] ret_from_fork+0x1f/0x40
> > [<ffffffffbc0a3880>] ? kthread_park+0x60/0x60
> > Code: bd 70 08 00 00 f0 49 83 ad 70 08 00 00 01 74 05 e9 5a ff ff ff 41
> > ff 95 80 08 00 00 e9 4e ff ff ff 48 c7 40 08 00 00 00 00 eb 8c <0f> 0b
> > 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
> > RIP [<ffffffffbc3b3890>] generic_make_request+0x1c0/0x1d0
> > RSP <ffff97de597a3aa0>
> > ---[ end trace 457dbe5e9cdd3473 ]---
> 
> CC'ing Shaohua - this is:
> 
>         BUG_ON(bio->bi_next);
> 
> which doesn't look healthy.

Hi Stefan,
does below patch help? Looks there is a race condition introduced recently.


diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index b95c54c..ee7fc37 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2423,10 +2423,10 @@ static void raid5_end_read_request(struct bio * bi)
 		}
 	}
 	rdev_dec_pending(rdev, conf->mddev);
+	bio_reset(bi);
 	clear_bit(R5_LOCKED, &sh->dev[i].flags);
 	set_bit(STRIPE_HANDLE, &sh->state);
 	raid5_release_stripe(sh);
-	bio_reset(bi);
 }
 
 static void raid5_end_write_request(struct bio *bi)
@@ -2498,6 +2498,7 @@ static void raid5_end_write_request(struct bio *bi)
 	if (sh->batch_head && bi->bi_error && !replacement)
 		set_bit(STRIPE_BATCH_ERR, &sh->batch_head->state);
 
+	bio_reset(bi);
 	if (!test_and_clear_bit(R5_DOUBLE_LOCKED, &sh->dev[i].flags))
 		clear_bit(R5_LOCKED, &sh->dev[i].flags);
 	set_bit(STRIPE_HANDLE, &sh->state);
@@ -2505,7 +2506,6 @@ static void raid5_end_write_request(struct bio *bi)
 
 	if (sh->batch_head && sh != sh->batch_head)
 		raid5_release_stripe(sh->batch_head);
-	bio_reset(bi);
 }
 
 static void raid5_build_block(struct stripe_head *sh, int i, int previous)
