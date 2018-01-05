Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751109AbeAEMP7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jan 2018 07:15:59 -0500
Subject: Re: [PATCH v5] Return bytes transferred for partial direct I/O
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20171122122901.32201-1-rgoldwyn@suse.de>
 <20180105021041.GA5597@magnolia>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <2c45b676-f687-8136-7ae9-7f551bbc0b4e@suse.de>
Date: Fri, 5 Jan 2018 06:15:55 -0600
MIME-Version: 1.0
In-Reply-To: <20180105021041.GA5597@magnolia>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 01/04/2018 08:10 PM, Darrick J. Wong wrote:
> On Wed, Nov 22, 2017 at 06:29:01AM -0600, Goldwyn Rodrigues wrote:
>> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>>
>> In case direct I/O encounters an error midway, it returns the error.
>> Instead it should be returning the number of bytes transferred so far.
>>
>> Test case for filesystems (with ENOSPC):
>> 1. Create an almost full filesystem
>> 2. Create a file, say /mnt/lastfile, until the filesystem is full.
>> 3. Direct write() with count > sizeof /mnt/lastfile.
>>
>> Result: write() returns -ENOSPC. However, file content has data written
>> in step 3.
>>
>> Changes since v1:
>>  - incorporated iomap and block devices
>>
>> Changes since v2:
>>  - realized that file size was not increasing when performing a (partial)
>>    direct I/O because end_io function was receiving the error instead of
>>    size. Fixed.
>>
>> Changes since v3:
>>  - [hch] initialize transferred with dio->size and use transferred instead
>>    of dio->size.
>>
>> Changes since v4:
>>  - Refreshed to v4.14
>>
>> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Hmmm, I shoved this into 4.15-rc6 and saw this horrible splat running
> generic/472 (that is the test that goes with this patch, right?) on XFS:

Yes, I will add it to the patch header.

> 
> [ 2545.534331] XFS: Assertion failed: ret < 0 || ret == count, file: /storage/home/djwong/cdev/work/linux-xfs/fs/xfs/xfs_file.c, line: 598
> [ 2545.538177] WARNING: CPU: 2 PID: 16340 at /storage/home/djwong/cdev/work/linux-xfs/fs/xfs/xfs_message.c:116 assfail+0x58/0x90 [xfs]
> [ 2545.539748] Modules linked in: xfs libcrc32c dax_pmem device_dax nd_pmem sch_fq_codel af_packet [last unloaded: xfs]
> [ 2545.541191] CPU: 2 PID: 16340 Comm: xfs_io Not tainted 4.15.0-rc6-xfsx #5
> [ 2545.542119] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1ubuntu1djwong0 04/01/2014
> [ 2545.543414] RIP: 0010:assfail+0x58/0x90 [xfs]
> [ 2545.544032] RSP: 0018:ffff88002b56f990 EFLAGS: 00010246
> [ 2545.544760] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [ 2545.545721] RDX: 0000000000000004 RSI: 000000000000000a RDI: ffffffffa0a1eac4
> [ 2545.546681] RBP: ffff88002b56fdd0 R08: ffff88002b56f6e0 R09: 0000000000000000
> [ 2545.547646] R10: 1ffff1000fe14f6e R11: 0000000000000000 R12: 1ffff100056adf3a
> [ 2545.548613] R13: 0000000000400000 R14: ffff88002b56fc38 R15: 0000000000000000
> [ 2545.549579] FS:  00007fc1f601e700(0000) GS:ffff88007f000000(0000) knlGS:0000000000000000
> [ 2545.550666] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2545.551460] CR2: 00007fc1f4bac000 CR3: 0000000075165001 CR4: 00000000001606e0
> [ 2545.552423] Call Trace:
> [ 2545.552850]  xfs_file_dio_aio_write+0x6e3/0xe40 [xfs]
> [ 2545.553581]  ? kvm_clock_read+0x1f/0x30
> [ 2545.554191]  ? xfs_file_dax_write+0x6a0/0x6a0 [xfs]
> [ 2545.554885]  ? kvm_clock_read+0x1f/0x30
> [ 2545.555439]  ? kvm_sched_clock_read+0x5/0x10
> [ 2545.556046]  ? sched_clock+0x5/0x10
> [ 2545.556553]  ? sched_clock_cpu+0x18/0x1e0
> [ 2545.557136]  ? __lock_acquire+0xbbf/0x40f0
> [ 2545.557719]  ? kvm_clock_read+0x1f/0x30
> [ 2545.558272]  ? sched_clock+0x5/0x10
> [ 2545.558848]  xfs_file_write_iter+0x34a/0xb50 [xfs]
> [ 2545.559544]  do_iter_readv_writev+0x44c/0x700
> [ 2545.560170]  ? _copy_from_user+0x96/0xd0
> [ 2545.560729]  ? vfs_dedupe_file_range+0x820/0x820
> [ 2545.561398]  do_iter_write+0x12c/0x550
> [ 2545.561939]  ? rcu_lockdep_current_cpu_online+0xd7/0x120
> [ 2545.562682]  ? rcu_read_lock_sched_held+0xa3/0x120
> [ 2545.563366]  vfs_writev+0x175/0x2d0
> [ 2545.563874]  ? vfs_iter_write+0xc0/0xc0
> [ 2545.564434]  ? get_lock_stats+0x16/0x90
> [ 2545.564992]  ? lock_downgrade+0x580/0x580
> [ 2545.565583]  ? __fget+0x1e7/0x350
> [ 2545.566077]  ? entry_SYSCALL_64_fastpath+0x5/0x96
> [ 2545.566744]  ? do_pwritev+0x125/0x160
> [ 2545.567277]  do_pwritev+0x125/0x160
> [ 2545.567787]  entry_SYSCALL_64_fastpath+0x1f/0x96
> [ 2545.568437] RIP: 0033:0x7fc1f56d6110
> [ 2545.568948] RSP: 002b:00007ffc07f11340 EFLAGS: 00000293 ORIG_RAX: 0000000000000128
> [ 2545.569971] RAX: ffffffffffffffda RBX: 0000000001ef9170 RCX: 00007fc1f56d6110
> [ 2545.570932] RDX: 0000000000000001 RSI: 0000000001ef9170 RDI: 0000000000000003
> [ 2545.571897] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000400000
> [ 2545.572857] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> [ 2545.573818] R13: 0000000000000000 R14: 0000000000400000 R15: 0000000001ef9170
> [ 2545.574802] Code: df 48 89 fa 48 c1 ea 03 0f b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 15 0f b6 1d d6 51 65 00 80 fb 01 77 1e 83 e3 01 75 0b <0f> ff 5b c3 e8 0f 59 1b e1 eb e4 0f 0b 48 c7 c7 20 40 8c a0 e8 
> [ 2545.577451] ---[ end trace 7bcb2da267d05648 ]---
> 
> I suspect that all we need to do is remove the ASSERT(ret...) at the bottom of
> xfs_file_dio_aio_write?

