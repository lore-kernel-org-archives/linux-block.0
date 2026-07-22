Received: from va-2-44.ptr.blmpb.com (va-2-44.ptr.blmpb.com [209.127.231.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45EA3E51FC
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784691540; cv=none; b=XUYSVH4zYx3vasM3hrCUXtKKN7/cqHSZelr1AknGlgnMTzDTH+FRG6zn7ud630YTHyXAhc/0GB4eP9aBEO+/OM/1rCCWQuZimqZi6jWBtaqIbjE8HvJO5qQzCe5MxBObnTJRUyXCEX+U42V9PSgx3GPqRcgtS/ibY9BP2fzsRds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784691540; c=relaxed/simple;
	bh=LvQ0l8Y1Sr4q5vki0hokRfiHpzJeoepEXQz3oRTmlXo=;
	h=Content-Type:Subject:To:Cc:References:In-Reply-To:Date:Message-Id:
	 Mime-Version:From; b=Tn6ICHawUZciO4oWoG5GDv2HLXXO8dZAl0StQT2erW3V9sAVYozMAX2qlHWZvrDiP4fdc9rqCvBEYCemItfdUfxWF34AyPYtPyKaHxFvM85a7J1c+0eLuYS7rhgZMy5wWtQk2otQM50VcYl6LP+rBwnSsmIWWd5Abg9afWp/dXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=YQCV3XwF; arc=none smtp.client-ip=209.127.231.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="YQCV3XwF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1784691525;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=ypsEvJ3+ptO3hb6bwrhxUuy7340bLg0ckLETzBzbR/I=;
 b=YQCV3XwFjp0fJKF+wGuXn9gOuSi29OZ0nxNAzS6OErm7dLoNvAKrxZoVk5Xz+YJueB0Tj3
 9HPJughX18KogHJoel+zryuk2dP4k4seE59cwHhtkxA/DqgzN1FEG/jY5lfcsKnkIvIXB0
 aq7CcxoRWd3NtBrlDsCAJBJMmwsMUNkpV8MDZjA5Jf4Rw0v82MiDik3sl91npQScosJ5ko
 jPM0CJ3dNCZZo6SmNoIU+rOzEPGz9d+LuB3S40yF0TVobbyLMGaMkLDFgwADD3IKPDA2Y4
 +9YDDF7rgtvu5m+JTWKgLl2Fc8NkmDz97BQR8PHc6AW/1vpGk9c4T4b0/yYcDQ==
X-Original-From: yu kuai <yukuai@fygo.io>
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] nbd: set nr_hw_queues at device creation to skip queue freeze
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
X-Lms-Return-Path: <lba+26a603b44+7840d0+vger.kernel.org+yukuai@fygo.io>
References: <20260713065644.1637594-1-yangerkun@huawei.com> <20260713065644.1637594-5-yangerkun@huawei.com>
In-Reply-To: <20260713065644.1637594-5-yangerkun@huawei.com>
Reply-To: yukuai@fygo.io
Date: Wed, 22 Jul 2026 11:38:39 +0800
Message-Id: <a36f609c-c861-42ad-afd5-b44e7cdcfb80@fygo.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.167]) by smtp.larksuite.com with ESMTPS; Wed, 22 Jul 2026 03:38:43 +0000
Content-Transfer-Encoding: quoted-printable
From: "yu kuai" <yukuai@fygo.io>

Hi,

