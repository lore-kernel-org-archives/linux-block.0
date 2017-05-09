Return-Path: <abdhalee@linux.vnet.ibm.com>
Subject: Re: [linux-next][bock] [bisected c20cfc27a] WARNING: CPU: 22 PID: 0
 at block/blk-core.c:2655 .blk_update_request+0x4f8/0x500
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Jens Axboe <axboe@kernel.dk>, hch@lst.de
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
        Stephen Rothwell
 <sfr@canb.auug.org.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-block
 <linux-block@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 09 May 2017 20:48:21 +0530
In-Reply-To: <f1a1ced1-6f3c-8fec-2e2d-4db4c09e31fc@kernel.dk>
References: <1493965539.7355.44.camel@abdul.in.ibm.com>
	 <15a0a50a-d57d-736b-634c-4d0131ec5af3@kernel.dk>
	 <1494227599.2983.2.camel@abdul.in.ibm.com>
	 <f1a1ced1-6f3c-8fec-2e2d-4db4c09e31fc@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1494343101.11532.4.camel@abdul.in.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-05-08 at 08:00 -0600, Jens Axboe wrote:
> On 05/08/2017 01:13 AM, Abdul Haleem wrote:
> > On Fri, 2017-05-05 at 08:02 -0600, Jens Axboe wrote:
> >> On 05/05/2017 12:25 AM, Abdul Haleem wrote:
> >>> Hi,
> >>>
> >>> 4.11.0 Linus mainline booted with Warnings on PowerPC.
> >>>
> >>> We did not see this on next-20170407 but on next-20170410 and later.
> >>
> >> Have you tried current Linus -git? Both of the -next versions you list
> >> are rather old.
> >>
> > 
> > Hi Jens, 
> > 
> > Warning is still seen with next-20170505 and also with today's mainline.
> > 
> > It was first seen on next-20170410, so the last good was next-20170407.
> 
> The log between the known good and first bad version, condensed a bit for
> primary suspects, is below.
> 
> Christoph Hellwig (4):
>       sd: split sd_setup_discard_cmnd
>       sd: implement REQ_OP_WRITE_ZEROES
>       sd: implement unmapping Write Zeroes
>       block: remove the discard_zeroes_data flag
> 
> Martin K. Petersen (2):
>       scsi: sd: Separate zeroout and discard command choices
>       scsi: sd: Remove LBPRZ dependency for discards
> 
> Christoph Hellwig (7):
>       block: implement splitting of REQ_OP_WRITE_ZEROES bios
>       block: stop using blkdev_issue_write_same for zeroing
>       block: add a flags argument to (__)blkdev_issue_zeroout
>       block: add a REQ_NOUNMAP flag for REQ_OP_WRITE_ZEROES
>       block: add a new BLKDEV_ZERO_NOFALLBACK flag
>       block: stop using discards for zeroing
>       block: remove the discard_zeroes_data flag
> 
> Christoph, Martin - any ideas? Trace from Abdul below.

A bisection for the above suspects resulted a bad commit;

c20cfc27a47307e811346f85959cf3cc07ae42f9 is the first bad commit
commit c20cfc27a47307e811346f85959cf3cc07ae42f9
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Apr 5 19:21:07 2017 +0200

    block: stop using blkdev_issue_write_same for zeroing
    
    We'll always use the WRITE ZEROES code for zeroing now.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
    Reviewed-by: Hannes Reinecke <hare@suse.com>
    Signed-off-by: Jens Axboe <axboe@fb.com>


