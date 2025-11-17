Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E22A299959;
	Mon, 17 Nov 2025 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763423147; cv=none; b=d8js+TXCwef4gmedxiIfwuyojxxZIXvv44JxYdewXxVPsECsdPni+xtko9+MgaO0GyhA+Y832zxEcr9FPTQdwpfNcKUe8veDeFmwoegjXD3pThnmUgo2V0/bG5kBkg0M+suDYIHUZtgL+LMMTU1aW1R21qee9Jm+u4PHwBNiuGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763423147; c=relaxed/simple;
	bh=fSrzL469rq5UJzLY4Y4dspONxGp76B9Lzl8uRfX2Kgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iot8XtrGt9Doifnit2nJXoPsDJL9k25vs2ci0utkpzi6z82Iep0OVwVtgGSs+GSdQnDBAjK08euU/P+j/sJemd55GM0eNaQz9R/FtZ1QKKIw+tSgXeD0ThAQ5v/ZlJFRrtRROs/gNIwqGjmZBxEakBSud/TO42t8TFNgYBE2RO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rGm8wVAv; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rGm8wVAv"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d9PWY14pmzlv4Vf;
	Mon, 17 Nov 2025 23:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1763423143; x=1766015144; bh=1r2Y5HDZXyyu9gW8fJQLxunD
	SDvVTAJBOoNfsdF76+s=; b=rGm8wVAvhz1db70SLSJ0XPdnbZwzBxUAizLkdS16
	b8Jec5uRrqoa2jc5txFLl2HEGsLYM3pLYdY5EbQeAg0T0zG9qQSXtm8NCiPrCOMB
	J4q5JDoluaCca3oJgtmfsT2inyR/LyDs4TR+cp3OGcNQnkWEWex3irVDeYewgJ82
	DSSFjp4QSzP/U70zctr93yFwQtp9GBrDlSgZKG7OZPHmxrR/S6MHWzc/b/1bLynu
	FR7mpDblJeOllyL12ucHJT14LsTrKYHSTG8Jd2o2BJbaQ6E9ilBQSuLfPpfDDcB7
	V0WKB6jHoFuW9W3jm2vWKvHy3mTAw8ZRWmhuHA+npSMYTw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DtIn5_1UyuaN; Mon, 17 Nov 2025 23:45:43 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d9PWM1xQqzlv4Dp;
	Mon, 17 Nov 2025 23:45:33 +0000 (UTC)
Message-ID: <4f3ed928-2fef-469d-8bfc-76041267b1c6@acm.org>
Date: Mon, 17 Nov 2025 15:45:32 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 3/7] blk-mq: add a new queue sysfs attribute
 async_depth
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: nilay@linux.ibm.com
References: <20251116035228.119987-1-yukuai@fnnas.com>
 <20251116035228.119987-4-yukuai@fnnas.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251116035228.119987-4-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/25 7:52 PM, Yu Kuai wrote:
> +static void blk_mq_limit_depth(struct blk_mq_alloc_data *data)
> +{
> +	struct elevator_mq_ops *ops;
> +
> +	/* If elevator is none, don't limit requests */

Nobody calls an I/O scheduler an elevator anymore. So I propose to
change "elevator is none" into "no I/O scheduler has been configured".

> +	/*
> +	 * Flush/passthrough requests are special and go directly to the
> +	 * dispatch list, they don't have limit.
> +	 */
"they don't have a limit" -> "are not subject to the async_depth limit".

> +	/*
> +	 * By default, sync requests have no limit, and async requests is
> +	 * limited to async_depth.
> +	 */

"is" -> "are"

 > -		/*
 > -		 * All requests use scheduler tags when an I/O scheduler is
 > -		 * enabled for the queue.
 > -		 */
 > -		data->rq_flags |= RQF_SCHED_TAGS;

Why has the above comment been removed? I think that it is useful.

Additionally, please split this patch into two patches: a first patch
that introduces the function blk_mq_limit_depth() and a second patch
with the remaining changes from this patch.

Thanks,

Bart.

