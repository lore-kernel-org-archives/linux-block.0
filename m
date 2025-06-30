Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1AB22126D;
	Mon, 30 Jun 2025 22:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751323167; cv=none; b=eB4ru204ROH8K/H0Xt8u9NJqZpVzIMWawr9DwlwjGOAm950TXhEVxnDjrQblPifDyGEQcpvJANlfz57Q5/gmlq9haXYF2T/2kI4atWXW3JY/Cnl94TSybfGPXss2AtvU9f2oXd4zdTwQcP0dho0Zldj/6b+j4CT19AKy9yg5qj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751323167; c=relaxed/simple;
	bh=2xdjdOQKomXsxP9+iR9VxL7+uBDsi2GWt6D1C/io5SA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDDODE5EZHgBvGufQTf9B7MK8bjBmKPoCguxuF0jTA8E2lY7qUFGvpv6h2YKPOxWvVFdV/1S0+gWZWJBv2nRKyI2ZJJkcY/t3qVUyGCNUg/TVT6G8YLkQlRDmbOAeHztEC75rJSJl3Z+02GSAKBiDEYOirCD2tjuPIwLkYAh/pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OrP8XDd4; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OrP8XDd4"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bWLgc6QmVzm0ytj;
	Mon, 30 Jun 2025 22:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1751323163; x=1753915164; bh=oZNjZvTkNh1KPaAJ3VZeD6LM
	CEJfVfxyiAhL0Psd0MI=; b=OrP8XDd4ZrnmYtqBrFBEhJFg9jhQkwhRY0nz+Uqq
	g2ES0WyAlh8ot6r9Hh8t0k+02I5yTKPM6sM3YawSwPpZD6mSteT6qYYTnaXPkI3H
	oN14SrzvSg1ubTHy+DrfJZY1QGokZPXkB92VfM3/n3w5q96t8vhQuEWDLR1IBSPh
	H8r1btz/GwY0XL99/aFPIpM9EWr3x5hXqfyZ7Qa1OGjSS1Lb2uvNAz+dsXphHf0A
	HrGd5qphzgrs35SyaxkD8SIYkGoTOJnxYuwh5MjPZogH2dcvgTu2fBIy8Po9UT3t
	YL2t4oa8ypXw5cIQMFAh5EUJCh6mJhBWCIHoaicI2hw5SQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4lOKWCl6_5Ej; Mon, 30 Jun 2025 22:39:23 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bWLgX3vdWzm1HbY;
	Mon, 30 Jun 2025 22:39:19 +0000 (UTC)
Message-ID: <d03ccb5c-f44c-40e7-9964-2e9ec67bb96f@acm.org>
Date: Mon, 30 Jun 2025 15:39:18 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Fix a deadlock related to modifying the
 readahead attribute
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Nilay Shroff <nilay@linux.ibm.com>, stable@vger.kernel.org
References: <20250626203713.2258558-1-bvanassche@acm.org>
 <20250627071702.GA992@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250627071702.GA992@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/25 12:17 AM, Christoph Hellwig wrote:
> Well, if there are queued never completed bios the freeze will obviously
> fail.  I don't see how this freeze is special vs other freezes or other
> attributes that freeze.

Hi Christoph,

Do you perhaps want me to remove the freeze/unfreeze calls from all
sysfs store callbacks from which it is safe to remove these callbacks?

Thanks,

Bart.
