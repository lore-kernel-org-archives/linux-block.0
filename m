Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9119524B0;
	Tue, 10 Dec 2024 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733793803; cv=none; b=FdGd3ewlQqeKVmKAtjaEanBJe8B+EtGmAfoBEkysxve9IzscaVghWrNFOAn3KHPNuHvIBqK/SmDnPHBzmcsoVuYMgLrUw12DrVJMZhZvZxMfzkXHZZRLxerwtre+5fUrcwirnxh14hTsE5dlrS/3Xsdamf0jdBJQLUz+PPLNuPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733793803; c=relaxed/simple;
	bh=+0GegLHvpCFE+64+vAAPPWLqRrXzJ43u5HBeRXzYaxE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cH6pwlV4GqcgiVi0rbxsfLc5xcTqSpGbl4q4nKTFVtptpXxjr+ICJLsog1CY7FqKdlgGPtXY8WxClCHCpT4dXeuSlyd3DFV+rcPHG2hgGg2eicjvztC1ABRZRlhwNFU0BMph6nGitf9Iwco79vms2vnFv7PHrZ38KGhlWxOwbts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y6gw150hyz4f3jd2;
	Tue, 10 Dec 2024 09:22:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DFCFC1A018D;
	Tue, 10 Dec 2024 09:23:16 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4cCmFdnk8mjEA--.28167S3;
	Tue, 10 Dec 2024 09:23:16 +0800 (CST)
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
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6585e36e-13a8-8352-2528-b0c2cb995bf4@huaweicloud.com>
Date: Tue, 10 Dec 2024 09:23:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bef7b96c-a6cc-4b83-99b2-848cecb3d3b1@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4cCmFdnk8mjEA--.28167S3
X-Coremail-Antispam: 1UD129KBjvJXoWrtw4kXF18Jw4UKrWxKr4xCrg_yoW8JrWrpw
	s7Ka4qyryDCr109rn5twnrXr9Yyw43Jr13XF15trZrCrs8JanYvFs5XanFgFW7ZrWxJw4j
	vFs8JasxZ3Wjv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU13ku3UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/12/10 2:02, Bart Van Assche 写道:
> 
>> 1) Set min_shallow_depth to 1 will end up setting wake_batch to 1,
>>     deadline has no reason to do this. And this will cause performance
>>     degradation in some high concurrency test, for both IO bandwidth
>>     and cpu usage.
> 
> As explained in the commit message, this is done because
> min_shallow_depth must be less than or equal to shallow_depth.
> Additionally, mq-deadline is not the only I/O scheduler that sets
> min_shallow_depth to 1. BFQ does this too.

No, BFQ is totally different, one task from bfq can be limited to just
one request, due to the cgroup policy of bfq.
> 
>> 2) async_depth is nr_requests, hence shallow_depth will always set to
>>     1 << bt->sb.shift. For consequence, no tag can be reserved.
> 
> This is not correct. dd->async_depth can be modified via sysfs.

So, I'm trying to understand, there are two cases:

1) the default value of async_depth is nr_requests, and no tag can be
reserved, right? Do we want to fix this?
2) User must change async_depth to a lower value to make it work.

Now, I understand why you want to change min_shallow_depth to 1.
However, I think we should also set min_shallow_depth while writing
sysfs as well.

> 
> Bart.
> .
> 

