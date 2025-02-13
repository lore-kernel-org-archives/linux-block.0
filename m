Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B07E2040AB
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 02:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739414558; cv=none; b=VFBuV8swXJMytz3hj+UscHDzjcoRMy9n8YHxHosX4LFPWYX/l6JupU13/7OjuT18dD08hhP1KMp0bq+PQHCbyBzaccMQ+GNeCskIYW2hfW5I4TdV3KWL5r0vUJjBvFtvEu/4VZUrKATOYf5OlQIl791i7WRGw87ZPH5LZV8GAVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739414558; c=relaxed/simple;
	bh=19Q1Ju85GtWgTs+zydyPb2txwMZXp8W6Tzek87vllNE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JTKE2C5tAV59DKoIO/BRFyeBw9zOcWngM2Y8T8RCUbHMRpt1qLqF9K1MVC23qStyuXUstAfeqd2vo+MdiaJJcwdYz8MHiXlUrEtrNkOaz3M7Wo4PKKPFfxraQRQcLvDbcp4ENY1ZH+5QGYIuxZKPgwI0bW28lUBSjeclT1W3G9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YtfbV1MB3z4f3jq4
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 10:42:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 460AC1A0BF0
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 10:42:30 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXe18UXK1nfHPGDg--.9490S3;
	Thu, 13 Feb 2025 10:42:30 +0800 (CST)
Subject: Re: [PATCH RFC] block: print the real address of request in debugfs
To: Guixin Liu <kanie@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20250208035224.128454-1-kanie@linux.alibaba.com>
 <ce305c08-af9b-4f4f-86ca-3832791bb7a4@linux.alibaba.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9c7e0983-aae2-f0be-a1ac-a36b74a757e8@huaweicloud.com>
Date: Thu, 13 Feb 2025 10:42:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ce305c08-af9b-4f4f-86ca-3832791bb7a4@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe18UXK1nfHPGDg--.9490S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWfZF4fGr1fur4Dtw47Jwb_yoW8WFyrp3
	93C3WrGrWDZr1F9F1qqa15X3yfGr4kKF1UXF90kF1rArnxW34aqr1q9rWYgF97Wrs5Ja1a
	qF4xtr97uF1Uua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/02/12 17:55, Guixin Liu 写道:
> Gently ping...
> 
> Best Regards,
> 
> Guixin Liu
> 
> 在 2025/2/8 11:52, Guixin Liu 写道:
>> Since only root user can access debugfs, for easier issue
>> identification, use '%px' to print the request's real address in
>> debugfs.

I search and find out that %p is introduced in the first commit:

320ae51feed5 ("blk-mq: new multi-queue block IO queueing mechanism").

I think usually we should not print address by debugfs, and I don't see
why this is needed here. For root user trying to debug, the tag
information should be enough.

Just wonder maybe we can just remove this.

Thanks,
Kuai
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>> Hi,
>>    I notice that block dont print the real address in
>> debugfs for a long time, I wonder what the community's
>> concerns are, thanks, so this is a RFC patch.
>> Best Regards,
>> Guixin Liu
>>
>>   block/blk-mq-debugfs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>> index adf5f0697b6b..c430d931512f 100644
>> --- a/block/blk-mq-debugfs.c
>> +++ b/block/blk-mq-debugfs.c
>> @@ -265,7 +265,7 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, 
>> struct request *rq)
>>       BUILD_BUG_ON(ARRAY_SIZE(cmd_flag_name) != __REQ_NR_BITS);
>>       BUILD_BUG_ON(ARRAY_SIZE(rqf_name) != __RQF_BITS);
>> -    seq_printf(m, "%p {.op=", rq);
>> +    seq_printf(m, "%px {.op=", rq);
>>       if (strcmp(op_str, "UNKNOWN") == 0)
>>           seq_printf(m, "%u", op);
>>       else
> 
> .
> 

