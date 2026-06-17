Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC29F4071FC
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704895; cv=pass; b=iEet1bZQ/RLRavApK1DakFBbXtZGPbyXhAPDPB4HRLbDNvQAsuZ/aUyCOAiJ3njQzH0ICfva4xP9TzmbW2VMkkLVcZKMSCgHNrHjbszhmGrvGngD8xIuPg65ODXErcWrIE0pv6OZbe7IrQHZ4Jn2jK0nWDTPpqb/c/dPnLQ0asA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704895; c=relaxed/simple;
	bh=d+DJYMfAXmvlnPojeQcYjc2FpmtRtc93BPdBcj/yJ2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U25/oZCiuna8PR1779Gtv0Zzicr114t+/WhysuqSA6smUBtdYsQYAp0S2HOgK8whxNZsmSYnNhnO73DuKTs0eVKtlGKQ/tkOtT34ZuNcb/I/Iypg4be73o42lQTtNpEBdvQsNeoDbWLClsUvczEE4UzjJnpN16E+Q626fIhbBlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJJ7KIDw; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJJ7KIDw"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36d6bb38b44so3742519a91.0
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 07:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781704894; cv=none;
        d=google.com; s=arc-20240605;
        b=jBguPtBplEtvYUjJnTcF/br+bkrNqE7uD/abSdtoFbU27/+pfzv0IAdeFmCACpulsf
         P/UmP0yT6VvhTkl9ZOHAClVEC1ybg3+8KQ0RL0POjJP9gInrAumjeIi6+aEonzSlSx1X
         PZgb9DTr5mqdm5j0e7TJGMs0+HjC0kpncUypx1ZKzSMj0FqBAbSbS1mQ3JjP9VWvBEx/
         Tul6a5Ea/tJUng2C1tlHJ0mWj2e4dz3nVVlRMqnKzIYvhm/Or/aJWxMJjaTmac+mCHbf
         RWQHFYeSfdsIcPlW7pok29iEYOcxYhCS0g2+QzdclV8OHwiwx/WeatRf9UyRMxuJLyc5
         Zi4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tiRv+G39h+X8YKopQA1rD5KpEf5r1LXb2YHn926YfMc=;
        fh=l4kwHgI8I3kiuk87rsXLe1eeA92Y9WoDiQrdLdW3dQ4=;
        b=MP3XGxPae83sBwJ6lrXdjXh/Brhbhxp9GrCyE1SFYfIyJ3gWKch/qjQ+l73f0gQKKK
         pm1NfElYM20hxaLyFiqu/eVM4gGx4d1ENm+JNAEM1O2cLs+thaHEyoIs7r2CR7vqMxHV
         oVUN7hPOMsdz3eEN7TRzWBmwmRVm3tvMm5/DDOvpfzijDdZmis+2R99zwiOpicupWjaB
         QITYmkRpnm3XYjvPWzG7fEaaQjwtqjKtS7mo6eGema1pK1K2s7yOCawY6Mu7D9SkttzW
         3ZYjfiV+mQUt63dyxhanM7VVVlLHijyDvcQ9g0S4Ptb18Tjuavy2OEiqnJKiiivhuAQi
         Ig/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781704894; x=1782309694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiRv+G39h+X8YKopQA1rD5KpEf5r1LXb2YHn926YfMc=;
        b=WJJ7KIDw1dDQ0IFIaYfeceXa/3cRIOQR3mRU1e7nsrzWNXgAMDRUX3sMK7s9Yyi5ck
         faPDfgSDe4AyDQ2jyAdf6rOfJd8nywiH0h1DprjC58gEirhbZsL4DK4utX7XU6xx+NNU
         UdoRGeTz052ebPyT8triSFNpYVCVKIvgQW+4MMA88l6MQqXqfvUjXR7x1pMfrjzGyVzj
         LUHOlWg6WVFQRQQOTM/CThqtvrol55/lDWO8uojB1d+poktbgiH8iTFTLYEAtN13ZHNS
         O0sWn8gURpJQj/HcYW9DptxkxqBvZcVdmRgwy264A1wPbty31SC60BGz4X5z6dNZe8IB
         3RCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781704894; x=1782309694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tiRv+G39h+X8YKopQA1rD5KpEf5r1LXb2YHn926YfMc=;
        b=aqq99/dHV+MY0fiPfskF0E7DAA8upc9ISA7u90igcQ8uJRY5KWS5lo8Yn33a02+/jd
         o+PsJEXJDYZFwRYAvP6a5wPGas4JiOfVAZ5dgp/ux1e/1ap/s9g5G+G3qFCU3nANDKQW
         f3mHHzK6/QLhyAvyms/WI0VJx3r7Qrf9G8UXCOqXvAb547iXuKsxv3QPqq5wUI1QPSqF
         jHtfWI/auo1N0vZ7JdioTUPHW+vrrQWBeD4VWbMc6DvGuUdpCmQfoGzOMljuZzm4qQrO
         nATUCpgiHyrYCLLigDyKVgOz8wQc1jpGsi0BpJZ+wFsGRkCUApfuwdHqgJX80aDYBtPz
         Khlg==
