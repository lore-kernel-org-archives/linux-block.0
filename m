Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101D21E8342;
	Mon, 10 Nov 2025 04:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747551; cv=none; b=gqjZ0iGHHkenmy2t6gcHVTAuvInpSQlTxgwbRgEvalmc0Gnu5/0Y6/kGrYyvfJXQSVamlUtbQRcuIZwEZdiZ6TWMONSy06BQxYs69IwyEw8R/6vuNN3moU50IxTpghyCrW4PWl4cFjs7cBauyrVFcLZwwDy/WndoXc5gW20jZ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747551; c=relaxed/simple;
	bh=fCzNOcCv+34id0JN6CaPhdnrpIkEFQLgtspsZOCQFZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KzOW+XdykU84GoUSRLDgEjh95jkTAyUwBjAvKnlMMY3LgyHpXg/kfT/VXv7C6JhhOShL9QGj5VzjTtKM6u8smb58wRW8M8heQeCVZEOUMHahkDt2foG2GkFx+/peItp3811Gndbi2xb2VyKasG6pov4SA3o7n7NNgrEhwZ+YOhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=a7USyjRm; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=a7USyjRm; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="a7USyjRm";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="a7USyjRm"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wX2mOYwb+MegAjrRKvNO6FT3ETpFUSjsdZcrt+5LHv8=;
	b=a7USyjRmWWpR1Be6G2EEy/lNN8xVjlyspc1/0Xxm01+J8s7yn6Kw2b3duTCu+1MLx/ICbc57g
	l1m98FTsiy4BAKaDuAW7NI6vKcrjYkMFBLkPAU627Dgf3CiqcVnO1L+JnYAXNDjiZdQ7vjqIE2R
	nsfX435YOMYhWvz6he1Z0Z0=
Received: from canpmsgout08.his.huawei.com (unknown [172.19.92.156])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4d4bfk1bVsz1BGFf;
	Mon, 10 Nov 2025 12:05:18 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wX2mOYwb+MegAjrRKvNO6FT3ETpFUSjsdZcrt+5LHv8=;
	b=a7USyjRmWWpR1Be6G2EEy/lNN8xVjlyspc1/0Xxm01+J8s7yn6Kw2b3duTCu+1MLx/ICbc57g
	l1m98FTsiy4BAKaDuAW7NI6vKcrjYkMFBLkPAU627Dgf3CiqcVnO1L+JnYAXNDjiZdQ7vjqIE2R
	nsfX435YOMYhWvz6he1Z0Z0=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4d4bd33h7wzmV7F;
	Mon, 10 Nov 2025 12:03:51 +0800 (CST)
Received: from kwepemh100003.china.huawei.com (unknown [7.202.181.85])
	by mail.maildlp.com (Postfix) with ESMTPS id C737B180043;
	Mon, 10 Nov 2025 12:05:29 +0800 (CST)
Received: from [10.174.178.72] (10.174.178.72) by
 kwepemh100003.china.huawei.com (7.202.181.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 12:05:28 +0800
Message-ID: <f5a2e5e7-d46e-45fa-bd28-c58bd7134d8e@huawei.com>
Date: Mon, 10 Nov 2025 12:05:28 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: defer config put in recv_work
To: Lizhi Xu <lizhi.xu@windriver.com>, <zhengqixing@huaweicloud.com>
CC: <axboe@kernel.dk>, <houtao1@huawei.com>, <josef@toxicpanda.com>,
	<linan122@h-partners.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nbd@other.debian.org>, <xiubli@redhat.com>,
	<yangerkun@huawei.com>, <yi.zhang@huawei.com>
References: <20251108070202.1816004-1-zhengqixing@huaweicloud.com>
 <20251110005453.546675-1-lizhi.xu@windriver.com>
From: Zheng Qixing <zhengqixing@huawei.com>
In-Reply-To: <20251110005453.546675-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemh100003.china.huawei.com (7.202.181.85)

Hi,


在 2025/11/10 8:54, Lizhi Xu 写道:
> On Sat,  8 Nov 2025 15:02:02 +0800, Zheng Qixing wrote:
>> Reported-by: syzbot+56fbf4c7ddf65e95c7cc@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/6907edce.a70a0220.37351b.0014.GAE@google.com/T/
>> Fixes: 87aac3a80af5 ("nbd: make the config put is called before the notifying the waiter")
>> Depends-on: e2daec488c57 ("nbd: Fix hungtask when nbd_config_put")
>> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
>> ---
>>   drivers/block/nbd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index a853c65ac65d..215fc18115b7 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -1024,9 +1024,9 @@ static void recv_work(struct work_struct *work)
>>   	nbd_mark_nsock_dead(nbd, nsock, 1);
>>   	mutex_unlock(&nsock->tx_lock);
>>
>> -	nbd_config_put(nbd);
>>   	atomic_dec(&config->recv_threads);
>>   	wake_up(&config->recv_wq);
>> +	nbd_config_put(nbd);
>>   	kfree(args);
>>   }
> This only makes the problem more hidden, and that's far from enough.
> I tested the same patch on syzbot on October 3rd before you did; you
> can check it out here [1].
>
> [1] https://syzkaller.appspot.com/bug?extid=56fbf4c7ddf65e95c7cc


The same patch was triggered by eslam.medhat1993 on Nov 5 via syzbot,

but it didn't produce the same stack trace. Is this stack trace necessarily

related to the UAF issue in nbd? It seems more likely to be a memory

corruption problem, but I'm not certain.


In addition, this issue arises from the mixed use of netlink and ioctl. 
Since

user-space tools generally do not mix these two interfaces, I believe a 
simple

solution along these lines could effectively avoid the UAF problem.


Regards,

Qixing


