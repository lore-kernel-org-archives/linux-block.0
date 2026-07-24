Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52743EDE77;
	Fri, 24 Jul 2026 21:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927773; cv=none; b=fDipWt6vs1eTjWROIjKNTi3GSNRXxJyeHUPj1NapJK/s7zd7lX1fYAk1avslL4bssaWi4pSLM2B5KHbpGcNPt+trW7mKmnqRPDMYwAKHZRlaXF3mA/4ivpgS6Llm6wwoNTDHVdak1KHHVq9H6hu6S5uRoIJyhFqaW1tB+Odvsd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927773; c=relaxed/simple;
	bh=49Jsa6TSufuApX1v1B9niAScIfPb1lgZo7oMj1mE+jE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+LE+g0+y/6Ta0u9yC8HxDB86GJH8+lS9zOjOux5SJX2Uc5ng4B3KGulE8o1NhflmDjR2fds/hR1A4WAZyeZmFg+BpppD8UsgdafGzVxGK3WgbprptTrmXoPVb3/Qjc87FEZdJyqPXmFGNwL7tp2h/xmB7lYixzPl+lP7dFvIpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=g+ZmKSfH; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="g+ZmKSfH"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4h6LQ35nbQz1XM4Tn;
	Fri, 24 Jul 2026 21:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1784927765; x=1787519766; bh=wm/Y7puwu6OFnzxn9rAksSi6
	ksgugu85bXB309vd0jI=; b=g+ZmKSfHuY6G0KqT7dqd0ivw4dje/oBfEBVp22aM
	cWQGNVTbzTAysB4R+hURyyhYrm8CbzV1Saspj6IQslQQO59w7O4Z34aKffWPRXJB
	0+QNV5oafMItjMf6XLm1g0IlMP5kbJELBOhTb1N/43I9xJ1vWhDf18nMwl8WWmrc
	6qkqwv1lnK+i/BhqtW6dCti5gW7n0i6UTXkEh7jYE7+nbHhBVlkCdJScunE2/xVh
	C1WiRTcnqoGTzWmnNGaFabZEKVMzXKgNf9sL3xR0xiURHG3uuj1zO7tYSHlTmkPk
	UkdPcjj1mhJ7gs+JLqRswvZkSFTWd4tDtw7hvgPd1A2Rsg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fbaGJMs_t4Pu; Fri, 24 Jul 2026 21:16:05 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4h6LPs6zCNz1XM4TB;
	Fri, 24 Jul 2026 21:16:01 +0000 (UTC)
Message-ID: <30c062e3-1f8b-43a9-8c85-4bc86cd74336@acm.org>
Date: Fri, 24 Jul 2026 14:16:00 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 9/9] null_blk: serialize configfs attribute shows with
 the file-scope lock
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
 nilay@linux.ibm.com, kch@nvidia.com, johannes.thumshirn@wdc.com,
 kbusch@kernel.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260714041805.1088702-1-wozizhi@huaweicloud.com>
 <20260714041805.1088702-10-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260714041805.1088702-10-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/13/26 9:18 PM, Zizhi Wo wrote:
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 67cd32d28887..c8487a630e1a 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -345,8 +345,14 @@ static ssize_t nullb_device_bool_attr_store(bool *val, const char *page,
>   static ssize_t								\
>   nullb_device_##NAME##_show(struct config_item *item, char *page)	\
>   {									\
> -	return nullb_device_##TYPE##_attr_show(				\
> +	ssize_t ret;							\
> +									\
> +	mutex_lock(&lock);						\
> +	ret = nullb_device_##TYPE##_attr_show(				\
>   				to_nullb_device(item)->NAME, page);	\
> +	mutex_unlock(&lock);						\
> +									\
> +	return ret;							\
>   }									\
>   static ssize_t								\
>   nullb_device_##NAME##_store(struct config_item *item, const char *page,	\
> @@ -479,7 +485,13 @@ NULLB_DEVICE_ATTR(badblocks_partial_io, bool, NULL);
>   
>   static ssize_t nullb_device_power_show(struct config_item *item, char *page)
>   {
> -	return nullb_device_bool_attr_show(to_nullb_device(item)->power, page);
> +	ssize_t ret;
> +
> +	mutex_lock(&lock);
> +	ret = nullb_device_bool_attr_show(to_nullb_device(item)->power, page);
> +	mutex_unlock(&lock);
> +
> +	return ret;
>   }

The above changes would be much more elegant if guard()() would be used 
instead of explicit mutex_lock() and mutex_unlock() calls.

Thanks,

Bart.
