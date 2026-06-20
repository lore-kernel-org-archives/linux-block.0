Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15E022F01
	for <linux-block@vger.kernel.org>; Sat, 20 Jun 2026 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781939518; cv=none; b=nQRXxs9MdirZoiwkv68fwc3hEG916aKqXyf3qbi8RIKGxCu1iBgDeVA+c3fJzgr58sqQ8kQJPgA0KZybxQ/GDpORnzagiHtPEc62GHExWOSgWrtn67PMMKgZ+Fq4IhniNl/UjVk2gGa7JZ/Lr2fDX363JHMr392izlcysv8vRhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781939518; c=relaxed/simple;
	bh=Y71ONCx1FU9qyn9+N4p/R61QZXgPrhVZY2OVrfST7xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jeI2JCAm5FdQmzksIBIcI4vb9sP1fBEjmtmQC6VD0nm66SU0cuZkmc1OikVy+j7+AhKAOSIkhaRdcjcgypWRTnBk/r0DhZi/mgeV9m5BZ1CrgV8Dv6sE9E5nKFDxVzmweUlPz/YgT1WD9oMpqnuJQ8booJg8rVwnL2ULAQ7b7b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=HV158xRs; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="HV158xRs"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gj5Hc2Xg6z1XM2FS;
	Sat, 20 Jun 2026 07:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781939513; x=1784531514; bh=IUZYr5qG2bJGaBEq3LOCBPtn
	Y8MmtKHbu1r+MBq069k=; b=HV158xRsHeeaA12P063sO16idg6C/NvsW53JVOTO
	3OPO+KSgtJuEF2DT9SQJPERPPy9iI/6np+T3NBF21OAU8KkFWpKzsLBCEziyaNnK
	iyrGBwknEVu1F4/YQTkKHDURSQqxHRWUSNcZM1Qep+r0G0VfHUaqFRo96xXxEFUY
	E2jraGz7T/YW3GpT661I+9u4J3iQqkC7fTp7LsHHIQJetTIEixUGPJdtTzIKyX3/
	uDtSW0zmfgFz9wJaSx8PVmR29jcBMmNu+M2QCXIxL3tEZLIUQoFgAAi2zJ6vfdjF
	4tS22IXrz/tZdjGLQhv5pU+uS3fvTOxFSPbc1lD+y+M9xA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id UZINQ1zWjJI9; Sat, 20 Jun 2026 07:11:53 +0000 (UTC)
Received: from [192.168.0.145] (178-117-58-162.access.telenet.be [178.117.58.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gj5HV6fhtz1XM5kt;
	Sat, 20 Jun 2026 07:11:50 +0000 (UTC)
Message-ID: <089e0281-4df8-4358-91ce-1f5cc0f0ec4b@acm.org>
Date: Sat, 20 Jun 2026 09:11:47 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] Fix _get_page_size()
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Jeff Moyer <jmoyer@redhat.com>, linux-block@vger.kernel.org,
 osandov@osandov.com, kch@nvidia.com
References: <x497bnvlxlc.fsf@segfault.usersys.redhat.com>
 <ajXmBu9lDZwgMG7_@shinmob> <d0432702-ac0b-410e-9586-2cb9be079033@acm.org>
 <ajYabLMbEo6zyOWh@shinmob>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ajYabLMbEo6zyOWh@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/20/26 6:51 AM, Shin'ichiro Kawasaki wrote:
> On Jun 20, 2026 / 05:55, Bart Van Assche wrote:
>> On 6/20/26 3:26 AM, Shin'ichiro Kawasaki wrote:
>>> This is a rather fundamental change, so I would like to ask opinions from
>>> other blktests users, especially Omar and Chaitanya. What do you think about
>>> the idea to add getconf to the requirement list?
>>
>> CONFIG_PAGE_SHIFT was introduced in the Linux kernel in February 2024
>> (commit ba89f9c8ccba ("arch: consolidate existing CONFIG_PAGE_SIZE_*KB
>> definitions")). Older kernels had CONFIG_PAGE_SIZE_4KB,
>> CONFIG_PAGE_SIZE_16KB, etc. This means that it is possible to derive the
>> kernel page size from the kernel configuration file for all upstream and
>> distro kernels, isn't it?
> 
> I checked the commit is in the tag v6.9. My Debian bookworm system has kernel
> v6.1, then the config file at /boot does not have CONFIG_PAGE_SHIFT as expected.
> But it does not have CONFIG_PAGE_SIZE_* either... I'm still afraid that kernel
> config file approach is not reliable.

Right, for older kernels CONFIG_PAGE_SIZE_*KB is only available for some
but not for all supported architectures.

It is not clear to me where the desire to avoid the dependency on
getconf comes from? As far as I know it is available on all Linux
distro's. Since it is typically included in the C library package it
should not introduce a new dependency.

Thanks,

Bart.
