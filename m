Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC2B36AB54
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062927; cv=none; b=bSxyyPViM1HMy87i/uSQk+di4bHHOCin1mC0HWkyJOIWoGGTH4xKeit0D4EVoWODkr/UVB+6dtrwZ2B+h4pDjLcMIXV+KGLTNwwNym6pALc9Juj8DRVlUbbYE4QuevhCk8OTfjKSflyt3cfaFsrat/3hCzC84YGykw2wiy6tKNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062927; c=relaxed/simple;
	bh=URY+aL0bYPI0jpocnvfzw+lI9G39L4LkAv7rrV06AGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2Yjq1ik16xX+p4z2Wg+wKcz1qtZ9OVao88vsq0xxjfSSsWGVMD1V+6p6vNQ9O0eorXJa6yJ7PcoGQUZZhXPwcvyLuSOU5qIBKWxDcuHPfoN5GuTuzMbTET4DcbVGUXjaada4yGMePePk31UJZZAZClTaUZCeR033PipopDUa7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=F1bwvcwO; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="F1bwvcwO"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fmB9N38YRz1XM6JH;
	Wed,  1 Apr 2026 17:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1775062913; x=1777654914; bh=URY+aL0bYPI0jpocnvfzw+lI
	9G39L4LkAv7rrV06AGQ=; b=F1bwvcwOs0UK4iN0PtCqZ6wlSYCik3TmAxdWUEGG
	x7srT/VyTOx1rweEspVd2RSgGvp3uOLwCnC1ShOEJ+sNPEyr/d0Lp2LAwP980C+T
	vb8xcFAGO4doPySWtJa2tyqABLdE+VclKQ96kKT5owlm4oTBYzEE5+Tyvn7xXaBV
	nRTQAlv8zPN6afXcjX4075gsF2gkfOyq/RVKWcwkhqIK7indu4lD2XRy0J+NWKQI
	4oE/PyHDsxo7B/HaaWexBmGcQpxk+Rc58agqwnb6XdQARdqCTJFS24yWrHtk5IGX
	IvY0uCZ8MGOzuTNLuG3rnmeC2gWoIRMGosBr4w30NFdWHw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id yovfM1Ju_qCt; Wed,  1 Apr 2026 17:01:53 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fmB9C2rZqz1XMFx7;
	Wed,  1 Apr 2026 17:01:51 +0000 (UTC)
Message-ID: <aca51bbe-d157-4e40-bf0c-4c71f7597f7e@acm.org>
Date: Wed, 1 Apr 2026 10:01:49 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/26] block/blk-iocost: Add lock context annotations
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>
References: <20260325214518.2854494-1-bvanassche@acm.org>
 <20260325214518.2854494-8-bvanassche@acm.org> <20260326063128.GH24071@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260326063128.GH24071@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/26 11:31 PM, Christoph Hellwig wrote:
> and ioc_rqos_throttle does basically totally
> different things based on the same paramter passed as the lock_ioc
> argument to iocg_lock/iocg_unlock.

Hi Christoph,

I looked into splitting ioc_rqos_throttle() into two functions: the
existing code without the code protected by iocg_lock() / iocg_unlock()
and a new function with all the code protected by iocg_lock() and
iocg_unlock(). That new function can tell ioc_rqos_throttle() how to
proceed via its return value. However, the number of parameters of
that new function is large. Almost all local variables declared in
ioc_rqos_throttle() would have to be passed to that new function. Hence,
I prefer not to modify ioc_rqos_throttle().

Thanks,

Bart.
