Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5384A13FEE;
	Sat, 14 Dec 2024 02:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734144287; cv=none; b=FP8GnsHmyYNeFM3STpeQGf271rUtYeFbYPvvNPtwYdRF8lPtzCwBv1x6bv9Eii1n4ZvQn5DxEOz7h8tQT3xooU3+0BSClpaFPSEHhzK0gloOQScGwh1bOrz4L3sy6atNiE1bXLCaiIRJE2z38JGwKBhqEwTk9EuyiVkhdxoUMOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734144287; c=relaxed/simple;
	bh=LXQ424kNl0hkFT7GE2IZ60/jBTpGcgsKLpzUxMya2PI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bw78ZGDDpMiBuJckfnzhhXyTHo0uQ/gKbLgB4w+nnmWGRzpEEmQtHD0rc8OUZua/ZcAJJGrUYo7GQYYc0Wi3XpPsf+fWr03T7V45tgKjhcnRNj/OruSHEkl6F8Gkutic6J2p/rov8dESRJ4GZFukMCAGez6zTRGsc7d90nwjllo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y99Wy4M3Zz4f3jRC;
	Sat, 14 Dec 2024 10:44:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EF4FB1A0359;
	Sat, 14 Dec 2024 10:44:33 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgDHo4cQ8VxnjzcoEg--.42921S3;
	Sat, 14 Dec 2024 10:44:33 +0800 (CST)
Subject: Re: [PATCH RFC 1/3] block/mq-deadline: Revert "block/mq-deadline: Fix
 the tag reservation code"
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, akpm@linux-foundation.org, yang.yang@vivo.com,
 ming.lei@redhat.com, osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241209115522.3741093-1-yukuai1@huaweicloud.com>
 <20241209115522.3741093-2-yukuai1@huaweicloud.com>
 <bef7b96c-a6cc-4b83-99b2-848cecb3d3b1@acm.org>
 <6e384b29-50d2-64bd-0d08-fc0f086c1cbd@huaweicloud.com>
 <7081765f-28d7-f594-1221-6034b9e88899@huaweicloud.com>
 <d9733af5-b16b-4644-9d6d-84fbacf334e0@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2562353d-bfe3-a2b1-5427-76426cbda7b4@huaweicloud.com>
Date: Sat, 14 Dec 2024 10:44:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d9733af5-b16b-4644-9d6d-84fbacf334e0@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHo4cQ8VxnjzcoEg--.42921S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw47Gw1xtrWfXr4UWF4UJwb_yoWkWrXEgw
	4qyryDGw4jqr1fCr47GayrGrZ0qrWDta4UArykKF4UX34IkwsxCF90kryfZa13XFyUKrn3
	Xw1jyry5AwnF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
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

Hi, Bart

在 2024/12/11 4:33, Bart Van Assche 写道:
>> If so, following are the options that I can think of to fix this:
>>
>> 1) make async_depth read-only, if 75% tags will hurt performance in some
>> cases, user can increase nr_requests to prevent it.
>> 2) refactor elevator sysfs api, remove eq->sysfs_lock and replace it
>> with q->sysfs_lock, so deadline_async_depth_store() will be protected
>> against changing hctxs, and min_shallow_depth can be updated here.
>> 3) other options?
> 
> Another option is to remove the ability to configure async_depth. If it
> is too much trouble to get the implementation right without causing
> regressions for existing workloads, one possibility is to remove support
> for restricting the number of asynchronous requests in flight.

If you agree, I'll use following option in the next version:

4) set min_async_depth to 64 (after treating min_shallow_depth for the
whole sbitmap instead of one word).

The good thing is that user can still set async_depth without changing
wake_batch, the side effect is that async_depth can't be used if
nr_requests <= 64;

Thanks,
Kuai

