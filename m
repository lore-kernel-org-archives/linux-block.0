Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837D22701BA;
	Thu, 24 Apr 2025 02:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745462125; cv=none; b=f0v6cVG1BLDRephgVkIXPGqRxnXiYFeihuL2GDu6hq4lMrTL668RQvJMTpnJJ7juH0XIs7r9979TWC64Jo5+VL3r7PBhzuMildRSL/WPzA4Nv/H6oPnlgg5iB4K7fPv1CUp2LwDVN/wawoqWrpJkRfT2lHypsipgV2TRhj6g4GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745462125; c=relaxed/simple;
	bh=l5VhaPblEjCMuhNE8DZY2F3Srkk0u7b+ljx3T5DrYMQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OJi+gSnu+f2Kc29m10rbbKaAtXOBRxls5el7tf6jO+0JZIYDXudQ624vCIItF0ACKFVj0eZpE/QNiRNEUvzK+B4bT3Z5oEK+mwNkgc0eQW8uM9GcLJcJTSAT0rNaqOyCfDfA5BnvPGRgWLIfNzKbtiimRYfyfrLxwPyoSKCXY+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zjg6g1sPWz4f3lDK;
	Thu, 24 Apr 2025 10:34:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BF1A41A0359;
	Thu, 24 Apr 2025 10:35:16 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXe19iowloxAWRKQ--.43174S3;
	Thu, 24 Apr 2025 10:35:16 +0800 (CST)
Subject: Re: 10x I/O await times in 6.12
To: Matt Fleming <mfleming@cloudflare.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CAGis_TVSAPjYwVjUyur0_NFsDi9jmJ_oWhBHrJ-bEknG-nJO9Q@mail.gmail.com>
 <dd2db843-843f-db15-c54f-f2c44548dee3@huaweicloud.com>
 <CAGis_TWtWMK93nVBa_D_Y2D3Su8x_dDNwNw9h=v=8zoaHuAXBA@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2bb4f6ef-c25a-887f-6a0b-434fc8e1e54e@huaweicloud.com>
Date: Thu, 24 Apr 2025 10:35:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGis_TWtWMK93nVBa_D_Y2D3Su8x_dDNwNw9h=v=8zoaHuAXBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe19iowloxAWRKQ--.43174S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar15Cw1xAw48ur1fXrWUurg_yoW8uF15pr
	W5Ja1Ykrs5JrW0ga1Iqa1UWFyrKw4Utry7Gr4Dta1rCwn0gry3KF1F9w4j9rWxArs5uw47
	ZF4Y9asrX3ZxKrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
	73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Jens!

在 2025/04/23 18:51, Matt Fleming 写道:
> On Mon, 21 Apr 2025 at 13:21, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Can you drop this expensive bpftrace script which might affect IO
>> performance, and replace __submit_bio directly to __blk_flush_plug? If
>> nsecs - plug->cur_ktime is still milliseconds, can you check if the
>> following patch can fix your problem?
> 
> Yep, the below patch fixes the regression and restores I/O wait times
> that are comparable to 6.6. Thanks!

Thanks for the test.

Do you have any suggestions? For now, I can think of two different
fixes:

1) clear time for the preempt case. On the one hand, preempt can be
frequent, cauing performance degradation; On the other hand, this can't
solve all the problems, for example, lots of interrupt or lots of BIO
issued into one round of plug.

2) delay setting rq start time to flush plug, however, the latency value
is still not accurate, and will be slightly smaller instead of greater.

Thanks,
Kuai

> 
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index ae8494d88897..37197502147e 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1095,7 +1095,9 @@ static inline void blk_account_io_start(struct
>> request *req)
>>                   return;
>>
>>           req->rq_flags |= RQF_IO_STAT;
>> -       req->start_time_ns = blk_time_get_ns();
>> +
>> +       if (!current->plug)
>> +               req->start_time_ns = blk_time_get_ns();
>>
>>           /*
>>            * All non-passthrough requests are created from a bio with one
>> @@ -2874,6 +2876,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug,
>> bool from_schedule)
>>    {
>>           struct request *rq;
>>           unsigned int depth;
>> +       u64 now;
>>
>>           /*
>>            * We may have been called recursively midway through handling
>> @@ -2887,6 +2890,10 @@ void blk_mq_flush_plug_list(struct blk_plug
>> *plug, bool from_schedule)
>>           depth = plug->rq_count;
>>           plug->rq_count = 0;
>>
>> +       now = ktime_get_ns();
>> +       rq_list_for_each(&plug->mq_list, rq)
>> +               rq->start_time_ns = now;
>> +
>>           if (!plug->multiple_queues && !plug->has_elevator &&
>> !from_schedule) {
>>                   struct request_queue *q;
>>
> 
> .
> 

