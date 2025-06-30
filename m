Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442642AA4;
	Mon, 30 Jun 2025 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297304; cv=none; b=nUH1cFRIZ0OCjdFOLN0uNQWIdUKHPrPgnbtX1DIGChQmJQ9R87WmVXYH6cjx7C3EPk5CA6b55Vrhiy1gBf9fta2o9Hi1tKPeExn7HurXbRFzQYCuAdhgsKqkDrfLFMn3wXvUJAEsqFqMo98sg1V7uhq2pbP1DnVnClNaKomqirs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297304; c=relaxed/simple;
	bh=0Xv1vjv4futKXHAjk048e6r8kxFRcCkSa5gCzJl2f5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJm2PJ/JsFPqPPTkeoLRRDk+qU8vZ4dFYn6OjUlsmcady8y+bNMZqCe8xt19a0OD5ctpFeeG168HU4lN2XoUkO2ollwbycm/emSF8B/UiEtmAwDOPpuUbSaTWnrQJ/suAMViIiXtNjQnfKgsKVcSakmdSiaook4dxRPjIrjfIhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0q3lwp0A; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0q3lwp0A"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bW9673HqczlgqTv;
	Mon, 30 Jun 2025 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1751297294; x=1753889295; bh=kcvb8zxH7vcjJft1XzxKvvp+
	hx51blQwxPAmz93DPXM=; b=0q3lwp0At5jDlMDjg7FPpSxdDdqE6VvelbSGRQh0
	ZvSvh5yGPfgthKz8KKYH+xP3wv4LM9blAFywW0+5si0UN+YPOU5zx1BPW7Zgmjdz
	FbcA92f6ymGid5/Z+9MU0hxhRz4BwVvcR+bl5zau5TW0O5huuqUSTu7q/bz6LZ5l
	9O5wAe1RwVvR8mr7UT40AQuxxImRB4w9r+RZKdcY2wFdQEyYXyY4+UgWdbgCKQDa
	evgz7Pb3tugltBoij/++G1Ca5iquzQ2yKjcShEZMe8ebko8C0Lt/xJRYLNmEToCy
	oKbS/+z1ZrLGDsoD2qt+/ny+X0unthK51v5mqJ4kHrGB3g==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id jeG2RULudk8w; Mon, 30 Jun 2025 15:28:14 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bW9626wqBzlgqTr;
	Mon, 30 Jun 2025 15:28:09 +0000 (UTC)
Message-ID: <765d62a8-bb5d-4f1d-8996-afc005bc2d1d@acm.org>
Date: Mon, 30 Jun 2025 08:28:08 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related to modifying the readahead
 attribute
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 stable@vger.kernel.org
References: <20250625195450.1172740-1-bvanassche@acm.org>
 <1816437d-240a-4834-bef9-c9c4a66bee0a@linux.ibm.com>
 <ca4c60c9-c5df-4a82-8045-54ed9c0ba9be@acm.org>
 <7e4ff7e0-b2e0-4e2d-92a4-65b3d695c5e1@linux.ibm.com>
 <344a0eef-6942-455a-9fb2-f80fd72d4668@acm.org>
 <6a9bf05f-f315-417a-b328-6a243de3568e@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6a9bf05f-f315-417a-b328-6a243de3568e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/25 3:41 AM, Nilay Shroff wrote:
> Looking at your earlier dmsetup command:
> # dmsetup table mpatha
> 0 65536 multipath 1 queue_if_no_path 1 alua 1 1 service-time 0 1 2 8:32 1 1
> 
> In the above rule, the option queue_if_no_path seems bit odd (unless used
> with timeout). Can't we add module param queue_if_no_path_timeout_secs=<N>
> while loading dm-multipath and thus avoid hanging the queue I/O indefinitely
> when all paths of a multipath device is lost? IMO, queue_if_no_path without
> timeout may make sense when we know that the paths will eventually recover
> and that applications should simply wait.

I refuse to modify the tests that trigger the deadlock because:
1. The deadlock is a REGRESSION. Regressions are not tolerated in the
    Linux kernel and should be fixed instead of arguing about whether or
    not the use case should be modified.
2. The test that triggers the deadlock is not new. It is almost ten
    years old and the deadlock reported at the start of this email thread
    is the first deadlock in the block layer triggered by that test.
3. queue_if_no_path is widely used to avoid I/O errors if all paths are
    temporarily unavailable and if it is not known how long it will take
    to restore a path. queue_if_no_path can e.g. be used to prevent I/O
    errors if a technician mistakenly pulls the wrong cable(s) in a data
    center.
4. Unnecessary blk_mq_freeze_queue()/blk_mq_unfreeze_queue() pairs slow
    down the workflows that trigger these kernel function calls. Hence,
    if blk_mq_freeze_queue() and blk_mq_unfreeze_queue() are called
    unnecessarily, the calls to these functions should be removed.

Bart.
