Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D912D47EC;
	Wed, 20 Aug 2025 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674253; cv=none; b=fIlPaE318Tg3Y2DwhUMrNzabKkZ1oToB1je2T+9MbyFnAGOS7D0LZYkkfef0GkR9pfTKpYsmcD3Tma/JCyr8LLc3mT6fCa+aa/r4vrPUDp8rV0FBw96abbuXyCYrG3/JCptzs1KlDU7vkabHKVysqtcGsvJ819faVbJDI93SYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674253; c=relaxed/simple;
	bh=/hMuwaw0YjNgzvK7Y9kbzjTsaSP+6iMcqRG6g1drqY4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=s/r8BTiQd0/FROZiHbODY1fgfojz5ZNBgv8eO5X8j60+rs8YqmzPrUhxZXMV+n+zXU0q5umwYWEJkOhaw8UN2oza57CVWgG9K8KWxWEf6ulf67bMD2nLHPtvlBRdiUhKVkI1jHUN57RjjqzDWLuF3eq3Emp+O8eLQ7C1k6Wk7Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c6HpC2xJnzYQvwW;
	Wed, 20 Aug 2025 15:17:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F1A721A0D9D;
	Wed, 20 Aug 2025 15:17:21 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDXUxR8dqVojjU0EQ--.55551S3;
	Wed, 20 Aug 2025 15:17:18 +0800 (CST)
Subject: Re: [PATCH v4 2/2] loop: use vfs_getattr_nosec for accurate file size
To: kernel test robot <oliver.sang@intel.com>, Rajeev Mishra <rajeevm@hpe.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-block@vger.kernel.org,
 axboe@kernel.dk, yukuai1@huaweicloud.com, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <202508200409.b2459c02-lkp@intel.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <79ab5533-82d1-4f06-461b-689e94f738ec@huaweicloud.com>
Date: Wed, 20 Aug 2025 15:17:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202508200409.b2459c02-lkp@intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXUxR8dqVojjU0EQ--.55551S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4DJr4DArWxGw1DZryDAwb_yoWrGry5pa
	y8WF4Ykrs5Gr1xAr4kArnrZ34jq393XFWj9r4UX3sFva1ayr9rZr92vrW3Xws0vr9YgrWY
	q3Z7Wryj9r4ruaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/20 12:55, kernel test robot Ð´µÀ:
> 
> 
> Hello,
> 
> kernel test robot noticed "xfstests.generic.563.fail" on:
> 
> commit: fb455b8a6ac932603a8c0dbb787f8330b0924834 ("[PATCH v4 2/2] loop: use vfs_getattr_nosec for accurate file size")
> url: https://github.com/intel-lab-lkp/linux/commits/Rajeev-Mishra/loop-use-vfs_getattr_nosec-for-accurate-file-size/20250815-031401
> base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
> patch link: https://lore.kernel.org/all/20250814191004.60340-2-rajeevm@hpe.com/
> patch subject: [PATCH v4 2/2] loop: use vfs_getattr_nosec for accurate file size
> 
> in testcase: xfstests
> version: xfstests-x86_64-e1e4a0ea-1_20250714
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: ext4
> 	test: generic-563
> 
> 
> 
> config: x86_64-rhel-9.4-func
> compiler: gcc-12
> test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202508200409.b2459c02-lkp@intel.com
> 
> 2025-08-17 21:02:18 export TEST_DIR=/fs/sda1
> 2025-08-17 21:02:18 export TEST_DEV=/dev/sda1
> 2025-08-17 21:02:18 export FSTYP=ext4
> 2025-08-17 21:02:18 export SCRATCH_MNT=/fs/scratch
> 2025-08-17 21:02:18 mkdir /fs/scratch -p
> 2025-08-17 21:02:18 export SCRATCH_DEV=/dev/sda4
> 2025-08-17 21:02:18 echo generic/563
> 2025-08-17 21:02:18 ./check -E tests/exclude/ext4 generic/563
> FSTYP         -- ext4
> PLATFORM      -- Linux/x86_64 lkp-skl-d03 6.17.0-rc1-00020-gfb455b8a6ac9 #1 SMP PREEMPT_DYNAMIC Mon Aug 18 03:05:49 CST 2025
> MKFS_OPTIONS  -- -F /dev/sda4
> MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /fs/scratch
> 
> generic/563       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//generic/563.out.bad)
>      --- tests/generic/563.out	2025-07-14 17:48:52.000000000 +0000
>      +++ /lkp/benchmarks/xfstests/results//generic/563.out.bad	2025-08-17 21:02:31.367411171 +0000
>      @@ -1,14 +1 @@
>       QA output created by 563
>      -read/write
>      -read is in range
>      -write is in range
>      -write -> read/write
>      -read is in range
>      -write is in range
>      ...
>      (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/563.out /lkp/benchmarks/xfstests/results//generic/563.out.bad'  to see the entire diff)
> Ran: generic/563
> Failures: generic/563
> Failed 1 of 1 tests
> 

This can be reporduce with just losetup /dev/loop0 /dev/sda, root cause
is that /dev/sda is from devtmpfs wherer the get_attr method for
is shmem_getattr, hence stat->size will be set to zero.

In vfs_getattr_nosec(), is the inode is block device, bdev_statx will be
called to override the result, however, STATX_SIZE is not handled here,
I feel handle STATX_SIZE in bdev_statx will make sense:

diff --git a/block/bdev.c b/block/bdev.c
index b77ddd12dc06..9672bb6ec4ad 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1324,6 +1324,9 @@ void bdev_statx(const struct path *path, struct 
kstat *stat, u32 request_mask)
         if (!bdev)
                 return;

+       if (request_mask & STATX_SIZE)
+               stat->size = bdev_nr_bytes(bdev);
+
         if (request_mask & STATX_DIOALIGN) {
                 stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
                 stat->dio_offset_align = bdev_logical_block_size(bdev);

Thanks,
Kuai

> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250820/202508200409.b2459c02-lkp@intel.com
> 
> 
> 

