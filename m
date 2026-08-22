Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9BA397E75
	for <linux-block@vger.kernel.org>; Sat, 22 Aug 2026 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406655; cv=none; b=Fe37AYEyE4OodTzekewdHusNsa/9EWz+jrhO+RLZvyx2i4qjxBSOtCFpkAeO8tLhPYF/qJ5icYqMC2hiCVG6QZj40n3XrJ97VHs1vWF9IxXO6dsCzda0yLDefVbkx0OODey6MoYfJGPbFJZSUQoFcPdYGPj14GZs/Lo0WvVZWEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406655; c=relaxed/simple;
	bh=y8p+eSVlmosxkhFx1paEn+Iu4E9f78he/HJlT1fG3zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvNo9g/pvq4aHwaueTGN944wimq/N6AnpZXULYdikbPSa8virzZkX2Bw8RRy4wrlBcjMEiiS81Zz8GAy6ZWD0n5gu4wtvcY5Qq3ZQl4w9YBH0M61UX5VyFrKgYFglCGCI8gzdFuimac50YNiibuDQN2TS0j3LpgYBeyH+UJJkjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=QOBQJUMW; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="QOBQJUMW"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hRz8q0GKVz1XM30w;
	Sat, 22 Aug 2026 13:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1787406649; x=1789998650; bh=y8p+eSVlmosxkhFx1paEn+Iu
	4E9f78he/HJlT1fG3zY=; b=QOBQJUMWObySp+dySRXFAvlm+I7XiX51IVIp2iQH
	fefBTYQ/1HhUujWoR+JOPWYz9fHo+i8DSqmoHeFJB6tKa7QpcIwv06Wk+dii6377
	uO0+7qaJqnTzvRz6lyftgHr1rMypbR5voEJJt52mJtfODIm9XEp/btcHzv7Iinxw
	ZzzZunJKYwWatCplxFbqPNH+VgLb7SV8MR91A57ubDILLCzZurAMYo2HiSnhxe+8
	iQ3en4R9JpuDsGKJYokct5DkLxqEXyEjIblvuGo1foNG27AkA0WHlbsx6tNGaCXG
	Qlu46AC8I6aJH5S0tsq4gS00o4kxtPlbW8rQxvOoiKS0+w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qPg905vGL9XT; Sat, 22 Aug 2026 13:50:49 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hRz8m0Vl1z1XM5kt;
	Sat, 22 Aug 2026 13:50:47 +0000 (UTC)
Message-ID: <5b810fd2-e9b8-40e6-abd8-7858184eafc6@acm.org>
Date: Sat, 22 Aug 2026 06:50:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] block/042,043, src/dio-offsets.c: relicense from
 GPL-2.0 to GPL-3.0+
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Cc: John Pittman <jpittman@redhat.com>
References: <20260821105539.794679-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260821105539.794679-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/26 3:55 AM, Shin'ichiro Kawasaki wrote:
> Relicense all three files under GPL-3.0 or later to resolve this
> incompatibility.
Acked-by: Bart Van Assche <bvanassche@acm.org>
