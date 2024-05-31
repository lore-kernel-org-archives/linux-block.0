Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9083679B96
	for <linux-block@vger.kernel.org>; Fri, 31 May 2024 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717192559; cv=none; b=mPjIMPSAjXXguczsJx5bylMo2nvff3j7cVSFf6G5CeVKl+SzBjnzIJKhYue/JMjgAFkY3470m4bZ4NQu4c6bIQuw5rJM4ICif0FH+M83Fb8y/m42/m5wVgsZl3wfWxuerYOwcj5NU6sYuNyRlqqxGONbT+uuTBmi6Xvyw3Wist8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717192559; c=relaxed/simple;
	bh=p+pXBGb/BdrvXlZrJEZq1wlI2GExIsMQtnEQnH/4/XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dF7fXBcwDXS8qE1faffH/oBcgrhONUnk6dLKLhr0oi1I96FxqyM72Kh8Uoq4angQJ5E0/hxeHkqHYMW8XUdfQ4e48/RdDkdxFuri+VRUg0fUawJWr182S345vVjDkzK3BJhCH1AWMu1+G/tdC/K8xjIej+nPPL7pGMghotnH7yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AjK6xRlA; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AjK6xRlA"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VrcPf6PHSz6CmR43;
	Fri, 31 May 2024 21:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717192547; x=1719784548; bh=JUeHJboQmQSUUWVtn+I1HH1x
	DqhZYiSvsKN5as2xfBY=; b=AjK6xRlAirlcL3Fy5FkLcsoh5K7c9QDbTv9NK6Uu
	Wbc8ks57ckQuBxWK0yVJQkFsPL/LvFCGEH/irdYHIeEfrO65xJ1ZNvhxyDeOInYZ
	GgVN5UUB0N4rNbvjrhAhRFAxWJMJfL1zD39OV5uKBZ4MbriK7IYs2o3CSG7zUhgk
	0GY90NjjjDv8V3xuyLVyYZphAbJLPmZrRqULKVlVwRF4molzB9EJ+mDO0mrZPNxC
	jcN23y6WilEZWbhx0Y1qSRQLDuYE6XCgWWb5OTwAOgGB4hZlZBywrjAHhGzCClcf
	pTzytqVBcSUZ2QvIKFVcpRU8ZdXFb47NcS9YVIGKlwb5bg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id UlzPivgeTgBX; Fri, 31 May 2024 21:55:47 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VrcPZ4rDGz6CmSMs;
	Fri, 31 May 2024 21:55:46 +0000 (UTC)
Message-ID: <cbdf0ee0-9252-447f-bb7a-d91bdb4759ab@acm.org>
Date: Fri, 31 May 2024 14:55:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] block: Improve IOPS by removing the fairness code
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
 Yu Kuai <yukuai3@huawei.com>
References: <20240529213921.3166462-1-bvanassche@acm.org>
 <Zljl3kAfL0WfFkoZ@kbusch-mbp.dhcp.thefacebook.com>
 <a5c1716f-b21b-42d2-8ce3-13627566c754@acm.org>
 <Zljs7Arkq9nBrHLQ@kbusch-mbp.dhcp.thefacebook.com>
 <7a69eba2-42e4-4c67-8a54-37b5b41675f9@kernel.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7a69eba2-42e4-4c67-8a54-37b5b41675f9@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/24 16:38, Jens Axboe wrote:
> On 5/30/24 3:17 PM, Keith Busch wrote:
>> On Thu, May 30, 2024 at 02:02:20PM -0700, Bart Van Assche wrote:
>>> Thank you for having run this test. I propose that users who want better
>>> fairness than what my patch supports use an appropriate mechanism for
>>> improving fairness (e.g. blk-iocost or blk-iolat). This leaves the choice
>>> between maximum performance and maximum fairness to the user. Does this
>>> sound good to you?
>>
>> I really don't know, I generally test with low latency devices and
>> disable those blk services because their overhead is too high. I'm
>> probably not the target demographic for those mechanisms. :)
> 
> Yeah same. But outside of that, needing to configure something else is
> also a bit of a cop out. From the initial posting, it's quoting 2.9%
> gain. For lots of cases, adding blk-iocost or blk-iolat would be MORE
> than a 2.9% hit.
> 
> That said, I'd love to kill the code, but I still don't think we have
> good numbers on it. Are yours fully stable? What does the qd=1 test do
> _without_ having anyone compete with it? Is the bandwidth nicely
> balanced if each does qd=32? I'm again kindly asking for some testing
> :-)
> 
>> I just wanted to push the edge cases to see where things diverge.
>> Perhaps Jens can weigh in on the impact and suggested remedies?
> 
> Don't think we have enough data yet to make the call...

Hi Jens,

I'm interested in this patch because it solves a UFS performance issue. Because
this patch significantly improves performance for UFS devices, we are carrying
some form of this patch since more than two years in the Android kernel tree.

Thanks,

Bart.


