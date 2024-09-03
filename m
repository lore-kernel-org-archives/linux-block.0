Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF84B1DC725
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725393979; cv=none; b=d5PE6DoMC+JywS7PCgCEfraaeGGWPvF189mhIaKub6ryUxXPXoc9dPwQq9foP7FaKpXrPXaSjJ7820cHFtk6vRPGhnwrtIz9eyDbXMJrG8ivdkUK89j0XX4gzshmR6vbUWVG/G6da9yapdURX1aKuKqj0nPRmDzXN9kzWAKvbDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725393979; c=relaxed/simple;
	bh=fN7oBdjMCDvU886VDHTreZxV7hCNiaOQdF26Ay4yjlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=tZsN75XV+mfnsOwmL/k7sbujQZ10cIBh/I+inZu+D9iBUQgJ/+WVcchcVPPdfh692s1dxuAkKsNnxDDjzNOPqeviNcGuJjTUoPG0j3vnw9WcmTXeu7moNVoH20TETAi45Y94i5OxmSJcr1uOEHHgv/UjFBfVoxWI96Rpk/75cQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=o6I2iaFM; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="o6I2iaFM"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WyxTP2211z6ClY96;
	Tue,  3 Sep 2024 20:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1725393974; x=1727985975; bh=gX1B3Rqeq7y3ChvN6XKIGFN6
	LAanwH5pKe/T9z9pf4A=; b=o6I2iaFMB/ydaMmX9gb6+3OvXtJTbIxb3QCMwU9B
	PP9ZJAjqPOsYxzV/sl9Zk52eVSTetpoXGivc12YBBG4WacscKzKhVryYR5VR2SWp
	zjf6ijCfhr5fNMwzh17WoBTfiQwrMavUEHGEOBMFdd0IEnn2L2rPX4S5fWacVJLn
	P9oDYJgGLpBkahlQ6dKi1TWrVfEO/c44JYYV+UbvV1kpM1CL8mmY95O7plhGhrWl
	gf5ZVoUkd+6fqS3L3/rf0peFgzk/Xs3c3wVyvu/gzC3zz+Ms6/ME+57MpghSpj2V
	k5ZoteqXA347NkyqdYqmb+GuXYt+aPb9/G0t7kHNL7TQkw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fWcNkMWlNiXV; Tue,  3 Sep 2024 20:06:14 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WyxTL2cttz6ClY95;
	Tue,  3 Sep 2024 20:06:14 +0000 (UTC)
Message-ID: <e2121f0f-c215-4c46-8ac5-df693771a5b7@acm.org>
Date: Tue, 3 Sep 2024 13:06:12 -0700
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
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
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

To the memstick and mmc maintainers, should the Kconfig files for these
drivers perhaps be updated? This is what I found by searching for
IOSCHED_BFQ:

$ git grep -nH 'imply.*BFQ'
drivers/memstick/core/Kconfig:23:	imply IOSCHED_BFQ
drivers/memstick/core/Kconfig:33:	imply IOSCHED_BFQ
drivers/mmc/core/Kconfig:40:	imply IOSCHED_BFQ

Thanks,

Bart.
