Received: from va-2-51.ptr.blmpb.com (va-2-51.ptr.blmpb.com [209.127.231.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC763AE712
	for <linux-block@vger.kernel.org>; Sun,  2 Aug 2026 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785671116; cv=none; b=M3hUKI3UhcyETK+hpybLjNx61nMdX4JQvniFAkfSzTEVt501fMUInaY+LHl6vyHVXPAydUkP7QyIMMiYyaO5iduC5QAbI1JXeX94dm1+r/CBiFvU+fUFHrjta5/hSIEobiiLnJsrK5wHiOYtXm4F6Dtv6S5gTg2EyVmvXf2h4TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785671116; c=relaxed/simple;
	bh=36vievNjZ8GtLIxqOCucLWvF1Vi3VnXYxsq60rHBAM8=;
	h=Mime-Version:Subject:References:To:Cc:From:Content-Type:
	 In-Reply-To:Date:Message-Id; b=uFDO7KJ62Zvnr0wmjW1z536DkyF2eoh47z8h9kxwYZYDV0HrjhyqKX5p7bRJnzRZ1wYtWXmIkOUI9+e+q8apbr1go3+IBc6zfxr3QTIjOh5A8x103SzaBhrgscVQFwo4QBVIfdO8fsXnvdCwaUcC0iq4U24WqRDA0QgumIJdu/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=TlfeCN05; arc=none smtp.client-ip=209.127.231.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="TlfeCN05"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1785671107;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=uKZn2mPcYWu8Kef9zrdD2C1ss+TXfPgOpNBBCqk7y7o=;
 b=TlfeCN05uWMu4cT3yB/HD3P3d94jEMLSb6SdlYYJakLKPJUMqhHKLwrIqt3yRmoNp0zjdq
 Btmf8ScS547AcSYUUJnDX97gs+dsvvyAhi01OgqWftvVST3XOonsAAG+zXLeaRMz6ol4AF
 11Knto8iLuAF81QYHU/8nkJA5FcJNo1A+Z9PImdaHIhbVYasOlY+xdsj5gm0wAcHPV6YXz
 HBXO74WUAjX/J3t4oJaT7E5Bx6ljEQ4EFbxrheLthB3RIgbOtTNaW/oSCMfhi/od6e5kd6
 Gwz38Ko26FUal+A8F5mitAcFW4i6+Vl8xVu2L2vvHdwe/YLtUP7cPfY4XBK+tg==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] nbd: skip queue freeze when setting size at device startup
References: <20260730082046.3459239-1-yangerkun@huawei.com> <20260730082046.3459239-6-yangerkun@huawei.com>
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>, 
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
From: "yu kuai" <yukuai@fygo.io>
X-Lms-Return-Path: <lba+26a6f2dc2+03270b+vger.kernel.org+yukuai@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>
Received: from [192.168.1.104] ([39.182.0.181]) by smtp.larksuite.com with ESMTPS; Sun, 02 Aug 2026 11:45:06 +0000
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20260730082046.3459239-6-yangerkun@huawei.com>
Content-Transfer-Encoding: quoted-printable
Reply-To: yukuai@fygo.io
Date: Sun, 2 Aug 2026 19:45:01 +0800
Message-Id: <75ff5ace-a4bb-4960-a992-dddb235fd2ca@fygo.io>

Hi,

=E5=9C=A8 2026/7/30 16:20, Yang Erkun =E5=86=99=E9=81=93:
> Commit 242a49e5c878 ("nbd: freeze the queue for queue limits updates")
> added the freeze to keep in-flight commands from seeing torn
> queue_limits.  But at startup the capacity is still 0
> (invalidate_disk cleared it) and the write cache is off (the previous
> patch cleared it on disconnect, and nbd_set_size sets it back only after
> the commit), so submit_bio_noacct() rejects any bio before it reaches
> the driver and no I/O is in flight.  Drop the freeze there.
>
> Split nbd_set_size() with a bool: nbd_start_device() passes false, the
> runtime resize/reconfigure paths (ioctls and nbd_genl_size_set) keep
> passing true.  nbd->pid is still 0 when nbd_genl_connect calls
> nbd_genl_size_set, so the early return in nbd_set_size keeps that path
> from applying limits before startup; the true covers the reconnect path
> on a live device.
>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>   drivers/block/nbd.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)

Can you just checking if size is 0 and write cache is disabled first, and j=
ust
skip freeze in this case. I think this is simpler and straightforward, as y=
ou
don't have to modify all the callers.

>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index ce25c254e5fb..3b7363b11d0b 100644
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
> @@ -1568,7 +1575,7 @@ static int nbd_start_device(struct nbd_device *nbd)
>   		args->index =3D i;
>   		queue_work(nbd->recv_workq, &args->work);
>   	}
> -	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config));
> +	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config), false);
>   }
>  =20
>   static int nbd_start_device_ioctl(struct nbd_device *nbd)
> @@ -1636,13 +1643,13 @@ static int __nbd_ioctl(struct block_device *bdev,=
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
> @@ -2097,7 +2104,7 @@ static int nbd_genl_size_set(struct genl_info *info=
, struct nbd_device *nbd)
>   		bsize =3D nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
>  =20
>   	if (bytes !=3D config->bytesize || bsize !=3D nbd_blksize(config))
> -		return nbd_set_size(nbd, bytes, bsize);
> +		return nbd_set_size(nbd, bytes, bsize, true);
>   	return 0;
>   }
>  =20

--=20
Thanks,
Kuai
