Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9285E3DE450;
	Thu, 24 Sep 2026 18:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272907; cv=none; b=g8gQQShATuVfltPs/HKdKzz9mmVIiZh0fu1SziOgVcGVi5jux+sK3HyH1xqMyaeLK47AxLwdLe68OUvaRRC1TkiBGBYvmwFVW58Luy5MOWWjKQ6kZ+ZCjWL3c1HHV1st2fNiBxw7xolUirGlR5Hz1+jQiuZyiN6M/RzNa30vBf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272907; c=relaxed/simple;
	bh=9Bz+zmSclqz2/PiF27JHPe5qGo74vrDFI1ZxbBe6Hos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPIT1zlPMpU6nMSuByF/WyPfYy1BfKn0HNYw2hKCN6fIbtMuLbc0Pqia/qgzeS3x70sEp8krs/LSu9H5csP7YRZxiuPTHrVAPhSRXMnbxkwJPLsU566z2w6+hWX36avsClpIZ7XGgvzXZ4g3xXNTLs5tMupL2/W0+tsu5AKmDAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Fe0nJ1Zp; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Fe0nJ1Zp"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hrM8y6mR0z1XM5kW;
	Thu, 24 Sep 2026 18:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1790272893; x=1792864894; bh=S+LCdIAUEZXHTSYTefczNZKI
	mY/l3usWmlLwQxNDeqw=; b=Fe0nJ1ZpjxfLOfaNl1zLK8FnNJqYLLPHWBu+jhto
	aiBiQfmuydx8e6/P1PpSoS6nXKsavJx+V1Xp2czBtHjAVQkNSV/Cz7+78wm2Sdna
	5JMLT+8TH7yri0LORg8dG+8KjPo38UqoW7B4vkNepvHYOjE0iRjgpUVlGXfCYkLx
	toI1nLDxfbnt6MARO/awiq7YfkRGlIV+b4u7pB9t8iN0sHzudXdhHmRBrwOjcg/9
	kL2THEblL2gz9t2AuAdzoLTu0WlxVk7TnLEtvSTeDXrblEbwyybM04PV8lFSpQP0
	rYq9fwdmsFuZdTvfKIQQabfS/7S6N8p4OzxAx0co1EEQ3w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id C7_IbOr_IvQb; Thu, 24 Sep 2026 18:01:33 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:dc45:df52:b6ee:9465] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hrM8p6yLHz1XM4Sx;
	Thu, 24 Sep 2026 18:01:30 +0000 (UTC)
Message-ID: <b6e08595-50f5-494b-ae5e-726513d8dae2@acm.org>
Date: Thu, 24 Sep 2026 11:01:29 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: defer the queue limits clear to a workqueue
To: Tao Cui <cui.tao@linux.dev>, axboe@kernel.dk, hch@lst.de,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: cuitao@kylinos.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260924102027.2307044-1-cui.tao@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260924102027.2307044-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 3:20 AM, Tao Cui wrote:
> +	memflags = blk_mq_freeze_queue(lo->lo_queue);
> +	mutex_lock(&lo->clear_limits_lock);
> +	if (lo->clear_limits_gen == lo->rebind_gen) {
> +		mode = lo->clear_limits_mode;
> +		lo->clear_limits_mode = 0;
> +
> +		if (mode & FALLOC_FL_ZERO_RANGE)
> +			lim.max_write_zeroes_sectors = 0;
> +
> +		if (mode & FALLOC_FL_PUNCH_HOLE) {
> +			lim.max_hw_discard_sectors = 0;
> +			lim.discard_granularity = 0;
> +		}
> +	}

I propose to remove the member variables clear_limits_gen and
rebind_gen. These member variables complicate verifying correctness
of the code and IMHO are not necessary. If loop_clear_limits() races
with loop_clear_limits_workfn(), the work will be rescheduled and
loop_clear_limits_workfn() will be called another time.

>   	queue_limits_commit_update(lo->lo_queue, &lim);
> +	mutex_unlock(&lo->clear_limits_lock);

Since the mutex_lock(&lo->clear_limits_lock) call occurs after
queue_limits_start_update(), please move the
mutex_unlock(&lo->clear_limits_lock) call above the
queue_limits_commit_update() call. This has no impact on
correctness nor on the lock nesting order but makes the code
easier to follow.

Thanks,

Bart.
