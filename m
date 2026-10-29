Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793289922;
	b=n20jzhbM0TsxaQ57wjDn+C+GdDFrVOSqHDsOrLjJppmJpMShjMlnpP1fkvqyj7TEu8QY
	 XbFfEs2PhXe3B9tf3l2uVknxPBKOjyELcRhM/0qxj50TvwUNhQi4D052kUhvvmOJ5T7QF
	 HwdiWXz4B8iH44PUq0LK4LWgs16BsfjT4guKF2osxGWEBH7LECqRipLHugSTXMVh1hO5W
	 q+wWpQzMhekz12gAon8FihbFmmBGNk/Q26yx544ROybw2LpCs32XwAeT3RjGiJV9DtFmN
	 l97jLkw5gFDvJycVuy9ASQbjMuqKAMy28t2ux5uKxWGwwuqHh/k9mU89iVcKgUeLrnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q+CWxkd/ICzhTlkHdouqQ9OeJOGKkuAOiyXGYUQe9oU=;
	b=VMPCdT+2B+pvmpMrhOL2Vj4z97g7W+9FR1R3KCMqtC7gRgh3A0AhYP+iHqIbm9DrEId6
	 y0gbzjbirCPwFqvWXunhl0bEWzY1qzPKIt+VEnYigKfsza3erFJt7RwGmfK0dvrArOSdZ
	 Abp5TKzxcb7GpThkTSgjN8UdSnj4f8nMs9XD2Ph2SYvBMrL83f0+4uN90wE63DMkSp6G/
	 9PxH4iWH1vvilrB1Ep9+eNBbBomiKqyaxyQqK29H99su4LbFO+uTxNnFos18zMJLJgdcw
	 9XJcJkEme814nvMIhgj+rcsaIVICRklQLGbXXJm5p++bfqI3OuHEXdAFI5piICcluNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=pa6JlRHJ;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C86606A31E
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 16:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83C86606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=pa6JlRHJ
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jFpwb4Dwdz1XM30h;
	Thu, 29 Oct 2026 16:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1793289916; x=1795881917; bh=Q+CWxkd/ICzhTlkHdouqQ9Oe
	JOGKkuAOiyXGYUQe9oU=; b=pa6JlRHJk0hw/hgc8rXXBzCgmKDVYcf2QFXxdmNM
	WIc88dj9Nj3PatPPshYj5NM0lsNwisGkn2xANLalYOxts3kXaMkS8IuU6Bdlj32D
	ZdCHWAZ5mQE5JXwimu4qImomzsyQl7z5c5XTGcG4NBxjPwVEH1cymC9R2hSwmp/g
	5gv1hLj0vVEv0ZaDcHSi06hW2tDktJZp8mzjgVfzgI5fqkxhireKOXZbx1wmfy8m
	ZxQYweB6DE1ULHH3JLQ2XRDPnoojp3W1Obsb5WXtfKEU5CkB0H1UNB/Pw8zwmpX2
	yPL61R5EALIubWdVpkAzjoAXwyaAQIWoqnbwfe5rVgf/9g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OX40iyVKNjY9; Thu, 29 Oct 2026 16:05:16 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jFpwX55gbz1XM4Tl;
	Thu, 29 Oct 2026 16:05:16 +0000 (UTC)
Message-ID: <94c807e7-5854-46a3-8031-8e3fe4fedd52@acm.org>
Date: Thu, 29 Oct 2026 09:05:16 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/98] aoe: don't free a device with its work queued
To: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>, linux-block@vger.kernel.org
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-19-axboe@kernel.dk>
 <20261028234917.3067347-1-bvanassche@acm.org>
 <d9d30ac0-102f-4578-96c9-c7c4b4f05b88@kernel.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d9d30ac0-102f-4578-96c9-c7c4b4f05b88@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 6:03 AM, Jens Axboe wrote:
> Great thanks Bart, but can you make it an _actual_ patch? I can't
> apply this, the commit message is referential to the original patch.
> 
> Just send me drop-in replacements, and I'll replace whatever gunk
> is in my tree now.

Done - see also 
https://lore.kernel.org/linux-block/5eff518c-f620-4d4b-9e02-1ebf142e67ff@kernel.dk/.

As mentioned in the description of that patch, it has only been
compile-tested.

Bart.


