Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27774A33
	for <linux-block@vger.kernel.org>; Thu,  7 Mar 2024 01:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709774155; cv=none; b=p4sFOm7u4savllTfViUiUdCMvqrmeA8+ma0yp83on5Vvfkl27EnX5U6AS17sI8F/66mZuGokZSrKHB9zfLHch2pFN/WvAJNhshn0pkzekbNMM5RkTlt+qm6lT5/sunig/fDh2+JsFDqgqpj+iRyylbmmwx15JA9Y2sCBPkSxEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709774155; c=relaxed/simple;
	bh=zr/vRpRYCy45J1qDndO9xe8yi8wWVKUkwn5X2xmNo3A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PSMLsNzrWRJrgf+hqfZcPCeQ875C7cPTUzz5zd2ZFVzInteO/CDIvgi5AlLq3RTOuAM0b+S8VAAPi1G0uhNLsNtgtkIDtaL5+dptArfBkvpiaQvoP+yRKmoegoUPkAwAZzRd3J5carSEqB4QINdwg2HVxG71lN4sNhtFM+QTxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tqrvw2Xnwz4f3kKG
	for <linux-block@vger.kernel.org>; Thu,  7 Mar 2024 09:15:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E08601A0390
	for <linux-block@vger.kernel.org>; Thu,  7 Mar 2024 09:15:43 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g4+FellmwaxGA--.31884S3;
	Thu, 07 Mar 2024 09:15:43 +0800 (CST)
Subject: Re: [PATCH] block: Support building the iocost and iolatency policies
 as kernel modules
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240306003911.78697-1-bvanassche@acm.org>
 <396d15a0-eedc-bf00-dd56-c064293fcaa5@huaweicloud.com>
 <b2907ddb-6e48-4c9a-b4e7-d6239550d5c3@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d4533b56-588b-ed1e-bb06-f0d044e8b23a@huaweicloud.com>
Date: Thu, 7 Mar 2024 09:15:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b2907ddb-6e48-4c9a-b4e7-d6239550d5c3@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g4+FellmwaxGA--.31884S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr1DWF1UGryktr18Ar15twb_yoWxtrcE9r
	yqyr9F9w1xGa92yFn7Jrs5CFZrGa1ruFWDt3yYqay3Ar13ta1FywsrWr9rAw45G3W8GF98
	ur1rZw1fJ34qgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
	UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/03/07 9:11, Bart Van Assche 写道:
> On 3/5/24 17:34, Yu Kuai wrote:
>> Looks like there are lots of work need to be done as well, for
>> exapmle:
>>
>> - ping the iocost Module before enabling it for a disk, otherwise unload
>> the Module will cause problems;
> 
> Hmm ... loading a block driver, loading blk-iocost, unloading the block
> driver and unloading blk-iocost works fine on my test setup.

This can work... However, did you try to enable iocost and then unload
iocost first?

Thanks,
Kuai

> 
>> - free the iocost structure after disabling it, otherwise iocost Module
>> can never be unloaded;
> 
> I will check whether struct ioc is freed when unloading blk-iocost.
> 
> Thanks,
> 
> Bart.
> .
> 

