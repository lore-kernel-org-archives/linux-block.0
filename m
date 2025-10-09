Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C53728850F;
	Thu,  9 Oct 2025 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760053228; cv=none; b=eQYVylonX4EE4s7EJapBCo8MhhgfKzx2NYIHXhwVygSu1kOhUCmey/+xtXINSvRVx7qeerX3KZuXqsOmoojitdTNzhogwWEgBdu+ZTGPw/OB1AWgsApEUbvDVeBeaDpmy4Wd02dgGAzVIavjc4LjZNnbCB4zWv1I7IgizkorNnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760053228; c=relaxed/simple;
	bh=jbXf+oYCbVfnN9hCBEoXYickNFcUbhVgCGfXK6UgfYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EliBa+lSXMIBYiVLpzcILH+CTdPJ++oOuuEj069A/FVFgqVKJXqZkqxxnOWblFonQ9dQpZ+shyTFKtZYz1244vPfba+RyI9t50J4JS0UGqSHf29meGMZEcdIgS+ckdaDI4KHFuxB0BMmHKHFKeHqIWuG7gjiEKiyO4zZgs5ySXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=dSAyVX7V; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="dSAyVX7V"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cjRFP75nDzltKFn;
	Thu,  9 Oct 2025 23:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1760053224; x=1762645225; bh=yTHDZEo4xkKcumLOfsHylHgL
	/jrJwym+SE4lLdqXNgY=; b=dSAyVX7VZCVHuOzIqDyd7VcdjRatL6Aozqzh9sIp
	sJtazL044OBVOflbfKOzza/CVOClB/cbBYwhWMyTy4zEwNUtpB1r6Z8yxx9nb7gP
	D+Af2eLm+l2orUmsjxGoPyZPNtdVmTE9AgbewybZcwOEs32iyhvNiQM0gOyxktwe
	P3ixyOdiT/gOjCtpDce3Ja1MZRKTE0DDkNJEpOR1QFtgSSOVxkrYsnKR7fm1aP1M
	7F3+Pu2FK5CKuNnNIojW0AJblLqESFonsd4jRX5IOneXycDskWoefcykcU5gjCUB
	yUIRaZtKzlETwT/xwWP8TkXwabotz7nIUHj1WbKJFr0EyA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IxN8B9_CWxTr; Thu,  9 Oct 2025 23:40:24 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cjRFH0Lsdzlgqyn;
	Thu,  9 Oct 2025 23:40:18 +0000 (UTC)
Message-ID: <8406f13d-d8be-4957-b1ec-6996f19d32e9@acm.org>
Date: Thu, 9 Oct 2025 16:40:16 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block/mq-deadline: adjust the timeout period of the
 per_prio->dispatch
To: Damien Le Moal <dlemoal@kernel.org>, chengkaitao <pilgrimtao@gmail.com>,
 axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chengkaitao <chengkaitao@kylinos.cn>
References: <20251009155253.14611-1-pilgrimtao@gmail.com>
 <db87a85d-e433-4daf-97c7-d5156849db0f@acm.org>
 <bb362d12-b942-48f3-8414-e859cebb8862@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <bb362d12-b942-48f3-8414-e859cebb8862@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/9/25 1:21 PM, Damien Le Moal wrote:
> There is still something bothering me with this: the request is added to the
> dispatch list, and *NOT* to the fifo/sort list. So this should be considered as
> a scheduling decision in itself, and __dd_dispatch_request() reflects that as
> the first thing it does is pick the requests that are in the dispatch list
> already. However, __dd_dispatch_request() also has the check:
> 
> 		if (started_after(dd, rq, latest_start))
>                          return NULL;
> 
> for requests that are already in the dispatch list. That is what does not make
> sense to me. Why ? There is no comment describing this. And I do not understand
> why we should bother with any time for requests that are in the dispatch list
> already. These should be sent to the drive first, always.
> 
> This patch seems to be fixing a problem that is introduced by the above check.
> But why this check ? What am I missing here ?

Is my conclusion from the above correct that there is agreement that the 
I/O priority should be ignored for AT HEAD requests and that AT HEAD
requests should always be dispatched first? If so, how about merging the
three per I/O priority dispatch lists into a single dispatch list and
not to call started_after() at all for the dispatch list?

Thanks,

Bart.
