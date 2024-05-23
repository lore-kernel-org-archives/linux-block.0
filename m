Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A4417EF;
	Thu, 23 May 2024 01:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716426799; cv=none; b=slX7gEce0tzWVNfNafvCJmReDQx5KLEUQ0D9PkdjzW2iOlhCSMBt3ML/qguw2Vi9fm4tvgu5m9b2Gor7iy7iJmOsGx/CCGePgXc4xk9le9psmXsVNldLeC0KoMXLc0kcCKTrX0abx8l06/VvBabilAkYwj/l/Rfoe0azRJP/4xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716426799; c=relaxed/simple;
	bh=uk0dhUH7Tl+BGR0/TQ3xckwGBxB5edtNoSpUztM1za0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Kp6Zy971Lv54ZrcaBOckfO7gorN9nCYrrKiHxQMKLH1jALoQV62UUYO2eXF5rF6QS6/JmeDsRWl8PhFnUg+MtC25pcjWpyt8cWJXJlyN+10b4nJVlhYVBulk7dneSxy9X8GKLaaC77eQn4VxT+Vekpk8mOTp32OjKFqslZlnjxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vl9CP5c5zz4f3jLf;
	Thu, 23 May 2024 09:13:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 967D41A0BF7;
	Thu, 23 May 2024 09:13:11 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g4lmE5m+VCqNQ--.42702S3;
	Thu, 23 May 2024 09:13:11 +0800 (CST)
Subject: Re: [PATCH V2 for-6.10/block 1/2] loop: Fix a race between loop
 detach and loop open
To: Gulam Mohamed <gulam.mohamed@oracle.com>,
 Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
 "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240521224249.7389-1-gulam.mohamed@oracle.com>
 <dcd2dac3-07d2-4ee8-addf-b9266a84f7fd@kernel.dk>
 <c7eb562c-97ae-455a-3859-0ed28ebdf7ae@huaweicloud.com>
 <IA1PR10MB7240AB2157B46F325669859D98EB2@IA1PR10MB7240.namprd10.prod.outlook.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3c1c654b-a80c-c257-4a36-863c4b148615@huaweicloud.com>
Date: Thu, 23 May 2024 09:13:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <IA1PR10MB7240AB2157B46F325669859D98EB2@IA1PR10MB7240.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g4lmE5m+VCqNQ--.42702S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZw45ArWrKF45XF4xKryrXrb_yoWrKw4xpF
	Z3WF42krWDKFsxCw12q3Wkuw1Sq3ZFqr48Wrn7G34fCr1qyFnIqFy2qryY9FyjgrW8Aa1j
	vr1UXrW3u34UArUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
	UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/05/23 3:12, Gulam Mohamed 写道:
