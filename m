Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5371A9F8C
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928381; cv=none; b=nb7Uz6j19FOfwteGPpH0ec5FsrZuAst1ed+JE6Wyid9dq1pblQE9tmFBK0H0KuqNKkZ1xQ6HorHEl65uk7tO4rlj0kN02aVaA7AzReJxuDMBFqSLG6QDWhaoAoo0v/hpYHcZpNCYhKujBy0g4aDmH+QyP1P70/vOi0r4N68+xdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928381; c=relaxed/simple;
	bh=cjjSPubqADsR+Z507kmUtGbe1mle1SWRQ986s5Ka0Ss=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OvHgGQAy/+OXsRhPw649aET/32hQJDPC/1P/o5nIJkgAul17ljaHNG3osMYY0BTgjFR/OceX9dUK65P83/r17Pb3WXxiXPokzaG8psWwgutPp+nOgLE3I3ups64YzYHl4B7JWUg9JZZmonsiVE7E+IzxG0vYkeMtR3UiKsTQxqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rM3vujkw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rM3vujkw"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-242d3be5bdfso280255ad.1
        for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754928379; x=1755533179; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b4XB7rbDMRDvsKK6fD02IRXzMhRU39sjlSTEErIcNrs=;
        b=rM3vujkwwch/fOckHaSSwk0iBSRHizMmQ6SNtL90ecw4wqnKkpN1K6GzZMkV0K3kqz
         OsM3noD45sglL9HRZ5pbFDlUnu927KGQ9l1CSTHZRl8xS5M7WeBzTf8C31XYLIUX6Ypx
         JPdVBR6aYK3zOnWM5Db7xtHx1+bqGIKQ9zM3eQDfbD3og7AaRlUvnPblAcTbaPLT61r2
         bjqEOSK6pfRSzyS6MGyOkZNPYGjR4jnCLih5FFOXq9YL1tEDxK/uvdLocSqYirnIbzqm
         HeeJGcZHq4qLFg/ZgLGk9GLJlc68X3Va3/hICc8l04dBSKBdgDbObKVtVTGFb0AxigEw
         YKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754928379; x=1755533179;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4XB7rbDMRDvsKK6fD02IRXzMhRU39sjlSTEErIcNrs=;
        b=FE5vlqDConxXmLcF+bM/NdWhsl0SCrI2PQlwQzA5xjDxo6AmkxH3rIunhdRlimRp4l
         DtlHtWa/bfLzt18jJ8pYtsVGUIotK4sMbBLxZhfYxXe7k7q8CzJlV0AOJli9IztDZZS9
         zumo+AlHQITXU/4ULECXL708ZMBXFEe8/TKsHvk5moxAH9r7d4uod6VD2ZOOm1opFd7q
         99+14qRY8hmCHNFLmMhdjgSvgolQSEEvzy1VP9NopymdxH1VbNWc8DFrFfoe6X1LqTrg
         9kBaUYIjtAFBUXNHxuaRgml1XYxwq+UR1iIV25yE8JyAlmkbRLHeJGcfRnqnb547dfx/
         cHCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5xj5Mlwh9YJrcWl8GUgT99zqAjLQ1VyRpi/ipg2MNRR784u5gpmdjus/gtKDMzDANJuS7BSFiAJTNxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx17LOCnSPyKUW2qoPK6UqvKtR3UYgMC61TQSLKyw6rbjxFRk7E
	OZhkABYHs+aGdIFdDhR/J2h4Tz5n7/bi4efJjWhDcwyTuL0uyewUYEU8/u0/8j1f9g==
