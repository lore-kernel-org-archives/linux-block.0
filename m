Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5FF279354
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206853; cv=none; b=R1Ai6zYs/9dqUFXplk0663tqGDI2Ad5aGTuUxtLpXE9Ed7mBmc2VDg+KxB5lHhYRmMjxBoWFWaIHgLaYtslHrFH21j7SCjH37qXkhyNjb6ycmsq5AuIIrf45BarqCSJaCzHlptoB557purvd33JaQtgYVfFin0as0PurPtiqbmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206853; c=relaxed/simple;
	bh=AeoG5HiDKnBp1HYYNHx1uycIU61Ybj3lvnRl12OD5bc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZSoIxBOc/iGt1AzsGHWFwAcSAr2g7q0i33apeNoKG34abGV70srBKHfzE+YOPPU1aa7HZwM2M4r69rlPnsImJYfwQmCpbmpZwaaapnoo/GhddGNv3tKakntqoRTWSoKqwApiE+GJFvDdsYoO13jU4IkxqWtuQXeA+6i/zkLqLBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vM5bjkeN; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vM5bjkeN"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bmlJL5lWHzlvX7v;
	Tue, 22 Jul 2025 17:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:subject:subject:from:from
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1753206849; x=1755798850; bh=DXgu9J61MDYL2WAdCyswZoq4
	NP9mKkrYIxMk0SeedEU=; b=vM5bjkeN6ZO7nUN/r3k9EjLEzxcnUKx+ANKyxRuC
	W3DYqKja3jjsMmBlU9pL6MrU5TXS2sgQZkUX0v5pc7TomE8Tkmfd4wzx0JT71PZA
	ue35G0pmb84dwcZH2R7ahzeYlavw+ugR5UKm9pfg9QQAOwDFD1Hvr321wZEVXnMZ
	J+tb81bYDpxburj2hB0K5yDAj4i8P/CxDEY+ZbPjXCPetroOd7PkFXOCqU196IoP
	WApZDj/T1ZubYDUvq31luWLMzOZl2DKds1qZNlq/Q0pKBFSz0UGOVAS3Iq7Y/arP
	sNQyhjSH0tMWdkKySljq6kX+hbByq/EJzCtR2Ddg08aBFg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IIki-ofUehm2; Tue, 22 Jul 2025 17:54:09 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bmlJD1hsKzlfnC3;
	Tue, 22 Jul 2025 17:54:03 +0000 (UTC)
Message-ID: <34508ac0-2060-4ea4-8fe7-de59ac64c677@acm.org>
Date: Tue, 22 Jul 2025 10:54:02 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 3/5] bcache, tracing: Do not truncate orig_sector
To: Coly Li <colyli@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Kent Overstreet <kent.overstreet@linux.dev>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Kent Overstreet <koverstreet@google.com>
References: <20250715165249.1024639-1-bvanassche@acm.org>
 <20250715165249.1024639-4-bvanassche@acm.org>
Content-Language: en-US
In-Reply-To: <20250715165249.1024639-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 9:52 AM, Bart Van Assche wrote:
> Change the type of orig_sector from dev_t (unsigned int) into sector_t (u64)
> to prevent truncation of orig_sector by the tracing code.
> 
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Fixes: cafe56359144 ("bcache: A block layer cache")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   include/trace/events/bcache.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/bcache.h b/include/trace/events/bcache.h
> index 899fdacf57b9..d0eee403dc15 100644
> --- a/include/trace/events/bcache.h
> +++ b/include/trace/events/bcache.h
> @@ -16,7 +16,7 @@ DECLARE_EVENT_CLASS(bcache_request,
>   		__field(unsigned int,	orig_major		)
>   		__field(unsigned int,	orig_minor		)
>   		__field(sector_t,	sector			)
> -		__field(dev_t,		orig_sector		)
> +		__field(sector_t,	orig_sector		)
>   		__field(unsigned int,	nr_sector		)
>   		__array(char,		rwbs,	6		)
>   	),

Hi Coly,

Can you please help with reviewing the two bcache patches in this patch
series? Apparently you didn't get Cc-ed automatically by
scripts/get_maintainer.pl. See also
https://lore.kernel.org/linux-block/20250715165249.1024639-1-bvanassche@acm.org/.

Thanks,

Bart.
