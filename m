Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5251E51EE;
	Thu,  9 Oct 2025 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028656; cv=none; b=MZhGaBDnmJHC6nnIZnJCzR3LrJP3nXeO4qt0s0dqNVk0IbWnd0yCc+UCn4yTjsw7IIi2NWVHqi6wYxlLiXslWgLB/gI0zkGTKXlp7D63pj6Bq2vfzFMCoCTsclYDsuAEoLUpEt79a8uZqEGzPEWGRDBN/Z6bD8nDGey8nqFn7EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028656; c=relaxed/simple;
	bh=NYi5PAvlfnKY1DvsY5vuZzaGmwqQOQ9FHnu1NBXQeoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IO1KBmGu9Vk5xw8UP10szRnUx3lpjWDuirtuh+26zklun3aX6sST9aglfjcvg7qPPeBDyF6An5Lkh45mKNDRBQgfdOK9JJ+H0Bq4srGz5MYRXDXZuLuVm9yWHLi+AgzC3/s5o/W9ojn7R4lpuIIt+EKZ24IVmKb8T79H68lX4F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Sa1ikTbF; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Sa1ikTbF"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cjG8l3NvSzm0ytC;
	Thu,  9 Oct 2025 16:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1760028646; x=1762620647; bh=/GOWrB6jzDLFvXNtk0gb/YYh
	jQAdm2THxLGGEUr+Uvw=; b=Sa1ikTbFVOWoL5UYuOfhlORuK1dRdutGahS5fwsO
	2U7+6fB17Odwr2us4eHd1UvnJOxTB74HBNGg/q+2O/tFETLc+xS7/apDUa672uJY
	uVwP/ns7S7PRtLbkNbIbVafT9Z55T5fCdJEShfgReMsGeaszpsgyRJaEOIo5mARR
	MdyoWnwNAwvtIo/iky/zK3ezBK9YJ5BLhcAb3Zhg7ZXeJljldR/45Ojf0jfqTWqA
	jXqduenD39qn03VyYhBbrDmfLr+K1AbuKsH5+6NU/8FtvxOBoYGhR4b27ro6e0IW
	f72jCvL5JqixVVLjsTvC5T8hh+6mfJBVb70lJko/NyxWbg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XXitJ0JI_MUQ; Thu,  9 Oct 2025 16:50:46 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cjG8d5L7Zzm0ytk;
	Thu,  9 Oct 2025 16:50:40 +0000 (UTC)
Message-ID: <db87a85d-e433-4daf-97c7-d5156849db0f@acm.org>
Date: Thu, 9 Oct 2025 09:50:39 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block/mq-deadline: adjust the timeout period of the
 per_prio->dispatch
To: chengkaitao <pilgrimtao@gmail.com>, axboe@kernel.dk, dlemoal@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chengkaitao <chengkaitao@kylinos.cn>
References: <20251009155253.14611-1-pilgrimtao@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251009155253.14611-1-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/25 8:52 AM, chengkaitao wrote:
> On the other hand, the Commit (725f22a1477c) merges the effects of
> fifo_expire and prio_aging_expire on the same code behavior, creating
> redundant interactions. To address this, our new patch introduces
> numerical compensation for {dd->fifo_expire[data_dir]} when adding
> requests to dispatch lists. To maintain original logic as much as
> possible while enhancing dispatch list priority, we additionally
> subtract {dd->prio_aging_expire / 2} from the fifo_time, with default
> values, {dd->prio_aging_expire / 2} equals {dd->fifo_expire[DD_WRITE]}.

No assumptions should be made about the relative values of
dd->prio_aging_expire and dd->fifo_expire[DD_WRITE] since these values
can be modified via sysfs.

> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 3e741d33142d..fedc66187150 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -659,7 +659,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>   
>   	if (flags & BLK_MQ_INSERT_AT_HEAD) {
>   		list_add(&rq->queuelist, &per_prio->dispatch);
> -		rq->fifo_time = jiffies;
> +		rq->fifo_time = jiffies + dd->fifo_expire[data_dir]
> +				- dd->prio_aging_expire / 2;
>   	} else {
>   		deadline_add_rq_rb(per_prio, rq);

Thanks for having added a detailed patch description. Please remove
"/ 2" from the above patch to make sure that BLK_MQ_INSERT_AT_HEAD
requests are submitted to the block driver before other requests. This
is important if a request is requeued. Additionally, a comment should be
added above the modified line of code that explains the purpose of the
calculation. How about this untested patch?

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 3e741d33142d..566646591ddd 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -659,7 +659,14 @@ static void dd_insert_request(struct blk_mq_hw_ctx 
*hctx, struct request *rq,

  	if (flags & BLK_MQ_INSERT_AT_HEAD) {
  		list_add(&rq->queuelist, &per_prio->dispatch);
-		rq->fifo_time = jiffies;
+		/*
+		 * started_after() subtracts dd->fifo_expire[data_dir] from
+		 * rq->fifo_time. Hence, add it here. Subtract
+		 * dd->prio_aging_expire to ensure that AT HEAD requests are
+		 * submitted before higher priority requests.
+		 */
+		rq->fifo_time = jiffies + dd->fifo_expire[data_dir] -
+				dd->prio_aging_expire;
  	} else {
  		deadline_add_rq_rb(per_prio, rq);

Thanks,

Bart.
