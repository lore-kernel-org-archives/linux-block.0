Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69701805E
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656868; cv=none; b=CCSe4goVGvmYL1e6e7EQwOW3ehlJaSEyTQu1HJ3io8CNGRBLSzjNnOWzgdnSwHmShA+sShXc+wCtn2LbX5b66HV+QeQHBYuhv7NGDGtbbzqApTTKcp9MyndQXFLSEpvTzJkqwFCMb2B0jawhl2xpJVDYJF97LkIUdNkK5WFL6iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656868; c=relaxed/simple;
	bh=w/ADc8oAQwBYIryqwa0id4qR442DNVi1nWp8T7TdTYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgQO2QY4WsMXLE81w/U/J/CmQzrdpg+QbPDkDc5XhpjAm5bsX5OrCZZYa9Hruk3hnVXh2YXGqnhLIoVfkCqHyOjWn005p55dqm0+2V+5HmyudyrAXrpKYjCYcV5hAJm4U1QvfpszGAimbXoLwjaeHi5zdwS6eZVtdRQ7UNjPp90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ao7+m1Uo; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ao7+m1Uo"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4dC3y66wk4zlvBxV;
	Thu, 20 Nov 2025 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1763656861; x=1766248862; bh=w/ADc8oAQwBYIryqwa0id4qR
	442DNVi1nWp8T7TdTYA=; b=ao7+m1UoNR2rdrGFdQxPxlgFO0J4I0BwnPfKdCib
	aXBg15M9pP0GP2dZ6KKhfK22xOaMnPddooXkMWOtHuj3rpTZ5yf3OLoe+Z1vQ2oX
	7mxp7DqVvksVyREvVzDzKqsR5XdYjKZT1SxCoX/e4I3a7rcJC+J+yDXsPMiGXbRS
	f8YlLxHAuFWWm8qoUD3JE1YQO7uH+6oNj9NArMVq+J7Q0M2OQ7/mTumbPpPYOFYP
	/4xKaDvbgxuit1OlzPDsAJFVPDOIckqlompk85iLvqpJHGb0hWtpoq3e+wRiHJZm
	NHOIc2j0y0cSfIyQSxQzAzncy4YzMRgPOQ7j7nIyD+iCpw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id lWxKQCz-bnMX; Thu, 20 Nov 2025 16:41:01 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4dC3y03whFzlvBx9;
	Thu, 20 Nov 2025 16:40:55 +0000 (UTC)
Message-ID: <3abda215-67f5-44d8-a2a1-5562c42c0f71@acm.org>
Date: Thu, 20 Nov 2025 08:40:54 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] blk-mq: use array manage hctx map instead of xarray
To: Fengnan Chang <fengnanchang@gmail.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org, ming.lei@redhat.com, hare@suse.de, hch@lst.de,
 yukuai3@huawei.com
Cc: Fengnan Chang <changfengnan@bytedance.com>
References: <20251120031626.92425-1-fengnanchang@gmail.com>
 <20251120031626.92425-2-fengnanchang@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251120031626.92425-2-fengnanchang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/25 7:16 PM, Fengnan Chang wrote:
> use-after-free on q->queue_hw_ctx can be fixed by use rcu to avoid in
> next patch, same as Yu Kuai did in [1],

Does this mean that this patch triggers a use-after-free? If so, please
include the fix for the use-after-free in this patch.

Thanks,

Bart.
