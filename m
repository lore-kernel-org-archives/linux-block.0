Return-Path: <babu.moger@oracle.com>
Subject: Re: Filesystem slow write performance
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <0fac0b7a-8723-cc5d-6118-bec29881a480@oracle.com>
From: Babu Moger <babu.moger@oracle.com>
Message-ID: <439c2b85-79c4-8239-7512-d5398675cc68@oracle.com>
Date: Mon, 8 Aug 2016 23:28:43 -0500
MIME-Version: 1.0
In-Reply-To: <0fac0b7a-8723-cc5d-6118-bec29881a480@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

I wasn't able to repro this with mainline. Sorry for the noise.

On 8/6/2016 1:49 PM, Babu Moger wrote:
> Hi,
>
> Seeing some terrible write performance with ext3/4 writes.  Reads are 
> fine.
>
> I have a created loop device and mounted as ext3(tried ext4 also).
>
> Here is iostat output. await time is pretty high most of the time.
>
> Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s 
> avgrq-sz avgqu-sz   await  svctm  %util
> loop0             0.00     0.00    0.00  133.00     0.00 1064.00     
> 8.00   124.14  835.61   7.52 100.00
> dm-0              0.00     0.00    0.00  132.00     0.00 1056.00     
> 8.00     1.00    7.52   7.52  99.20
>
> Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s 
> avgrq-sz avgqu-sz   await  svctm  %util
> loop0             0.00     0.00    0.00   94.00     0.00 752.00     
> 8.00   124.18  901.02  10.64 100.00
> dm-0              0.00     0.00    0.00   92.00     0.00 736.00     
> 8.00     1.02   11.09  10.87 100.00
>
> Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s 
> avgrq-sz avgqu-sz   await  svctm  %util
> loop0             0.00     0.00    0.00  132.00     0.00 1056.00     
> 8.00   124.56 1329.30   7.58 100.00
> dm-0              0.00     0.00    0.00  141.00     0.00 1128.00     
> 8.00     1.08    7.72   7.06  99.60
>
> Tags output
> [root@build-t7 0]# cat tags
> nr_tags=128, reserved_tags=0, bits_per_word=5
> nr_free=128, nr_reserved=0
> active_queues=0
>
> Here is the output of  "echo w > /proc/sysrq-trigger" when the problem 
> happens.
>
> Aug  3 12:18:55 build-t7 kernel: kworker/u512:0  D 
> 00000000009defd4     0     6      2 0x06000000
> Aug  3 12:18:55 build-t7 kernel: Workqueue: writeback 
> bdi_writeback_workfn (flush-7:0)
> Aug  3 12:18:55 build-t7 kernel: Call Trace:
> Aug  3 12:18:55 build-t7 kernel: [00000000009dc9e4] schedule+0x24/0xa0
> Aug  3 12:18:55 build-t7 kernel: [00000000009defd4] 
> schedule_timeout+0x134/0x220
> Aug  3 12:18:55 build-t7 kernel: [00000000009dc044] 
> io_schedule_timeout+0x84/0x100
> Aug  3 12:18:55 build-t7 kernel: [00000000006be64c] bt_get+0x10c/0x1e0
> Aug  3 12:18:55 build-t7 kernel: [00000000006be7f4] 
> blk_mq_get_tag+0x74/0xe0
> Aug  3 12:18:55 build-t7 kernel: [00000000006ba570] 
> __blk_mq_alloc_request+0x10/0x180
> Aug  3 12:18:55 build-t7 kernel: [00000000006bb9f4] 
> blk_mq_map_request+0x1d4/0x260
> Aug  3 12:18:55 build-t7 kernel: [00000000006bbd40] 
> blk_sq_make_request+0x60/0x300
> Aug  3 12:18:55 build-t7 kernel: [00000000006afa58] 
> generic_make_request+0x78/0xe0
> Aug  3 12:18:55 build-t7 kernel: [00000000006afb44] submit_bio+0x84/0x160
> Aug  3 12:18:55 build-t7 kernel: [00000000005f7cb4] 
> _submit_bh+0x174/0x200
> Aug  3 12:18:55 build-t7 kernel: [00000000005f7d54] submit_bh+0x14/0x40
> Aug  3 12:18:55 build-t7 kernel: [00000000005fc248] 
> __block_write_full_page.clone.0+0x2c8/0x500
> Aug  3 12:18:55 build-t7 kernel: [00000000005fc620] 
> block_write_full_page+0xa0/0xe0
> Aug  3 12:18:55 build-t7 kernel: [00000000100e7d94] 
> ext3_writeback_writepage+0x134/0x200 [ext3]
> Aug  3 12:18:55 build-t7 kernel: [0000000000562798] __writepage+0x18/0x60
>
> Aug  3 12:18:55 build-t7 kernel: loop0           D 
> 00000000009deff4     0 15632      2 0x01000400
> Aug  3 12:18:55 build-t7 kernel: Call Trace:
> Aug  3 12:18:55 build-t7 kernel: [00000000009dc9e4] schedule+0x24/0xa0
> Aug  3 12:18:55 build-t7 kernel: [00000000009deff4] 
> schedule_timeout+0x154/0x220
> Aug  3 12:18:55 build-t7 kernel: [00000000009dc044] 
> io_schedule_timeout+0x84/0x100
> Aug  3 12:18:55 build-t7 kernel: [00000000009dcdbc] bit_wait_io+0x3c/0x80
> Aug  3 12:18:55 build-t7 kernel: [00000000009dd1c4] 
> __wait_on_bit+0x84/0x100
> Aug  3 12:18:55 build-t7 kernel: [000000000055719c] 
> wait_on_page_bit+0x7c/0xa0
> Aug  3 12:18:55 build-t7 kernel: [00000000005586a8] 
> filemap_fdatawait_range+0xc8/0x140
> Aug  3 12:18:55 build-t7 kernel: [00000000005587fc] 
> filemap_write_and_wait_range+0x3c/0x80
> Aug  3 12:18:55 build-t7 kernel: [0000000000558a58] 
> __generic_file_write_iter+0xb8/0x140
> Aug  3 12:18:55 build-t7 kernel: [0000000000558bac] 
> generic_file_write_iter+0xcc/0x1e0
> Aug  3 12:18:55 build-t7 kernel: [00000000007ca000] lo_rw_aio+0x180/0x240
> Aug  3 12:18:55 build-t7 kernel: [00000000007ca260] 
> do_req_filebacked+0x1a0/0x1c0
> Aug  3 12:18:55 build-t7 kernel: [00000000007ca2b4] 
> loop_queue_work+0x34/0x80
> Aug  3 12:18:55 build-t7 kernel: [0000000000491944] 
> kthread_worker_fn+0x44/0x180
> Aug  3 12:18:55 build-t7 kernel: [0000000000491c4c] kthread+0xac/0xe0
> Aug  3 12:18:55 build-t7 kernel: [0000000000406184] 
> ret_from_fork+0x1c/0x2c
>
> Aug  3 12:18:55 build-t7 kernel: livecd-creator  D 
> 00000000009deff4     0 15627   2676 0x308000103000400
> Aug  3 12:18:55 build-t7 kernel: Call Trace:
> Aug  3 12:18:55 build-t7 kernel: [00000000009dc9e4] schedule+0x24/0xa0
> Aug  3 12:18:55 build-t7 kernel: [00000000009deff4] 
> schedule_timeout+0x154/0x220
> Aug  3 12:18:55 build-t7 kernel: [00000000009dc044] 
> io_schedule_timeout+0x84/0x100
> Aug  3 12:18:55 build-t7 kernel: [00000000009dcdbc] bit_wait_io+0x3c/0x80
> Aug  3 12:18:55 build-t7 kernel: [00000000009dd1c4] 
> __wait_on_bit+0x84/0x100
> Aug  3 12:18:55 build-t7 kernel: [000000000055719c] 
> wait_on_page_bit+0x7c/0xa0
> Aug  3 12:18:55 build-t7 kernel: [00000000005586a8] 
> filemap_fdatawait_range+0xc8/0x140
> Aug  3 12:18:55 build-t7 kernel: [00000000005587fc] 
> filemap_write_and_wait_range+0x3c/0x80
> Aug  3 12:18:55 build-t7 kernel: [00000000100e4258] 
> ext3_sync_file+0x58/0x2c0 [ext3]
> Aug  3 12:18:55 build-t7 kernel: [00000000005f54d8] 
> vfs_fsync_range+0x38/0xa0
> Aug  3 12:18:55 build-t7 kernel: [00000000005f555c] vfs_fsync+0x1c/0x40
> Aug  3 12:18:55 build-t7 kernel: [00000000005f55a8] do_fsync+0x28/0x60
> Aug  3 12:18:55 build-t7 kernel: [00000000005f55f0] 
> SyS_fdatasync+0x10/0x40
>
> I am not an expert on this area. Note that I am bit behind on the 
> kernel version(but not a whole lot). Working on to recreate this
> with latest upstream kernel. Looked at the upstream patches and tried 
> most of the upstream patches which appear to be related
> and nothing helped. Problem is fairly easy to reproduce. Let me know 
> if you want me to try something.
> Thanks
> Babu Moger
