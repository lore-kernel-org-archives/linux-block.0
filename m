Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE66B631
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 00:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720483978; cv=none; b=sHv6ApMqbclNIXD8/pcDmzghjiTXyIGXMUX6ts1DXAT1Ig0FWpDlaQjBifCcZRPrkDzhAB4M7lTBpyAQzw7mhm60GGkM9yzZbO42gcAz/MFB1Ie1D24sO4UymA5fDwE5EG4CiLIElg7ZOe3O/fGWN63jf2ntrmiYUUcFQdP/dbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720483978; c=relaxed/simple;
	bh=2Gj8s9nZbYCDFARzegS1muqgRrgVAIxf+e0daMnpTIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecX8uDJgcb+SQAa8oDOxrcdi3dMGGXz4qZKherTuz+/AIAII39R5JWPWhhmxqOdS+4MQf8URfnNR8VkW7ztm20PzeESOqA8EilqqL2Qqnp/lbtMngHg43n73oyxM21pT//YsEqRb1TJI+NTm2yif7FR5ZScbO2BRV6IILXFR8x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YWBlJ8nS; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YWBlJ8nS"
X-Envelope-To: john.g.garry@oracle.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720483972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMA7bkz8Stsxvv5DOjBv/YnA9fiCUhmgIbgMYPT3sPk=;
	b=YWBlJ8nS3SGBDalkBYK3CSr+rpG+RSl/HX3Duq2y/sBCEc4iJ1xMgv4u/zfLGyMAZN0fBJ
	V5Hvby+2JHz047wArUn9vnNY1YFM2axa8zLKOTNc5+LywU9Nbl98E5KhXhE3THG1q3v6Sn
	dr4R8W9ax2fDazSebtfag0mtV5Ywni8=
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: mst@redhat.com
X-Envelope-To: jasowang@redhat.com
X-Envelope-To: xuanzhuo@linux.alibaba.com
X-Envelope-To: eperezma@redhat.com
X-Envelope-To: pbonzini@redhat.com
X-Envelope-To: stefanha@redhat.com
X-Envelope-To: hare@suse.de
X-Envelope-To: kbusch@kernel.org
X-Envelope-To: hch@lst.de
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: virtualization@lists.linux.dev
Message-ID: <f92269eb-3664-42ae-83a7-8eb0a3af3f08@linux.dev>
Date: Tue, 9 Jul 2024 02:12:50 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/5] null_blk: Don't bother validating blocksize
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com, hare@suse.de, kbusch@kernel.org,
 hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240708091651.177447-1-john.g.garry@oracle.com>
 <20240708091651.177447-4-john.g.garry@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240708091651.177447-4-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/7/8 11:16, John Garry 写道:
> The block queue limits validation does this for us now.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/block/null_blk/main.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 9d0f6da77601..2f0431e42c49 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1831,9 +1831,6 @@ static int null_validate_conf(struct nullb_device *dev)
>   		dev->queue_mode = NULL_Q_MQ;
>   	}
>   
> -	if (blk_validate_block_size(dev->blocksize))
> -		return -EINVAL;

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks,
Zhu Yanjun

> -
>   	if (dev->use_per_node_hctx) {
>   		if (dev->submit_queues != nr_online_nodes)
>   			dev->submit_queues = nr_online_nodes;

