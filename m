Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C88EEC8;
	Mon, 11 Aug 2025 01:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754875226; cv=none; b=MzEvSOTjw74GflfX5gC5a3ybufUQdXIF04cSGi9z9ZXBzmR8lCNVTgTs0JDwSMzf9TnqBacUKkXtuDu/kaMFypvxXS7imTs/WswIkV2RQLMfs8kGCedldoNFMRGN0fYnHgZYyQAI7O+YUmhCnED2/Cdq8NafolmSjlr97jheV4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754875226; c=relaxed/simple;
	bh=UhQT8nVI8Py8OeW5cye4pFlNMOZbWaWHVBpeWTnpFOw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OimOSq0DYZXrmeTEz+DZvzSoEdP4XZDG3pzmpVBYsj3fKx+bbc9QM1X1rDmOIbyRgC+/Uilg2V2ydtikfmUb22PKo8E7xIhEOBQGO54qHGzYXHnRqhmxPFzL00aSHLpywnSi3rIHvUcjmKwEjEkFxWQMcreKUn7B3Y51XWukP+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c0cJM2QGyzKHMmn;
	Mon, 11 Aug 2025 09:20:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 875221A1A5A;
	Mon, 11 Aug 2025 09:20:18 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB3QBFQRZlo4OAXDQ--.54961S3;
	Mon, 11 Aug 2025 09:20:18 +0800 (CST)
Subject: Re: [PATCH 1/1] loop: sync filesystem cache before getting file size
 in get_size()
To: "Mishra, Rajeev" <rajeevm@hpe.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250807232522.192898-1-rajeevm@hpe.com>
 <756e15de-dbbc-4438-80c6-454b2fcc44ac@huaweicloud.com>
 <PH7PR84MB2079A6A4EFE799BCA7E5738CAA2FA@PH7PR84MB2079.NAMPRD84.PROD.OUTLOOK.COM>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7b4fbe4b-d89d-6037-9ee6-33ced5dc0b64@huaweicloud.com>
Date: Mon, 11 Aug 2025 09:20:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <PH7PR84MB2079A6A4EFE799BCA7E5738CAA2FA@PH7PR84MB2079.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3QBFQRZlo4OAXDQ--.54961S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy5CF1kAFW5ZrW7Ar4kXrb_yoW7ZrWxpF
	W5ta4YkrykGF17GwsrZw47Z3yFg34xury5Wry7Jw4xZF90kr1a9F93KFWYgFWDXr97C3WY
	q3yDtr929ryUZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/09 2:50, Mishra, Rajeev 写道:
> Thanks, Kuai, for the quick review — I really appreciate it. Please let me know if you have any questions or if I missed addressing anything.
> My response to queries is inline below.
> Rajeev
> 
> From: Yu Kuai <yukuai1@huaweicloud.com>
> Date: Thursday, August 7, 2025 at 9:48 PM
> To: Mishra, Rajeev <rajeevm@hpe.com>, axboe@kernel.dk <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>, yukuai (C) <yukuai3@huawei.com>
> Subject: Re: [PATCH 1/1] loop: sync filesystem cache before getting file size in get_size()
> Hi,
> 
> 在 2025/08/08 7:25, Rajeev Mishra 写道:
>> The get_size() function now uses vfs_getattr_nosec() with AT_STATX_SYNC_AS_STAT
> 
> With a quick code review, I didn't found how can that flag ensure
> filesystem cache is synchronized, can you explain in detail? Or Do you
> mean getattr for filesystem like fuse to get latest data from server?
> Response ---
>>> Thanks for the quick review. The AT_STATX_SYNC_AS_STAT flag tells
>>> the VFS layer to synchronize cached metadata before returning file attributes.
>>> This is particularly important for distributed/network filesystems where
>>> the local cache may not reflect the current file size on the server.
> ---

