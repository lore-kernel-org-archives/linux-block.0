Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB59A70832;
	Tue, 10 Dec 2024 01:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733794133; cv=none; b=o3ucPmVJJrqfuyAcRa0ZqFOXqRpq3P0sG8baoUrr8Xr0LS4V9bJBXWh7CaJJMji1RYR84ZE44um4EHaRjqMK3wU4II6EFZIoAmLAcR9HHji+1wXxkxpn74d+ZS3G5qqp6UnMDUO7abTxdIR/PFd7+SG5FQW3/GEzT3wuD2Kla4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733794133; c=relaxed/simple;
	bh=7lkdRcCRRbDDaXdtteXxEjafp3g9akCmf9TUcyRR6qU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PP0qQAwXa02bxjqA03nmxbP06+E3GjiLun+S7U10BzF2ImQwgaooeURtefl5VTAK7bMQzmRyPDK9ikOsoU9mIaqYfiVHytRWgEoH2O3RNJOx4KkIU6kJdD8lhyLfOTQhlnIb6fSfdWSa2Ql/dPwxt3ygjH2RSsK2JrYDuBk/I3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y6h2L6bXFz4f3lVM;
	Tue, 10 Dec 2024 09:28:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 260E11A0568;
	Tue, 10 Dec 2024 09:28:47 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgAXP4NOmVdnmiikEA--.59696S3;
	Tue, 10 Dec 2024 09:28:46 +0800 (CST)
Subject: Re: [PATCH RFC 3/3] lib/sbitmap: fix shallow_depth tag allocation
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, akpm@linux-foundation.org, yang.yang@vivo.com,
 ming.lei@redhat.com, osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241209115522.3741093-1-yukuai1@huaweicloud.com>
 <20241209115522.3741093-4-yukuai1@huaweicloud.com>
 <3e401555-e971-44c2-b9a4-5c746baaca8a@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0e7225ea-72de-76c8-9154-0afc197a7e22@huaweicloud.com>
Date: Tue, 10 Dec 2024 09:28:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3e401555-e971-44c2-b9a4-5c746baaca8a@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXP4NOmVdnmiikEA--.59696S3
X-Coremail-Antispam: 1UD129KBjvJXoW7GFWkJFyUur4fKFyDCry5XFb_yoW8JF1xp3
	yFqFW3Jr4DX3WUua4Igan7Z3Z5AwsxX34rArn8X348C3y5CwnavF4fGFZ0va4IqFs7WF1j
	va1Fvw1rJ398ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU13ku3UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/12/10 2:11, Bart Van Assche 写道:
> On 12/9/24 7:55 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently, shallow_depth is used by bfq, kyber and mq-deadline, they both
>> pass in the value for the whole sbitmap, while sbitmap treate the value
>> for just one word. Which means, shallow_depth never work as expected,
>> and there really is no such functional tests to covert it.
> 
> treate -> treats
> 
> The above text is incorrect. I have verified that shallow_depth 
> restricts the queue depth of asynchronous requests for mq-deadline if it
> is reduced from its default value. The function dd_word_to_depth() in
> mq-deadline converts the value written into the sysfs attribute into a
> value that is appropriate for the sbitmap implementation.

Hi,

please notice that patch 1 is reverted in this set, which means
dd_word_to_depth() is not existed. :)

And for patch 1, dd_word_to_depth() doesn't(and can't) handle the last
word, for the case that avaliable bits in the last word is less than
1 << sb->shift. So, in fact it's not convert to the appropriate value.

> 
> That being said, it seems like a good idea to me to modify how the
> sbitmap code interprets 'shallow_depth'.

Good to know!

Thanks,
Kuai

> 
> Thanks,
> 
> Bart.
> .
> 

