Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3A830E0EC
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778774309; cv=none; b=KU+n7LD63cuFVHBeM2MuhuxdbPc5v+atdV4wJVDdLsExcBYdeZrwdN9UWICeZ5UVL7LwnqgDcKO6vFczNAMSEveviRQAtP7W13c3H6608yO/g99zNRNb3toImdJbA1fwXPy2GwQQrEqq4q2W6qEi17BO/9A2Q6SWsj5In+Lg5XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778774309; c=relaxed/simple;
	bh=i6OUqKdJcWDxltnlpK2v3TGAzzzqK5Wj01WIX+Oj4Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRTg2Lx77oCu0oPU/6vK9ZWLgeGELBOyv3fyZrl/cc/tVh5LLRUnGbn8llts6RghMEIqG2GGGH1NYuVoeEaIE0bhcEYYgKi2ajGxWtKPFwvICay8iEKTo4SNu/kpuP+Bg3vU5kaTcqYqhGY6gRA93IMmCqubj22B1EQ3qWiuWsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=s2cjmtiR; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="s2cjmtiR"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gGZkC4yyWz1XM6JX;
	Thu, 14 May 2026 15:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778774305; x=1781366306; bh=N5vLG7xsL8joJupmV0n5/mAv
	AEHRwCj84qSsI75U7rM=; b=s2cjmtiRrkhvgxIpXHCyXxYJp5dYvY0Hn6Z6iPNA
	fQZR416tu3deb3TW1UQgjfrSPkk/S6PJE675hls0A8tgOLG1iutRvoEmRV0olKzu
	Fsdsn2rGPBVLvEFJyThQBjRRHQmZ+UiX4n0I15e98JNjRKORHKKySA/NTLjdIbaW
	ZhCDsueCkQ6/cZ3Gk/PAbCrkhpJWUZ1A8o8JoRvc/DLzog6WlWaFPf+WHCOzZj22
	WXpWa0bC+lIDHzie1YWjmZmvBNT8ZDuSr6OgAnJyXKnHZSH7/Ami1/VXRkJO0kGC
	DuxJcvwX0QaU8S6tXpiSA13JCNZVp683vDZ+257dyJTc+w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6ajLG6e7wHT0; Thu, 14 May 2026 15:58:25 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gGZk85R5lz1XM6J9;
	Thu, 14 May 2026 15:58:24 +0000 (UTC)
Message-ID: <58c5d530-416a-4dce-8aa7-099eb571bddc@acm.org>
Date: Thu, 14 May 2026 08:58:23 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 2/3] common/rc: add _echo() function to trace
 sysfs attribute writes
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>,
 John Meneghini <jmeneghi@redhat.com>
References: <20260513112326.584256-1-shinichiro.kawasaki@wdc.com>
 <20260513112326.584256-3-shinichiro.kawasaki@wdc.com>
 <472b55a1-cef3-4473-b8b2-08b501efcd77@acm.org> <agWZZkwOhiSoAvh6@shinmob>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <agWZZkwOhiSoAvh6@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/26 2:45 AM, Shin'ichiro Kawasaki wrote:
> On May 13, 2026 / 10:17, Bart Van Assche wrote:
>> Should "echo" or "echo -n" be used in the above shell function?
> 
> I couldn't catch the comment above. The current patch uses "echo", and it's
> working.

We will have to switch to "echo -n" if any code is ever added to
blktests that writes into binary sysfs/debugfs/configfs attributes.

Thanks,

Bart.
