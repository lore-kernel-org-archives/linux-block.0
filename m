Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BF21891A9
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508822; cv=none; b=gGmMjiL2q66fciJvHkEiwrZBkGDQI/1lOcEKJdJ58j92xXGxhT00OAl941Pf9ph/wHMVJnV7WE5xMFafW8Uo102cHXmnj67LAG6PIp9YDI3pGFEvNECdfh/YZtfOdQGe4QLQQppxPGlXuDwx3VwHq/1JliizRLfdQWG3XdKNugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508822; c=relaxed/simple;
	bh=8XsoBYhFIEBZTQkZs8vAgDbtzDYECANbIX1Ura7u8Gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dy28xo2IpT6XbxW9FH4vYlz9UBAQ23jTLfBK+DPDOto6oCqdXXcwq16PMPhh5fCqdds5uZatcXLMLE+cOTD7b4RBHeBD7ftrpzVZpbnAgjZGtdI9m7V+AOvsijFiFSidLNrrEhInUS6fM7z9NER+2XmRKRAx7RWdRwwDY9zLsXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=I9s9jytH; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="I9s9jytH"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bgn8h0bS0zm0jwM;
	Mon, 14 Jul 2025 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752508818; x=1755100819; bh=uNf8Syk7VFqbD7NXmtjC+Srs
	YGQRc3JnyU6Z9+cqde0=; b=I9s9jytHzoAVzrr1YE2Z3Wz88Jdsd//RZanW+oaY
	pmCuaKtWqkyVa00klIuE8YUXSzt9ujltlwjOGPknFHfBjg0YyJqipRrXZbTKZ44b
	b0QOTqYu48oMqvAXb42sD3+XdeyAWhSOJVFfL/wAhzKQeKkmRtLIn3UwBWWGNUbZ
	UtO11h8AnwM10bayAu2nGhZHAX98RmNYmnmF/IPlaRrzUVAeeUnsGYgRgdvAgjvw
	qxJKZPz87J9AE7XkCzyX5jGYpb9vHQautwbh33Irqpe3eREZrG+DVtj1V+SjhY4O
	+CbkWaC4gXJZMAgVJZkzAcTf0cUg1E1DXe1V6XATLRqZPQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zA1360iISh2S; Mon, 14 Jul 2025 16:00:18 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bgn8Y0ttHzm0gbQ;
	Mon, 14 Jul 2025 16:00:12 +0000 (UTC)
Message-ID: <87a8998e-ba7d-4ca4-a9f0-642d56f4682f@acm.org>
Date: Mon, 14 Jul 2025 09:00:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] blktrace: add zoned block commands to blk_fill_rwbs
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, hch <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
 <20250709114704.70831-2-johannes.thumshirn@wdc.com>
 <de8c6c73-3647-4cc7-a8a2-6848b2f4607e@acm.org>
 <07fa0a60-1541-4201-b4e9-b02a994c915c@wdc.com>
 <6e25e109-33bf-413f-812a-69a7f33e783e@acm.org>
 <c53e8414-f3ad-4eb7-8963-8532790ccbb2@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c53e8414-f3ad-4eb7-8963-8532790ccbb2@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 3:23 AM, Johannes Thumshirn wrote:
> Do you mean something like this:
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index f1dc00c22e37..ac30cb83067f 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1911,6 +1911,8 @@ void blk_fill_rwbs(char *rwbs, blk_opf_t opf)
>           if (opf & REQ_ATOMIC)
>                   rwbs[i++] = 'U';
> 
> +       WARN_ON_ONCE(i >= RWBS_LEN);
> +
>           rwbs[i] = '\0';
>    }
>    EXPORT_SYMBOL_GPL(blk_fill_rwbs);

Yes, thanks!

Bart.
