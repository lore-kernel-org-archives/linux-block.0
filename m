Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEA73D79E9
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963430; cv=none; b=otMbHhZr9oyjh9uqMZ6+9M2jzKyrqOGFsymBDwLZQGBiGofCybkhEAYI2LCfD+INebwRvQz5G7knEzu4AGwMKCFlcS5C6v3cMfO5+Gqnc0MqCbLNX+65pga+lwSS0hUOHaVWXQmg3a3JMKMU5MXLa0mEvvOwjXfA54iFWRrsqTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963430; c=relaxed/simple;
	bh=aumyFFwkemCDdr7E1AxUs2HzKJCAnrXd8WLinwCdIms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+ikDHVLK/h99wuXiPgS0LGutAkSgCSOe89maIJ8Ze6Zl/+PBu+nlElIpzwIyAheGAtYuIIbsUvOCxzyqYIB3zWP7fkpMoL9EsgV48YN0fNAj1H/yn2FxrlGagvjAqMPkd7Xi1Aq5KWodd3NBO/F+2tXjXgobOr5hYqsu7LXpJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=BZ2V/BoW; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="BZ2V/BoW"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hFjKx5l9lzlfvpy;
	Wed,  5 Aug 2026 20:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1785963187; x=1788555188; bh=FtARwnAW34jCTabJf+9NEItO
	TOh6DobvqL7P+oRh02c=; b=BZ2V/BoWQ2H+8hDeHyZuJQcdgrZw3nj8p0+MS3a3
	u8/AAQfsPGTpqTSTTlBYvhU74ZxcGXxDG0yKc0ALACPF88tIYP5VcqNFdjsQcqZL
	foWyCUBuMkfFjG6mfbfe3GTVe8XV04RQ4VU1xo7+AdC8ptNldMUVKqqfTAvi3/d6
	gKxxOkAFrUU/YEi6B64umk7k+njLgYbRiXRY74aZyi6COFlHiQbuKDISW6XX2qvY
	uJReqQ1Mtyp52xCf7REGmDYevUJ2bMFrtPc0toi/yz7E5vZvptAARcUbW7GItgP0
	CKzYbnqOdL0hJv/qpRsm+7wPjklD3TXMsFq2Ebk04tqOBQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9rRw1vl2DM5h; Wed,  5 Aug 2026 20:53:07 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hFjKt1z3JzlfvpN;
	Wed,  5 Aug 2026 20:53:05 +0000 (UTC)
Message-ID: <c7e9ffab-468a-430f-b64b-a385ce0c282b@acm.org>
Date: Wed, 5 Aug 2026 13:53:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] block: remove disk_free_zone_resources()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260805022719.735323-1-dlemoal@kernel.org>
 <20260805022719.735323-2-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260805022719.735323-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/26 7:27 PM, Damien Le Moal wrote:
>   destroy_pool:
>   	mempool_destroy(disk->zone_wplugs_pool);
>   	disk->zone_wplugs_pool = NULL;
> +stop_worker:
> +	kthread_stop(disk->zone_wplugs_worker);
> +	disk->zone_wplugs_worker = NULL;
>   free_hash:
>   	kfree(disk->zone_wplugs_hash);
>   	disk->zone_wplugs_hash = NULL;

With this patch applied the kernel thread and workqueue are created
after the mempool has been created. Shouldn't the kthread_stop() call
occur before the mempool_destroy() call such that the mempool is
destroyed if workqueue allocation fails?

Thanks,

Bart.