X-Forwarded-Encrypted: i=1; AFNElJ/Jqgsg4IOSbdOh6vqIVHo5GsqHVl1npfDJK7QJj2Lgu6GbgjBeNKfe05n1iSf8n7g2barOhOvz6rrJGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzS/NAEr0+ByVvmB7iYw/j2ryLYkZcqFbNdahQ0Jc8b5fjBLbLv
	yaRKvJGdekktnJHbhfPtTNjhUvBWDGAyj7TS+UuD/NnpNMjLkSWb4a5NqTYD1Xj/A39oOdnA0q5
	MEfJ7YLMR8dE1FSbH6fMDDbq3KhTipmY=
X-Gm-Gg: AfdE7clqEAc2ybmZCj93tqfoT2DqlCQku/SgNO9wYu4v667bYVMPFMW3+Buw3J3OeWP
	dpx0RemrUwfs3kqw1rVoVDNRwBsUVEbGoEF/itc43IauFDvGL1W8IHk9DS7IuMtBgCc4HzR8TvD
	bKMqGYOPMluO3VRMaHZgusso9WZ/NHpuWw8nkZFZmm9PccbEpeqqwefdXxNOhwPEIZJY7Tt+1KG
	RL8Ze+vlIp3WfpX7yUuQ7CdJjGg0xNpEEYv99eyie+Yi/nmvxtlJBmCPfYjg/F95NIDcm70YF4q
	bxy8jM955rJaIqLH6H+5Kz6ZyA==
X-Received: by 2002:a17:90b:350c:b0:377:36af:c996 with SMTP id
 98e67ed59e1d1-37c947363e6mr4256111a91.21.1781704892396; Wed, 17 Jun 2026
 07:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com>
 <20260616123646.GB21024@lst.de> <CAJxJ_jhK+zkpjhs3YsQ9RoasKYh+E0NweQci0sPAEY1ne5LmBA@mail.gmail.com>
 <20260617061743.GA19844@lst.de>
In-Reply-To: <20260617061743.GA19844@lst.de>
From: Jianyue Wu <wujianyue000@gmail.com>
Date: Wed, 17 Jun 2026 22:01:19 +0800
X-Gm-Features: AVVi8CcmbYlKs19G5r-C0VfRk8c0vOg--A7ctAfStsGLM_YhFG6Fmldj3URh3So
Message-ID: <CAJxJ_jiBFUwqZwbE1XQg4oKM0XDrBzZeScvJ0PAUqusG0CObvw@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm/zram: route block swap I/O through swap_ops
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Youngjun Park <youngjun.park@lge.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 2:17=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Jun 17, 2026 at 11:38:02AM +0800, Jianyue Wu wrote:
> > Before I rework or drop the RFC, could you outline how you see that
> > core-side model working? In particular:
> >   - How should a compressed backend like zram or future block device
> >     plug into swap_iocb / swap_ops?
>
> I don't think that is the right layer.  The virtual swap layer that is
> currently in the process of being upstreamed is the right level, and
> the actual swap devices or swap files are just a dumb backend for what
> they higher level code does.
>
> >   - What role do you expect zram to keep while the legacy block interfa=
ce
> >     remains: current block swap only, or something else?
>
> For now we'll need to keep it working as-is.  It is heavily used in
> android and potentially elsewhere.  Once we have zswap fully working
> in the virtual swap layer world it might make sense to say never
> compress again in zram when REQ_SWAP is set (or maybe a new
> REQ_COPRESSED) so that we can use the core compression code without
> breaking existing setups.
>
Hello Christoph,

Thanks for the clarification.

I understand the goal is to have more common code in the core layer,
with dumb backends. On the swap path, once core has already compressed
the data, zram would only store it and not compress again, while
non-swap use of zram stays as-is.

Thanks,
Jianyue
