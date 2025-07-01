Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98194C97;
	Tue,  1 Jul 2025 01:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751333346; cv=none; b=iUN9qX+g8x+e4x4D1ujdMxLKiP1ZddZJibNT0euntgquRu+lRlouDxg1qGQjAGECnKmr/YOQT9Be0UgcSa8AMaphuSvOEUudIAKTrNei9aUZKfpNnYlP+v68xj8TvadCfauk6PRdZ0sME60ZiZJgxg/AOTE3lSBmwRQuPUNmPp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751333346; c=relaxed/simple;
	bh=D8UqOOsEY/NopVE3CbDsVtjbT/fYg5AELD/acega2Mw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=G7/texkIUQMfLa8uHFIr+ZwGw5qWzouoiwLfcsPW4vSqretil4c8xvY+DaJU/SAZpnfGo0dsINpW7FAizVwRoPxcLnc5JdQ0S9ikiPZ3Rg/yEzeFSAF1GpIZ3HBCkuFX6wz/XIedjjUFZjhwLxvEn4Bx56r3Dx2O66m9sSGKYOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bWQRL6R3YzKHMxk;
	Tue,  1 Jul 2025 09:29:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 49FA21A0D86;
	Tue,  1 Jul 2025 09:29:01 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP2 (Coremail) with SMTP id Syh0CgAX_wzbOWNoPK4SAQ--.17602S3;
	Tue, 01 Jul 2025 09:29:01 +0800 (CST)
Subject: Re: [PATCH v2] brd: fix sleeping function called from invalid context
 in brd_insert_page()
To: Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai1@huaweicloud.com>,
 hch@lst.de
Cc: penguin-kernel@I-love.SAKURA.ne.jp, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250630112828.421219-1-yukuai1@huaweicloud.com>
 <eb41cab3-5946-4fe3-a1be-843dd6fca159@kernel.dk>
 <a2dc2566-44e1-4460-bbff-bb813f4655d9@kernel.dk>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <773a49cf-3908-85d2-5693-5cbd6530a933@huaweicloud.com>
Date: Tue, 1 Jul 2025 09:28:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a2dc2566-44e1-4460-bbff-bb813f4655d9@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAX_wzbOWNoPK4SAQ--.17602S3
X-Coremail-Antispam: 1UD129KBjvJXoWruw1fGw1fGFy7Xr13Zr1fWFg_yoW8JF1fpF
	Wjga4Yyr4ku3sFya17u3WDJFyrtw4kKr4UC3WrKFyUZFZIgF93XrW7A3y5Wr9Iqrn2qw1Y
	qa1j93s3uFZ3AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/06/30 23:28, Jens Axboe 写道:
> On 6/30/25 9:24 AM, Jens Axboe wrote:
>> On 6/30/25 5:28 AM, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> __xa_cmpxchg() is called with rcu_read_lock(), and it will allocate
>>> memory if necessary.
>>>
>>> Fix the problem by moving rcu_read_lock() after __xa_cmpxchg(), meanwhile,
>>> it still should be held before xa_unlock(), prevent returned page to be
>>> freed by concurrent discard.
>>
>> The rcu locking in there is a bit of a mess, imho. What _exactly_ is the
>> rcu read side locking protecting? Is it only needed around the lookup
>> and insert? We even hold it over the kmap and copy, which seems very
>> heavy handed.
> 
> Gah it's holding the page alive too. Can't we just grab a ref to the
> page when inserting it, and drop that at free time? It would be a lot
> better to have only the lookup be RCU protected, having the full
> copies under it seems kind of crazy.

In this case, we must grab a ref to the page for each read/write as
well, I choose RCU because I think it has less performance overhead than
page ref, which is atomic. BTW, I thought copy at most one page is
lightweight, if this is not true, I agree page ref is better.

Thanks,
Kuai

> 
> IOW, I think there's room for some good cleanups here.
> 