I think this is the default behavior, unless AT_STATX_DONT_SYNC is set.
So I think you don't need to emphasize the flag AT_STATX_SYNC_AS_STAT,
otherwise, at least I will think if the flag is not set, cache won't be
synchronized.

> 
>> to ensure filesystem cache is synchronized before retrieving file size. This
>> provides more accurate size information, especially when:
>>
>> - The backing file size has been changed by another process
>> - The file is on a network filesystem (NFS, CIFS, etc.)
>> - The file is being modified concurrently
> 
> I don't think this make sense in real world. If a file is already used
> by loop device, then user should avoid modifying this file directly. For
> a file in fuse, I feel it's not good to use it as loop device.
> Response---
>>> I encountered this issue specifically with Lustre filesystem during testing
>>> I did following --
>>> 1. File was created on Lustre
>>> 2. dd was done to write data on the file
>>> 3. ls confirmed the size
>>> 4. Loop device setup was done on the file immediately
>>> 5. write was issued with less space
>>> 6.above happened as file size was not correctly captured by loop device
> 
>>> I agree that network/distributed filesystems aren't ideal for loop devices,
>>> but they are used in practice (container images on shared storage, diskless
>>> systems, etc.). The fallback to i_size_read() ensures no performance penalty
>>> for local filesystems while improving reliability for network filesystems.

Ok, I agree with this case, can you please just keep the network
filesystem, and remove the description about concurrent modifying of
loop file?

> ____
> 
>> - The most accurate size is needed for loop device setup
>>> The implementation gracefully falls back to i_size_read() if
> vfs_getattr_nosec()
>> fails, maintaining backward compatibility.
> Response –
> ___
>>>> you mean using the flag sync has backward compatibility issue ? or using function itself ?

Nevermind, this is from your orginal patch, I somehow added a new line
break.
> ___
> 
>>>
>> Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
>> ---
>>    drivers/block/loop.c | 31 +++++++++++++++++++++++++++++--
>>    1 file changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 1b6ee91f8eb9..15d5edbc69ce 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -137,12 +137,39 @@ static void loop_global_unlock(struct loop_device *lo, bool global)
>>    static int max_part;
>>    static int part_shift;
>>
>> +/**
>> + * get_size - calculate the effective size of a loop device
>> + * @offset: offset into the backing file
>> + * @sizelimit: user-specified size limit
>> + * @file: the backing file
>> + *
>> + * Calculate the effective size of the loop device
>> + *
>> + * Returns: size in 512-byte sectors, or 0 if invalid
>> + */
>>    static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
>>    {
>> +     struct kstat stat;
>>         loff_t loopsize;
>> +     int ret;
>> +
>> +     /*
>> +      * Get file attributes for validation. We use vfs_getattr() to ensure
>> +      * we have up-to-date file size information.
>> +      */
>> +     ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE,
>> +                             AT_STATX_SYNC_AS_STAT);
>> +     if (ret) {
>> +             /*
>> +              * If we can't get attributes, fall back to i_size_read()
>> +              * which should work for most cases.
>> +              */
>> +             loopsize = i_size_read(file->f_mapping->host);
>> +     } else {
>> +             /* Use the size from getattr for consistency */
>> +             loopsize = stat.size;
>> +     }
> 
> I'm ok switch from i_size_read() to getattr, however, the commit message
> is confusing for me :(
> 
> Response --
>>> I will make the commit message clear and simple. Just wanted to understand
>>> if using this will be good “vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);”
>>> is good I will replace i_size_read() with above code
>>> do let me know if this will have any backward compatibility issue
>>> Thanks again for your help

I'm good, and i_size_read() is not needed anymore.

Thanks,
Kuai

> 
> 
> Thanks,
> Kuai
>>
>> -     /* Compute loopsize in bytes */
>> -     loopsize = i_size_read(file->f_mapping->host);
>>         if (offset > 0)
>>                 loopsize -= offset;
>>         /* offset is beyond i_size, weird but possible */
>>

