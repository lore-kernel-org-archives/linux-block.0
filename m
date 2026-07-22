Received: from va-2-58.ptr.blmpb.com (va-2-58.ptr.blmpb.com [209.127.231.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9683CA4A8
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 03:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784692158; cv=none; b=MAuMpZ3kpGnU3RturpY5erdJOfZQr8YmpJfzDYCRjyQ408wNogkTRuoDr0+3LCZFlnCcz2QzgIPf3eSHsNUWe9+kOm9QatYtmqaMDVjEvWFVFuOwPq6Jgj6vY8EEbKylCJLasJfhVth4+m681KgNpa9cHQt686+Q9c9h6bGzZQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784692158; c=relaxed/simple;
	bh=rYN18PKnmXLNNzwxwaROTGNkxcxX8cruIZXB5c6yEmo=;
	h=From:Content-Type:Cc:Date:References:In-Reply-To:To:Subject:
	 Mime-Version:Message-Id; b=t9HOpt/Fn3OJDB3lvFACcFiDbAp6pF2/H3HpKd+NByJE0G6EH6w8RTbCZmw/bnyxOgvKfRnQaU0nj5vOmzXnCvv9q6kYlSL26WF53LOuUsSJq2ITVHmU1FtpRZPVeEC9Cltn6EUGwAfJedzLYviojBo5hGT4nThoR74CifzzKuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=d54LVfdk; arc=none smtp.client-ip=209.127.231.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="d54LVfdk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1784692146;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=fZ0prG7MEE6934Jy0Nj7FHftMtpZFv/eY+mg5K+I7MU=;
 b=d54LVfdkK9Hv8K26TuyXotU9gFv/2vlnNIsBbEy08XRhoYRF5XnTQrOO9QUWzAclWlJX6e
 qkkU2DswCbrMVZ3EdyZjXXp4uE2g+zNQ9f7OI0UeUuocwwLX7y/xFvBa5af5IpyRTvOxgV
 4UCAKtiY9zyKoSxHlNop3irOn35gJH4qCZh8+k0pN21afsfCflNcNIl2heBCrznutBtH+6
 /KUJVJlCOSnbdgj3gMviELGz8b3W8kRGYu5odnubx5/+dxENYcRh+BGFmRmRu2eaiLtazb
 zRFONrBy2ZZ2yp/Adz6m5oNGlf35Ypbb2y58s2vBgeMnRVYzMm3VsWZuR+a3jA==
User-Agent: Mozilla Thunderbird
From: "yu kuai" <yukuai@fygo.io>
Content-Transfer-Encoding: quoted-printable
X-Original-From: yu kuai <yukuai@fygo.io>
Content-Type: text/plain; charset=UTF-8
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
X-Lms-Return-Path: <lba+26a603db1+303519+vger.kernel.org+yukuai@fygo.io>
Date: Wed, 22 Jul 2026 11:49:00 +0800
References: <20260713065644.1637594-1-yangerkun@huawei.com> <20260713065644.1637594-6-yangerkun@huawei.com>
In-Reply-To: <20260713065644.1637594-6-yangerkun@huawei.com>
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Subject: Re: [PATCH v3 5/6] nbd: skip queue freeze when setting size at device startup
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.167]) by smtp.larksuite.com with ESMTPS; Wed, 22 Jul 2026 03:49:04 +0000
Reply-To: yukuai@fygo.io
Message-Id: <7cc2fb8d-32b4-4fc9-a440-e125ba290374@fygo.io>

Hi,

=E5=9C=A8 2026/7/13 14:56, Yang Erkun =E5=86=99=E9=81=93:
> Commit 242a49e5c878 ("nbd: freeze the queue for queue limits updates")
> introduce queue freeze/unfreeze in nbd_set_size to avoid inflight
> commands see this inconsistent limits. However, this cannot be happened
> when device setup since the capacity is still 0.

Same reason above, 0 capacity disk will only reject non-zero sized bio from
bio_check_eod().

>
> time nbd-client --name myexport --connections 96 127.0.0.1 1234
>
> Before this patchset:
> real    0m2.195s
> user    0m0.005s
> sys     0m0.022s
>
> After this patchset:
> real    0m0.090s
> user    0m0.004s
> sys     0m0.018s
>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>   drivers/block/nbd.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 400f638e832e..2c7b09c70da2 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -331,7 +331,8 @@ static void nbd_mark_nsock_dead(struct nbd_device *nb=
d, struct nbd_sock *nsock,
>   	nsock->sent =3D 0;
>   }
>  =20
> -static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t =
blksize)
> +static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t =
blksize,
> +			bool freeze)
>   {
>   	struct queue_limits lim;
>   	int error;
> @@ -371,7 +372,13 @@ static int nbd_set_size(struct nbd_device *nbd, loff=
_t bytesize, loff_t blksize)
>  =20
>   	lim.logical_block_size =3D blksize;
>   	lim.physical_block_size =3D blksize;
> -	error =3D queue_limits_commit_update_frozen(nbd->disk->queue, &lim);
> +
> +	if (freeze)
> +		error =3D queue_limits_commit_update_frozen(nbd->disk->queue,
> +				&lim);
> +	else
> +		error =3D queue_limits_commit_update(nbd->disk->queue, &lim);
> +
>   	if (error)
>   		return error;
>  =20
> @@ -1563,7 +1570,7 @@ static int nbd_start_device(struct nbd_device *nbd)
>   		args->index =3D i;
>   		queue_work(nbd->recv_workq, &args->work);
>   	}
> -	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config));
> +	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config), false);
>   }
>  =20
>   static int nbd_start_device_ioctl(struct nbd_device *nbd)
> @@ -1631,13 +1638,13 @@ static int __nbd_ioctl(struct block_device *bdev,=
 struct nbd_device *nbd,
>   	case NBD_SET_SOCK:
>   		return nbd_add_socket(nbd, arg, false);
>   	case NBD_SET_BLKSIZE:
> -		return nbd_set_size(nbd, config->bytesize, arg);
> +		return nbd_set_size(nbd, config->bytesize, arg, true);
>   	case NBD_SET_SIZE:
> -		return nbd_set_size(nbd, arg, nbd_blksize(config));
> +		return nbd_set_size(nbd, arg, nbd_blksize(config), true);
>   	case NBD_SET_SIZE_BLOCKS:
>   		if (check_shl_overflow(arg, config->blksize_bits, &bytesize))
>   			return -EINVAL;
> -		return nbd_set_size(nbd, bytesize, nbd_blksize(config));
> +		return nbd_set_size(nbd, bytesize, nbd_blksize(config), true);
>   	case NBD_SET_TIMEOUT:
>   		nbd_set_cmd_timeout(nbd, arg);
>   		return 0;
> @@ -2122,7 +2129,7 @@ static int nbd_genl_size_set(struct genl_info *info=
, struct nbd_device *nbd)
>   		bsize =3D nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
>  =20
>   	if (bytes !=3D config->bytesize || bsize !=3D nbd_blksize(config))
> -		return nbd_set_size(nbd, bytes, bsize);
> +		return nbd_set_size(nbd, bytes, bsize, true);

This is still called from nbd_genl_connect().

Will it be much simpler to just check pid in nbd_set_size()?

>   	return 0;
>   }
>  =20

--=20
Thanks,
Kuai
