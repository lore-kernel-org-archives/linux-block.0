Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860CF279DB6
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772144251; cv=none; b=uhx5MJSytv7MDRIgjurB7Tj1jodECNNmbaQ2bnYUyiHG0dBzJniEhH+IeJrRgx9wGgqB4GN6fBLIUH4M/vyjHWoL2ekHflvsokdXV8wcwcUowmlhOawUD+O0DuJIQ5LQU67jpenFwq24TbMrg1xGiamlvWveqzNwCdkSESCn3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772144251; c=relaxed/simple;
	bh=trPYJJyb9C9JlMCbDa0XYIZu6v4NQ+s4Jquz6mkIFOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BvzIDUbURBFufBpzwJQtLVUTXofMpSDXJxT5H83wN9NVU/pRXWryQQXCfwxDVmNver2aN6HYPcQczkIT/sob3bMPkdfDt0IFWyhtehDY7GyJ9iu+isnrfZ22jgstgjapF6umz4aXR5rC+9Hb/XrKLJ7JMCLHRbUdjlL+BN2D9gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=caLVxYTI; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="caLVxYTI"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fMQmw5vyCzlfdfS;
	Thu, 26 Feb 2026 22:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772144239; x=1774736240; bh=trPYJJyb9C9JlMCbDa0XYIZu
	6v4NQ+s4Jquz6mkIFOE=; b=caLVxYTI71pA2PlEhwzKF6hLDB/Zy/uZRXgj6jm/
	J2fWJ0kWdOERkbk4N9czH3dQ0xRUy/nGrHCx03uWmv5BM2DblRIMVV6EG5dHxFyH
	u2u9ioCvFLwQGRVpyiSnN9PZyr6/I/eJ/ZEjSW/2qPVzJBYylWPU1uUrsCifHOZy
	zEELNpXvGpmjYMBeDulIYf19dlSfvgr9ohWczIniZJxLWd0S+p6/aaptae4C1GS4
	X37g0HfzHis1Ul/kyawcU6X683hnXD3gr+nb0DTx+osCzrOEG7FPYYiaSINHv2NJ
	ybk+/dSBjl808vsv66aRD2AycY4/J5/7pMwhTDDoWMgABQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BJu3FG4hr_uA; Thu, 26 Feb 2026 22:17:19 +0000 (UTC)
Received: from [172.20.2.156] (unknown [4.28.11.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fMQmt2gZnzlgqsJ;
	Thu, 26 Feb 2026 22:17:18 +0000 (UTC)
Message-ID: <e852d89d-e910-4f62-9d78-e4e6579625f3@acm.org>
Date: Thu, 26 Feb 2026 14:17:16 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Improve zoned (SMR) HDD write throughput
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260226041024.2154806-1-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260226041024.2154806-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/26 8:10 PM, Damien Le Moal wrote:
> This patch series cleans up the zone write plugging code and introduces
> the ability to issue all write BIOs from a single context (a kthread)
> instead of allowing multiple zones to be written at the same time using
> a per zone work. As shown in patch 6, raw block device tests and XFS
> tests with an SMR HDD show that this can significantly increase write
> throughput (up to 40% over the current zone write plugging).
For the entire series:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

