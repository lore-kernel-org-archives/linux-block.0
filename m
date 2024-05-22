Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9296339A8;
	Wed, 22 May 2024 02:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716345076; cv=none; b=o6+zAXhPPjQoZff7bHfYh0cs/YKMEyP95+6WbspTHakmmoRPt6SKYMGUBLRbgVIZEg1X6tU+H6Jg/dUGzyddN/UA7NazHgkqeDGYy50adZuuYTSlHj7fD4yIjnucYkfFzyohAVhv7tyFW6S+X3eDgvbCmRnDbuMUwe212bSgx9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716345076; c=relaxed/simple;
	bh=dCWpHDIGxN8+JH6x/Fr1QOyLBL0zIKxdojXzZXnoBWs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pbDbomx4+6PWGJU4HqYI0dqzvDr+Y4XJ2RACiI+DmAU/BBstJrALjTLmRVhmGvdAPo6Q/xudw7qMbnsPRC4M3NuQV7eUpzUk5H8SrzXbvQSkTrgPh+aDHDkcPT4KugEiG5tuvsxdN4RUxrwihUUEzwe8R3p/kP0c2uyViTydNNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VkZzn672Vz4f3kK0;
	Wed, 22 May 2024 10:31:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A003A1A0199;
	Wed, 22 May 2024 10:31:07 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxDlWE1mfUNSNQ--.47117S3;
	Wed, 22 May 2024 10:31:03 +0800 (CST)
Subject: Re: [PATCH V2 for-6.10/block 1/2] loop: Fix a race between loop
 detach and loop open
To: Jens Axboe <axboe@kernel.dk>, Gulam Mohamed <gulam.mohamed@oracle.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, hch@lst.de,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240521224249.7389-1-gulam.mohamed@oracle.com>
 <dcd2dac3-07d2-4ee8-addf-b9266a84f7fd@kernel.dk>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c7eb562c-97ae-455a-3859-0ed28ebdf7ae@huaweicloud.com>
Date: Wed, 22 May 2024 10:31:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <dcd2dac3-07d2-4ee8-addf-b9266a84f7fd@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxDlWE1mfUNSNQ--.47117S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGF47XF4fAryDury3tw18Xwb_yoW5KFWDpF
	Z3WFW2kryDKa9xWw12vF1xu3WFq3Z2yrWrGrn7C34SkrnFyFnavFy2vryY9a4jgrW0kayj
	vF1UWrWUuFWUCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/05/22 9:39, Jens Axboe 写道:
> On 5/21/24 4:42 PM, Gulam Mohamed wrote:
>> Description
>> ===========
>>
>> 1. Userspace sends the command "losetup -d" which uses the open() call
>>     to open the device
>> 2. Kernel receives the ioctl command "LOOP_CLR_FD" which calls the
>>     function loop_clr_fd()
>> 3. If LOOP_CLR_FD is the first command received at the time, then the
>>     AUTOCLEAR flag is not set and deletion of the
>>     loop device proceeds ahead and scans the partitions (drop/add
>>     partitions)
>>
>> 	if (disk_openers(lo->lo_disk) > 1) {
>> 		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
>> 		loop_global_unlock(lo, true);
>> 		return 0;
>> 	}
>>
>>   4. Before scanning partitions, it will check to see if any partition of
>>      the loop device is currently opened
>>   5. If any partition is opened, then it will return EBUSY:
>>
>>      if (disk->open_partitions)
>> 		return -EBUSY;
>>   6. So, after receiving the "LOOP_CLR_FD" command and just before the above
>>      check for open_partitions, if any other command
>>      (like blkid) opens any partition of the loop device, then the partition
>>      scan will not proceed and EBUSY is returned as shown in above code
>>   7. But in "__loop_clr_fd()", this EBUSY error is not propagated
>>   8. We have noticed that this is causing the partitions of the loop to
>>      remain stale even after the loop device is detached resulting in the
>>      IO errors on the partitions
>>
>> Fix
>> ---
>> Re-introduce the lo_open() call to restrict any process to open the loop
>> device when its being detached
>>
>> Test case
>> =========
>> Test case involves the following two scripts:
>>
>> script1.sh
>> ----------
>> while [ 1 ];
>> do
>> 	losetup -P -f /home/opt/looptest/test10.img
>> 	blkid /dev/loop0p1
>> done
>>
>> script2.sh
>> ----------
>> while [ 1 ];
>> do
>> 	losetup -d /dev/loop0
>> done
>>
>> Without fix, the following IO errors have been observed:
>>
>> kernel: __loop_clr_fd: partition scan of loop0 failed (rc=-16)
>> kernel: I/O error, dev loop0, sector 20971392 op 0x0:(READ) flags 0x80700
>>          phys_seg 1 prio class 0
>> kernel: I/O error, dev loop0, sector 108868 op 0x0:(READ) flags 0x0
>>          phys_seg 1 prio class 0
>> kernel: Buffer I/O error on dev loop0p1, logical block 27201, async page
>>          read
>>
>> V1->V2:
>> 	Added a test case, 010, in blktests in tests/loop/
>> Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
>> ---
>>   drivers/block/loop.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 28a95fd366fe..9a235d8c062d 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -1717,6 +1717,24 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
>>   }
>>   #endif
>>   
>> +static int lo_open(struct gendisk *disk, blk_mode_t mode)
>> +{
>> +        struct loop_device *lo = disk->private_data;
>> +        int err;
>> +
>> +        if (!lo)
>> +                return -ENXIO;
>> +
>> +        err = mutex_lock_killable(&lo->lo_mutex);
>> +        if (err)
>> +                return err;
>> +
>> +        if (lo->lo_state == Lo_rundown)
>> +                err = -ENXIO;
>> +        mutex_unlock(&lo->lo_mutex);

This doesn't fix the problem completely, there is still a race window.

lo_release
  if (disk_openers(disk) > 0)
   reutrn
   -> no openers now
		lo_open
		 if (lo->lo_state == Lo_rundown)
		 -> no set yet
		 open succeed
  mutex_lock(lo_mutex)
  lo->lo_state = Lo_rundown
  mutex_unlock(lo_mutex)
  __loop_clr_fd

And with the respect, loop_clr_fd() has the same problem.

I think probably loop need a open counter for itself.

Thanks,
Kuai

>> +	return err;
>> +}
> 
> Most of this function uses spaces rather than tabs.
> 

