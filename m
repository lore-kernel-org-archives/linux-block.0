Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7BD41D63B
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203929; cv=none; b=Eyz5w6yov7wtyGqMqhmS0ZZiYXorv1a7MTfFKHOT/qg3ulF0Kj5o0/f7zJ3BOl5Un9Aku5CRBB79NispbAjEF5zLQY3bbt4FhA8MemIythxF/w0yBlgf4dN3Nudk2StL55ygaURoW7j2Jk/hFlixI3p1LJUudhb1PLP0KYHtx78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203929; c=relaxed/simple;
	bh=Kx5nygWqTS8oJ6N/+ovL34+aA0A1jag0eHoc/auPpgY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SaC6JRu+rw64QjGcIl4Wm9A8Exl05cKHFlsEFG1Fkc++dLfSReSHe0n30lfrsNQ0PYEk1K7HHnzsoMjA+nm6u9xJ2zvvoYDUYnSfxd2L2nmagBU96qmSf90M17Tfj5crlQ2v+oSLmMFFi/ZZ6yr5+1MkrGLiH/2L2adQKALksUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=ALxZsfUr; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="ALxZsfUr"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6a183eb9689so1849179eaf.1
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 05:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1784203926; x=1784808726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LdzbRgO9G82vBagiIQNu9gs7dextjAylQUL3RFHFe2A=;
        b=ALxZsfUrJSfS59vqMkuXOg9dHXmxpomUQEwHx+HSuh/4skqW9YgtRPIcDmel2vbUQf
         PdLIRDHWp8/sDUNlO65j5I7h++bAdXywTE5rhusV6Mx+9UNb9BmSFd5AD3Uj67QM3SeE
         JRRKHFf+3ejQJBqAcl2Z3GWdWTmMXqAF/gu7PCdmzE80OYl9xXfb3k0ueaJ3p6jLJqOJ
         WpiPCXC3OYv7LeWKRxo6VNsRVWaYiQfwo8FguzcgIozixRM9lrzzhteKjzTvBlWgEk4v
         xT0xApHGcYCu8ZgEyTWuG9IDfHkYTkMCZcOJKLrcdAj63aoJevvlWqx/8cAbEcju+aUe
         BlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784203926; x=1784808726;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LdzbRgO9G82vBagiIQNu9gs7dextjAylQUL3RFHFe2A=;
        b=maLUPIbKBG7KSvCV2rd6hKO9S6xYXekPQXHAqXJXfqVth0jUlJ+wQZYrrz1jUuKDUQ
         gI4xi/eYHWGwZD25fdUaSwvjF+cregtxFSTwIr9hifPpJ5bi9L61bkfuRBegHOrk7zGw
         nDcprZXq6IraCUNQEo4hLP5vl7oJs1gcnNqZ8j2fAS8bNeBCj6m5LbZpxa2Z45l0dNr6
         PWHPpvWS8MBvLJyssUNZsRdgT/EFMGdgnPEjdgEIJWbpWraKh8kNYiwDu6wUWF8YMOSB
         OLg1/xnfm1sRNfrCdlTpaEfbMg76pHNzWh5ahDsMPNF9w5+fTff2mSvwwuFuu9w6BOBL
         DvHA==
X-Gm-Message-State: AOJu0YyDkEkR1WNoDgmviZmli8EmZNzPIEfL043Pw6GuZI6fjeskmD7e
	Dt8qFpCnZ1mhgssIm+FZfjFzw/q+foGxF7u6RMBio7Lyr2Fnv9xwDLpHV0K8C3OeA0GAFjWxFOo
	dz/uGKwc=
X-Gm-Gg: AfdE7ckU8N8h6tALAEsNcDhi4D55lUHlwoga+jQo7UHd62pvnVORkh8lAkxExrzcSpy
	eFfrFvJH50c6u50XNgJVK+xNa0SWPEn3GuT7UVg0CeG5YWzFWi5dmBtIy0QEyiygfD6yYpux/MF
	gzbT0XwB4Y3ZuNjpWCS1oEfn0cyuPmYkVj2eLeNlAlVJ9SdyDfBFrwN9ATiyhkPNIEcLdfDvfKl
	D0YLvDZsvHCW8jUlEPJpLM3ny8tTg3nAHmdEKkhGQQB0nj/GFSLXsWm34KO4HRf1Ubse8cdL2JD
	44bg0VHOTv9yMiaSmkNyh4ffxQDqV17YYEKoAVWZnRKL4A9s2FX/E56Qcuu5A4ZykPGwTUV2iWk
	SWYL8J3qSVhjGfy/NkQO8rKpyhcsokc/9JbXFG4cnEBGzSE4jXX5fG55/YLs7SSzYlsjOKuJ+D9
	hTPt0nZZTYqWN2C1QkpEBEFCqtx9DYBIAVVhdZCVGiQNg5HuxwSenHxSs=
X-Received: by 2002:a05:6820:134c:b0:6a3:7a25:c084 with SMTP id 006d021491bc7-6a39a93f22emr12887730eaf.69.1784203925974;
        Thu, 16 Jul 2026 05:12:05 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a38a4bd734sm11627050eaf.4.2026.07.16.05.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:12:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Jackie Liu <liu.yun@linux.dev>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20260715073518.96042-1-liu.yun@linux.dev>
References: <20260715073518.96042-1-liu.yun@linux.dev>
Subject: Re: [PATCH] block: free copied pages when blk_rq_map_kern() fails
Message-Id: <178420392406.282740.3801237651207755584.b4-ty@b4>
Date: Thu, 16 Jul 2026 06:12:04 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 15 Jul 2026 15:35:18 +0800, Jackie Liu wrote:
> bio_copy_kern() allocates pages that are normally freed by the bio
> completion callback. If blk_rq_append_bio() rejects the bio, however,
> blk_rq_map_kern() only drops the bio reference. Since bio_put() does not
> free pages referenced by the bio vectors, those pages leak.
> 
> This can happen when the bio exceeds the queue segment constraints or
> when a later mapping cannot be merged into a request built by earlier
> calls. Track whether the buffer was copied and free those pages before
> dropping the rejected bio.
> 
> [...]

Applied, thanks!

[1/1] block: free copied pages when blk_rq_map_kern() fails
      commit: bd2df8dc72201f626d66ca97f2afc8b7f2740713

Best regards,
-- 
Jens Axboe



