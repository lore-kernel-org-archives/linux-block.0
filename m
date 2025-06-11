Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF911C84CE
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657078; cv=none; b=tifMWaKo598kn7oeGyYJH4K47f3XywEIvbgSl662PpEa3JJ2uNDa6O0syro3lUYaAtIUQxxQ/kXHP+2jQogM9EazS1w0YGF+yOb4B/n7ZIvljQ+RnD7WHeJwnrVwqQclORzKz/ZZHzxXeYu+oDeo2PvdTBoEKma1QdpR/v0H1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657078; c=relaxed/simple;
	bh=9pQw15xdiP67387DQVWAr+ZswScclwW7IuT5xa6osh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQhVrv60Bk3PHHA6laFfYKdC2lwgYbQM/ybn5Z2fF5+jiV+eTUb9Ye1Pw33k2M+IRS+jZ/rFt9nLT6VJl/9t4wPtMrYAIAS75g9ttT8FrqNkjjehL6iIHZHrObfmAYPOIzO+3a0REIZPnMQwndknTiOiCR/MqWgNbNctKBC7Ly4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JzjWIFS4; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JzjWIFS4"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bHVWR3KGgzlgqVT;
	Wed, 11 Jun 2025 15:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1749657074; x=1752249075; bh=FWQ/gXvL78lPB03xJADInMbe
	uW2b+DZLiV3vLJzUvBQ=; b=JzjWIFS4SpWjQ8KMXGPCFJN3NQ9XJy3QhLRGTiZI
	NwAXt4twqOcBZ7RV3i+GCT1tlPCk0NdIpqwDSk6iZN7LqR8AWSsI5qgs85SFudKl
	5KGLMSgNdls7d8bMnlf7+ZbjL2DXnetF82lSEVRIGGdpxn32M6iSKLuF6nUdYNkN
	2MvxSmhjwUXVZBur63VYs+FCIAjpRjSdRfq0KVVKlk3wMOBSIJUvYquAAtv7fJmV
	iv3UUq35wnS7nUBhaq5nb8km9Nu2/grZM6r1yKvD6iYS0BSSnX4MRIrXn3Ky1wGM
	0jGyg737LQixn4GDuEltwW3eQuw+fUO1lT//o7xc445fuA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id W_7xaC60TmXt; Wed, 11 Jun 2025 15:51:14 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bHVWP2tD2zlgqVR;
	Wed, 11 Jun 2025 15:51:12 +0000 (UTC)
Message-ID: <b36df65a-1b59-4c03-8d6a-d0a90729ad7d@acm.org>
Date: Wed, 11 Jun 2025 08:51:11 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 2/2] check: introduce ERR_EXIT flag
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250606035630.423035-1-shinichiro.kawasaki@wdc.com>
 <20250606035630.423035-3-shinichiro.kawasaki@wdc.com>
 <a30853d6-5d7c-4697-9bca-926962649254@acm.org>
 <6ov3repiplxgds6jcprle5jhtg33myba2cgf3bt7lsklqlvmy5@igjg7muw2hv4>
 <e9c4235a-1c60-4a61-a152-f65ae973992a@acm.org>
 <3et7jqzna2n2e7henrbr2foiopjqxl64pqxaadszrbmmuqorei@xinbpunqb2ye>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <3et7jqzna2n2e7henrbr2foiopjqxl64pqxaadszrbmmuqorei@xinbpunqb2ye>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/25 10:29 PM, Shinichiro Kawasaki wrote:
> On Jun 10, 2025 / 08:49, Bart Van Assche wrote:
>> Here is an example that shows how a subshell can be used to halt a test
>> with "set -e" if a failure occurs in such a way that error handling is
>> still executed:
>>
>> $ bash -c '(set -e; false; echo "Skipped because the previous command
>> failed"); echo "Error handling commands outside the subshell are still
>> executed"'
>>
>> Error handling commands outside the subshell are still executed
> 
> Yes, I understand it. I assume that your idea is to ask test case authors to add
> the subshells in test cases when they want to do "set -e", right? My question is
> how to ensure that the "set -e" is done only in the subshells. I think we need
> to rely one code reviews. If "set -e" out of subshells are overlooked in the
> reviews, the impact for the following test cases are left. Maybe this is not a
> big risk and we can take it, but I wanted to know what you think about it.

Can this concern be addressed by adding an unconditional set +e in
_call_test after the $test_func call and before the _cleanup call?

Thanks,

Bart.
