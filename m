Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5292430D407
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 02:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785722978; cv=none; b=kTjBcpf0D1FbOKVvG5Fd91JiE0Yh6Sy59xYhgW24MuhNsl91pLJVSsjCs5lpDx82WwwopT+5WdnugBCPHV2nRSSWNpgUUpS4zbNjXL7SE+7WIWPBSJFfqdCgwjGeXAPfypxCp/BL8zFqojb1i1HBGvAV1Or65bpOBeKH0MeaVSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785722978; c=relaxed/simple;
	bh=PvKLdROp+aSf93DBWZA/kgezXawMZJ56pgt3qRCjaD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fsVVaGaM3II6SIQ7lkGWfPei4bMc4qhHMxvYNvTsmtIErebDHw7fgBzWMl6PZa0k4M8qfDYkg58gsEFYXMKFJHtQw9HNJllPo4aXh8fq4PtId+7P1LxYKqvdj3OfRGfxtfbG6u8/xY5NkOBjN2n2njZxg5KVmVLrq1Pw2WzKZG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Fj5F69Wd; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Fj5F69Wd"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0Lu5/OW5g5EhaNfWm027awW5NftsjHHkN1z1xuuBA3k=;
	b=Fj5F69Wd0MBpOtzChXy7jzKkhX1O+FbCWXbkiFsnfqqohQUNHg7pT3MwDTvCfFGWFKmUhMJ6c
	VBu7QMwJQZ8pTNfjFv7n1EjvdI2BLWQIbDV0QsTBVFn2I9cIbLIV7Fz22utIAYquFEpl0Ya58Al
	Q3MxCr5I1FNwa1/XuFcQVdY=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hD0HN01DkznTbN;
	Mon,  3 Aug 2026 10:00:00 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 92B4D4056C;
	Mon,  3 Aug 2026 10:09:24 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 3 Aug 2026 10:09:23 +0800
Message-ID: <73779a3d-2897-4a98-a0e3-9f12a382efd1@huawei.com>
Date: Mon, 3 Aug 2026 10:09:23 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] nbd: factor out a nbd_genl_foreach_sock
To: <yukuai@fygo.io>, <josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@lst.de>
CC: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>,
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>,
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, <nbd@other.debian.org>
References: <20260730082046.3459239-1-yangerkun@huawei.com>
 <20260730082046.3459239-7-yangerkun@huawei.com>
 <248d334a-5fa5-4568-8083-6249e5cdec78@fygo.io>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <248d334a-5fa5-4568-8083-6249e5cdec78@fygo.io>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2026/8/2 20:14, yu kuai 写道:
> Hi,
> 
> 在 2026/7/30 16:20, Yang Erkun 写道:
>> The NBD_ATTR_SOCKETS walk is duplicated in nbd_genl_connect (add sockets)
>> and nbd_genl_reconfigure (reconnect).  Factor out a single helper that
>> walks the list and calls a callback per fd; with a NULL callback it is a
>> pure counter, used by a later patch to learn nr_hw_queues before the
>> device exists.  Returns the number of fds walked (>= 0) or a negative
>> errno; a callback >0 stops early as success (reconnect's -ENOSPC).
>>
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>    drivers/block/nbd.c | 137 +++++++++++++++++++++++---------------------
>>    1 file changed, 73 insertions(+), 64 deletions(-)
> 
> This patch LGTM, two nits below.
> 
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 3b7363b11d0b..34b84fc1c61f 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -2108,6 +2108,58 @@ static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
>>    	return 0;
>>    }
>>    
>> +/*
>> + * Walk the NBD_ATTR_SOCKETS nested list can call @cb for each socket fd.
>> + *
>> + * Return the number of fds walked, or a negative errno.
>> + */
>> +static int nbd_genl_foreach_sock(struct genl_info *info,
>> +		int (*cb)(struct nbd_device *nbd, int fd),
>> +		struct nbd_device *nbd)
>> +{
>> +	struct nlattr *attr;
>> +	int rem, count = 0;
>> +
>> +	if (!info->attrs[NBD_ATTR_SOCKETS])
>> +		return 0;
>> +
>> +	nla_for_each_nested(attr, info->attrs[NBD_ATTR_SOCKETS], rem) {
>> +		struct nlattr *socks[NBD_SOCK_MAX + 1];
>> +		int ret;
>> +
>> +		if (nla_type(attr) != NBD_SOCK_ITEM) {
>> +			pr_err("socks must be embedded in a SOCK_ITEM attr\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (nla_parse_nested_deprecated(socks, NBD_SOCK_MAX,
>> +						attr,
>> +						nbd_sock_policy,
>> +						info->extack)) {
>> +			pr_err("error processing sock list\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (!socks[NBD_SOCK_FD])
>> +			continue;
>> +
>> +		count++;
>> +		if (cb) {
>> +			ret = cb(nbd, (int)nla_get_u32(socks[NBD_SOCK_FD]));
>> +			if (ret > 0)
>> +				return count;
>> +			if (ret < 0)
>> +				return ret;
>> +		}
>> +	}
>> +	return count;
>> +}
>> +
>> +static int nbd_genl_connect_sock_cb(struct nbd_device *nbd, int fd)
>> +{
>> +	return nbd_add_socket(nbd, fd, true);
>> +}
>> +
>>    static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>>    {
>>    	struct nbd_device *nbd;
>> @@ -2227,36 +2279,9 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>>    		}
>>    	}
>>    
>> -	if (info->attrs[NBD_ATTR_SOCKETS]) {
>> -		struct nlattr *attr;
>> -		int rem, fd;
>> -
>> -		nla_for_each_nested(attr, info->attrs[NBD_ATTR_SOCKETS],
>> -				    rem) {
>> -			struct nlattr *socks[NBD_SOCK_MAX+1];
>> -
>> -			if (nla_type(attr) != NBD_SOCK_ITEM) {
>> -				pr_err("socks must be embedded in a SOCK_ITEM attr\n");
>> -				ret = -EINVAL;
>> -				goto out;
>> -			}
>> -			ret = nla_parse_nested_deprecated(socks, NBD_SOCK_MAX,
>> -							  attr,
>> -							  nbd_sock_policy,
>> -							  info->extack);
>> -			if (ret != 0) {
>> -				pr_err("error processing sock list\n");
>> -				ret = -EINVAL;
>> -				goto out;
>> -			}
>> -			if (!socks[NBD_SOCK_FD])
>> -				continue;
>> -			fd = (int)nla_get_u32(socks[NBD_SOCK_FD]);
>> -			ret = nbd_add_socket(nbd, fd, true);
>> -			if (ret)
>> -				goto out;
>> -		}
>> -	}
>> +	ret = nbd_genl_foreach_sock(info, nbd_genl_connect_sock_cb, nbd);
>> +	if (ret < 0)
>> +		goto out;
>>    
>>    	if (info->attrs[NBD_ATTR_BACKEND_IDENTIFIER]) {
>>    		nbd->backend = nla_strdup(info->attrs[NBD_ATTR_BACKEND_IDENTIFIER],
>> @@ -2345,6 +2370,20 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
>>    	return 0;
>>    }
>>    
>> +static int nbd_genl_reconnect_sock_cb(struct nbd_device *nbd, int fd)
>> +{
>> +	int ret = nbd_reconnect_socket(nbd, fd);
>> +
>> +	if (!ret) {
>> +		dev_info(nbd_to_dev(nbd), "reconnected socket\n");
>> +		return 0;
>> +	}
>> +
>> +	if (ret == -ENOSPC)
>> +		return 1;
>> +	return ret;
>> +}
> 
> Since there is only one caller for nbd_reconnect_socket(), you might as well just fold above
> changes into nbd_reconnect_socket() directly.

OK, will do it next version!

> 
>> +
>>    static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
>>    {
>>    	struct nbd_device *nbd = NULL;
>> @@ -2441,40 +2480,10 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
>>    		}
>>    	}
>>    
>> -	if (info->attrs[NBD_ATTR_SOCKETS]) {
>> -		struct nlattr *attr;
>> -		int rem, fd;
>> -
>> -		nla_for_each_nested(attr, info->attrs[NBD_ATTR_SOCKETS],
>> -				    rem) {
>> -			struct nlattr *socks[NBD_SOCK_MAX+1];
>> -
>> -			if (nla_type(attr) != NBD_SOCK_ITEM) {
>> -				pr_err("socks must be embedded in a SOCK_ITEM attr\n");
>> -				ret = -EINVAL;
>> -				goto out;
>> -			}
>> -			ret = nla_parse_nested_deprecated(socks, NBD_SOCK_MAX,
>> -							  attr,
>> -							  nbd_sock_policy,
>> -							  info->extack);
>> -			if (ret != 0) {
>> -				pr_err("error processing sock list\n");
>> -				ret = -EINVAL;
>> -				goto out;
>> -			}
>> -			if (!socks[NBD_SOCK_FD])
>> -				continue;
>> -			fd = (int)nla_get_u32(socks[NBD_SOCK_FD]);
>> -			ret = nbd_reconnect_socket(nbd, fd);
>> -			if (ret) {
>> -				if (ret == -ENOSPC)
>> -					ret = 0;
>> -				goto out;
>> -			}
>> -			dev_info(nbd_to_dev(nbd), "reconnected socket\n");
>> -		}
>> -	}
>> +	ret = nbd_genl_foreach_sock(info, nbd_genl_reconnect_sock_cb, nbd);
>> +	/* foreach_sock returns a positive count on success; doit must return 0 */
>> +	if (ret >= 0)
>> +		ret = 0;
>>    out:
>>    	mutex_unlock(&nbd->config_lock);
>>    	nbd_config_put(nbd);
> 