=E5=9C=A8 2026/7/13 14:56, Yang Erkun =E5=86=99=E9=81=93:
> There still be queue freeze call when nbd_start_device invoking
> blk_mq_update_nr_hw_queues. For netlink path, we can obtain the actual
> number of connections before calling nbd_dev_add in nbd_genl_connect,
> which can helps remove this queue freeze.
>
> However, nbd devices created with a fixed nbds_max may still require
> this freezing because the real connection count is unknown.
>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>   drivers/block/nbd.c | 39 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 0755b7046ed4..400f638e832e 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1930,7 +1930,8 @@ static const struct blk_mq_ops nbd_mq_ops =3D {
>   	.timeout	=3D nbd_xmit_timeout,
>   };
>  =20
> -static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
> +static struct nbd_device *nbd_dev_add(int index, unsigned int refs,
> +				       int nr_hw_queues)
>   {
>   	struct queue_limits lim =3D {
>   		.max_hw_sectors		=3D 65536,
> @@ -1947,7 +1948,7 @@ static struct nbd_device *nbd_dev_add(int index, un=
signed int refs)
>   		goto out;
>  =20
>   	nbd->tag_set.ops =3D &nbd_mq_ops;
> -	nbd->tag_set.nr_hw_queues =3D 1;
> +	nbd->tag_set.nr_hw_queues =3D nr_hw_queues;
>   	nbd->tag_set.queue_depth =3D 128;
>   	nbd->tag_set.numa_node =3D NUMA_NO_NODE;
>   	nbd->tag_set.cmd_size =3D sizeof(struct nbd_cmd);
> @@ -2070,6 +2071,35 @@ static const struct nla_policy nbd_sock_policy[NBD=
_SOCK_MAX + 1] =3D {
>   	[NBD_SOCK_FD]			=3D	{ .type =3D NLA_U32 },
>   };
>  =20
> +/*
> + * Count the number of socket FDs in the NBD_ATTR_SOCKETS netlink attrib=
ute.
> + * This is used to determine the correct nr_hw_queues before creating th=
e
> + * nbd device, so that blk_mq_update_nr_hw_queues (and its RCU grace per=
iod
> + * overhead) can be avoided entirely.
> + */
> +static int nbd_genl_count_sockets(struct genl_info *info)
> +{
> +	struct nlattr *attr;
> +	int rem, count =3D 0;
> +
> +	if (!info->attrs[NBD_ATTR_SOCKETS])
> +		return 0;
> +
> +	nla_for_each_nested(attr, info->attrs[NBD_ATTR_SOCKETS], rem) {
> +		struct nlattr *socks[NBD_SOCK_MAX + 1];
> +
> +		if (nla_type(attr) !=3D NBD_SOCK_ITEM)
> +			continue;

nbd_genl_connect() will fail in this case.

> +		if (nla_parse_nested_deprecated(socks, NBD_SOCK_MAX,
> +						  attr, nbd_sock_policy,
> +						  info->extack) !=3D 0)
> +			continue;
> +		if (socks[NBD_SOCK_FD])
> +			count++;
> +	}
> +	return count;
> +}

Personally I don't like to copy code from existed NBD_ATTR_SOCKETS handling=
. Do
you consider moving NBD_ATTR_SOCKETS handling forward or factor out a commo=
n helper?

> +
>   /* We don't use this right now since we don't parse the incoming list, =
but we
>    * still want it here so userspace knows what to expect.
>    */
> @@ -2101,6 +2131,7 @@ static int nbd_genl_connect(struct sk_buff *skb, st=
ruct genl_info *info)
>   	struct nbd_device *nbd;
>   	struct nbd_config *config;
>   	int index =3D -1;
> +	int num_connections =3D nbd_genl_count_sockets(info);
>   	int ret;
>   	bool put_dev =3D false;
>  =20
> @@ -2148,7 +2179,7 @@ static int nbd_genl_connect(struct sk_buff *skb, st=
ruct genl_info *info)
>   	mutex_unlock(&nbd_index_mutex);
>  =20
>   	if (!nbd) {
> -		nbd =3D nbd_dev_add(index, 2);
> +		nbd =3D nbd_dev_add(index, 2, num_connections);
>   		if (IS_ERR(nbd)) {
>   			pr_err("failed to add new device\n");
>   			return PTR_ERR(nbd);
> @@ -2715,7 +2746,7 @@ static int __init nbd_init(void)
>   	nbd_dbg_init();
>  =20
>   	for (i =3D 0; i < nbds_max; i++)
> -		nbd_dev_add(i, 1);
> +		nbd_dev_add(i, 1, 1);
>   	return 0;
>   }

This approach will only be useful when nbd device is created the first time=
.
If NBD_ATTR_INDEX is set and nbd device is found, or NBD_ATTR_IDNEX is not =
set
and nbd_find_get_unused() found an unused nbd device, blk_mq_update_nr_hw_q=
ueues()
is still required. As you can see, nbds_max is default to 16 and all these =
devices
will be created with nr_hw_queues as 1.

>  =20

--=20
Thanks,
Kuai
