Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96621317173;
	Fri, 27 Mar 2026 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774626519; cv=none; b=GKHnK8tcf33EQCsdO5vbL2dYRqPrTLivJfbxIAhKi175aZbruhTTd0yCCisjqRl/EA1fjUA4w5E9oMjmMGs1I/XzpPOoe5+UAMhDL8N1p1ySldl4bLfY7+VwTDXd5b5H9i2kbe6+Cc+z3GYiEFB7wjZw7jI4s9foH1gVCwYx8mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774626519; c=relaxed/simple;
	bh=w7e8xKMVwZwox5IQWdkUnPwsOPywXW3XfBut2voR89o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6wSVBYASV7jrq0ZafkaklZHRfdCyRHhwEvVVn0c4W3rPMQjrQZ5AeMh7f4PDltKDV9sw/P2DtpoxBWW/DoQN/wgJuKJ46SliKB6RGOj10va0ZrYz53xcRvV7ZdaY1rGnYMgGuuRmZ/DsUqaTWjdj0UF+GBFgH7RuqfB62uxc48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=y/CwjrgZ; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="y/CwjrgZ"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fj4n20nQszlgqw5;
	Fri, 27 Mar 2026 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1774626506; x=1777218507; bh=daYKBfZtVRE0Up+JvW4epS91
	zfI0bi2LU/4qn3ihDck=; b=y/CwjrgZaYZ8yuyWAm7DVpesBmImJ3qmESbF7Oph
	7bcSW56maohK9flTVqvLGyUEPvzPHCsVBaSRD5PgFlANNFQ6DetOqlymgFOyuKvS
	G89BGNB0HUcVwyVUe46i6iHpNQlkj5DsVwoGrohq040AglGJ3JeqHX/MMontyRBJ
	65d0Fcz2pHeDO8DjVZeswp9C1voPLPXmsJsVY91BEF/Gd8SJHnUrsy48ZWUH/Tan
	DFRKTzh13diapZrM5bsErlqCXq8j5qrB9X/68kkcaBjRZqmpN7atVfy9TfuTbcRU
	ZW/e6waW9YBYz7gNn3Afjj1xTwahBjjBsBMu0LamPIoevA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XR9mbTQNfkjy; Fri, 27 Mar 2026 15:48:26 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fj4mf33mJzlfwHS;
	Fri, 27 Mar 2026 15:48:18 +0000 (UTC)
Message-ID: <91bacd7d-6ec0-4888-be0d-f11a6607f38f@acm.org>
Date: Fri, 27 Mar 2026 08:48:17 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] block: Introduce a BPF-based I/O scheduler
To: Chengkaitao <pilgrimtao@gmail.com>, axboe@kernel.dk, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, rust-for-linux@vger.kernel.org,
 bpf@vger.kernel.org, llvm@lists.linux.dev,
 Kaitao Cheng <chengkaitao@kylinos.cn>
References: <20260327114741.91500-1-pilgrimtao@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260327114741.91500-1-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/26 4:47 AM, Chengkaitao wrote:
> I have been working on adding a new BPF-based I/O scheduler. It has both
> kernel and user-space parts. In kernel space, using per-ctx,

Does "ctx" perhaps refer to struct blk_mq_hw_ctx? If so, please use the 
abbreviation "hctx" to prevent confusion with struct blk_mq_ctx (block
layer software queue).

For what type of block devices is this new type of I/O scheduler 
intended? This new type of I/O scheduler is not appropriate for hard
disks. To schedule I/O effectively for harddisks, an I/O scheduler must
be aware of all pending I/O requests. This is why the mq-deadline I/O
scheduler maintains a single list of requests across all hardware
queues.

Additionally, this new I/O scheduler is not appropriate for the fastest
block devices. For very fast block devices, any I/O scheduler incurs a
measurable overhead.

> I implemented
> a simple elevator that exposes a set of BPF hooks. The goal is to move the
> policy side of I/O scheduling out of the kernel and into user space,

What does "into user space" mean in this context? As you know BPF code
runs in kernel context.

Thanks,

Bart.
