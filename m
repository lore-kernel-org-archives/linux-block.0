Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03D1F16B;
	Wed, 23 Apr 2025 03:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745379371; cv=none; b=Q9eRypOrvFw2/z9Kgppv9UvLPrYcg7lF5+SkgQT+8I53tO/E/cq/RVHSwkh2B2WPvaO/1rXJhBshUs5c4eyg8SDxYSvD5exOCAnZvzJNITL1MkhPlpaFn9c8W4TUV4+1E2WULdNRToGf3NsrQN+vIfYrRB1jyDg+kmySVd2dVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745379371; c=relaxed/simple;
	bh=55psKTM7ONmh9KzL1u8CuHWX+eeDNZ58/9qn9OYu3VQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WVhf6SvVOJncTrhtGwWzxrFvRPCRrFHVrUb1qDfrisSF1rY7EvY7Ix0KIw5cBbyhld8RwM5JOroy9c7RY4Do78YhujUkuLJuJSxJByQhK6RfYbj677f0rmg0xcwv1qXgJPUTBYZUHiZ/UBEK3QmcsYnXlMy9oHmFEmCniFcULHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zj4WG4srpz4f3lDF;
	Wed, 23 Apr 2025 11:35:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2A1121A06D7;
	Wed, 23 Apr 2025 11:36:04 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnSl8jYAhoOskwKQ--.27052S3;
	Wed, 23 Apr 2025 11:36:04 +0800 (CST)
Subject: Re: 10x I/O await times in 6.12
To: Matt Fleming <mfleming@cloudflare.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team <kernel-team@cloudflare.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <CAGis_TVSAPjYwVjUyur0_NFsDi9jmJ_oWhBHrJ-bEknG-nJO9Q@mail.gmail.com>
 <aAZiwGy1A7J4spDk@kbusch-mbp.dhcp.thefacebook.com>
 <ad67b397-9483-d3c3-203e-687cefb9e481@huaweicloud.com>
 <aAbzW1POQP9z5BWS@kbusch-mbp.dhcp.thefacebook.com>
 <98915ccf-4fe8-5d96-0b59-b3f3d5a66f81@huaweicloud.com>
 <CAGis_TV7gq1fHM0YFz798G91poeKQWYo2cZq0eEo7ydT1Qen+A@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <463e4707-d05c-7114-b04a-86b6ca01a234@huaweicloud.com>
Date: Wed, 23 Apr 2025 11:36:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGis_TV7gq1fHM0YFz798G91poeKQWYo2cZq0eEo7ydT1Qen+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnSl8jYAhoOskwKQ--.27052S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy8Ww48Gw17Kry5uryrtFb_yoW8GF18pF
	WqqayFyrn5A3y0kw1Iyr4UX3yF9w1xJrW7trWrJFWxZrnFgr12kFs7K3yFvFWUZrWkWw4I
	yF4Fg3y7W39Yg3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VU18sqtUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/04/22 18:45, Matt Fleming 写道:
> On Tue, 22 Apr 2025 at 04:03, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> So, either preempt takes a long time, or generate lots of bio to plug
>> takes a long time can both results in larger iostat IO latency. I still
>> think delay setting request start_time to blk_mq_flush_plug_list() might
>> be a reasonable fix.
> 
> I'll try out your proposed fix also. Is it not possible for a task to
> be preempted during a blk_mq_flush_plug_list() call, e.g. in the
> driver layer?

Let's focus on your regression first, preempt during flush plug doesn't
introduce new gap, rq->start_time_ns is before that already before
caching time in plug.
> 
> I understand that you might not want to issue I/O on preempt, but
> that's a distinct problem from clearing the cached ktime no? There is
> no upper bound on the amount of time a task might be scheduled out due
> to preempt which means there is no limit to the staleness of that
> value. I would assume the only safe thing to do (like is done for
> various other timestamps) is reset it when the task gets scheduled
> out.

Yes, it's resonable to clear cached time for the preempt case. What
I'm concerned is that even the task never scheduled out, the time can
still stale for milliseconds. I think that is possilble if a lots of bio
are endup in the same roud of plug(a lot of IO merge).

Thanks,
Kuai

> 
> .
> 

