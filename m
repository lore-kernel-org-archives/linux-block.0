Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBD91B0424
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655775; cv=none; b=Fvhy9EPgCbWqRDUVfEH92nnZe24LoDPqBCd5qjjMCFOcBYrTw4vPYHqKm5zXfEOCtBD/CE4eiaSiFhBpq7bHftaRSvVk+QDFYge96H4cBHq3KhNCvJYitMcLothshnBgv+uIB/t3EfY+BSsQ2+pKc8gHYKA3HbZOnD27YNJ+0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655775; c=relaxed/simple;
	bh=/qXs0UYVPs4buiHGgtBktVJq7g+Wr9zXW2izfglDzt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKb1AZLWsKcZB5bOKsWvXN55/0HC+o9aAZMApw/c/Te26Zh76jTtKsWz5cBv9ZAxK7ylTrL7uA5CuzwVwl8bIpA/nv2O4NsVlg0kXlJzoAEJlk/KeH8iZc9PKj1hNa2G3APi2UdOW28jUBXlHg3Oezr3Y+T3DTzTUI1o0CcE2EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Al6LRx8a; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Al6LRx8a"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bHV2N3mR5zlgqTt;
	Wed, 11 Jun 2025 15:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1749655771; x=1752247772; bh=kq+x84AbNC3SWb+ObG5bgczu
	X8mZHYTpqwfDtMoBi/Q=; b=Al6LRx8aGNZG4Aw+ccVdA3EyXitiRtRLYDDlVoO4
	NGqLIhQSneCIgyXTDJjv2rJfGfAaFJLzOcVRJmWWwZRdiF8xbGSmQuCkLILc+vIT
	eBgQZujzOkQr0C/GuW6Io5w029y//W2aVim49PtZNVEVWZ5r3Ety7z9aFSryYgOf
	/5kV9SlzHf0eGKExwvz0cRtuCVjUyKO1mK08/343DeRvqo1Rce92ZkvAPNEVAg6b
	t3a7lzwhamqK+i6lDHEr6h1zxUY6gG5lxY4GGm/h+qrPYZbMmvhLKZuDgoQAvpGA
	pFsl5mzajtbAYrXMKhToC8vQzf3imVa3NhwMdYD8/YC1qQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id g2EcMmaA3m3N; Wed, 11 Jun 2025 15:29:31 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bHV2K68CvzlsxF8;
	Wed, 11 Jun 2025 15:29:29 +0000 (UTC)
Message-ID: <f10b55f0-8aaa-46f0-9fd3-36c4acd038ce@acm.org>
Date: Wed, 11 Jun 2025 08:29:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't use submit_bio_noacct_nocheck in
 blk_zone_wplug_bio_work
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20250611044416.2351850-1-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250611044416.2351850-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/25 9:44 PM, Christoph Hellwig wrote:
> Bios queued up in the zone write plug have already gone through all all
> preparation in the submit_bio path, including the freeze protection.
> 
> Submitting them through submit_bio_noacct_nocheck duplicates the work
> and can can cause deadlocks when freezing a queue with pending bio
> write plugs.
> 
> Go straight to ->submit_bio or blk_mq_submit_bio to bypass the
> superfluous extra freeze protection and checks.

Although this patch has already been applied:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
