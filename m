Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A1B1C14
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384016; cv=none; b=EF0Kjm+G7Lr4RasIJnEuB5NZ+0eJB0Bf4or5PE5SOv+E7EzBlUDo7b8lgtq7aWtYDPzxPO6CEk2KDVtca0f2XiAIHVekItFoDJUqNePUh3ITheTwrO+ddJPSxcJjHeMzCH0ylbrATNMlTyuGmCd2MnEhysom0JGSxwpoQG45q8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384016; c=relaxed/simple;
	bh=Ph0Wh1kaxUYm3GVdX+Lr+roLE/+5OiIqeoyzxf+Oqq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Er7JEssPasaXlqBHPoEtvJgTMFcv83+BjhCSmbgbnIo1yjScfW3e9GXyd4a/cvuAMauq8WDAKbhGBCqCpXXovNLVx7ScFxipZfWxmWHdkgOYP1X0/mOwnls460tSFbTQvqXLZCSZmtZ8wRqNHh47Fl9sHYWKZvVeluZjEbx20t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vLeUTSxB; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vLeUTSxB"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Wysng1fqVzlgTWR;
	Tue,  3 Sep 2024 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1725384006; x=1727976007; bh=W3C6raIpgFwAvG3RpaJ9xZoF
	k9a3BMudX1Jo7ciAZR4=; b=vLeUTSxB4QURTPgzK7gqo1cTeh9AyazGRXvBePyt
	teDxI9u4hTcTe8cKpO5o0qi7hwD45qQGX09Zs3BObX2Rqnk8EvP4G1opPmgLP6hC
	Q61KMnJJ9Tj/YB15xg9AOQpRRDjbkscw8gK0cABGN0WpvnhTSQPmv06guCPL6NGK
	6nXxq87soRRTlHpjB2wWXpmaYXV9Hz8AtzPuB/vTfsmFivWcwxoKV0Z+Hg4NZACd
	iBkjwD++YqwpT08T13/3pby6oO8qZU8cdzg3uteAD4H+Dm044jTh8TAkhMFxz5Iq
	NFuBQrcNmiEUvujr9gR8BSvV8toMpC/fOj+tqpRoRrGoYg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ekx2ICgIA1TA; Tue,  3 Sep 2024 17:20:06 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Wysnf1YznzlgTWP;
	Tue,  3 Sep 2024 17:20:06 +0000 (UTC)
Message-ID: <de423681-8fee-4864-b916-c9178298673d@acm.org>
Date: Tue, 3 Sep 2024 10:20:05 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: move the BFQ io scheduler to orphan state
To: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6fe53222-876c-4deb-b4e1-453eb689a9f3@kernel.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6fe53222-876c-4deb-b4e1-453eb689a9f3@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 8:53 AM, Jens Axboe wrote:
> Nobody is maintaining this code, and it just falls under the umbrella
> of block layer code. But at least mark it as such, in case anyone wants
> to care more deeply about it and assume the responsibility of doing so.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42decde38320..4a857a125d6e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3781,10 +3781,8 @@ F:	Documentation/filesystems/befs.rst
>   F:	fs/befs/
>   
>   BFQ I/O SCHEDULER
> -M:	Paolo Valente <paolo.valente@unimore.it>
> -M:	Jens Axboe <axboe@kernel.dk>
>   L:	linux-block@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>   F:	Documentation/block/bfq-iosched.rst
>   F:	block/bfq-*
>   

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
