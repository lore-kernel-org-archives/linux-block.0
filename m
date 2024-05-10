Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEB9168BE;
	Fri, 10 May 2024 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351328; cv=none; b=CNo/stBi57ItRdLLmX+xOe77+3cNSPXy97FmdskImZ7Mj0Cuz0cN+LibRzpT78gk77V53hRdPfSf8iodcNiv/72a6vj1b/sA3e95Pqk491TiCkQ0tzUhMl3iwwqMNzDlipop9S8jzfUXI8l8uo5z6r9VaQtK6hfU2eBwCbj29Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351328; c=relaxed/simple;
	bh=BFrpAMtQ6hOgNZP36CFmr/GFU+yNvcmCFe8r40i8/6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwuRD8uzURJMTJa4YpjD3qxy0x5gJd1BTK9fIBTDeG/KOhadDqDfKLnTwNixQmSJmTwDA8ZwbSdIc5KmsjvFF6HNnXfONICA3InAbt/VSUkHci67joFpKveXCb4iQpmrDZrq1U3xMP9hPQF3PDewO87clE9g8BxRO9kNjaicNwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0kQPzbPd; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0kQPzbPd"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VbWTT6PHrz6Cnk8y;
	Fri, 10 May 2024 14:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1715351324; x=1717943325; bh=38xXDqKoToM9frMHkxcYxnC8
	M11PgrzwbYFH289Fa7w=; b=0kQPzbPdtgdB6+UuGEQxlXjVWB6JY7mHizLjuAdj
	l48EeEF17HPQLYWXnLzcIkbZs/gOZEFzoDgdfERoa+HcV8+6UMENa5UXW+BhOq0i
	V17ULYPyOoUe28K/CrjDRVvvY8kN/Hi811GhPX77H/drR1Reb29LkkutfIhiSK+1
	5Ll0dupCiUe7M4Cfk7jjQyUIHsoFIaT+9w6HuCwYnns9tGJ9o6RhbphLNYr3IQ2M
	ThY7xzgNOOITsjYhD1jiEYBYTEI9CiaUXPoBKv6OQGLBDHKRe+9jHbjoLGw0a4Kw
	DiwzBnFZMyq6PmRSVApMKlVf/hN+bpjh2WaW5SdY/ixiWQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id UJMy_NOPQQXI; Fri, 10 May 2024 14:28:44 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VbWTR1F1Rz6Cnk8t;
	Fri, 10 May 2024 14:28:43 +0000 (UTC)
Message-ID: <ef8c5f6d-17e3-4504-8560-b970912b9eae@acm.org>
Date: Fri, 10 May 2024 07:28:41 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
To: Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>
Cc: paulmck@kernel.org, "open list:BLOCK LAYER"
 <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240510141921.883231-1-leitao@debian.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240510141921.883231-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 5/10/24 07:19, Breno Leitao wrote:
> diff --git a/block/blk.h b/block/blk.h
> index d9f584984bc4..57a1d73a0718 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -353,7 +353,8 @@ int blk_dev_init(void);
>    */
>   static inline bool blk_do_io_stat(struct request *rq)
>   {
> -	return (rq->rq_flags & RQF_IO_STAT) && !blk_rq_is_passthrough(rq);
> +	/* Disk stats reading isn=E2=80=99t critical, let it race */
> +	return (data_race(rq->rq_flags) & RQF_IO_STAT) && !blk_rq_is_passthro=
ugh(rq);
>   }
>  =20
>   void update_io_ticks(struct block_device *part, unsigned long now, bo=
ol end);

Why to annotate this race with data_race() instead of READ_ONCE()? Are
there any cases in which it is better to use data_race() than
READ_ONCE()?

Thanks,

Bart.
