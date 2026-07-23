Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06612C534
	for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769007; cv=none; b=gHS17cgPVa0TduQkjxQIOll2O/DTnK/m+i+C1RKMOomcRjVTDUonUBlReHG40Y/4QBx+yjkpEq4vUj8QDWqxar65vkeObfhhBot4SmLLwdnSbwZOcoebQIuBUNgcTUkwmjyCJDpla+WO/vsIZK7Teo3cR4n+epL9YEQtmPe6Ll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769007; c=relaxed/simple;
	bh=DzWwKMMLRauRrABiNMtUEclS/0aVSg4+FPFZokICauY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n8k/sad4RTtOEhOCuo0taibOum8Ftz6IoxMzJq5dBZpDV3WJa4F8ox2jbH4RDTZQu0YXEGmZNGp7TgNfH8RXrDHkWSvG9Q83ZzQKPPBZnTM9QuuXe8iGkt5HilIYinJESy0M0yTYRE3CPSpFjNzQ4ecXSGOnvzcUTqtTT69P/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RB3VZoM1; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RB3VZoM1"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cNZEZj6H8kmg1VGvGnXYYCwxZjZuLtSzDx+riLcgnfQ=;
	b=RB3VZoM1QmtyNoyNh8O+f8J2eTFn/5tu9kMqegRmxtmbMscT0TmsbAvqIRuW6EAfWn9Kj8BaV
	CRD9K0lneesrQlAN+u3JIu/7+kSCXqC5J669PldEdck4VQN5kgSDyT0tP6W3VNd8GSb9fczFhpF
	YwzElaX5zfNqbNMDvcJp5/Y=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h5CTn2ch8zKm5m;
	Thu, 23 Jul 2026 09:00:29 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id E287F4057C;
	Thu, 23 Jul 2026 09:09:54 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 23 Jul 2026 09:09:54 +0800
Message-ID: <b5754d82-d5b8-41dd-bf67-ff20d6b197d1@huawei.com>
Date: Thu, 23 Jul 2026 09:09:53 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] nbd: set nr_hw_queues at device creation to skip
 queue freeze
To: <yukuai@fygo.io>, <josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@lst.de>
CC: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>,
	<wangkefeng.wang@huawei.com>, <linux-block@vger.kernel.org>,
	<nbd@other.debian.org>
References: <20260713065644.1637594-1-yangerkun@huawei.com>
 <20260713065644.1637594-5-yangerkun@huawei.com>
 <a36f609c-c861-42ad-afd5-b44e7cdcfb80@fygo.io>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <a36f609c-c861-42ad-afd5-b44e7cdcfb80@fygo.io>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100006.china.huawei.com (7.202.181.220)

Hi,

