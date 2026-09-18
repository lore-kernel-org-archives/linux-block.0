Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818032CCC5;
	Fri, 18 Sep 2026 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789770813; cv=none; b=Ele5LdV15R8dkWdf16IL/b62X0qZwWMQDNASvQs9STtbQw6nl24JNsYYaD8CG/RTbu/324tCbzJUOh2EtFXCy5StwwfK7CUvSHJ/Wr7BmZbF3e+N9Wr/cYSJLtfOZKJdgmA0SXDFbbznvMoIz+Iaq0AXvEE2j2HohxJAF/1oyu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789770813; c=relaxed/simple;
	bh=61rFDggWBOBDa7Hhv/wzVT4iuxTSGAiajC/uosajJXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LP+TflurbuQhvvWBP1FITiQiKc1ku9exOwqxw/0/SlKoXva9FyvNsPJaN7+C3CdMX4XlUpP5vK8IstzHffCE3mVwioMtZ5+gIHf65aM99PLlSj1a9mlAMpi3y5y9J3U7KkJIuznW13jkQYhjDlXNSa4apsKQhjewCDbCi41jNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=VtahzfMk; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="VtahzfMk"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hmnTS0p3qz1XM5kD;
	Fri, 18 Sep 2026 22:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1789770808; x=1792362809; bh=W0tUnx4tff9XMUq3o/PucHtA
	yescclBuGil82LwNn54=; b=VtahzfMkXdTIlPqTJwgxr9KtTFi3wfD7/wmIBaX6
	NLiDu/tK6zdO8DF36DuX/O1vCum/nigXeJ8lixf3bHdDVzhNUUjmgYFweqM6eib0
	CN/j/tX7FHct15FDA90kBTarsOYGFAr8SgwG6Ke1RQAT0kJ/RYi4iqaiEZUa1obv
	BgdhzXE0I/TSt5dTVBJuao6YBddE+lLmISImEKjzANr+FRD6Ek9aeYNuCshEWti4
	aDficijVxkdvLytS9TO4B/XcmVYBDtYVAuMJ08n8gKEJ5m9UVXHrllimP8B8Bomt
	eQPFc9tjLmwk9vivUcn8TmRXP62t4GN86eQHNpSXeWoZsQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id K7UeJHHspIzR; Fri, 18 Sep 2026 22:33:28 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hmnTL6FhLz1XM30w;
	Fri, 18 Sep 2026 22:33:26 +0000 (UTC)
Message-ID: <68a0902e-00c2-4d7d-9714-531226bab73c@acm.org>
Date: Fri, 18 Sep 2026 15:33:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] loop: defer the queue limits clear to a workqueue
To: Tao Cui <cui.tao@linux.dev>, axboe@kernel.dk, hch@lst.de,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
References: <20260903013800.1036691-1-cui.tao@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260903013800.1036691-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/26 6:38 PM, Tao Cui wrote:
> +	struct work_struct      clear_limits_work;
> +	atomic_t		clear_limits_mode;
> +	atomic_t		rebind_gen;
> +	atomic_t		clear_limits_gen;

Three new atomic variables? That's too much because it makes it much
harder than necessary to verify the code changes. Please change the
atomic variables to non-atomic and use a new mutex to serialize accesses
to the new variables.

Thanks,

Bart.
