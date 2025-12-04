Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03815333439
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764838830; cv=none; b=SZHKrFcrft+Wr+hPXVgy423bDvidQyFLuHgUVThU23hFpYbfRM5uNOuszpeenCWm8SWhwDxaZqXX39eniMM2yqHxRvPrSVYFUL/kkVht1+MjgbkTWJPQUWjytExfR7Q24sX6v08Fsm9jHunK0uYg8FaXWUTNb0OJCq9OuV2TWFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764838830; c=relaxed/simple;
	bh=72GPm1ULAj1WA2GXdfhiS+jYjGnUAprwyZKKNmKV62I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAX9KMm4hJ7K3qrTTQ2wuCmXB5+rjG/L6SKcFBLLXD4OFKaXrd2EblaS7rSxTAi8FBpfGGQG7BhRnSau6lvldNyMkKutOXF8m2tdTR2CaXFAgVCv5PZdtgs7+un49ZuBEja5XJQ+/rz84dC2DWzr/6WNrPkKPellbcLaF2kuDFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d8/pFBj4; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d8/pFBj4"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7ba49f92362so437787b3a.1
        for <linux-block@vger.kernel.org>; Thu, 04 Dec 2025 01:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764838827; x=1765443627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=72GPm1ULAj1WA2GXdfhiS+jYjGnUAprwyZKKNmKV62I=;
        b=d8/pFBj4FGRkH7QWlN8rQvDV6IlMWDUg605KeQ1gBOCr/BEoQshoR8T5DQFy2RO8N8
         c1k88JauWrYBi7WblT4cyXW3T8XrmXYkhRGNoUs0oap8m4ffw1QHEx0JRoB0N1OO1qs4
         MSivUcGmKJE03vLOq+EJGofaw+BYOBYJHGMn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764838827; x=1765443627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72GPm1ULAj1WA2GXdfhiS+jYjGnUAprwyZKKNmKV62I=;
        b=FWjmqI+Zdjcj4NoeHvonyCg8uFeYm/yP3uUZe06Z+ax/xP5dQUMaj+GVGAaFn3LuXM
         b8wATFymakQAphURAacAqvLwemQ9xXavC+oPwUoV9PoCisw9fhTlwgHfD3msEC5sJbaO
         F2AbDTiFjtau7Ao/IBh+uxFdcDWLw8uCX+o00NesAI7ITt66of5qLlSrJhzjxtWOlJqo
         6YtQ+OlAgw1S9plX9dZKYST/hMusRSrCOlZJQIyL7lfp4lx9XcPI3jATCeKc/yRTz6IA
         mJXm4rjoHjLTRUMlznMlaa/nNUyLqHCFTmyiTh9KtlVRiNi7PdKgTLeeH8nhy5aW9xqN
         XTxg==
X-Forwarded-Encrypted: i=1; AJvYcCUQYESGQfTTQy3yoPz145IrX58TuIAOz9mZOu9z4zHj+OdYE3UCRyRm8ZwjvmQswMKlDzDW34ZS8NUlOg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo1ucPQHeUAHWGaVRTg1WV+RQ0eLpcmACWdkF6GTeGQPcFf6Xn
	PELuWt+0c1Y75s5UKHDqK1wzbCniElcJ8rwyvOe1w20EoT9kimq3IIbddQ4KDsQ/5Q==
X-Gm-Gg: ASbGncsnRmouy41DFt3iFf1anDmJxGAm+iGUR3zX9siKku4Cun+rhKItJ3rIdc5VfHz
	J9OY6NVcyiZYKwSlRLMMjGz6zxXdJQIE1GX+c2AVh8BJCgS5qfhF2yfQ2ZosIrcrGbkJBcPsIgL
	sABGTYo9H14JiBuvpXZ9hgkiYRtcf/zDFQkoZ3AR/8n7zIXnUBsC8Zd9xa+pIpC8ksER8hH9BKc
	N+YRdZpGFlF1LcLX7cMaks2x4AICKoYvIYP9rIgXFFc5fsRGRsnN6IDcbMbgxzuHyykPoS3LSuk
	zuRntsEgO56HMm83FioPjBN6Ccl4E6rhZ+kM5rD41X7PZUTnFLXeVW/65l7bWwIeP1ii5u6OCW+
	M01QHzhj66p80Smf1muR8eZXZettzOaFifux3oae/0IrPFc0U711EnkYFsjeyNKQkvwJyPmUlmC
	xrU6o3NrSgPRTu3RwEjPv2T8eV70YO5gkLDJdYvAAWnnssQ1iVu4w=
X-Google-Smtp-Source: AGHT+IGrCmJXKAQtdU3NALKnC/NLtRATjkDSaaivHemq5nPaEpusucmf2NZ3eoouqNk9cTRRShNDMA==
X-Received: by 2002:a05:6a00:6fcd:b0:77d:c625:f5d3 with SMTP id d2e1a72fcca58-7e2020650a4mr2076684b3a.1.1764838826661;
        Thu, 04 Dec 2025 01:00:26 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:803c:ee65:39d6:745e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ece66sm1483482b3a.13.2025.12.04.01.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 01:00:26 -0800 (PST)
Date: Thu, 4 Dec 2025 18:00:21 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, agruenba@redhat.com, 
	ming.lei@redhat.com, hsiangkao@linux.alibaba.com, csander@purestorage.com, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Subject: Re: [PATCH v3 8/9] zram: Replace the repetitive bio chaining code
 patterns
Message-ID: <d3du6mmazbygxo2zkxqjxamfg44ovrfiilbof6rnllfjzxnnby@becwubn7keqe>
References: <20251129090122.2457896-1-zhangshida@kylinos.cn>
 <20251129090122.2457896-9-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129090122.2457896-9-zhangshida@kylinos.cn>

On (25/11/29 17:01), zhangshida wrote:
> Replace duplicate bio chaining logic with the common
> bio_chain_and_submit helper function.

A friendly hint: Cc-ing maintainers doesn't hurt, mostly.

Looks good to me, there is a slight chance of a conflict with
another pending zram patches, but it's quite trivial to resolve.

Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
