Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793238847;
	b=biKImMRZcgkAoC69qOO6E3860OF6Po1iKrAYsRMz9VWIvu+2KaVhk0lm3XERJUtm7wnJ
	 vW3Rgfb3ZOrzeW94DwRPFcS1vAWt6jZtQgOCOgTWhufBgqqIcINaKXD6+UZyGnPnOml/+
	 30I1K2ujz+1jWuxRRNenOJ+4D5YMaIg4c72s+ZP27ka0krdxdHvnZDpHyUBgNDKY0fxK1
	 Nz6P9RGM2Ie6RJi2Et1wIH6PPlyohTNuCnqiJBhX6ms9ofGzoL770lKpm5emPMauPPtRg
	 dhd0TRFUaTVvesozUuOJjHWVOkJj2mxytqWd2OlLQs5Pr1KEsSYwUmraVL123Xu6i9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793238847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=bDvELGQi9MfOeaDPWq3cJAJFDMVwqQVSIPY5xJr0g9U=;
	b=vtVR5wcZQdDNHIlYnVldwjbJNr3kyqAwQjz2skFY42w5OFfRwfPDCnT8bkMmopFruuMW
	 w4Ya395nCsvlOhhhH4swc8HHPD6v5l4eIRSRE3lpretcIQu74eRrqicF2PanSZiIqlRNn
	 UP0i4AqdQI8sIEJVxhPEwHUDhDkQSvcILdiUREAFwgYj2ObZxHycSWFlqd/2/2A4r0sG/
	 5hFZCiB4Podsf+ZGqE/cuHDAjjmoN4EKqlhbYkYUY9rpH1kVz3JicgDHMnNhXJjpRLrog
	 LF9EBihzJfYk49JEraLYeb5u5qc/TyltB1Ggo0RWfBJ4SjfgYCJTEktWI9DRNXPOG4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VMM3GJzf;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF93606A31C
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 01:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEF93606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VMM3GJzf
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so2287917eec.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 18:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793238844; x=1793843644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bDvELGQi9MfOeaDPWq3cJAJFDMVwqQVSIPY5xJr0g9U=;
        b=VMM3GJzfQvf4gEmV++SaxpnE2WHgJF2Adif6k0TZEq/MO0UYg69aT9h/pFdCNgG9Uc
         9YyNRw95u4MmwWil0iKNV5Ij6pt6Yi11mMrg5tKIc2fqrQsPZQ8McUxEvFKk/49tp/Ae
         5/TtLBbR3l73Tj+qxTpAtOVfN4xLQG2SgbChSeTZagS9yedLKij9GUDAAfu0Ex9HPft6
         tfZOphps39YkGnQ5FSCiIbnJdZQSfsj8igzY9Kyu4VRXe8JXB6h2Hp2uUVHKdAJ9daWp
         5PZ3k08Kx9F3I8eH5FNI4DdtNptM1q9B5CrMttErSR1eG9Y7yXJX2ejIxszS61GhYXBP
         vThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793238844; x=1793843644;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bDvELGQi9MfOeaDPWq3cJAJFDMVwqQVSIPY5xJr0g9U=;
        b=K/95hw0sEhIe7KZVQCcNvDXCAht7a6hgEKDN9GV7vP/fDKNJAUjGajLZ10M7H1+QIG
         8lkbOqlrI/g1XA/fqz8me3mo1y9ws4yszPxr0dlCwnnjR6bMxswViZt+dd61dTY9wl2l
         6sLlL15vEqZ6Y04rZm9Qw2mwIsquqO8EeroiKzGIfVpEwQOsaRcOKhVLxrWTB4GddbEU
         WIMBvpKnjTMg/HqQoxMLR+Sb9yZSNvBy0cUTpxq3sfV8MZMXKnmsIQ5wa19NoCoI+8PG
         0jEWJgZ8uc2FBKuJXDJ9dPUAAo7Eh3s7mxuKC1u+Cw9MUV/qigHErBtyUO8LaYBivw7H
         u55w==
X-Gm-Message-State: AFq9FYJmi0eXax0bw7XLp2MubXZBV0eDTyfoB7CcQviTpDMHdFHY6hvJ
	zfC3ANBHitiuE1xll1Efpy4OvlUxd8omMlk6EEENS1oHGRVCR/LC4n+Ra3eLkoDcO5w=
