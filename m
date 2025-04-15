Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778022DFA41
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733613; cv=none; b=NaleZFFEx7ydTfTHDOa/gbXorzO5G5kO2UMw6306xxsf+HVp1C3/fGNJFFzB5Wgg54pDk8ITXQBLvJFbdMXwA6qmk277BL8AWe6ThPLQOooCGy1FQLfJiRmNDlETX7az1fSDy/zWzR3jtY3WDd1HogwjItWwvUMYZ5oWaZ1JBGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733613; c=relaxed/simple;
	bh=wkSPPXWFbT2+ljWVwLvkrqluqpYBza3Xn9m2ci+mEhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ijS25dQ5RD1nDIJFaDhiH7r0D7w8WK/gEyNfiJ0U5jFIfiKnCrkzsRvb8lmxU5//JUbXWFTRog6HR6kcZiu+rryIaJzgUK15S0Exl/+g0Nu24uXW7HIbG71oGrrVCXxIzHsAHVpgHEth8BJyETOHf1COJzd/suRIX1Bm12LUevs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Ne3EgI8G; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Ne3EgI8G"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4ZcTjQ2cXRzm0yTx;
	Tue, 15 Apr 2025 16:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1744733609; x=1747325610; bh=eWe/2h1C1UHa5EOAZBySFfNo
	j4f+JM9P7UzPagskPKA=; b=Ne3EgI8GCacrOt4oFujiRQlzwy0vHfjOt2/ywkZW
	o7Mzju4jRvHp99woDdT99v2c3e0uUYQKTMPIFEj/ECKMmo89OhWlmp6uYsuKZf9K
	4QZjees9RAfKbhtCHjh6Ddknh+YXjRbMVSnHqiaA4Ub1WcFQ1nzFprswE5KZGDlR
	gx1kA3ttEqr49ZgSHZ+RRbLNlSR/zTyanNhUWYZIIXza8MLygFggUffauJqC2+v7
	57oGuGMX6jiuhKJnXu1kcgEbnlVtZXqxTrd+HRDviTKGnf4yRosJAEWGwl3C8I0w
	jZtTT6WhHDIAO//TQi3mg88aoSi/wWJy6VII1RfOYKGCmQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1VQqDJUt5OaX; Tue, 15 Apr 2025 16:13:29 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4ZcTjN1xG9zm0yQ9;
	Tue, 15 Apr 2025 16:13:26 +0000 (UTC)
Message-ID: <77aa1c61-dc33-47d0-854d-22e4f1cae60e@acm.org>
Date: Tue, 15 Apr 2025 09:13:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: ensure that struct blk_mq_alloc_data is fully
 initialized
To: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1720cf81-6170-4cac-abf3-e19a4493653b@kernel.dk>
 <a8074c72-e258-4b34-a629-c253997dfab9@acm.org>
 <4b0eee16-a37b-4770-95f0-c5f02160e0da@kernel.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4b0eee16-a37b-4770-95f0-c5f02160e0da@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/25 8:59 AM, Jens Axboe wrote:
> On 4/15/25 9:50 AM, Bart Van Assche wrote:
>> On 4/15/25 7:51 AM, Jens Axboe wrote:
>>> On x86, rep stos will be emitted to clear the the blk_mq_alloc_data
>>> struct, as not all members are being initialied.
>>
>> "Partial initialization" never happens in the C language when
>> initializing a data structure. If a data structure is initialized,
>> members that have not been specified are initialized to zero (the
>> compiler is not required to initialize padding bytes). In other words,
>> the description of this patch needs to be improved.
> 
> How is the description inaccurate? As not all members are being
> explicitly initialized, rep stos is emitted to do so.

Hi Jens,

I think we agree if the word "explicit" would be added to the patch
description.

Thanks,

Bart.