Yes, since there can be a short write in case the user attempts to
direct write beyond end of device. I will update this.

Thanks for testing.

> 
> --D
> 
>> ---
>>  fs/block_dev.c |  2 +-
>>  fs/direct-io.c |  4 +---
>>  fs/iomap.c     | 20 ++++++++++----------
>>  3 files changed, 12 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 789f55e851ae..4d3e4603f687 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -421,7 +421,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>>  
>>  	if (!ret)
>>  		ret = blk_status_to_errno(dio->bio.bi_status);
>> -	if (likely(!ret))
>> +	if (likely(dio->size))
>>  		ret = dio->size;
>>  
>>  	bio_put(&dio->bio);
>> diff --git a/fs/direct-io.c b/fs/direct-io.c
>> index b53e66d9abd7..a8d2710f4ee9 100644
>> --- a/fs/direct-io.c
>> +++ b/fs/direct-io.c
>> @@ -262,8 +262,6 @@ static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
>>  		ret = dio->page_errors;
>>  	if (ret == 0)
>>  		ret = dio->io_error;
>> -	if (ret == 0)
>> -		ret = transferred;
>>  
>>  	if (dio->end_io) {
>>  		// XXX: ki_pos??
>> @@ -310,7 +308,7 @@ static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
>>  	}
>>  
>>  	kmem_cache_free(dio_cache, dio);
>> -	return ret;
>> +	return transferred ? transferred : ret;
>>  }
>>  
>>  static void dio_aio_complete_work(struct work_struct *work)
>> diff --git a/fs/iomap.c b/fs/iomap.c
>> index d4801f8dd4fd..6e37acba578d 100644
>> --- a/fs/iomap.c
>> +++ b/fs/iomap.c
>> @@ -715,23 +715,23 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
>>  	struct kiocb *iocb = dio->iocb;
>>  	struct inode *inode = file_inode(iocb->ki_filp);
>>  	loff_t offset = iocb->ki_pos;
>> -	ssize_t ret;
>> +	ssize_t err;
>> +	ssize_t transferred = dio->size;
>>  
>>  	if (dio->end_io) {
>> -		ret = dio->end_io(iocb,
>> -				dio->error ? dio->error : dio->size,
>> +		err = dio->end_io(iocb,
>> +				transferred ? transferred : dio->error,
>>  				dio->flags);
>>  	} else {
>> -		ret = dio->error;
>> +		err = dio->error;
>>  	}
>>  
>> -	if (likely(!ret)) {
>> -		ret = dio->size;
>> +	if (likely(transferred)) {
>>  		/* check for short read */
>> -		if (offset + ret > dio->i_size &&
>> +		if (offset + transferred > dio->i_size &&
>>  		    !(dio->flags & IOMAP_DIO_WRITE))
>> -			ret = dio->i_size - offset;
>> -		iocb->ki_pos += ret;
>> +			transferred = dio->i_size - offset;
>> +		iocb->ki_pos += transferred;
>>  	}
>>  
>>  	/*
>> @@ -758,7 +758,7 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
>>  	inode_dio_end(file_inode(iocb->ki_filp));
>>  	kfree(dio);
>>  
>> -	return ret;
>> +	return transferred ? transferred : err;
>>  }
>>  
>>  static void iomap_dio_complete_work(struct work_struct *work)
>> -- 
>> 2.14.2
>>

-- 
Goldwyn
