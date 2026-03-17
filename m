Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AC930F818
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764692; cv=none; b=qsfkLDrNfYLSr1TrFqRdncCFsA2tz5JCWeiNMPYn0p8POHARGldRpsRkNfo7ee7Ba4Q9F8xtdnJVsJ2DY3SF0Iodhkx028bWK2vT1FpqvpExd+2eti/bzj3FAGn1tmlelVrGLCO1AjjgVFw1c/czCLwI5FcQ43w5f3mRGWq/DrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764692; c=relaxed/simple;
	bh=ySmnvFDWd0W/Lmyp7uJnwxiT+WQTYbR3ZPjLmnrbkFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUHc1iRSiEsWsIgNEKn+f7H//+8y9unL9oVbF0/RXO5qi8wo5MYZhr1McxKxz5Pz0WwguSkI4R2LaI9a5jZjzjMkExMbXSJYD03C/AnvOnKNfcTMDOf4gX2m8k7kKL1PD2lO9HUEzUv4orvop/NT+1FU3j1uB0/BDlHm3ZCT/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AIyh1pU6; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AIyh1pU6"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fZy3R01n2z1XMFjk;
	Tue, 17 Mar 2026 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1773764686; x=1776356687; bh=wOk0p6hKnJ3Ndk8Rt0B3Tdaj
	7u8a+Lk1nWRjan/mTn8=; b=AIyh1pU68yczGvN1SrPy4yzsAlLTlob5lYnpLPm4
	gZ0DbtrktUPmC0CYhob6/L54jQfMEUlZyhknzg2p/0I5kXgmwLoa62ePxN1P1Awb
	n45MbujCerWM2xsBnotwNlHYS6LXvu2R6lMCu7NXCh3FCgoHtNDjqeh6RCLqhR7U
	wNV7D41Z9C9I9Ukt33MkrsIU4ezV/lie7aRR2oVBMMX04M68kMfLgqv1LQeVe20L
	oV4Djkkl9XHZ8p2UMWK3iPgewg8uLmie1DdA2RZX2F1oUupBtX1DNj3ti/5llKrM
	/0WC6QzjBhH7wFvPvZPQnwx5bC4xJ9YGYoO6STi6alHHkQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id o-pylyNOW25t; Tue, 17 Mar 2026 16:24:46 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fZy3J4Hmrz1XM0pH;
	Tue, 17 Mar 2026 16:24:44 +0000 (UTC)
Message-ID: <1b8125ab-ce71-43f5-9a91-f40d9b70134b@acm.org>
Date: Tue, 17 Mar 2026 09:24:43 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] zram: Add lock context annotations
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Minchan Kim <minchan@kernel.org>, Nathan Chancellor <nathan@kernel.org>
References: <20260316200901.4111651-1-bvanassche@acm.org>
 <20260316200901.4111651-13-bvanassche@acm.org> <20260317140819.GE2670@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260317140819.GE2670@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/26 7:08 AM, Christoph Hellwig wrote:
>> -struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
>> +struct zcomp_strm *__zcomp_stream_get(struct zcomp *comp)
>> +	__no_context_analysis /* acquire related to return value */
> 
> Which should be supported by the latest version of the annotations.

Unfortunately not. If I annotate __zcomp_stream_get() with
__acquires(&raw_cpu_ptr(comp->stream)->lock), the following error
messages appear:

drivers/block/zram/zcomp.c:131:1: error: mutex 'tcp_ptr__.lock' is still 
held at
       the end of function [-Werror,-Wthread-safety-analysis]
   131 | }
       | ^
drivers/block/zram/zcomp.c:126:3: note: mutex acquired here
   126 |                 mutex_lock(&zstrm->lock);
       |                 ^
drivers/block/zram/zcomp.c:131:1: error: expecting mutex 
'tcp_ptr__.lock' to be
       held at the end of function [-Werror,-Wthread-safety-analysis]
   131 | }
       | ^
drivers/block/zram/zcomp.c:110:20: note: mutex acquired here
   110 | struct zcomp_strm *__zcomp_stream_get(struct zcomp *comp)
       |                    ^
2 errors generated.

raw_cpu_ptr() has been defined as follows:

#define raw_cpu_ptr(ptr)						\
({									\
	__verify_pcpu_ptr(ptr);						\
	arch_raw_cpu_ptr(ptr);						\
})

If I replace arch_raw_cpu_ptr(ptr) with 0 in the above macro (which is
incorrect), the compiler errors shown above disappear. So there must be
something in the x86 definition of arch_raw_cpu_ptr() that makes the
Clang alias analysis fail (this_cpu_off is a per-cpu variable):

#define arch_raw_cpu_ptr(_ptr)						\
({									\
	unsigned long tcp_ptr__ = raw_cpu_read_long(this_cpu_off);	\
									\
	tcp_ptr__ += (__force unsigned long)(_ptr);			\
	(TYPEOF_UNQUAL(*(_ptr)) __force __kernel *)tcp_ptr__;		\
})

Thanks,

Bart.
