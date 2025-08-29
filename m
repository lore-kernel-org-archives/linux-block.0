Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF55E30CD9F;
	Fri, 29 Aug 2025 04:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756442322; cv=none; b=CSzPDvC9JsKB4Lxb76vvvWdaOxlfE689QRBU+5zZRu1baitkl23R5skv3xaTdCfqFxPhgBhMkrcOMAgp0IxPlDX0HTtWteokBCZHFK4sjJjsbRqQqJ1rccdBijnkyS0nCDm1S/yKb6BJ17zfMLQiPOAShtahx23zBqYMJb0K4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756442322; c=relaxed/simple;
	bh=kR47r7+cZe1DzINd4XA4apwTZcOc4Rqjsr0w0We2qGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbtRsQSLAJFCdKSXF0QGB7UxJKXbM/ZKgDDG0gjEA7NHbgijMjo0XdppBtlvfd5Qehe3Z3YVWzD0lGSG4igvoo9T7MdJ8tNE2Kd+NJ6MGYEaKeJf/hoxKalDpLGIORMbN0LysGbMthO6vexfUhhe97baGWFuC65yJYZe/is/mBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WI81Mo1b; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WI81Mo1b"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cClrv4V8tzltPtf;
	Fri, 29 Aug 2025 04:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1756442318; x=1759034319; bh=IaPSaBw2KwMcDI1oubljBKPZ
	1q5dOYR2yWs8+LQ+2iw=; b=WI81Mo1bKW4UckaLrlytM6X1pG4i/tjylT1z99Aj
	d3dSbIyIN6+Uxvqozkc7LJk424zJ6Vxrn5h0xl8wJy4zZ7UH9FYhQMhOnYpiBO2m
	HVOvRf//3lNEsQc6sCg4j8LUIqCwhPSJTeWUHmqOLiS3G6dJKksyGVIBbsZa5/OC
	F1Yl4HXFqeEJnrUoMdVPstRBXiyBteu3SNyo0tixWe+zz552Qj5U20Vyk+MInxbO
	0ZPnmO0SyXPUt0feYhsxLX8mJ3tWuEkJNiuwh6kSb91hGkuWrFH0ldCswaKwvC1c
	4su4TZ9JgPAtpwsvF+/KtF9qZQljHF+2ci32a8OUrHg8Fg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id raeT_GyE74iU; Fri, 29 Aug 2025 04:38:38 +0000 (UTC)
Received: from [172.20.6.188] (unknown [208.98.210.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cClrn3c1mzltM5Z;
	Fri, 29 Aug 2025 04:38:31 +0000 (UTC)
Message-ID: <62c9b68f-6adc-41d8-b504-4bce4d721e64@acm.org>
Date: Thu, 28 Aug 2025 21:38:24 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/mq-deadline: Replace DD_PRIO_MAX with DD_PRIO_COUNT
To: chengkaitao <pilgrimtao@gmail.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 chengkaitao <chengkaitao@kylinos.cn>
References: <20250829015444.91369-1-pilgrimtao@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250829015444.91369-1-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 6:54 PM, chengkaitao wrote:
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index b9b7cdf1d3c9..1a031922c447 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -41,19 +41,16 @@ static const int fifo_batch = 16;       /* # of sequential requests treated as o
>   enum dd_data_dir {
>   	DD_READ		= READ,
>   	DD_WRITE	= WRITE,
> +	DD_DIR_COUNT	= 2
>   };
>   
> -enum { DD_DIR_COUNT = 2 };
> -

This change is not an improvement in my opinion because it makes it
less clear what the role of DD_DIR_COUNT is.

>   enum dd_prio {
> -	DD_RT_PRIO	= 0,
> -	DD_BE_PRIO	= 1,
> -	DD_IDLE_PRIO	= 2,
> -	DD_PRIO_MAX	= 2,
> +	DD_RT_PRIO,
> +	DD_BE_PRIO,
> +	DD_IDLE_PRIO,

There is code that depends on DD_RT_PRIO < DD_BE_PRIO < DD_IDLE_PRIO so 
I'd like to keep the explicit enum values.

> +	DD_PRIO_COUNT
>   };
>   
> -enum { DD_PRIO_COUNT = 3 };

I see the above change as a step backwards because it makes the role of
DD_PRIO_COUNT less clear.

> -	for (prio = DD_BE_PRIO; prio <= DD_PRIO_MAX; prio++) {
> +	for (prio = DD_BE_PRIO; prio < DD_PRIO_COUNT; prio++) {

The current code is easier to read IMHO than the new code.

Thanks,

Bart.
