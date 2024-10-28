Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EEE1DDA0F
	for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730114109; cv=none; b=qF90+JG3CkEp3Bmzx0lAu5gnsUaKm5AjaPHfDxbw26/MHW7yorGjj8ru5X8ze0qkmU3tRcWwIY2Zdn+pFTzOwGSvOKYEKmGNs4ZLpq0pzEwVBQXzK8kgPP2zRojqSzIeNlkE+Gb1jc0ITyOC6vbBK8L4mLrtktPNCRlWkRPsc7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730114109; c=relaxed/simple;
	bh=T3ZYgT2hJnh2Xgxu0pyQi701/L9CjJfLzBk2xGu1q5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9ETiJh+Ve2WSko7crm7jQwZn/Fpc5lqnPe0K6+TlicCMIRWFd6Us9tO7dbODqIsCTwjQyNmZ3MTnz2fAmKiCr9/XolZaVerClYC5AKha0c11nQyyvbbLmjiPJW/zDawqIctQpVuIhF3K5oh+JgOtqNkjS9jDimBywJnkAvAJtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XcW4f3XVSz4f3vfc
	for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 19:14:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E95D01A058E
	for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 19:15:00 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgCHYoYzch9nK5u5AA--.13104S3;
	Mon, 28 Oct 2024 19:15:00 +0800 (CST)
Message-ID: <2e830e56-45de-6696-bcfc-52b4904355f1@huaweicloud.com>
Date: Mon, 28 Oct 2024 19:14:59 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] brd: defer automatic disk creation until module
 initialization succeeds
To: Christoph Hellwig <hch@lst.de>, "yukuai (C)" <yukuai3@huawei.com>
Cc: axboe@kernel.dk, ulf.hansson@linaro.org, houtao1@huawei.com,
 penguin-kernel@i-love.sakura.ne.jp, linux-block@vger.kernel.org,
 yangerkun@huawei.com
References: <20241028090726.2958921-1-yangerkun@huaweicloud.com>
 <20241028094409.GA31248@lst.de>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20241028094409.GA31248@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHYoYzch9nK5u5AA--.13104S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1rCFWkuw1xuw1DJFyxXwb_yoW8uw1kpa
	98KFW8tFW5CrWfGw4UXw17WF48Jw109a15Xa1rAF1IkrZ7Ar9aqasYkFyUCr1rurWvya1q
	yFyYqwn8Zr1Fk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/10/28 17:44, Christoph Hellwig 写道:
> On Mon, Oct 28, 2024 at 05:07:26PM +0800, Yang Erkun wrote:
>> Fix this problem by following what loop_init() does. Besides,
>> reintroduce brd_devices_mutex to help serialize modifications to
>> brd_list.
> 
> This looks generally good.  Minor comments below:

Hi,

Thanks for your review!

> 
>> +	snprintf(buf, DISK_NAME_LEN, "ram%d", i);
>> +	mutex_lock(&brd_devices_mutex);
>> +	list_for_each_entry(brd, &brd_devices, brd_list) {
>> +		if (brd->brd_number == i) {
>> +			mutex_unlock(&brd_devices_mutex);
>> +			err = -EEXIST;
>> +			goto out;
> 
> This now prints an error message for an already existing
> device, which should not happen for the module_init case,
> but will happen all the time for the probe callback, and
> is really annoying.  Please drop that part of the change.

OK, maybe print nothing is better like loop_add in loop_init has did to
leave code clean? mknod can help to create /dev/ram%d... Hi, Kuai, what
do you think?

> 
>> +		}
>> +	}
>>   	brd = kzalloc(sizeof(*brd), GFP_KERNEL);
>> +	if (!brd) {
>> +		mutex_unlock(&brd_devices_mutex);
>> +		err = -ENOMEM;
>> +		goto out;
>> +	}
>>   	brd->brd_number		= i;
>>   	list_add_tail(&brd->brd_list, &brd_devices);
>> +	mutex_unlock(&brd_devices_mutex);
> 
> And maybe just split the whole locked section into a
> brd_find_or_alloc_device helper to make verifying the locking easier?

Ok.

> 
>> +	mutex_lock(&brd_devices_mutex);
>>   	list_del(&brd->brd_list);
>> +	mutex_unlock(&brd_devices_mutex);
>>   	kfree(brd);
> 
>> +		mutex_lock(&brd_devices_mutex);
>>   		list_del(&brd->brd_list);
>> +		mutex_unlock(&brd_devices_mutex);
>>   		kfree(brd);
> 
> Maybe a brd_free_device helper for this pattern would be nice as well.

Ok.

> 
>> +	brd_check_and_reset_par();
>> +	brd_debugfs_dir = debugfs_create_dir("ramdisk_pages", NULL);
>>   
>>   	if (__register_blkdev(RAMDISK_MAJOR, "ramdisk", brd_probe)) {
>> -		err = -EIO;
>> -		goto out_free;
>> +		pr_info("brd: module NOT loaded !!!\n");
>> +		debugfs_remove_recursive(brd_debugfs_dir);
>> +		return -EIO;
> 
> I'd keep an error handling goto for this to keep the main path
> straight.

Ok.

