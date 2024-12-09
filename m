Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7469A35940;
	Mon,  9 Dec 2024 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733768156; cv=none; b=aFQiIVT9iNLY8NeEjnwVubVCqjoV5nH5TKV4KR6M7P65MLgknTpxqWgV74F67vyyr6WuJXWM3bTrSQ+7q9LcIPmvTvGwJwwAyaBgPlLfdMbGzajePPmFLJRqsv3w44MOG0G+7+yvguE6tWz93jquYiLXZAiOS5xmrYK/whDx0vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733768156; c=relaxed/simple;
	bh=+VNaXCdCBUo8fhtWnSkUoEHA3l1GNctqMXNx4aGLi8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Et+R1bb8Su9p6VzVWgdwM9XVr4TpBkEZZAHDto7zN/Kpstyxh77e7wkf2BhYe0M4QuYqSMhkso8Vh+nolp6l1zdWYkIXQrBoq5GpkTXW641t2y5gFT9B9N2IUuzwUGUpvmJYYPwTECm75o+E9mUUMTEJVXOnd0enBWwzKMSAREM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OvG1zj3y; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OvG1zj3y"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Y6VLt4w3zzlfflY;
	Mon,  9 Dec 2024 18:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1733767922; x=1736359923; bh=XbavAQT2tBD2N+OkH44rTIHU
	HOUIf131SRpW4H9G6FU=; b=OvG1zj3yKFBbYeIZ9j8he6IvAsj/VekkQ5ILAncq
	sLJnLVNmkrqzVCuPfp2hhVM1TR2IRjTwSyYkLmgH6K9AOsvf2DTSzH80vamGk4xM
	s8WUM89nhXayBB+9HVkaCYHSSdkcbaoQvj65SJbw+0HBRivsSI/RlxbeKfbg/VbF
	Pii3izARckdqeC3cdUkl4dHN7GEQAYrf3P3pDCTnG6iwA6PydSaM17txTn6QgPLK
	jpHyyPdpnaMpiYrGRv/RwSvhL7csJhHmyA4d/TkXM6XH7dQbX3OFccnZFgYgbhnU
	UyxSkfdo8xNa3fvTwZch5dsHnVEEV2YVRCn/c3p8tVMQug==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id G_7sSOhAz231; Mon,  9 Dec 2024 18:12:02 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Y6VLh2NrQzlfflB;
	Mon,  9 Dec 2024 18:11:55 +0000 (UTC)
Message-ID: <3e401555-e971-44c2-b9a4-5c746baaca8a@acm.org>
Date: Mon, 9 Dec 2024 10:11:54 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] lib/sbitmap: fix shallow_depth tag allocation
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
 akpm@linux-foundation.org, yang.yang@vivo.com, ming.lei@redhat.com,
 yukuai3@huawei.com, osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com
References: <20241209115522.3741093-1-yukuai1@huaweicloud.com>
 <20241209115522.3741093-4-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241209115522.3741093-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/24 7:55 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, shallow_depth is used by bfq, kyber and mq-deadline, they both
> pass in the value for the whole sbitmap, while sbitmap treate the value
> for just one word. Which means, shallow_depth never work as expected,
> and there really is no such functional tests to covert it.

treate -> treats

The above text is incorrect. I have verified that shallow_depth 
restricts the queue depth of asynchronous requests for mq-deadline if it
is reduced from its default value. The function dd_word_to_depth() in
mq-deadline converts the value written into the sysfs attribute into a
value that is appropriate for the sbitmap implementation.

That being said, it seems like a good idea to me to modify how the
sbitmap code interprets 'shallow_depth'.

Thanks,

Bart.
