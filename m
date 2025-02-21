Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B141D89E4
	for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 06:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740119379; cv=none; b=SEhlPH47rnOle8F/p8gJdXtgwF5kgaqJCbZ5pIBV5sKMWFqm1P/oKni01kUssXq0ReJV92dBX8nV8FVgTiwJ7bzGr5dDfVgb+Qs1Eiq3NuDV2e762HjM7zlCYgpRvwrg7JLtsMqpnhK5u6DHpzmoBbx4quV5Os1mPx3XeH50fTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740119379; c=relaxed/simple;
	bh=m0McyqBL9S2q+I3d+cgzW2C0j7Dn0YGUXkLTSi0kQ+w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ogNK3QJm+VIAdPoy2KLW0hlelUxbDE68awLxqx6DP39mFALutiZ2t81I677he4qsGhLQK2uezS79DktOtlpj9Rn0QIB2tmb7Kv4acd2NzIbVYe2v3v+6Tld4SoaZnrs6rZUHwuutjNSzMPpRgcDWBSsOtKkZEfkJfbTuydZXWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YzgFf73qfz4f3jXr
	for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 14:29:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A3CC71A058E
	for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 14:29:32 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXu19KHbhnyi_XEQ--.6506S3;
	Fri, 21 Feb 2025 14:29:32 +0800 (CST)
Subject: Re: [PATCH] block: throttle: don't add one extra jiffy mistakenly for
 bps limit
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250220111735.1187999-1-ming.lei@redhat.com>
 <a8f10a51-c9c8-0d1a-296d-f1f542bf8523@huaweicloud.com>
 <Z7frGxuMCTLwH9BW@fedora>
 <83147b4b-9be8-3a50-6a4f-2ec9b37c8ab8@huaweicloud.com>
 <Z7f-jx9LRXUrj_ao@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7a113162-a2c1-fad4-3395-7bc39d05b5c4@huaweicloud.com>
Date: Fri, 21 Feb 2025 14:29:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z7f-jx9LRXUrj_ao@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXu19KHbhnyi_XEQ--.6506S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1UKryxtw1DZw1UXw47Arb_yoW8Jw13pr
	ZFkrs0kFs8W3W7K3WfC3W0va4jqa1kAF15GrW0kr9rCa4rGrn5AFy5WrZIk343Wwn3ArZF
	q348ZFW3CF47uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/02/21 12:18, Ming Lei 写道:
>> -       jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
>> -
>> -       if (!jiffy_wait)
>> -               jiffy_wait = 1;
>> +       jiffy_wait = div64_u64_rem(extra_bytes * HZ, bps_limit,
>> &carryover_bytes);
>> +       tg->carryover_bytes[rw] -= div64_u64(carryover_bytes, HZ);
> Can you explain a bit why `carryover_bytes/HZ` is subtracted instead of
> carryover_bytes?

For example, if bps_limit is 1000, extra_bytes is 9, then:

jiffy_wait = (9 * 100) / 1000 = 0;
carryover_bytes = (9 * 100) % 1000 = 900;

Hence we need to divide it by HZ:
tg->carryover_bytes = 0 - 900/100 = -9;

-9 can be considered debt, and for the next IO, the bytes_allowed will
consider the carryover_bytes.
> 
> Also tg_within_bps_limit() may return 0 now, which isn't expected.

I think it's expected, this IO will now be dispatched directly instead
of wait for one more jiffies, and debt will be paid if there are
following IOs.

And if the tg idle for a long time before dispatching the next IO,
tg_trim_slice() should handle this case and avoid long slice end. This
is not quite handy, perhaps it's better to add a helper like
tg_in_debt() before throtl_start_new_slice() to hande this case.

BTW, we must update the comment about carryover_bytes/ios, it's alredy
used as debt.

Thanks,
Kuai
> 
> 
> Thanks,
> Ming

