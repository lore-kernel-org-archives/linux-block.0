Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A97225CB;
	Fri, 10 May 2024 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715373015; cv=none; b=IZHQtWu7GUj2mkGeSaDzIfscoNjVbfBZVX7dZ1SDnizRvXzzyGod4a4mIEBl2g3T/Moh+zxKRJFRCGPOEU6xB7tExpXk3IbQznj69O4AFfR2MahuzCKrqRCzX/Ce4StThMiqhp1F7f8cku0aGrzO4EQrR5v+Et9aH8yiEPmXF9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715373015; c=relaxed/simple;
	bh=I7RjoZV3o40k9XQXSwSf1DJAdG9Nl2iKsCqlygmuYn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FaJRSnrvDGDlWoKsUP6KeTVZ7mB4kMnGJEojPHcobsNpPd6P1sVsNPsNzS1tZOn7ibew3GsiCOYmj2qWXLCI84tE9h0z/uJbTAMVAfjIbb9y03dYUzArmcs1AEO+P3ttWlBrYcy2Cuf+N+AP+1p19DV5fwSlRX2p8wF8H7mB2ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=d55XFglX; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="d55XFglX"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VbgVS4kjQzlgVnW;
	Fri, 10 May 2024 20:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1715373006; x=1717965007; bh=rlky6QDdkncidRxtAEFa/U6T
	BKgp+TuKNd/kaQDCoIE=; b=d55XFglXN28U/dFCorqURDZ+T0c5zdcQjEzVNr0K
	p6Jr3bWvRPqlvDJBd+nXKpeDvFOLe0ZKQ1AaFdwoPY7OUEBxa2Cqt2Xe943q4p+s
	XZEPB8SIydXn5BxSmGCsQciMeKYOY27b1IP+NauUX5bZ7bFp93lOUbUt/Yvj20Yp
	KH0NvP0aBfPXI/UnXDUZbjy2g/n5ewthM0U2tkfHPSiP0Fj98pQ6bHdGnuyCkNxs
	e8ZKSPDsFvrsH4I8liL3ANczJOYc0e/2rybFlDBvL4cd23tz4mH8F7OXuvsPACVR
	fH6Dr6HmJ1gaRp7M/oNe9MORJNaPV7/i/2mt91p2iCXvBg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0eZsTtgVf4P9; Fri, 10 May 2024 20:30:06 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VbgVP4C7KzlgVnN;
	Fri, 10 May 2024 20:30:05 +0000 (UTC)
Message-ID: <4d230bac-bdb0-4a01-8006-e95156965aa8@acm.org>
Date: Fri, 10 May 2024 13:30:03 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
To: paulmck@kernel.org
Cc: Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240510141921.883231-1-leitao@debian.org>
 <ef8c5f6d-17e3-4504-8560-b970912b9eae@acm.org>
 <de92101c-f9c4-4af4-95f4-19a6f59b636f@paulmck-laptop>
 <d037f37a-4722-4a1d-a282-63355a97a1a1@acm.org>
 <c83d9c25-b839-4e31-8dd4-85f3cb938653@paulmck-laptop>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c83d9c25-b839-4e31-8dd4-85f3cb938653@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/10/24 10:08 AM, Paul E. McKenney wrote:
> To see that, consider a variable that is supposed to be accessed only
> under a lock (aside from the debugging/statistical access).  Under RCU's
> KCSAN rules, marking those debugging/statistical accesses with READ_ONCE()
> would require all the updates to be marked with WRITE_ONCE().  Which would
> prevent KCSAN from noticing a buggy lockless WRITE_ONCE() update of
> that variable.
> 
> In contrast, if we use data_race() for the debugging/statistical accesses
> and leave the normal lock-protected accesses unmarked (as normal
> C-language accesses), then KCSAN will complain about buggy lockless
> accesses, even if they are marked with READ_ONCE() or WRITE_ONCE().
> 
> Does that help, or am I missing your point?

Thanks, that's very helpful. Has it been considered to add this
explanation as a comment above the data_race() macro definition?
There may be other kernel developers who are wondering about when
to use data_race() and when to use READ_ONCE().

Thanks,

Bart.


