Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237D942A7B3
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709931; cv=none; b=t9emSuc4L3wKwC0sWPnzP1U+tbhZ2Dhbl0+nP9eKmPdFxwzWbSWcNDs1qJCaAXomcVnsWwkg7/kTxgwbUAtXxJUVKmWUYgPZg7dOj6Dv8CLH1wBP+iAXPBmunlt2LwfR9nP5LXHFunZeFVWRsjaO8IV0tDS9BDXeHsO6mS5qZw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709931; c=relaxed/simple;
	bh=QkcoB8HT7APjYTLTaoAu97a8uHmNuddAOU1jwJ6FjlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gkbhMy42C3/qUapNmx4MOC9rmN9KKsbhNCYK/P8AlYB9Nh3aBWAR97HLsAla/VdTs2UaiF+2QLmmBzLi217lV8NF/5CBeo5gaOpptw3rYan5DLuKsF/va/S3iKu51OKH4YXltflcqpWm+CjyN4n2UKzDRwvteNtvR3nhEDWg+v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dFrd0t5j; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dFrd0t5j"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EgDYXau6PYq+TNzlNlIRRTJ9Rl8qZt4jKMYBj68+J1U=;
	b=dFrd0t5jM9t953TO3j2FCFVTKGCwAnZRNET05ooCsmcVt+yTAhI39tTQP0nfuyLO1coKTfu3S
	7/v70vpoYOv6Hq+qzt4HYvASsUfNKHOpBheNig4kRPXeDeJvzgxVaedHeHh5DRu+kNbFhAzeF0u
	0TAZFXf23qwSlJ2rWwtBbKI=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h4ndj75Kqz1prlh;
	Wed, 22 Jul 2026 16:35:53 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id AE39C4056E;
	Wed, 22 Jul 2026 16:45:18 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 22 Jul 2026 16:45:17 +0800
Message-ID: <b49d2daf-aae9-4642-9b45-7efc1d0981fc@huawei.com>
Date: Wed, 22 Jul 2026 16:45:17 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] nbd: remove queue freeze in nbd_add_socket
To: <yukuai@fygo.io>, <josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@lst.de>
CC: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>,
	<wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>,
	<nbd@other.debian.org>
References: <20260713065644.1637594-1-yangerkun@huawei.com>
 <20260713065644.1637594-4-yangerkun@huawei.com>
 <1b8b00e4-3f6f-42f1-a52a-b4d99c9f2cc3@fygo.io>
 <5799ffec-f179-47ec-b685-1f992648aff5@fygo.io>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <5799ffec-f179-47ec-b685-1f992648aff5@fygo.io>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2026/7/22 14:35, yu kuai 写道:
> Hi,
> 
> 在 2026/7/22 11:17, yu kuai 写道:
>> Hi,
>>
>> 在 2026/7/13 14:56, Yang Erkun 写道:
>>> nbd_add_socket can never run concurrently with inflight I/O:
>>>
>>>     - netlink path: nbd_genl_connect calls nbd_add_socket before
>>>       nbd_start_device, so no I/O can happened when invoking nbd_add_socket,
>>>       nbd_genl_reconfigure cannot too since it won't call nbd_add_socket
>>>
>>>     - ioctl path: NBD_SET_SOCK cannot be called after NBD_DO_IT with
>>>       the previous commit, so capability of nbd will keep 0 while
>>>       invoking NBD_SET_SOCK
>>>
>>> Removing the freeze in nbd_add_socket to speed up nbd device startup.
>> Check nbd_open(), the pid is not checked there, which means the nbd device
>> can be opened after add_disk() succeed. Normally read/write IO will not pass
>> bio_check_eod() checking, however, there can be special zero sized bio that
>> might still be issued to nbd device. So I think there should be a pid checking
>> in nbd_open() for this patch, and I'm not aware of any special IO mush be handled
>> before nbd_start_device(). Otherwise, the freeze is still necessary since
>> nbd_handle_cmd() will deference config->socks[] directly.
> 
> Sorry this is a mistake, nbd_open() must succeed before pid is set, because of ioctl
> like NBD_SET_SOCK and NED_DO_IT :( I just forgot this simple case.

nbd can only accept request from bio, so bio_check_eod will reject them all?

> 
>>
>>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>>> ---
>>>     drivers/block/nbd.c | 9 ---------
>>>     1 file changed, 9 deletions(-)
>>>
>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>>> index a15553ab4b97..0755b7046ed4 100644
>>> --- a/drivers/block/nbd.c
>>> +++ b/drivers/block/nbd.c
>>> @@ -1272,7 +1272,6 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
>>>     	struct socket *sock;
>>>     	struct nbd_sock **socks;
>>>     	struct nbd_sock *nsock;
>>> -	unsigned int memflags;
>>>     	int err;
>>>     
>>>     	/* Arg will be cast to int, check it to avoid overflow */
>>> @@ -1283,12 +1282,6 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
>>>     		return err;
>>>     	nbd_reclassify_socket(sock);
>>>     
>>> -	/*
>>> -	 * We need to make sure we don't get any errant requests while we're
>>> -	 * reallocating the ->socks array.
>>> -	 */
>>> -	memflags = blk_mq_freeze_queue(nbd->disk->queue);
>>> -
>>>     	if (!netlink && !nbd->task_setup &&
>>>     	    !test_bit(NBD_RT_BOUND, &config->runtime_flags))
>>>     		nbd->task_setup = current;
>>> @@ -1335,12 +1328,10 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
>>>     	INIT_WORK(&nsock->work, nbd_pending_cmd_work);
>>>     	socks[config->num_connections++] = nsock;
>>>     	atomic_inc(&config->live_connections);
>>> -	blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
>>>     
>>>     	return 0;
>>>     
>>>     put_socket:
>>> -	blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
>>>     	sockfd_put(sock);
>>>     	return err;
>>>     }
> 

