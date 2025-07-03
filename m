Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05E11853
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 01:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751506250; cv=none; b=Iw/r3P4W7f5ju8bjzOkJfy6xANmxHGtilvbnXe7QEz/3vBTuFyvZrMtPsJ1nMWQavEPh5kZz6bAovXTgSA2Rymo3bo1d79zGw/9PoaqnMqVVpeDVZ5Jjml4QZ7HO/X6ZHAfAXzQhMeUIWTVMl0cYrl4kgrOt+b5Ua4aDx9YCNIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751506250; c=relaxed/simple;
	bh=ljsXL1NvjAWobwikc+8QwOw+TVah/u4A4QMr1T4KvZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4FEIST9V5hU3UN7VqkRTdunckIX177cT8jjZylg0vEtx+5lO6MvJiUrpQGg2p7EUJfFWk1rZki6rZfIA3ejNuVH0eQuZ1xh8t1ogPG/+PY+s4lSAUE1Apr33DueD3JrEJXnu+jH6FtR0lXypiKzLS/+LdYYdj6tGTGKF/gtrMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SOigKziu; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SOigKziu"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bXfNR4QFFzlyKCW;
	Thu,  3 Jul 2025 01:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1751506246; x=1754098247; bh=ljsXL1NvjAWobwikc+8QwOw+
	TVah/u4A4QMr1T4KvZ4=; b=SOigKziu3FKBEvX6U6aTj1bzGzGmlaY8GblpkPLr
	cxn9wRjGcA2CVCid6MKPfWooXzOqqnnLRnEiXY4pKH7dpGEP2xqP1OxvvDPDzMuc
	XfPYp1Tm+SJi/BAWnJHtiuAcaAveck+tPzoGArh68Q1AiTfFfIhfJ59n5gzILJn6
	nfnGxlP55Hk7NxOIq5Y6qv+6Japr7LujHVptmOMdEKjzqOJz/MsSpHWrc5KrinKZ
	JB0I2EbVatSM5+Y3oGKcqhDMJ7Bdo0MSAsknTs6IJCxTXGFhLSnofrKLqGqxrZvg
	Md9R4Sx23ohPDNQjXLsMSLYErhIN2xdr+lC7UE3/av5zIg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9GwDu6b-Oxbp; Thu,  3 Jul 2025 01:30:46 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bXfNK5Hsxzm2XgT;
	Thu,  3 Jul 2025 01:30:40 +0000 (UTC)
Message-ID: <93500d50-ba11-425b-8d5f-1ce1930e4160@acm.org>
Date: Wed, 2 Jul 2025 18:30:34 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] block: Do not run frozen queues
To: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250702203845.3844510-1-bvanassche@acm.org>
 <20250702203845.3844510-3-bvanassche@acm.org>
 <699f9f38-009f-c5da-dfd3-60531e16c1ce@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <699f9f38-009f-c5da-dfd3-60531e16c1ce@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/25 6:15 PM, Yu Kuai wrote:
> Just a question, blk_mq_quiesce_queue also calls synchronize_rcu() to
> wait for inflight dispatch work to be done, is it safe in following
> patches? I think it's not, dispatch work can be running while there is
> no request pending, menas queue can be frozen with active dispatch work.

No work is dispatched if a queue is frozen because freezing a queue only
finishes after q_usage_counter drops to zero. queue_rq() and queue_rqs()
are only called if one or more requests are being executed.
q_usage_counter is increased when a request is allocated and decreased
when a request is freed. Hence, q_usage_counter cannot be zero while
queue_rq() or queue_rqs() is in progress. Hence, neither queue_rq() nor
queue_rqs() are called while q_usage_counter is zero.

Thanks,

Bart.
