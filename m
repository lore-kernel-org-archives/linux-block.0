Received: from va-2-52.ptr.blmpb.com (va-2-52.ptr.blmpb.com [209.127.231.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E615A1DA57
	for <linux-block@vger.kernel.org>; Sun,  2 Aug 2026 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785673335; cv=none; b=pO+TeL3zeaOvS3iP647sahMHsQS5xdR+5T9czBlgoQ6pPmLNFhQ70m6iveBkS13oiW796Gvd+4PS9SX9Lgj2Eo8x3pJYsv6p6bwhxsLsu+Ub9ITAyVfuYB/n2w/KT3On8QEYVsEwNYp+vZfxF3nYIVVwY7KFTXoBCVUwMhKwmiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785673335; c=relaxed/simple;
	bh=tZEwStte6TMDKO1O9CXR5Ct5+++61EJuuXPE1dnAeVo=;
	h=Date:Content-Type:In-Reply-To:References:Mime-Version:To:Cc:From:
	 Message-Id:Subject; b=JryiXddvIlf5MFiunLN/m6qovMgggWDl9EBUmGYnpUqWpsSiR/7eJXd+JEht6Erddj/mf4WMgr2zRpZbj3HzZ0TfLDajploVYUazAw5C7LYJApQ8G6JiDFfO063C1LYMTHinaO8TYkY0c0LfGTd/PsGfPjw0gf5oDox2ZVu+BIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=d8BOeP69; arc=none smtp.client-ip=209.127.231.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="d8BOeP69"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1785673321;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=XxDq7k0qAy9gawl4siERJjXmNNXMmFIO2q3gkEN82UU=;
 b=d8BOeP69NY43Gu0hej8mgxPvMpwyBPlpuWxYRQO8Nacw/gnKBbzJ8Pdbm2zgAuSAsg3vCC
 AY1N1E5SCfNjKi562Ekqji2T2RVVx23I0+ylEPzBGn3hbtGVkWhlxwADL9im1rdjkTJumD
 Dg4VR2Qq9Bi5Pn5w9TFOLQKq4dyA52fgdFEyp7U6TIPTBY7III2vyUofXJa2OL5ePmIwsX
 D5xzHG7+moxal5qZayMFPpkKutJt+qPt1K/yBk9bEt7oANo1+7ZDqQL8YlpZfGG0yoI59B
 UtlvFLMmxjea85J5WB+lNqejzLAgj4Od+dYbLC0tr0YkQCZFzXwErNx8XwEVfQ==
X-Lms-Return-Path: <lba+26a6f3668+28746c+vger.kernel.org+yukuai@fygo.io>
User-Agent: Mozilla Thunderbird
X-Original-From: yu kuai <yukuai@fygo.io>
Date: Sun, 2 Aug 2026 20:21:55 +0800
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20260730082046.3459239-9-yangerkun@huawei.com>
References: <20260730082046.3459239-1-yangerkun@huawei.com> <20260730082046.3459239-9-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>, 
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
From: "yu kuai" <yukuai@fygo.io>
Message-Id: <94c6ad4a-af3d-4a85-bc02-6cf8bcee10ce@fygo.io>
Reply-To: yukuai@fygo.io
Subject: Re: [PATCH v5 8/8] nbd: add nr_hw_queues module parameter for pre-created devices
Received: from [192.168.1.104] ([39.182.0.181]) by smtp.larksuite.com with ESMTPS; Sun, 02 Aug 2026 12:21:59 +0000

Hi,

=E5=9C=A8 2026/7/30 16:20, Yang Erkun =E5=86=99=E9=81=93:
> The function blk_mq_update_nr_hw_queues in nbd_start_device may causes a
> queue freeze. The previous commit addressed this issue for newly created
> nbd device via setting the expected nr_hw_queues in nbd_dev_add.
> However, when reusing an old inactive nbd device, the queue freeze can
> still occur when old nbd->tag_set->nr_hw_queues not match the new socket
> connection count. Inactive nbd devices can originate from two sources:
> loading the nbd module with nbds_max, which sets the default nr_hw_queues
> to 1, and the netlink method, which sets nr_hw_queues according to the
> expected number of socket connections. For the first case, we can add a
> module parameter to allow changing the default nr_hw_queues. This way,
> users who know their expected number of connections can prevent queue
> freezes on pre-created devices via nbds_max.
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
>   drivers/block/nbd.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 6369a409e10c..2194c7d7b2ea 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -166,6 +166,7 @@ static struct dentry *nbd_dbg_dir;
>  =20
>   static unsigned int nbds_max =3D 16;
>   static int max_part =3D 16;
> +static int nr_hw_queues =3D 1;
>   static int part_shift;
>  =20
>   static int nbd_dev_dbg_init(struct nbd_device *nbd);
> @@ -2740,8 +2741,10 @@ static int __init nbd_init(void)
>   	}
>   	nbd_dbg_init();
>  =20
> +	if (nr_hw_queues < 1)
> +		nr_hw_queues =3D 1;
>   	for (i =3D 0; i < nbds_max; i++)
> -		nbd_dev_add(i, 1, 1);
> +		nbd_dev_add(i, 1, nr_hw_queues);

I still feel the module param name nr_hw_queues really confusing. How about=
 rename it like
pre_defined_connections? And add comments here that user should config the =
exact number of
connections to avoid queue freeze from nbd_start_device().

>   	return 0;
>   }
>  =20
> @@ -2802,3 +2805,6 @@ module_param(nbds_max, int, 0444);
>   MODULE_PARM_DESC(nbds_max, "number of network block devices to initiali=
ze (default: 16)");
>   module_param(max_part, int, 0444);
>   MODULE_PARM_DESC(max_part, "number of partitions per device (default: 1=
6)");
> +module_param(nr_hw_queues, int, 0444);
> +MODULE_PARM_DESC(nr_hw_queues,
> +"number of hardware queues for devices pre-created at module load (defau=
lt: 1). ");

--=20
Thanks,
Kuai
