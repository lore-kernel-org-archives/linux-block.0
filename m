Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FEC44AB9A;
	Fri, 24 Jul 2026 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921983; cv=none; b=tYRYpVleIfM0PYii5izzkGAzBOhr1oFzJVIIbNl0W3bokgG7fxxZPldbOX5FItNGHoZ9CNoUUVyx3Kg1EXJeRwImAJ9+jeFZDWttUB079Sl2tREuy5L9IHytl+wwQYBh7WAj0FOvZflPBun1mnDUCPsK0p0sTpVzr7ceVzbOnJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921983; c=relaxed/simple;
	bh=EqqTpor9tX0TUxZRphka8rjjO8kKQfBCXwYvOzt21Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6wBiIrqhwwZmfmRFUV8k1ycfRBP2JLotFkbE677bH0iJX3NgyUD+sPtlyTJ+NJPNt4Q8x+X8VHlz9+eLH3ElDsa731MnkIPybCxfASQHq/imxXHTQ04k7ZzXhVjFcOV+Id1TzNg+CLNhVTLwX3RjOU0iNyBoy52O8iESWZ6qZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=u9Z21ldm; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="u9Z21ldm"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4h6JGj4Sbhzlfvpb;
	Fri, 24 Jul 2026 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1784921978; x=1787513979; bh=yLOiYGiMIhOm5K40/b8I9sQC
	KgCL7Edg6O4AQtiFuyI=; b=u9Z21ldmXsiCnhEQRCUcxCFWifsJBXzAoZk4THna
	FC6IuAGM3QbjO+fsmP+FH38h1xbG6DFyPTRbJ0KDdKZrbazJh9wm+9HCQrUedpkn
	UPid1rluc/4SkJdG7e9/E4BBSTHCPf37DkOV7Up/r0R1455aKw5/IctPQT3QfPc6
	Vl4NOuqekjqnMmWHMZEjZyH3NUSJCPNbhZBEq3qB/1z9TU5rkDzGfOx5mINAYINL
	xSACGLdLniHpZYdqU/Ps5uPT7AOoN4vhhwNgwI2xcI4Pq6VuVbE/LElyITkLiqkq
	T+0InNDFwWkN+AaAsiCMRi62/qedbHvwjwsPuiR/pinbcw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6P8n4Zz_Szcr; Fri, 24 Jul 2026 19:39:38 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4h6JGc45JTzlfvpW;
	Fri, 24 Jul 2026 19:39:36 +0000 (UTC)
Message-ID: <4ef6f2b4-57b9-40cc-a5cd-e34473e1cba3@acm.org>
Date: Fri, 24 Jul 2026 12:39:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix BLKSECDISCARD zero-length range causing page
 cache invalidation
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260704073942.3760597-1-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260704073942.3760597-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/4/26 12:39 AM, Zizhi Wo wrote:
> Commit 697ba0b6ec4a ("block: fix integer overflow in BLKSECDISCARD") fixed
> the start+len overflow via check_add_overflow() but did not handle the
> start=0, len=0 case. There, start + len = 0, so end = 0 passes all checks,
> and truncate_bdev_range()->truncate_inode_pages_range() is then called with
> lend=UINT64_MAX, whitch is the "truncate to the end of file" sentinel, so
> the entire page cache is invalidated.
> 
> Fix this by replacing the validation with blk_validate_byte_range(), which
> already rejects a zero-length range and is what BLKDISCARD uses. This also
> switches the alignment check from a hardcoded 512 to
> bdev_logical_block_size().

A Fixes: tag is missing. Once this has been addressed, feel free to add:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

