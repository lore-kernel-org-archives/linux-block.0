Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C202194ACB
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732750592; cv=none; b=IsxoURPgRswmtroxxcvY0HmiLYvtjqC60kcDv6HBz4Q0tIZlEBrPGGLUe7yGQB24nYjAnoeDnuNdQ6uvI9yADbIUwrzGSfilpCexxiJ7ORMXPB1M9wxa191Y0b51y1F4Z2qp+p5oWO2ZNu5HpJRfmGyW9xYZWiBcEAbHIvKWBc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732750592; c=relaxed/simple;
	bh=jjgMuhHLIBo5Gj9AN2QR/GhLDYssFsCS8Ao1LpdlkKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJpkSVZuj4RVpPiqURCzGC5Gu67i3I9v6LiIbwHdCpGKqt+eCWDZOFTMvQSuIKGJ04z3esQMuamFbMyXsjqVTSoA7Yb1YO9jAPqyanyrnoVVM2IK8aErN5bgTZrnMIt6CmlBPF/hYlmAhZERCow3Wc8WDXakvR+GXTSr9ykFT/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=r1bzCpW7; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="r1bzCpW7"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XzG6j5b53zlgVnf;
	Wed, 27 Nov 2024 23:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1732750587; x=1735342588; bh=dSeoMLEe3W9tXzrG/0O9Oxah
	tvaYcEv7hVinEiyN7/w=; b=r1bzCpW76Cgl0fPc7qI09k1qJ2EXcN2J4vY6xtay
	RGM4ttb1gX5dm5CDJmKHBMHdZN9LuBbZePMItV0Xi/p0zN7AcuESKPYzBabVxlaO
	bLq/xzhLXl48TLvlPO2umCtewZzCT643KN/nR6UEfPVdTw/gKzCCVExpfzOVSf2d
	MC+ys5LzxyOKT/+4Spdgr6RqzW3ZqM7cwB6upK2TFG7mRxpLlEcqTzVspFD1tt6Z
	Qy6HwDgJCTmK2Vi9Eb0x2pPV/eyZbqcqIkYG+ef0HRn3JVSmczC4Utl6jg0AWuJS
	6LinfyE2oDed4xeCZP4RqfXEaPFgvyY649/L31FL7Exv8g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GmVsx0xVdV1J; Wed, 27 Nov 2024 23:36:27 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XzG6f3xYSzlgVnY;
	Wed, 27 Nov 2024 23:36:25 +0000 (UTC)
Message-ID: <992ba839-5b7b-4db5-bc64-286ca47b216e@acm.org>
Date: Wed, 27 Nov 2024 15:36:23 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <Z0a6ehUQ0tqPPsfn@infradead.org>
 <73fb6bae-a265-43c3-a362-3cece4b42bbe@kernel.org>
 <Z0a9SGalQ5Sypfpf@infradead.org>
 <9d224032-254f-4b4a-a667-d1538cdbf0dc@kernel.org>
 <Z0bAHKD-j49ILtgv@infradead.org>
 <52570aad-c191-4717-b91d-a555d9dfda96@kernel.org>
 <Z0bIDopTmAaE_nxQ@infradead.org>
 <0e2dc18f-d84e-4dcf-a5c2-134d579c480c@kernel.org>
 <Z0bfKNMKhLkEHusz@infradead.org>
 <3bc57ef3-4916-4bcf-ac1a-9efed89fc102@kernel.org>
 <Z0dPn46YnLaYQcSP@infradead.org>
 <2b7afce4-fa13-47b6-a3ed-722e0c11e79f@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2b7afce4-fa13-47b6-a3ed-722e0c11e79f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/27/24 3:18 PM, Damien Le Moal wrote:
> The BIO that failed is not recovered. The user will see the failure. The error
> recovery report zones is all about avoiding more failures of plugged zone append
> BIOs behind that failed BIO. These can succeed with the error recovery.
> 
> So sure, we can fail all BIOs. The user will see more failures. If that is OK,
> that's easy to do. But in the end, that is not a solution because we still need
> to get an updated zone write pointer to be able to restart zone append
> emulation. Otherwise, we are in the dark and will not know where to send the
> regular writes emulating zone append. That means that we still need to issue a
> zone report and that is racing with queue freeze and reception of a new BIO. We
> cannot have new BIOs "wait" for the zone report as that would create a hang
> situation again if a queue freeze is started between reception of the new BIO
> and the zone report. Do we fail these new BIOs too ? That seems extreme.

This patch removes the disk->fops->report_zones() call from the
blk-zoned.c code:
https://lore.kernel.org/linux-block/20241119002815.600608-6-bvanassche@acm.org/. 
Is it really not possible to get that
approach working for SAS SMR drives? If a torn write happens, is the
residual information in the response from the drive reliable?

Thanks,

Bart.


