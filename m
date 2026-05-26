Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E59405C42
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807595; cv=none; b=JPMPlTzW7SlHqarwVj6XMZD3Y7iODF9Aars/rCSxT1yq2cj9Xo6uR6vXv33gGp+Ihyhsi/x3nT/FE9bQpymNV84eU6ngDEdk6jsAtjYAlzkiMTNjC8RW0cuqgSAybJvXujldC1Qo5RHsPxzmNJIqnSK2ElgEI5dvLe4Zk58pgqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807595; c=relaxed/simple;
	bh=lY5sYqBKb+AtZ4XOmflhgYPgxcRPHPReYfjft5d3W34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUSLUXMygnOGKxnPZ96Ja8V6+8vCv/nqrlSX+QCQzpbXxIftqhTt0rSGF8je7qJ23ldcRELHK54k0VRrPwy5R2+85k6qX2UkXjq8dV8fTBy2tSqS3Dyq7R1cZjRKVEBatMSt//gdC2o8oYrA++2WfXbVWfkFBU8LUdkmDAYm8s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iWeBpD1H; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iWeBpD1H"
Message-ID: <dbb8c50d-6478-466e-baff-20a6aeaca940@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779807581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gw2ho1TBqL0+84U+DbNJSQtrZkTGKWZZmLYfkdK9KKo=;
	b=iWeBpD1HTTjsY/2K5waOx5evkbXYYP64kHhAPU4tOPvs2q0USHj7Lm5tHSxZHVibQoNPoD
	FyPKmNlBUXzU/cRzTp6wS97YMcr5dhwvX1c85qzRg9VWcyxEH3bGIA/I7g2hOwAwIN6KfB
	EOTg6o5En732i7ZWiXoAAxpMILu9op0=
Date: Tue, 26 May 2026 16:59:26 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] block: partitions: fix of_node refcount leak in
 of_partition()
To: Wentao Liang <vulab@iscas.ac.cn>, Jens Axboe <axboe@kernel.dk>,
 stable@vger.kernel.org
Cc: Josh Law <objecting@objecting.org>, Kees Cook <kees@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260526102124.2283846-1-vulab@iscas.ac.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <20260526102124.2283846-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/26/26 12:21, Wentao Liang wrote:
> of_partition() calls of_node_get() on the parent device node at the
> beginning of the function, storing the reference in 'partitions_np'.
> This reference is leaked in two paths:
> 
> 1. The compatibility check at the top of the function returns 0
>     without releasing partitions_np when the node exists but is not
>     "fixed-partitions" compatible.
> 
> 2. The function returns 1 at the end after successfully processing
>     all partitions without releasing partitions_np.
> 
> Fix both leaks by adding of_node_put(partitions_np) on each path.
> 
> Fixes: 2e3a191e89f9 ("block: add support for partition table defined in OF")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Looks good:

Reviewed-by: Md Haris Iqbal <haris.iqbal@linux.dev>

> ---
>   block/partitions/of.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/partitions/of.c b/block/partitions/of.c
> index c22b60661098..53664ea06b65 100644
> --- a/block/partitions/of.c
> +++ b/block/partitions/of.c
> @@ -74,8 +74,10 @@ int of_partition(struct parsed_partitions *state)
>   	struct device_node *partitions_np = of_node_get(ddev->of_node);
>   
>   	if (!partitions_np ||
> -	    !of_device_is_compatible(partitions_np, "fixed-partitions"))
> +	    !of_device_is_compatible(partitions_np, "fixed-partitions")) {
> +		of_node_put(partitions_np);
>   		return 0;
> +	}
>   
>   	slot = 1;
>   	/* Validate parition offset and size */
> @@ -104,5 +106,6 @@ int of_partition(struct parsed_partitions *state)
>   
>   	seq_buf_puts(&state->pp_buf, "\n");
>   
> +	of_node_put(partitions_np);
>   	return 1;
>   }

