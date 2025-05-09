Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE50029374B
	for <linux-block@vger.kernel.org>; Fri,  9 May 2025 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798390; cv=none; b=dswXYI/F1Uf2GWpljUdUAr/DSUp9McyYDc/uOcX1RtVirHp0/pR4BYXD1CLNcuQqeUnZRieqK4eZl4NL9T+8DRbIe7GUb5gzyJMh7fwNnNge96YlT0YaffIsYbnqTu6t3DuOQRY3UPDgULLr0eDgEmvz4+b888NEkFWhVQBYC1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798390; c=relaxed/simple;
	bh=2CjDjbRMyEF4ElRBzkF3KlMiSTJCzZ0dnKFXtnBxLNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q21QJRGMxUw9iB2lB4zrnBlayWRgJ7ITlcU0FXb6XpNew8Bbl/0NnxzqssZm9/1I9T1NnDbaJGII+cywEWrpRJHSx80Ra5rB1kreHZQ0VRXH4JOsoFzzd/zEIJ6myrjBfA7MXztH0+p4p0S7Su2wh8mHASHidZ13oONkxpVBqCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=yzB16izc; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="yzB16izc"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4Zv9Jg6JFjzlvBYV;
	Fri,  9 May 2025 13:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1746798386; x=1749390387; bh=YsHJN82mP4YO3gP/YmEdZ6fu
	IyA3u6PVoPKmLVJIcqs=; b=yzB16izcidg1RkxDkflE1WK5Va2Y6KxJmWliF7HD
	DyexDbG3TKQU5TJ2jHs7EyBc0cHa51WrqUO69XrCVPMNEWbXr5mWM+qIr5eqHKaL
	S/vNfZ6YEHHIFamcMvVYf0pIkZEvPYu0DuWs/1OJZilOVAgXJi3zmg2S21i2ynpu
	z0StbT1Jfg/4McD7hDd04D5T46iCpbIk8R1bRrPWc3imIp2GuPhkQkeYQq+xw3RI
	ND1GB/gYto/v/yr0AF+Uq4KA2/UroL9aH7vML6CIqzc0IU4LLT2pd22dv1a3Bm2H
	cv59e5gz51zLC3dK92+hnjdROkxn4CID8XqbFlpTV7YPfw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id LTakaRrM6lON; Fri,  9 May 2025 13:46:26 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4Zv9Jb3Hz7zlvhyP;
	Fri,  9 May 2025 13:46:22 +0000 (UTC)
Message-ID: <a6b2d2bd-42ea-4bdf-80f4-299b28cc54de@acm.org>
Date: Fri, 9 May 2025 06:46:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] Submit split bios in order
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20250509004201.424932-1-bvanassche@acm.org>
 <aa288ae2-e9db-462f-993c-9079a9a0ffad@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aa288ae2-e9db-462f-993c-9079a9a0ffad@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/25 6:15 PM, Damien Le Moal wrote:
> On 5/9/25 9:42 AM, Bart Van Assche wrote:
>> If a bio is split, the bio fragments are added in reverse LBA order into
>> the plug list. This triggers write errors with zoned storage and
>> sequential writes. Fix this by preserving the LBA order when inserting in
>> the plug list.
> 
> Preserving the order of the fragment would be a good thing for all block
> devices. But what I fail to see here is how this lack of ordering affects zoned
> block device writes since zone write plugging will split large BIOs when a
> write BIO goes through zone write plugging. That happens before we have a
> request, so we should never endup needing to split a zone write request.
Hi Damien,

 From a comment in source file block/blk-zoned.c:
"We always receive BIOs after they are split and ready to be issued."

Does this mean that splitting bios happens before these are passed to 
the code in block/blk-zoned.c?

Note: as you probably know Christoph's patch series "don't reorder
requests passed to ->queue_rqs" affects bio splitting. The bio splitting
code pushes bio fragments onto the plug list in decreasing LBA order.
Before that patch series the requests pushed onto the plug list last
were processed first and hence bio fragments are submitted in LBA order.
Since that patch series the requests pushed onto the plug list first are
processed first and hence bio fragments are submitted in decreasing LBA
order.

See also 
https://lore.kernel.org/linux-block/20241113152050.157179-1-hch@lst.de/.

Thanks,

Bart.
