Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114841862;
	Fri,  1 Aug 2025 00:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007907; cv=none; b=CzbHtsqZ9NC0YjdJtfnOgNXBXUhLwTO+p4aJBF4wqnpSscpySaoYsqJGjKH/H9wOYX+zv2xtwUy+ZBuVIZIixkSzb1mUFO9vIVV+Eey2RObNrhdFoeObOAFSwG2JRJkP1ogatK4+eY8Z0i7u8aVODB4EJx65ivsCYZc2UqTpaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007907; c=relaxed/simple;
	bh=EOQv1qcT/OkdpOw9CGpuqepOjLi/A//XzPP16t9jr30=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tTFs9A5sSmiEsySGEaSdxiLuY2+7qZP0Vlxk0vfBfPctkDNe2iaKVV52sQx2FMSZA9NPXzragEOR9t2zei83HoScdIZRFo9seE+RHrm47mMZYrn8K25sgtnT1a4rBWDRwW+JvwUEwdeqd0LbMVONdKRKoR/8ZOuNglG4c74fxWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4btRY95Jv5zYQvYj;
	Fri,  1 Aug 2025 08:25:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6A94D1A1121;
	Fri,  1 Aug 2025 08:25:00 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHwhJaCYxoOySgCA--.13105S3;
	Fri, 01 Aug 2025 08:25:00 +0800 (CST)
Subject: Re: [PATCH v2 1/2] lib/sbitmap: convert shallow_depth from one word
 to the whole sbitmap
To: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: yukuai@kernel.org, axboe@kernel.dk, akpm@linux-foundation.org,
 yang.yang@vivo.com, dlemoal@kernel.org, ming.lei@redhat.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 Omar Sandoval <osandov@fb.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250729031906.3615228-1-yukuai1@huaweicloud.com>
 <20250729031906.3615228-2-yukuai1@huaweicloud.com>
 <ozjsdoiqa2uem65qqj4fjbrwm6toxlj5bzv7f5dg5xfiljv3zi@wcaamboo2r6h>
 <8edcdef6-8749-aa45-e7d2-ada677645d76@huaweicloud.com>
 <jr54uomodnzqyw4bu4hcdpllgafkhueyygiiempuudwjy3vir5@d7lv3jsxxqx2>
 <223acbc1-60d4-4687-8eea-5306aa44ae24@kernel.org>
 <c748a3ee-bf33-e13e-d507-984277acbb32@huaweicloud.com>
 <imit4dkxy55c6a6tfqzaa6hf67nrawedotc3rzltlmmgmf3b3t@nde6h6cy3agw>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <12d82243-237c-d890-a975-392b151d55a9@huaweicloud.com>
Date: Fri, 1 Aug 2025 08:24:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <imit4dkxy55c6a6tfqzaa6hf67nrawedotc3rzltlmmgmf3b3t@nde6h6cy3agw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHwhJaCYxoOySgCA--.13105S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF48Kw4UJr4xuw4xKF1fCrg_yoW8WF4kpr
	4Ut3W7Kw4UtF1jkFn0qa1DXF1akr13A3ZIgF43Xw1xCrWDtaySqF1YvF90vry7ZrWkurWj
	yFWfXry7J3WYqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
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

在 2025/08/01 0:27, Jan Kara 写道:
> On Thu 31-07-25 10:38:58, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/07/31 2:24, Yu Kuai 写道:
>>> hi, Jan!
>>>
>>> 在 2025/7/30 21:03, Jan Kara 写道:
>>>> I think having two APIs will be even more confusing than the current
>>>> state.
>>>> But as I wrote I think you can have API to specify shallow depth in total
>>>> size and in sbitmap_queue_get_shallow() do:
>>>>
>>>> shallow_per_word = (shallow_depth << sb->shift) / sb->depth;
>> In order to consider the last word, I think we should use __map_depth()
>> here.
> 
> Right.
> 
>>>> rounding_index = shallow_depth - shallow_per_word * sb->depth;
>> And then it's not possible to calculate this rounding index easily. How
>> about following, although the reminder handling is not perfect.
>>
>>   static unsigned int __map_depth_with_shallow(const struct sbitmap *sb,
>>                                               int index,
>>                                               unsigned int shallow_depth)
>>   {
>>          unsigned int word_depth = __map_depth(sb, index);
>>          unsigned int shallow_word_depth = word_depth * shallow_depth;
>>          unsigned reminder = do_div(shallow_word_depth, sb->depth);
>>
>>          if (reminder && !(index & 0x1))
> 
> Well, why not:
> 	if (remainder > index)
Do you mean reminder > index * shallow_depth? This looks correct, and
with the consideration for the last word:

if (index == sb->map_nr - 1)
	shallow_word_depth = max(shallow_word_depth, 1);
else if (reminder > index * shallow_depth)
	shallow_word_depth++;

Thanks,
Kuai

> ?
> 
> That should accurately distribute the remainder across the remaining words,
> shouldn't it?
> 
>>                  shallow_word_depth++;
>>
>>          return shallow_word_depth;
>>   }
> 
> 								Honza
> 

