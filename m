Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFA1374A0A
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 06:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785911235; cv=none; b=JFYbi/Shn8/8a/XwDlKEvZPIXawAZ4NfiIYb0i03KjFRL+3w8Rz85YZ7ZFG/mRFOuDkEt7LIzpb25qbFeYXU0lC0BFRptleaPaTs30z99wFu6cxzsIkPL1DOvQ3Aj2mPEKqQZLKHJNTtSBLyd/TOSCrah1A+GAiGjAYOgIbyAnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785911235; c=relaxed/simple;
	bh=hLbKGFFaVlFdKJRIso3KOlMakXDAeYJcyF3ttzPX4VU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Jl1/maobcIMMG4boBjlH+K8t//Vvw6/9cYaLfOiIxehds/jbZZQp/pcja+WAixa3sXlkQMei+EDR/NTDsDsacw/0QC/xC+vteh1RM1OOMftS+2+nn8YUXl1fVKvRNecd2fb4zW17hWcsTTEI9OljZZlFRKbt00hb6gu6oQPoVCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=c1Obcdry; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="c1Obcdry"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=j/aVuiY9bylWkxOHhkPJbPR8kXYX1ueguX/r6g26rbc=;
	b=c1Obcdry/3lUlJieZaYRZD8bJE/4sVc8GqB5IiHJSGIJFSaMxdV4/ET5xW2eIX55NZojeuqRB
	soNDsQ0zmoHbqnq2AOKNTYpn5fydEK8v7qh1ZmA/xSjnL/+1SK9GP1uBD5MxcCZMBpcDhMKSksk
	2iq9omdAe3iZSvId5+TOfIg=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hFKvS2kQrz1T4Lb;
	Wed,  5 Aug 2026 14:17:24 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 99D9C40561;
	Wed,  5 Aug 2026 14:27:04 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 5 Aug 2026 14:27:03 +0800
Message-ID: <97948333-9e42-4443-8297-ed6c3455bac6@huawei.com>
Date: Wed, 5 Aug 2026 14:27:02 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] nbd: clear queue limits on disconnect
From: yangerkun <yangerkun@huawei.com>
To: <josef@toxicpanda.com>, <axboe@kernel.dk>, <hch@lst.de>,
	<yukuai@kernel.org>
CC: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>,
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>,
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, <nbd@other.debian.org>
References: <20260804083922.1927105-1-yangerkun@huawei.com>
 <20260804083922.1927105-4-yangerkun@huawei.com>
In-Reply-To: <20260804083922.1927105-4-yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2026/8/4 16:39, Yang Erkun 写道:
> An inactive nbd device may refuse any I/O operations. The nbd_config_put
> function calls invalidate_disk, which sets the device capacity to zero
> to reject all read and write I/O. For zero-sector flush I/O requests
> from blkdev_issue_flush, if the write cache is disabled, the zero-sector
> flush I/O immediately returns 0 in submit_bio_noacct. However, since
> nbd_config_put does not clear the write cache state, an inactive nbd
> device might still have the write cache enabled. In this situation,
> zero-sector flush I/O will return -EIO because there is no active socket.
> Additionally, BLK_FEAT_FUA and BLK_FEAT_ROTATIONAL flags may also remain
> stale, resetting all of them ensures consistent behavior.
> 
> The limits update uses queue_limits_commit_update() (the non-freezing
> variant) because config_refs == 0 here means every fd is closed and recv
> threads have drained, so no in-flight I/O can read q->limits concurrently.
> 
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>   drivers/block/nbd.c | 43 ++++++++++++++++++++++++++-----------------
>   1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 7ec85f94f742..45e58191c5d7 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -331,6 +331,26 @@ static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
>   	nsock->sent = 0;
>   }
>   
> +static void nbd_apply_limits(struct queue_limits *lim, u32 flags)
> +{
> +	lim->features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA | BLK_FEAT_ROTATIONAL);
> +	lim->max_hw_discard_sectors = 0;
> +	lim->max_write_zeroes_sectors = 0;
> +
> +	if (flags & NBD_FLAG_SEND_TRIM)
> +		lim->max_hw_discard_sectors = UINT_MAX << SECTOR_SHIFT;

I am so sorry there is a mistake here... Should be UINT_MAX >> SECTOR_SHIFT

> +	if (flags & NBD_FLAG_SEND_FLUSH) {
> +		lim->features |= BLK_FEAT_WRITE_CACHE;
> +		if (flags & NBD_FLAG_SEND_FUA)
> +			lim->features |= BLK_FEAT_FUA;
> +	}
> +
> +	if (flags & NBD_FLAG_ROTATIONAL)
> +		lim->features |= BLK_FEAT_ROTATIONAL;
> +	if (flags & NBD_FLAG_SEND_WRITE_ZEROES)
> +		lim->max_write_zeroes_sectors = UINT_MAX >> SECTOR_SHIFT;
> +}
> +
>   static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize)
>   {
>   	struct queue_limits lim;
> @@ -352,23 +372,7 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize)
>   		return 0;
>   
>   	lim = queue_limits_start_update(nbd->disk->queue);
> -	if (nbd->config->flags & NBD_FLAG_SEND_TRIM)
> -		lim.max_hw_discard_sectors = UINT_MAX >> SECTOR_SHIFT;
> -	else
> -		lim.max_hw_discard_sectors = 0;
> -	if (!(nbd->config->flags & NBD_FLAG_SEND_FLUSH)) {
> -		lim.features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA);
> -	} else if (nbd->config->flags & NBD_FLAG_SEND_FUA) {
> -		lim.features |= BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA;
> -	} else {
> -		lim.features |= BLK_FEAT_WRITE_CACHE;
> -		lim.features &= ~BLK_FEAT_FUA;
> -	}
> -	if (nbd->config->flags & NBD_FLAG_ROTATIONAL)
> -		lim.features |= BLK_FEAT_ROTATIONAL;
> -	if (nbd->config->flags & NBD_FLAG_SEND_WRITE_ZEROES)
> -		lim.max_write_zeroes_sectors = UINT_MAX >> SECTOR_SHIFT;
> -
> +	nbd_apply_limits(&lim, nbd->config->flags);
>   	lim.logical_block_size = blksize;
>   	lim.physical_block_size = blksize;
>   	error = queue_limits_commit_update_frozen(nbd->disk->queue, &lim);
> @@ -1469,8 +1473,13 @@ static void nbd_config_put(struct nbd_device *nbd)
>   	if (refcount_dec_and_mutex_lock(&nbd->config_refs,
>   					&nbd->config_lock)) {
>   		struct nbd_config *config = nbd->config;
> +		struct queue_limits lim;
>   		nbd_dev_dbg_close(nbd);
>   		invalidate_disk(nbd->disk);
> +		/* reset queue limits to default */
> +		lim = queue_limits_start_update(nbd->disk->queue);
> +		nbd_apply_limits(&lim, 0);
> +		queue_limits_commit_update(nbd->disk->queue, &lim);
>   		if (nbd->config->bytesize)
>   			kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
>   		if (test_and_clear_bit(NBD_RT_HAS_PID_FILE,

