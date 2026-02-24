Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FFB27F195
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954568; cv=none; b=T5OwjpfUdgvsxloyJNlff7tDLAkgD6buee+hpUrAWh+Ddx0S918Fpp07EDL4UEvYK7q6tqsD5ERnobaD0cNZjMxG2eiJbw+zBwag7vZQE8Nzq8uKZCod5a3BNVNvUUMwqZ9HhpcPLTVlwQDJBp3NO8/2KbclOjBC+U0/NeaHd88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954568; c=relaxed/simple;
	bh=6XdYx0ll96r/9PHYVGFbH6GQJAet6X2zBwmrYSdRnks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFAfoKsuk5jxI0UHG84yEN5khfbZeJxjC01JiQAr93fQiQfJGQAyIvsRvOzPCqZUx37uZwoEgCYR9v2fBCZG8stKpN4/2KIfI47nzjOTsNCwJnp2W+c8tVYJSqpnkFOlvMX3KJ/cblxxU95QlNY6szXd/g+4DWSnMf0IRk4w1wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WFLYAy0q; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WFLYAy0q"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fL4dF0vzfz1XM6JH;
	Tue, 24 Feb 2026 17:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1771954559; x=1774546560; bh=sCuXJErpB6ccgPbxAJ7vRQYq
	iXF+3dWL62NGg9Wamhk=; b=WFLYAy0qfWEZdQDeV3HQJIcHuqQNe6CBFtJ2CoTb
	lqc47cxTMcgrLdsy101wpgkJwhqP5ebLKrZ8390tUBYPepPlLxLjIkJon5QRGf83
	bY0YXhnjX1GSAJONhmKgckp9fTOfZpkhniIhL8R6eiN0FOgieN/mZ8xRzfbdigur
	YScTWRI4tqylQWjQFyt9QXV0iIjwK4iwMdSfo9fnm1CAS94PJ0v84IXBSEqgCI81
	CUM7pkg5VakYRnKj5x9EbeADvk+1ejxRoDcEhF3TW/N7pzucCP/MCWFbkRz7d2tf
	N0XNx51461OPNgMLuJCFZITt6e7xHCil5ZAXv6bC7iWbJA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vnInxkX2GhW4; Tue, 24 Feb 2026 17:35:59 +0000 (UTC)
Received: from [172.20.150.38] (unknown [4.28.11.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fL4d64mXFz1XM6JG;
	Tue, 24 Feb 2026 17:35:54 +0000 (UTC)
Message-ID: <acde6496-8df3-4529-8e3c-5f7fbe3ed377@acm.org>
Date: Tue, 24 Feb 2026 09:35:52 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/62] blk-ioc: Prepare for enabling thread-safety
 analysis
To: Christoph Hellwig <hch@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Yu Kuai <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>,
 linux-block@vger.kernel.org
References: <20260223214950.2153735-1-bvanassche@acm.org>
 <20260223214950.2153735-3-bvanassche@acm.org>
 <aZ25dOkJERXR2rCl@infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aZ25dOkJERXR2rCl@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/26 6:45 AM, Christoph Hellwig wrote:
> This is a series with 62 patches, of which only some and not the cover
> letter made it to linux-block.  You're doing something seriously
> wrong in your patch submission.

The two SMTP servers that I tried (smtpauth.mailroute.net and
smtp.migadu.com) gave up about halfway this patch series (quota
exceeded / too many recipients).

Peter Zijlstra asked me to split this series and to send the patches 
from this series directly to the maintainers of the affected code rather
than to send these patches as one large patch series to him.

Thanks,

Bart.


