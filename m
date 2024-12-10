Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A412E4A
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733792973; cv=none; b=kr4kFKLQoGIRi7j4WaUBVyaMzOWGKCAFw9Xy3NM44Cv/H17YP0Z3YEVP54X6MhR88ttGZfrQIrgaTKHaP2gGga0U8qU/gEqaflGjNQl7rlaLJmfsYFI0DNLLE97a0R0quq+EmBN5++1Pu2jwl63ttjN9KONFnib7Wn3Sax+L8WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733792973; c=relaxed/simple;
	bh=iKfKczAl+GUU01eIjdEmsaZb2SIdQtsorYzARN1sqRY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hW8caEASuX5fo57JOWe196qja1eHwlIxdqnNQujZ2EFCvN1rEaqxz9OlCpyoBAssnVFw9IxJjNVoS98YTWFoBNDsd0sWsDg44Dt1241dSxfHfjey35H00F3I3IrZBwnDmD+/BMEhlGShfiFcjB1tYZWjyYDE9HEz9Z4uFELiKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y6gc35nBdz4f3kFL
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 09:09:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0856D1A018D
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 09:09:27 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgAHMYW8lFdnc9miEA--.58859S3;
	Tue, 10 Dec 2024 09:09:26 +0800 (CST)
Subject: Re: [PATCH v2 2/2] block/mq-deadline: Fix the tag reservation code
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240509170149.7639-1-bvanassche@acm.org>
 <20240509170149.7639-3-bvanassche@acm.org>
 <8df3fd04-08ef-7aab-77d0-a919a09838a0@huaweicloud.com>
 <b3bb69a1-9b0c-4d77-9498-c8bbd536452d@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ab37900a-7ab0-bb21-38f2-9ea4ad6a8349@huaweicloud.com>
Date: Tue, 10 Dec 2024 09:09:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b3bb69a1-9b0c-4d77-9498-c8bbd536452d@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHMYW8lFdnc9miEA--.58859S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtryrJrWDCw4rWryrXw17Awb_yoWfAwb_Kr
	n0yFZrGw13tws2kFZrKry5JrW7tFZxJr4DArnFgF4UZ34Fkas8Gryqk3yFyws8XF4xKrs5
	uw15t34jkanIvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
	73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/12/10 3:08, Bart Van Assche 写道:
> On 12/6/24 6:17 PM, Yu Kuai wrote:
>> We're comparing v6.6 and v5.10 performance in downstream kernel, we
>> met a regression and bisect to this patch. And during review, I don't
>> understand the above change.
>>
>> For example, dd->async_depth is nr_requests, then dd_to_word_depth()
>> will just return 1 << bt->sb.shift. Then nothing will be throttled.
> 
> (just back from traveling)
> 
> As explained in the description of commit 39823b47bbd4 ("block/mq-
> deadline: Fix the tag reservation code"), the default value of
> async_depth has been changed from 3 * q->nr_requests / 4 into
> q->nr_requests to fix a performance regression. The value of
> dd->async_depth can be changed through sysfs.

Then I think what we should do next is to fix the sysfs api as well,
it's not correct for the default value for now.

Thanks,
Kuai

> 
> Thanks,
> 
> Bart.
> .
> 

