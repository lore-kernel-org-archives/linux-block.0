Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BFE217F2C
	for <linux-block@vger.kernel.org>; Sat, 26 Oct 2024 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729922543; cv=none; b=ngxs2l2ZlbV1SZ8rLYqmLqtKKyUuXZbcpN/0rhgFnJ5wxBpZTcIfQqBrsswzHVN6oFYmFiEHa/Ohxc7EHSwWQ/ZnUZ2LA64XCaxSQLtj/jpum6aXSWkCwOxiYDAG47sKzytMhEjo+K6Tu5Z6Vkd10p2oj6CeGHhlysAyqizEA1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729922543; c=relaxed/simple;
	bh=/tXMNwg9226A2OKAfReb+b/WsY3Y5l/Zry6keNriVBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvUT3MDbcYFI4mvIngTM/amP2SnsBCe/VKvbMf/yMI/vo8/98KcMbbGJv4Yllt3nYDT+8adhOESkXqH/r6MA0IMauXfr0optiCTC9GiidEP2NdGWj60SJe3d6IKPZYV7laIIx20L2bCoSHNnxx2Et70YnEgFk+3TSQ1qInF95M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 49Q5uOar007707;
	Sat, 26 Oct 2024 14:56:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 49Q5tw00007570
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 26 Oct 2024 14:56:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <62e97223-a508-4174-9ba0-6f897149a825@I-love.SAKURA.ne.jp>
Date: Sat, 26 Oct 2024 14:55:59 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brd: fix null pointer when modprobe brd
To: Yu Kuai <yukuai1@huaweicloud.com>, Yang Erkun
 <yangerkun@huaweicloud.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-block@vger.kernel.org, yangerkun@huawei.com, axboe@kernel.dk,
        ulf.hansson@linaro.org, hch@lst.de, houtao1@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>, linux-modules@vger.kernel.org
References: <20241025070511.932879-1-yangerkun@huaweicloud.com>
 <a55c8d7e-cfd7-4ab9-ab45-bd7fdecaaf3c@I-love.SAKURA.ne.jp>
 <05915eac-e5c7-c293-d960-a781e91fd23d@huaweicloud.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <05915eac-e5c7-c293-d960-a781e91fd23d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav104.rs.sakura.ne.jp
X-Virus-Status: clean

On 2024/10/26 10:21, Yu Kuai wrote:
> Hi,
> 
> 在 2024/10/25 18:40, Tetsuo Handa 写道:
>> On 2024/10/25 16:05, Yang Erkun wrote:
>>> From: Yang Erkun <yangerkun@huawei.com>
>>>
>>> My colleague Wupeng found the following problems during fault injection:
>>>
>>> BUG: unable to handle page fault for address: fffffbfff809d073
>>
>> Excuse me, but subject says "null pointer" whereas dmesg says
>> "not a null pointer dereference". Is this a use-after-free bug?
>> Also, what verb comes after "when modprobe brd" ?
>>
>> Is this problem happening with parallel execution? If yes, parallelly
>> running what and what?
> 
> The problem is straightforward, to be short,
> 
> T1: morprobe brd
> brd_init
>  brd_alloc
>   add_disk
>         T2: open brd
>         bdev_open
>          try_module_get
>   // err path
>   brd_cleanup
>           // dereference brd_fops() while module is freed.

Then, fault injection is irrelevant, isn't it?

If bdev_open() can grab a reference before module's initialization phase
completes is a problem, I think that we can fix the problem with just

 int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	      const struct blk_holder_ops *hops, struct file *bdev_file)
 {
 (...snipped...)
 	ret = -ENXIO;
 	if (!disk_live(disk))
 		goto abort_claiming;
-	if (!try_module_get(disk->fops->owner))
+	if ((disk->fops->owner && module_is_coming(disk->fops->owner)) || !try_module_get(disk->fops->owner))
 		goto abort_claiming;
 	ret = -EBUSY;
 	if (!bdev_may_open(bdev, mode))
 (...snipped...)
 }

change. It would be cleaner if we can do

 bool try_module_get(struct module *module)
 {
 	bool ret = true;
 
 	if (module) {
 		/* Note: here, we can fail to get a reference */
-		if (likely(module_is_live(module) &&
+		if (likely(module_is_live(module) && !module_is_coming(module) &&
 			   atomic_inc_not_zero(&module->refcnt) != 0))
 			trace_module_get(module, _RET_IP_);
 		else
 			ret = false;
 	}
 	return ret;
 }

but I don't know if this change breaks something.
Maybe we can introduce a variant like

bool try_module_get_safe(struct module *module)
{
	bool ret = true;

	if (module) {
		/* Note: here, we can fail to get a reference */
		if (likely(module_is_live(module) && !module_is_coming(module) &&
			   atomic_inc_not_zero(&module->refcnt) != 0))
			trace_module_get(module, _RET_IP_);
		else
			ret = false;
	}
	return ret;
}

and use it from bdev_open().