> Hi Kuai,
> 
>> -----Original Message-----
>> From: Yu Kuai <yukuai1@huaweicloud.com>
>> Sent: Wednesday, May 22, 2024 8:01 AM
>> To: Jens Axboe <axboe@kernel.dk>; Gulam Mohamed
>> <gulam.mohamed@oracle.com>; linux-block@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Cc: shinichiro.kawasaki@wdc.com; chaitanyak@nvidia.com; hch@lst.de;
>> yukuai (C) <yukuai3@huawei.com>
>> Subject: Re: [PATCH V2 for-6.10/block 1/2] loop: Fix a race between loop
>> detach and loop open
>>
>> Hi,
>>
>> 在 2024/05/22 9:39, Jens Axboe 写道:
>>> On 5/21/24 4:42 PM, Gulam Mohamed wrote:
>>>> Description
>>>> ===========
>>>>
>>>> 1. Userspace sends the command "losetup -d" which uses the open() call
>>>>      to open the device
>>>> 2. Kernel receives the ioctl command "LOOP_CLR_FD" which calls the
>>>>      function loop_clr_fd()
>>>> 3. If LOOP_CLR_FD is the first command received at the time, then the
>>>>      AUTOCLEAR flag is not set and deletion of the
>>>>      loop device proceeds ahead and scans the partitions (drop/add
>>>>      partitions)
>>>>
>>>> 	if (disk_openers(lo->lo_disk) > 1) {
>>>> 		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
>>>> 		loop_global_unlock(lo, true);
>>>> 		return 0;
>>>> 	}
>>>>
>>>>    4. Before scanning partitions, it will check to see if any partition of
>>>>       the loop device is currently opened
>>>>    5. If any partition is opened, then it will return EBUSY:
>>>>
>>>>       if (disk->open_partitions)
>>>> 		return -EBUSY;
>>>>    6. So, after receiving the "LOOP_CLR_FD" command and just before the
>> above
>>>>       check for open_partitions, if any other command
>>>>       (like blkid) opens any partition of the loop device, then the partition
>>>>       scan will not proceed and EBUSY is returned as shown in above code
>>>>    7. But in "__loop_clr_fd()", this EBUSY error is not propagated
>>>>    8. We have noticed that this is causing the partitions of the loop to
>>>>       remain stale even after the loop device is detached resulting in the
>>>>       IO errors on the partitions
>>>>
>>>> Fix
>>>> ---
>>>> Re-introduce the lo_open() call to restrict any process to open the
>>>> loop device when its being detached
>>>>
>>>> Test case
>>>> =========
>>>> Test case involves the following two scripts:
>>>>
>>>> script1.sh
>>>> ----------
>>>> while [ 1 ];
>>>> do
>>>> 	losetup -P -f /home/opt/looptest/test10.img
>>>> 	blkid /dev/loop0p1
>>>> done
>>>>
>>>> script2.sh
>>>> ----------
>>>> while [ 1 ];
>>>> do
>>>> 	losetup -d /dev/loop0
>>>> done
>>>>
>>>> Without fix, the following IO errors have been observed:
>>>>
>>>> kernel: __loop_clr_fd: partition scan of loop0 failed (rc=-16)
>>>> kernel: I/O error, dev loop0, sector 20971392 op 0x0:(READ) flags 0x80700
>>>>           phys_seg 1 prio class 0
>>>> kernel: I/O error, dev loop0, sector 108868 op 0x0:(READ) flags 0x0
>>>>           phys_seg 1 prio class 0
>>>> kernel: Buffer I/O error on dev loop0p1, logical block 27201, async page
>>>>           read
>>>>
>>>> V1->V2:
>>>> 	Added a test case, 010, in blktests in tests/loop/
>>>> Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
>>>> ---
>>>>    drivers/block/loop.c | 19 +++++++++++++++++++
>>>>    1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c index
>>>> 28a95fd366fe..9a235d8c062d 100644
>>>> --- a/drivers/block/loop.c
>>>> +++ b/drivers/block/loop.c
>>>> @@ -1717,6 +1717,24 @@ static int lo_compat_ioctl(struct block_device
>> *bdev, blk_mode_t mode,
>>>>    }
>>>>    #endif
>>>>
>>>> +static int lo_open(struct gendisk *disk, blk_mode_t mode) {
>>>> +        struct loop_device *lo = disk->private_data;
>>>> +        int err;
>>>> +
>>>> +        if (!lo)
>>>> +                return -ENXIO;
>>>> +
>>>> +        err = mutex_lock_killable(&lo->lo_mutex);
>>>> +        if (err)
>>>> +                return err;
>>>> +
>>>> +        if (lo->lo_state == Lo_rundown)
>>>> +                err = -ENXIO;
>>>> +        mutex_unlock(&lo->lo_mutex);
>>
>> This doesn't fix the problem completely, there is still a race window.
>>
>> lo_release
>>    if (disk_openers(disk) > 0)
>>     reutrn
>>     -> no openers now
>> 		lo_open
>> 		 if (lo->lo_state == Lo_rundown)
>> 		 -> no set yet
>> 		 open succeed
>>    mutex_lock(lo_mutex)
>>    lo->lo_state = Lo_rundown
>>    mutex_unlock(lo_mutex)
>>    __loop_clr_fd
> We have noticed that, at block layer, both open() and release() are protected by gendisk->open_mutex.
> So, this race may not happen. Can you please let me know if I understand correctly?

Yes, __loop_clr_fd from lo_release can't concurrent with lo_open.
>>
>> And with the respect, loop_clr_fd() has the same problem.

Did you check __loop_clr_fd from lo_ioctl?

Thanks,
Kuai

>>
>> I think probably loop need a open counter for itself.
> We are looking to see how to handle this case
>>
>> Thanks,
>> Kuai
>>
>>>> +	return err;
>>>> +}
>>>
>>> Most of this function uses spaces rather than tabs.
>>>
> 

