Return-Path: <barra_cuda@katamail.com>
Date: Sat, 9 Dec 2017 00:27:21 +0100
From: Michele Ballabio <barra_cuda@katamail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org
Subject: Re: block: oopses on 4.13.*, 4.14.* and 4.15-rc2 (bisected)
Message-ID: <20171209002721.537a5290@darkstar.example.org>
In-Reply-To: <f59e66c4-e09b-95aa-a5a5-f26288beb3f0@kernel.dk>
References: <20171208163851.0f3823b6@darkstar.example.org>
	<f59e66c4-e09b-95aa-a5a5-f26288beb3f0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Fri, 8 Dec 2017 13:08:37 -0700
Jens Axboe <axboe@kernel.dk> wrote:

> On 12/08/2017 08:38 AM, Michele Ballabio wrote:
> > Hi,
> > 	kernels 4.13.*, 4.14.* 4.15-rc2 crash on occasion,
> > especially on x86-32 systems. To trigger the problem, run as root:
> > 
> > while true
> > do
> >         /sbin/udevadm trigger --type=subsystems --action=change
> >         /sbin/udevadm trigger --type=devices --action=change
> >         /sbin/udevadm settle --timeout=120
> > done
> > 
> > (Thanks to Patrick Volkerding for the reproducer).
> > 
> > Sometimes the kernel oopses immediately, sometimes a bit later
> > (less than five minutes).
> > 
> > The bisection pointed to commit
> > caa4b02476e31fc7933d2138062f7f355d3cd8f7 (blk-map: call
> > blk_queue_bounce from blk_rq_append_bio). A revert fixes the
> > problem (tested on 4.13 and master).  
> 
> Thanks for your report - can you try the below patch? Totally
> untested...

I applied the patch on master
(968edbd93c0cbb40ab48aca972392d377713a0c3), I tried two times to boot
the system but couldn't get to the shell. I found this in the log:

