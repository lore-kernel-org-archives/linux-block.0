Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF921B90F
	for <linux-block@vger.kernel.org>; Fri, 20 Dec 2024 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734718737; cv=none; b=rsVMlhfkOp93zpMvjgeZHPCYQMMPq4vJAYtdYndnAmm09hDQhC46RmslqPJfPddC5OjY8c60sTWLkk2q1Nlooan4qaf2WSNJPeQ5X+DsL40OWrWFu09rmhAZKWzKezGXMfCDiAlVM4zHI5DqfBl8CIASwD3bCnI0CxeOOrW08W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734718737; c=relaxed/simple;
	bh=evpuUx7yDNwaCv+ZVl57RqJ8AqeM6j5LVdWgUYr0N64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glj6+byz0hSo7pMVC+prQpT1XBmEBJQRuJh0UoeXtWQfPdyNM9BBHmCFezSrHDdsy/M6ia/CeFbgfq8002jc9pmXuPcjQNEbFLbjohEeGsKKPFYQmV112EV8YzGLNqEq+a20r3IGUds8JkTtwzXbY+w6b64tGTDgIr+cX3VbL+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=qJQWOVy1; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="qJQWOVy1"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YFFzb44qbz6ClbJ9;
	Fri, 20 Dec 2024 18:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734718729; x=1737310730; bh=evpuUx7yDNwaCv+ZVl57RqJ8
	AqeM6j5LVdWgUYr0N64=; b=qJQWOVy1frHk+YMBsWgyCcykLBI8GPfqYgT2raRb
	S0lCmpzVX0kA2lk5pp6ymqCIVxTrHglNpv0h9VOOTtou28CueT3/uNJuaULJjh2q
	aOtJJT5Kfph+ZP+/H7Kkq7qJjj3CiUNxPsltvGusZ3WfQSg0oJh6R6XufW9zXL9z
	fxv5K31ywqsZVAIs/BlhFLDfeNPMJGypKMwGyFQgin4uCbfdsFg4epw/G+TsGN3V
	aZg9eu5ZRWRtAEPULRK4rR95zs4NdkND96VWlDXg5QJa1mwsYO4k7ofu+UKf/5PS
	xQXgOBuwqT+hbSBd5lf9NzYiNu4KvUICcVA6dl4v+6h9qw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id di5uhCkO63Pt; Fri, 20 Dec 2024 18:18:49 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YFFzX0hpLz6CmR0C;
	Fri, 20 Dec 2024 18:18:47 +0000 (UTC)
Message-ID: <5c410028-ac25-45e0-9caf-2ad26c0ce0ea@acm.org>
Date: Fri, 20 Dec 2024 10:18:46 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Minor improvements for the zoned block storage
 code
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>
References: <20241217210310.645966-1-bvanassche@acm.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241217210310.645966-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 1:03 PM, Bart Van Assche wrote:
> This patch series includes several minor improvements for the zoned block
> storage code. None of these patches changes the behavior of that code.

(replying to my own email)

Hi Jens,

Can you please take a look at this patch series and also at the patch
series "[PATCH v3 0/2] Two blk_mq_submit_bio() patches"? All patches in
both patch series received one or two positive reviews and no negative
feedback.

Thanks,

Bart.
