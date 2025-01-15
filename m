Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD511CD21C
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736964897; cv=none; b=JsnvV0GY3INcEujfwiKdEGIHAjdUgG2R5e5yf/60CnQ+EdcQQa6S0Psnmdf3nkSaLw8kMgHS7PctMdK36lFIQMK2Jnba+CHxIEd2kAI+pmSHXlxGnc6LOGx8wzP14vu3RfD/KP0VvdCRZ4b8z9CWP6ohDjPfSaf84bp+WizUQiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736964897; c=relaxed/simple;
	bh=SpYeQuGl6WgsxXN5pewjtf6yQTCbE2iz0e1//fM/OYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDt/d2y1h7pwdMREd0vphbCgrVlAHaiVlbuV56taPXY+PKidwWad0DLkhvG3UhOxrSK0o7V83EuQqUcWBE9jtaXhVx3IEtE02tnby2BBRs9SiBda2l25uzMjA/5C1e1klLreMjccMuAY86mIcATm4N8X9vnLyQFxMDnWwlOQVJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WryFBg4Y; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WryFBg4Y"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YYDg318Lkz6CmQyc;
	Wed, 15 Jan 2025 18:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1736964892; x=1739556893; bh=DmRMWkHdyFraHuI3+ZUb0sAp
	WwIzi5k6lnU22poQCjk=; b=WryFBg4YgwfO4RBl5tt0lATjD1LSyKyT5DGUkTrs
	5rzue8NQktfJE8y13MlKvT+c/v4aLX9NWrS4Sd6gu/lrapkjT3lgsaKmQWs/lqEC
	82sJLkR72NwntOFg1M4bAJ1EOq0CCYedGRgoQUaxRp1ijdXtFTgnTaX1IeuGrnQP
	ihlwmcD+3EXHpD01RdC8B+RLZkYxTZtrVxbCdi5uuqjndK+F6JYosL+YcEds8/dT
	6dfny0qFHanhIiaR48tZiUcgMQMz1t0NN6eE3JCHsvL5H4tYvsg8rmrRJqlrXWy1
	6WjSH0B8I3lSub15VJOxeIgg9aPmakId9lbcXuYGchBDEw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JXHxxtYsVK2a; Wed, 15 Jan 2025 18:14:52 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YYDfz3XTZz6CmQwN;
	Wed, 15 Jan 2025 18:14:51 +0000 (UTC)
Message-ID: <447f7847-df9c-4188-a842-dff599631072@acm.org>
Date: Wed, 15 Jan 2025 10:14:49 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 1/5] null_blk: generate null_blk configfs
 features string
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>
References: <20250115042910.1149966-1-shinichiro.kawasaki@wdc.com>
 <20250115042910.1149966-2-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250115042910.1149966-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/25 8:29 PM, Shin'ichiro Kawasaki wrote:
> The null_blk configfs file 'features' provides a string that lists
> available null_blk features for userspace programs to reference.
> The string is defined as a long constant in the code, which tends to be
> forgotten for updates. It also causes checkpatch.pl to report
> "WARNING: quoted string split across lines".
> 
> To avoid these drawbacks, generate the feature string on the fly. Refer
> to the ca_name field of each element in the nullb_device_attrs table and
> concatenate them in the given buffer. Also, sorted nullb_device_attrs
> table elements in alphabetical order.
> 
> Of note is that the feature "index" was missing before this commit.
> This commit adds it to the generated string.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

