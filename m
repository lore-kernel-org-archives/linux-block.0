Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8B63BE659
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784712063; cv=none; b=GkH10pngL+ji8Df/8aR1jW6sr6joXZOOohZRgWEWk9uUusFGV1c0JWzAcZsd1TDvXstG0H4CEymxGjogZA5YalJKkko/q3RVYD8zdUjJMfELz+o4OdDlyylkbwqA6dWIZYawMIH2o7AoMWRN9NB9Oqyf6iJyvc/ZJV+mcGs0uUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784712063; c=relaxed/simple;
	bh=MWE9YMAo2u0tD8fyx2H5Bvw4JhSnHaS6r+uqIsGl/IM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Jk+OCKMYAZqc7Xfg5a0ZtCrhVg1kqua1AiCgeg/jo2nzfSmx1Cti6vnhr68Drdy9B5HKIp1IJflTNHeaeYahMKshJEtLW3VnIYETqse5eVFrOKb5nHLQKB7by3/MrPd0zjbnnQoKI3othctA4hZYusLrjiycFvlXFnntxx1MKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WKFKDnsr; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WKFKDnsr"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xxGJuQD1U6kf7fqtR32Dn9EtONttEvCxanCnYUuhlw4=;
	b=WKFKDnsrT9f+9/xeyKW8jsLek+uERKUt/tI603fc7i2rKub1ntgywsY4YWUPEsw2o6rzFCxZV
	o+7cdmcVyqvLQ21+C/7eb8aN2H0tkrqdyYJqVBK66yZ720Rl9TA5EDj0xhSxljKOY9lrbs1gVg2
	br+GotzE/nPip7hYM/VRwwQ=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h4pQp0WmfzKmW0;
	Wed, 22 Jul 2026 17:11:30 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 395024057C;
	Wed, 22 Jul 2026 17:20:55 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 22 Jul 2026 17:20:54 +0800
Message-ID: <45240cc5-1af3-40b3-93bf-7185ac4d0d55@huawei.com>
Date: Wed, 22 Jul 2026 17:20:53 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] nbd: remove queue freeze in nbd_add_socket
From: yangerkun <yangerkun@huawei.com>
To: <yukuai@fygo.io>, <josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@lst.de>
CC: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>,
	<wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>,
	<nbd@other.debian.org>
References: <20260713065644.1637594-1-yangerkun@huawei.com>
 <20260713065644.1637594-4-yangerkun@huawei.com>
 <1b8b00e4-3f6f-42f1-a52a-b4d99c9f2cc3@fygo.io>
 <5799ffec-f179-47ec-b685-1f992648aff5@fygo.io>
 <b49d2daf-aae9-4642-9b45-7efc1d0981fc@huawei.com>
In-Reply-To: <b49d2daf-aae9-4642-9b45-7efc1d0981fc@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2026/7/22 16:45, yangerkun 写道:
> 
> 
> 在 2026/7/22 14:35, yu kuai 写道:
>> Hi,
>>
>> 在 2026/7/22 11:17, yu kuai 写道:
>>> Hi,
>>>
>>> 在 2026/7/13 14:56, Yang Erkun 写道:
>>>> nbd_add_socket can never run concurrently with inflight I/O:
>>>>
>>>>     - netlink path: nbd_genl_connect calls nbd_add_socket before
>>>>       nbd_start_device, so no I/O can happened when invoking 
>>>> nbd_add_socket,
>>>>       nbd_genl_reconfigure cannot too since it won't call 
>>>> nbd_add_socket
>>>>
>>>>     - ioctl path: NBD_SET_SOCK cannot be called after NBD_DO_IT with
>>>>       the previous commit, so capability of nbd will keep 0 while
>>>>       invoking NBD_SET_SOCK
>>>>
>>>> Removing the freeze in nbd_add_socket to speed up nbd device startup.
>>> Check nbd_open(), the pid is not checked there, which means the nbd 
>>> device
>>> can be opened after add_disk() succeed. Normally read/write IO will 
>>> not pass
>>> bio_check_eod() checking, however, there can be special zero sized 
>>> bio that
>>> might still be issued to nbd device. So I think there should be a pid 
>>> checking
>>> in nbd_open() for this patch, and I'm not aware of any special IO 
>>> mush be handled
>>> before nbd_start_device(). Otherwise, the freeze is still necessary 
>>> since
>>> nbd_handle_cmd() will deference config->socks[] directly.
>>
>> Sorry this is a mistake, nbd_open() must succeed before pid is set, 
>> because of ioctl
>> like NBD_SET_SOCK and NED_DO_IT :( I just forgot this simple case.
> 
> nbd can only accept request from bio, so bio_check_eod will reject them 
> all?

Sorry, for read/write bio, bio_check_eod will reject them, for flush 
only bio, if (!bdev_write_cache(bdev)) in submit_bio_noacct will reject 
it. So it seems safe here.

> 
>>
>>>
>>>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>>>> ---
>>>>     drivers/block/nbd.c | 9 ---------
>>>>     1 file changed, 9 deletions(-)
>>>>
>>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>>>> index a15553ab4b97..0755b7046ed4 100644
>>>> --- a/drivers/block/nbd.c
>>>> +++ b/drivers/block/nbd.c
>>>> @@ -1272,7 +1272,6 @@ static int nbd_add_socket(struct nbd_device 
>>>> *nbd, unsigned long arg,
>>>>         struct socket *sock;
>>>>         struct nbd_sock **socks;
>>>>         struct nbd_sock *nsock;
>>>> -    unsigned int memflags;
>>>>         int err;
>>>>         /* Arg will be cast to int, check it to avoid overflow */
>>>> @@ -1283,12 +1282,6 @@ static int nbd_add_socket(struct nbd_device 
>>>> *nbd, unsigned long arg,
>>>>             return err;
>>>>         nbd_reclassify_socket(sock);
>>>> -    /*
>>>> -     * We need to make sure we don't get any errant requests while 
>>>> we're
>>>> -     * reallocating the ->socks array.
>>>> -     */
>>>> -    memflags = blk_mq_freeze_queue(nbd->disk->queue);
>>>> -
>>>>         if (!netlink && !nbd->task_setup &&
>>>>             !test_bit(NBD_RT_BOUND, &config->runtime_flags))
>>>>             nbd->task_setup = current;
>>>> @@ -1335,12 +1328,10 @@ static int nbd_add_socket(struct nbd_device 
>>>> *nbd, unsigned long arg,
>>>>         INIT_WORK(&nsock->work, nbd_pending_cmd_work);
>>>>         socks[config->num_connections++] = nsock;
>>>>         atomic_inc(&config->live_connections);
>>>> -    blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
>>>>         return 0;
>>>>     put_socket:
>>>> -    blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
>>>>         sockfd_put(sock);
>>>>         return err;
>>>>     }
>>
> 
> 

