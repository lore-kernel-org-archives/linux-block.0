Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D046188A29;
	Fri, 23 Aug 2024 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422356; cv=none; b=oHTMsGwk9Xk6BgA2sjenm0cl5BOaf6Ltg9JDWbj0xMRo7/cDe4YBo/LZfuVCgQ1oYT5EGURF3AiMqfEEGhu102lRQx8Y5J5+OjJrPx1DiKUUQQTuibXZrJLqVAXNLi4vj31IQAl9YlOM7KGciQ6aKS0nBL6fJOv7ichSZDCc/Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422356; c=relaxed/simple;
	bh=EyufYXPNWSItb39u8DvxH833MSOIXo+lqAb2BqrMdbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dll/otl5VXBG7x5crO1x+oBwwn59R09jbl7xaFgdmW1ObaWnLyTqclkWTPVEpcaAkEEJMlgimU9jxsAHjq+cAwfFMtUE66CBjxR0dgxjzBxltWkO735mvBfoLFIJpQUm2DFjaijk7TWOhqq3Zgfj9rgzd1qqOwbyYgUTcZNEjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JEMFW/8d; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JEMFW/8d"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Wr28D203jz6ClY9T;
	Fri, 23 Aug 2024 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1724422339; x=1727014340; bh=ONVrc9T6Yvt4FzO9QEqjvKtc
	SJZtTbp8nfkejbWKyo0=; b=JEMFW/8dza0fpv/dw2t0qZsrpqJvyK3ZqSw5SsPD
	we9w3NBPZk/3G6JcV60K0kuY0v+snOmDPkxfxeT1n2ssT7F+r2xSDZyT2Gn6XEp1
	EcaQYHUvMRl8ZLFXAosOESxec+RkmVbCOlLKCCGg6DAoOMED9yzIwClPK4MkL9dW
	Gos9uzlvJYONbK9cvD0nXlt7pqL1i26Jt2o9Usn7kvsvFV/rrVNmR9wcyWY57C8I
	I/7refltH3d8d++NE8LFEL33bQ5VYViD9URUtJql/O0cxhsSqy6NT0blQBQll/V7
	ntmhD/JDzUYdTgPLYkZhFdbKUppPKv38n0alsoL2p4W/nQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MsMJKyLsDZkK; Fri, 23 Aug 2024 14:12:19 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Wr27z68t3z6ClY9F;
	Fri, 23 Aug 2024 14:12:15 +0000 (UTC)
Message-ID: <340f156b-0dbb-45d2-a6dd-31e468ead846@acm.org>
Date: Fri, 23 Aug 2024 07:12:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
To: MANISH PANDEY <quic_mapa@quicinc.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Sandeep Dhavale <dhavale@google.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Qais Yousef <qyousef@layalina.io>, axboe@kernel.dk, mingo@kernel.org,
 peterz@infradead.org, vincent.guittot@linaro.org,
 linux-block@vger.kernel.org, sudeep.holla@arm.com,
 Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 kailash@google.com, tkjos@google.com, bvanassche@google.com,
 quic_nitirawa@quicinc.com, quic_cang@quicinc.com, quic_rampraka@quicinc.com,
 quic_narepall@quicinc.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
 <25909f08-12a5-4625-839d-9e31df4c9c72@acm.org>
 <1d9c27b2-77c7-462f-bde9-1207f931ea9f@quicinc.com>
 <17bf99ad-d64d-40ef-864f-ce266d3024c7@acm.org>
 <e2c19f3a-13b0-4e88-ba44-7674f3a1ea87@quicinc.com>
 <c151b6d5-7e02-48ee-951f-c23594f6be6f@arm.com>
 <CAB=BE-RHwqmSRt-RbmuJ4j1bOFqv1DrYD9m-E1H99hYRnTiXLw@mail.gmail.com>
 <ca78ada8-d68b-4759-a068-ac8f66c51b72@quicinc.com>
 <12a6f001-813e-4bc4-90c2-9f9ef7dc72e6@acm.org>
 <688ead11-c1c0-48b2-b4d1-feeb1278c692@quicinc.com>
 <1a95a60c-730a-4bb7-80c9-98b8a70f6521@acm.org>
 <66912a22-540d-4b9a-bd06-cce55b9ad304@quicinc.com>
 <3d37e8ba-25a8-45c2-93a3-02888dad2c9e@arm.com>
 <22d1bd64-934f-49f1-bb82-1367f4a43f40@quicinc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <22d1bd64-934f-49f1-bb82-1367f4a43f40@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/24 6:49 AM, MANISH PANDEY wrote:
> while making the patch, i figured out that queue_flags is unsigned long 
> type and we already reached up to 32 flags as of now.

Really? In Linus' master branch I see 13 queue flags. This is less than
half of 32. From include/linux/blkdev.h:

enum {
	QUEUE_FLAG_DYING,		/* queue being torn down */
	QUEUE_FLAG_NOMERGES,		/* disable merge attempts */
	QUEUE_FLAG_SAME_COMP,		/* complete on same CPU-group */
	QUEUE_FLAG_FAIL_IO,		/* fake timeout */
	QUEUE_FLAG_NOXMERGES,		/* No extended merges */
	QUEUE_FLAG_SAME_FORCE,		/* force complete on same CPU */
	QUEUE_FLAG_INIT_DONE,		/* queue is initialized */
	QUEUE_FLAG_STATS,		/* track IO start and completion times */
	QUEUE_FLAG_REGISTERED,		/* queue has been registered to a disk */
	QUEUE_FLAG_QUIESCED,		/* queue has been quiesced */
	QUEUE_FLAG_RQ_ALLOC_TIME,	/* record rq->alloc_time_ns */
	QUEUE_FLAG_HCTX_ACTIVE,		/* at least one blk-mq hctx is active */
	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
	QUEUE_FLAG_MAX
};

Bart.

