Received: from va-2-19.ptr.blmpb.com (va-2-19.ptr.blmpb.com [209.127.231.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9DF1DEFE8
	for <linux-block@vger.kernel.org>; Sun,  2 Aug 2026 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785671506; cv=none; b=fQfWg8fQShKEXRKYXlbMA80/smDLMWYZKEMXU1YMtjr3cIWb6OgoTLXLEdWrmGIG1pcsFgr/VrRdTis0WX1qaSDFNtGeQpCkDM8kCgLcemng6H6QEheFuDdBsux5KsCIU6aKot7tZWGBO8/t7nWAefJrLLu7vEXRqOuAapV+Y44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785671506; c=relaxed/simple;
	bh=8qGw6nGGKyFUQ1om5+jLljQ7y4AWiTxXjtkqPziX0X4=;
	h=From:References:In-Reply-To:To:Subject:Date:Message-Id:
	 Mime-Version:Cc:Content-Type; b=qNgxQagy6JbHhqZzHlmBQ9RPAMnZ2ZkgJdJL2MT2SZFxNLUIZ6Mq9q2nzsmwl9RmtVwoIjPZtQZlcItlot8envcR/fnvdGC3rG5K3iV1vPQnbm95E4Bc5JC5uo2n7aR+JnPlVK3hZZGBGz7iTSAiLkaXnkXZ2ZJFm3oj9CIOyD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=gB3c2zp8; arc=none smtp.client-ip=209.127.231.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="gB3c2zp8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1785671491;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=6VT+fYfV7kRpeCxfmPL9V+ZjzFE143KXWyy1O4dkvOk=;
 b=gB3c2zp85/TkiEkoEW08xqzai+wYcvBk/VrDcLykMSb5ufDNwFjEpKGtL4Zp12rzFcwfZC
 0NQO6bHOFgdvKFiDrf+dFFb0tzFUKTIXS6I/NZjMtb+ZoIjpYMXGh2OBc5S8uDLlq6TwdM
 +r0414TLZDBhQMCZsvOAdjhXPsOaUiqt1/HVX+t9jv1tJ+drE+NEx9I7D/xPxkyfttsx3b
 GrG8FfgqFuU5rrUawMlXJpCphRC2izxDB26BNMWTxEuZ6o5LZEjNxrEaDPuNH2oj9Qstoo
 Rw78D1kncHFSCuLTP81m9j1+8hKvzz073pe4cTSzZub7/cARm2l+Gm58/rdYeA==
From: "yu kuai" <yukuai@fygo.io>
User-Agent: Mozilla Thunderbird
Received: from [192.168.1.104] ([39.182.0.181]) by smtp.larksuite.com with ESMTPS; Sun, 02 Aug 2026 11:51:29 +0000
References: <20260730082046.3459239-1-yangerkun@huawei.com> <20260730082046.3459239-4-yangerkun@huawei.com>
In-Reply-To: <20260730082046.3459239-4-yangerkun@huawei.com>
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Content-Transfer-Encoding: quoted-printable
Reply-To: yukuai@fygo.io
Subject: Re: [PATCH v5 3/8] nbd: reset write cache on disconnect
Date: Sun, 2 Aug 2026 19:51:25 +0800
Message-Id: <9525c07b-f9ee-4a06-9857-0b6c9942ffaf@fygo.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>, 
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
X-Lms-Return-Path: <lba+26a6f2f42+8c8d75+vger.kernel.org+yukuai@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>
Content-Type: text/plain; charset=UTF-8

Hi,

=E5=9C=A8 2026/7/30 16:20, Yang Erkun =E5=86=99=E9=81=93:
> An inactive nbd device may refuse any I/O operations. The nbd_config_put
> function calls invalidate_disk, which sets the device capacity to zero
> to reject all read and write I/O. For zero-sector flush I/O requests
> from blkdev_issue_flush, if the write cache is disabled, the zero-sector
> flush I/O immediately returns 0 in submit_bio_noacct. However, since
> nbd_config_put does not clear the write cache state, an inactive nbd
> device might still have the write cache enabled. In this situation,
> zero-sector flush I/O will return -EIO because there is no active socket.
> Although this does not cause any bugs, resetting the write cache state
> would make the behavior consistent.

I don't think this make sense, at this point nbd->config_refs is 0, which m=
eans
there is no opener for the device, so how can there still be outstanding re=
ad/write
or flush IO?

>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>   drivers/block/nbd.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 7ec85f94f742..da4b48ef3c79 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1469,8 +1469,13 @@ static void nbd_config_put(struct nbd_device *nbd)
>   	if (refcount_dec_and_mutex_lock(&nbd->config_refs,
>   					&nbd->config_lock)) {
>   		struct nbd_config *config =3D nbd->config;
> +		struct queue_limits lim;
>   		nbd_dev_dbg_close(nbd);
>   		invalidate_disk(nbd->disk);
> +		/* reset write cache */
> +		lim =3D queue_limits_start_update(nbd->disk->queue);
> +		lim.features &=3D ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA);
> +		queue_limits_commit_update(nbd->disk->queue, &lim);
>   		if (nbd->config->bytesize)
>   			kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
>   		if (test_and_clear_bit(NBD_RT_HAS_PID_FILE,

--=20
Thanks,
Kuai
