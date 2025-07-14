Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54BC24468A
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511421; cv=none; b=c91GA0tixLbPx48KMA44AvooTxjPHps/wHv1qxco1Zw6yi13u8YeLSGjTvMe3NFusxNRz6qDxA15TCD3CanDPA81+CSFJlFXOEndnS0GNAPgUIGfT74CaMbWvvlcKAix1WYYe2fihhTC9Aps4rQhg0thtBBR40IS8SBmP801e+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511421; c=relaxed/simple;
	bh=IQCh/qR1QSX0Q0FwxLpuG7XiDATXrFrI+GdBp71CY/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9AR/LgRqwCXIXN+hGCaIFbmCjx+qZ2NJ9MgPDEIlLTueiZp+9T/J33diIOO7pN1pNXQ5STQdx3wj+qrQsA/5tBekyF4dsdsP/NhvF1pLmoLyBeFKZycPp3lrWfS4Naxff3XSVLX3oFWmSc2F6yetvGxVQ6uXxFOP02QRAWuIhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=x22LsBC2; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="x22LsBC2"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bgp6f6QfbzlvRxg;
	Mon, 14 Jul 2025 16:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752511417; x=1755103418; bh=nUlIxYmiYCt2JGlG7d5yeEmr
	XY4rq0JQ/eAwEKTvOBU=; b=x22LsBC2k67R0gPwMfgVfsgvkxvwez82Q4f9F3IQ
	z27iEp1qTu/kxPD5hnErv7/Bpi1kVFjTBMTMDQ5NQuy9LAX3gnah0BWQmTZ3vtd9
	QVAwACpfYCkE7mqEGRHmyDB1HuV6fCNKlUzSOKW+MCJYLAwUg+X3o6gu3NvVltam
	/QyElbjy1y6tU79eppV8uvm/FwvlIsvawgUi0Japx5Dh3AXdSWxgGOo/k0NHUdSp
	GuXQEhKm5mIGAjHCEMFFLVUGejthpDX+oZ6/m0Uyx13vog21eBJhrYOs8ElXD+5F
	JJEsIvCp3GmbxEjKGay8Mb2Vd4bto82Jq3cyiMcxbAPm1w==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IWffXPJfmKR1; Mon, 14 Jul 2025 16:43:37 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bgp6Z3NTczlgqxl;
	Mon, 14 Jul 2025 16:43:33 +0000 (UTC)
Message-ID: <72643230-7825-4482-81bd-d6f25c854d9a@acm.org>
Date: Mon, 14 Jul 2025 09:43:32 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] block: add trace messages to zone write plugging
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20250714143825.3575-1-johannes.thumshirn@wdc.com>
 <20250714143825.3575-6-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250714143825.3575-6-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 7:38 AM, Johannes Thumshirn wrote:
> +	TP_printk("%d,%d zone %u, BIO %llu + %u",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->zno,
> +		  (unsigned long long)__entry->sector,
> +		  __entry->nr_segs)

Fifteen years ago it was essential in kernel code to cast u64 values
when formatting these with %llu but that's no longer necessary today. I
think that the "unsigned long long" cast can be left out since nowadays
u64 is a synonym for unsigned long long in the Linux kernel. Otherwise
this patch looks good to me.

Thanks,

Bart.
