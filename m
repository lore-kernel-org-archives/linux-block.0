Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B844E1D63C5
	for <linux-block@vger.kernel.org>; Sat,  4 Jan 2025 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736029854; cv=none; b=qhzcqdJRM0T8h1ownIbR1o5Vn7iTdCxwca4SwRNgfK5JwCrYo1J8xBGFvwYIqCyDCw6gRjj3OGlDqm8rpoR/wwXqriVm+5sqr27Pfgch/X5hy0tOM244TkA+ZyAOzJg6YHDcl8BVW/qDV0jHAjHxQAA9zILx584Tfg+B0KEVVO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736029854; c=relaxed/simple;
	bh=qSzgXugY8+ywSHYX0Jh5DiSY9/RYR0BqmD0qJojkzEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqcVTqmHNkRliygnbFzprIlaNh7outsut8OgRulECmaLIOcY/bmsQC8AXOr11ziW5eERn2Ci12EqIaQ3J1J229G5SVJnM6o4BvJHCHiM1XV6faTyfvPHe7vuAm0f5XiuxTfe+993IM9pG9r43Zl5clt1Vv8QhNQzyHo6FQ70YPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=MpohBqgi; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="MpohBqgi"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YQZsQ6Xj0zlfflk;
	Sat,  4 Jan 2025 22:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1736029848; x=1738621849; bh=t+6/jz/0ZK+YrvWJBp82+/p7
	hn2yXaPORGwxg5VN618=; b=MpohBqgitUAl3IUoOIoWXe/d9pjUqevBNgNTn8gh
	DN+Kg6DDxFpeLL6RZR0G7R4AJx7fGPKslwVfKPzjamkD7ZDb2Fs59yoB0yJ2MrKI
	dl1HiEeA01k3aZU0xtQ93ofkKiOqFHPebdFDl4u16GUQRqJzweD3R/tjUIy03w2y
	e+CzHVvxry6WWurba/qgY8l1v5YUqrKyFRN35sMO2nqb9VlSUOIpo2kr6Sr6beTV
	9EnywlIJHWVvgLIg2fTbafjexqAP1TyKXe1hlG1pHS+ESpXS37pNg5VsIr3/zVrw
	NpMf5vtuGaPTK1xL4iCThQqY4ZyzYuiDkCCJSNigqE8D6w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XP1LuN8MIRqh; Sat,  4 Jan 2025 22:30:48 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YQZsJ66HmzlfflY;
	Sat,  4 Jan 2025 22:30:44 +0000 (UTC)
Message-ID: <cbda6cc0-9781-4214-a6fd-e9852141bd64@acm.org>
Date: Sat, 4 Jan 2025 14:30:42 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: make queue limits workable in case of 64K
 PAGE_SIZE
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
 John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>
References: <20250102015620.500754-1-ming.lei@redhat.com>
 <0b423229-f928-4210-9351-dca353071231@acm.org> <Z3X-xMeMuF8j0RDA@fedora>
 <0b34bfc9-2cd3-40a8-8153-3207a6d62f8c@acm.org> <Z3dFBQIiik6FWLut@fedora>
 <1b1bf316-359a-4bec-8195-0152cd706001@acm.org>
 <Z3iTFSBxKY4Z8xZg@bombadil.infradead.org>
 <386a5388-1b1b-4e5a-ad9c-0da1840f12ee@acm.org>
 <Z3izUEIPTdvRg5Xe@bombadil.infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Z3izUEIPTdvRg5Xe@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/25 8:04 PM, Luis Chamberlain wrote:
> Try aiming high for a single 2 MiB for a single IO on x86_64 on NVMe, that is
> currently not possible. At the max 128 NVMe number of DMA segments, and we have
> 4 KiB per DMA segment, for a 512 KiB IO limit. Should multi-page bvec
> enable to lift this?

4 KiB per DMA segment for NVMe? I think that the DMA segment size limit 
for PRP and SGL modes is much larger than 4 KiB. See also the
description of the CC.MPS parameter and PRP Lists in the NVMe base
specification. From a system with an NVMe controller:

$ cat /sys/block/nvme0n1/queue/max_segment_size
4294967295

Thanks,

Bart.
