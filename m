Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C931C5F39;
	Mon,  6 Jul 2026 01:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783299933; cv=none; b=a1ZqzgDHucBxZ8ZBEX9bE1xc4j/6PQNNjEFhYeRXzlT4a/uR11WlLxPyj/uQblbwdc+6sVfBACMj4bqm7oFgt+x9+2BPZ7O3KwNx/lUgq3sfCj9sA9KIpryoufOhjogYK8Syrj9pZV/RCN7JEYNZpMnObiPef37NdC782hJ8blE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783299933; c=relaxed/simple;
	bh=1nT2r483PMemz+eeDXRcKDdvJvT4D2SJlRXJ7t9Hi7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T29viymtH6RS9eBBYYPkYDHbkMhtPdJzR+mOXFmae0F2MXcW/3VJ5h0WFEGO8339WKeRlbqBQqhYJkkCJf0EkRfAux1yvrrHafNzkOZv2vlYHEZyoVYeutvIvH1wQ+Z/FfA+y9bUMeqzZxKVWJJRMpmFMSoXXOTIq8a43MIK63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gtmNw5Z2PzKHMMP;
	Mon,  6 Jul 2026 09:05:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B14CC4057D;
	Mon,  6 Jul 2026 09:05:21 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgC3xnJP_0pqa1rSAA--.40649S3;
	Mon, 06 Jul 2026 09:05:21 +0800 (CST)
Message-ID: <28c3d5ea-fab3-4e52-afbe-2e0fad854912@huaweicloud.com>
Date: Mon, 6 Jul 2026 09:05:19 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: initialize lock mutex before registering
 configfs subsystem
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
 dlemoal@kernel.org, nilay@linux.ibm.com, linux-block@vger.kernel.org,
 kch@nvidia.com, johannes.thumshirn@wdc.com, kbusch@kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260704092323.748772-1-wozizhi@huaweicloud.com>
 <33ec54bf-b6b5-466b-82fb-f05b133336c9@acm.org>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <33ec54bf-b6b5-466b-82fb-f05b133336c9@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC3xnJP_0pqa1rSAA--.40649S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4kuw4kXw17ZFWfKF1kAFb_yoWkWwc_Aw
	4kZr48Xrn7Cw45Cr1xKFnxZryUJr4v9r1kGw12vrZxGFy7XrnxJ3W5A3s3Gw48Kr47CrZ8
	CrW5ZFWavr17CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2026/7/4 21:25, Bart Van Assche 写道:
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/ 
>> main.c
>> index f8c0fd57e041..98616d290c5c 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -2161,13 +2161,12 @@ static int __init null_init(void)
>>       config_group_init(&nullb_subsys.su_group);
>>       mutex_init(&nullb_subsys.su_mutex);
>> +    mutex_init(&lock);
>>       ret = configfs_register_subsystem(&nullb_subsys);
>>       if (ret)
>>           return ret;
>> -    mutex_init(&lock);
>> -
>>       null_major = register_blkdev(0, "nullb");
>>       if (null_major < 0) {
>>           ret = null_major;
> 
> Why an explicit mutex_init() call instead of changing "static struct
> mutex lock" into "static DEFINE_MUTEX(lock)"? Additionally, shouldn't
> the "lock" name be made more descriptive since it has file scope?
> 
> Thanks,
> 
> Bart.

Thanks for your suggestion, this is indeed more appropriate. I'll send
out a v2 shortly.

Thanks,
Zizhi Wo

