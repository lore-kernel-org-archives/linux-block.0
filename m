Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8083264CE;
	Fri, 17 Apr 2026 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776450552; cv=none; b=Tmmf9tnpjBEweNbqHz9xL8OJGedbdO1cmeIoxY3IsvXSlZDSmjnG9xXM5pkujN4Djq+JyHJ7KeSTx5d2zkasy+v27/9EGtNEk9Q/8fMBfs8japETy8s99KLYrkGKLdBr+FB5tMUTLuMyLycJWJz5Eq+Q4v94GWfVPYs5QaAePfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776450552; c=relaxed/simple;
	bh=ZiShd4aBfoDRDOHRq+1j2Xtq82FQmujuu2msu2SAob8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHEPS+r3QrFtaPY/qgRe74Ygzd5tcpYX9zJzS9DtfDkp3k/NWcA5/rDGFO5y0Vp/V39NNLMxp/bI/GKZuWzcM5ykhjt+I7U0eUCNNXpyVtcg11dUiQDd8taRHe7u5WJcQTyqzJhFtXjj1aOh9YNdfjDuCaVY77BkDHZ1CDN9+PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ugUuwHq7; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ugUuwHq7"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fy3LY5K2qz1XM6JB;
	Fri, 17 Apr 2026 18:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1776450542; x=1779042543; bh=WAGgI1B5Tgph8S24CaWZ0IEl
	D41wYFriM+vj6MrK/40=; b=ugUuwHq7g8JO4KqwA67wAg16uLNiscftenvMk6eP
	A3tYBDOc4BvctQFxqQ/NBBqgVuXipzgHPLAZ/p+TgX0fv5UXzhBE+mks/i6gNYqF
	XDYKNMtqXkVhb/MXQ9XIg8Bwt5ItZOnGwU6OVZZmraMQUKebQkzXwRH9jdSH47tS
	/428rneq1BwwF/zboiTfg54Dp3d24h8VR67+8He1zHZjBm6k/4mbBHmDMp2vpwWP
	L7wpCGph5IQDQfjSdC7HdEAEhS+vNc9DcznzdAwXKJn7YRccQC6fvS7IRWP5kIgA
	ApnfnzsxY9z4TVdMWvkC4vojxoDCHkQRxDnqJkxivQEHLw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id HwSW5CBXrllK; Fri, 17 Apr 2026 18:29:02 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fy3LH2hFSz1XM31H;
	Fri, 17 Apr 2026 18:28:55 +0000 (UTC)
Message-ID: <ac8d9fd1-15c6-44cf-ba5a-85bd4aefce9b@acm.org>
Date: Fri, 17 Apr 2026 11:28:53 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] blk-mq: expose tag starvation counts via debugfs
To: Aaron Tomlin <atomlin@atomlin.com>, axboe@kernel.dk, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: johannes.thumshirn@wdc.com, kch@nvidia.com, dlemoal@kernel.org,
 ritesh.list@gmail.com, loberman@redhat.com, neelx@suse.com, sean@ashe.io,
 mproche@gmail.com, chjohnst@gmail.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260319221956.332770-1-atomlin@atomlin.com>
 <20260319221956.332770-3-atomlin@atomlin.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260319221956.332770-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/26 3:19 PM, Aaron Tomlin wrote:
> To guarantee zero performance overhead for production kernels compiled
> without debugfs, the underlying atomic_t variables and their associated
> increment routines are strictly guarded behind CONFIG_BLK_DEBUG_FS.
> When this configuration is disabled, the tracking logic compiles down
> to a safe no-op.

I don't think that's sufficient. Please use per-cpu counters to minimize 
the overhead for kernels in which debugfs is enabled.

Thanks,

Bart.
