Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B473113D891;
	Sun,  3 May 2026 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777806540; cv=none; b=pUom7l6bT0a1c+aTNSoZfwE2eQDOv4+FdnZOlzp4resdoiBV+k3ZTh6fVoOKulWFByIboxkq/VCzecRZfmIBUdu9J8vYRoMtlLj9OvMDzkzJKSo8WFrAWJ7ymxtSslAwlDE8e8kcxIX/7gOzW/BKAXUzK1Bv4iDyBBO+7kaNEcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777806540; c=relaxed/simple;
	bh=T4liqSNyfhqqx4IuluvXA4Y0fx5sInlzola2gG/iXx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmiA7s37iSxo8T0CRWIwHEf0rXR0XR7SC0MuQmpvmAU+69UvkpImqSAp66LcJkEMPYHSC0UXDEAaKmeeXI67q9UcPW8/jWpozzxdSfo/q2s3Lo0X7JpH9cmWZAu6PlHmxJl+5gUeat2fj6uZeCvXN+CU+ysLJQNWH5K89jh2ISc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vMscr7YM; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vMscr7YM"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g7hqG0pV6zlgtd0;
	Sun,  3 May 2026 11:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1777806534; x=1780398535; bh=Gc3vf0oTsrBP5r4gguorIwCT
	NwM99bsgKjg74B49dKc=; b=vMscr7YMZQMMxHyKUuyPtHXwXeE4W67BPxtVSGKh
	3x5NaUjXRBuFHOoGOW3/WdoHzEmZH+lYOUJWPw5eQrftpAKv0wMGvj2/3DakU058
	89ilyeW88VQB4rJ2qCxNDTzm9hn8m+pJQ4HDEItvlBjGZLQ+T1mcC+qzDt5E7nRZ
	yKSVZhESjvdx/hK2ZAS3KDOjapBjYnBgcNIVBRpBb40z//OoCH4J+eKwb/8LpdtG
	daOJOiYwRP1bxC5PZ6Euin3vGGujP5QPpRUB2G5NhiouccIOQGxmVUNhOUWv00fz
	MsILaObFONIDPfMm6tTFoT9Pc2qNy/Meu7yIrWgdMH9phA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IYmczv1KkU_P; Sun,  3 May 2026 11:08:54 +0000 (UTC)
Received: from [10.211.8.206] (unknown [213.147.98.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g7hq63fFXzlgr41;
	Sun,  3 May 2026 11:08:49 +0000 (UTC)
Message-ID: <8abcd4ec-3e62-49d8-8657-f1a1ca925fba@acm.org>
Date: Sun, 3 May 2026 13:08:47 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blktrace: reject buf_size smaller than blk_io_trace2
To: Deepanshu Kartikey <kartikey406@gmail.com>, axboe@kernel.dk,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260503085519.138360-1-kartikey406@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260503085519.138360-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/3/26 10:55 AM, Deepanshu Kartikey wrote:
> blk_trace_setup() accepts any non-zero buf_size from
> userspace and passes it directly to relay_open(). If
> buf_size is smaller than sizeof(struct blk_io_trace2),
> relay_reserve() always returns NULL and all trace
> events are silently dropped.

That's the intended behavior, isn't it?

> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 8cd2520b4c99..20f941495151 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -773,7 +773,7 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>   	if (ret)
>   		return -EFAULT;
>   
> -	if (!buts.buf_size || !buts.buf_nr)
> +	if (buts.buf_size < sizeof(struct blk_io_trace2) || !buts.buf_nr)
>   		return -EINVAL;
>   
>   	buts2 = (struct blk_user_trace_setup2) {

We may be better off not changing this code because there may be users 
who rely on the current behavior and who will report this change in
behavior as a regression.

Thanks,

Bart.
