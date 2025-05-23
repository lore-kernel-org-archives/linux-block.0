Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A88204840;
	Fri, 23 May 2025 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748017145; cv=none; b=afOcOQwCNZuKgLZTcjBMjyReStkDStnDbrA2dvD1ZxeSIuWhjkX7Gws3chTmmspCg1g45plTgFaPnFrYOAO2dbIrfwTWwySgvLbN7w6sixEfcM14Z1qGt7FN2Kt7dpSDs5Rvs3tw9gIZookx46foZ0tboouVbfFiB4G0UrO+KAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748017145; c=relaxed/simple;
	bh=JN/5uR5X3K3OgdY/9KpRPnQP8EnZ/YD1LGLqRYwl6GM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJWH5K6Kljw5SEm2htKks79XouHpaYA+4n3yUrpgWzEKlP/NLq5igsNMU/cKxEXE0LTM7ZWI56BWnoPtk7DNoFmYjqXTybFgZ2T4Gu+HBS70vgbY/P+Pb+Ianu2sY7V9RWkBTpqTORv0EZ5LY8GqdUjKBuzKbDxT1Togs1pfqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=txG33X9D; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="txG33X9D"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4b3qpP0HSYzlstRB;
	Fri, 23 May 2025 16:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1748016523; x=1750608524; bh=JN/5uR5X3K3OgdY/9KpRPnQP
	8EnZ/YD1LGLqRYwl6GM=; b=txG33X9DR5LXxiWEoTvNGbISjhCSpKyMTF6RUf2k
	gNCzq2il6OmZxS7JFKMrrf7X2jcGvCMeNdz7x5lyfKH61sxCeDMqCWkjKobzybw/
	CtWKG+aiFeMSDn7tkHv64B8AZMEjSH5ztwlN2Wklxy+VKI7Bx8/WmnKDOJCM1mb4
	n7d1kp7OwQGga4FNgvKZDyLkOkKR1AgdfINJFQaRu99HP9KKxEWoJotAfd5esbMH
	S6tBTabPjDRgDtv+9bpZlYnUni8Yl6Jnb0Z23XL6LG7hqUpnRXGquI7IJo+WHRhr
	SMnj6jOU9sUYWLSEpgPCyVbpXpzEtM3kBSKcpNCrzZXPOg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id YtBgw0_y1JQQ; Fri, 23 May 2025 16:08:43 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4b3qpG375Kzlfl2f;
	Fri, 23 May 2025 16:08:36 +0000 (UTC)
Message-ID: <ed7e4530-5055-432b-96f5-39f4af788b73@acm.org>
Date: Fri, 23 May 2025 09:08:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related freezing zoned storage
 devices
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org
References: <20250522171405.3239141-1-bvanassche@acm.org>
 <20250523031019.GA5564@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250523031019.GA5564@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/25 8:10 PM, Christoph Hellwig wrote:
> And I'll ask you again to provide a reproducer and explain your findings.
> Without that you we are just waisting a lot of time and effort.

This link that points at a reproducer was already shared two days ago:

https://github.com/osandov/blktests/pull/171

I will post the reproducer in that pull request as a patch as requested
in another email.

Bart.


