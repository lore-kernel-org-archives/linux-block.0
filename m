Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079621E832A;
	Mon,  8 Dec 2025 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765211062; cv=none; b=qDmaFEph9lfEq+XSP6nYN6e95TrvS2FNNhLokNtET4qfwH5Bv5uRk3TBe1/UId6mxY5yt5XLIRvYWG2ZQqbkNvhXlBbADWANzgivo5WpIZ1thvf4bo2pRG45XhtAHB4cG/LpfGBhYb8rhk+ZmWEJwHd7Yf3Gk6rLwkzXNsD3fMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765211062; c=relaxed/simple;
	bh=V8SQkGR6wA5DOl43SBVKPdP4pWU9RM6ENdNe0T7xvNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4pyKvLLePo5noAWVvQ0v7jF20NMkT23fExOPFwT7wS7pE492UA7eHq8+LtrVmPkw6m90W5W6UqlcqW3Cx+7QHdjj5sGzsx9J3ldtOOvhy3F1ZdJzwhqgMeoX58mWIRr2SJZXP9Nl47Omkzkhu+IToBKsAih7gOHNNr/Zo2H5G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=z20dA/Hm; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="z20dA/Hm"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dQ6kX21PMzllB6m;
	Mon,  8 Dec 2025 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1765211058; x=1767803059; bh=/8ZaL/CpY0hJr7iRpRYBjs2p
	gOHILOFcO8Qgdg6Hxa8=; b=z20dA/HmHf22nja1pJ0pkQ0Bzy1AT7KfCX6fXfjx
	vC9o25I2f2Al3PdKGHKNrHwmOoIEgpfv4K4NH8h4byFjQCMj0EyUgT8DQB3zhdii
	7QXWwtt9OKkO+pIFgraRVdtAiEQu8Wt3lSuvnTgs01mgjNB7wSRt2rPjliSIqb3c
	Fc5suiwWq4dyCkwBfGXrfO1zkfMWnRtBe9LpHYbaOcv/mRABagv1gpp+jhJ2VMwE
	tvZHROUDbhql5jPVNbGDeneSCAVjGoMXhw4UHFX2H9OGcYXHLEjlKdzU1H3LMSE4
	t9/5XHJ7Bw5t/l1xD7by3ZNgdqru6PnoX8lQmK6n1HhPOA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Fp3thE0F4fWM; Mon,  8 Dec 2025 16:24:18 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dQ6kT4K84zllB6t;
	Mon,  8 Dec 2025 16:24:17 +0000 (UTC)
Message-ID: <33dcc737-1419-4f3e-8952-2f34db47a087@acm.org>
Date: Mon, 8 Dec 2025 08:24:16 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mq-deadline: the dd->dispatch queue follows a FIFO policy
To: chengkaitao <pilgrimtao@gmail.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chengkaitao <chengkaitao@kylinos.cn>
References: <20251208110213.92884-1-pilgrimtao@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251208110213.92884-1-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/25 4:02 AM, chengkaitao wrote:
> From: Chengkaitao <chengkaitao@kylinos.cn>
> 
> In the initial implementation, the 'list_add(&rq->queuelist, ...' statement
> added to the dd_insert_request function was designed to differentiate
> priorities among various IO-requests within the same linked list. For
> example, 'Commit 945ffb60c11d ("mq-deadline: add blk-mq adaptation of the
> deadline IO scheduler")', introduced this 'list_add' operation to ensure
> that requests with the at_head flag would always be dispatched before
> requests without the REQ_TYPE_FS flag.
> 
> Since 'Commit 7687b38ae470 ("bfq/mq-deadline: remove redundant check for
> passthrough request")', removed blk_rq_is_passthrough, the dd->dispatch
> list now contains only requests with the at_head flag. In this context,
> all at_head requests should be treated as having equal priority, and a
> first-in-first-out (FIFO) policy better aligns with the current situation.
> Therefore, replacing list_add with list_add_tail is more appropriate.
> 
> Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
> ---
>   block/mq-deadline.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 3e3719093aec..dcd7f4f1ecd2 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -661,7 +661,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>   	trace_block_rq_insert(rq);
>   
>   	if (flags & BLK_MQ_INSERT_AT_HEAD) {
> -		list_add(&rq->queuelist, &dd->dispatch);
> +		list_add_tail(&rq->queuelist, &dd->dispatch);
>   		rq->fifo_time = jiffies;
>   	} else {
>   		deadline_add_rq_rb(per_prio, rq);

I think the current behavior (LIFO) is on purpose and also that it only
should be changed if there is a strong reason to change it. I don't see
a strong reason being mentioned in the patch description.

Bart.
