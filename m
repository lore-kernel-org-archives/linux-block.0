Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4BD3B1B3;
	Sat, 25 Jul 2026 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784939349; cv=none; b=XMr7gLk5lmm5GWozjMnbZLjNmsl2/9Ov5UL3ZixrDx00N5naZiODbXa4HizjbIb+NphYolW/wowHifFy5aNQCXAfd4EogMn8o6TxnmZouS05lyh8vTLI6WF9chJVnuYbDB7qGKjgBkHo9MnRR2hm5sHP3zXZMOtLn/C4DXguxAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784939349; c=relaxed/simple;
	bh=+3XC2swu5r9T7CSdaGFC5WcnSLB4wf6F/7gTt2Q1gHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWUATdPPGuV28z/FD7lDedv+ndXg8Mpi+tv6xMiqAPUDwWAO1wEZeyMW/AC8MqbfIT93G8xYQgwP1vdeqzh0836ffel5VyvH4wthNZ8nRiPb+Vr2QrMjzuxG7HjD9x/nQCb6CLNnKQF/AF0uPm51NJnfmm6rvpABn7t12WEQpUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h6Qgw4WykzYQtwt;
	Sat, 25 Jul 2026 08:28:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E33AE4058D;
	Sat, 25 Jul 2026 08:29:01 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgCX8W1LA2RqJrDICQ--.23231S3;
	Sat, 25 Jul 2026 08:29:01 +0800 (CST)
Message-ID: <57d39035-f065-47d7-a100-5b3bc9d952c2@huaweicloud.com>
Date: Sat, 25 Jul 2026 08:28:58 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix BLKSECDISCARD zero-length range causing page
 cache invalidation
To: Bart Van Assche <bvanassche@acm.org>, Zizhi Wo <wozizhi@huaweicloud.com>,
 axboe@kernel.dk, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com
References: <20260704073942.3760597-1-wozizhi@huaweicloud.com>
 <4ef6f2b4-57b9-40cc-a5cd-e34473e1cba3@acm.org>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <4ef6f2b4-57b9-40cc-a5cd-e34473e1cba3@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCX8W1LA2RqJrDICQ--.23231S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF4kZF1UKrW5CF13Wr4kWFg_yoWDXFg_Xr
	18AFyrA3W8XF4xJa1qkayfZFWxJ3yUWr4DJrWkGwsru3sxGayrZFW8trZY9anxJa1FgFnI
	9r909ayjvr1SvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2026/7/25 3:39, Bart Van Assche 写道:
> On 7/4/26 12:39 AM, Zizhi Wo wrote:
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
> 
> A Fixes: tag is missing. Once this has been addressed, feel free to add:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> 


Thanks for the reminder, I will add a fixtag in the second version.

Thanks,
Zizhi Wo

