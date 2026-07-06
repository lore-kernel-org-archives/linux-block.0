Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1CA41610F;
	Mon,  6 Jul 2026 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344086; cv=none; b=K8pdXDU+305dKkrFthqdz9kyH04IJ2bQ3zdwBM8HudaZV0k6jP6Lo0bxmRGkR8HhFCY3GBTBrPii4CMjVxNTRxqOphr0LSVrp2XRuTcv4Xpmnmk2MmZTC4ny9XLf60GD62uAWnWOh9p2JLb15ynNdPePG0uGaOxnEgddIfjUBB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344086; c=relaxed/simple;
	bh=gaCJ25QjdQrF7nxW9Qz2pBDcYnjlAwyaj4KdNuWjQuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UrlrMg8ANlkyErerog926IwXOTpxuxzQdcWjl5bMxj0U1VrsDSQE46cbHlOMU4yCEkCC4ogCf75zIX/C1m5QInStWQXplWhrUp48g/v5u0CwpuwWxc6jQBVjiEMAzc3ryhxJNzKQAsFwl9tgxPNq32wNF2LTrfUTHAjGBz8MmU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gv4kQ6765zYQtlr;
	Mon,  6 Jul 2026 21:21:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 83D684058C;
	Mon,  6 Jul 2026 21:21:20 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHWHTOq0tqXCcQAQ--.50158S3;
	Mon, 06 Jul 2026 21:21:20 +0800 (CST)
Message-ID: <5f99b2f3-05c1-4754-9827-d55528861ecc@huaweicloud.com>
Date: Mon, 6 Jul 2026 21:21:18 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] null_blk: give the file-scope mutex a descriptive
 name
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
 dlemoal@kernel.org, nilay@linux.ibm.com, linux-block@vger.kernel.org,
 kch@nvidia.com, johannes.thumshirn@wdc.com, kbusch@kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260706123507.3809871-1-wozizhi@huaweicloud.com>
 <20260706123507.3809871-3-wozizhi@huaweicloud.com>
 <9004743e-f522-424e-a1ab-8779ecc6da02@acm.org>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <9004743e-f522-424e-a1ab-8779ecc6da02@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHWHTOq0tqXCcQAQ--.50158S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1kWw48ur1xGr1rGr43trb_yoW8Gr4fp3
	ZYgw4DJ348Wrs7Z3W7XFZ7KrZavwn3uay5tF4UGry0kw4DZr9avFZIyr48W3yUWws3JrWY
	qa45X3W2yay8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2026/7/6 21:12, Bart Van Assche 写道:
> On 7/6/26 5:35 AM, Zizhi Wo wrote:
>> The file-scope lock mutex mainly serializes access to the global 
>> nullb_list
>> and related device setup. Rename it to "nullb_list_lock" to make its
>> purpose clear. No functional change.
> 
>  From commit a2db328b0839 ("null_blk: fix null-ptr-dereference while
> configuring 'power' and 'submit_queues'"):
> 
>      Writing 'power' and 'submit_queues' concurrently will trigger kernel
>      panic:
>      [ ... ]
>      Fix this problem by resuing the global mutex to protect
>      nullb_device_power_store() and nullb_update_nr_hw_queues() from 
> configfs.
> 
> This makes it clear that the "lock" mutex has a broader purpose than
> only protecting nullb_list. Hence, the name nullb_list_lock is
> confusing. How about using the name "nullb_lock"?
> 
> Thanks,
> 
> Bart.

Thanks for the reminder! Agreed that "nullb_list_lock" is too narrow
since it also serializes nullb_device_power_store() and
nullb_update_nr_hw_queues().

However, I'm a bit worried that "nullb_lock" is easy to confuse with the
per-device spinlock "nullb->lock"... They are only one "->" apart?

Would "nullb_global_lock" (or "nullb_config_lock") work better? It
reflects the broader purpose and avoids clashing with nullb->lock.

Thanks,
Zizhi Wo

