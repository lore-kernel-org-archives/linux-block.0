Received: from va-2-45.ptr.blmpb.com (va-2-45.ptr.blmpb.com [209.127.231.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B2A42B73F
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008390; cv=none; b=CJhW3as87cseKBSvgaskCinqHClyxEjURObAY67oNWUCUdZ+PDc4wl5PPEJzF0SNVzs+BsIrgzd8OcfIL458VBZfIA5pwMyuh2byT7yFWDRi/7ts0jzck6KX2Cf+sR3shs/GLJ20HhmPv3oVptIG9o4XeNNwLIoZre0tfDhT+ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008390; c=relaxed/simple;
	bh=DXLdrPvGF3vaOeWnsc3TTzDLOy2G1e+dIo40cRAFjoo=;
	h=From:Message-Id:Mime-Version:Cc:Date:To:References:In-Reply-To:
	 Subject:Content-Type; b=ezoVPKMScxPVKpPpVOFfq8sRN0HPIUvb8t6T+Li94E3CzQapDJUlNkQw4obIFOIkhlwPN/NvBHLX6LTafzQL9YQsnVSeiXJL5HDm6FUMR0p1GFLSFslqIcaNIyCI0OYp8JGXSA2SlFr722QGpIgIwyedpfx9Rkzu/99wpNDKJKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=c8u9fUY4; arc=none smtp.client-ip=209.127.231.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="c8u9fUY4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1786008380;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=+FzkfknCu1KhUUf7iiomqJBMijrdNVG9Uw9CHQcYxEw=;
 b=c8u9fUY4U9bxew/mMiyPNOQ5j+3qnrLZypQCf33i85m+bGmKcYIqWNEv3OY+gVW2CeQONe
 2OSUg4Kk4sFhc0yUo34PpLd1inlJuL+5fXVMCgwIzp908pCptgSeX+Zkx1MX+PBT5vBYAL
 mr6LgDsNU0jarM9HhriK+LRWsEmFUVDZ4JrOrfzYYtHz5MvJl4mLfwFitzUg7I6va7ywvn
 ieuKPYPkO6wIc7Z3OmGdYhl2NJqbHWTpYrlIP1S+5xTWmAtQKcqv5agqbYHKZ/mffmPHOT
 z15GnEQfqWSIKEfcYaJmVNxs96AJvtv3LCytVYXVxPi7n7qiRTjNZLaaAL2jXw==
X-Lms-Return-Path: <lba+26a74533b+c7f53f+vger.kernel.org+yukuai@fygo.io>
User-Agent: Mozilla Thunderbird
Received: from [192.168.1.104] ([39.182.0.170]) by smtp.larksuite.com with ESMTPS; Thu, 06 Aug 2026 09:26:18 +0000
From: "yu kuai" <yukuai@fygo.io>
Message-Id: <22a4c13f-517a-42c3-9079-15dd20940424@fygo.io>
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
Date: Thu, 6 Aug 2026 17:26:12 +0800
X-Original-From: yu kuai <yukuai@fygo.io>
Content-Transfer-Encoding: quoted-printable
Reply-To: yukuai@fygo.io
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
References: <20260805122930.57647-1-yangerkun@huawei.com> <20260805122930.57647-9-yangerkun@huawei.com>
In-Reply-To: <20260805122930.57647-9-yangerkun@huawei.com>
Subject: Re: [PATCH v8 8/8] nbd: add pre_defined_connections module parameter for pre-created devices
Content-Type: text/plain; charset=UTF-8

Hi,

=E5=9C=A8 2026/8/5 20:29, Yang Erkun =E5=86=99=E9=81=93:
> blk_mq_update_nr_hw_queues() in nbd_start_device() may cause a queue
> freeze.  The previous commit addressed this for newly created nbd
> devices by setting the expected nr_hw_queues in nbd_dev_add().  However,
> when reusing an old inactive nbd device, the queue freeze can still
> occur if the old nbd->tag_set->nr_hw_queues does not match the new
> socket connection count.  Inactive nbd devices can originate from two
> sources: loading the nbd module with nbds_max, which sets the default
> nr_hw_queues to 1, and the netlink method, which sets nr_hw_queues
> according to the expected number of socket connections.  For the first
> case, add a module parameter so the default nr_hw_queues can be
> changed.  Users who know their expected number of connections can then
> prevent queue freezes on pre-created devices via nbds_max.
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
>   drivers/block/nbd.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 6c4aa19ea11a..ffce519bf008 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -166,6 +166,7 @@ static struct dentry *nbd_dbg_dir;
>  =20
>   static unsigned int nbds_max =3D 16;
>   static int max_part =3D 16;
> +static int pre_defined_connections =3D 1;
>   static int part_shift;
>  =20
>   static int nbd_dev_dbg_init(struct nbd_device *nbd);
> @@ -2712,6 +2713,12 @@ static int __init nbd_init(void)
>   	if (nbds_max > 1UL << (MINORBITS - part_shift))
>   		return -EINVAL;
>  =20
> +	/* An excessively large value will be adjusted in blk_mq_alloc_tag_set =
*/
> +	if (pre_defined_connections < 1) {
> +		pr_err("pre_defined_connections must be >=3D 1\n");

It's also better to add NR_CPUS checking for upper bound, because the nr_hw=
_queues is passed
directly to __blk_mq_realloc_hw_ctxs() for memory allocation.

> +		return -EINVAL;
> +	}
> +
>   	if (register_blkdev(NBD_MAJOR, "nbd"))
>   		return -EIO;
>  =20
> @@ -2728,8 +2735,12 @@ static int __init nbd_init(void)
>   	}
>   	nbd_dbg_init();
>  =20
> +	/*
> +	 * Set to the intended connection count so nbd_start_device() can skip
> +	 * the queue-freezing blk_mq_update_nr_hw_queues() call.
> +	 */
>   	for (i =3D 0; i < nbds_max; i++)
> -		nbd_dev_add(i, 1, 1);
> +		nbd_dev_add(i, 1, pre_defined_connections);
>   	return 0;
>   }
>  =20
> @@ -2790,3 +2801,6 @@ module_param(nbds_max, int, 0444);
>   MODULE_PARM_DESC(nbds_max, "number of network block devices to initiali=
ze (default: 16)");
>   module_param(max_part, int, 0444);
>   MODULE_PARM_DESC(max_part, "number of partitions per device (default: 1=
6)");
> +module_param(pre_defined_connections, int, 0444);
> +MODULE_PARM_DESC(pre_defined_connections,
> +"number of connections for devices pre-created at module load (default: =
1)");

--=20
Thanks,
Kuai
