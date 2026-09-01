Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D329346777
	for <linux-block@vger.kernel.org>; Tue,  1 Sep 2026 06:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788243629; cv=none; b=WsnnBBxy7pFrnaYnK4rkTFdPPPdcSjOwy28KMdwcuRVlCf2Ngm9uq4pGHQ3NwWbdZdJCFLX/wK5yzDOrzUX0PEgN8Ht1I1R+2+lCbOWKS/kE8hdUGMRjHYWA/Y4w4QnZHWEcvVjxqDvftSH5T9LYtbgSMrH4R0Opcq/Eg0VX1Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788243629; c=relaxed/simple;
	bh=7kAXqpDhc+U5NotagFYGtFI5lJerTgwre3i3eLWhEOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1rSLq+Lllt7OQKe4DaeLfDcKIiILfI5lLmWpGQwbbM6rHwAuBeEH9rxPymX4oXcQpNjbRsur33c9ekb9SyS8C+6eW8pdr3/yAqeXaRmwyI88q+ffJKZDEofO7uwcKodbJCfJOm81ydHMM3A7nlpQY29Z3SRQJhdGSdlwDHT12A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hYwgN1HhjzKHMYX
	for <linux-block@vger.kernel.org>; Tue,  1 Sep 2026 14:19:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 22BA6405B7
	for <linux-block@vger.kernel.org>; Tue,  1 Sep 2026 14:20:18 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHMAudbpZqJM9SAQ--.59400S3;
	Tue, 01 Sep 2026 14:20:15 +0800 (CST)
Message-ID: <b53ad130-3360-41b7-9180-cc66a16a356e@huaweicloud.com>
Date: Tue, 1 Sep 2026 14:20:13 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] block: fix BLKSECDISCARD zero-length range causing
 page cache invalidation
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, bvanassche@acm.org,
 hch@lst.de, yukuai@fygo.io, linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, chengzhihao1@huawei.com
References: <20260725002355.347485-1-wozizhi@huaweicloud.com>
 <27b84502-9239-4a21-b38c-a44697764d57@huaweicloud.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <27b84502-9239-4a21-b38c-a44697764d57@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHMAudbpZqJM9SAQ--.59400S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4rZF1xuF4fZF4kGF18Grg_yoW5KrWkpr
	ykGFy5GryUWr97ur18tF17ZryUtw1Uta1UAr15XF1DZrWDArnFgFyUWrySgrykJrWkJr4U
	JF4jvr97ZFy7uFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

Hi Jens,

Gentle ping on this patch. It has collected several Reviewed-by
tags and I haven't seen any outstanding comments, so I believe it'
ready to go?

I just checked it still applies cleanly on the latest for-next,
so it should be ready to pick up as-is.

Thanks,
Zizhi Wo

在 2026/8/6 14:39, Zizhi Wo 写道:
> friendly ping...
> 
> 在 2026/7/25 8:23, Zizhi Wo 写道:
>> From: Zizhi Wo <wozizhi@huawei.com>
>>
>> Commit 697ba0b6ec4a ("block: fix integer overflow in BLKSECDISCARD") 
>> fixed
>> the start+len overflow via check_add_overflow() but did not handle the
>> start=0, len=0 case. There, start + len = 0, so end = 0 passes all 
>> checks,
>> and truncate_bdev_range()->truncate_inode_pages_range() is then called 
>> with
>> lend=UINT64_MAX, whitch is the "truncate to the end of file" sentinel, so
>> the entire page cache is invalidated.
>>
>> Fix this by replacing the validation with blk_validate_byte_range(), 
>> which
>> already rejects a zero-length range and is what BLKDISCARD uses. This 
>> also
>> switches the alignment check from a hardcoded 512 to
>> bdev_logical_block_size().
>>
>> Fixes: 0bd1ed4860d0 ("block: pass inclusive 'lend' parameter to 
>> truncate_inode_pages_range")
>> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
>> Reviewed-by: Yu Kuai <yukuai@fygo.io>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>> v2:
>> Add the fixtag.
>>
>> v1: https://lore.kernel.org/all/20260704073942.3760597-1- 
>> wozizhi@huaweicloud.com/
>> ---
>>   block/ioctl.c | 13 +++++--------
>>   1 file changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/block/ioctl.c b/block/ioctl.c
>> index 3d4ea1537457..3b7d33a737e8 100644
>> --- a/block/ioctl.c
>> +++ b/block/ioctl.c
>> @@ -174,12 +174,11 @@ static int blk_ioctl_discard(struct block_device 
>> *bdev, blk_mode_t mode,
>>   }
>>   static int blk_ioctl_secure_erase(struct block_device *bdev, 
>> blk_mode_t mode,
>>           void __user *argp)
>>   {
>> -    uint64_t start, len, end;
>> -    uint64_t range[2];
>> +    uint64_t range[2], start, len;
>>       int err;
>>       if (!(mode & BLK_OPEN_WRITE))
>>           return -EBADF;
>>       if (!bdev_max_secure_erase_sectors(bdev))
>> @@ -187,19 +186,17 @@ static int blk_ioctl_secure_erase(struct 
>> block_device *bdev, blk_mode_t mode,
>>       if (copy_from_user(range, argp, sizeof(range)))
>>           return -EFAULT;
>>       start = range[0];
>>       len = range[1];
>> -    if ((start & 511) || (len & 511))
>> -        return -EINVAL;
>> -    if (check_add_overflow(start, len, &end) ||
>> -        end > bdev_nr_bytes(bdev))
>> -        return -EINVAL;
>> +    err = blk_validate_byte_range(bdev, start, len);
>> +    if (err)
>> +        return err;
>>       inode_lock(bdev->bd_mapping->host);
>>       filemap_invalidate_lock(bdev->bd_mapping);
>> -    err = truncate_bdev_range(bdev, mode, start, end - 1);
>> +    err = truncate_bdev_range(bdev, mode, start, start + len - 1);
>>       if (!err)
>>           err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
>>                           GFP_KERNEL);
>>       filemap_invalidate_unlock(bdev->bd_mapping);
>>       inode_unlock(bdev->bd_mapping->host);
> 
> 

