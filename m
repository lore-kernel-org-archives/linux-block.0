Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E715C45016
	for <linux-block@vger.kernel.org>; Mon, 15 Jul 2024 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064529; cv=none; b=pCmVuUpOd8cCjlfCKx6UhYAkE6gI7+0KasWuKr1N1OzwmON517cNpD0wlkQz35SoUQtPfhsq8BVjpeE5fe5O/osSvhQeQVrSKNrc5xckCrW1hi+crkKKlw2Pj6eBZi9J/dQyuzdsFMEk3V6TF4PYnNwy0VxXpLkqZuXx3ODENvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064529; c=relaxed/simple;
	bh=CJNhuYmvnPEQgN7Hj5r7MPvfqYX0JsXnYhf/8OmqjZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhoMLUzlYg32w61KhajEe2TCQT9t9IE/0tgbNiyoXNzxam87NkJAMx4N4mc9rrw/3p9+951RdM2qZRdDNtG+qFPTTL0hTUu7aAT0ga6wCqQq/yeQ7FAxLNISLqsaFPHHu51a11D/q32tazamP/lS3Ab6O4EQXn2QCZ4V2h9dc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YyWY/U8l; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YyWY/U8l"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WN8Ll2kRHzlgMVQ;
	Mon, 15 Jul 2024 17:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1721064526; x=1723656527; bh=njHQ9isGuuklV3YnQYZvWK73
	UllkuTp4UkBoTxb5OWM=; b=YyWY/U8lHdRpKC6tPLaoUDvii3zhL44bM/F04u31
	MKjSheW7CuMcEmRhGo8zybK3TX6HPKDocg+Yew422B+Kfe0YehrkCbyEUx0NvU2/
	vXM/SQJSr3UwzJIsO7oC6vhEuejtVl6+7EymJuZTsGxhEi64lEwKbVax7gcPyhAA
	0MHJ5MXD4BL5OLfikg8xBCB83Gz36F8SsPB5aSOIwk8bfjWbHdGDqAAMvLSbMhNX
	0ql6gqpU5A5nmiYszeqgGdyg1X/Lf9jjOEhjIqcu8f39BuKWAv7RTEF/NgOg6qwK
	V8bxFPUCNx3pj7l/pIr+EZAlLwp66W98nd1BMqo4R3orGQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Ar8Nu7IiQp4Z; Mon, 15 Jul 2024 17:28:46 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2e14:8:30c:88a5:456e:8b88] (unknown [104.135.204.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WN8Lj5C3tzlgMVL;
	Mon, 15 Jul 2024 17:28:45 +0000 (UTC)
Message-ID: <1ef25aa9-dfd6-409f-ac92-9c443a05fe96@acm.org>
Date: Mon, 15 Jul 2024 10:28:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] block: Catch possible entries missing from
 hctx_state_name[]
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
 <20240711082339.1155658-5-john.g.garry@oracle.com>
 <b97da63e-386d-4cb0-9bf1-cfbe00154979@acm.org>
 <5fca6dde-bbfd-4a25-8d1d-c1257540eac4@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5fca6dde-bbfd-4a25-8d1d-c1257540eac4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/24 12:54 AM, John Garry wrote:
> BTW, BLK_MQ_CPU_WORK_BATCH is only used in block/blk-mq.c, so I don't 
> see why it is even in a public API.

I'm in favor of moving this constant into block/blk-mq.c.

Thanks,

Bart.

