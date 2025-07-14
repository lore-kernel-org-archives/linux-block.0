Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC856266EFB
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515304; cv=none; b=hkbiQHVgS1jE5skXa29rzCPnUc6aHXVupvsRvtBh30jeMxQg6trQMhIuaE3LKu0ECI3X3sk4f2iKP2fY91MzURDvg1ocrLfwIqTM3f1MpIbtLzfOysHttZbawiuUgZi61WdbzLU68fsOcXu0ua+JeJYIml4N77G2bNBV9ItOeOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515304; c=relaxed/simple;
	bh=XxE6j9RFq8s5d+wIl8zFJmN32XBFZN2wEswJYKrQ/7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epnVHtowgMW+Cye6U+VAybiyMJvCBO5aBPPn8ocvJPUh38Vm29yOGDV02migmWnfjkf0CqtaS4rf0drE++jQSkPaa7r4aeRU5J0SzXyyRaC5Rast5lTkd3vD9WxpMVUzkrfH8Nf8ywX0aNUuacAnkkulrjhY/u5goFqS9vUopcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=S/JPS3qa; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="S/JPS3qa"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bgqYK69pYzlgqxr;
	Mon, 14 Jul 2025 17:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752515300; x=1755107301; bh=2C7DY0fp8chZj+I6OjLQ9aah
	jllQgCd8qIDczWiWMZE=; b=S/JPS3qaPUgahdCC+hdADXOGzeWdUd9vxGUie9Fc
	F7E2HGQ9oN+ceneAcG5t5wu3VRx0BkXc0BrQcH1Exvx2I1XAp0uozwBNSNHCQ1p/
	vJqCOHGjBck6piEIhTUr5zVa/Ns50QqDhYhIB9tX3Z17vfOt5euUPb3LDLaVT+js
	PIF+AQCwErTg5tKHbR5nge/W5JCXCJ/Tay4VD8lWC69gOGWOLsW/7ZpV0K036MBi
	G74XiW7TxJ6jyqnxv2wkgxXBC7RrYe/1BnoFXzPSu07T2qTETPrERWllhe4qtEFm
	plc2jw7vWXqRq7ubyHJF3z47PJ2Sy7wbve6C/zV/BYjxFg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id RQ9IpzEHod0y; Mon, 14 Jul 2025 17:48:20 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bgqYF0GBVzlgqVm;
	Mon, 14 Jul 2025 17:48:16 +0000 (UTC)
Message-ID: <c0931818-2f55-4311-b1b9-9d045713e1b0@acm.org>
Date: Mon, 14 Jul 2025 10:48:15 -0700
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

This output format is confusing. All other block layer tracing code
uses the notation <sector> + ... to indicate a starting sector and a
length in sectors. Is the segment information relevant enough to
include it in the tracing output? If so, please use another way to
report the number of segments, e.g. "BIO %llu, nr_segs %u".

Thanks,

Bart.
