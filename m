Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D6B14E2CC;
	Tue, 10 Dec 2024 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862829; cv=none; b=fCVYCHIRhQWeKP9ivvFAz1UlfuV5smcB7fSqq5Bb6WNx5xpiRBkQiE8ZYgS39fSojdPgqUHtcD9SFiOyFDk6njU+WbccEeCUmNTbP489J/1zXVtXYCLsGkdklS18wDhEz73URw67OyYONdL3VFe5d2EoOd3p2RR3L7HhNhaJWWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862829; c=relaxed/simple;
	bh=gCX3Kg2zrlybcZgIZASFW4SayKABZoVZVYeRec8AoMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqVWXJw+EF0BC1bxx+nzmH0Yncg35n058HiJmXZ2nH8BB2HosGLry/gtJfXial1FH9F+eGNR1xCxb1QOhSepQA79Tq8VwH0xXAza3feZTjZnTWSTQ9oPrH4uCiHOPENwlMqPa3EafoHccqCX/j3YM8pLsXuuXuGFaPx4W9FlprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xtueQlW0; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xtueQlW0"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Y79Rn0vTSz6Cl4Pk;
	Tue, 10 Dec 2024 20:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1733862814; x=1736454815; bh=2U7gKiL8ugvTpuPKu/6BqFFj
	wbiz86mIkeXs667F/Yw=; b=xtueQlW0zQb/YC92NBgEyoOTPLXcUENDwUqPsOD9
	29FuTLNbNGJbWz+Rh2H/39DS8uSKeJQOwD+0L9l7PvtUxojnZRFqciA+k21N2832
	0V9Cb2qBqGAK0hGQdPxfHOfHl7Ly2d3940OgHKnCkRINo4FE3HNAjvF2bYybooQi
	9pIZvPcQrswIyIqn5qkznsNgv5a6nMC4OfdVn2va91Xb0nu1C1ZOn1mdsjTFgvio
	TICGY+LnEGI1PHJaU/Wy1mTQx2/caGtCEtqoL22i+ZlrisjX2UtFunnkchXoj8gu
	VJ+xP69l09NdL4tJccpvxv+vBVP0kjFFuglCZEf9JOGOIA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PhYZ8bO0RNb2; Tue, 10 Dec 2024 20:33:34 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Y79Rc1LY2z6ClL94;
	Tue, 10 Dec 2024 20:33:31 +0000 (UTC)
Message-ID: <d9733af5-b16b-4644-9d6d-84fbacf334e0@acm.org>
Date: Tue, 10 Dec 2024 12:33:31 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] block/mq-deadline: Revert "block/mq-deadline: Fix
 the tag reservation code"
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
 akpm@linux-foundation.org, yang.yang@vivo.com, ming.lei@redhat.com,
 osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241209115522.3741093-1-yukuai1@huaweicloud.com>
 <20241209115522.3741093-2-yukuai1@huaweicloud.com>
 <bef7b96c-a6cc-4b83-99b2-848cecb3d3b1@acm.org>
 <6e384b29-50d2-64bd-0d08-fc0f086c1cbd@huaweicloud.com>
 <7081765f-28d7-f594-1221-6034b9e88899@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7081765f-28d7-f594-1221-6034b9e88899@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/24 10:22 PM, Yu Kuai wrote:
> First of all, are we in the agreement that it's not acceptable to
> sacrifice performance in the default scenario just to make sure
> functional correctness if async_depth is set to 1?

How much does this affect performance? If this affects performance
significantly I agree that this needs to be fixed.

> If so, following are the options that I can think of to fix this:
> 
> 1) make async_depth read-only, if 75% tags will hurt performance in some
> cases, user can increase nr_requests to prevent it.
> 2) refactor elevator sysfs api, remove eq->sysfs_lock and replace it
> with q->sysfs_lock, so deadline_async_depth_store() will be protected
> against changing hctxs, and min_shallow_depth can be updated here.
> 3) other options?

Another option is to remove the ability to configure async_depth. If it
is too much trouble to get the implementation right without causing
regressions for existing workloads, one possibility is to remove support
for restricting the number of asynchronous requests in flight.

Thanks,

Bart.
