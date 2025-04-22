Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B204310A1F;
	Tue, 22 Apr 2025 03:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745290993; cv=none; b=RoRvZVPbq8HAlJ9WZqmvXfJqvW7Ocw9/UdYxNmZo9rniK0/p2qLe7LyVgyu8N9pluYnhdqCEINMHSotjYGi52nhaa8y+LoVqR4z0GZKuQivzDj1+FDIf6xaSi0zRuA5D58ur+DQQncGOvCY6edJaVxSCMr9XwNiAri81Ab0N8U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745290993; c=relaxed/simple;
	bh=Uq7MMe7AeeZt9Qok1hStV+tYZiwjOTGaEkdNt5tijCQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Woic1cBSsVJ7mODHhXzam60lcAl7vHvvqufVPmYnPal0+BJSW8jwnn5OH2/9peeueaToCYRI3PTdgosnbyWXHmA04RezchsDRy9tUHs8FbgPM3Wd1RzsyaGQ1ado4JLACluNduiqsS/UdYbghdvoVaM4pl5x1QH6VkzWfJ5GgNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZhRqZ2Y9Bz4f3jY9;
	Tue, 22 Apr 2025 11:02:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 412921A01A5;
	Tue, 22 Apr 2025 11:02:58 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl_gBgdomaHKKA--.12010S3;
	Tue, 22 Apr 2025 11:02:58 +0800 (CST)
Subject: Re: 10x I/O await times in 6.12
To: Keith Busch <kbusch@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Matt Fleming <mfleming@cloudflare.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team <kernel-team@cloudflare.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <CAGis_TVSAPjYwVjUyur0_NFsDi9jmJ_oWhBHrJ-bEknG-nJO9Q@mail.gmail.com>
 <aAZiwGy1A7J4spDk@kbusch-mbp.dhcp.thefacebook.com>
 <ad67b397-9483-d3c3-203e-687cefb9e481@huaweicloud.com>
 <aAbzW1POQP9z5BWS@kbusch-mbp.dhcp.thefacebook.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <98915ccf-4fe8-5d96-0b59-b3f3d5a66f81@huaweicloud.com>
Date: Tue, 22 Apr 2025 11:02:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aAbzW1POQP9z5BWS@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl_gBgdomaHKKA--.12010S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4fCFW7Xw4fJFW8Zr4DCFg_yoW8Aw4UpF
	Z0qa1ftr4UAFy0yw4Ivrs7XryrK347Gry2vryrGryavryDKrnakrW2kws09a47ZF1rC3yI
	yFWrK347X34jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/04/22 9:39, Keith Busch 写道:
> On Tue, Apr 22, 2025 at 09:28:02AM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/04/21 23:22, Keith Busch 写道:
>>> On Mon, Apr 21, 2025 at 09:53:10AM +0100, Matt Fleming wrote:
>>>> Hey there,
>>>>
>>>> We're moving to 6.12 at Cloudflare and noticed that write await times
>>>> in iostat are 10x what they were in 6.6. After a bit of bpftracing
>>>> (script to find all plug times above 10ms below), it seems like this
>>>> is an accounting error caused by the plug->cur_ktime optimisation
>>>> rather than anything more material.
>>>>
>>>> It appears as though a task can enter __submit_bio() with ->plug set
>>>> and a very stale cur_ktime value on the order of milliseconds. Is this
>>>> expected behaviour? It looks like it leads to inaccurate I/O times.
>>>
>>> There are places with a block plug that call cond_resched(), which
>>> doesn't invalidate the plug's cached ktime. You could end up with a
>>> stale ktime if your process is scheduled out.
>>
>> This is wrong, scheduled out will clear cached ktime. You can check
>> it easily since there are not much caller to clear ktime.
> 
> Huh? cond_resched() calls __schedule() directly via
> preempt_schedule_common(), which most certainly does not clear the
> plug's time.

Yes, this is the preempt case, where pluged IO is not issued, this
behaviour is already known. I thought you mean the normal case, like
you said below. :(
> 
> The timestamp is only invalidated from schedule() or
> rt_mutex_post_schedule(). You can check it ... "easily".

So, either preempt takes a long time, or generate lots of bio to plug
takes a long time can both results in larger iostat IO latency. I still
think delay setting request start_time to blk_mq_flush_plug_list() might
be a reasonable fix.

Thanks,
Kuai
> 
> .
> 