在 2026/7/22 11:38, yu kuai 写道:
> Hi,
> 
> 在 2026/7/13 14:56, Yang Erkun 写道:
>> There still be queue freeze call when nbd_start_device invoking
>> blk_mq_update_nr_hw_queues. For netlink path, we can obtain the actual
>> number of connections before calling nbd_dev_add in nbd_genl_connect,
>> which can helps remove this queue freeze.
>>
>> However, nbd devices created with a fixed nbds_max may still require
>> this freezing because the real connection count is unknown.
>>
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>    drivers/block/nbd.c | 39 +++++++++++++++++++++++++++++++++++----
>>    1 file changed, 35 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 0755b7046ed4..400f638e832e 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -1930,7 +1930,8 @@ static const struct blk_mq_ops nbd_mq_ops = {
>>    	.timeout	= nbd_xmit_timeout,
>>    };
>>    
>> -static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
>> +static struct nbd_device *nbd_dev_add(int index, unsigned int refs,
>> +				       int nr_hw_queues)
>>    {
>>    	struct queue_limits lim = {
>>    		.max_hw_sectors		= 65536,
>> @@ -1947,7 +1948,7 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
>>    		goto out;
>>    
>>    	nbd->tag_set.ops = &nbd_mq_ops;
>> -	nbd->tag_set.nr_hw_queues = 1;
>> +	nbd->tag_set.nr_hw_queues = nr_hw_queues;
>>    	nbd->tag_set.queue_depth = 128;
>>    	nbd->tag_set.numa_node = NUMA_NO_NODE;
>>    	nbd->tag_set.cmd_size = sizeof(struct nbd_cmd);
>> @@ -2070,6 +2071,35 @@ static const struct nla_policy nbd_sock_policy[NBD_SOCK_MAX + 1] = {
>>    	[NBD_SOCK_FD]			=	{ .type = NLA_U32 },
>>    };
>>    
>> +/*
>> + * Count the number of socket FDs in the NBD_ATTR_SOCKETS netlink attribute.
>> + * This is used to determine the correct nr_hw_queues before creating the
>> + * nbd device, so that blk_mq_update_nr_hw_queues (and its RCU grace period
>> + * overhead) can be avoided entirely.
>> + */
>> +static int nbd_genl_count_sockets(struct genl_info *info)
>> +{
>> +	struct nlattr *attr;
>> +	int rem, count = 0;
>> +
>> +	if (!info->attrs[NBD_ATTR_SOCKETS])
>> +		return 0;
>> +
>> +	nla_for_each_nested(attr, info->attrs[NBD_ATTR_SOCKETS], rem) {
>> +		struct nlattr *socks[NBD_SOCK_MAX + 1];
>> +
>> +		if (nla_type(attr) != NBD_SOCK_ITEM)
>> +			continue;
> 
> nbd_genl_connect() will fail in this case.
> 
>> +		if (nla_parse_nested_deprecated(socks, NBD_SOCK_MAX,
>> +						  attr, nbd_sock_policy,
>> +						  info->extack) != 0)
>> +			continue;
>> +		if (socks[NBD_SOCK_FD])
>> +			count++;
>> +	}
>> +	return count;
>> +}
> 
> Personally I don't like to copy code from existed NBD_ATTR_SOCKETS handling. Do
> you consider moving NBD_ATTR_SOCKETS handling forward or factor out a common helper?

OK, I will try it.

> 
>> +
>>    /* We don't use this right now since we don't parse the incoming list, but we
>>     * still want it here so userspace knows what to expect.
>>     */
>> @@ -2101,6 +2131,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>>    	struct nbd_device *nbd;
>>    	struct nbd_config *config;
>>    	int index = -1;
>> +	int num_connections = nbd_genl_count_sockets(info);
>>    	int ret;
>>    	bool put_dev = false;
>>    
>> @@ -2148,7 +2179,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>>    	mutex_unlock(&nbd_index_mutex);
>>    
>>    	if (!nbd) {
>> -		nbd = nbd_dev_add(index, 2);
>> +		nbd = nbd_dev_add(index, 2, num_connections);
>>    		if (IS_ERR(nbd)) {
>>    			pr_err("failed to add new device\n");
>>    			return PTR_ERR(nbd);
>> @@ -2715,7 +2746,7 @@ static int __init nbd_init(void)
>>    	nbd_dbg_init();
>>    
>>    	for (i = 0; i < nbds_max; i++)
>> -		nbd_dev_add(i, 1);
>> +		nbd_dev_add(i, 1, 1);
>>    	return 0;
>>    }
> 
> This approach will only be useful when nbd device is created the first time.
> If NBD_ATTR_INDEX is set and nbd device is found, or NBD_ATTR_IDNEX is not set
> and nbd_find_get_unused() found an unused nbd device, blk_mq_update_nr_hw_queues()
> is still required. As you can see, nbds_max is default to 16 and all these devices
> will be created with nr_hw_queues as 1.

Yes, this patch indeed only addresses the freeze/unfreeze issue when 
creating a nbd device for the first time through netlink. The later 
patch addresses the nbds_max case. I will update the commit message 
later to make it more accurate.

> 
>>    
> 

