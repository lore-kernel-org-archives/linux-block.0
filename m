Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C14C18E359
	for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569743; cv=none; b=ATbbu71dDW91NRAHIiwjdPo7UTScyHXrxAjFOBJIphEEViqIY/m8CTHq/Ce74A1gpYUpwCjx8F4ZccfiBZ1sgVVgo+sXFlR8q9W95/FjZmDlZBca6dhfdsY/g3xKsI1+1nblevp/dMWBt8Q5BUNZeXvQOSRRLIijYGF8bVrARPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569743; c=relaxed/simple;
	bh=P+1fJAQX7PXlVemoV8O4ua0Hvd6fa5MUU19HYRD6EU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLW9TfeLhcgXmHdUH9bVvAUgUztPa6QrickeNdh1yhxSqUIdrHtMSjZ+fUEooueRZj8FP1ZBtoLCU8A/V/SWY4bKRLiNSr2JZgQgih7/PrAAWkHCIXDtGi4qCpreKyUF5cSMb0Uy2G/0wohbB9xn0nD/tXEhA8S52r6PXM/Bf7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0o55IQI6; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0o55IQI6"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XxzDs41yVzlgVnN;
	Mon, 25 Nov 2024 21:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1732569740; x=1735161741; bh=wqPID4dvnLTqSasVcFiinwot
	UqwdRMKOPMXG9787NHo=; b=0o55IQI6HVyEKNnKPooTjYadn0uluTPau5Sc0z9H
	r9nTq5sTHXkDSe9p5vZjskBSSkfBgU5DnK97tk0fi9KfcB14FpNM1cFvgiloKVaD
	6P5C0j8yDEp+6hofa9fv6L3ng2N1BRRrfLJrlLii9TshUh3SDnaTRd4fLcwLL9LF
	zJHrC/SXdLb/MdC/ff3eCDmvE06Os161SzzNUO+BICgWILj6EWl6kdkr+wOQZ1Fr
	UnXQE8pej3UdH7YY2Z/bSDYs5HuK9BqtYfnecw/8IhUM0nKWkVx++UgM28NDUFSx
	WWur0mZrxljvejry9sQuXtjBCoLKnT3rk/+oB6+1q4w/gA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id snfsf_cXaj98; Mon, 25 Nov 2024 21:22:20 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XxzDq4vfwzlgTWQ;
	Mon, 25 Nov 2024 21:22:19 +0000 (UTC)
Message-ID: <0ff201f8-40d1-4cec-b964-0c8d848d80b5@acm.org>
Date: Mon, 25 Nov 2024 13:22:17 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zone write plugging and the queue full condition
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <33753e7a-d38c-4a5e-9a8e-c2e27000337c@gmail.com>
 <73427797-9620-4cb7-bc9e-3f073eaa57fe@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <73427797-9620-4cb7-bc9e-3f073eaa57fe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/24 6:36 PM, Damien Le Moal wrote:
> and then it runs, but I do not see anything blocked. All is fine. Could you
> share your kernel config to see what I am missing may be ?

The different results are probably because of a udev rule that is
present on my setup (coming from the Linux distributor). Can you please
verify whether test zbd/012 triggers a hang on your test setup? In that
test a variant of the udev rule has been converted into a background
process. On my test setup (x86 VM) test zbd/012 passes with kernel v6.9
and hangs with Jens' for-next branch (commit 7eb75c9e3b24 ("Merge branch
'for-6.13/block' into for-next")).

See also 
https://lore.kernel.org/linux-block/20241125211048.1694246-1-bvanassche@acm.org/

Thanks,

Bart.

