Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D453B41C72;
	Thu, 19 Dec 2024 01:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571274; cv=none; b=BU7fw9g065FPlU4AVeaPv3BA2ZLz/p7hfW3gaO+kHv+GpoXVZo1Qf25w9cSwX6LlZkd3/frZBnq+7Jrp4DbRNk9oX2OTzH2bPQAOpFl7maPjREPIACy+PZTVU+MFAn2AsW7/NM6y/9AOSm/vld+KOz7Tyms4b24VqiieXkAngrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571274; c=relaxed/simple;
	bh=muQ4ssRslj9k5J2L/MtfZQ1SOg0fisQiTrx15+/aL8o=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tVKv4uBm52kwkq1jJNwhNYMQQsfTF+Q3ZxONVTMDaTIbBSmKiU6nDRoL6P7sMfM/A4XOj2nmwbEwjkyrRh9/0Rmc4ds1qNyp3msMb/XUn3mVFFQzCUlqHXbNMv4/LHs5cY2pvYfAtGAedQLUZop7Gcd0BpK2LEuyxBdjRYXxNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YDCRM4LMxz4f3jY1;
	Thu, 19 Dec 2024 09:20:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 222301A058E;
	Thu, 19 Dec 2024 09:21:07 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgAnT4MBdWNnzWEBFA--.11064S3;
	Thu, 19 Dec 2024 09:21:06 +0800 (CST)
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
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ff6b1360-2cc8-d700-df88-130fa15de1c7@huaweicloud.com>
Date: Thu, 19 Dec 2024 09:21:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f2b95b70-f074-4f58-b03d-5e7fb20f4274@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnT4MBdWNnzWEBFA--.11064S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWrKF1xGF1xCF4rWFyfJFb_yoW3WFX_Wr
	1qyryvgwnY9rn3ta1jvr15W3y3Gr4DGFn3Wa9rW3W5ta4YgasxWrZrAws5Zr43X3y0gr1k
	uayI93y09w4agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/12/19 2:00, Bart Van Assche 写道:
> On 12/17/24 5:14 PM, Yu Kuai wrote:
>> I can't make this read-write, because set lower value will cause
>> problems for existing elevator, because wake_batch has to be
>> updated as well.
> 
> Should the request queue perhaps be frozen before wake_batch is updated?

Yes, we should. The good thing is for now it's frozen already:
  - update nr_requests context;
  - switch elevator;

However, if you mean do this while writing async_depth, freeze queue
is not enough, we have to ping all the hctx as well by q->sysfs_lock,
which is not possible.

Or if you mean do this while write the new min_async_depth, then we have
to update wat_batch for all the queues in the system, too crazy for
me...

Thanks,
Kuai

> 
> Thanks,
> 
> Bart.
> 
> .
> 