@Christoph FYI, the machine configured with 64K page size
> 
> WARNING: CPU: 12 PID: 0 at block/blk-core.c:2651 .blk_update_request+0x4cc/0x4e0
> Modules linked in: sg(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sunrpc(E) binfmt_misc(E) ip_tables(E) ext4(E) mbcache(E) jbd2(E) sd_mod(E) ibmvscsi(E) scsi_transport_srp(E) ibmveth(E)
> CPU: 12 PID: 0 Comm: swapper/12 Tainted: G            E   4.11.0-autotest #1
> task: c0000009f455ee80 task.stack: c0000009fb2e8000
> NIP: c00000000050bd1c LR: c00000000050b8ec CTR: c0000000005114b0
> REGS: c0000013fff73740 TRAP: 0700   Tainted: G            E    (4.11.0-autotest)
> MSR: 8000000000029032 <SF,EE,ME,IR,DR,RI>
>   CR: 48042048  XER: 00000001
> CFAR: c00000000050bb34 SOFTE: 1 
> GPR00: c00000000050b8ec c0000013fff739c0 c000000001389c00 c0000009eca9c800
> GPR04: 0000000000000000 0000000000000000 0000000000000001 0000000000000060 
> GPR08: 0000000000067887 0000000000000000 c0000009eca9c800 d00000000e5f7e30 
> GPR12: 0000000088044044 c00000000e9f6c00 c0000009fb2ebf90 0000000000200042 
> GPR16: 00000000ffff9367 c0000013fff70000 0000000000000000 c000000000df4100 
> GPR20: c0000000013c3b00 c000000000df4100 0000000000000000 0000000000000005 
> GPR24: 0000000000002ee0 c0000000017789f8 0000000000000000 0000000000000000 
> GPR28: 0000000000000000 c0000000038ba400 0000000000000000 c0000009eca9c800 
> NIP [c00000000050bd1c] .blk_update_request+0x4cc/0x4e0
> LR [c00000000050b8ec] .blk_update_request+0x9c/0x4e0
> Call Trace:
> [c0000013fff739c0] [c00000000050b8ec] .blk_update_request+0x9c/0x4e0 (unreliable)
> [c0000013fff73a60] [c0000000006b06fc] .scsi_end_request+0x4c/0x240
> [c0000013fff73b10] [c0000000006b4564] .scsi_io_completion+0x1d4/0x6c0
> [c0000013fff73be0] [c0000000006a8cd0] .scsi_finish_command+0x100/0x1b0
> [c0000013fff73c70] [c0000000006b3978] .scsi_softirq_done+0x188/0x1e0
> [c0000013fff73d00] [c000000000516b44] .blk_done_softirq+0xc4/0xf0
> [c0000013fff73d90] [c0000000000daef8] .__do_softirq+0x158/0x3b0
> [c0000013fff73e90] [c0000000000db5b8] .irq_exit+0x1a8/0x1c0
> [c0000013fff73f10] [c000000000014f84] .__do_irq+0x94/0x1f0
> [c0000013fff73f90] [c000000000026cbc] .call_do_irq+0x14/0x24
> [c0000009fb2eb7f0] [c00000000001516c] .do_IRQ+0x8c/0x100
> [c0000009fb2eb890] [c000000000008bf4] hardware_interrupt_common+0x114/0x120
> --- interrupt: 501 at .plpar_hcall_norets+0x14/0x20
>     LR = .check_and_cede_processor+0x24/0x40
> [c0000009fb2ebb80] [0000000000000002] 0x2 (unreliable)
> [c0000009fb2ebbf0] [c0000000007c360c] .dedicated_cede_loop+0x4c/0x150
> [c0000009fb2ebc70] [c0000000007c1040] .cpuidle_enter_state+0xb0/0x3b0
> [c0000009fb2ebd20] [c00000000012d1bc] .call_cpuidle+0x3c/0x70
> [c0000009fb2ebd90] [c00000000012d550] .do_idle+0x280/0x2e0
> [c0000009fb2ebe50] [c00000000012d768] .cpu_startup_entry+0x28/0x40
> [c0000009fb2ebed0] [c0000000000428a4] .start_secondary+0x304/0x350
> [c0000009fb2ebf90] [c00000000000aa6c] start_secondary_prolog+0x10/0x14
> Instruction dump:
> 3f82ff90 3b9cc190 4bfffd8c 3f82ff90 3b9cc1a8 4bfffd80 61290040 b13f0018
> 4bfffbd4 3cc2ff8b 38c63160 4bfffd9c <0fe00000> 4bfffe18 60000000 60000000 
> ---[ end trace 0f80359f8fb9c5f4 ]---
> EXT4-fs (sda3): Delayed block allocation failed for inode 11011467 at logical offset 0 with max blocks 7 with error 121
> EXT4-fs (sda3): This should not happen!! Data will be lost
> 


-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
