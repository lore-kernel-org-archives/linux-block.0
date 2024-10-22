Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B31A0BD7
	for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729609541; cv=none; b=aSbDeeHetPJ1Bg4B0F70y/BJlz4MvpVocntbfjOQHVKbm7MW28UG/xdrR3TvACwyYf0K1BrionRcgFOQP3h8nUDo1XNGjI/l6gGGgjU0b0Ck6IenIRg0L53REWSfsP6+aw5Rfj5FIEOXxR/TvVxLv667sd50oPSItI/9Vs97Y5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729609541; c=relaxed/simple;
	bh=VGPr6BW3vTEn7vab3wmqikb8wAlWu5eezgeYIMD9+KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GrDybyqW3VmvQ3p34o2H6daYH8D8ALaOAFC8SRe+7TOT7Q+Gq/5rJEM/Ftz0YhvqPdMQrXuby7sAg4rZPFPPtJ5yEna+QI6OSWFBOVvaREhiDPQxAgiz21Ei9dta49d7PSvuO8SF/x8ukwHk0Pw44dAYVnvSKL2bLEMdsspvubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=wYUlEGH2; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="wYUlEGH2"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XXwTt5NPLzlgVnf;
	Tue, 22 Oct 2024 15:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1729609537; x=1732201538; bh=H9H2CeGKHHtFgPf5NY60xx8J
	rgkBxlNmQDcZYIMGhus=; b=wYUlEGH2EYibqn4xtjtbqqvUKzhaIHti6ZtF2wWc
	rDOxmDcgkoOLYCrTwfoTzpt2HoPP7yElwHSZFB+M39CMYbSw7nEhpSyUZp+CIXjz
	E7N20fYLemPaz0RKZ5z474lnrOkt/2O2lnVTzDSw5QKLL52ZloHH+WfZr3VyZ78S
	4LEV8ReUHHQH7cUC6fbBU8sMGMaQaI6YN9wECAQe7pbQ49U7IaKsSCbJTxp3nES0
	+bwVMJUroZSVOoU1PiOu43OeH46NJTc2cO5aW1a01FiJyyY5rIgsnEmNZuaW0Yop
	p4NkMB/NBi0F7XgYsU7D+4aDNaKDMyTDPEbwspObOujltg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WX03nRb566X2; Tue, 22 Oct 2024 15:05:37 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XXwTr4L4RzlgTWR;
	Tue, 22 Oct 2024 15:05:35 +0000 (UTC)
Message-ID: <ed9a22b7-64b7-4b83-a6c9-1269129e89d1@acm.org>
Date: Tue, 22 Oct 2024 08:05:32 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: model freeze & enter queue as rwsem for supporting
 lockdep
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20241018013542.3013963-1-ming.lei@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241018013542.3013963-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/24 6:35 PM, Ming Lei wrote:
>                 -> #1 (q->q_usage_counter){++++}-{0:0}:

What code in the upstream kernel associates lockdep information
with a *counter*? I haven't found it. Did I perhaps overlook something?

Thanks,

Bart.

