Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2A233CE
	for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358818; cv=none; b=V3T2xVjbRAaKZ+Hq+IaZEQMey2IBqQH0NI8HUs4l/5vKto2IROOGQL1RH4CBRUGnsmuMHJTnCtOvl0dk57iO4U+k0rzDtacn3wthYc3JrXjXME91hZth9alJ5NQzB6nl+bkhOboaju8yMBx8nayI/Z3ahTy9JmLLJm8rXVfQbBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358818; c=relaxed/simple;
	bh=dtGaLMmi+k0XPunMwQot+UNDGJLkHyYWVFXicGmQ+7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dE1rdMaqTlay31C+DgL1huB4tjTteQM5VwXAQG7C/s/N5Eyb7ioHz14dMHrrL16WhzSnPQA+XTxSnBhfusP+hlQ2gHjM+ZRaSWl7qOmjwCERpWyJaczMYt+Iy0NYLXs+8hlqhcCiz/rVO/R1pVWVEg7STQFKccv+YgTqULgW6eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gAd1O1K+; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gAd1O1K+"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-366326c6c0cso383235ab.1
        for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 12:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710358814; x=1710963614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWZmATEPK4fDfBCHZhSlkAhi3zzM8I9gdKhUeKMMIRg=;
        b=gAd1O1K+8Zp4CK+RpxUyjKzAQU+FkoN4PF1MVD77yMtq6s+gmw68RCnExJNWnWgUDz
         F/SKxrap8NdVxQ3kjEi/7B+VcQMHNGR6u++883qfgdMSa4zOP94Gm0Omhz930KCzhg7Y
         mpO/U/RLmbUyQMQCzMtRDxio0hn0CAFPiqxVywsb93G+i/NhAAPJdJjxo9Coxc2r70pc
         Km4OFcmV0qts/pbihQJ/G4M3OHTYfBcVMMnKpFJfVLldmQ+rzm+KnqWD/0EXH7XC2n1g
         sHhKB4/VlWddQYVOjkIkG74GooWlshk3L/ZQ8eMBiMm7zqmDn4H46W7L9ANXahIkpqmw
         WtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710358814; x=1710963614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWZmATEPK4fDfBCHZhSlkAhi3zzM8I9gdKhUeKMMIRg=;
        b=tkrNQuWF08iQpjEUIWyOYAR1JkmGuOJckcrv7vGgQB2j0HPSbaR+E4a7wYYY6n9/iQ
         4Lfjkk3k3ybtq1+WFiE7ifb8JBm57AULaqHyRNjzejvnwwJVNWbnkUNS99riExDpwFZw
         i2B7drNb5DUNNzCYNp7/9zzSSiaBEvNfexknAbYSqLfceOH/cVlLZlccKLoeYO+c7qVp
         IFrltdZr4J2WnZqN7nftepx7js5FMz1bm1Lh//utzCUqRsHRnD1U1DVlq3kUH4JTy1pY
         cTz5p9HXEFVGd6gYK3joEPrfaTcypWqb0AeVN8SuKyKO6CGkfUsK/+cRDfMHPyiNzgeN
         nmiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaAeG1xBB8WkF7xU3nxjs0vYi2aoq6+ZDRK9AqSEv9tYv3KXneZOECA8AcHniwU+twa8352SX47rnDq4Ptb+Biw7KyGoUCIzmbje0=
X-Gm-Message-State: AOJu0YyNf1i4PA4LJLdgAwrcbSe8Fhzl+84OhVzKIl4pV0Wb47MudSdf
	mzv1WjropXdGAm+jp/kUZVoqbDjxBbSkQ2FPfeQ/5tCHa83UwabKHzxoLpUwQCMBKmrjfZkYDrW
	s
X-Google-Smtp-Source: AGHT+IFH1AIy/7QctRVFBr2d16OquKkeqZSHYZCwH83jxFjNpHuXzdUulKBWnEmaOBuftKVbZ+FFFg==
X-Received: by 2002:a05:6e02:1a2e:b0:363:cec2:e344 with SMTP id g14-20020a056e021a2e00b00363cec2e344mr2718705ile.2.1710358813639;
        Wed, 13 Mar 2024 12:40:13 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r11-20020a92c5ab000000b00363c90b1207sm1429ilt.55.2024.03.13.12.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 12:40:12 -0700 (PDT)
Message-ID: <3429f79b-442c-4444-b592-85090e0e78cd@kernel.dk>
Date: Wed, 13 Mar 2024 13:40:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brd in a memdesc world
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 Pankaj Raghav <p.raghav@samsung.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <ZfCTfa9gfZwnCie0@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZfCTfa9gfZwnCie0@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/24 11:40 AM, Matthew Wilcox wrote:
> Hi Jens,
> 
> I'm looking for an architecture-level decision on what the brd driver
> should look like once struct page has been shrunk to a minimal size
> (more detail at https://kernelnewbies.org/MatthewWilcox/Memdescs )
> 
> Currently brd uses page->index as a debugging check.  In the memdesc
> future, struct page has no members (you could store a small amount of
> information in it, but I'm not willing to commit to more than a few bits).
> 
> brd doesn't use anything else from struct page, as far as I can tell.
> It just calls kmap_atomic() / __free_page() / flush_dcache_page() (and
> it doesn't need to call flush_dcache_page() because you can't mmap the
> pages in the brd's array).
> 
> Now if you have plans to, eg, support page migration, you're going to need
> a bit more infrastructure than just allocating pages, but for what you
> have at the moment, just removing the debugging checks that page->index ==
> idx would make you entirely compatible with the memdesc future.
> 
> Any problem with that?

As far as I can recall, I haven't seen that debugging trigger anything
in forever. So fine to kill it, imho.

-- 
Jens Axboe

