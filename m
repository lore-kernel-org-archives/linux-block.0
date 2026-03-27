Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF093603EE
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774636089; cv=none; b=tOiMq7BHLFO6uKYe2V8BdESCKtuFz+MAulnCLY+iM93bjijjYxFLxXz9dinDV+53uEYrFgym7aLaZjVNIqPIWVxt+CAHEuvo+llURxI1l6RFaY0C8OC2yeZlKAi9J9R7te+A83njXk6K+QE/w1yO7zMg0QFOqnvd3yw0o2L0DOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774636089; c=relaxed/simple;
	bh=LkjEyldzd/NFfQ0/+BVBZHhpyk56PNZakUDYA5TvPa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLzSnlbskKYGgth4z1a4BcYuwexF78Ls9hwhyK5JTGntH4c/EvBTnlG+fUawSOCpeLmzuVGuNg9AuCyvBPpGHqc5gMH09jcA8SrVoA89T8ch9z5l/oDzvfBO22SZ7a926kUiYx3DUPDz1mMmjaFp3VPM8pkS+7YUjsYTMz7OdYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OLiaAGlZ; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OLiaAGlZ"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fj8K25VSMz1XM6JS;
	Fri, 27 Mar 2026 18:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1774636083; x=1777228084; bh=LkjEyldzd/NFfQ0/+BVBZHhp
	yk56PNZakUDYA5TvPa4=; b=OLiaAGlZv0sloYR+Hh5JekGcROeqyz7Yf+HtpvRg
	3DVvjJJOIkOh7v6Hq9oQLToGADEmL59E46/9bFaah50xzElclIijUgp7fuvfjB9n
	Y1eeljxgg7daXVH0nvz0+MTOpHLv327Dql0MZJjX+/iB43UKg45g+yZuuMMHCiCL
	zIIME1Vt5/2M6sqTzAWR3Kb/wiu56IUiWcpXe6E/pt0FHdR65kSTT+TEIJy56RaL
	RnC3GnbKHJiXofWA4rsUV01m3OEk+/a0nmaHcRh7KejTPF1Pr7dqlRbOdEUmzvh4
	rVRpVnP26TxUffofe0rwIbGXksq3oFFRbJ2zMQQ8uiP2Hw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EngNg-zuYuBC; Fri, 27 Mar 2026 18:28:03 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fj8Jw2N9Xz1XM5kt;
	Fri, 27 Mar 2026 18:27:59 +0000 (UTC)
Message-ID: <37e0a051-8bc9-4af7-8ad2-8b52784897d9@acm.org>
Date: Fri, 27 Mar 2026 11:27:59 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/26] block: Annotate the block device functions
To: Marco Elver <elver@google.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Tejun Heo <tj@kernel.org>, Nathan Chancellor <nathan@kernel.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
 <20260325214518.2854494-3-bvanassche@acm.org> <20260326062507.GC24071@lst.de>
 <16074463-9242-4c62-877c-54b0939ab892@acm.org>
 <CANpmjNMiR2_s7iyXAT_nOdy+EhxR-oSf_KR089L_66d13JidCQ@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CANpmjNMiR2_s7iyXAT_nOdy+EhxR-oSf_KR089L_66d13JidCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/26 11:17 AM, Marco Elver wrote:
> No that's not supported (yet). There are various design options, each
> with their own pros/cons: the one question is if attributes should
> behave more like type qualifiers in this case (enforces functions to
> match), or just be a best-effort thing (functions may not match
> function pointer).

It would be great if lock context annotations would be integrated in the
function pointer type because today these annotations are lost if one
function pointer is assigned to a function pointer variable.

Maybe there is something that I'm overlooking?

Thanks,

Bart.
