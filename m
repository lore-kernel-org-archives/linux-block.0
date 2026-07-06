Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A308345CCE;
	Mon,  6 Jul 2026 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344895; cv=none; b=kKL1/PGJ62qaHaVcLHkbirxYBobQtKD6jglJQ4dvmU5eMOK2pd500whmB1o0rkWf4kRK84t5hRnOvc6pb9ZCKNT+apMGznPoxziCsYOr/9+mWlvKMgREBRQELsTBrZ8/Vol/L+Ujo87Lnsmy8gNsZZEFk22pUL1PAOjAO/q3dQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344895; c=relaxed/simple;
	bh=f0UIkUYPReSNpUyhwRpue4mKYSnZP2yWBlACfBpBajg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6wWdM6zI3RHeb4iNR+1GZ1JHBcS6PBK5Pksx0cg1Vhnrb24quNW5/KV4iFUBSAG8Xezs4H4DdobWL18oZTKvSVR0EadlYkZyMr0hSYrT1tGLcf2YAiPYv9depjI9hr5DjE+SKQ1jllzvrgvU0krccfPUgSIQTh3l1Y9H2dx3Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gv51g5fVmzKHMNt;
	Mon,  6 Jul 2026 21:34:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 925C140D1A;
	Mon,  6 Jul 2026 21:34:49 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHWHT3rktq6kgRAQ--.50332S3;
	Mon, 06 Jul 2026 21:34:49 +0800 (CST)
Message-ID: <c8cc96b2-7ff0-4368-9c2d-5054301ff6c5@huaweicloud.com>
Date: Mon, 6 Jul 2026 21:34:47 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] null_blk: register configfs subsystem after creating
 default devices
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
 dlemoal@kernel.org, nilay@linux.ibm.com, linux-block@vger.kernel.org,
 kch@nvidia.com, johannes.thumshirn@wdc.com, kbusch@kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260706123507.3809871-1-wozizhi@huaweicloud.com>
 <20260706123507.3809871-4-wozizhi@huaweicloud.com>
 <490008e2-2345-48ea-bd8e-c078d828a43f@acm.org>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <490008e2-2345-48ea-bd8e-c078d828a43f@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHWHT3rktq6kgRAQ--.50332S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZF47uF15Aw4rKrW3WF4DArb_yoWxKrb_Jw
	s5tr4kWryqvayFkw1akw1UZryxGFZFgrnxXr1IvrW7Gw17XFnxKw1YvFZYvr1rKa15CrZ8
	X3y5Aasakr1xGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2026/7/6 21:17, Bart Van Assche 写道:
> On 7/6/26 5:35 AM, Zizhi Wo wrote:
>> @@ -2187,8 +2185,6 @@ static int __init null_init(void)
>>           null_destroy_dev(nullb);
>>       }
>>       unregister_blkdev(null_major, "nullb");
>> -err_conf:
>> -    configfs_unregister_subsystem(&nullb_subsys);
>>       return ret;
>>   }
> 
> Please make null_exit() consistent with the cleanup path in null_init().
> null_exit() calls unregister_blkdev() before it destroys the null_blk
> instances. That doesn't look right to me.
> 
> Thanks,
> 
> Bart.
> 
> 

Thanks for pointing this out, I hadn't noticed that. I'll add this
change in the next version.

Thanks,
Zizhi Wo

