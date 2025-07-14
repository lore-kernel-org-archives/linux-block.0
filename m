Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440BB13D521
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752528787; cv=none; b=QBKQuZHsk99KrTVQxIpILgGeLk90I9ClIBRSJJvWsyHnYPfH4qW9+833TAh/EhPWdCTPdNb+PTJ/0z0ay2zSJyHiXXMLFTPbcVVVhTE+g2ZpINFi4S4wZJqFaSKnLYiCdLT72GYbtsTk+VZG2y8AsJMAfbypCktWyuyI/0dGeoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752528787; c=relaxed/simple;
	bh=qPiCPI4soT5I10K5g1Q+Wc01rVueLXCy/9CUKeSmvWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGy128o2tt5IPlXpLcxrYzxplZNlvjRwukvQUPd479D3pTo0BVvD70a4pYrjgnq8AeRa0D3hkUgU3NiL84JLzH76tAJk1QMGc4uoHEkZB9eyv4GvK2pTUONK/e7jJ+3EZ7mfPtzgZB5+sAcWCoqKa9wgEw5MF/TmcbLxgEzG7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=q/jNeYey; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="q/jNeYey"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bgwXd10XKzlfl2l;
	Mon, 14 Jul 2025 21:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752528783; x=1755120784; bh=9cCQFozfJw3Fs2AGaFzHP+Qw
	IJgE9ei6RNMRq7r8TIE=; b=q/jNeYeybfbxCe+ASgOZw1o/K3Axy2kEj6bue//M
	CUq7OE3yFUhg6LJjR/THTvdtDKwd5UUm80AUDWAcP0qc55un2AKwLbpws4xAwPo3
	TzGJDKy8Kz3gzBWQpJGkQJQuwIzbhHo3OD+vENyo82FkEDt8VTnOnpsKPzw7sH5L
	xfq35iXkq7uxFV6IdLFO2YEnD6p/XuegcckWTihMJh3kQmIzPB7u8SeKcN52jFl4
	X4GKa6A37NOg3fzzW2THKRwrzAdB3CuIrP9fFoBtdk+f1O6o8x9znaNG7nZ18A0r
	onY85/kAkwmOhsoj+u0w1FqYXFOAwhLhec89G3+HVMZtQw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nsnMX3aGmgUe; Mon, 14 Jul 2025 21:33:03 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bgwXX4znzzlfl5C;
	Mon, 14 Jul 2025 21:32:59 +0000 (UTC)
Message-ID: <780796cb-dff0-437b-8959-9ea7a5d80f52@acm.org>
Date: Mon, 14 Jul 2025 14:32:58 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] blktrace: add zoned block commands to
 blk_fill_rwbs
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20250714143825.3575-1-johannes.thumshirn@wdc.com>
 <20250714143825.3575-2-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250714143825.3575-2-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 7:38 AM, Johannes Thumshirn wrote:
> +		if ((opf & REQ_OP_MASK) == REQ_OP_ZONE_RESET_ALL)
> +			 rwbs[i++] = 'A';

                         ^

There is an issue with the indentation of the assignment: the space
in front of the assignment statement should be removed.

Thanks,

Bart.
