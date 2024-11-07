Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C517C96
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731003421; cv=none; b=ZBv2f1+K2fcIiPQXiFwcfhv6zQAPIvOupvml/sCh/NlZgteH1AcbpWYRtwi6Oh1Y22V0cnSgC4Cg6j61tudMxyg1n5aiemcFzgdURcVjBiqtI92I/otP/ihfV58nvARsQGKH65dG/PjxWTB91XaWJmjtTgXyjFCa0JsMZYfZ6s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731003421; c=relaxed/simple;
	bh=o6Cae5hwVAu79b7IRSgx0MwFkmBXhDrEwipdj5nSgmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IbnItFoZJhOnwaq5shB9VMyMhRl+sHefQ8ju7DMNAcq0tVMTPgIe7luJfLTzBkSibIT491Rw0L39htTwOKjxEKLlB32hy9HYqhjosXY7EmU1s8v1hDY55kKt3fQ/vEbcShPjj+ko5N0JGUm3DVYxvVMHXkeIS+fFoTxEAhTk4+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=QdiitbZ+; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="QdiitbZ+"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XkqzG6Y0Hz6CmQwQ;
	Thu,  7 Nov 2024 18:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1731003416; x=1733595417; bh=OEjRe6sdsdv2Re1MwodCC9UG
	18YwOyfwooC0e2d+vww=; b=QdiitbZ+0Jr/Hg3bbXSwvmAjQk90fwYI6B3NuRhv
	xitIJy1EBY2u512DS4/gErHKc93lI656g9vKAJeGosbbLNsdLX040jZBKSM9OI5Y
	PnpkOqqmM16aJsJYWiqYe4orVg6PtKQnzEI/JDWz8wROkeng7g5zINuyfSKK7qx+
	hTAiLw53WaDaqHWyld/K5bFM7cl2yy+PKKmosF2tJJ7YEnYLZNYZunCAhz4AhGEy
	yoBVBaIPVVgvsXsfA6g8tXBq+U9hOVtWJlKGRzldkTCDC5WUJro1GpRK4i5RwPsc
	RdNZoJdNcMCP9aD1pzqQhregOewPsJWX05HmkJhksmHaAA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PeZVjOeWrmiS; Thu,  7 Nov 2024 18:16:56 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XkqzC4FD0z6CmQwN;
	Thu,  7 Nov 2024 18:16:54 +0000 (UTC)
Message-ID: <6c695556-6ccf-452d-bbb5-0995f078d9a3@acm.org>
Date: Thu, 7 Nov 2024 10:16:53 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Switch to using refcount_t for zone write plugs
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20241107065438.236348-1-dlemoal@kernel.org>
 <20241107072719.GA4408@lst.de>
 <13ac0849-13c3-4c87-b3c3-e6259dea0155@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <13ac0849-13c3-4c87-b3c3-e6259dea0155@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/24 4:07 AM, Damien Le Moal wrote:
> On 11/7/24 16:27, Christoph Hellwig wrote:
>> On Thu, Nov 07, 2024 at 03:54:38PM +0900, Damien Le Moal wrote:
>>> Replace the raw atomic_t reference counting of zone write plugs with a
>>> refcount_t.  No functional changes.
>>
>> I don't quite see the point, but if Jens wants to take it the code
>> changes look correct to me:
> 
> The point is only to avoid kernel bots screaming about the use of atomic for
> refcounting. Nothing more than that.

There may be better approaches to achieve this goal, e.g. introducing an
annotation scheme that makes these bots ignore zwplug->ref. I prefer the
annotation approach because I'm concerned that this patch will have a
negative performance for ZNS and ZUFS devices.

Thanks,

Bart.
