Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3318F1304B1;
	Mon,  3 Jun 2024 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434202; cv=none; b=eoSXqPNudZxzrAudHGiABZ8LToddifRjzIJ7nxYpFQTPJ+8ivDkq5H7/z/F9gUYo++LbzZcHi4E564G7v+E+1lTU7D3ZK7upNtV8tYERA3Mwv3xiMxQP0sNlBUK2VqINBtAU29Qfp/tFb3/QgdubPW8mOsXYlv3ZN9Wl31b2VYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434202; c=relaxed/simple;
	bh=NdEWlc5LadRjjSgK7Y5Tx6FHrF4eTCDLDBNTBsZ5ACg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWFBRDjQ7gtqJOFG81E57UseBk3/V8aolijPh6GLPeXGrqOe9pmrXLUFQtNdHF+S70gfbK69l85EWvgK9FdwZ3Jr81leIOjcANAuYv5IGB3By+DeNflQuiXu4FjgROW4FR5CsKklMu6DG9egccyEZq2E8Wqnh30HSUb3YScPum4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kWjEhXWY; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kWjEhXWY"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VtKmm4zlnzlgMVc;
	Mon,  3 Jun 2024 17:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717434198; x=1720026199; bh=szTW+lKyFEYkP8WzkuWnoEbk
	PGfA8Q5XnLEea5tZdt0=; b=kWjEhXWYSSJk090al3eaFSa9Ewr5sX87IluLwzcu
	+6SD7gWwDI+CQRO+4Hm1Xpd071Thd1hx4JHzeo/OWtxxXkXNvlZKeaprFqc8JzAV
	OZs/Z7ktWBCJXoaU7bjNYji7WM/nKQoSk93zllHcG9ffnxniyFUqqTpt0bMUE6Qp
	h312oUdCec4QSLft4ZzYs+zHIIE+BSGL4P9vlmi8C9Ws61YKfnsHByhJOHcZ729v
	X4kC/5PCWcOr2HR1rR9ZrhPfovCwoj8l9IvaMFd9gaGkd8l/Tjd9BnZH5et5bG+p
	ORk1PQOs/XimhqCv/rL3pN9MVAzao5H9+IDH8V6gblT6sQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Gq-q_G1KSLzU; Mon,  3 Jun 2024 17:03:18 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VtKmj2lnrzlgMVV;
	Mon,  3 Jun 2024 17:03:17 +0000 (UTC)
Message-ID: <66a8c62b-9202-4de8-8789-1f724a5ce5f8@acm.org>
Date: Mon, 3 Jun 2024 10:03:14 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: fix validation of block size
To: Damien Le Moal <dlemoal@kernel.org>, John Garry
 <john.g.garry@oracle.com>, Andreas Hindborg <nmi@metaspace.dk>,
 Jens Axboe <axboe@kernel.dk>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Keith Busch
 <kbusch@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240601202351.691952-1-nmi@metaspace.dk>
 <d6999fef-aadf-494e-ad58-f27dfd975535@oracle.com>
 <9d68c7c1-b1e6-4f42-8d4b-8c986ab688b5@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9d68c7c1-b1e6-4f42-8d4b-8c986ab688b5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/24 16:59, Damien Le Moal wrote:
> On 6/2/24 19:57, John Garry wrote:
>> On 01/06/2024 21:23, Andreas Hindborg wrote:
>>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>>
>>> Block size should be between 512
>>> and 4096
>>
>> Or PAGE_SIZE?
> 
> PAGE_SIZE can be larger than 4096. But most drives are 512 or 4096 LBA-sized.

null_blk is not a physical device. Hence, why not to use 
blk_validate_block_size() here?

Thanks,

Bart.

