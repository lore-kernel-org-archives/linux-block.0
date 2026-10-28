Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231516;
	b=o8JFVFKCaaI6M4u7Dr+MyqyMcjinewcK2uIEVqHIer1CDDMvM2V6d2YpJlZcGGl/WbNf
	 b3qEg85jduOD1l3Xa8mtmz3jcIeh9IfRshegmAE9hftJegOZVQdXRLaS9NtIxfs4sTumd
	 VwETbJo5FjN7bCc/F8vdbqTpgkn/5vd/ORhmTKF51F2PrM+lU7ITDXr7hFp/zoRganIhf
	 0SDEQzgOaUnRs/Q/wAfbCwDzJLdkluxSBTkz+7I486ls2z0NWDTwjtVGjw14dJ4Iapl0K
	 ZJvNkgNH6IPa8KyRAw3wlgWsNkdqpiK4VJ1jCJl3GFC9OWFMOc6iCFLAqHu26mEzKTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231516;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=b1hzDNVCmHaefLbt48bRem74vqo+vEFJJbLSfE5XYlw=;
	b=I6Jx8g3qniFU8ND+jNY0b4JNc74V5jy9qNjELlFRQ5LpUq1VcurAQ4z2dd2L5iXfZp1N
	 IR5WkLgJeu8YrcNizkPR/yEcA9YoEQ0IGWO8KcfCIb0BEemSFmAC5ZAJ9Hen+CSguK9sb
	 xmk146tJRzCN71aTiwTkFxquHuS/EqI5SLZv3QBT28PRXpuKhDRB4Iq/eynLkOx7Aib61
	 ot1+kLgsiaPTzOqEBw31s48q7hwP2QgGAY97UF1c1tvLQg6I+XG9lFpT4u2fYEfJ3erE4
	 VY+bqae4KMWVpksIS2TDsK8hLKl2eXkb7F0ZQNKs8U7E16zk44gdloIOEgiE4WQ4qjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="j1QRit/u";
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7187E606A31E
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 23:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7187E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=j1QRit/u
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jFPKM0p0jzlfvpc;
	Wed, 28 Oct 2026 23:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1793231510; x=1795823511; bh=b1hzDNVCmHaefLbt48bRem74
	vqo+vEFJJbLSfE5XYlw=; b=j1QRit/uEBbBTFh8bCnEFDsuhgYFLh9RVHRXLa6z
	5KejiCaDYPp9OdLHralEzSqWlV1B6U6eNP4nz0VeMeONxXB0+CWnJtCLHwmhbOr3
	yxHsxtOVQcHjrBn1g0Cenq6JgrDebj8j9auCvsdIPN6Dntv0bQUVf0yUR178uGRr
	+K/RrQclnI5WPzdhPhU7c7GbWYz0y8scH7uljfJAJCpfUNz5kmaOPHWGEVhlhknm
	Iia7SP6fP1hZ7Y2c8U+bz1IwWAbTNy1D9UwPFqPYHjsM/Cg3tb+OWqo+EqUFPSD4
	mfHZC1zj+IpOwcSipyRoPdCVG2QFffcf1qRSh8X5KBW7MQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ujE58I9ivU4j; Wed, 28 Oct 2026 23:51:50 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jFPKL16yszlfvpT;
	Wed, 28 Oct 2026 23:51:50 +0000 (UTC)
Message-ID: <82167bff-86fe-42e8-b9a4-252cc5c090a9@acm.org>
Date: Wed, 28 Oct 2026 16:51:49 -0700
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
Subject: Re: [PATCHSET 0/98] Various block related fixes
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <c16356fc-662e-4939-ad76-355f3a62ed4c@acm.org>
 <3c5a116a-394b-44a1-bcee-0cfdcc43712b@kernel.dk>
 <b349b5eb-1bab-48d6-b2d3-c5a6bdd05109@acm.org>
 <108919a7-98af-45e9-8d95-00406f3d0558@kernel.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <108919a7-98af-45e9-8d95-00406f3d0558@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/28/26 2:06 PM, Jens Axboe wrote:
> Hence for the replies, also have your LLM actually suggest a fixed patch instead.
Done.

Bart.
