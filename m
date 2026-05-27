Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FDA2459DD
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 03:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779853963; cv=none; b=WKixVnbocSdsY5hCrmxFludb+RHl7MoPkJO5s9TEywXovMKZmEYzEHzEQpBln0pCA/fS/h1Gph2Lb5UNY1M1PBtAgJCUxdkaV0NSF8efOqwH3Xd+yfDa2Cq2290fFNQ3+p6WR2RgbLA28axPtUsRAXWxj9Xtl0fYiiyYM9ixX18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779853963; c=relaxed/simple;
	bh=dJXb19Osa1h+praf5iKuqDSE/LsePmEMFxH6RkgLnKY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=lnmAsYE/VJlIJT0IDvbEwgvwbPxiRSsKifkOc4c5LWITgr+aTkSqwzRPcEvmBXl+5t/ZIBf7XHAMdRLQgBTVEEMlEHBYHi+KVDgvXUwBgWr4uCZP+9Cs6miZMJeqtdAdCxTgOXTztDpvtqKt4uC5jzOGU+d8wTUdYcwFuZKzBzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=AgM1hy8A; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="AgM1hy8A"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RB8V7hcKY/bxo8qZrnz1kBrq6dvXt64MiANiM1jN/qA=;
	b=AgM1hy8AkkFrr7j7TZNENvgwImFMEhEgv5mp2KJPAojIU30hL4oyaDtM4+Fx+HfNGvXX5bZ4N
	5349HlitP8quWKsCu0vUUqb7RiIk+x/rkyDbhhpFojiGSH+C/o/QgtEQ9m8PigfH7a5oW2iulK/
	akXY3rPmSvGvQjb0A9SiMmg=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gQFqW2pb7znTWb;
	Wed, 27 May 2026 11:44:39 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id A4A8940539;
	Wed, 27 May 2026 11:52:36 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 27 May 2026 11:52:36 +0800
Message-ID: <9bd7c679-b5b4-4274-95ba-f2e3da1a531e@huawei.com>
Date: Wed, 27 May 2026 11:52:35 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "nbd: freeze the queue while we're adding
 connections"
From: yangerkun <yangerkun@huawei.com>
To: <josef@toxicpanda.com>, <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <nbd@other.debian.org>, yangerkun
	<yangerkun@huawei.com>
References: <20260526115253.746625-1-yangerkun@huawei.com>
In-Reply-To: <20260526115253.746625-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2026/5/26 19:52, Yang Erkun 写道:
> This reverts commit b98e762e3d71e893b221f871825dc64694cfb258.
> 
> Commit b98e762e3d71 ("nbd: freeze the queue while we're adding
> connections") added blk_mq_freeze_queue/blk_mq_unfreeze_queue in
> nbd_add_socket() to protect krealloc(config->socks) from concurrent I/O
> that could cause a Use-After-Free.
> 
> However, analysis shows that in all current code paths, concurrent I/O
> cannot actually reach nbd_add_socket():
> 
> 1. nbd_genl_connect() path:
>     nbd_add_socket() is called first, and nbd_start_device() -- which
>     starts the queue and enables I/O -- is called only after all sockets
>     have been added. So the freeze/unfreeze runs against an idle queue,
>     marking then waiting on a percpu_ref that is already zero, and then
>     resurrecting it -- a pure no-op that burns an RCU grace period per
>     socket on multi-core systems.
> 
> 2. nbd_ioctl(NBD_SET_SOCK) path:
>     The task_setup check enforces that only the thread which performed
>     the first NBD_SET_SOCK can call NBD_SET_SOCK again. That thread is
>     blocked in NBD_DO_IT's wait_event_interruptible, so it cannot issue
>     another NBD_SET_SOCK concurrently with I/O. Other threads are
>     rejected by the task_setup != current check.

Apologies, but the analysis provided here is inadequate. A 
use-after-free (UAF) can still occur in the following scenario:

task A: ioctl NBD_SET_SOCK => task_setup = A
task B: ioctl NBD_DO_IT    => nbd_start_device_ioctl, nbd can receive IO
task A: ioctl NBD_SET_SOCK => task_setup == A, so racer can happend with
concurrent IO!

This patch is misleading, please disregard it. Sorry once again.

> 
> 3. nbd_genl_reconfigure() does not call nbd_add_socket() at all; it
>     uses nbd_reconnect_socket() which replaces a dead socket in-place
>     without reallocating config->socks.
> 
> Therefore the freeze/unfreeze provides no actual protection in any
> reachable code path, while imposing the cost of blk_mq_freeze_queue
> (percpu_ref_kill + RCU grace period wait + percpu_ref_resurrect) on
> every socket addition during device setup[1].
> 
> Revert the change to eliminate the unnecessary overhead.
> 
> Link: https://lore.kernel.org/all/20260327091223.4147956-1-leo.lilong@huaweicloud.com/ [1]
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>   drivers/block/nbd.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index fe63f3c55d0d..9033d996c9a9 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1245,22 +1245,16 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
>   	struct socket *sock;
>   	struct nbd_sock **socks;
>   	struct nbd_sock *nsock;
> -	unsigned int memflags;
>   	int err;
>   
>   	/* Arg will be cast to int, check it to avoid overflow */
>   	if (arg > INT_MAX)
>   		return -EINVAL;
> +
>   	sock = nbd_get_socket(nbd, arg, &err);
>   	if (!sock)
>   		return err;
>   
> -	/*
> -	 * We need to make sure we don't get any errant requests while we're
> -	 * reallocating the ->socks array.
> -	 */
> -	memflags = blk_mq_freeze_queue(nbd->disk->queue);
> -
>   	if (!netlink && !nbd->task_setup &&
>   	    !test_bit(NBD_RT_BOUND, &config->runtime_flags))
>   		nbd->task_setup = current;
> @@ -1300,12 +1294,9 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
>   	INIT_WORK(&nsock->work, nbd_pending_cmd_work);
>   	socks[config->num_connections++] = nsock;
>   	atomic_inc(&config->live_connections);
> -	blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
> -
>   	return 0;
>   
>   put_socket:
> -	blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
>   	sockfd_put(sock);
>   	return err;
>   }

