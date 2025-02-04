Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAD7215770
	for <linux-block@vger.kernel.org>; Tue,  4 Feb 2025 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692030; cv=none; b=WE6qeMTokAaDgTNhFPBYCP3cbY01S+9QQ/Nh45jF5KQBtn2ukSp+G4VSeeviw23379FPIgElF7Yxg4pnynK69WTov9LbYXQ2l89px0HNik3onkF/MGKcu02X5wqTFbaYwZopGDlflLFZFECPVjOyvWet47YU4MPSUZV5QuOqlIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692030; c=relaxed/simple;
	bh=1k2UYKIFbo3X5iKK9oCUCvYMbMyfyeFn9MU/NBcdXT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcHGbgqAIJySF9N759vEyNFDRqLB/3LUoacTNhP79sxHWghGSM5KDTk5kRkJ9F6ErkSiEp7CSNGZZBOXOrWk9D00uFxAVB7cPnZjsc4n610EN6jsjowtHbdyiGOHlQCfrjhtHHeVUKtMNgY+yGDiyCk5ppwFqv1tkWj99APDJpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0GssmVP6; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0GssmVP6"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YnWP16tS9zlgTxJ;
	Tue,  4 Feb 2025 18:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1738692020; x=1741284021; bh=1k2UYKIFbo3X5iKK9oCUCvYM
	bMyfyeFn9MU/NBcdXT8=; b=0GssmVP6co37ENFHn8gWLsA4+Y49cS+nBwCT0g/g
	lt1Y+RSJooc9ye5Vi+XUDkEZFqF9ngAcl3x/qoDs8EVZ5WrDFnJppRK2LFpaPiWk
	hFLugFKlOCNXV4DrUaCGkdQpL8y1oH/GTy72BcOQGAfrUUxGMZZhc9pyIUEjsGtQ
	jXi0bwsPw5pRYJ5yvhnV/fRSVjffANMwjkGPpKJo9aJXdA+PCUnv4ehcxMU+0cZt
	iTsS8nsOVWcsHKwUJ4fgFzo9MucdTFDdKP5RvLGLqv5WZlauN9Ygc4jGYPTpNpOV
	vFHbNKDGcPYYxpKDnj0qIv+M2U86uteJvMn5JcwJawpdDw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5OMWcxlEtV3M; Tue,  4 Feb 2025 18:00:20 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YnWNy4sT8zlgTvr;
	Tue,  4 Feb 2025 18:00:18 +0000 (UTC)
Message-ID: <76edbee8-9d5f-47a5-a6ae-932ff1b711b8@acm.org>
Date: Tue, 4 Feb 2025 10:00:17 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] srp: skip test if scsi_transport_srp module is
 loaded and in use
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
References: <20250201184021.278437-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250201184021.278437-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/25 10:40 AM, Nilay Shroff wrote:
> +_have_module_not_in_use() {

The name "_have_module_not_in_use()" sounds weird to me. Wouldn't
_module_not_in_use() be a better name?

Thanks,

Bart.
