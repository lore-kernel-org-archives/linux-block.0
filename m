Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0503195EA
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714779; cv=none; b=TOhnDRhwoz7T8/L122SiHbaGCso1y0gR1IHHcUzPE4AenBapU5bauFxMrhb365T8a0sh+Rch9MHduWEsHBugpm4s/1BUxt8H+1RU+6XWVqI5FLLy+PgDp1SMW+MRvNbwUiUGjL9JDP+p82+RYVKsPU0vaqxBBShAhp06L/Bc3aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714779; c=relaxed/simple;
	bh=Tig2ayktz5O1Utrhd2DYfDjJEisbxytE3Aj2FvrYeyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9UHMYc2t+paQIRx/yxeIAKLBW83AZnkUpOwrm8cu3BC1VZtHg1WMosB3vAjUg3M27O9Q8eduRw3dC7YWSSip9O/hLTw3TyZHqKVg8uhcbTeHkWLOQSVcVmWTm6Bo1SuhAEYxr2hJWd8y2kZ3Xx4FE/j0o8mn8R/BsfoUPX4KfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=14IWbm1a; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="14IWbm1a"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fRTmk3m7mz1XM0pP;
	Thu,  5 Mar 2026 12:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772714770; x=1775306771; bh=ftTtIeax0vlDpF/HfvUluF8s
	hnj3D50HCetBhf2uNQE=; b=14IWbm1aGqU7J+U51p1CnuTkvSec8E9V2XybruX8
	VC+JZAiqsO3gsWY9UwWfNGtCmTAxxFx2ioJkg2ewJjMYGE0nsCJhqU1ztHXZ4fNL
	IqeZgKfuF88v2kFn0Uj27yLi4V0o7WsWYtLfAkxgfQucOcWpXC8L1I4WG5Bwg9Xk
	hnpN7CYL1QAs60St/JzGJ19mSDvkuMYd6qA321NoDHg7s3udMLZgIunb1UjMMAG1
	7XY+Qy/aROwBlZP3ag3QfQ7pTeyM8fE0I9cGljEvLVcFfp51GlzNQwOXXG9g59Om
	BZ8/BgmWEVgCAw1DCiuEfn/RYGHDe6DfdNWCWzp6TUh7cQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GVee-PXqiyd1; Thu,  5 Mar 2026 12:46:10 +0000 (UTC)
Received: from [192.168.132.187] (unknown [12.150.89.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fRTmb554Wz1XM6Jc;
	Thu,  5 Mar 2026 12:46:07 +0000 (UTC)
Message-ID: <a7834c93-1eaf-4230-9add-d1c4b77549c8@acm.org>
Date: Thu, 5 Mar 2026 06:46:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] blk-ioc: Prepare for enabling thread-safety
 analysis
To: Marco Elver <elver@google.com>, Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Yu Kuai <yukuai3@huawei.com>, Nathan Chancellor <nathan@kernel.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
 <20260304194843.760669-3-bvanassche@acm.org>
 <an6x6or3aceomqwhy4rc4zz5a4kyrnbitoz3v2m2ekkfaaslnu@uuwya3gdk3qp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <an6x6or3aceomqwhy4rc4zz5a4kyrnbitoz3v2m2ekkfaaslnu@uuwya3gdk3qp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/26 4:10 AM, Jan Kara wrote:
> On Wed 04-03-26 11:48:21, Bart Van Assche wrote:
>> The Clang thread-safety analyzer does not support testing return values
>> with "< 0". Hence change the "< 0" test into "!= 0". This is fine since
>> the radix_tree_maybe_preload() return value is <= 0.
>>
>> Cc: Yu Kuai <yukuai3@huawei.com>
>> Cc: Jan Kara <jack@suse.cz>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> 
> Frankly, I dislike changing the idiomatic ways we use in the kernel for
> checking for error returns just because some static checker tool is too
> dumb... It may make life easier for the tool but it makes it harder for
> humans which I don't think is a good tradeoff.

Marco, do you agree it would help to add a variant of
try_acquire_capability in Clang that accepts a range of successful
return values instead of a single boolean? That would not only address
Jan Kara's concern but would also make it possible to annotate the
many functions that return an ERR_PTR() value. With the current
thread-safety support in Clang the only option is to annotate these
functions with __no_context_analysis.

Thanks,

Bart.
