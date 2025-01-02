Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E8184E
	for <linux-block@vger.kernel.org>; Thu,  2 Jan 2025 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735785260; cv=none; b=sT2/fpy8t4AuR3rNh83XOaTJO2ShJV5DwC4VK/avobwzMAsFtnx5GNYtw6CVwqgnP8pnBcJPQsdN0MHMPBkXXu4qkoXop1/ImIwhhMBR8nWDabpRvFcKa9E+o+BUll7Q5h7hk079oSJjViAGcgCWLvKPlnH52LKWPWbQoLGLoXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735785260; c=relaxed/simple;
	bh=neQbh182/Vj5CAAhSvAo1QdjtK6pj+NdTX9tTpZmX8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GtgkmD3eM7mWsZ558c6pgpbCOmuL9Tq3g448VGXgiIXytwSn/0Fobzg/PnvHDSrYX+GNLjuz03VB0sm4Pp0UfN5vXrnTlf15+nDGJTCwtwq3sQGutVaF4TpIcag2OfCwzZTXrf4lSTI7caeLng2c6Q3mHOGJTuersneVpd6i5q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WQno930f; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WQno930f"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YNrKW0bwkz6ClbJB;
	Thu,  2 Jan 2025 02:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1735785035; x=1738377036; bh=wSBPS9SC25qKskmKmm35wcdM
	KMZDCL1U803BqmTv1t0=; b=WQno930f1LDE/4O6DFuZAvHllULAIBegCM/LO022
	D7oQKkMR/iUUuaUsjW9sugJCnQHwele96tE664BycLY9nagtgpraWz2VtKO2AC6d
	/wXsuTpFYpcZ4XojsXk8ej/QDBH0X+rva69ugOwMED/JEQrHa6uv1/0u4d6YiXzB
	jZyeYo3SmA9ZRHuq+mu6zfDJI9vN9XCgQ/U0t6KydZHrtksPARxWSbQhxQ1A4A/l
	40yNrBZNRJlysqXq9qNWRdQkx2n9IFPdjCqowPZ2Tvzh8FlKR1tKJU2i3tOmlJK/
	gsBozI0h72EnDaDFuCpvf1B3C/cg9pnY4iz6Q1CVts3XEQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id K0ATU3qzacRS; Thu,  2 Jan 2025 02:30:35 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YNrKN4sRdz6CmQyc;
	Thu,  2 Jan 2025 02:30:31 +0000 (UTC)
Message-ID: <0b423229-f928-4210-9351-dca353071231@acm.org>
Date: Wed, 1 Jan 2025 18:30:30 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: make queue limits workable in case of 64K
 PAGE_SIZE
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>
References: <20250102015620.500754-1-ming.lei@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250102015620.500754-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/1/25 5:56 PM, Ming Lei wrote:
> In RH lab, it has been found that max segment size of some mmc card is
> less than 64K, then this kind of card can't work in case of 64K PAGE_SIZE.

That means that that MMC card is incompatible with the 64K page size.

Additionally, this patch looks wrong to me. There are good reasons why 
the block layer requires that the DMA segment size is at least as large
as the page size.

You may want to take a look at this rejected patch series:
Bart Van Assche, "PATCH v6 0/8] Support limits below the page size",
June 2023 
(https://lore.kernel.org/linux-block/20230612203314.17820-1-bvanassche@acm.org/).

Bart.
