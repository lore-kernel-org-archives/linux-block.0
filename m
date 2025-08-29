Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FB61C01;
	Fri, 29 Aug 2025 04:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756441959; cv=none; b=ZrJVBib5ws6z2JXs4EKaSnDuPQtQ2UHcqqzyjMB6ysyQFkcVuWJfnJOrbJkEZuhTSD0okWBaLGOo9Ej4lqRzsplVvhCtqUw2R+k68WNZ856h6kTJWXrlvPIMBOHBlQh5GJKD++CqTldYy9Y3PAw9GA6u8Lwhilt/ou6LawAyjig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756441959; c=relaxed/simple;
	bh=eRZ1gg9Rv5ircfsh7ob2vLDB6KIkhKae+7C2lKwKeaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aypg63opi5GyBrgbuPnU9eoW975ASzC0Ijxj9PWzuL1NPzUTVrM8wG9Tif+nZECxVAOljRZSkW/uJCKm5sUdgoR7qHaTAwo6qNIwf1DIhkJEEWmZahbXS9HOV9uO5YJdDZPI+bVW8yv/LYcbO8HiHOX6/fapV8+AU6rWAGSZx14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JdPYpiiR; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JdPYpiiR"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cCljq4Nntzm0yV0;
	Fri, 29 Aug 2025 04:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1756441950; x=1759033951; bh=eRZ1gg9Rv5ircfsh7ob2vLDB
	6KIkhKae+7C2lKwKeaI=; b=JdPYpiiR3Yz/WTZ0bjo4s15yaU7pUv1NYySIBJdG
	WzNGtkEfte2sBhaGAvvgr0WaDIzeZqWFWOlZ+Ysyvh9MxA2sGXgmOgvg7ZDjEkVN
	rQfWVvzVlK9wI//74SsBqnZlxmg5X9lNfC6dxP4WeQel5I4+kY24kUF7a0fdP4D0
	LeJsYTeu2G3CzPu/bua1NDL5R3Yi3QaSuOz8SzVyxBINduhm8+r8Y5g6lu7Tmrmc
	rrLfSmliYfJxgmkaBI+rVWqTshFxaJ9Hjatdsan0eriBt9Nlm5MUknwgqkUbCMJB
	2vaKGHPZ1MwpsqAHP+qGrHcCnBbMd/zU6tMFVoLLZiLZqQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DfEadRS1nGJt; Fri, 29 Aug 2025 04:32:30 +0000 (UTC)
Received: from [172.20.6.188] (unknown [208.98.210.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cCljj2FwYzm0ySX;
	Fri, 29 Aug 2025 04:32:23 +0000 (UTC)
Message-ID: <7e267bc9-c5ed-4155-a54d-401218b708d9@acm.org>
Date: Thu, 28 Aug 2025 21:32:16 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block/mq-deadline: Remove the redundant rb_entry_rq in
 the deadline_from_pos().
To: chengkaitao <pilgrimtao@gmail.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 chengkaitao <chengkaitao@kylinos.cn>
References: <20250829034505.95468-1-pilgrimtao@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250829034505.95468-1-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 8:45 PM, chengkaitao wrote:
> In commit(fde02699c242), the "if (blk_rq_is_seq_zoned_write(rq))"
> was removed, but the "rb_entry_rq(node)" and some other code were
> inadvertently left behind. This patch fixed it.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
