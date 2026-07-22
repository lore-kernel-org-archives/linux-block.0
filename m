Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E1345EDF;
	Wed, 22 Jul 2026 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784742275; cv=none; b=FyT9oE5IjstXTizek8yQI7rDkoQM3vKpmDXYpePQheGOfdclvyUYMatwItnyNroA9Hc9PmcC4lmfQ+trhDcPSI08ZLgqGPtsuoeKBdaz0BkbBIEHqZB5L8uZUv+R0swCJ+QJYvfkJ7OpWRuhfePiw51J7+BEwSECGUnXFWNnrvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784742275; c=relaxed/simple;
	bh=GhXyyqCSbwdPauQCxggFmDGHyi/5SzNmjKhdTF4cp3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trlf4mg4u79xOl708kCrzAUVtIqI5BXd91FEci5uvHjhgf4N1YolLApTjTzHPDHEIKbPvQFCvR1bRifh8nPCnaldCEMdSOvOCtEwa345CmYU8G3S2IMLVUL71tYksqtHJb27zT014iaas0LGGjmnVokHsMCj148TxdlgDwJLkfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2zI2mLo/; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2zI2mLo/"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4h51pn5SLqz1XM6JW;
	Wed, 22 Jul 2026 17:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1784742271; x=1787334272; bh=eCgBdiwHc05/Nzk4yzjAqgnd
	zMUH/E/riEl947dL7rk=; b=2zI2mLo/pKIhSFbBhCStTKEQwkNtwz8q7ZNIcCmo
	BIIkIBTQSGxyFR5IGqIARfjz+66RnvPCsYikG+F/HhN92iBzWIuajN4vxQFdxF87
	y73nAI0/mg+pKMM/zGW82JBnQvp2kyPdXH9KDKm70kf+bHn71pgfcqhJZaDpUEjG
	XeCZyIYwDWOKlTkquCRkugE8oRZlTXbIwZkLLVrhLXpT8KgMDw4V7MtoNH4tg4Bb
	W/8UerAZ6DQX/JIhq9uTuYf8vcgnenxhgjo9+9SnskAnbbpXgR8jWYYyn8gzd0He
	ImQX1K842qGXMrdaDIYbbWCiYDkSb63+G8dBPhcvmxCL+Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QFyTvQZbBOWt; Wed, 22 Jul 2026 17:44:31 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4h51pk21sJz1XM6JT;
	Wed, 22 Jul 2026 17:44:29 +0000 (UTC)
Message-ID: <84d487e9-8350-4427-8d38-68ff6d0bf17a@acm.org>
Date: Wed, 22 Jul 2026 10:44:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] block/mq-deadline: hold elevator_lock in debugfs
 next_rq show
To: Xixin Liu <liuxixin@kylinos.cn>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org
References: <2e689b2c4021.1784615432.git.liuxixin@kylinos.cn>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2e689b2c4021.1784615432.git.liuxixin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/20/26 11:30 PM, Xixin Liu wrote:
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 824bfc17b2c6..e7c4a91b2d08 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -842,14 +842,22 @@ static int deadline_##name##_next_rq_show(void *data,			\
>   					  struct seq_file *m)		\
>   {									\
>   	struct request_queue *q = data;					\
> -	struct deadline_data *dd = q->elevator->elevator_data;		\
> -	struct dd_per_prio *per_prio = &dd->per_prio[prio];		\
> +	struct elevator_queue *e;					\
> +	struct deadline_data *dd;					\
> +	struct dd_per_prio *per_prio;					\
>   	struct request *rq;						\
> +	int ret;							\
>   									\
> +	ret = mutex_lock_interruptible(&q->elevator_lock);		\
> +	if (ret)							\
> +		return ret;						\
> +	e = q->elevator;						\
> +	if (!e)								\
> +		goto unlock;						\
> +	dd = e->elevator_data;						\
> +	per_prio = &dd->per_prio[prio];					\
>   	rq = deadline_from_pos(per_prio, data_dir,			\
>   			       per_prio->latest_pos[data_dir]);		\
>   	if (rq)								\
>   		__blk_mq_debugfs_rq_show(m, rq);			\
> +unlock:									\
> +	mutex_unlock(&q->elevator_lock);				\
>   	return 0;							\
>   }
>   

The above patch uses the wrong lock and brings way too much code under
the lock. Please help with testing this patch:

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 6e8f87e07eb9..c52601c1fa13 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -850,6 +850,7 @@ static int deadline_##name##_next_rq_show(void 
*data,			\
  	struct dd_per_prio *per_prio = &dd->per_prio[prio];		\
  	struct request *rq;						\
  									\
+	guard(spinlock)(&dd->lock);					\
  	rq = deadline_from_pos(per_prio, data_dir,			\
  			       per_prio->latest_pos[data_dir]);		\
  	if (rq)								\

