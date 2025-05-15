Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501994B1E41
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747316867; cv=none; b=Npvvu+mTp4uiKgi+AWo1dE27zHBfX9bMyYBN5E8g6Dpe3dSxUZNIVJm37jdPpqPW1g8OrMTtr7yUsay8eVmKdiMYZMug3PpmrTGVKSsBkb5ouPhb8JhLR4KCpbQXfdqnQjy6vv8bMdL7f7Dy8ydDGHCuzJnWvLfyl2UE3sQPWYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747316867; c=relaxed/simple;
	bh=sy/4XgxZ7AYSAwvf+qNAn8mfiWSE2xJk8F17giMXl18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMc5XCzYLJkfYphvpcvlYdF/GKLKmu9fN64fiKPmQW7gmUy3XGB8Y5iMQdmDA3Oo/ZAsrcBWsAUsQ6YbjOgS+UihREz9IEhbQpHaIdoINakdTwCW0MG8y+Y9KcR0AKV3SA9XtafVcORvzjQ7TAAJD5dH6sCaTDbCPdOG3M18xhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4Zys3K2wtyzYQv87
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 21:47:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A83D71A0359
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 21:47:40 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2B68CVoRnT4MQ--.44458S3;
	Thu, 15 May 2025 21:47:40 +0800 (CST)
Message-ID: <fd74ab33-0d72-4924-a849-25e655988f5d@huaweicloud.com>
Date: Thu, 15 May 2025 21:47:38 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 6/7] blk-throttle: Split the service queue
To: Jens Axboe <axboe@kernel.dk>, Aishwarya <aishwarya.tcv@arm.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, tj@kernel.org,
 yangerkun@huawei.com, yukuai3@huawei.com, ryan.roberts@arm.com
References: <20250506020935.655574-7-wozizhi@huaweicloud.com>
 <20250515130830.9671-1-aishwarya.tcv@arm.com>
 <0d059764-76ba-4681-8cc1-4783424ad3bf@kernel.dk>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <0d059764-76ba-4681-8cc1-4783424ad3bf@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2B68CVoRnT4MQ--.44458S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF47Wry3Ww4rGr1xCw45Wrg_yoW8AF47p3
	45Zw1rKrW8t3WqgayrKrs3trWfJrsrG39xW3Z3GrWayF47JF9FkF13Ar1UJa1vkan3uF47
	ZFZxWFZrta4UWa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2025/5/15 21:39, Jens Axboe 写道:
> On 5/15/25 7:08 AM, Aishwarya wrote:
>> Observed the following build warning when building the next-20250515 kernel with defconfig+CONFIG_BLK_DEV_THROTTLING applied:
>>
>> Warning output:
>>
>> ../block/blk-throttle.c: In function 'throtl_pending_timer_fn':
>> ../block/blk-throttle.c:1153:30: warning: unused variable 'bio_cnt_w' [-Wunused-variable]
>>   1153 |                 unsigned int bio_cnt_w = sq_queued(sq, WRITE);
>>        |                              ^~~~~~~~~
>> ../block/blk-throttle.c:1152:30: warning: unused variable 'bio_cnt_r' [-Wunused-variable]
>>   1152 |                 unsigned int bio_cnt_r = sq_queued(sq, READ);
>>        |                              ^~~~~~~~~
>>
>>
>> There?s no warning with defconfig alone, and I?ve confirmed that the warning appears when CONFIG_BLK_DEV_THROTTLING is explicitly enabled.
> 
> This should fix it. The issue is if blktrace isn't enabled.
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index bf4faac83662..bd15357f23bd 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -1149,8 +1149,8 @@ static void throtl_pending_timer_fn(struct timer_list *t)
>   	dispatched = false;
>   
>   	while (true) {
> -		unsigned int bio_cnt_r = sq_queued(sq, READ);
> -		unsigned int bio_cnt_w = sq_queued(sq, WRITE);
> +		unsigned int __maybe_unused bio_cnt_r = sq_queued(sq, READ);
> +		unsigned int __maybe_unused bio_cnt_w = sq_queued(sq, WRITE);
>   
>   		throtl_log(sq, "dispatch nr_queued=%u read=%u write=%u",
>   			   bio_cnt_r + bio_cnt_w, bio_cnt_r, bio_cnt_w);
> 

Oops.. I didn't take that into account. Those two variables are only
used in throtl_log. I'll check if there are any other similar issues and
send out a fix patch shortly. Thanks for pointing it out!

Thanks,
Zizhi Wo

