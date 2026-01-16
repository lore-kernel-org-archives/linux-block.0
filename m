Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4384323EA83
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 03:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534861; cv=none; b=vDIDw+UUfCcme9Ion2t8q9DWHsA/kTS7nqfCr1q67qucednm/pB8Aju2YxZo8MBll1OGepAuDtZrqBM7FYvC1D1Hi8H5Qo/4Uu8S0pBcxzcoGD1pjq99/1qh/XgJUrv+54kXyAnCUS1l2cXdimJm66PADjddDZqdn5wZ+gGdYDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534861; c=relaxed/simple;
	bh=/i6Dyk8wuqbXmMN1e3S7R2VA5VM8S9Z03l2XYBazvVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOtOn+DuU6Mdk9OdSiq7YlJBBCUokj0C/8mmSb8gfFDbkAKvcIZT4H9A7ytlOSDJfO6eknymCbfjK7JkeWw+DsjAfxj3cKCaG5CFiGj7eXBPzmJIOQ52w39/M0BDOsaCxGmzH1Oyj1RHLj6fOUnd6uZG3PfzuhGXTHFBuBwEcEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=neSbjmUB; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="neSbjmUB"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7cfd0f2ef93so713616a34.1
        for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 19:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768534858; x=1769139658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/PfayK5hlZPTQ7Jul/Cnommd5sGdCaiVUqVPiu1G3d4=;
        b=neSbjmUBRieCi1qkvJA2FvxN7WNcPIP+jeAdJnVfHGp3T2b96S+NTJbBLLFbg1SBGP
         BAbkjOfHSgWwyqYvvXmOJbAukLwYxgUqGNcjwGLcadfLzjELYRIyPPtv68aebdyoKbIg
         jO8cwBkNkJMvfjugd4d77PcqoJO1KW1sRDP+WmpN1LxNbro7b4XBTKT1boMVXQh1IThw
         tnC/T0rvbfdiHHvlY6JS7xqvNlOMx9IL2Ow5LoWmwA0xv5QP+ECZrv11bkfKv/U7aUr/
         yC+i6zVUEG3bOuMu/NFkE1r9OB7hFRvcJ0EL6PDudcViS4tvVi51nXcnt8Y9av/3LmqN
         HINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768534858; x=1769139658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/PfayK5hlZPTQ7Jul/Cnommd5sGdCaiVUqVPiu1G3d4=;
        b=MFWUu44fxs4RO0gIzd3WweZlGGXWYtwsSaSGbLWS3hiJWlpBjxycY5iSAwRCj0AdJZ
         HY5GEmf56lSYhY8tFrU8ENx4jOOVfLuBY3W/stVLfW5oOkLtgD8r0tMH5REv/R25DBdo
         hdBTr12EZJlRpROCkwaUyAxH+mj52Uj/n8y4q9rZnSLO13O6HtSzVJpokQqKGIxTqRni
         M4kb71eKyG226YTXxFMERfIH4+/XrS9g+zRalyAOSyuOo4UpLvP05HD9v3hoBzuKD3RF
         HSOxjPvPbUJ0YBOVy11IvzUfs7yKgRmZWbgLy615SqIltS78wYRGdlgw4YKCk5QBdLW5
         NZ/w==
X-Forwarded-Encrypted: i=1; AJvYcCVPxVwd3GIHnpL20q152SCvxi75MNLPIRaVYK7aA3RSnG4AviBh6yV6hbZawPr/wnPeZ67xq9wUBaqSgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUzc+bP7cbvGQaqDnr4Zco2k219pqQmP11UlAyUmyQ8qOy0QDc
	pKi6GoI8Jx2YzQgMAkYnQd6Jh3ID+KgJEAn6avzgMkfxskg34YcT4VQZla77s1NTW28=
X-Gm-Gg: AY/fxX43/d5+3BR3dA+4xq0YPZ3y4C+XxZfH/F25VTc+rTvUsLbFuMkGwVvow/etI9T
	bDu4QOsgyASmdtcQCRpmsh0gdZT/6mxgwJllx985nahathDvSAuN0caT+rq/Huk0/a7hXDu3KOo
	7L7UaU8w/xDWmBbCLwH7JnmJ2l7r/WJD50TT5ADNjLgq/pFmcKQb8wMMED1v0kvVTYFJ2EDGa7K
	NcgkB0owu43xu5Rn+SYcdpFLlOAHRWAtM9oLOF8He7M+cQO4VvbMeXBP97voWJs4bt4CxL5sfKr
	bdeppINFstecysur9VBzuxVF5Mp+6exGfCKvgEwsuWjC+nPH8UzasW35I9z2flJSXpT37UFwSzy
	HRhKRO75J4p3LUBWQvZqvgHqYVSSgtOZqQe2jd00E0ftB/bH+/hiiZHWixWr7YCTBdS4NyNZ3qC
	qi6kXq/8ri
X-Received: by 2002:a05:6830:2a91:b0:7c7:63b6:89d3 with SMTP id 46e09a7af769-7cfdee2b72cmr912948a34.19.1768534858009;
        Thu, 15 Jan 2026 19:40:58 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf28f71dsm1029345a34.16.2026.01.15.19.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 19:40:57 -0800 (PST)
Message-ID: <6d0e6461-de4f-468f-bb81-0c650700ba0d@kernel.dk>
Date: Thu, 15 Jan 2026 20:40:56 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: remove the boring judgment in
 blk_rq_map_bio_alloc()
To: Chaohai Chen <wdhh6@aliyun.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20260116021524.776322-1-wdhh6@aliyun.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260116021524.776322-1-wdhh6@aliyun.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

https://lore.kernel.org/all/2d73aaa4-9718-4285-ab3f-85e1fa3b40fa@kernel.dk/

-- 
Jens Axboe

