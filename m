Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1A17DA6C;
	Fri, 20 Dec 2024 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734674948; cv=none; b=SzKR3aHAGfWXYLvBp5oXEF9x51H0CYZ8qAXZGrJiTvxlKgJjKH97/K78/dyTOCa8z0Iqt5h57AFjZFRG8l1dK5RPqeEBO0KgnR+swl0vGkJBgoaVJbIyvTFdx1AK+qAulbBDU/lyJ4QnhAh4slrjDiLQfkbFi86RT2Y6qT4PmwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734674948; c=relaxed/simple;
	bh=9kyvTZ4qe43rvM/volEU/7+ZdllU6XMFuC1OBK2VkY8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DZNNno4Zc3GsSUezMUVGVVStAYCZ+qCrOjZNVBRDsa5Mbwsnqti0raJ3KqsDTvdb7cid2DDAjku9l17NDhaWiGX/Qo/kmzU80D7YTOtNaNDoS0F2UfCj2M1qs+geBBCIgdsx09g2sJI2WaDTSOA93yvo/qWVtWurllEGiLlMk3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YDxnB2Mv1z4f3jqq;
	Fri, 20 Dec 2024 14:08:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CE05C1A0194;
	Fri, 20 Dec 2024 14:09:00 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgAHMYX6CWVn+_ZxFA--.28178S3;
	Fri, 20 Dec 2024 14:09:00 +0800 (CST)
Subject: Re: [PATCH RFC v2 4/4] block/mq-deadline: introduce min_async_depth
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, akpm@linux-foundation.org, ming.lei@redhat.com,
 yang.yang@vivo.com, osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241217024047.1091893-1-yukuai1@huaweicloud.com>
 <20241217024047.1091893-5-yukuai1@huaweicloud.com>
 <da924dc3-a2e5-4bfe-afb6-5fbc55bc25a3@acm.org>
 <8fa8c620-22ff-0963-d1ee-c6fe6f13b49c@huaweicloud.com>
 <96556f82-b511-b3ef-01b5-e9a32557db95@huaweicloud.com>
 <f2b95b70-f074-4f58-b03d-5e7fb20f4274@acm.org>
 <ff6b1360-2cc8-d700-df88-130fa15de1c7@huaweicloud.com>
 <818ca8e9-d691-421f-9b66-f13c76f523f3@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b1a4c70e-e41e-e434-0f98-6c61a4bd7dbc@huaweicloud.com>
Date: Fri, 20 Dec 2024 14:08:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <818ca8e9-d691-421f-9b66-f13c76f523f3@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHMYX6CWVn+_ZxFA--.28178S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZFyrur4DGrWUXF17Cr4xtFb_yoWktwc_Wr
	4qyrWvgwn8urn3tanYvr15KrZ5WrWDGFnxJa4DWF4Iv3W5Wa43WrZ8Xwn3Zay3W3y0grn5
	Cay09FyFvw4agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/12/20 3:25, Bart Van Assche 写道:
> On 12/18/24 5:21 PM, Yu Kuai wrote:
>> Hi,
>>
>> 在 2024/12/19 2:00, Bart Van Assche 写道:
>>> On 12/17/24 5:14 PM, Yu Kuai wrote:
>>>> I can't make this read-write, because set lower value will cause
>>>> problems for existing elevator, because wake_batch has to be
>>>> updated as well.
>>>
>>> Should the request queue perhaps be frozen before wake_batch is updated?
>>
>> Yes, we should. The good thing is for now it's frozen already:
>>   - update nr_requests context;
>>   - switch elevator;
>>
>> However, if you mean do this while writing async_depth, freeze queue
>> is not enough, we have to ping all the hctx as well by q->sysfs_lock,
>> which is not possible.
>>
>> Or if you mean do this while write the new min_async_depth, then we have
>> to update wat_batch for all the queues in the system, too crazy for
>> me...
> 
> Should min_async_depth perhaps be a request queue attribute instead of
> an mq-deadline I/O scheduler attribute?

Yes, I think this make sense, at least kyber and deadline can both
benefit from this. And I might must add a new async_depth_updated() api
to the elevator ops.

Thanks,
Kuai

> 
> Thanks,
> 
> Bart.
> 
> 
> .
> 

