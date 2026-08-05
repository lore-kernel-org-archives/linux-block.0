Received: from sg-3-45.ptr.tlmpb.com (sg-3-45.ptr.tlmpb.com [101.45.255.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5821D3D954F
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919654; cv=none; b=INRhZphcOuIaNBW2qHQLEuLhWeaoFCDtCTz86Ra37c4aWAMXRi0E/KoiTkwNOY7hlxUptBzzR+kFKLGDijQm/y2w9jkvMZIusc/xeW9zUfZol/hgss2oF3tZgEdGCFA0EQaJLY261VEAiOMYzxPjd5lGhGk6xsdr6lM1UrtkwoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919654; c=relaxed/simple;
	bh=82dVUQSTCKBdlHlK5tgY1fY0WmT28TiGjxsfHEny/Gk=;
	h=From:Date:Mime-Version:In-Reply-To:To:Subject:References:Cc:
	 Message-Id:Content-Type; b=GywpqVUSUf49AXddV7sXJF03oYbpdnvtjtsElM1a+LAH7o4uaN3eZT8lQ5SQTaOKBekQ1pU3/CsD1Ou4R2FqXxxrQ315/V1rCPg/aEHv2ZGHPEM6+uoAyKZa9I7I64gcQSLf0W6Dwk1uhncNTT/7bcPkjrAl8ZKpJhXdFXZyThw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=TmrpWkLW; arc=none smtp.client-ip=101.45.255.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="TmrpWkLW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1785919556;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=9lofU4TyutyMU1dsRW4KP/ALsmoGw8wIYdXifrJTcok=;
 b=TmrpWkLWOPD75w0OISP3XWXSAOPMdb1aWjqvS1btrBSPSFwv8gzRV16H1Kzls0szT19XOe
 EOcJhKsaxL2XF+/R2WMWcSozysT+S6MT0r5zSpGppZkKQgJnRzdq4yTOuqAF0C5liXyGIW
 VFzey4jDLzvQAvXouv8R1TqwoLZp8OE6+OaSrvoNeLyQBaGFYHQIf1J3F7QZRfyuLghhXq
 xaZkiI7yshgcy54Na7vNN+UexzVbyXZBuoDrduOOctEKmLucDw7GN0A1jIcjHU2yfdkXoq
 CYqF7qO2cRCHvwv2wwLAJX7EUFxBhqpXsNQNkIRERbJBC28f+Zy58T77l5Ysww==
From: "yu kuai" <yukuai@fygo.io>
Date: Wed, 5 Aug 2026 16:45:50 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a72f844+73cb7f+vger.kernel.org+yukuai@fygo.io>
In-Reply-To: <20260805065843.3332859-9-yangerkun@huawei.com>
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Subject: Re: [PATCH v7 8/8] nbd: add pre_defined_connections module parameter for pre-created devices
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
References: <20260805065843.3332859-1-yangerkun@huawei.com> <20260805065843.3332859-9-yangerkun@huawei.com>
Received: from [192.168.1.104] ([39.182.0.181]) by smtp.larksuite.com with ESMTPS; Wed, 05 Aug 2026 08:45:55 +0000
Reply-To: yukuai@fygo.io
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>, 
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
Message-Id: <6b39fb25-6030-4e4e-9200-c7df47f3ca89@fygo.io>
Content-Type: text/plain; charset=UTF-8
X-Original-From: yu kuai <yukuai@fygo.io>

Hi,

=E5=9C=A8 2026/8/5 14:58, Yang Erkun =E5=86=99=E9=81=93:
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
>   drivers/block/nbd.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index b316129b9a17..f8f51df31ada 100644
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
> @@ -2733,8 +2734,13 @@ static int __init nbd_init(void)
>   	}
>   	nbd_dbg_init();
>  =20
> +	if (pre_defined_connections < 1)
> +		pre_defined_connections =3D 1;

nbd_init() will fail for invalid module parameter like max_part, nbds_max. =
So I
think it's better to fail for new parameter as well.

> +	/* Set to the intended connection count so nbd_start_device() can skip
> +	 * the queue-freezing blk_mq_update_nr_hw_queues() call.
> +	 */

Please follow the common comment style in this file.

/*
  * xxx
  */

>   	for (i =3D 0; i < nbds_max; i++)
> -		nbd_dev_add(i, 1, 1);
> +		nbd_dev_add(i, 1, pre_defined_connections);
>   	return 0;
>   }
>  =20
> @@ -2795,3 +2801,6 @@ module_param(nbds_max, int, 0444);
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
