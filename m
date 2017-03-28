Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 28 Mar 2017 08:06:55 -0600
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: v4.11-rc blk-mq lockup?
Message-ID: <20170328140655.GB27578@kernel.dk>
References: <1490651076.7897.11.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1490651076.7897.11.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 27 2017, Bart Van Assche wrote:
> Hello Jens,
> 
> If I leave the srp-test software running for a few minutes using the
> following command:
> 
> # while ~bart/software/infiniband/srp-test/run_tests -d -r 30; do :; done
> 
> then after some time the following complaint appears for multiple
> kworkers:
> 
> INFO: task kworker/9:0:65 blocked for more than 480 seconds.
> ������Tainted: G����������I�����4.11.0-rc4-dbg+ #5
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/9:0�����D����0����65������2 0x00000000
> Workqueue: dio/dm-0 dio_aio_complete_work
> Call Trace:
> �__schedule+0x3df/0xc10
> �schedule+0x38/0x90
> �rwsem_down_write_failed+0x2c4/0x4c0
> �call_rwsem_down_write_failed+0x17/0x30
> �down_write+0x5a/0x70
> �__generic_file_fsync+0x43/0x90
> �ext4_sync_file+0x2d0/0x550
> �vfs_fsync_range+0x46/0xa0
> �dio_complete+0x181/0x1b0
> �dio_aio_complete_work+0x17/0x20
> �process_one_work+0x208/0x6a0
> �worker_thread+0x49/0x4a0
> �kthread+0x107/0x140
> �ret_from_fork+0x2e/0x40
> 
> I had not yet observed this behavior with kernel v4.10 or older. If this
> happens and I check the queue state with the following script:

Can you include the 'state' file in your script?

Do you know when this started happening? You say it doesn't happen in
4.10, but did it pass earlier in the 4.11-rc cycle?

Does it reproduce with dm?

I can't tell from your report if this is new in the 4.11 series,

> The kernel tree I used in my tests is the result of merging the
> following commits:
> * commit 3dca2c2f3d3b�from git://git.kernel.dk/linux-block.git
>   ("Merge branch 'for-4.12/block' into for-next")
> * commit f88ab0c4b481 from git://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
>   ("scsi: libsas: fix ata xfer length")
> * commit ad0376eb1483 from git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>   ("Merge tag 'edac_for_4.11_2' of git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp")

Can we try and isolate it a bit - -rc4 alone, for instance?

-- 
Jens Axboe
