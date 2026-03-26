Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B853F7AA8
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531755; cv=none; b=c58K9PfBm0LkgM80cdZvtDZ/ATgNw3RAQQd9dbr4m+RvTIkvx1Yyo7p/9UG9iGPNpD+/J0aexX7sgGReIUGX0I8h2irY5hiNa+pqkDosIG1C1N2e9+VcgtOtNTq1XLYF27z6fjTHgDWiD8dU5rfuWbATRtgEPoZnmbMZ4Q55bIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531755; c=relaxed/simple;
	bh=B6noTafdsZNzMpLDDpDQS6ENyhj+30j7mmXH6QqRMmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTOPU6wGRcFjkji+NmW0hoOwKRnsjo42UmRcgwtf4NwnlOisMrth1lnI6a9BtHFrWBcI5UIx1ghrvI2qZAwMWx8QvGHXRLUoSTu7qkLCoVSKLTWUhj3bUgC3UwGJnR6K6ZhtRZkJTk/DWFcj2vJKmzC5yzS3JdWaW+2RQNUNXEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Lwry8k/b; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Lwry8k/b"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d74aa6bcdbso513111a34.2
        for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774531751; x=1775136551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/14zwkBWbjGDATSnVCzZMJjiEbUtWagM+D+x2Rn4yjA=;
        b=Lwry8k/boNcRNW3AtEVv+DrC8Lu61v7NR+OhC2ckArIvwT9mEtjhxc5HQZbWUi+SS4
         2E5wIlud2RlI+868ZPersa3EQMt12ACXukEKKQhgKOg9CCQXt6mH3swyjndukFRB8WyK
         Hk+eh24uUez82agqWqqqWZ64dmz/K1lrPf4MSmtarg8FjW0YpXlzz+jAycnK1vP6HRET
         iH9og9HtmhCoDzNgPl/d/RCHekOlzviqgKs9tO+f4d2lMPCPY26/4Xc+bOox2vavyiwr
         BkyoIfiTRE27uXNwIP6K9LzGP/McbavGvZ/dCPS0xy34NWfqwnxqIs+HMoNZzImsHeXc
         VYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774531751; x=1775136551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/14zwkBWbjGDATSnVCzZMJjiEbUtWagM+D+x2Rn4yjA=;
        b=FAtr1view5KXMmBoY6bA8PwFxYgvp87m+GZgD0ddzOlmqNH3t31L6ggl8lSlHCnZVu
         pa48yq79imC9wIwoBvAQ52wgY+0mZl317uXIUl6SJ3UxuKWmvBzYEH/4Qhk561CThmlk
         TSNO3HcS6481DXvitklX6pJ5Xh8pgnehkUcC4ZdEQ+cyjt6yI9nfo6aD3VU5u4un6auP
         pMr0r874vry26EVMQ/3OGNJSymF/QjL8foEBuHrdHLELkfQTu/mzNvgO/KUioIxhIKzG
         3KBQDzjzs0zskHfmiPsBQNJym9MG5q2DFrx+5VUfynhXBgbusi2L68ccnsPQPY32pnb9
         l5cA==
X-Forwarded-Encrypted: i=1; AJvYcCXMwqPyQgM/xY5WxRR+9AFBRSj1lvIA6cCJGmKPao9/jQF4wN0KbMxLtpUbeyQLnGXvTS4zoQfwM4wQug==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYGYQhRZYWCwsqnTwg5MV2W+cLvHuxf5dR89/1lWxq7o6CkeCl
	m4wUq5piWPLK7MXLjt5bjdGCrPbJ441SYffsOSJYsbm1TUeIPWf6T4QIgAg+cAHZi+E=
X-Gm-Gg: ATEYQzzFlZ3DtWKqWcNW/Izbt4V2GeGYILNr2cDhVLjba5wFMHbuBHEo7BO+NSoNCJd
	MTFcRBWrZZ7SgZt972dDC4bQQyyI2JqfmqtqqGrvuRFu8a/YAtXcnBVPv4PmVInVH3aPXpsZ75p
	ngXbUTs3a6tbrQcluE5U8gVzqE7Uw8NjSnVNxTqne/JAHY5XBBh2Q77Dgdvt2bPsFneDhV2nIbW
	yKfziCWuD235uwsR6UV7Y1CpPA0sCvkL50Ub3DfMd4rd/FNX7Hup7jFcIssVBWSkoe9MPE21pqy
	RuAY5+E0EkUnrkRunYWK+rNV23hLovHw+14PV5QVpAxpeY6K216154sYUmRimtgSw5PGSNr4Bbx
	gXyYeJ4P1dPlGYLRDt4egZNkE7agnG68SriFaX9fDdXSVPwt0nEE0FPAt9t1focbmGf6Agmqkev
	ScLKlZD3UVv+KWETILHYmRCogdPLdNUPeXCr21pE/hKDbI/PU4jefIeuN8W6GtQr+LQel4QG+RY
	cMHKfENWDewGKr3Legr
X-Received: by 2002:a05:6830:f92:b0:7d7:c96c:c5d6 with SMTP id 46e09a7af769-7d9d64f0914mr4015335a34.1.1774531751668;
        Thu, 26 Mar 2026 06:29:11 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d9e71f680asm2653172a34.17.2026.03.26.06.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 06:29:11 -0700 (PDT)
Message-ID: <c0c9becb-7ec7-4774-99f4-a265f53166e4@kernel.dk>
Date: Thu, 26 Mar 2026 07:29:10 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bio: fix kmemleak false positives from percpu bio alloc
 cache
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>
References: <20260324090052.1782766-1-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260324090052.1782766-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 3:00 AM, Ming Lei wrote:
> When a bio is allocated from the mempool with REQ_ALLOC_CACHE set and
> later completed, bio_put() places it into the per-cpu bio_alloc_cache
> via bio_put_percpu_cache() instead of freeing it back to the
> mempool/slab. The slab allocation remains tracked by kmemleak, but the
> only reference to the bio is through the percpu cache's free_list,
> which kmemleak fails to trace through percpu memory. This causes
> kmemleak to report the cached bios as unreferenced objects.
> 
> Use symmetric kmemleak_free()/kmemleak_alloc() calls to properly track
> bios across percpu cache transitions:
> 
>  - bio_put_percpu_cache: call kmemleak_free() when a bio enters the
>    cache, unregistering it from kmemleak tracking.
> 
>  - bio_alloc_percpu_cache: call kmemleak_alloc() when a bio is taken
>    from the cache for reuse, re-registering it so that genuine leaks
>    of reused bios remain detectable.
> 
>  - __bio_alloc_cache_prune: call kmemleak_alloc() before bio_free() so
>    that kmem_cache_free()'s internal kmemleak_free() has a matching
>    allocation to pair with.

Looks fine to me, but can you please do it against for-7.1/block
instead? It's not a huge issue, and I'd rather not introduce a merge
conflict by shoving it into 7.0 if that can be avoided.

-- 
Jens Axboe
