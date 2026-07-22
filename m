Received: from va-2-58.ptr.blmpb.com (va-2-58.ptr.blmpb.com [209.127.231.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE25238237F
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 03:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784690289; cv=none; b=AsXFNsnK9gTvBturWs4PMS/S5raGCpLC/96dgmvGCx8Jv8VneyCgYxQDIMuneaPcAuPc4VsxQOZM+7970I2biDt57hhwokPPyBKfEQzrbz5ZBFghRocZJD1x6Iv4it3Yd49LJJch/vD3NidopXZt/7xnmNC98/SCHQOwJPloD24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784690289; c=relaxed/simple;
	bh=L7abnYzoWqdpjO+zhppS6uYVZGEqfSVmMRMptoBVgp8=;
	h=Mime-Version:References:Subject:To:Cc:From:Message-Id:In-Reply-To:
	 Date:Content-Type; b=lnVttc8ZTzHWV67kYpAbX4aYUOcdm3ujJa6c/sqA7CR5na96Q/cDO2lxSsmO2dggJDJdjYwm19ycCCCmSKlYVQYQVGnMLaCy4t8GPEvquExUCx9gnn5MnjzxPcnYwXmJ1y9rVLiKQnMUxwxooEG6DsmPoQHO+w4dh0suN8o0yi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=meGa2SWC; arc=none smtp.client-ip=209.127.231.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="meGa2SWC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1784690273;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=vxs8EDeevO1T33Y+DfZMEPQj6RRLgEhqCpYw2G+EaGk=;
 b=meGa2SWCd81MqbubAAwfgcPmjuVRdG6h5wGKHRQR8lqp7aiGWERgEFzC83mIb4ElZosa4X
 4Gk69U7uasFowkEBMTlafOO1f7IwI1AKtci/NiBOoYnnM+uMTHyoTm03T4/vrl5dVA2B+V
 OnfUCxwGa9XBh/yKgc4aa+oX2zsc7JwChXTcxHr5wKjqdRcu/u8LHvPGTEuSMv47de5w0x
 dh7SCGF87WKyUa7LWr06hNHmr9RDGhA1OXNU8chuhX5WS3hGEDzdbRwOVL72rfzUt/Nef5
 xui3L4jTHws2xHo23fbXCOJim+dgH7DVcsEYvL68QlDDmD3DxxWXh3oGjMqhzQ==
Reply-To: yukuai@fygo.io
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: yu kuai <yukuai@fygo.io>
References: <20260713065644.1637594-1-yangerkun@huawei.com> <20260713065644.1637594-4-yangerkun@huawei.com>
Subject: Re: [PATCH v3 3/6] nbd: remove queue freeze in nbd_add_socket
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
From: "yu kuai" <yukuai@fygo.io>
Message-Id: <1b8b00e4-3f6f-42f1-a52a-b4d99c9f2cc3@fygo.io>
X-Lms-Return-Path: <lba+26a603660+1ecd86+vger.kernel.org+yukuai@fygo.io>
In-Reply-To: <20260713065644.1637594-4-yangerkun@huawei.com>
Date: Wed, 22 Jul 2026 11:17:48 +0800
Received: from [192.168.1.104] ([39.182.0.167]) by smtp.larksuite.com with ESMTPS; Wed, 22 Jul 2026 03:17:51 +0000
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

=E5=9C=A8 2026/7/13 14:56, Yang Erkun =E5=86=99=E9=81=93:
> nbd_add_socket can never run concurrently with inflight I/O:
>
>   - netlink path: nbd_genl_connect calls nbd_add_socket before
>     nbd_start_device, so no I/O can happened when invoking nbd_add_socket=
,
>     nbd_genl_reconfigure cannot too since it won't call nbd_add_socket
>
>   - ioctl path: NBD_SET_SOCK cannot be called after NBD_DO_IT with
>     the previous commit, so capability of nbd will keep 0 while
>     invoking NBD_SET_SOCK
>
> Removing the freeze in nbd_add_socket to speed up nbd device startup.

Check nbd_open(), the pid is not checked there, which means the nbd device
can be opened after add_disk() succeed. Normally read/write IO will not pas=
s
bio_check_eod() checking, however, there can be special zero sized bio that
might still be issued to nbd device. So I think there should be a pid check=
ing
in nbd_open() for this patch, and I'm not aware of any special IO mush be h=
andled
before nbd_start_device(). Otherwise, the freeze is still necessary since
nbd_handle_cmd() will deference config->socks[] directly.

>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>   drivers/block/nbd.c | 9 ---------
>   1 file changed, 9 deletions(-)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index a15553ab4b97..0755b7046ed4 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1272,7 +1272,6 @@ static int nbd_add_socket(struct nbd_device *nbd, u=
nsigned long arg,
>   	struct socket *sock;
>   	struct nbd_sock **socks;
>   	struct nbd_sock *nsock;
> -	unsigned int memflags;
>   	int err;
>  =20
>   	/* Arg will be cast to int, check it to avoid overflow */
> @@ -1283,12 +1282,6 @@ static int nbd_add_socket(struct nbd_device *nbd, =
unsigned long arg,
>   		return err;
>   	nbd_reclassify_socket(sock);
>  =20
> -	/*
> -	 * We need to make sure we don't get any errant requests while we're
> -	 * reallocating the ->socks array.
> -	 */
> -	memflags =3D blk_mq_freeze_queue(nbd->disk->queue);
> -
>   	if (!netlink && !nbd->task_setup &&
>   	    !test_bit(NBD_RT_BOUND, &config->runtime_flags))
>   		nbd->task_setup =3D current;
> @@ -1335,12 +1328,10 @@ static int nbd_add_socket(struct nbd_device *nbd,=
 unsigned long arg,
>   	INIT_WORK(&nsock->work, nbd_pending_cmd_work);
>   	socks[config->num_connections++] =3D nsock;
>   	atomic_inc(&config->live_connections);
> -	blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
>  =20
>   	return 0;
>  =20
>   put_socket:
> -	blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
>   	sockfd_put(sock);
>   	return err;
>   }

--=20
Thanks,
Kuai
