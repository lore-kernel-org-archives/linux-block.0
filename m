Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972E2358399
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376193; cv=none; b=FJBrlejVZkcLmyr88y5yrw3dgwHcOValtnRlbRdt4AX1/emyDR77791xGSiFimJyGc5SoviVotk9RJ2GG1s4DmF5dFRVsP4gCa9Lh56z+Lc6ZyHQH2ldsHpOfOR6xBfPQfnZZ33NDZRMFWvYhHQmAOKM2NgQoovEsL1O3YamwLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376193; c=relaxed/simple;
	bh=zyd5SrEod9oXFEjjIdxcBRPh74rz70rAG39YwIl83Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qw6+hlq+Ej02WqywDDKeR1qtwe+HT4t2Nqmmd53E6DLVoHsIZnYIRCsdxryll/OIwYf5DG+6+LrDN5487cZvYyXrYSqjqGim92DJXnmeBK+6CNyFjN9tWrNOxj+frIU8YN/g/+72a0C0OICxMbUOKxp2FIRMdVd4AhNVZEvyf4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=A84x7YQV; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="A84x7YQV"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hJf4H07H2zlfvpG;
	Mon, 10 Aug 2026 15:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1786376189; x=1788968190; bh=zyd5SrEod9oXFEjjIdxcBRPh
	74rz70rAG39YwIl83Yk=; b=A84x7YQVyDzT4xHeXdxnnkrD76B15R/Zvsw4U4sf
	gKa3mHq6EnBW8dhnbltB7nLfxpiGgcad+1saKxzVJ31SdzDuarWcevDQ2TNJgw1X
	jFqlZ/g4Lg+Qscg2fUSqWQSgiE5fJYNdb6LP90zubrOF8fMnu+1tfbze70atp8v6
	PFlBKya6dI9VCbN8bzCQRNx7B9dr1Zt/2izlc1uDdZkufD6JkjDQTHkl48stKTL0
	189ykr1ISFEygXEWUlBQ2Po8aegBBOQ/WTHu1Cruyb4epcEl3CTw+ImzKPpLMAok
	cYfF9ZH9KH0kKus1hVJj0WRjQaZ19oly0Vey9g0DnQq//Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4tb8p1oBJnPm; Mon, 10 Aug 2026 15:36:29 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2e3b:8:bf02:1d5:26f3:7213] (unknown [104.135.204.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hJf4D4HzTzlfsTl;
	Mon, 10 Aug 2026 15:36:28 +0000 (UTC)
Message-ID: <1ac031b9-1018-49b6-a980-11411886245e@acm.org>
Date: Mon, 10 Aug 2026 08:36:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't include blk-integrity.h in bdev.c
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20260810144603.453283-1-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260810144603.453283-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/26 7:45 AM, Christoph Hellwig wrote:
> Not needed, probably since this file was split out.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>

