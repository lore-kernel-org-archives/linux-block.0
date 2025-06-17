Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F162F5312;
	Tue, 17 Jun 2025 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750199146; cv=none; b=UMn/T3IBnnFFiu8XdN6Tza4//yHh5sxQUnxhPTdRiMttGywMRapeRmKkyIBnvt+9k9lzJlNpSmGdpFaahJPgSjt/5uxtJL8BLBv7A4xJkPwtzshNkjgjcHQzGBMpwzCWcCnMQWjnL32cmQhD0UBd5b7l9AIvTgiKIZRJ7aRY4HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750199146; c=relaxed/simple;
	bh=ldx27R1+iMR7oFThnP3SG77yVAaWUBoN1GCRNm+wX6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Uus2yqyKNmkCPDJ/qIpI502eQnsyy+aD7Kv0zaIp0pOqVe4tGPyQaHUajlk/6E1DYP2F7iUR/PyCAfoGgz7cWCFuR+LEdea7GoznfZhWEfja1qGkbN2/eyPxs2wKM1LrGW2kWUybfWUzJZOCqxZmS4JiahhhUl3L+awiagMydHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XdNktgi3; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XdNktgi3"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bMLzm6dGrzlvX7p;
	Tue, 17 Jun 2025 22:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1750199139; x=1752791140; bh=Xc+WhlkMlI+pcVbRXrb20qA1
	G39pU4szZWRw6M3elb4=; b=XdNktgi3VEUbIIAXW3fj45mu74LrFsjTJ5SWp03N
	vprNEtC086dLQnR763wK3yV4qPHtocrLLn5mYDeqz+wnhPbx3r9+YGPkRpiIy9nO
	584rSrWm8KXjaia26nb4PeOp054vYqQjenqWMlr80ootiPrBqeY09JlDmPK+82p6
	FfL65nSh93sfmoc0VV4jzMTUK7h8HSyzINbEWhD9eNjlwCT48QnT1wOuS3znaael
	RV+oOm40I5oSHRPEWn6QGtw9T8uky7olicxuGk6DDaCH4q+B67ZZURRwhsXtzVOr
	VtoikIorEkOxyoM1uKSW9Jq17icFG1jvwNsnZy7tjUBGYw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id l1_sIaQCi6vK; Tue, 17 Jun 2025 22:25:39 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bMLzh6P13zlgn8k;
	Tue, 17 Jun 2025 22:25:35 +0000 (UTC)
Message-ID: <1e25d17b-f481-485c-85a6-d5a8440c1c96@acm.org>
Date: Tue, 17 Jun 2025 15:25:34 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: mq-deadline: check if elevator is attached to
 queue in dd_finish_request
To: Elijah Wright <git@elijahs.space>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250617205630.207696-1-git@elijahs.space>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250617205630.207696-1-git@elijahs.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/25 1:56 PM, Elijah Wright wrote:
> in dd_finish_request(), per_prio points to a rq->elv.priv[0], which could be
> free memory if an in-flight requests completes after its associated scheduler
> has been freed
> 
> Signed-off-by: Elijah Wright <git@elijahs.space>
> ---
>   block/mq-deadline.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 2edf1cac06d5..4d7b21b144d3 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -751,13 +751,15 @@ static void dd_finish_request(struct request *rq)
>   {
>   	struct dd_per_prio *per_prio = rq->elv.priv[0];
>   
> -	/*
> -	 * The block layer core may call dd_finish_request() without having
> -	 * called dd_insert_requests(). Skip requests that bypassed I/O
> -	 * scheduling. See also blk_mq_request_bypass_insert().
> -	 */
> -	if (per_prio)
> -		atomic_inc(&per_prio->stats.completed);
> +	if (rq->q->elevator) {
> +		/*
> +		* The block layer core may call dd_finish_request() without having
> +		* called dd_insert_requests(). Skip requests that bypassed I/O
> +		* scheduling. See also blk_mq_request_bypass_insert().
> +		*/
> +		if (per_prio)
> +			atomic_inc(&per_prio->stats.completed);
> +	}
>   }

The warnings in dd_exit_sched() will be triggered if dd_finish_request()
is ever called with rq->q->elevator == NULL.

If this can happen, it should be fixed in the block layer core instead
of in the mq-deadline scheduler.

Thanks,

Bart.
