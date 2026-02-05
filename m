Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57BF35F8A6;
	Thu,  5 Feb 2026 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301325; cv=none; b=OU5J7h73gnClXRfBWPY9t+QZ4926Tm7XakFY2rZD6D807cgM5GeySn1ALNDxBIXRuyOS0N54Mnfz7Ajtpc93rlv2G7724c8ftWHgnz1JnYc3uyKWfMIzMM2D7LNEb3aeSMzCP0+Jh0x9qq2HD4Ktk3HX+bHg3pDEYZ3a5CTvGGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301325; c=relaxed/simple;
	bh=kzbsrXPs9zhPeH4CI+qA946fgJ2rB9+KYBD4bB5+zSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYXP0JMHHmvRlUbkgUwU5Jf2xmmr964Ao5kdb4GCy9h+BNPqIuQCuh+EFL7JNFXUfPwwGfKcTNR4b0aUUMaERiv/irZ8nxsh9T71w5UHmf93PgJYZdcJcvYDbl0E0io9X/Ue0Uaz4XUIsw04zXdJtyRBWPTlCSro8ZyAawBjEBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ax9uBZbj; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ax9uBZbj"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4f6KD71mKPz1XMFwj;
	Thu,  5 Feb 2026 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1770301317; x=1772893318; bh=284YlpLW/PLOasClSptY/p0L
	7BENNl1Vbq/GaY79w0k=; b=ax9uBZbj3ADazf5gNM/Xe+TNwbdAe70VCbL8C5HA
	N3Ww/KrjxloqS3T4Q1sbAoWD63zWt6yKySieLN+5L2HvEOhIfwJ63ZRIof+wD0AF
	yoStjxVD9L/uU5pgqCWuXQEf1DdftxjScKHX8nqqezkO3EmZpQz1DvR/wbxELq9N
	D+pLCn49/8+Wyvs+EU7jHVbbEPGR0nT1xy+TrfBZUp2bLll/Jj8EnYBR7vSQmrIj
	RfRq7KDXShx505bwcQFL48H8jUT85k6v1Mt5kJDkBvVOfhmrpkmw3pKz7RVffoMc
	0/b+mI/AKA3DZDdrtMyJM8IOEt/epm+ZAWko30u6r5Uk2g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id q8pL06DJZpWu; Thu,  5 Feb 2026 14:21:57 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4f6KD12qBhz1XMFvJ;
	Thu,  5 Feb 2026 14:21:52 +0000 (UTC)
Message-ID: <4f1d5c9a-f261-49da-9ae6-f068bcd7402c@acm.org>
Date: Thu, 5 Feb 2026 06:21:52 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] - Short freezes in gameplay due to MMC_CAP_AGGRESSIVE_PM on
 RTS525A card reader
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Ricky WU <ricky_wu@realtek.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>
References: <ff9a7c20-f465-4afa-bf29-708d4a52974a@linux.dev>
 <CAPDyKFrGpvjONrDmnNZXv+SME_NCNv-LK8J-Vo88RSz1fuD7rg@mail.gmail.com>
 <787171c6-0b9c-400b-8a95-b331b58e284c@linux.dev>
 <4777aabd-bc9e-4904-9444-892393aecb15@linux.dev>
 <9e362d5fa2604fb0848ea28866dc45fc@realtek.com>
 <47ed09fc-047b-4f98-8df3-d11d17678c57@linux.dev>
 <380f75c7adc04cbab38cfd2f82bd0c6d@realtek.com>
 <d46dcebe-ca58-44c4-87ee-cade2e478572@linux.dev>
 <4205fde06ecd4a7489b03ef25e5e4011@realtek.com>
 <CAPDyKFoC-dwzcsABNy9pA=GGirBWwcxQhNMeTSSStXHtXmWbcg@mail.gmail.com>
 <0b6fd99b-54a6-45f1-942e-94f707f2fbf5@acm.org>
 <CAPDyKFqic-rFe95g657MdZHtdPXTmFmYQG4ZSBV56S3DhMEF-A@mail.gmail.com>
 <dc1ac2e5-1db1-49b5-847d-a10a611027ae@acm.org>
 <CAPDyKFrNHc4FexuTbdWM-Kvo0mn9C51nJN5b=e0jZR8miFho+g@mail.gmail.com>
 <2d3b720c-5637-45e7-887d-077b1e9b3c23@acm.org>
 <CAPDyKFqQCtXzRruVSy0RLfWw11=TB+HAqN=+0P7St=aovZOoEg@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAPDyKFqQCtXzRruVSy0RLfWw11=TB+HAqN=+0P7St=aovZOoEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/26 3:26 AM, Ulf Hansson wrote:
> The other concern I was trying to point out, is that using the runtime
> PM suspend/resume callbacks for managing the QoS constraint isn't
> really a good fit in my opinion, because of the potential idle period
> beyond the point when I/O was completed and when we may be waiting for
> the device to be runtime suspended (especially when runtime PM
> autosuspend is used).
> 
> More precisely, during this idle period there is no point in keeping
> the QoS constraint as it would mean potentially wasting unnecessary
> energy by preventing low power states for CPUs. Ideally, I think it
> would be better if we could monitor the I/O request queue to manage
> the QoS constraint directly. Perhaps that is what you suggested too, I
> just didn't get it. :-)

Hmm ... the block layer RPM code monitors the request queue, isn't it?
I don't see how the request queue could be monitored more directly than
how the block layer RPM code does it today - by checking the counter of
the number of requests that is in flight?

Deciding that the I/O request queue is empty is not possible without
waiting until the idle period has expired, isn't it?

> That said, speaking about runtime suspend for UFS. Is runtime PM
> enabled for the UFS card too or is it just the UFS host controller
> that supports it?

It depends on the decisions made by the manufacturer of the device that
includes the UFS device.

In multiple recent UFS-powered devices RPM is enabled for both the UFS
device and the UFS host controller.

Bart.
