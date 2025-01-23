Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F0AC2FD
	for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 00:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737593592; cv=none; b=W1ALOBGACiFo4/WkJkK2oQ9xmmtGHVErkBXUbFWgrEXLuO6cptkldooUNtTg5blgBBCNKxLvF9QvQ1e4zXtwcx/D79CoZqaTsiWCywRyuadbVoZLteAX5p0LjG+6DZPXo+hD+BZ0DRO0J5iBscUIwKFejVrVJfjs3i0VNHBOE3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737593592; c=relaxed/simple;
	bh=rQR3RlhfUuZ4DDKM8HISXRRC6fPWAPsA6oLOd1d8bK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RiD73eyXH7MP09y3g3h1m/9UKrjGBSB4NO2D9u/jPFX0ODG8A1Uvlwd+0/xeiE86vXSvc6bHpSmbSmy9tIpLpjhJa4sl+Z4PIuGVE8XEwhtEW3nEMRPhHolXY8yWtSjQAj52dPc+SGJYI5/M5ws+WNvOY73mULlCUALriK1uvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OBblMO6t; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OBblMO6t"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Ydj9K3lbYzlgT1M;
	Thu, 23 Jan 2025 00:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1737593583; x=1740185584; bh=rQR3RlhfUuZ4DDKM8HISXRRC
	6fPWAPsA6oLOd1d8bK8=; b=OBblMO6tZhfMK6BjuzEm/oHj6y1gtfFm1pdyOD5q
	SW+OL4yWnwbssIp+33Dzkcrmf0up/uAsvlukMDHZDiNSgA0L9KkCP9j2PoBquFRo
	7aJ7oD/ZPkrzADE8EBE65YqyKXcriZbKeDL5+K8lHJ3d6ndReCKIJbpn3oxK/ol9
	dq1/YQTLwArSH7RNemn6zrfxLeOmmJQ/K765KvCbaXigbibUSqUaIibm7zv7jVSn
	/glhvA5iPErt6IRxq41KDN6B37ZAGzUPrc54PFKVtYTrn+pccFnIOCSbfjiUR1O7
	G3ex1s+Bss4aFuzQjPWCrt8D87qrE2IJEPi6WTwng388JA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nVdKWhE1uRli; Thu, 23 Jan 2025 00:53:03 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Ydj9565HXzlgVnN;
	Thu, 23 Jan 2025 00:52:57 +0000 (UTC)
Message-ID: <4f639499-1eb0-40bc-b1b4-26996e3fb0f8@acm.org>
Date: Wed, 22 Jan 2025 16:52:55 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 14/14] scsi: ufs: Inform the block layer about write
 ordering
To: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Can Guo <quic_cang@quicinc.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Avri Altman <avri.altman@wdc.com>
References: <20250115224649.3973718-1-bvanassche@acm.org>
 <20250115224649.3973718-15-bvanassche@acm.org>
 <a0923b0c-ba96-e025-e063-59ba9f97678d@quicinc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a0923b0c-ba96-e025-e063-59ba9f97678d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 1/16/25 7:58 AM, Bao D. Nguyen wrote:
> On 1/15/2025 2:46 PM, Bart Van Assche wrote:
>> This patch improves performance as follows on a test setup with UFSHCI
>> 3.0 controller:
>> - With the mq-deadline scheduler: 2.5x more IOPS for small writes.
>> - When not using an I/O scheduler compared to using mq-deadline with
>> =C2=A0=C2=A0 zone locking: 4x more IOPS for small writes.
>
> Wondering if the change has been tried on 4.x hosts and using different=
=20
> IO schedulers? Any performance improvements?

Hi Bao,

Agreed that it would be great to have results for UFSHCI 4.0 host
controllers. Something that's unfortunate is that my UFSHCI 4.0
test setup runs kernel 6.6 and that I have not yet succeeded at
backporting the zone write plugging patches (a requirement for this
patch series) to the 6.6 kernel. A test setup with UFSHCI 4.0
controller and kernel 6.12 should become available to me around the
end of March (two months from now).

Thanks,

Bart.
