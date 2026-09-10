Received: from mta0.migadu.com (out-22.mta0.migadu.com [91.218.175.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB2472096
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044736; cv=none; b=MiYVl1J85PfNrtOABhSEjPUWd3BWrg7Q46SXLa1us1buLzyFY4/37f2m2HNukhOKPKn8iYozPbs8VlEFbKFbhiu7/bitr+rSBi8iay4L6Q8lMxN59pxouVZ6jeTchy9tVyNXFy+9GTTtAlPtamjN9BMykd8aKL4CckAhBD9DwTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044736; c=relaxed/simple;
	bh=EHQ2ejoB+cSbQ8A7VhST3DLKL+bxLmj8u16d+UPMvpU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=E9xh+G2S0ZFBcdNhABnQ8Uo05fapLEt/Ec/qs2xG1HyGJx9oUzdj0L4WjmIrBPQijvNOKBQFTwRQ+0wxztutYRVr6RYm2pI3n4PhQ6uADIxnmSjJqcNqoPZnEy3mH1pofhqGdW3zBGi1F/hD2IzsTKZE+/nxtSRCIoFFRPEN9bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JxR9OgtW; arc=none smtp.client-ip=91.218.175.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JxR9OgtW"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EHQ2ejoB+cSbQ8A7VhST3DLKL+bxLmj8u16d+UPMvpU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789044731; v=1; x=1789649531;
 b=JxR9OgtWxrtxnUETAVnHeNfngdZ0k58HYvdjgeTgLl4s3NDZST86IQzYe2R+dqh3lINILyCo
 nyYBnYT7CepDbMQ4NG7FNV8j6cERCA/FB/dR9WhIOcKUSQNLL4+F0VTPCmgZcPasydylbl7UEQT
 /XLU5Ku38EHQ75gqwq9Kat94=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 5a5742c41d523243;
	Thu, 10 Sep 2026 12:52:11 +0000
X-Mizu-Trace-ID: 5a5742c41d523243
X-Migadu-Flow: FLOW_OUT
Message-ID: <75f54355-8c69-4d02-9531-4ca85fac46a8@linux.dev>
Date: Thu, 10 Sep 2026 13:52:09 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: cap atomic write size by PI buffer size
 constraints
From: John Garry <john.garry@linux.dev>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org
References: <20260907074111.721054-1-hch@lst.de>
 <20260907074111.721054-3-hch@lst.de>
 <a17ccccc-a91c-4e45-a97e-d899c739e159@linux.dev>
 <20260910053636.GA27408@lst.de>
 <b800ecf7-1e78-4605-9db0-7bf891d8ca51@linux.dev>
Content-Language: en-US
In-Reply-To: <b800ecf7-1e78-4605-9db0-7bf891d8ca51@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/10/26 09:45, John Garry wrote:
>>>
>>> The expectation is that the driver sets atomic_write_hw_max,
>>> atomic_write_hw_unit_min, and atomic_write_hw_unit_max individually. We
>>> don't assume that atomic_write_hw_unit_max ==
>>> rounddown_pow_of_two(atomic_write_hw_max). The is because of SCSI and 
>>> it's
>>> granularity and alignment atomic limits 🙁
>>> Anyway, maybe this is a better change:
>>>
>>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>>> index 8274631290db..b88744d42719 100644
>>> --- a/block/blk-settings.c
>>> +++ b/block/blk-settings.c
>>> @@ -233,11 +233,15 @@ static void blk_atomic_writes_update_limits(struct
>>> queue_limits *lim)
>>>       unsigned int unit_limit = min(lim->max_hw_sectors << SECTOR_SHIFT,
>>> blk_queue_max_guaranteed_bio(lim));
>>>
>>> +    unit_limit = min_not_zero(unit_limit, max_integrity_io_size(lim));
>>>       unit_limit = rounddown_pow_of_two(unit_limit);
>>>
>>>       lim->atomic_write_max_sectors =
>>>           min(lim->atomic_write_hw_max >> SECTOR_SHIFT,
>>>               lim->max_hw_sectors);
>>> +    lim->atomic_write_max_sectors =
>>> +        min_not_zero(lim->atomic_write_max_sectors,
>>> +            max_integrity_io_size(lim));
>> This needs to be conditional on a non-zero lim->integrity.metadata_size.
>>
>> Otherwise this looks sane.
> 
> ok, I can add that.
> 
> I'd like to test this, I suppose scsi_debug is all I have to sanity test 
> this...

It's a bit tricky to test this, as max_integrity_io_size() >> 
atomic_write_unit_max normally and so I could not exceed that buffer 
with an atomic write.

However with these changes:

--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1806,7 +1806,7 @@ static inline int bio_split_rw_at(struct bio *bio,
  /*
   * Maximum contiguous integrity buffer allocation.
   */
-#define BLK_INTEGRITY_MAX_SIZE         SZ_2M
+#define BLK_INTEGRITY_MAX_SIZE         SZ_4K

--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -72,7 +72,7 @@ void bio_integrity_alloc_buf(struct bio *bio, gfp_t 
gfp, bool zero_buffer)
         unsigned int len = bio_integrity_bytes(bi, bio_sectors(bio));
         void *buf;

-       buf = kmalloc(len, gfp | __GFP_NOWARN | (zero_buffer ? 
__GFP_ZERO : 0));
+       buf = NULL;//kmalloc(len, gfp | __GFP_NOWARN | (zero_buffer ? 
__GFP_ZERO : 0));
         if (unlikely(!buf)) {
                 struct page *page;

I can trigger a KASAN use-after-free report:

# cat /sys/block/sda/queue/atomic_write_unit_max_bytes
524288
# xfs_io -d -C "pwrite -b 64k -V 1 -A -D 0 64k" /dev/sda
wrote 65536/65536 bytes at offset 0
64 KiB, 1 ops; 0.0512 sec (1.220 MiB/sec and 19.5164 ops/sec)
# xfs_io -d -C "pwrite -b 512k -V 1 -A -D 0 512k" /dev/sda
[   39.779692] 
==================================================================
[   39.779698] BUG: KASAN: use-after-free in 
blk_integrity_iterate+0x18d5/0x1bb0
[   39.779724] Write of size 2 at addr ffff888118160000 by task xfs_io/244
[   39.779726]
[   39.779729] CPU: 3 UID: 0 PID: 244 Comm: xfs_io Not tainted 
7.3.0-rc2-00042-gb7b6d996bb84-dirty #1238 PREEMPT(lazy)
[   39.779732] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
1.16.3-debian-1.16.3-2 04/01/2014
[   39.779734] Call Trace:
[   39.779736]  <TASK>
[   39.779737]  dump_stack_lvl+0x68/0xa0
[   39.779743]  print_report+0x10d/0x5d0
[   39.779747]  ? __virt_addr_valid+0x21e/0x3f0
[   39.779752]  ? blk_integrity_iterate+0x18d5/0x1bb0
[   39.779754]  kasan_report+0x96/0xd0
[   39.779757]  ? blk_integrity_iterate+0x18d5/0x1bb0
[   39.779760]  blk_integrity_iterate+0x18d5/0x1bb0
[   39.779764]  ? alloc_pages_noprof+0x25/0x70
[   39.779766]  ? mempool_alloc_noprof+0x129/0x1f0
[   39.779770]  ? __pfx_blk_integrity_iterate+0x10/0x10
[   39.779774]  ? bio_integrity_alloc_buf+0x191/0x4a0
[   39.779776]  ? bio_integrity_init+0x25/0xf0
[   39.779779]  blk_mq_submit_bio+0xc21/0x2600
[   39.779784]  ? __pfx_blk_mq_submit_bio+0x10/0x10
[   39.779786]  ? kasan_save_stack+0x34/0x50
[   39.779788]  ? kasan_save_stack+0x24/0x50
[   39.779801]  ? __pfx_iov_iter_extract_pages+0x10/0x10
[   39.779805]  ? __blkdev_direct_IO_simple+0xb5/0x910
[   39.779809]  ? blkdev_write_iter+0x707/0xb80
[   39.779811]  ? do_iter_readv_writev+0x3e4/0x7b0
[   39.779814]  ? __pfx_blk_cgroup_bio_start+0x10/0x10
[   39.779818]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   39.779822]  submit_bio_noacct_nocheck+0x474/0xab0
[   39.779826]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
[   39.779829]  ? submit_bio_noacct+0x5bb/0x1330
[   39.779832]  bio_await+0x160/0x190
[   39.779835]  ? __pfx_bio_await+0x10/0x10
[   39.779836]  ? find_held_lock+0x2b/0x80
[   39.779842]  submit_bio_wait+0x11/0x50
[   39.779844]  __blkdev_direct_IO_simple+0x404/0x910
[   39.779847]  ? __pfx___blkdev_direct_IO_simple+0x10/0x10
[   39.779850]  ? __pfx_bio_wait_end_io+0x10/0x10
[   39.779853]  ? inode_set_ctime_current+0x7e/0x610
[   39.779856]  ? inode_set_ctime_to_ts+0xf8/0x330
[   39.779858]  ? __pfx_inode_set_ctime_to_ts+0x10/0x10
[   39.779861]  ? ktime_get_coarse_real_ts64_mg+0x196/0x230
[   39.779864]  ? inode_set_ctime_current+0x7e/0x610
[   39.779867]  blkdev_direct_IO+0xa73/0x1e10
[   39.779870]  ? inode_maybe_inc_iversion+0xe3/0x1a0
[   39.779874]  ? __pfx_inode_maybe_inc_iversion+0x10/0x10
[   39.779876]  ? lock_acquire+0x185/0x2e0
[   39.779880]  ? __pfx_blkdev_direct_IO+0x10/0x10
[   39.779882]  ? __mark_inode_dirty+0x95d/0x10c0
[   39.779886]  ? generic_update_time+0x8c/0xf0
[   39.779888]  blkdev_write_iter+0x707/0xb80
[   39.779892]  do_iter_readv_writev+0x3e4/0x7b0
[   39.779895]  ? __pfx_do_iter_readv_writev+0x10/0x10
[   39.779897]  ? folio_add_lru_vma+0x15b/0x1d0
[   39.779901]  ? selinux_file_permission+0x361/0x4d0
[   39.779905]  vfs_writev+0x269/0xb40
[   39.779907]  ? lock_release+0xc9/0x290
[   39.779911]  ? __pfx_vfs_writev+0x10/0x10
[   39.779913]  ? lock_vma_under_rcu+0x2e1/0x960
[   39.779917]  ? lock_release+0x124/0x290
[   39.779920]  ? lock_vma_under_rcu+0x2eb/0x960
[   39.779925]  ? do_pwritev+0x144/0x220
[   39.779927]  do_pwritev+0x144/0x220
[   39.779929]  ? __pfx_do_pwritev+0x10/0x10
[   39.779931]  ? irqentry_exit+0xf8/0x860
[   39.779934]  ? trace_hardirqs_on_prepare+0x11d/0x150
[   39.779937]  ? irqentry_exit+0x112/0x860
[   39.779940]  do_syscall_64+0x11a/0x610
[   39.779943]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   39.779946] RIP: 0033:0x7f391f1c9727
[

...

Now I'll fix that patch as suggested and retest.
