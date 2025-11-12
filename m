Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313882153EA
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971711; cv=none; b=KlhhA/eNUvjuisXfkIXiSwJorR5gNq63HUCOVUkEbo0ptWkbVKacf0YnDc5scAWCHt7geKrps7fHYRgZ1WwVv8gEoMiYsbywduGPfZozow1byUHzHY5bFqcZNyrymGrDuEeapr6NmQUI1Ydl1wZnjzywxxoVKujoNeytNskRs+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971711; c=relaxed/simple;
	bh=PHuZIjfdj9XEDfhSIEOirtTiqOftcRTVRao2V5rgpIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZCkkEqXmgJ6jf1/zSVqCxdQx7G/2KSzdMKOJSqD/TjVUP4gv24P1u/yVp2mfrClFDHroq50EL5MlbLD/ASnRhz7At7d4cQ9vrOHR0PO/yCNaWq27GLjm5ubrbMtbXa9zLxbAzscZmzzOqYQjda8BcKu157mAVd+TqO2YIDWqDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nF/Ae+oR; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nF/Ae+oR"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d6BZ40q1fzlstQW;
	Wed, 12 Nov 2025 18:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762971706; x=1765563707; bh=a5HLk38HQaxwEbjArpfepbVc
	xmYOC7LiwtY705rfkM4=; b=nF/Ae+oRvsZ9OzGQda1ODwum/4IzDARL1BztzSaS
	zhvSKRi6pRyQ9T6cMswjKUVK2oXiYzgLA+EYjavGac0YuYwL1PmObZHeObCfg4IV
	9ZTnxL0IsFi/vRIyS8aT/m945O6ri+PLJ+7YIjF3VCBxr0T5svlZfDzomRLxcYyh
	erhHkVFnuelv+VA6zTOPPexJ11yU7kEbybY0tdkIoEGGf03XbvmwqaTagxQ+tZw9
	EEVlCQZ6KvVnmbbUsbJ80h9+xS/0D0k3GQeijbH7W9KVSpPKJ5XHXG1gNYHOX5EW
	9bc83Orh8lMCJ47kGcgSGokYFfZyK5tUUJ5IGEIKkvcGNw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ymLSSi-EYyv7; Wed, 12 Nov 2025 18:21:46 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d6BYv6fG4zltBJL;
	Wed, 12 Nov 2025 18:21:39 +0000 (UTC)
Message-ID: <4cb772db-1e97-4796-b75f-de3650fdc485@acm.org>
Date: Wed, 12 Nov 2025 10:21:37 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "null_blk: allow byte aligned memory offsets"
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Zheng Qixing <zhengqixing@huawei.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20251111220838.926321-1-bvanassche@acm.org>
 <aRPqoinLQjYFBJsO@kbusch-mbp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aRPqoinLQjYFBJsO@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/25 6:02 PM, Keith Busch wrote:
> On Tue, Nov 11, 2025 at 02:08:33PM -0800, Bart Van Assche wrote:
>> This reverts commit 3451cf34f51bb70c24413abb20b423e64486161b and fixes
>> the following KASAN complaint when running test zbd/013
> 
> Can I please just get one chance to fix it before a kneejerk revert??

Of course. I only posted a revert because I knew that Jens wouldn't
apply it immediately and would give you the chance to come up with a
fix.

Thanks,

Bart.
