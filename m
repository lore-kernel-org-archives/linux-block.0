Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4FB2CA9;
	Tue, 12 Aug 2025 02:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754964364; cv=none; b=HPvYHvX/TTtskuMnj6jgUavmULcc0XZ3C+tRcQUGaUtexMNAQH/O8Q9P5pOoPS5S5xkITXiTfvOfnEuMyWxw8fDj1y+u6NgJqD23PC3RKcGow9NI7OR+2lM9C3zgYre1I1+yNEAyruGULM21d5E7FoeSbi2xMSSzV/ppxDPVsUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754964364; c=relaxed/simple;
	bh=tdlTKcqBSGbRchsC3CdAHsNL98oa72v0PDwWqtsHXHI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NA15rAJeOMYj3KMTz6w8FRX6KwFgBp73UXXc3DoqE0OjdAxpM2TDblUzPjmYd6n89eKLwfyGAGqCzY1MwDCvjyBCaF48rzKVHTGwASU/YUG5iOetUlfSZWRC9fCdFtxxS+b7gIK+njyYvcxVyQPh3bhZnt4HQ75nWT+9JoDEzFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c1FGV0v3MzYQtwt;
	Tue, 12 Aug 2025 10:05:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B79BA1A0E5E;
	Tue, 12 Aug 2025 10:05:52 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDXUxR+oZpoyeCMDQ--.40233S3;
	Tue, 12 Aug 2025 10:05:52 +0800 (CST)
Subject: Re: [PATCH v2] loop: use vfs_getattr_nosec() for accurate file size
To: Damien Le Moal <dlemoal@kernel.org>, Rajeev Mishra <rajeevm@hpe.com>,
 axboe@kernel.dk, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250811190303.222802-1-rajeevm@hpe.com>
 <45b33232-9089-4df4-b9f8-c843cb3d2d07@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a8041180-03f2-3342-b568-867b3f295239@huaweicloud.com>
Date: Tue, 12 Aug 2025 10:05:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <45b33232-9089-4df4-b9f8-c843cb3d2d07@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXUxR+oZpoyeCMDQ--.40233S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4UGr4fGFWktry7GF48JFb_yoW8tw17pF
	W3tFWYyF1jgFy7CFsrAw47X3yFvan3uryUury7Ca17AFn0yr9xuF97GFWY934UXry5Ar1r
	XF4DtrW7uFyDArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/12 9:40, Damien Le Moal 写道:
> On 8/12/25 4:03 AM, Rajeev Mishra wrote:
>> The get_size() function now uses vfs_getattr_nosec() instead of
>> i_size_read() to obtain file size information. This provides more
>> accurate results for network filesystems where cached metadata
>> may be stale, ensuring the loop device reflects the current file
>> size rather than potentially outdated cached values.
>>
>> Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
>> ---
>>   drivers/block/loop.c | 24 ++++++++++++++++++++++--
>>   1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 1b6ee91f8eb9..c418c47db76e 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -137,12 +137,32 @@ static void loop_global_unlock(struct loop_device *lo, bool global)
>>   static int max_part;
>>   static int part_shift;
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
>>   static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
>>   {
>> +	struct kstat stat;
>>   	loff_t loopsize;
>> +	int ret;
>> +
>> +	/*
>> +	 * Get the accurate file size. This will prevent caching
>> +	 * issue that occurs at filesystem layer.
>> +	 */
>> +	ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
>> +	if (ret)
>> +		return 0;
> 
> return 0 here is odd. Why not "return ret;" to propagate the error if any ?
> An error may come from the underlying FS inode->i_op->getattr().

This helper is supposed to return the size, all the callers don't
hanldle error value for now.

However, I agree return error value instead of set disk size to 0 will
make more sense, at least from ioctl path. Perhaps go through all the
callers and see, if we want to handle errors or set disk size to 0.

Thanks,
Kuai

> 
>> +
>> +	loopsize = stat.size;
>>   
>> -	/* Compute loopsize in bytes */
>> -	loopsize = i_size_read(file->f_mapping->host);
>>   	if (offset > 0)
>>   		loopsize -= offset;
>>   	/* offset is beyond i_size, weird but possible */
> 
> 

