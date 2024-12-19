Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D89C1A0BF1
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734631488; cv=none; b=JPNIk2Aoxpy8TTZm/Agmag6zc3DO3Hu2SmyjF2/Q8MurjvAP69f6RGfDtwVYpb6z/tP8wBe07Zgr6kdfqiPEFf3Nn5hf9WqJwxMnQYBeB6cm1UbWBtl/rGWJsBj5bfufwapenz2gl0V7mMWvYye1hFSeUkZT8JGJ6dR6sBEE1lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734631488; c=relaxed/simple;
	bh=wMOj+3G+/rY3FDQfnuOzzZv03T5mJV/EbQyJ4JiBrYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovgqcrz99u/vpVNTl2juMWdetVX7ZWpfHpowE1a8dQxjz+dhFU7/YVVRibSmF5NsizqrWZer7VnAdC/hIBHLPpjrSVU7OWYju8lY4Uh0lyscm1v4CjP5u+PP0VQ4631qYI+Q0emY2trqUlNdz5oLNMOWuI/fG+R99AWUXGDS7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NB6Wf8qU; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NB6Wf8qU"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YDdjn5WQmzlff0K;
	Thu, 19 Dec 2024 18:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734631483; x=1737223484; bh=Hp4F8XYQDtzqfCsMw2egyQ6W
	om6tcSzOsM+/5hqEyEk=; b=NB6Wf8qUS8CncV84/ZE1nrjbCMf16TT0UW2AIZNo
	JQeRPtzRtLZvd6HaPZZBFUAKoQK1W8FdYSXSPGYTWVVr5e92k9cnx+yZukRf9hVU
	Hu/iNtUu+FZA4MhmbuBbo0ZtK+i1EB/0xLksR7mEoraHp1F1yT77bW6DPjh70mzw
	ncW3u/F3RChOZAMgyIApLm5MyZ9+442zruetYwTFCbOOtyTz/h/E+IOyrPIV5+tw
	ep5LVRcJgnaJ9UAZHmwE4b+zDI2UxA4b0hNX3aklXHwFpsYZ0jzYyACDtBRqMgUj
	pII1uoIAbzoaZxtSup/fV7YgcTxTxlHRy6S2+qxQLBBnAw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1Ua1TAH7j7Uk; Thu, 19 Dec 2024 18:04:43 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YDdjk2bnbzlff0D;
	Thu, 19 Dec 2024 18:04:41 +0000 (UTC)
Message-ID: <78caa04c-34b6-4801-a57a-84251dd9d253@acm.org>
Date: Thu, 19 Dec 2024 10:04:40 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org>
 <63aae174-a478-48ea-8a74-ab348e21ab65@acm.org>
 <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org>
 <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk>
 <5fb36d77-44cc-4ad7-8d64-b819bc7ae42a@kernel.org>
 <eb61f282-0e23-428a-8e6a-77c24cfd0e83@kernel.dk>
 <f41ffec1-9d05-47ed-bb0e-2c66136298b6@kernel.org>
 <e299e652-2904-417c-9f76-b7aec5fd066b@kernel.dk>
 <fb292dc8-7092-45c1-ae8a-fca1d61c6c9a@kernel.dk>
 <9e8e2410-53b5-4dad-8b54-b7e72647703b@kernel.org>
 <20241218065859.GA25215@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241218065859.GA25215@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 10:58 PM, Christoph Hellwig wrote:
> Use the new append writes that return the written offsets we've
> talked about.
Here is why this is not a solution for SCSI devices:
* There is no Zone Append command in the relevant SCSI standard (ZBC).
* It is unlikely that a zone append command will ever be standardized
   for SCSI devices. Damien explained a few months ago why. See also
 
https://lore.kernel.org/linux-block/4f48b57f-e8bb-4164-355a-95f5887bac36@opensource.wdc.com/ 
and
 
https://lore.kernel.org/linux-block/6a17bdb3-af76-edf7-85a4-0991ee66d380@opensource.wdc.com/
* For SCSI devices, to support QD > 1 per zone for zone append writes,
   the write order of the emulated zone write commands has to be
   preserved.

In other words, no matter whether we use regular writes or zone append
writes for SCSI devices, something like the write pipelining patch
series that I posted is needed to support QD > 1 per zone for writes to
zoned SCSI devices.

Bart.
