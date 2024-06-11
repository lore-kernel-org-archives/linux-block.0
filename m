Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AA3383A3;
	Tue, 11 Jun 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123227; cv=none; b=dkTwbXzl5irp+nCFqLEx7i4iJXgJu/EvHvtmtTiGT8Xf9QP9j1dBhcdNTJtBkJSjLmAm6UOSaXyJChoEq77T/KuxRxkN9XWovG6IqfTOQF48+XehdE4YuJIU3naxEndUiXt2NHHej6OzPyHSgaelWaU1mOJoYWJPvRk/3S/4JvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123227; c=relaxed/simple;
	bh=lNI1z7kV8tW0KJelcKiByN1P/iVLFYv0vmsKZ06xtI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tj/4QMZi6OfgCp8k4PcYI3Am4NDEOWcwYjew4TUzPx+jEYxO+9o1/8H8rDixeN4IPaXZ5WrwQ5dGfaRlYdCotc6RcEKu/aqBX9L+FskBwSEE65xwCED93F8KJlncweU/JPRsmINP5fOrhlk9QCRw4/HYRK0D5dmnsmi87OU17nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZdWta9UI; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZdWta9UI"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VzDbF3KCSzlgMVP;
	Tue, 11 Jun 2024 16:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1718123219; x=1720715220; bh=vOfUJnLtkU9bueOk+Z1extJW
	Kgk6nSX5XKkkvClh41E=; b=ZdWta9UIQnFdBteeCPBCx5c6TkbvXaRaj0/q5G0T
	ZRvXcBSLyFzq9d0qw+9C6UKiLYn0IMKyhijnTy7Jhh0Rq/fLZ4Nv5eNdw6F8bkQA
	znavZR/j2g0bwtLdfxJyhuKDpa4x+Jc60d0tHWUa4aoUPmkRQgWZzpT+XPlecYJ9
	VX+scPPEFW8PRsRLPvaaGI33FkPDdd/za89/2zsbLUtCVNf/Ao8CXvtNZPR2kr1U
	rbGM259gChLgcRtU5W2BnEoMKMN8VlnHZzWfoT+w0lOQW2Ld8ALwgxiSgyh1LbKn
	U/H8QJGZQgBuzkhJAnMbkILV1WW/qQWjtf599GNYlukf1w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4oQ_ICYubISc; Tue, 11 Jun 2024 16:26:59 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VzDb46LL9zlgMVN;
	Tue, 11 Jun 2024 16:26:56 +0000 (UTC)
Message-ID: <86eb3dd0-77a1-4d1d-8e62-38c46bd7563a@acm.org>
Date: Tue, 11 Jun 2024 09:26:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] block: Add ioprio to block_rq tracepoint
To: Dongliang Cui <dongliang.cui@unisoc.com>, axboe@kernel.dk,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 ebiggers@kernel.org
Cc: ke.wang@unisoc.com, hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com,
 hao_hao.wang@unisoc.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, akailash@google.com, cuidongliang390@gmail.com
References: <20240611073519.323680-1-dongliang.cui@unisoc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240611073519.323680-1-dongliang.cui@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/24 12:35 AM, Dongliang Cui wrote:
> +#define IOPRIO_CLASS_STRINGS \
> +	{ IOPRIO_CLASS_NONE,	"none" }, \
> +	{ IOPRIO_CLASS_RT,	"rt" }, \
> +	{ IOPRIO_CLASS_BE,	"be" }, \
> +	{ IOPRIO_CLASS_IDLE,	"idle" }, \
> +	{ IOPRIO_CLASS_INVALID,	"invalid"}

Shouldn't this array be defined in a C file instead of in a header file?

> @@ -79,27 +87,32 @@ TRACE_EVENT(block_rq_requeue,
>   	TP_ARGS(rq),
>   
>   	TP_STRUCT__entry(
> -		__field(  dev_t,	dev			)
> -		__field(  sector_t,	sector			)
> -		__field(  unsigned int,	nr_sector		)
> -		__array(  char,		rwbs,	RWBS_LEN	)
> -		__dynamic_array( char,	cmd,	1		)
> +		__field(  dev_t,		dev			)
> +		__field(  sector_t,		sector			)
> +		__field(  unsigned int,		nr_sector		)
> +		__field(  unsigned short,	ioprio			)
> +		__array(  char,			rwbs,	RWBS_LEN	)
> +		__dynamic_array( char,		cmd,	1		)
>   	),

I see unnecessary whitespace changes. These changes make this patch harder to
read than necessary. Please undo the whitespace changes.

>   DECLARE_EVENT_CLASS(block_rq_completion,
> @@ -109,12 +122,13 @@ DECLARE_EVENT_CLASS(block_rq_completion,
>   	TP_ARGS(rq, error, nr_bytes),
>   
>   	TP_STRUCT__entry(
> -		__field(  dev_t,	dev			)
> -		__field(  sector_t,	sector			)
> -		__field(  unsigned int,	nr_sector		)
> -		__field(  int	,	error			)
> -		__array(  char,		rwbs,	RWBS_LEN	)
> -		__dynamic_array( char,	cmd,	1		)
> +		__field(  dev_t,		dev			)
> +		__field(  sector_t,		sector			)
> +		__field(  unsigned int,		nr_sector		)
> +		__field(  int	,		error			)
> +		__field(  unsigned short,	ioprio			)
> +		__array(  char,			rwbs,	RWBS_LEN	)
> +		__dynamic_array( char,		cmd,	1		)
>   	),

Also here, please do not reformat lines that are not modified otherwise.

> @@ -176,13 +194,14 @@ DECLARE_EVENT_CLASS(block_rq,
>   	TP_ARGS(rq),
>   
>   	TP_STRUCT__entry(
> -		__field(  dev_t,	dev			)
> -		__field(  sector_t,	sector			)
> -		__field(  unsigned int,	nr_sector		)
> -		__field(  unsigned int,	bytes			)
> -		__array(  char,		rwbs,	RWBS_LEN	)
> -		__array(  char,         comm,   TASK_COMM_LEN   )
> -		__dynamic_array( char,	cmd,	1		)
> +		__field(  dev_t,		dev			)
> +		__field(  sector_t,		sector			)
> +		__field(  unsigned int,		nr_sector		)
> +		__field(  unsigned int,		bytes			)
> +		__field(  unsigned short,	ioprio			)
> +		__array(  char,			rwbs,	RWBS_LEN	)
> +		__array(  char,			comm,   TASK_COMM_LEN	)
> +		__dynamic_array( char,		cmd,	1		)
>   	),

Same comment here.

Thanks,

Bart.
