Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AB42C11EF
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775063048; cv=none; b=oE4Tfv9xEsSrkdhD10Gfuy1OAoygICdd1vuh3Z+NQOnhBL9pf79VsPB6tuszB6KexXh/PHWOo+PzYfKFlNuRwZsvl/xDlwCMZDLjY3VZ5oPdR/X/EmKx9kafm7wv6KKCBH9pSQ0iswVSL2foplezawS6RQDEFZIy/V45F6v5aOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775063048; c=relaxed/simple;
	bh=pOGN4dEsj36di/X5daIvUeiSEeimAwpMB1mll9RH3Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTs28qB8/h9N/VWhEr9Iq4eio6flvqhA8HNCO5IuVK3GwM7NsT7hBCKgeY0d0oL6JH26AebVYLgMOYA1p3G1hXyjWtyBYystU+RNRi9RLvv7dvgv+RFVeo2+1Iqlm0IGEy386adAoBb6gWxZL1nMjupZp/fqPU8IG2/BqOt9t/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=aeeTqQgk; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="aeeTqQgk"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fmBCp5LZQz1XM6J5;
	Wed,  1 Apr 2026 17:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1775063043; x=1777655044; bh=pOGN4dEsj36di/X5daIvUeiS
	EeimAwpMB1mll9RH3Ao=; b=aeeTqQgkJSuESL18elYsxrDreGnB4mXgo8ynUJAX
	8Ph0xDgYg8QFosX8T0N194vj92nIMdCEVY92mxbtlodYAsgDxYVdO5CsHw3OPsE5
	HoyLFwjhTSq24HYAVsAJjpcZE0Gl0qUcytdbAdtsdW9jy4pSq+nTocsBERIf8z1k
	qiF/9baKWTIeaRz2W3/gOQvpxlUYN3Gnl65fHthA9IbaQrNKWdqm9NQfsqxdgbZ3
	ONZ0fSI+9/LOJr/98+IjGCYEZXjRJ5xISGQJtHCb/0DM/3LZPRrlE34nkXY8WHjx
	fInwhnaR91dPhLfCxzkZWx8+/zIkV4H8GlLJLhq+5tyc9A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Kn7TMra_ZNRu; Wed,  1 Apr 2026 17:04:03 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fmBCj6d78z1XM5kW;
	Wed,  1 Apr 2026 17:04:00 +0000 (UTC)
Message-ID: <c2b915db-04c9-400c-9682-f1f60f77f295@acm.org>
Date: Wed, 1 Apr 2026 10:04:00 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/26] block/blk-mq-debugfs: Improve lock context
 annotations
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
 <20260325214518.2854494-9-bvanassche@acm.org> <20260326063225.GI24071@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260326063225.GI24071@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/26 11:32 PM, Christoph Hellwig wrote:
> Looks fine, althought I'd still love to find a way to avoid all these
> open coded dereferences of the private data pointers using casts.

A possible solution is to introduce new single-line functions that
perform these conversions. Please let me know if you agree with making
this change.

Thanks,

Bart.


