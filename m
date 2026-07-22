Received: from va-2-53.ptr.blmpb.com (va-2-53.ptr.blmpb.com [209.127.231.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D0239E80
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 03:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784692429; cv=none; b=Zq5Y9UcjbRDcv8Ce+1XSL8sD10MzZ/bbiAlRDkvMqcUDExofG0C5z7v2bIGXLNuxFQjE/0GUnj2+8XvROzAF3hY7z+QCLWYfKsAuitaJsBSqT5W6FczgjjqugmAmwZXBoYDDCaFjbbPDDbW2lHuOcJtC13359J90IAJzviNfwUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784692429; c=relaxed/simple;
	bh=FSBcOAKUuRXQ4vxEN/a/77zGKe/CPyp9MH/kReu0aBw=;
	h=To:Content-Type:Cc:Subject:In-Reply-To:From:Date:Message-Id:
	 Mime-Version:References; b=FdHzhhK5i3pCY8QcqQVpomwzeIHYbuSdYtXeSkYxyQsKGAlmgLm9efhsTYiQPe19AYwwxO56RJ722SKOikmnMJMOmzWIZFDIhD9v0gg+Ommoy5Y+smyH3SJi5EFv1Msl5mrj6mZlF5Gd4nHuX3zKYTJoExU8Us7IMthza1RdCsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=dxV5arTd; arc=none smtp.client-ip=209.127.231.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="dxV5arTd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1784692417;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=sBZVBtHCCN6AytQT03xKZC6Jjrd7IUeqrRnA3DixRyI=;
 b=dxV5arTdt2NrMDT+kKmcMpzLLSq5F9UU8v3HWdzY1zAspMZDdZK3YVGh7bEtnGYqYDwEvY
 pHsvrIE8oY+LL0mkXj57WU69hbjWInA8ctKyXjQPJJb/6pjNE0d/YWzEw4beCTl5BJRLTN
 KVV2Sw6hfpGlQN03JSiH3Y0vO1aOIr8LnGmXKDcMFCKNfmiK+ki455ty86QXBqJL7IjCkw
 BFaSOAVl2Ljjk7YMQ0E+bU7+NrgBRZTMsJsrfFVMPhu7J97ZdlPzJfu394yENWiF83G8iw
 ogjI4DSd3FhURyi0zse2OliH0nPRFNN6MScrzVEKtEJsLeZ1Hq04xmyvy4WWdA==
X-Lms-Return-Path: <lba+26a603ec0+e7f423+vger.kernel.org+yukuai@fygo.io>
Received: from [192.168.1.104] ([39.182.0.167]) by smtp.larksuite.com with ESMTPS; Wed, 22 Jul 2026 03:53:35 +0000
X-Original-From: yu kuai <yukuai@fygo.io>
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Reply-To: yukuai@fygo.io
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
Subject: Re: [PATCH v3 6/6] nbd: add nr_hw_queues module parameter for pre-created devices
User-Agent: Mozilla Thunderbird
In-Reply-To: <20260713065644.1637594-7-yangerkun@huawei.com>
From: "yu kuai" <yukuai@fygo.io>
Date: Wed, 22 Jul 2026 11:53:31 +0800
Message-Id: <cbcbe9e9-3700-4801-88b8-6b99f61a8936@fygo.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713065644.1637594-1-yangerkun@huawei.com> <20260713065644.1637594-7-yangerkun@huawei.com>

Hi,

=E5=9C=A8 2026/7/13 14:56, Yang Erkun =E5=86=99=E9=81=93:
> Previous commit can help remove all freeze for netlink newly created nbd
> device. But for the devices pre-created at module load(nbds_max default
> as 16), the nr_hw_queues was setting default as 1, then ioctl/netlink
> path will set the real connection count, and blk_mq_update_nr_hw_queues
> in nbd_start_device will introduce freeze.
>
> Add an nr_hw_queues module parameter so that users who know their
> expected connection count can pre-created devices with the right queue
> count to avoid this freeze too.

I'm fine with this, but this is misleading. Please also add comment to
emphasize this module parameter is just to avoid queue freeze if user confi=
gure
the exact number of socks as this new module parameter. Otherwise, the real
nr_hw_queues is still depend on the real number of user configured socks.

>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>   drivers/block/nbd.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 2c7b09c70da2..f918c9efa9b2 100644
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
> @@ -2752,8 +2753,10 @@ static int __init nbd_init(void)
>   	}
>   	nbd_dbg_init();
>  =20
> +	if (nr_hw_queues < 1)
> +		nr_hw_queues =3D 1;
>   	for (i =3D 0; i < nbds_max; i++)
> -		nbd_dev_add(i, 1, 1);
> +		nbd_dev_add(i, 1, nr_hw_queues);
>   	return 0;
>   }
>  =20
> @@ -2814,3 +2817,6 @@ module_param(nbds_max, int, 0444);
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
