Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841E12F60A1;
	Thu, 14 Aug 2025 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161729; cv=none; b=i8u2rBWU/I3gDrHsfM3qvXNd5zFPpGp/fEALYk1x9GOT3rJv0l4Kh4ZoYIgW5SIYj6ppnGKDy5kPYX/hI1mykKxSfNdg4PeHjpKILyx/L7AN/Xr1tFjvUCkgNH+v8Dw0AxTa7xWnnc9g2TlDMvltCL8+Y1Luaa8ho2yNr+97rjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161729; c=relaxed/simple;
	bh=Q1Ezmr8xBNBJbp0yiqf+2cpES60qrJG5Q9MDk0b1NDg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aQqez3hHCFm8p+6Z/u/miw1llOTQyFG3Knsq/cKAVxION9cfPOhl1X1+wWYp4aVXlQyAn/nICYMmUxyBe4E5mavDi6sv+niI6jGqsWZ0U+6rXFVwb1/wxizVzsa9Z8Tc6BOOyh/eZKZCYFXVM9DmKRqtaHV9PE58UqC49S1tpLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c2fG52Nn1zYQvHd;
	Thu, 14 Aug 2025 16:55:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E96151A0B2B;
	Thu, 14 Aug 2025 16:55:23 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXIBF6pJ1ot8SQDg--.42923S3;
	Thu, 14 Aug 2025 16:55:23 +0800 (CST)
Subject: Re: [PATCH 01/16] blk-mq-sched: add new parameter nr_requests in
 blk_mq_alloc_sched_tags()
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, bvanassche@acm.org, nilay@linux.ibm.com, hare@suse.de,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250814033522.770575-1-yukuai1@huaweicloud.com>
 <20250814033522.770575-2-yukuai1@huaweicloud.com> <aJ2bWqQCMtjT3NZh@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <16924973-c18e-6b1c-8271-1ff1954854de@huaweicloud.com>
Date: Thu, 14 Aug 2025 16:55:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aJ2bWqQCMtjT3NZh@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXIBF6pJ1ot8SQDg--.42923S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GrykZr1ruFy5uFWfKFy3Jwb_yoWDJFg_Gr
	WjkFn7K34DArsaqr47WFW3ArWkGFnayF47GFyqqFnrXwnIka98JFZ5Wr98Wan7Aw4xArsr
	Ww15K343G3Z8ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/14 16:16, Ming Lei Ð´µÀ:
>>   struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
>> -		unsigned int nr_hw_queues)
>> +		unsigned int nr_hw_queues, unsigned int nr_requests)
>>   {
>>   	unsigned int nr_tags;
>>   	int i;
>> @@ -475,8 +475,11 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
>>   	 * 128, since we don't split into sync/async like the old code
>>   	 * did. Additionally, this is a per-hw queue depth.
>>   	 */
>> -	et->nr_requests = 2 * min_t(unsigned int, set->queue_depth,
>> -			BLKDEV_DEFAULT_RQ);
>> +	if (nr_requests)
>> +		et->nr_requests = nr_requests;
>> +	else
>> +		et->nr_requests = 2 * min_t(unsigned int, set->queue_depth,
>> +				BLKDEV_DEFAULT_RQ);
> It looks more readable to add helper blk_mq_default_nr_requests(),
> and pass it from call sites directly, then people won't be confused
> with the passed zero `nr_requests`.

Yes, this sounds good.

Thanks for the review,
Kuai

