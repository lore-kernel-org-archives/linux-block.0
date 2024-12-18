Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AD31FA173;
	Wed, 18 Dec 2024 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734545224; cv=none; b=LoP3DHzfzGFx7yyQxY2n3TsMQUDr/N9rQVjYNHuEdT2Iviva3Nc3BgYk/s+mAG9edIMpyU4L/0kXcn+7RdrTUBZaELz8wBWUeK9r/iUFRtq6NlXxZVzfYjEd5bvoCNAj0UtkH1y1sZLiBUanYbv/GK77pQbmuOk4yf6gfPgZHtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734545224; c=relaxed/simple;
	bh=tr6UyiYeBOeDxGKe9LogPeEdP0gP+8kOknDF1WkJdy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFvtveBibSb/G49xTrc2GbIdXqBDnzMvX8dwr3L+QfCYPUq1efAueQ7aNJ/MiQmOJNgDp2Ahx9antU1knDhnXOJOcPcVGQ4az2fcQ3zwMEHOg2WTQkwJ4Z9LnrO+J2/2ksj1SFIcw1aTGoZ6dgelE/z0i9n+7jE1HU5c+zciymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Mfs0r3yM; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Mfs0r3yM"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YD1pt0jRrzlfflk;
	Wed, 18 Dec 2024 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734545217; x=1737137218; bh=tr6UyiYeBOeDxGKe9LogPeEd
	P0gP+8kOknDF1WkJdy4=; b=Mfs0r3yM2d7ZznoWwA8ZW4sWnxFV6kx74b2MDZ39
	duAEZmA24gMt6WcbCs2XQd5IoGojoTdIgHmlATpDYkrk79IuTjqqhvoCkPjoe6AM
	3t7fuPq63nS40IXlXgNCrdxhUAvrAHis/nvdl+6gauTR1980LR0fKdmpw0yNzE+P
	VHTpgYEoq8VtMRFK/J62tbyYYotfC4/ePvRIIF+DyFkKoDbozHhY3okLBOTNG4ir
	o4hkWHlZ2aZRO9DvuRSqxWscf4VuYuaskND7wfP+huUpVQxsmFHxsD/7wyBbG2TS
	Y/drrpec5IL8SRpEtHLuINhE04RaEQurPq0D4e/YLDVxqQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hCVkDRqFl94X; Wed, 18 Dec 2024 18:06:57 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YD1pk5r92zlfflB;
	Wed, 18 Dec 2024 18:06:54 +0000 (UTC)
Message-ID: <95d352cd-b52f-4cc8-9014-302763f401aa@acm.org>
Date: Wed, 18 Dec 2024 10:06:53 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 4/4] block/mq-deadline: introduce min_async_depth
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
 akpm@linux-foundation.org, ming.lei@redhat.com, yang.yang@vivo.com,
 osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241217024047.1091893-1-yukuai1@huaweicloud.com>
 <20241217024047.1091893-5-yukuai1@huaweicloud.com>
 <da924dc3-a2e5-4bfe-afb6-5fbc55bc25a3@acm.org>
 <8fa8c620-22ff-0963-d1ee-c6fe6f13b49c@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <8fa8c620-22ff-0963-d1ee-c6fe6f13b49c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 5:12 PM, Yu Kuai wrote:
> dd->async_depth is initialized to 0 now, functionally I think
> it's the same as q->nr_requests. And I do explain this in commit
> message, maybe it's not clear?

It would be good to add a comment in the source code that explains that
__blk_mq_get_tag() does not restrict tag allocation if dd->async_depth
is zero because that causes data->shallow_depth to be zero.

Thanks,

Bart.
