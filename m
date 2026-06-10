Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAAF347FC4
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111149; cv=none; b=l+3pvWP1rsPQge/nOQbF5tjDGfIWxua4DN+xjADh7y4HxGgXoJAZkzZlXbMAs4U+sB9fIvHq23r8t3l1xXTNPLoWNWO+HtakbIImDP7/mlzgQu3mAlR/H2xSTud20fNoIiLmVmk0Z+x5PUt/Ws3xkvuj+EvzTNghtyBt3lLugM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111149; c=relaxed/simple;
	bh=euJFSeFIRIM/TnxoUiiW8hmA+XAOC78CpquZ244fJQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0XgxlTPvceyf2VAF2VOQgO910bna1ThVx7wGmII/W4ln1pW17q588yP3ZpQtXZGmd7ugsMK9jgOf7qfYBy4xHgqak03412PmPp5FfSvQL/vHN9ZV76d5WwibrjSHAnqZu2JaSj9wTf5SpAlt5pIcozxJ6Nn4iSDKp9+O9DspIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AYamYGXM; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AYamYGXM"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gbBxQ3DyZzlfvpK;
	Wed, 10 Jun 2026 17:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781111143; x=1783703144; bh=vazbLPvy25xDqcD2+einu0Aw
	qrNEMvzN31qVzTntNts=; b=AYamYGXMvVg0dF1K0YE6i2yY9DnfhgHvPe61BdvD
	9R8Igdqs6Xl8nQ3moDkxr79nTgotoHfoNvtRmMrqt0LJ/WiQAuhsiLz7Ls/Y/4OL
	6AENb8+HI+nuu8fcXsORwDhyqWe6QS5ULH6+dqrq8782uYNpV8dsfo/g1GRLgfyc
	8DpfIzZyPMGTZf13D7RjIs2ky8yaWchO2FHQG6fkwvCJj9OGlRqS1qPaBix3Y5gN
	8IDbmzVcxHLLs/YrAJND4fkkd4OHadQsLG8yaV3voIzGe5ynoqhzU2y+qT7CxxLy
	DFf5OM4aPSQhd+kQ0LJmS19wR1YjN6nIscZicT8kEU3CHQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id i_uy_bTXGuyP; Wed, 10 Jun 2026 17:05:43 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gbBxK0wqQzlgdRF;
	Wed, 10 Jun 2026 17:05:40 +0000 (UTC)
Message-ID: <61eb3024-f9bb-465a-938c-c12db1218923@acm.org>
Date: Wed, 10 Jun 2026 10:05:39 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/27] drbd: Split drbd_req_state()
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Marco Elver <elver@google.com>, Philipp Reisner
 <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <cover.1781042470.git.bvanassche@acm.org>
 <83d144f376580f491b42d7533e004aced7d26d7a.1781042470.git.bvanassche@acm.org>
 <aij1DtWM8N7O3q-E@infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aij1DtWM8N7O3q-E@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/26 10:24 PM, Christoph Hellwig wrote:
>> +{
>> +	enum drbd_state_rv rv;
>> +
>> +	if (f & CS_SERIALIZE)
>> +		mutex_lock(device->state_mutex);
>> +	rv = __drbd_req_state(device, mask, val, f & ~CS_SERIALIZE);
>>   	if (f & CS_SERIALIZE)
>>   		mutex_unlock(device->state_mutex);
> 
> Wouldn't something like:
> 
> 	if (f & CS_SERIALIZE) {
> 		mutex_lock(device->state_mutex);
> 		rv = __drbd_req_state(device, mask, val, f & ~CS_SERIALIZE);
>   		mutex_unlock(device->state_mutex);
> 	} else {
> 		rv = __drbd_req_state(device, mask, val, f & ~CS_SERIALIZE);
> 	}
> 
> be either to follow?  Is there much of a point in the CS_SERIALIZE
> clearing here?

Do you perhaps want me to combine this patch and the next patch in this
series (12/27)?

Thanks,

Bart.
