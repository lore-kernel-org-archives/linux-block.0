Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C85D1F61C;
	Wed, 18 Dec 2024 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485316; cv=none; b=oBdtboMEOS81DRuHYhK87WTwGB9oOr1aYmRVDIK6j9C4Srh3YnKETzMD5Vk6yzePg7t1G4f/hpkQuNIxH8GJbVjm0hnuO5ka6wWa0dGPVLd8Wue0yZK1jXfLHhwrYQDpUWppuiI0gEDfeZzVXpOY3pD67E+0M8IzRyl5F/b8BWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485316; c=relaxed/simple;
	bh=lExFsluDAK+Ndqwpz0+C6rkTy7HrW8FQjoG+9Kb5fvI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BxqakMxsYuqGnjfHPWq0yFZKByYt3z6IYvP7Q+6QIT+TXiqmlf1ZLNYhPWjFwcnlXcMupi6KUIUnjf6KzBclVABHl2xcJ/OtNY5eAaoG6AvMYYpaPppvzCUjoTMdudI4KrmDtKvcfoPNHruMU3vRrek/HqN83f3Hz4VBHWgAz0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YCbHp21Dbz4f3lWF;
	Wed, 18 Dec 2024 09:12:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C7C9C1A07BB;
	Wed, 18 Dec 2024 09:12:26 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgBHIoZ4IWJniQmiEw--.38048S3;
	Wed, 18 Dec 2024 09:12:26 +0800 (CST)
Subject: Re: [PATCH RFC v2 4/4] block/mq-deadline: introduce min_async_depth
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, akpm@linux-foundation.org, ming.lei@redhat.com,
 yang.yang@vivo.com, osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241217024047.1091893-1-yukuai1@huaweicloud.com>
 <20241217024047.1091893-5-yukuai1@huaweicloud.com>
 <da924dc3-a2e5-4bfe-afb6-5fbc55bc25a3@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8fa8c620-22ff-0963-d1ee-c6fe6f13b49c@huaweicloud.com>
Date: Wed, 18 Dec 2024 09:12:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <da924dc3-a2e5-4bfe-afb6-5fbc55bc25a3@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHIoZ4IWJniQmiEw--.38048S3
X-Coremail-Antispam: 1UD129KBjvJXoWrKrWrJw1fJFy8JF1UXw17GFg_yoW8Jr48pw
	4vqan2kr45XF10kw48A397Xw10qrsIgr13J3Z8t34xtr95ZFZ5XFy5XFWY9rs7Z3y8Ga12
	gFyDua45uFnIyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/12/18 6:13, Bart Van Assche 写道:
> On 12/16/24 6:40 PM, Yu Kuai wrote:
>> +static unsigned int min_async_depth = 64;
>> +module_param(min_async_depth, int, 0444);
>> +MODULE_PARM_DESC(min_async_depth, "The minimal number of tags 
>> available for asynchronous requests");
> 
> Users may not like it that this parameter is read-only.
> 
>> @@ -513,9 +523,12 @@ static void dd_depth_updated(struct blk_mq_hw_ctx 
>> *hctx)
>>       struct deadline_data *dd = q->elevator->elevator_data;
>>       struct blk_mq_tags *tags = hctx->sched_tags;
>> -    dd->async_depth = max(1UL, 3 * q->nr_requests / 4);
> 
> Shouldn't this assignment be retained instead of removing it? 
> Additionally, some time ago a user requested to initialize 
> dd->async_depth to q->nr_requests instead of 3/4 of that value because
> the lower value introduced a performance regression.
dd->async_depth is initialized to 0 now, functionally I think
it's the same as q->nr_requests. And I do explain this in commit
message, maybe it's not clear?

BTW, if user sets new nr_requests and async_depth < new nr_requests,
async_depth won't be reset after this patch.

Thanks,
Kuai

> 
> Thanks,
> 
> Bart.
> 
> .
> 

