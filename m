Return-Path: <abdhalee@linux.vnet.ibm.com>
Subject: Re: WARNING: CPU: 15 PID: 0 at block/blk-mq.c:1111
 __blk_mq_run_hw_queue+0x1d8/0x1f0
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Brian King <brking@linux.vnet.ibm.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "sachinp@linux.vnet.ibm.com" <sachinp@linux.vnet.ibm.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "brking@us.ibm.com" <brking@us.ibm.com>,
        "axboe@kernel.dk"
 <axboe@kernel.dk>
Date: Fri, 18 Aug 2017 10:10:58 +0530
In-Reply-To: <072f9589-7489-ac6a-2899-0f12aed3e2fe@linux.vnet.ibm.com>
References: <1502906852.3305.33.camel@abdul.in.ibm.com>
	 <1502907345.2421.8.camel@wdc.com>
	 <4fe35be3-c631-e4ed-a135-110e536823bc@linux.vnet.ibm.com>
	 <1502983941.2615.5.camel@wdc.com>
	 <072f9589-7489-ac6a-2899-0f12aed3e2fe@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1503031258.3305.39.camel@abdul.in.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-08-17 at 14:18 -0500, Brian King wrote:
> On 08/17/2017 10:32 AM, Bart Van Assche wrote:
> > On Wed, 2017-08-16 at 15:10 -0500, Brian King wrote:
> >> On 08/16/2017 01:15 PM, Bart Van Assche wrote:
> >>> On Wed, 2017-08-16 at 23:37 +0530, Abdul Haleem wrote:
> >>>> Linux-next booted with the below warnings on powerpc
> >>>>
> >>>> [ ... ]
> >>>>
> >>>> boot warnings:
> >>>> --------------
> >>>> kvm: exiting hardware virtualization
> >>>> ------------[ cut here ]------------
> >>>> WARNING: CPU: 15 PID: 0 at block/blk-mq.c:1111 __blk_mq_run_hw_queue
> >>>> +0x1d8/0x1f0
> >>>> Modules linked in: iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4
> >>>> Call Trace:
> >>>> [c000000ffff37990] [c00000000088f7b0] __blk_mq_delay_run_hw_queue
> >>>> +0x1f0/0x210
> >>>> [c000000ffff379d0] [c00000000088fcb8] blk_mq_start_hw_queue+0x58/0x80
> >>>> [c000000ffff379f0] [c00000000088fd40] blk_mq_start_hw_queues+0x60/0xb0
> >>>> [c000000ffff37a30] [c000000000ae2b54] scsi_kick_queue+0x34/0xa0
> >>>> [c000000ffff37a50] [c000000000ae2f70] scsi_run_queue+0x3b0/0x660
> >>>> [c000000ffff37ac0] [c000000000ae7ed4] scsi_run_host_queues+0x64/0xc0
> >>>> [c000000ffff37b00] [c000000000ae7f64] scsi_unblock_requests+0x34/0x60
> >>>> [c000000ffff37b20] [c000000000b14998] ipr_ioa_bringdown_done+0xf8/0x3a0
> >>>> [c000000ffff37bc0] [c000000000b12528] ipr_reset_ioa_job+0xd8/0x170
> >>>> [c000000ffff37c00] [c000000000b18790] ipr_reset_timer_done+0x110/0x160
> >>>> [c000000ffff37c50] [c00000000024db50] call_timer_fn+0xa0/0x3a0
> >>>> [c000000ffff37ce0] [c00000000024e058] expire_timers+0x1b8/0x350
> >>>> [c000000ffff37d50] [c00000000024e2f0] run_timer_softirq+0x100/0x3e0
> >>>> [c000000ffff37df0] [c000000000162edc] __do_softirq+0x20c/0x620
> >>>> [c000000ffff37ee0] [c000000000163a80] irq_exit+0x230/0x290
> >>>> [c000000ffff37f10] [c00000000001d770] __do_irq+0x170/0x410
> >>>> [c000000ffff37f90] [c00000000003ea20] call_do_irq+0x14/0x24
> >>>> [c0000007f84e3a70] [c00000000001dae0] do_IRQ+0xd0/0x190
> >>>> [c0000007f84e3ac0] [c000000000008c58] hardware_interrupt_common
> >>>> +0x158/0x160
> >>>
> >>> Hello Brian,
> >>>
> >>> In the MAINTAINERS file I found the following:
> >>>
> >>> IBM Power Linux RAID adapter
> >>> M:      Brian King <brking@us.ibm.com>
> >>> S:      Supported
> >>> F:      drivers/scsi/ipr.*
> >>>
> >>> Is that information up-to-date? Do you agree that the above message indicates
> >>> a bug in the ipr driver?
> >>
> >> Yes. Can you try with this patch that is in 4.13/scsi-fixes:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?h=4.13/scsi-fixes&id=b0e17a9b0df29590c45dfb296f541270a5941f41
> > 

Hi Brian,

The patch fixes the warning, Thanks for the fix.

Tested-by : Abdul Haleem <abdhalee@linux.vnet.ibm.com>

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
