Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E46425A642
	for <linux-block@vger.kernel.org>; Tue,  4 Feb 2025 00:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630502; cv=none; b=SjAU/r8j+imYMAxKuUYuUseHUynGLeGtaScvshievfRIa7F/As8qQwAnt74xTAtqsdzz+r0y/9hmHCQojfxyajh1el0iz+kqOKb/3OWgoUnLb8ktN/w8622qNi4Aik9rKIx4da1vZZGDK41AKLhI0E1BkewEiBWaW1yz+CNozfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630502; c=relaxed/simple;
	bh=9GNtC6j8Xt5vTGRDmUMC171HIQeTrpuhlihYo5u6mGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hx/bVt1g1YJiDgmCWMHqevlhVgBDSOUi9TXFhm8vhdP+u1Wt1rjAmLrFwxynokioDjvQ27yA5peqisQckoYVOoFXqzq8kHXuq5BersnuhjsjuysIWjAoeBE1MdhY50CW0LRAjUDQVx0sMr2z6xh/f53YVkJC2HhvYDzUxPwHnuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEmNyNpz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEmNyNpz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5839FC4CEE0;
	Tue,  4 Feb 2025 00:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738630501;
	bh=9GNtC6j8Xt5vTGRDmUMC171HIQeTrpuhlihYo5u6mGg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FEmNyNpzDIgcUnlk1TxyBilE+Ng7I9SFSh1TyVBPoEsMrwifZcipmgNb0Cf58c62M
	 Fvg4i5rzsGPr/BBCxNOvPH1MT9Y+utE3IdxFVEq4DwLTvPn9d5H70YUY7m0Hd1XJXM
	 rEc9SxGCqBwliZhgPJfimpXjU/weltASwFYQPDq1zd4Xjaq0HRS+w6RuXwA4FnoJwW
	 4rKs0NCSW+iylrVJ8o9HeBQt8JH3Ni12atzA15IzNFFg9eVPgVcmqgiu5oMuepNfdY
	 sCPTIR/+9bPgNbMCExBoZ1UkmIqjmTsFt12mY6cXfWOxsE/XxxoZBWgGeCj6kLPcIc
	 dDV4xAvvCNKeQ==
Message-ID: <d73bc2bd-40fb-4d56-a303-bbcfb686bbd3@kernel.org>
Date: Tue, 4 Feb 2025 09:55:00 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] loop: factor out a loop_assign_backing_file helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20250131120120.1315125-1-hch@lst.de>
 <20250131120120.1315125-2-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250131120120.1315125-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/25 21:00, Christoph Hellwig wrote:
> Split the code for setting up a backing file into a helper in preparation
> of adding more code to this path.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
