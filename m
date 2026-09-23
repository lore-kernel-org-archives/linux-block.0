Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBD3563297;
	Wed, 23 Sep 2026 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183698; cv=none; b=ukNgJe8jIWdF6iWa1aCMqbOMBHGtAAk4ijtT99UVZAKN241dlYLtk9N1ZVAPaYZHm3m3aIMl1u5fpKt0Y0bgF2XUEv9nSUaEzVIFkchq8CgPbxUJQcn4bZkFP74tnrKa4uvUxHmPQbyXjRC2DkXSt4P/hthrJHX+yPq3IT++iPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183698; c=relaxed/simple;
	bh=cnvV5g1t5WP4Kco1Qsd1kwvD910KxUaz342uhKlnXSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVCv6XUN5vcxwySGndLH5AVpiLQteVrwEqhRM5nF8H5llEcvO1gbdyy0iB4dG63p/H/zRXF5OG3osaUCx97VRWo2/eEtMU6lOy3JzZOq0ld7nU+f9ONIsZitA5EzcbllJssBd5J+DzWsmVY1RwOFgx1Foz90IA2iA013BC1VYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=MyhaD8It; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="MyhaD8It"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hqk9V0p5Sz1XM5kW;
	Wed, 23 Sep 2026 17:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1790183686; x=1792775687; bh=3qc10G2922bb0dMkJC+jOzuq
	NnwQUytYMJrgHXQPaSo=; b=MyhaD8ItxJdFKD+bVsmlY16Ckg5yuL87i/auKX5i
	dxsgSErtsyFaz8V8yH8Y+l6DWBCtX74RtphZOK9cVCiDcXCEG0MHFySMIUp1jqT4
	ZF3UYvEqsmPvHCQLL1Vb7rYvxIOVl4M8D52GWc16eclXm0WDyoKePLdj6zhKvzj5
	shz2ude+W4ZrIIP61FX7hpirmdFbkZJCD/jJ50RAWPwZPYDyqYUAVyCmboJL1E4c
	LN2oJ5OkGZAId+M3dnbiebGpQfpcZRW7A8qyKrk36JMHfoi4dopDQ8bcxnozl//0
	exkO0ZfGjTTmoQvhXOl3M0bjdVJwJpaL+1Cfnl3eCG5f5Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id x4e-pVLKkSLa; Wed, 23 Sep 2026 17:14:46 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hqk9F5Yglz1XM4Sx;
	Wed, 23 Sep 2026 17:14:41 +0000 (UTC)
Message-ID: <7805a9a4-a4ed-49d6-a645-00de0823fc76@acm.org>
Date: Wed, 23 Sep 2026 10:14:40 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] block: Add post_release() operation
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Jan Kara <jack@suse.cz>, linux-block <linux-block@vger.kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Brian Foster
 <bfoster@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Hillf Danton <hdanton@sina.com>, Markus Elfring <Markus.Elfring@web.de>,
 Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
 rust-for-linux@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nilay Shroff <nilay@linux.ibm.com>
References: <69960302-1535-441a-be4e-d652766d65c2@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <69960302-1535-441a-be4e-d652766d65c2@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/26 10:09 PM, Tetsuo Handa wrote:
> Changes in v5:
>    Since Bart Van Assche commented that post_release() is more clear
>    and more descriptive than run_todo(), renamed run_todo() back to
>    post_release(), and make it be called only if release() was called.

Thanks!

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
