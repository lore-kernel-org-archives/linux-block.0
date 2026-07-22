Received: from va-2-46.ptr.blmpb.com (va-2-46.ptr.blmpb.com [209.127.231.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E96F44AB87
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784689410; cv=none; b=CJN3Z6bTyjPseYJhJuGNTJ9C5i2NG/UOXk0xg+qAtf289qEXf9k9jGeb7T+Wc0ienB5R+9A4Y2FoTUhmmVSEw4ZwRZmMvGffMKFmB7SEj3jgtO86YcvtPDkK1wddNiBT5IGtubNqNxKyXm3bLZk2TwGKoxm9VjXw+4qYl2k3UAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784689410; c=relaxed/simple;
	bh=w3AQ21A9l+v+9ebPzx6/+FdGCnj1pakoel9Oxu0pBh0=;
	h=Cc:Date:Message-Id:From:To:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oCK4t3SkgiZCxDiOMXXJwguflFy9SqGDsQB3ZOJO/Pdl+pnaQz/ol5Yyv5/6lJ5eQLUH5GVgh3Q39wjIg2LM4vq0VhwWPQu/FTn9WGcmqzafvXSATISB39mw9dZZX7Worh1hK6dLNH27sjR3fY8+HLZzX6yeQKSp5Cj7eGAdesM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=N7MNwUnD; arc=none smtp.client-ip=209.127.231.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="N7MNwUnD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1784689397;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=YXQacFLTarlmOQFPQLbH4cRcHlMu6SDwvRgPfx9wcIM=;
 b=N7MNwUnDt/e0Rm+lTnpgRFh2gDhiTVkSAxDbpjOIHWEHdmGsRorWkjn76cIhUugseTZNCH
 rc4+VMU5hyK4Mys/zum0uAR3nEC+fhrJibE2RYao7oYAYDY07mqX0E0xQtFlVM+ARj7c3R
 HdKSuoncUYQY8lU/DHpODzYV9Sk6Q3odTrm0SVbQBDg9rwmlR4TSV+MPawPJ7T5bVKdhQD
 d2/KPjF+85S35Q+pVX14i7dH2VXVv/AIn1UMM99eAmm+YzVOSEpWkFNsnKoPTHFxVHqaZF
 fG6xU0xnofHW4OUpNALEK1BHzOkQM7dhSztFTlZ/ruatb6zWDHvfzC4pUeJ8jw==
Reply-To: yukuai@fygo.io
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
Date: Wed, 22 Jul 2026 11:03:12 +0800
Message-Id: <9210a679-21f9-4b57-9220-6a15955c5bcf@fygo.io>
Received: from [192.168.1.104] ([39.182.0.167]) by smtp.larksuite.com with ESMTPS; Wed, 22 Jul 2026 03:03:15 +0000
Content-Transfer-Encoding: quoted-printable
From: "yu kuai" <yukuai@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
X-Lms-Return-Path: <lba+26a6032f4+0477fd+vger.kernel.org+yukuai@fygo.io>
In-Reply-To: <20260713065644.1637594-3-yangerkun@huawei.com>
References: <20260713065644.1637594-1-yangerkun@huawei.com> <20260713065644.1637594-3-yangerkun@huawei.com>
Subject: Re: [PATCH v3 2/6] nbd: disallow NBD_SET_SOCK on an active device
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird

Hi,

=E5=9C=A8 2026/7/13 14:56, Yang Erkun =E5=86=99=E9=81=93:
> We cannot add a socket to an already running nbd device, the reconfigure
> for netlink can only active dead socket. But for ioctl path, we can call
> NBD_SET_SOCK after NBD_DO_IT, reject this using nbd->pid which has been
> setted when NBD_DO_IT. Besides, it is the root cause for commit
> b98e762e3d71 ("nbd: freeze the queue while we're adding connections").
>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>   drivers/block/nbd.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index b1a5acd57426..a15553ab4b97 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1302,6 +1302,13 @@ static int nbd_add_socket(struct nbd_device *nbd, =
unsigned long arg,
>   		goto put_socket;
>   	}
>  =20
> +	if (nbd->pid) {
> +		dev_err(disk_to_dev(nbd->disk),
> +			"Cannot add socket to a running device\n");
> +		err =3D -EBUSY;
> +		goto put_socket;
> +	}

I think the checking if fine, but I'd like to add the checking before nbd_g=
et_socket() and
return -EBUSY directly.

> +
>   	nsock =3D kzalloc_obj(*nsock);
>   	if (!nsock) {
>   		err =3D -ENOMEM;

--=20
Thanks,
Kuai
