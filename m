Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14AD30171C;
	Sat,  4 Jul 2026 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783171550; cv=none; b=d9fKCm6Qb2kr+S+pUeWJCa13NLdqaqBVLHJItosGahmMElq+d0shiuLxO4Kbd+5SXg3Zp0Uzuo0UTaGOFpExRYDI+Fm00AUO9KOkiO/BX2/0ByHN93Mmtggvxr04O7prybumB314cuXdt5g5DX6EQ2SAKkJmznR5Ph2r42+4pYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783171550; c=relaxed/simple;
	bh=u6w5l0aglC7GnyP5zpmKbVmF/YHbOxqdYVZB1SSdjxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mg3jZCZKVaaHVx5oBqMSXvOKrxkY1i9ESWGQtX0SoeTsQilZb44Y1Gk/EcB19axQuZJANF2fMS1hwFPcJkAq8w3+Preur3TFaRxf8OG/LP4vK9bwNVf9cDlqEQzULZut2TKVr0CHpMhlckmFvbvXWoujDd6Jz8zEWCMoHv/HM3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gfGOfJyF; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gfGOfJyF"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gsrwX2Xwnz1XM6J5;
	Sat,  4 Jul 2026 13:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783171543; x=1785763544; bh=pQ6FpIeZ/GHZwuHLQGGYVcug
	GxwpKuSkWJ/dnMyKVHQ=; b=gfGOfJyFOC+PSHA13ClOh94f0KLEHkwNBQ5bkxPy
	S448oZ6vc6y+a1id5CDunB7/1tAkpf/z6ena+ix9tEQWzV9nRlOVpDqucHbNI/sC
	HMvKhJHLze73Dyu4aDrx05IHokEx12xfF5C87hF1v0qQKz7SZMv9FnQ7B1OCy0Hf
	MEmvBk9ZADtc60sLekBBlWiVUSCWQMnvtvjIEUF3HuVqOtZDV9YpTOdeUi2A6zta
	RrjawU7/fF7BsqHWN5GgkSSiNl577cvc1tQDZr4TlZnGtiOivbRJz2wudGAlYi6O
	jJ0BB2sGwQ5oO535utq/TARdtTzAJWYXaJMnxKt9MmweQA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id f-wSwmIrPBGn; Sat,  4 Jul 2026 13:25:43 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gsrwM0VpBz1XM5kt;
	Sat,  4 Jul 2026 13:25:38 +0000 (UTC)
Message-ID: <33ec54bf-b6b5-466b-82fb-f05b133336c9@acm.org>
Date: Sat, 4 Jul 2026 06:25:38 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: initialize lock mutex before registering
 configfs subsystem
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
 nilay@linux.ibm.com, linux-block@vger.kernel.org, kch@nvidia.com,
 johannes.thumshirn@wdc.com, kbusch@kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260704092323.748772-1-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260704092323.748772-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index f8c0fd57e041..98616d290c5c 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -2161,13 +2161,12 @@ static int __init null_init(void)
>   
>   	config_group_init(&nullb_subsys.su_group);
>   	mutex_init(&nullb_subsys.su_mutex);
> +	mutex_init(&lock);
>   
>   	ret = configfs_register_subsystem(&nullb_subsys);
>   	if (ret)
>   		return ret;
>   
> -	mutex_init(&lock);
> -
>   	null_major = register_blkdev(0, "nullb");
>   	if (null_major < 0) {
>   		ret = null_major;

Why an explicit mutex_init() call instead of changing "static struct
mutex lock" into "static DEFINE_MUTEX(lock)"? Additionally, shouldn't
the "lock" name be made more descriptive since it has file scope?

Thanks,

Bart.
