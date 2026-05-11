Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91EE42EEDF
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517423; cv=none; b=lB+2hJudNbsVu+ihEIc/upyCX0H+jpDenLMEW/I4TFX+0bbynKXj9CXMP2xS5uPbr11RCYQUD32W7Mm39dp1A5YEk8jpwuifr1BIV/2aV2w+X2lMBemt3XpEuueX9Xjb/SGnyUiwwv7vykbOMpBieorLTPghbiomjJ7c0+/Bu7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517423; c=relaxed/simple;
	bh=utsuSfkyuRYpF66BLZ2YMRqasFcji4lbJ5PW+67opUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKJoRkC/IPDgwY3zstzd/YnwqmJVi+OavZhCFkXFD5SEzwgFZ+STWO1UCCXgspHGN1z31I87t30gllWdxWRdMRNMUH8b/pkwDG/kb/m1JjODnH942ukpFj0TSRrqfpfsYD2DjYjEJstg7mzGcSQ/qmGWLQyCo3ikHZ+7q1BZr40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=tU4Hi7l1; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="tU4Hi7l1"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gDlk51fJgzlfpM6;
	Mon, 11 May 2026 16:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778517418; x=1781109419; bh=utsuSfkyuRYpF66BLZ2YMRqa
	sFcji4lbJ5PW+67opUE=; b=tU4Hi7l1lHE/g5VHXtwM+PUkCHV0NI4E2X6Yb7ww
	V+FV1AU6cBQFBgbp+LZdDv/TjwxhNO8dDyC6yLLdsRZMx1amT7yejDlvCBwEAr/t
	1dsbIsFw1I3MIa/waARvfHXNhvw/7gX7YQhyXr1FtKyT/tf5/pJktA8xgSnkE525
	2isxZkNw9Wc7AXtJns9Lo8EM0anJzcQ32avNJDmPA7tZ5twICtgWV8ZpQukECvSA
	SKIfBDYn05f9Y4ZTyXqwgb1K+GLi1TcvNX84I6quoRBTPafYyni5jglFxmq9NjHM
	BHiy4R6RNE7bdBMOZgFYwq8dhRVWOXXdgXCh+mAYEEf2qQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id g20YIjhQ1Owo; Mon, 11 May 2026 16:36:58 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gDlk02ftSzlfl6R;
	Mon, 11 May 2026 16:36:56 +0000 (UTC)
Message-ID: <0b5bcac4-f58d-4cb0-9d58-fef74238edb8@acm.org>
Date: Mon, 11 May 2026 09:36:55 -0700
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
 Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20260402183950.3626956-1-bvanassche@acm.org>
 <20260402183950.3626956-3-bvanassche@acm.org> <20260409064221.GA8378@lst.de>
 <CANpmjNMUv5n2VrWGPBOzGg7-r6gf3hH6ZoJYtRsrntY8+_=fQg@mail.gmail.com>
 <2e09806a-d5fe-4581-8024-906be7dca4de@acm.org>
 <CANpmjNPJPz7qruFw8S=4qoF32snPW-RYrd_BZK6skR_y86CUZg@mail.gmail.com>
 <08078df0-d3e6-4860-b22b-937035d45857@acm.org>
 <CANpmjNONpHgSzavkbqdbM2N0oCtt2_2+UqBCMWjMaWEcWrCy4w@mail.gmail.com>
 <2a2c46fb-c934-4ecc-b3cb-4e4114a6d6bf@acm.org>
 <CANpmjNPzuCUKRPFXZ8ckiCE01kc85xzOiMB05Y9OC9J4Lwi61w@mail.gmail.com>
 <CANpmjNM6nERjfhNBE=D93E+HMaQtJWyi9s2qHmLWrmtBFt05vg@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CANpmjNM6nERjfhNBE=D93E+HMaQtJWyi9s2qHmLWrmtBFt05vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/10/26 11:00 PM, Marco Elver wrote:
> Clang 23 will have function pointer support:
> https://github.com/llvm/llvm-project/commit/d1e84bb9ad3b6a844cd902cf70e2764cb8126979

Thanks Marco for having implemented function pointer support in Clang!

As you may already have noticed a new version of this patch series has
been posted that relies on this feature. Combining -Wthread-safety with
annotating function pointers with older versions of Clang results in a
build error. Should a test be added to the kernel build such that
config WARN_CONTEXT_ANALYSIS can only be enabled if Clang supports
annotating function pointers?

Thanks,

Bart.
