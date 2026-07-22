Received: from va-2-46.ptr.blmpb.com (va-2-46.ptr.blmpb.com [209.127.231.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4319C2F3C37
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784702143; cv=none; b=kMPQFicFgkwpnQ/k+SF0owVzPSUh4da55wokdPCaIe7Py8qtEd9mPaQR1nLeGuL9qxGmyLSUd/RNTBRb35mUfHt2b6nHGRgWhvuD4W/JcIItAc01KUoXbmNYz1J4ZG8riiQVXNC/vJkNcqF4eFlL03BBp8d57lbEXHLUMBInr2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784702143; c=relaxed/simple;
	bh=OVqg11dRVv/cGt5qWA9d6SB/btrYFO4g0//t0nRzYSo=;
	h=To:Date:Cc:Subject:Content-Type:References:Message-Id:In-Reply-To:
	 From:Mime-Version; b=bxJTSgF7hQrItSqig3fR2be1Ysr66KOSWnEVDd/zhpBS41DpMol56BjcgQ7Iw1iO0wMCmz1RyDVU7N6HtmUWosGZ/LObQqq4idTQOx9aNgl3jEYHFFki5b9vCAXTIrlG2oS5RewWXC/q/dHzD/CJrjOro/RWBQT6+d/83Tz8Dns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=NjrrjeqK; arc=none smtp.client-ip=209.127.231.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="NjrrjeqK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1784702133;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=IS+vLUAqF19uHa9r4MFEDZEo9090sfLlD8hvwjzZzwA=;
 b=NjrrjeqKlu+0DSluIurFU9EPCR+chPGQq/PjOx4Fxif19+Q8+NfZaqZtNRhW42PyH0lZUS
 P1yq/nCKmdnETdbkyhRtiO5xy8MXQZxlumaVY0flNYmaSRNLt6HvmOFy3yvJz0W75Z9i0Y
 ug9wAH++yH1174R3ShRB+E2Uof3hUWiNk+4XzDdJWLOgU/6sjvIPAg0T9aEUSYT3xlGbwX
 t0/9ojQUr8xYCwdqeeXYe6VXUn3ojy33UZrQxJuCpDX+VD7k+ZYyJ0+4XxNesFFD/EvN0d
 3SZSYjA++v4ILmQOkZJiN/m2BzWM4SHXHS9d8ibGha3Oi74HvbFUJwxcUounwQ==
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Date: Wed, 22 Jul 2026 14:35:28 +0800
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+26a6064b5+0f5f72+vger.kernel.org+yukuai@fygo.io>
Reply-To: yukuai@fygo.io
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
Subject: Re: [PATCH v3 3/6] nbd: remove queue freeze in nbd_add_socket
Content-Type: text/plain; charset=UTF-8
References: <20260713065644.1637594-1-yangerkun@huawei.com> <20260713065644.1637594-4-yangerkun@huawei.com> <1b8b00e4-3f6f-42f1-a52a-b4d99c9f2cc3@fygo.io>
Message-Id: <5799ffec-f179-47ec-b685-1f992648aff5@fygo.io>
In-Reply-To: <1b8b00e4-3f6f-42f1-a52a-b4d99c9f2cc3@fygo.io>
Received: from [192.168.1.104] ([39.182.0.167]) by smtp.larksuite.com with ESMTPS; Wed, 22 Jul 2026 06:35:32 +0000
User-Agent: Mozilla Thunderbird
From: "yu kuai" <yukuai@fygo.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: yu kuai <yukuai@fygo.io>

Hi,

=E5=9C=A8 2026/7/22 11:17, yu kuai =E5=86=99=E9=81=93:
> Hi,
>
> =E5=9C=A8 2026/7/13 14:56, Yang Erkun =E5=86=99=E9=81=93:
>> nbd_add_socket can never run concurrently with inflight I/O:
>>
>>    - netlink path: nbd_genl_connect calls nbd_add_socket before
>>      nbd_start_device, so no I/O can happened when invoking nbd_add_sock=
et,
>>      nbd_genl_reconfigure cannot too since it won't call nbd_add_socket
>>
>>    - ioctl path: NBD_SET_SOCK cannot be called after NBD_DO_IT with
>>      the previous commit, so capability of nbd will keep 0 while
>>      invoking NBD_SET_SOCK
>>
>> Removing the freeze in nbd_add_socket to speed up nbd device startup.
> Check nbd_open(), the pid is not checked there, which means the nbd devic=
e
> can be opened after add_disk() succeed. Normally read/write IO will not p=
ass
> bio_check_eod() checking, however, there can be special zero sized bio th=
at
> might still be issued to nbd device. So I think there should be a pid che=
cking
> in nbd_open() for this patch, and I'm not aware of any special IO mush be=
 handled
> before nbd_start_device(). Otherwise, the freeze is still necessary since
> nbd_handle_cmd() will deference config->socks[] directly.

Sorry this is a mistake, nbd_open() must succeed before pid is set, because=
 of ioctl
like NBD_SET_SOCK and NED_DO_IT :( I just forgot this simple case.

>
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>    drivers/block/nbd.c | 9 ---------
>>    1 file changed, 9 deletions(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index a15553ab4b97..0755b7046ed4 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -1272,7 +1272,6 @@ static int nbd_add_socket(struct nbd_device *nbd, =
unsigned long arg,
>>    	struct socket *sock;
>>    	struct nbd_sock **socks;
>>    	struct nbd_sock *nsock;
>> -	unsigned int memflags;
>>    	int err;
>>   =20
>>    	/* Arg will be cast to int, check it to avoid overflow */
>> @@ -1283,12 +1282,6 @@ static int nbd_add_socket(struct nbd_device *nbd,=
 unsigned long arg,
>>    		return err;
>>    	nbd_reclassify_socket(sock);
>>   =20
>> -	/*
>> -	 * We need to make sure we don't get any errant requests while we're
>> -	 * reallocating the ->socks array.
>> -	 */
>> -	memflags =3D blk_mq_freeze_queue(nbd->disk->queue);
>> -
>>    	if (!netlink && !nbd->task_setup &&
>>    	    !test_bit(NBD_RT_BOUND, &config->runtime_flags))
>>    		nbd->task_setup =3D current;
>> @@ -1335,12 +1328,10 @@ static int nbd_add_socket(struct nbd_device *nbd=
, unsigned long arg,
>>    	INIT_WORK(&nsock->work, nbd_pending_cmd_work);
>>    	socks[config->num_connections++] =3D nsock;
>>    	atomic_inc(&config->live_connections);
>> -	blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
>>   =20
>>    	return 0;
>>   =20
>>    put_socket:
>> -	blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
>>    	sockfd_put(sock);
>>    	return err;
>>    }

--=20
Thanks,
Kuai
