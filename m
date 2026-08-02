Received: from va-2-53.ptr.blmpb.com (va-2-53.ptr.blmpb.com [209.127.231.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B83B19B9
	for <linux-block@vger.kernel.org>; Sun,  2 Aug 2026 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785672881; cv=none; b=R9xZGSMYzWZa5b5PH6yaEHEPaTsn0HFffNC0fdL6mJVxAIhTjJ4rormSFw90GHio8gf7UvX7SzyY446cUS/yQrDUamwqmpsijVgH0glMsmTKK/Qe8JZDJn5vc/MS62EzWpNJsb3BnP9FSnlKRLa9HCzs2HYI4x86Ih8RGVCcK1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785672881; c=relaxed/simple;
	bh=52sCRUWhseFXRto+8JSNwnIhubDl74NU22FRp1d7duQ=;
	h=To:Date:In-Reply-To:Cc:Message-Id:References:Content-Type:From:
	 Subject:Mime-Version; b=vGOC9lXU+Ohuct+nEl2w85OQoDuDwC4NW7nMhnNFjPKhos1T/bcMhOu24Bz3r6+Jm0om0Qoos29uAUqmkvysjdxkobqg+GZkOR8+NeI951kh2rLu9M+uHSlstvRoP4fLbXHi91ePIYe8/OFpEFPhW1/fLKw1KMBocp3ppOrLedU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=iHDbXL/G; arc=none smtp.client-ip=209.127.231.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="iHDbXL/G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1785672865;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=/MI7wcuHpPBk12/ZePG4+eZG3sqlToa/viziVqPBCPo=;
 b=iHDbXL/GklZ8l8+kXknH+mwVGZQyJ3nBpJp/8a5kw2fFEvZqg7a/G5PKbm/wNX5pKnpCWh
 AGu3gSuGPtwfNfF6adsmc+s73NdPcnJW7eXY617m1DRWGRrvmKvjEWJ0D2YTpJCxKF4Elm
 hHY0e2nvYKWTUeI5ENwpiotUvhj5TJcLMYOCfbgyzDzBzmYiP2sHlwjdrWuEuyKTzUuABX
 ybiJSvkE8E0rrqFsaZ7EZq4qZcgA0FmWhxZ8BnX/Xci+6R8R5aUT653NkeUK+M02rQlZ6e
 E6GR+91AewDBNc6MXVWM6gekNvqTe7SNUJ2ZkgJI5u+q7ox7ZLTMvVzirHpRbQ==
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Reply-To: yukuai@fygo.io
Date: Sun, 2 Aug 2026 20:14:19 +0800
In-Reply-To: <20260730082046.3459239-7-yangerkun@huawei.com>
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>, 
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
Message-Id: <248d334a-5fa5-4568-8083-6249e5cdec78@fygo.io>
References: <20260730082046.3459239-1-yangerkun@huawei.com> <20260730082046.3459239-7-yangerkun@huawei.com>
Received: from [192.168.1.104] ([39.182.0.181]) by smtp.larksuite.com with ESMTPS; Sun, 02 Aug 2026 12:14:23 +0000
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
From: "yu kuai" <yukuai@fygo.io>
Subject: Re: [PATCH v5 6/8] nbd: factor out a nbd_genl_foreach_sock
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+26a6f34a0+e42ee1+vger.kernel.org+yukuai@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>

Hi,

=E5=9C=A8 2026/7/30 16:20, Yang Erkun =E5=86=99=E9=81=93:
> The NBD_ATTR_SOCKETS walk is duplicated in nbd_genl_connect (add sockets)
> and nbd_genl_reconfigure (reconnect).  Factor out a single helper that
> walks the list and calls a callback per fd; with a NULL callback it is a
> pure counter, used by a later patch to learn nr_hw_queues before the
> device exists.  Returns the number of fds walked (>=3D 0) or a negative
> errno; a callback >0 stops early as success (reconnect's -ENOSPC).
>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>   drivers/block/nbd.c | 137 +++++++++++++++++++++++---------------------
>   1 file changed, 73 insertions(+), 64 deletions(-)

This patch LGTM, two nits below.

>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 3b7363b11d0b..34b84fc1c61f 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -2108,6 +2108,58 @@ static int nbd_genl_size_set(struct genl_info *inf=
o, struct nbd_device *nbd)
>   	return 0;
>   }
>  =20
> +/*
> + * Walk the NBD_ATTR_SOCKETS nested list can call @cb for each socket fd=
.
> + *
> + * Return the number of fds walked, or a negative errno.
> + */
> +static int nbd_genl_foreach_sock(struct genl_info *info,
> +		int (*cb)(struct nbd_device *nbd, int fd),
> +		struct nbd_device *nbd)
> +{
> +	struct nlattr *attr;
> +	int rem, count =3D 0;
> +
> +	if (!info->attrs[NBD_ATTR_SOCKETS])
> +		return 0;
> +
> +	nla_for_each_nested(attr, info->attrs[NBD_ATTR_SOCKETS], rem) {
> +		struct nlattr *socks[NBD_SOCK_MAX + 1];
> +		int ret;
> +
> +		if (nla_type(attr) !=3D NBD_SOCK_ITEM) {
> +			pr_err("socks must be embedded in a SOCK_ITEM attr\n");
> +			return -EINVAL;
> +		}
> +
> +		if (nla_parse_nested_deprecated(socks, NBD_SOCK_MAX,
> +						attr,
> +						nbd_sock_policy,
> +						info->extack)) {
> +			pr_err("error processing sock list\n");
> +			return -EINVAL;
> +		}
> +
> +		if (!socks[NBD_SOCK_FD])
> +			continue;
> +
> +		count++;
> +		if (cb) {
> +			ret =3D cb(nbd, (int)nla_get_u32(socks[NBD_SOCK_FD]));
> +			if (ret > 0)
> +				return count;
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +	return count;
> +}
> +
> +static int nbd_genl_connect_sock_cb(struct nbd_device *nbd, int fd)
> +{
> +	return nbd_add_socket(nbd, fd, true);
> +}
> +
>   static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info=
)
>   {
>   	struct nbd_device *nbd;
> @@ -2227,36 +2279,9 @@ static int nbd_genl_connect(struct sk_buff *skb, s=
truct genl_info *info)
>   		}
>   	}
>  =20
> -	if (info->attrs[NBD_ATTR_SOCKETS]) {
> -		struct nlattr *attr;
> -		int rem, fd;
> -
> -		nla_for_each_nested(attr, info->attrs[NBD_ATTR_SOCKETS],
> -				    rem) {
> -			struct nlattr *socks[NBD_SOCK_MAX+1];
> -
> -			if (nla_type(attr) !=3D NBD_SOCK_ITEM) {
> -				pr_err("socks must be embedded in a SOCK_ITEM attr\n");
> -				ret =3D -EINVAL;
> -				goto out;
> -			}
> -			ret =3D nla_parse_nested_deprecated(socks, NBD_SOCK_MAX,
> -							  attr,
> -							  nbd_sock_policy,
> -							  info->extack);
> -			if (ret !=3D 0) {
> -				pr_err("error processing sock list\n");
> -				ret =3D -EINVAL;
> -				goto out;
> -			}
> -			if (!socks[NBD_SOCK_FD])
> -				continue;
> -			fd =3D (int)nla_get_u32(socks[NBD_SOCK_FD]);
> -			ret =3D nbd_add_socket(nbd, fd, true);
> -			if (ret)
> -				goto out;
> -		}
> -	}
> +	ret =3D nbd_genl_foreach_sock(info, nbd_genl_connect_sock_cb, nbd);
> +	if (ret < 0)
> +		goto out;
>  =20
>   	if (info->attrs[NBD_ATTR_BACKEND_IDENTIFIER]) {
>   		nbd->backend =3D nla_strdup(info->attrs[NBD_ATTR_BACKEND_IDENTIFIER],
> @@ -2345,6 +2370,20 @@ static int nbd_genl_disconnect(struct sk_buff *skb=
, struct genl_info *info)
>   	return 0;
>   }
>  =20
> +static int nbd_genl_reconnect_sock_cb(struct nbd_device *nbd, int fd)
> +{
> +	int ret =3D nbd_reconnect_socket(nbd, fd);
> +
> +	if (!ret) {
> +		dev_info(nbd_to_dev(nbd), "reconnected socket\n");
> +		return 0;
> +	}
> +
> +	if (ret =3D=3D -ENOSPC)
> +		return 1;
> +	return ret;
> +}

Since there is only one caller for nbd_reconnect_socket(), you might as wel=
l just fold above
changes into nbd_reconnect_socket() directly.

> +
>   static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *=
info)
>   {
>   	struct nbd_device *nbd =3D NULL;
> @@ -2441,40 +2480,10 @@ static int nbd_genl_reconfigure(struct sk_buff *s=
kb, struct genl_info *info)
>   		}
>   	}
>  =20
> -	if (info->attrs[NBD_ATTR_SOCKETS]) {
> -		struct nlattr *attr;
> -		int rem, fd;
> -
> -		nla_for_each_nested(attr, info->attrs[NBD_ATTR_SOCKETS],
> -				    rem) {
> -			struct nlattr *socks[NBD_SOCK_MAX+1];
> -
> -			if (nla_type(attr) !=3D NBD_SOCK_ITEM) {
> -				pr_err("socks must be embedded in a SOCK_ITEM attr\n");
> -				ret =3D -EINVAL;
> -				goto out;
> -			}
> -			ret =3D nla_parse_nested_deprecated(socks, NBD_SOCK_MAX,
> -							  attr,
> -							  nbd_sock_policy,
> -							  info->extack);
> -			if (ret !=3D 0) {
> -				pr_err("error processing sock list\n");
> -				ret =3D -EINVAL;
> -				goto out;
> -			}
> -			if (!socks[NBD_SOCK_FD])
> -				continue;
> -			fd =3D (int)nla_get_u32(socks[NBD_SOCK_FD]);
> -			ret =3D nbd_reconnect_socket(nbd, fd);
> -			if (ret) {
> -				if (ret =3D=3D -ENOSPC)
> -					ret =3D 0;
> -				goto out;
> -			}
> -			dev_info(nbd_to_dev(nbd), "reconnected socket\n");
> -		}
> -	}
> +	ret =3D nbd_genl_foreach_sock(info, nbd_genl_reconnect_sock_cb, nbd);
> +	/* foreach_sock returns a positive count on success; doit must return 0=
 */
> +	if (ret >=3D 0)
> +		ret =3D 0;
>   out:
>   	mutex_unlock(&nbd->config_lock);
>   	nbd_config_put(nbd);

--=20
Thanks,
Kuai
