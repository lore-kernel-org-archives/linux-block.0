Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC32E19343B
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733771331; cv=none; b=n434T9B898gSzlVRMboJHZwGmH8ldXsd7u4r6vAFGlcB9BCx/bF2dqy5jVnOtHpmHzWjI5LsQJkqU3OUMTjnmBmNMb1AkRv+IqgVkJMax8t9yUS8o9oFY7lVBCY1q9YNe5PH+Jg2LXlT8HaUxozAvjkWW/C2Lkm/RvqkI7iPuBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733771331; c=relaxed/simple;
	bh=27BVwxEAkS+WJUucjkmgo+xMS2RqIJk2ppibsi24YeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLuzSnkIxX/VrGxvm9r8nvqAvle5cFDB/NkL57GdTV27ojXwymjO5poZ/H8QaJWW1YVUNebfxRF4zTxUPjEuGI569u8aQQxkA0VC3uvWu5/6+8E5iOuFrsmivjhCBpsxUxPyxjV3eSqPSnMPONQ2pDSW/dFoCXsZagsvRU7CXUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=R0JdtDmf; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="R0JdtDmf"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Y6WcK1tFMzlfflk;
	Mon,  9 Dec 2024 19:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1733771326; x=1736363327; bh=zG7nlKwna2RWVUMn4gBhjGga
	oO2d8yzxCwG9qi6Wcb8=; b=R0JdtDmf7c/M87aCZesuCpzioiPUrWX2foPYuBxS
	QC2mrkl9CTPrlMfFzKvCUAy4WrVfxy9sKHxjrJHpmxe2AHm9wzpYE5hSSM2Y2yeO
	qbNqkBLWCBGxm7KcZtQxXhun4fvJXKNHIqiS3y8+csF4CC67cxpXbGRnWStiI8Ax
	qKSXcCyAtQF4xm9ipmWfcRd4QMiPfKHaf3G1ArAEy+e63M3ftQJMh807AEDq6EPk
	MuvVxmmuwVc2e+nRxyyZTa7JTyKKLuF/kz1ep6hKAnq0u6KCMDaEnY4dFxlbzyaV
	4tstlE5YTKVCL/ewl6Oyzkg+Lc2l3Ll4PxdnwBZIMDnr9A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cY6Hy3_GoWU3; Mon,  9 Dec 2024 19:08:46 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Y6WcC6vdCzlgVnf;
	Mon,  9 Dec 2024 19:08:43 +0000 (UTC)
Message-ID: <b3bb69a1-9b0c-4d77-9498-c8bbd536452d@acm.org>
Date: Mon, 9 Dec 2024 11:08:42 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] block/mq-deadline: Fix the tag reservation code
To: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240509170149.7639-1-bvanassche@acm.org>
 <20240509170149.7639-3-bvanassche@acm.org>
 <8df3fd04-08ef-7aab-77d0-a919a09838a0@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <8df3fd04-08ef-7aab-77d0-a919a09838a0@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/6/24 6:17 PM, Yu Kuai wrote:
> We're comparing v6.6 and v5.10 performance in downstream kernel, we
> met a regression and bisect to this patch. And during review, I don't
> understand the above change.
> 
> For example, dd->async_depth is nr_requests, then dd_to_word_depth()
> will just return 1 << bt->sb.shift. Then nothing will be throttled.

(just back from traveling)

As explained in the description of commit 39823b47bbd4 ("block/mq-
deadline: Fix the tag reservation code"), the default value of
async_depth has been changed from 3 * q->nr_requests / 4 into
q->nr_requests to fix a performance regression. The value of
dd->async_depth can be changed through sysfs.

Thanks,

Bart.
