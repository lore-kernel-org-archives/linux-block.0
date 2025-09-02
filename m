Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7860D322775;
	Tue,  2 Sep 2025 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829005; cv=none; b=GN4Viz7bRLPhw80OkFahfDdZYjsEHHSs/UdU+NHCg5r8HcfPtDVFlqJqG3c9Qr3W+3lSoIgidBtB9TSm2S9/SgqjZpg8PW1V69xNKFjFGCY0quNmb4JcTitFjuMr3nWz/FOcGIkvTNaeYAvDJ10eP6VXndugr/uRFtR0G28Iv8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829005; c=relaxed/simple;
	bh=VguaB0iJUAqfQVHbnBDjVTfLYKDwO5t09siwFQORS8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WKLp9vScLZOhzxF58DTgonJ3a6ffXEKcxujncBO+jfuhXS6x+Ovx9MrRNwuIwUX3b9W/v9Qh8GIuR9I+MUxAbXb/M3JIaDLEMcLPG+1soK1yOALLHHDujOiwyUwsTbS9NZROcJqJfRGK3IGZNx1920YXMYiu36jIwYCcfGAX+tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=31Pl2Ym3; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="31Pl2Ym3"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cGVs02J7Kzm0djF;
	Tue,  2 Sep 2025 16:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1756828993; x=1759420994; bh=9WDGhDQ0YrDyGB1djJuD4ncV
	es60eDmcGGP3MSyD3Ts=; b=31Pl2Ym3fcLIkkKwdEYE7VIZ29NeB8TJ4lO5imKp
	+JseXhqXQ14JC74bCuoR4L/Lr0LzUStzJ9yBet0tn+vAi3rKXMJvqFwzUeF8BRPh
	pqGBc2NarjVb9RrTUl4voQjuqNHJjSSaaJ0ULRGAa5G0Qc9GUjxCxOmqDxvrTf08
	SAb9rkEyDaR3uHlu9bscHBEK7PLJcfGgRDr7PWB3sK1HEpUpvGDzQbpDBe4xwPTF
	sIGIMX9d5kRYkDT6uqJPHrCkrxXfQyzX/SaE7bPGV6sJxUlfoF35xvi2jYAd8jPc
	g/0zgP4BumY7uCoPYFypnLHeWz7CtC4YdYVNf21FOQFFGg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id pDmgZPLVVovA; Tue,  2 Sep 2025 16:03:13 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cGVrt0d6Tzm0XCl;
	Tue,  2 Sep 2025 16:03:09 +0000 (UTC)
Message-ID: <51d863a4-fe0a-4a08-a3a5-dd7b402ce824@acm.org>
Date: Tue, 2 Sep 2025 09:03:08 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: use int type to store negative value
To: Qianfeng Rong <rongqianfeng@vivo.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20250902130930.68317-1-rongqianfeng@vivo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250902130930.68317-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/25 6:09 AM, Qianfeng Rong wrote:
> Change the 'ret' variable in blk_stack_limits() from unsigned int to int,
> as it needs to store negative value -1.
> 
> Storing the negative error codes in unsigned type, or performing equality
> comparisons (e.g., ret == -1), doesn't cause an issue at runtime [1] but
> can be confusing.  Additionally, assigning negative error codes to unsigned
> type may trigger a GCC warning when the -Wsign-conversion flag is enabled.
> 
> No effect on runtime.
> 
> Link: https://lore.kernel.org/all/x3wogjf6vgpkisdhg3abzrx7v7zktmdnfmqeih5kosszmagqfs@oh3qxrgzkikf/ #1
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>   block/blk-settings.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index d6438e6c276d..693bc8d20acf 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -763,7 +763,8 @@ static void blk_stack_atomic_writes_limits(struct queue_limits *t,
>   int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>   		     sector_t start)
>   {
> -	unsigned int top, bottom, alignment, ret = 0;
> +	unsigned int top, bottom, alignment;
> +	int ret = 0;
>   
>   	t->features |= (b->features & BLK_FEAT_INHERIT_MASK);

Has it been considered to add a Fixes tag, e.g. this tag?

Fixes: fe0b393f2c0a ("block: Correct handling of bottom device misaligment")

With or without that tag:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>




