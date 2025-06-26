Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33B31E7C03;
	Thu, 26 Jun 2025 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750954078; cv=none; b=Q16NKSXqwRTXHBp9m9TQBdsvKT3s7DXsEPmhBUg2DJwMzOTlPWs+Es37t7BdWgzo+VgtKwZa4xYecgrL8EqiYjHWgFH6bFBHRHLpdsyyLrun4KuywRHaPogr8dSzEeDtFag0byAEYa6Hjw5rI48wJgeQO/UtBkub1q8u1mbtmnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750954078; c=relaxed/simple;
	bh=KL21l540I30nzx4Nr1L75eKP0fD9eowHptJE81pUqAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgofRlfbz6gv2eBJ/IcH9gsfhitSW3dx7PAdUDiBo1P7M+PEg3aqeyHCrZH4wg8SRpI7eUmxLaghAJowG3h8Kj6dx7OhSLINWxvHpQCL+5Cy/efTIMESf9PMPWt60QAmzJHsoBbEwLCvWVEI7LrYwtKSD2hzQscK7+EHQXne4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RtacytCX; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RtacytCX"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bSk9l5Bhxzm0gbQ;
	Thu, 26 Jun 2025 16:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1750954074; x=1753546075; bh=KxYf3wLLOYlrd/Sq54BhcuYs
	cJ+t0s1eZz/49Duoj2o=; b=RtacytCXZggDdgGc5XN9L0A4Yi6WrzdFIzugXbiz
	IoLofwmvX+CGA92RBQQkCkW6dnhgKq1xA0QtYpkjriS9DVI5Wb44wY2k2yH1jGLf
	U5VV5ANTI0fllZRB2QVn7O/FcL2Sk0O0PC1jfC5xcp+pH5qY264nNn2fdEZ3XD2P
	E1W5EWjOeI8C1g4v7nmQflmA3Ah9rg/K1aTchA2ZnjD1JGS+ou7ysbC35dROVPsa
	SgM+jDsISCdGYGwfRS/Ean0u64Zc4AmndfrWA//SCRyBLIiNghLK7WftYh4lsjwi
	Q3+UnuIjpBLT9VA1em1X2fVD2bSNbkY4ZVcmgDEKkhMNcg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id bHDVGSpCp3Fp; Thu, 26 Jun 2025 16:07:54 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bSk9f5cWBzm0gcN;
	Thu, 26 Jun 2025 16:07:49 +0000 (UTC)
Message-ID: <43efadb7-8251-4a7c-a962-437a6c97762d@acm.org>
Date: Thu, 26 Jun 2025 09:07:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related to modifying the readahead
 attribute
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Nilay Shroff <nilay@linux.ibm.com>, stable@vger.kernel.org
References: <20250625195450.1172740-1-bvanassche@acm.org>
 <20250626051506.GD23248@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250626051506.GD23248@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/25 10:15 PM, Christoph Hellwig wrote:
> On Wed, Jun 25, 2025 at 12:54:50PM -0700, Bart Van Assche wrote:
>> Fix this by removing the superfluous queue freezing/unfreezing code from
>> queue_ra_store().
> 
> You'll need to explain why it is useless here.

If nobody objects I will add the following text to the patch
description:

"Freezing the request queue from inside a block layer sysfs store
callback function is essential when modifying parameters that affect how
bios or requests are processed, e.g. parameters that affect
bio_split_to_limit(). Freezing the request queue when modifying
parameters that do not affect bio nor request processing is not
necessary."

Thanks,

Bart.