kernel: [   37.625778] BUG: unable to handle kernel paging request at 00027f30
kernel: [   37.660642] IP: bio_uncopy_user+0xab/0x120
kernel: [   37.731620] Oops: 0000 [#1] SMP
kernel: [   37.766587] Modules linked in:
kernel: [   37.800794] CPU: 0 PID: 692 Comm: ata_id Not tainted 4.15.0-rc2-mike-1mike+ #165
kernel: [   37.836750] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [   37.873684] EIP: bio_uncopy_user+0xab/0x120
kernel: [   37.909600] EFLAGS: 00010206 CPU: 0
kernel: [   37.944533] EAX: ec7ea800 EBX: eb8ef380 ECX: 00027f2c EDX: 802a0013
kernel: [   37.979895] ESI: 00000004 EDI: 00000000 EBP: e9721d78 ESP: e9721d4c
kernel: [   38.015108]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [   38.050511] CR0: 80050033 CR2: 00027f30 CR3: 2cee0ea0 CR4: 003406f0
kernel: [   38.085727] Call Trace:
kernel: [   38.119868]  ? mempool_free+0x23/0x80
kernel: [   38.154149]  __blk_rq_unmap_user+0x17/0x40
kernel: [   38.188016]  blk_rq_unmap_user+0x27/0x60
kernel: [   38.221280]  sg_io+0x1f4/0x390
kernel: [   38.253896]  ? blkdev_get+0xe6/0x2a0
kernel: [   38.286291]  scsi_cmd_ioctl+0x26a/0x3f0
kernel: [   38.318792]  ? path_openat+0x4e9/0x11e0
kernel: [   38.350829]  scsi_cmd_blk_ioctl+0x30/0x40
kernel: [   38.382469]  sd_ioctl+0x63/0x90
kernel: [   38.413630]  ? scsi_disk_put+0x40/0x40
kernel: [   38.444589]  blkdev_ioctl+0x47a/0x9a0
kernel: [   38.474897]  block_ioctl+0x37/0x40
kernel: [   38.504137]  ? block_ioctl+0x37/0x40
kernel: [   38.532682]  ? blkdev_fallocate+0x220/0x220
kernel: [   38.560834]  do_vfs_ioctl+0x81/0x610
kernel: [   38.588706]  ? putname+0x47/0x60
kernel: [   38.616480]  ? putname+0x47/0x60
kernel: [   38.643817]  ? do_sys_open+0x139/0x230
kernel: [   38.670493]  SyS_ioctl+0x58/0x70
kernel: [   38.697488]  do_int80_syscall_32+0x3e/0xe0
kernel: [   38.723925]  entry_INT80_32+0x31/0x31
kernel: [   38.750093] EIP: 0xb7dd82c4
kernel: [   38.775882] EFLAGS: 00000246 CPU: 0
kernel: [   38.801792] EAX: ffffffda EBX: 00000003 ECX: 00002285 EDX: bfd09900
kernel: [   38.828336] ESI: bfd0af05 EDI: bfd09940 EBP: bfd09e18 ESP: bfd09868
kernel: [   38.854585]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
kernel: [   38.880557] Code: d4 8d 65 f4 5b 5e 5f 5d c3 8d b4 26 00 00 00 00 c7 45 d4 00 00 00 00 eb d6 8d b4 26 00 00 00 00 8b 4d d8 66 83 7b 54 00 8b 73 5c <8b> 41 04 89 45 dc 8b 41 08
89 45 e0 8b 41 0c 89 45 e4 8b 41 10
kernel: [   38.935585] EIP: bio_uncopy_user+0xab/0x120 SS:ESP: 0068:e9721d4c
kernel: [   38.962830] CR2: 0000000000027f30
kernel: [   38.989570] ---[ end trace 49c0f0f09584f509 ]---
kernel: [   43.367782] BUG: unable to handle kernel paging request at 10010021
kernel: [   43.396195] IP: kmem_cache_alloc+0x8e/0x1d0
kernel: [   43.450948] Oops: 0000 [#2] SMP
kernel: [   43.478445] Modules linked in:
kernel: [   43.505799] CPU: 6 PID: 573 Comm: fc-cache Tainted: G      D          4.15.0-rc2-mike-1mike+ #165
kernel: [   43.534691] Hardware name: System manufacturer System Product Name/PRIME B350-PLUS, BIOS 0902 09/08/2017
kernel: [   43.564549] EIP: kmem_cache_alloc+0x8e/0x1d0
kernel: [   43.594336] EFLAGS: 00010206 CPU: 6
kernel: [   43.624092] EAX: 00000000 EBX: 10010021 ECX: 0000108a EDX: 00001089
kernel: [   43.654634] ESI: f77f3ae8 EDI: ecc03980 EBP: ea63fbc0 ESP: ea63fba4
kernel: [   43.685394]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
kernel: [   43.716288] CR0: 80050033 CR2: 10010021 CR3: 2bdaee40 CR4: 003406f0
kernel: [   43.747663] Call Trace:
kernel: [   43.778709]  ? mempool_alloc_slab+0x13/0x20
kernel: [   43.810162]  mempool_alloc_slab+0x13/0x20
kernel: [   43.810165]  mempool_alloc+0x3a/0x130
kernel: [   43.810168]  ? cfq_set_request+0x4d/0x4d0
kernel: [   43.810172]  ? native_sched_clock+0x2a/0xd0
kernel: [   43.810175]  bio_alloc_bioset+0x13a/0x220
kernel: [   43.810177]  bio_clone_bioset+0x47/0x370
kernel: [   43.810180]  blk_queue_bounce+0x1cb/0x3a0
kernel: [   43.810183]  blk_queue_bio+0x22/0x3f0
kernel: [   43.810185]  generic_make_request+0xd7/0x2d0
kernel: [   43.810187]  ? mempool_alloc+0x3a/0x130
kernel: [   43.810189]  submit_bio+0x67/0x130
kernel: [   43.810191]  ? bio_alloc_bioset+0x13a/0x220
kernel: [   43.810194]  ext4_mpage_readpages+0x59d/0x8e0
kernel: [   43.810197]  ? __alloc_pages_nodemask+0xd4/0xe80
kernel: [   43.810202]  ext4_readpages+0x31/0x40
kernel: [   43.810203]  ? ext4_readpages+0x31/0x40
kernel: [   43.810205]  ? ext4_invalidatepage+0xb0/0xb0
kernel: [   43.810208]  __do_page_cache_readahead+0x13e/0x1e0
kernel: [   43.810211]  filemap_fault+0x31a/0x550
kernel: [   43.810214]  ? find_get_pages_range_tag+0x270/0x270
kernel: [   43.810216]  ? filemap_map_pages+0x13d/0x2d0

(log ends here, the rest didn't make it to disk).
