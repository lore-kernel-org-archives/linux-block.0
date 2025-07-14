Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771B954654
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510925; cv=none; b=lqPMpbLS2+ep/yVpBVaaSI2RIU6iMQDNZ5oT2LYLMqL9AuhfJIaF0aXiiuQr5GOj3AIZj7hVdlrq2oX33p0ZPwCKtctk8lX3IpM7tdyZHnAS4RWwKkYpUynFGxe2JhdNMRmvE/LVQwBPbxAtRJkrtPf/fxJHg3djrTnTLGid37c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510925; c=relaxed/simple;
	bh=jTvZWXFcwJXWcWkz5Q2fTPVABCLpO8AfuUQg8zA8RDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GemZDKZwScNpDTiPOGsa7QA+eZQ0bgqdm/s1dSjfGk0hOAUABTlDn4DMEcejMeMxkcZO8EUwrfPhdSKoLNefek4zP58PiEoxmiu4dDpPzYxTvUjNJ2nmfZb/Xd8FeePQOk1BHwhAU0NjUmAZb+3ZKTkDcnYsfmZKwdqPDqCAeLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=FjkRkwPd; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="FjkRkwPd"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bgnx74Y5hzlvRxQ;
	Mon, 14 Jul 2025 16:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752510922; x=1755102923; bh=jTvZWXFcwJXWcWkz5Q2fTPVA
	BCLpO8AfuUQg8zA8RDM=; b=FjkRkwPdurUCiHyVNAXlZbFvtxFvMsqhBxxEMDad
	KG/tOisw7WKfw+xox42D631onZbT+1+6tvqD7kmZkpXHGWBYvLJ7t0t8kfxhjQEV
	Lco/wWTbBXyYDTcJFGBjrAbfUwCtqfWvaY5Clc6bpF+/wcdKKVWGWBsbdtH93BQt
	MYgJfh1xGqVo1FBYodueECtNiHEcLJNwUcq/V0Ov6QlPPfuYW2OOj1Z/u+ox8kzm
	mipm1Fk+8yw+gWmwpIqWPZ6N5On2SeaHbtkfCU26b3QnjLN5Gf7KYiH8jHIJ1iUP
	HvKvXqTaOh+ZzlVkfW3ZRvwtixyj4m/cNEnke5Ol9FrOrA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rfISWhu9t36b; Mon, 14 Jul 2025 16:35:22 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bgnx32RPWzlgqxr;
	Mon, 14 Jul 2025 16:35:18 +0000 (UTC)
Message-ID: <e786b546-37c7-4885-90cc-8072147949e7@acm.org>
Date: Mon, 14 Jul 2025 09:35:17 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] block: add tracepoint for
 blk_zone_update_request_bio
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20250714143825.3575-1-johannes.thumshirn@wdc.com>
 <20250714143825.3575-4-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250714143825.3575-4-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 7:38 AM, Johannes Thumshirn wrote:
> Add a tracepoint in blk_zone_update_request_bio() to trace the bio sector
> update on ZONE APPEND completions.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
