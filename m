Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF43537FF7A
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 23:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775864671; cv=none; b=PJWeY4ArCZMd90fbWPyPvBNbh+fJQDmJvYmF8PR0Umh/zCcPF7osHTM+qyaXdidmp0tiO3havhbAKXmIQJuS1m0CeX0xh9H2ufwfiT472VzuzXxXc/+8CyqmN9s2Co49xrhs2YlljgGIfvPVixWOkYJSHI+0qj6cTiaxkn+YpoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775864671; c=relaxed/simple;
	bh=Y25iNKctzdEyBysVjNrtQD7LFIxAKzptePh4aCQ5PNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kcqt8c6k4UGRonJ3W7i2v3AF1Y6zsZHkx4btCKpSoqkGxuQnXZK6iXnnmRo8R4uUNrsDlkzCv5sqMNTi46BAPeCrNrktA4Fl+bymuD701/7kpSy82p+zZOQdd732/+3/eS8tqqbGRDQgm7tBzWmBtct+usReCoySc13OputigEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2kcwnA35; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2kcwnA35"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fstgd0JQ1zm9P8R;
	Fri, 10 Apr 2026 23:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1775864666; x=1778456667; bh=Y25iNKctzdEyBysVjNrtQD7L
	FIxAKzptePh4aCQ5PNk=; b=2kcwnA35FtYdoYQBgBKpSOz3c4xOJiQV12d1+ri8
	YLN30AlpCmklLUyDhn8CcOKcAzKOCA7dOm8f1qr8ofF05kDaXoMqaxqxYGYKFBmY
	He29MwFK/ZDlHorz8Pdu5iWxWVh7xwOm69EHHTf9GPjE/FLbk8m/UMTLEJb94xW2
	gBYVFO7AUS1kSiiRkmBptUsF/5O0BRy6Pm7ImdhdZLwJG0VPY7D8naNVSX4hDWie
	DEjMoRjXtH89yZYnOI5ZGeVodvD3EDBMi7yRgAHzVP6wtzLcWag78p09X/9wa+U6
	wj/whYg5zU5wZZHoQ6ygyywLMBgNICBgHuNPGLj4MQLkEg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cIJdVna1SOZr; Fri, 10 Apr 2026 23:44:26 +0000 (UTC)
Received: from [172.20.20.20] (unknown [98.51.2.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fstgY03QBzm9P81;
	Fri, 10 Apr 2026 23:44:24 +0000 (UTC)
Message-ID: <08078df0-d3e6-4860-b22b-937035d45857@acm.org>
Date: Fri, 10 Apr 2026 16:44:23 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] block/bdev: Annotate the blk_holder_ops callback
 invocations
To: Marco Elver <elver@google.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>
References: <20260402183950.3626956-1-bvanassche@acm.org>
 <20260402183950.3626956-3-bvanassche@acm.org> <20260409064221.GA8378@lst.de>
 <CANpmjNMUv5n2VrWGPBOzGg7-r6gf3hH6ZoJYtRsrntY8+_=fQg@mail.gmail.com>
 <2e09806a-d5fe-4581-8024-906be7dca4de@acm.org>
 <CANpmjNPJPz7qruFw8S=4qoF32snPW-RYrd_BZK6skR_y86CUZg@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CANpmjNPJPz7qruFw8S=4qoF32snPW-RYrd_BZK6skR_y86CUZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/26 3:43 PM, Marco Elver wrote:
> Can you retry? Thanks!

Thanks, this works much better! However, I think there is still an issue
with this new version: no compiler warning is emitted if one function
pointer is assigned to another function pointer and the lock context
annotations of the two pointers differ.

Bart.