X-Gm-Gg: ASbGncv8VePHwrjBg3XQg/1iDRpxe1PzYwmgTymo6k1HHy5tbGMeYgt2YwxQLu25b8u
	5sQOokqaVgDp+gGtiK3CuOpAHCfcRpAbKUN/3JoXmJbJzT2LsP3pxOlMhs9PlQxdjJiKyNyyPwU
	Sl+exkWYwvooHhXSyFnM1d84L7Ld6l8q3nmC7S8JeFAo+ddGTBzMeKfqwIoaNN3PAp8N+pLfhWa
	zq7Qh8v4wRJssXx54xIW0k48hN8/V5cZ11mGqanptnOdsbt1PwK0wqCsVaY7eYc74Nu2Uf3jNbU
	K9wHzIFtlzxoQfV548OyepsL+dU4f+ELr1iUvedC4Gm/t4Yf5XSCfDIewDjzSGhnrBqr3u8BG2b
	qZb6jhcfWYsSNeC5vGIFjEt1LpRL6wiU+GOilppCu66p75uuRC/DUwdk0EOlCp1nLGmvF/bJoYb
	bD0x6TJIJwuAFafcIq
X-Google-Smtp-Source: AGHT+IHfX3J5jPQcjeR7PGp0tVsL7ZVLWcGPT//n+uMiE8TlGUsCOcJGCeSa/IqlMj8LeXBSgpTeEA==
X-Received: by 2002:a17:903:246:b0:23d:eb0f:f49 with SMTP id d9443c01a7336-242d2bc6116mr5965795ad.14.1754928378887;
        Mon, 11 Aug 2025 09:06:18 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:bf4b:17b7:3044:fe58] ([2a00:79e0:2eb0:8:bf4b:17b7:3044:fe58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd174sm27194145b3a.63.2025.08.11.09.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:06:18 -0700 (PDT)
Date: Mon, 11 Aug 2025 09:06:16 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
    Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>, 
    John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>, 
    "Martin K. Petersen" <martin.petersen@oracle.com>, linux-mm@kvack.org, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Qi Zheng <zhengqi.arch@bytedance.com>, Michal Hocko <mhocko@kernel.org>, 
    David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
    Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [REGRESSION][BISECTED] Unexpected OOM instead of reclaiming
 inactive file pages
In-Reply-To: <5905724.LvFx2qVVIh@natalenko.name>
Message-ID: <199fb020-19ee-89d1-6373-7cc7f5babab8@google.com>
References: <5905724.LvFx2qVVIh@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 11 Aug 2025, Oleksandr Natalenko wrote:

> Hello Damien.
> 
> I'm fairly confident that the following commit
> 
> 459779d04ae8d block: Improve read ahead size for rotational devices
> 
> caused a regression in my test bench.
> 
> I'm running v6.17-rc1 in a small QEMU VM with virtio-scsi disk. It has got 1 GiB of RAM, so I can saturate it easily causing reclaiming mechanism to kick in.
> 
> If MGLRU is enabled:
> 
> $ echo 1000 | sudo tee /sys/kernel/mm/lru_gen/min_ttl_ms
> 
> then, once page cache builds up, an OOM happens without reclaiming inactive file pages: [1]. Note that inactive_file:506952kB, I'd expect these to be reclaimed instead, like how it happens with v6.16.
> 
> If MGLRU is disabled:
> 
> $ echo 0 | sudo tee /sys/kernel/mm/lru_gen/min_ttl_ms
> 
> then OOM doesn't occur, and things seem to work as usual.
> 
> If MGLRU is enabled, and 459779d04ae8d is reverted on top of v6.17-rc1, the OOM doesn't happen either.
> 
> Could you please check this?
> 

This looks to be an MGLRU policy decision rather than a readahead 
regression, correct?

Mem-Info:
active_anon:388 inactive_anon:5382 isolated_anon:0
 active_file:9638 inactive_file:126738 isolated_file:0

Setting min_ttl_ms to 1000 is preserving the working set and triggering 
the oom kill is the only alternative to free memory in that configuration.  
The oom kill is being triggered by kswapd for this purpose.

So additional readahead would certainly increase that working set.  This 
looks working as intended.
