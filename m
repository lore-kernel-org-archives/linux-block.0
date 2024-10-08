Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148818622;
	Tue,  8 Oct 2024 01:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728351717; cv=none; b=i50g4DxWvloun6kRsz4LVmm3lOJuwjrPFZSk+NKIZabDZm9LycjxGpLYefAAi1xeO/f3nkqB/mDyup3q0+ItlwudAAyQhTfFM5Js4jT0hZl1B9tzWOs3kLDDS8psPKpkcK/vaKh0ZaObvn6IFYiuq7YrOQFTMyS7hwhfVu/wQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728351717; c=relaxed/simple;
	bh=cWSt4WA0p+of5ATDqf+7wEmIL+eMVlkDc/qdAUHqWjg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VZMoz78uhqGmfv7Nv6xOQ42FsUdwWlImwrQ5ZBUI87peqTxzHDgODjmd4jhYNqMoGnTW4LH3fXitsSeUcE15CPSRQcyCI1euxf8Q2qSCkowCoxzkZXepyXlDDtIu2hAGyRs3F2dZRG5gZOMzkLbxB9ZNEt97lq6ltxIjoSdwwXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XMzJj1gZ2z4f3jk7;
	Tue,  8 Oct 2024 09:41:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E597A1A0359;
	Tue,  8 Oct 2024 09:41:52 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgD3KsfgjQRnQFbqDQ--.24419S3;
	Tue, 08 Oct 2024 09:41:52 +0800 (CST)
Subject: Re: [PATCH 5.10] block, bfq: remove useless checking in
 bfq_put_queue()
To: Jens Axboe <axboe@kernel.dk>, George Rurikov
 <g.ryurikov@securitycode.ru>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Jan Kara <jack@suse.cz>, "yukuai (C)" <yukuai3@huawei.com>
References: <20241007140709.1762881-1-g.ryurikov@securitycode.ru>
 <5995b8d7-a94a-4c5d-8bf6-e19998c0ac72@kernel.dk>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <06ed3431-1311-ef45-0611-1321307a4629@huaweicloud.com>
Date: Tue, 8 Oct 2024 09:41:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5995b8d7-a94a-4c5d-8bf6-e19998c0ac72@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3KsfgjQRnQFbqDQ--.24419S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYH7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4
	kS14v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/10/07 22:21, Jens Axboe 写道:
> On 10/7/24 8:07 AM, George Rurikov wrote:
>> From: George Ryurikov <g.ryurikov@securitycode.ru>
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> commit 1e3cc2125d7cc7d492b2e6e52d09c1e17ba573c3
>>
>> 'bfqq->bfqd' is ensured to set in bfq_init_queue(), and it will never
>> change afterwards.
> 
> No point pushing this to stable, so no from here.
> 

Yes, and there are no follow up fixes as well.

Thanks,
Kuai

