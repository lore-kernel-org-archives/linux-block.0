Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4A423A8;
	Tue, 16 Jul 2024 20:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160215; cv=none; b=ULboT2v8SocnujupHSZicETFzUYdDxx9ukVyYZpGnVrnOfSD7/M5KeoSESBczEXNbLmUsoaiT8BLFLyOSeRB6+zGFib4hFkdve5zoox033nH9MzGzPpDZcAU/9ctGKvNMRqs/GnB1g9Knv4zUaKXcYrtk/8a0lR181q8HVUI2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160215; c=relaxed/simple;
	bh=3isCtw49gjTNxSl4rT4/wCPsTUypsJfNTuh4OxGYI/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYootTTxG35nnXdhk+aYqOx1Ke4PjjEb1o9bVvKpCN2cMP9ZGOUlXcBQ3ea57h/uQv51gZcOCrSNBROIzkV/ITrpaz4BB/3BcUxxGshIGLr2CywtlV0F411DWDINMXsJhUg5fvtBX0MjQBq/Tt8QDVfe6J6phf0AZxrl009z8+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OqS/PqaT; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OqS/PqaT"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WNqks1pcyz6CmM6Q;
	Tue, 16 Jul 2024 20:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1721160210; x=1723752211; bh=3isCtw49gjTNxSl4rT4/wCPs
	TUypsJfNTuh4OxGYI/A=; b=OqS/PqaT1uBIIjqi2SnBuIOBa8nOUAFZacT6iXK9
	wyuOTv9U1MHTv4iYT8IaO4Lozvt/mfWz9zQ429WJje3I+HHKaBrMtnnn11AV7S+R
	Mh7l23b/gXv4psoo/kQRNTJD5Vpv9UM5yn0/TKIgdYf8jkXXx6Zz7EuGTd/1x6p4
	5gxFg77Vw29LX4EPCPRWHubaATfVDzN/2F1QjHUiah54h0por4S5pamEZOPNxYlS
	aDjquWid5wyjWinN0+vEbMM4HdugYu3eDxrROvWicKAN7xzm/wwoSQFHE/dJmpuo
	jEmIQJ4gnXuqqPLWEta2UnnM5XLFzKst9oU3nUekibJRuQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QqI_rDm8Yjbh; Tue, 16 Jul 2024 20:03:30 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WNqkm4bMGz6CmM5x;
	Tue, 16 Jul 2024 20:03:28 +0000 (UTC)
Message-ID: <637875b5-104c-4df7-a7ae-181d6eab7ad6@acm.org>
Date: Tue, 16 Jul 2024 13:03:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] block: uapi: Fix compliation warning of using
 IOPRIO_PRIO_DATA
To: Zhiguo Niu <niuzhiguo84@gmail.com>, Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: axboe@kernel.dk, dlemoal@kernel.org, hch@lst.de,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
References: <1720518712-28301-1-git-send-email-zhiguo.niu@unisoc.com>
 <CAHJ8P3LTxcMK0fuM5XCr5fmXffQUGxXsRSYdW46MtPoX8961UA@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHJ8P3LTxcMK0fuM5XCr5fmXffQUGxXsRSYdW46MtPoX8961UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 2:28 AM, Zhiguo Niu wrote:
> kindly ping...

Please repost this patch after the merge window has closed.

Thanks,

Bart.

