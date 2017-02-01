Return-Path: <dan.j.williams@intel.com>
MIME-Version: 1.0
In-Reply-To: <20170131125429.14303-5-jack@suse.cz>
References: <20170131125429.14303-1-jack@suse.cz> <20170131125429.14303-5-jack@suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Feb 2017 11:25:22 -0800
Message-ID: <CAPcyv4hi9niVD4DUscTMmt6s_P5WWtiwrDsgS83UJuLySZof7w@mail.gmail.com>
Subject: Re: [PATCH 4/4] block: Make blk_get_backing_dev_info() safe without
 open bdev
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Laurent Dufour <ldufour@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Tue, Jan 31, 2017 at 4:54 AM, Jan Kara <jack@suse.cz> wrote:
> Currenly blk_get_backing_dev_info() is not safe to be called when the
> block device is not open as bdev->bd_disk is NULL in that case. However
> inode_to_bdi() uses this function and may be call called from flusher
> worker or other writeback related functions without bdev being open
> which leads to crashes such as:
>
> [113031.075540] Unable to handle kernel paging request for data at address 0x00000000
> [113031.075614] Faulting instruction address: 0xc0000000003692e0
> 0:mon> t
> [c0000000fb65f900] c00000000036cb6c writeback_sb_inodes+0x30c/0x590
> [c0000000fb65fa10] c00000000036ced4 __writeback_inodes_wb+0xe4/0x150
> [c0000000fb65fa70] c00000000036d33c wb_writeback+0x30c/0x450
> [c0000000fb65fb40] c00000000036e198 wb_workfn+0x268/0x580
> [c0000000fb65fc50] c0000000000f3470 process_one_work+0x1e0/0x590
> [c0000000fb65fce0] c0000000000f38c8 worker_thread+0xa8/0x660
> [c0000000fb65fd80] c0000000000fc4b0 kthread+0x110/0x130
> [c0000000fb65fe30] c0000000000098f0 ret_from_kernel_thread+0x5c/0x6c
> --- Exception: 0  at 0000000000000000
> 0:mon> e
> cpu 0x0: Vector: 300 (Data Access) at [c0000000fb65f620]
>     pc: c0000000003692e0: locked_inode_to_wb_and_lock_list+0x50/0x290
>     lr: c00000000036cb6c: writeback_sb_inodes+0x30c/0x590
>     sp: c0000000fb65f8a0
>    msr: 800000010280b033
>    dar: 0
>  dsisr: 40000000
>   current = 0xc0000001d69be400
>   paca    = 0xc000000003480000   softe: 0        irq_happened: 0x01
>     pid   = 18689, comm = kworker/u16:10
>
> Fix the problem by grabbing reference to bdi on first open of the block
> device and drop the reference only once the inode is evicted from
> memory. This pins struct backing_dev_info in memory and thus fixes the
> crashes.
>
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Reported-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Tested-by: Dan Williams <dan.j.williams@intel.com>
