Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A61153BD9
	for <linux-block@vger.kernel.org>; Mon, 10 Nov 2025 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790099; cv=none; b=DvLoixOj0/tcMba+Y06BKAZBV5u7xTt/bdCnT7sfsbLOWBjT3dtAcUAmYKrsVhzOkFqhLT3OP8q/+9f5ahfM1HvET2ol0T+t4h/WEa5sBmJ8Aud+yV8puHDY+dt5en4Yfu5IstgjlbjjcZrgBUHj66ZeCDmiY2BRvHAxflVr/4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790099; c=relaxed/simple;
	bh=+nz+ZLFIE6FkAAek/UMOSr12xhHKRlqWB2xOHDuyO/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxGFB1Mp23JjhhkYauXnvPdYG+POB/6oF2DX8/xtGU/qcYZ1tk/QUN5rmiSCTdtsBO12jwUShMeYPNgcjfFkXB1GGQnjLs/bawxVXonyl7hs7jg90rAIAyFHHVcvCxgYv6cXpOfbDHb63HXvQEZPOleXDcQUJV09rtcXsTuDAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zbB7z8xW; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zbB7z8xW"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d4vPQ2kKxzltJQH;
	Mon, 10 Nov 2025 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762790089; x=1765382090; bh=+nz+ZLFIE6FkAAek/UMOSr12
	xhHKRlqWB2xOHDuyO/g=; b=zbB7z8xWw4mRLLR9dmrlBsIQmgxjGKpyblId1fQ7
	NcTkwrdtbnlTK2m9MxLXe/EITwybIXWdctzgNK+nXOzuxJ5oz6VlQUr3O4Lzi9Qj
	J4FYwUqehFLfZx/TS/qaQdF95rYliCJFiUuR2Cm4H84HOuVIE5Fd3MEY/zGBoOP3
	85fL9/4EtJgiNALPPeobnm8vQT2NJuYbCh5zvy6K7lzv2YtDOgr8GRGbWu6MOfVk
	vMlGb/GuqqFP4rJeGyL1zeLvcsF+mPxAWZ06VAAnZIcx0x9D65Rz9wnCCxHZN43R
	SKFr+k1Jv0Cj3fwan3llMPSpm43e3xdduQVofMgZhBZ8tw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Mg6L3uNfxMbE; Mon, 10 Nov 2025 15:54:49 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d4vPM4BNBzlgqjL;
	Mon, 10 Nov 2025 15:54:46 +0000 (UTC)
Message-ID: <9b2660cd-184c-4604-82ef-942d2fa52632@acm.org>
Date: Mon, 10 Nov 2025 07:54:45 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: add sysctl_blk_timeout
To: lwk <lwk111111@126.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20251110152348.2653843-1-lwk111111@126.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251110152348.2653843-1-lwk111111@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/25 7:23 AM, lwk wrote:
> In some scenarios, we want to modify the blk timeout, but the
> blk timeout is a hard-code constant, the default value is 30s,
> so this patch changes blk timeout to a variable that can be
> controlled via sysctl.

Please use /sys/block/<disk>/queue/io_timeout. See also
Documentation/ABI/stable/sysfs-block.

Thanks,

Bart.
