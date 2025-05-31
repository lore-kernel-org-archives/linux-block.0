Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19489460
	for <linux-block@vger.kernel.org>; Sat, 31 May 2025 00:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748651132; cv=none; b=q/GpcLY4WX7spkSpeqFji30IVb85y6VBmSBtVR1Q4bBjzR9TCorvEkzsGyEaki5RetuJh+4SWUwVnzsdWZLLtOM2w6NqXv2yi4bruKRzK+Aa7kbdEc2vO1omzEKrst1SP/rA8SvZzfe5IVsyErhG9ZcJ7hv1BFw3d6oSLK8cJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748651132; c=relaxed/simple;
	bh=gWm8yZ2jQtA6cHtjR+1NWLNjE5o1/FKqJVgp7BR82Y8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SoZNAq1AXJQ6sam1TksQ1NzqjrmKIrfLnyxjmvcz53udtVn0vQkwBOBKigGF5rlufokPpWrSruciFZV7StV1H+qHyEDSPOba99EQPh39OCvFdmrcqJhNRF+cy504kIIOF3Cf78FhnHnxvZustpoNFN65LUbtKlsak3/YF5QVe1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=f2DRlKBb; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="f2DRlKBb"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4b8LVK4l9nzlvfHD;
	Sat, 31 May 2025 00:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:from:from:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1748651128; x=1751243129; bh=gWm8yZ2jQtA6cHtjR+1NWLNj
	E5o1/FKqJVgp7BR82Y8=; b=f2DRlKBbY9WYbIG+ujtUzL948Y1W9EIp5l60shHz
	27AzmTC3VYJa3CBFvsglhvp6Gvj8J6DEUSaSZUP3buoaaAjOHzAiZAhFD6/YqdTr
	SDFoXvfi/Ac5xiKEd9YgvObh18LkdzFigdh+5Ib4ajNh9pdGVRTONBJFrukSa+aj
	a7WFNBZccx2fMdutKEB4JcLePDPJiV11mANUKHtmYajPf3mxwnIf1Nbi06rQkMOF
	4p1+635eDvJMnXrOXQhy4RG+5TLZ1MdIu0KY2nZMGalsOIszYSl1ZtPODvzFCchV
	gZmYrnAEVI0itSkkyaYr7qFuFj3EYnXRcH27JlHbl5Qb3w==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sjjIBOFX2H9g; Sat, 31 May 2025 00:25:28 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4b8LV96knXzm0GSl;
	Sat, 31 May 2025 00:25:20 +0000 (UTC)
Message-ID: <7f3ae0d0-dd44-4927-9b5d-c80365bc819c@acm.org>
Date: Fri, 30 May 2025 17:25:19 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
From: Bart Van Assche <bvanassche@acm.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250516044754.GA12964@lst.de>
 <47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org> <20250520135624.GA8472@lst.de>
 <d28b6138-7618-4092-8e05-66be2625ecd9@acm.org> <20250521055319.GA3109@lst.de>
 <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org>
 <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org>
 <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org>
 <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
 <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
 <20250526052434.GA11639@lst.de>
 <3eae0697-0468-47a6-810a-b97d0f469f79@acm.org>
Content-Language: en-US
In-Reply-To: <3eae0697-0468-47a6-810a-b97d0f469f79@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/25 9:19 AM, Bart Van Assche wrote:
> I'm still working on a reproducer for the blktests framework. To my own
> frustration I have not yet found a small reproducer that is easy to run
> by others. I'm convinced that it should be possible to create a
> reproducer that is based on dm-crypt since dm-crypt and the dm-default-
> key driver behave identically with regard to bio splitting.

(replying to my own email)

I have not yet found a small reproducer - not even against the kernel
this issue was originally observed with (android16-6.12). So I switched
my approach. I'm now working on obtaining more information about the
queued bios when this issue occurs. It seems like a bio for a SCSI disk
device that shouldn't be split is split anyway. A bio A that does not
cross a zone boundary is split into bios A1 and A2 and bio A1 is split
into bios A11 and A12. Bio A12 is added at the end of the list (past bio
A2) and this causes the reordering. I'm currently analyzing why this
happens because this shouldn't happen.

Bart.
