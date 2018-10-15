Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-um@lists.infradead.org, anton.ivanov@cambridgegreys.com, dwalter@google.com
Subject: Re: [PATCH, RFC] ubd: remove use of blk_rq_map_sg
Date: Mon, 15 Oct 2018 22:42:47 +0200
Message-ID: <1771273.Wvapsmo5cm@blindfold>
In-Reply-To: <20263939.GgfHUqOn1T@blindfold>
References: <20181015065637.1860-1-hch@lst.de> <20181015084541.GA27159@lst.de> <20263939.GgfHUqOn1T@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

Am Montag, 15. Oktober 2018, 21:17:46 CEST schrieb Richard Weinberger:
> Am Montag, 15. Oktober 2018, 10:45:41 CEST schrieb Christoph Hellwig:
> > On Mon, Oct 15, 2018 at 10:40:06AM +0200, Richard Weinberger wrote:
> > > hm, this breaks UML.
> > > Every filesystem fails to mount.
> > > 
> > > I did some very rough tests, it seems that the driver fails to read
> > > data correctly as soon the upper layer tries to get more than 4096 bytes
> > > at once out of the block device.
> > > 
> > > IOW:
> > > dd if=/dev/ubda bs=4096 count=1 skip=0 2>/dev/null| md5sum -
> > > is good.
> > > As soon I set bs to something greater it returns garbage.
> > > 
> > > Later this day I might have some cycles left to debug further.
> > 
> > It probably needs this on top:
> 
> Sadly not. I'm checking now what exactly is broken.

I take this back. Christoph's fixup makes reading work.
The previous version corrupted my test block device in interesting ways
and confused all tests.
But the removal of blk_rq_map_sg() still has issues.
Now the device blocks endless upon flush.

:/ # cat /proc/251/stack
[<0>] __switch_to+0x56/0x85
[<0>] __schedule+0x427/0x472
[<0>] schedule+0x7c/0x95
[<0>] schedule_timeout+0x2b/0x1d2
[<0>] io_schedule_timeout+0x2b/0x48
[<0>] wait_for_common_io.constprop.2+0xdd/0x154
[<0>] wait_for_completion_io+0x1a/0x1c
[<0>] submit_bio_wait+0x5b/0x74
[<0>] blkdev_issue_flush+0x95/0xc3
[<0>] jbd2_journal_recover+0xe4/0xf6
[<0>] jbd2_journal_load+0x183/0x3b2
[<0>] ext4_fill_super+0x23e0/0x3602
[<0>] mount_bdev+0x18f/0x1f8
[<0>] ext4_mount+0x1a/0x1c
[<0>] mount_fs+0x13/0xf6
[<0>] vfs_kern_mount+0x78/0x139
[<0>] do_mount+0x874/0xb48
[<0>] ksys_mount+0x99/0xc0
[<0>] sys_mount+0x10/0x14
[<0>] handle_syscall+0x79/0xa7
[<0>] userspace+0x487/0x514
[<0>] fork_handler+0x94/0x96
[<0>] 0xffffffffffffffff

Just checked, the number of calls to blk_mq_start_request()
matches the number of calls to __blk_mq_end_request().
So I don't really get what is being waited on.

Thanks,
//richard
