Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E495F1E47CC
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 04:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787891451; cv=none; b=ijSdiEQTcOM6v/zLqLMPy/oAXPQ25WmRlaXkF0g0EDGSgjmsWgOed/qhg9YHFSKWg+vEo4jRBM9332hQih0ckPBCdSjuUWHJM0HAAxD2jSIQVG917vrHpcabvR+jSQl5pMq87DPBM4TuE1TyfcC6aTsEOV27S6o/IjzVIrb9si0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787891451; c=relaxed/simple;
	bh=kG58sF3RZ5u9NnjOKQXNOz8FhkA7f7nNGMaw3qY76mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/fJ/zxkJVasBIRVaHQwjYQtsEtGoe7vnx6DusAkHre3cnrf5SYy6k8IDUfJcPfGv2kO5RW5E/Va4hjD2kcVrY5KV/seq9kUU+iTpoOaJpqSwvBQNgXPRO+AoyDb4q5GxAhZjhCui6m0gJdtjY+7x6LfzhTGEtWaXQue96SxNLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HnqsjjQJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HnqsjjQJ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d7200b2e15so6701635ad.3
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 21:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787891449; x=1788496249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wWELYUdy0evcbSQbyM99+0EsELbqzDDQlDxke8jG9OY=;
        b=HnqsjjQJ96I4GX86C+PjPYNe2AMblWrCe/cj1V7jUWrb6ADQRWIOvgvNhbsAHRaWfK
         cG57yTbTFqx0irqjXcVvfTUaLO0Hk8PVNvKWC71hOAQ1aNESYyHell4A9k78J3zBhh9c
         4gbMMBgUeMM1l/efZI7Y5seNzCiMaeHbX0Jjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787891449; x=1788496249;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wWELYUdy0evcbSQbyM99+0EsELbqzDDQlDxke8jG9OY=;
        b=AlcE3aOb6YSqJ+AEIMMWF9zlg2PCZxTezHnOQ2mH0IPrfS7YVlGJ4Q7Wl4Q1uET8P+
         5Jn19VN0shsXYT2yBffk1deRU8FPsvBM3ixLxQCVIerf9IR3aj/dX4XaNtMklhqHBgfB
         cgxWBXigRoeYvzBaz7583LMVJhdwT9jigdxcbv0SP+Ho3I2NaW5eUr15AfK768IwYAzJ
         wtAMAyNf138cXhtUuMMlQYhhbSftXzpMOVq0fBqrt9L1V5in06NgJWt0peRv6Lj9uBLM
         8oCb4JYSUMdZPCW/mk/luDSwIiQi0rhKjup/fV1K04YAuHd+xQjFCPi0CcJiYNgT+e8v
         KN0A==
X-Forwarded-Encrypted: i=1; AHgh+RptMT94RO+7fRMzSemKT5pHG5Od7iqZZmJpvSuU4A4ywoCZQfyrPKJVwUcwwk2+FNolfGojXnRvBoPTmA==@vger.kernel.org
X-Gm-Message-State: AFuF++nmIJHs/QQNOpmjepUSq7ZOaiLIkmfFC0CZfaBaA6hXNpsqCZZX
	FRHbmkbXjTBASknTFOQ6Iltj8o9v0s/BaCi6Xdcf7GE8VkL42KwQHVQ6oD75d/d/5g==
X-Gm-Gg: AR+sD11SYm6d1ySko1S6aVOaBE1mJoRcR2E/w9JzFSK9xU60+PfQ34D5jokkb1asBPB
	iCpS82Z0yRLYcLy+UEkYg3DquQVh5/MhOkIbY2bIVu8O/ON7s2mu5nVX6+WLPAAI6r0rUQxkSoP
	C4TA0d00miuGqfJS7rFiAVSKxrAEDQruRD5vH3c3UhsxCAZrZSy4tZqKan9lITnvjZckoJMM8Ij
	/31rpqK7MFqYWvLRMe899uJqYIn/kOj0B9k7PnjkMBYkSk0hHkBuK+1MWhl+FHjXl6ruyOYUnNm
	xO/9cA67Yx0JrYUXFKNghs//3GyU8JbOqoyRWkcrjAv7uo7IB3yNzIIS5Vh0O0ltPnW4/6OBNc3
	AsXzQDIH/ixXvrzM7DvloWXuh6gyFt/7vtzJX6hFDibhZ4IXk5xqgcN56EzGQsO3o1mugwh6hCe
	09o7cMdMwO4JeThtc5qyds4PGP9zh3wwi6JjYl7Y2b6aFcv741ikwLQLx6PnJ3rIGU9soiIKbIt
	/aRzWlv0SRvXpksZ8AIyqWnYdhEf0P65oXIsg==
X-Received: by 2002:a17:903:350f:b0:2d6:d3f9:d394 with SMTP id d9443c01a7336-2d74ce2d81dmr81411195ad.0.1787891448977;
        Thu, 27 Aug 2026 21:30:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:ff0:ad84:24b0:9e52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7594fc0c9sm1794885ad.2.2026.08.27.21.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 21:30:48 -0700 (PDT)
Date: Fri, 28 Aug 2026 13:30:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Hao Jia <jiahao.kernel@gmail.com>, Brian Geffon <bgeffon@google.com>, 
	minchan@kernel.org, axboe@kernel.dk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH] zram: fix idle age_sec underflow in idle_store()
Message-ID: <apEOgZEaDXntmbKn@google.com>
References: <20260825092316.69658-1-jiahao.kernel@gmail.com>
 <apEK-yRTQR8VdT3e@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apEK-yRTQR8VdT3e@google.com>

On (26/08/28 13:23), Sergey Senozhatsky wrote:
> Can we instead just reject such cases?   It should be an error to
> request writeback of pages that are 2y old on a system that has
> uptime of 2d.
> 
> Maybe something like this:
> 
> +             time64_t uptime;
> 
> -             if (IS_ENABLED(CONFIG_ZRAM_TRACK_ENTRY_ACTIME) &&
> -                 !kstrtouint(buf, 0, &age_sec))
> -                     cutoff = ktime_sub((u32)ktime_get_boottime_seconds(),
> -                                        age_sec);
> -             else
> +             if (!IS_ENABLED(CONFIG_ZRAM_TRACK_ENTRY_ACTIME) ||
> +                 kstrtouint(buf, 0, &age_sec))
>                       return -EINVAL;
> +
> +             /* No slot can be older than the system uptime */
> +             uptime = ktime_get_boottime_seconds();
> +             if (age_sec >= uptime)
> +                     return -ERANGE;
> +
> +             cutoff = uptime - age_sec;
>       }
> 
> We are probably fine doing just basic arithmetics operations on those two.
> One is u32 the other one is s64: we should be fine just doing >= and sub.
> I guess we also can use plain comparison
> 	cutoff > zram->table[index].attr.ac_time
> in mark_idle().  Or am I hallucinating?

That implies that cutoff becomes time64_t both in idle_store() and in
mark_idle().
