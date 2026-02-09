Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D98261B80
	for <linux-block@vger.kernel.org>; Mon,  9 Feb 2026 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659523; cv=none; b=ma7ZTcR4VX5FFcByxpGDsI1evN62F0p5E+P63VFHJ15rQd1zr7/RC7H4ZL5e66DpMFSu6U4XfQUPg4Z3rWg1DG7edEDj7vrnXCdw2pQCanqwrpYPnVzg2ywQqHmC5qc/UeBfN2ATByfJEbXyh6cdeCqr3jZZhfJWejk1+/fa0NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659523; c=relaxed/simple;
	bh=wWRw45vxPzMf6IUhlILMEm7Zh4ZyPMbWLX+8yExKoms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfzEiUu3J7oi7VgnOjU6EHTUeWUB2jjLB2bgUwE+pGVnjp5ihuK8lIwucsKA0hKh9PdbXILllnSCGPUzjlhd3Vo02+nVj4r0FgmiNiwK5JGEWcwv41Mwmw+BAc6cEsNmmxsIrp/IWLeOrsP7uh6JaNNKdvurnWyoaOVX1U7jUO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nP4ebFiQ; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nP4ebFiQ"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4f8shf57YhzlfjRv;
	Mon,  9 Feb 2026 17:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1770659519; x=1773251520; bh=wWRw45vxPzMf6IUhlILMEm7Z
	h4ZyPMbWLX+8yExKoms=; b=nP4ebFiQQ+2ePiCZoz4k648cjcCDTBFzscyxKGIn
	7b3wEZiVYGWZxiPLtNJ1UL/6bcRmGZbbHqY1WKp4rN0wrTg1uHy3tVV/gE6qjk5G
	UOD2vJFwRLVUcnS6oETEE5cp7e0hVKxLzGfXcgWHH+mW8HdlywkrO95VhDWhHm37
	4nL0KlB2K1irwnzrgipoTFRGaBql2aGnkJJ7EECoaSVwmUMR/JaUEoXLlY2jXCYE
	jQF4PjrRZXveqvZ3b3iP/+qgYrAAMWXiFM9C0KmCuXzdiKJcDoY4o5M6KbscGm/r
	jtI2RWcxUXMmmHfoDcj3+FLDel7wRkpGE8t7E9VDcKScOA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id toXWEeWDQ0M2; Mon,  9 Feb 2026 17:51:59 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4f8shX1QN1zlfdCr;
	Mon,  9 Feb 2026 17:51:55 +0000 (UTC)
Message-ID: <b2069052-ac7d-46f6-bdd5-a96533144f9c@acm.org>
Date: Mon, 9 Feb 2026 09:51:55 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] blk-mq: use blk_queue_enter/exit to protect debugfs
 file creation
To: Keith Busch <kbusch@kernel.org>
Cc: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, sven@kernel.org, j@jannau.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, tj@kernel.org,
 nilay@linux.ibm.com, ming.lei@redhat.com, neal@gompa.dev,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-5-yukuai@fnnas.com>
 <6b18e0bc-efa7-4bd5-b12b-a313941d2ba1@acm.org> <aYoaWwI-sl5hK6s_@kbusch-mbp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aYoaWwI-sl5hK6s_@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/9/26 9:33 AM, Keith Busch wrote:
> I had to look up the original commit that introduced the WARN,
> 65d466b629847. The commit message says "Creating new debugfs entries can
> trigger fs reclaim", so that must be the path that enters back into the
> block layer request_queue.

Thanks Keith. It's probably a good idea to integrate this information in
the source code comment above the blk_queue_enter() call.

Bart.
