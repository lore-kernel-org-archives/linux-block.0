Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C040E249F9;
	Wed, 22 May 2024 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396695; cv=none; b=LHa2XYoInOPtgqrDzbOruuiMxwL1OB4IWN085FqQKrP4aO1FcY3G9CgOhLPWTDLc06mM5wDJii2op2zkP2EP7uUJ2TqerGLs2P34sqv9b4uKGtsIXQwCiOt50CsSc+xYJ7kJo5FW/zmVeCUSA738gKD/9IeB3e2IxZYpTcZ37WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396695; c=relaxed/simple;
	bh=6sqL4Sln4VTXgOdS36e3ZnSUXf0674oIdBAh3AxRshY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSLewLY1XLew/Nthd2+oSB4/84RmBvYQOlt2Z8friPlA4FExbin6/3le31/rtjMKi+F9d00dVc4HfxD+Sl1IAUKPXqEmdsK5ixe1nNZ1IcalCg32iFxDdFSd9knrSiiIUEIEIMrLYbjNsFvP4/o8PLtdIlKtuZEqicp/V5Eg7V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4eJ2D4C1; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4eJ2D4C1"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Vky4b40HhzlgMVN;
	Wed, 22 May 2024 16:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716396682; x=1718988683; bh=+qHjXc4wc3A6hgY+QIP3fsYa
	svVjod08q+0H/O6siVM=; b=4eJ2D4C1cKZjsn191QXsxoSR77Wj6jVuvaPDJdTJ
	ryUP1pXg6rll7oigWxq9Fw68+yjDxEniGZiV6vi/TTMn4rqYjIa3cRvPnJdVse2Q
	k4h0BIjjb8cPdLvhWna6sdkRZYoIWGHKQHRbrM/TYQGnCbOWrgk03LTTYj9WQA2O
	OcD+Qjufb+FsUri6m9UH89mOVcQrPz5n9Nu+gSIQ/ut0OTTd4C+mcmtWqqtu7K48
	eUjUeEldT/U31TSIzMtvTzYFqWOo8O15GQVZCdgTGw+pGZK3TZJZfGhf4GdqtHhP
	cW2QLRHrMCJKbkaGcjsOPUQ5wlnv3t4gQP9c8Rz+Qx1G8g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BHXIj_N2MZ5d; Wed, 22 May 2024 16:51:22 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Vky4Q4C7rzlgMVL;
	Wed, 22 May 2024 16:51:18 +0000 (UTC)
Message-ID: <b2e4a072-a339-444e-abea-29388dcbfee6@acm.org>
Date: Wed, 22 May 2024 09:51:16 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] block: Add ioprio to block_rq tracepoint
To: Dongliang Cui <dongliang.cui@unisoc.com>, axboe@kernel.dk,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 ebiggers@kernel.org
Cc: ke.wang@unisoc.com, hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com,
 hao_hao.wang@unisoc.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, akailash@google.com,
 cuidongliang390@gmail.com, Damien Le Moal <dlemoal@kernel.org>
References: <20240522090104.1751148-1-dongliang.cui@unisoc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240522090104.1751148-1-dongliang.cui@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/24 02:01, Dongliang Cui wrote:
> +#define IOPRIO_CLASS_STRINGS \
> +	{ IOPRIO_CLASS_NONE,	"none" }, \
> +	{ IOPRIO_CLASS_RT,	"rt" }, \
> +	{ IOPRIO_CLASS_BE,	"be" }, \
> +	{ IOPRIO_CLASS_IDLE,	"idle" }, \
> +	{ IOPRIO_CLASS_INVALID,	"invalid"}
> +
>   #ifdef CONFIG_BUFFER_HEAD
>   DECLARE_EVENT_CLASS(block_buffer,
>   
> @@ -82,6 +90,8 @@ TRACE_EVENT(block_rq_requeue,
>   		__field(  dev_t,	dev			)
>   		__field(  sector_t,	sector			)
>   		__field(  unsigned int,	nr_sector		)
> +		__field(  unsigned int,	ioprio_class		)
> +		__field(  unsigned int, ioprio_value		)
>   		__array(  char,		rwbs,	RWBS_LEN	)
>   		__dynamic_array( char,	cmd,	1		)
>   	),
> @@ -90,16 +100,19 @@ TRACE_EVENT(block_rq_requeue,
>   		__entry->dev	   = rq->q->disk ? disk_devt(rq->q->disk) : 0;
>   		__entry->sector    = blk_rq_trace_sector(rq);
>   		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
> +		__entry->ioprio_class = rq->ioprio >> IOPRIO_CLASS_SHIFT & 0x3;
> +		__entry->ioprio_value = rq->ioprio & 0xff;

Why to split the I/O priority field when storing it in __entry instead of when
the values are printed? Combined the ioprio bitfields occupy 16 bits. The above
patch reserves 64 bits in __entry. I think that's overkill. Additionally, some
bits of the I/O priority bits are discarded by the above code before I/O
priority information is reported.

Please split the I/O priority information into the three fields defined in
include/uapi/linux/ioprio.h (class, hint, prio) and use the macros from that
header file for splitting I/O priority information.

Thanks,

Bart.

