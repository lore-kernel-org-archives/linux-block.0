Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2440323D2AB;
	Thu,  9 Oct 2025 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029542; cv=none; b=sMAV4B/e9LdUz3HxL8/QLaWR2cpB/rlZquVbDp2+GPIlYaM5Wy4QNqErSwGpDpWl572n1hosQdwo+tIhUI9pO/CjD0tpaLntpIcqsbauRnAg9ofeFCb9UdK/gULgNHEVwovS0U+hKTLxg/1zRXjjm/AjZ54gZKRtHYkHIXEFmj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029542; c=relaxed/simple;
	bh=0ZE/jGvm6aL4wVZv112il9NPd7AW4QAQ9v7SEMKi9Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/93pemR7g4XAjv+yyDSBzUDa2lYIlCdFxmQ7C3Y9Dp9WaRjR2SPlPJ/UNX24CWwrIRNk8416kjbt9H6HLS8xpJlMa5wsrs/SovRCQ8bPvNkrsM18DYNc2WMFzXxQXByrjlo0HH8J+9/WBE9FxJHppG1i00URdlo/tM9u5tIi3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=K5lAT7o+; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="K5lAT7o+"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cjGTw1C60zm0ytn;
	Thu,  9 Oct 2025 17:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1760029538; x=1762621539; bh=ASbHD4hHgKK4/wqMUDMSHNZq
	gmJoYXs6WYurcxNLSO8=; b=K5lAT7o+zrUYz2s5JXVTFJd2+KRR6up+NnKogSK7
	cxwXJPWI9TiOpWyfXjFUHSgPBSMDN5h3Hd6+t6hlCcz0zPYrP9/O5v95MyGDj4Ob
	S4Ktt4dfXSmh/k8HvxRiB3TVWxazsrHQ1bcDXimCXrQdN0ynq5udfY/inlp3YOT2
	+T3GPF4SYe7bXCz41O17nB7ze6+QDPzKUSR2BHTZc/ypSnc7PDT6TFjWDRZ0hTb9
	uqT2CDYYawAI4C/wHcf0XSLFzl6Y9Ja6gk8R3L5LB8PkZV+qDNSi80etkMbFsyND
	/RREh8UPSZrO/i5iLmu7/yLKzzbtZkaW6yWdj+JGTFMGhA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7Q1p1ARXfwZu; Thu,  9 Oct 2025 17:05:38 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cjGTj2hK6zm0ytk;
	Thu,  9 Oct 2025 17:05:28 +0000 (UTC)
Message-ID: <49647ccf-5d19-4ede-87b4-0f7ff8e9f5ea@acm.org>
Date: Thu, 9 Oct 2025 10:05:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v2 3/7] blk-mq: add a new queue sysfs attribute
 async_depth
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, ming.lei@redhat.com,
 nilay@linux.ibm.com, jmoyer@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20251009074634.527661-1-yukuai1@huaweicloud.com>
 <20251009074634.527661-4-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251009074634.527661-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/25 12:46 AM, Yu Kuai wrote:
> +static ssize_t queue_async_depth_show(struct gendisk *disk, char *page)
> +{
> +	ssize_t ret;
> +
> +	mutex_lock(&disk->queue->elevator_lock);
> +	ret = queue_var_show(disk->queue->async_depth, page);
> +	mutex_unlock(&disk->queue->elevator_lock);
> +	return ret;
> +}

Functions like the above can be simplified by using guard(mutex)(...) or
scoped_guard(mutex, ...).

Thanks,

Bart.