X-Gm-Gg: AYBFou0hVzyde1J+vpqTRsT1jZuWHmXoFAxq6IB29wYFyOBYEtv+WsHWs2oByh5k081
	XraUA7YkXY2gyGNWOJLqfVMqgKSCN+2O7v7ZhtRp9XHmNe9wHaWJGC26UCvS5yY8hxtJnV8fsfy
	j+DpsrFm7r6kYg08wioOymWeeVt2hjRoaWYH+AulRPRp2c57Xf3OB40QNOclAmCRZV2XSHXuG1o
	Jm9WTSE92sWszURgzz66csZlLQf73JaPnr/4nyBl/WGeWCXOFQ5nNMeixXFMDvpax5e0LA6i9yQ
	HFfGU0xAgLhzpWHFKViggEDc2/SqTUxh1r1pIeqiKwgGlJltDohvcrLUqt9G3KaI85KHqDQGIUH
	mTyfg9QmwKhEgWf5psxpIZ59jRW6owpmMMGfse57Pow7YtQOCie717Y1y8+4BqTrFgW4iygRLM2
	gJn+RbPZ3jTyHNhOsD5GmgpXKRTg++9IJ4iLhFw2+anm0h0ZcPde1yODo1ugyxo42AzciIfZUYm
	9bVyFB5d6PWErNLsk/Tf/rvvwBHRWugYO365SJv2rULQXkkzSCWM82Vk7vuUeGsM6mwKSOYUbyF
	uOlHBOY6s4+Mie3djAkm1+MV6i+CkQlF+b+4rOZo2piCa9gInO9ULlFv7lvP55dTXvLBuc+fSEP
	WZIWmQ/HKd0nE
X-Received: by 2002:a05:7301:b09:b0:360:d4c5:7243 with SMTP id 5a478bee46e88-36a2002d2cfmr5093545eec.11.1793238844420;
        Wed, 28 Oct 2026 18:54:04 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239bf999sm12075692eec.28.2026.10.28.18.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 18:54:03 -0700 (PDT)
Message-ID: <beffc39a-9680-45c3-83d0-6251e28840fc@kernel.dk>
Date: Wed, 28 Oct 2026 19:54:03 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/98] zram: accept lz4 dictionaries of more than 64 KiB
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Minchan Kim <minchan@kernel.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-25-axboe@kernel.dk> <auKfEyDhNK0lf0c6@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <auKfEyDhNK0lf0c6@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 7:20 PM, Sergey Senozhatsky wrote:
> On (26/10/28 10:41), Jens Axboe wrote:
> [..]
>>  #include <linux/kernel.h>
>>  #include <linux/lz4.h>
>> +#include <linux/sizes.h>
>>  #include <linux/slab.h>
>>  #include <linux/vmalloc.h>
>>  
>> @@ -48,7 +49,8 @@ static int lz4_setup_params(struct zcomp_params *params)
>>  
>>  	ret = LZ4_loadDict(dict_stream,
>>  			   params->dict, params->dict_sz);
>> -	if (ret != params->dict_sz) {
>> +	/* Only the last 64 KiB of a dictionary are of use */
>> +	if (ret != min_t(size_t, params->dict_sz, SZ_64K)) {
>>  		kfree(dict_stream);
>>  		return -EINVAL;
>>  	}
>> diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
>> index d8aa01bb258f..d163ff0ae8ae 100644
>> --- a/drivers/block/zram/backend_lz4hc.c
>> +++ b/drivers/block/zram/backend_lz4hc.c
>> @@ -4,6 +4,7 @@
>>  
>>  #include <linux/kernel.h>
>>  #include <linux/lz4.h>
>> +#include <linux/sizes.h>
>>  #include <linux/slab.h>
>>  #include <linux/vmalloc.h>
>>  
>> @@ -96,7 +97,8 @@ static int lz4hc_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
>>  		LZ4_resetStreamHC(zctx->cstrm, params->level);
>>  		ret = LZ4_loadDictHC(zctx->cstrm, params->dict,
>>  				     params->dict_sz);
>> -		if (ret != params->dict_sz)
>> +		/* Only the last 64 KiB of a dictionary are of use */
>> +		if (ret != min_t(size_t, params->dict_sz, SZ_64K))
>>  			return -EINVAL;
> 
> I think this should patch lz4hc_setup_params() instead.
> Similarly to lz4 hunk.

You're the maintainer, so queue up a patch like that. Like I told
Bart, I'm not sending this out to get review. Either ack it if it's
good, and if not, as the maintainer of this driver, just fix it and
I'll happily drop this one.

-- 
Jens Axboe

