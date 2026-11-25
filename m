Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579097;
	b=XToEdFw2pWLAl+RF/7sobmLuzvCfBve0Sy2kSfMwE8tVfdDLDImti4vvvuWHO2gNtmwY
	 0TM/AtVFraNmXsf94jyIuVg+2Gd/zbbtw83Mzc2JAJCXAaY4lbCeTSWH9oh6yACftTBbT
	 kIXgzEggC0rXFbGucZdtjxjCY7vbTBmkb5UNRawv0taWuzGykwFQ607tcNOZt1ymXmpuQ
	 aK485aHsCKLS//UkSdsoA8lV9xJ+x7sUNoc6Cb2u5K5JRMvUFdMRwTUUBPEapTcw5zpk+
	 CJuozUpJcgfqlTl19ttLaJGvv0L0qdJqgnmMed73BPnOTJDT8uDFwP1D802DobOxsIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579097;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=w2GcGq8IeDHEJo2hhv/gnTH7TQqHvIsjQUqf1AKZb4w=;
	b=yPw3Wka3fcoBppwc2ot2DH7JzxvX8f77MOqh0xQDmIiRykM2Vh/X5Eiay7g8tBq0Dqr2
	 qW6v/yRaemknB9Qi7fvFxn+zNY8aiu1XmjUJ1aAZkMPub0Vm754X3iiz1l0Xl1PLVWCyM
	 UZ+T9uYM7B5b0fE+P8oOenmxWzI5WC0pztEF9t5BV6bSrI8dFQeE3KoCZJgZ2enFxIfcI
	 AXU1aqxWc5XsDMUhKTlBC9ODEom0f/JHEdRpOIsBvCUS6KOj19scRu59mZs027VzHh3i0
	 a3q8YiW0/ur+cvhELMsTZdWMcCht+VehgZOCaUI/FL4sJs4nmTPJWr4FCmBmsiGNJoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="F/1yAGIj";
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44300606A323
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 03:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44300606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=F/1yAGIj
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f0a0d1a1e5so13755405ad.0
        for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 19:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795579096; x=1796183896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w2GcGq8IeDHEJo2hhv/gnTH7TQqHvIsjQUqf1AKZb4w=;
        b=F/1yAGIj/vcfN7GxWSyHI5pxXFN0ejhz7qzfGjsqQHA2+2JR2IAaROcSBAfpzzzxWO
         BN9JFLF/x8m6OSL6w/5Sm5s73ZacJ1/WVYaZz1NNVZndrqx3M3F12apLSAuTMOBOLF2Q
         Y6k8pe6IEUHaGveiTj8UYrQXllDitfggHo3RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795579096; x=1796183896;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w2GcGq8IeDHEJo2hhv/gnTH7TQqHvIsjQUqf1AKZb4w=;
        b=D8t/O0Pycn9PWgb6TJyEg6Llkn8YHWnpLSmoh+ZcQ7/tDwYDsnracpdsnC1bO4hJ4I
         ASYyvinqudouD9id+Ig4LZI4t87ycqJveTOh+95qfxgy/vrHJMwOe5Hpy7R2QxrIX5kF
         1A1qm35cE6wSoGx9vj6HviOTGZW003SG1pBl+4O/wlxlqktj+WTeII1zn3V9tP8SyQmX
         ih6C1aTXnmF0fqn9LdpnkncqQUIfYZEOxedFOh+r8SiZl+ZyWhhk+Kdc4zraBQfd0Fzr
         IDZso/5n7Nx2NN30HCweyR8Au1m2bTB2dhm/HRmsFSTgxa63XpTXiLY+kM+msqrFKPc0
         Z2Cw==
X-Forwarded-Encrypted: i=1; AL+hErHZBuBrjkcmcERj5GkXsF3htlY6hcDPu2N2HqzeFPbyFe0NaU8WbFhD7N0SHBteQBtuzT7rQ/r3BAHuhw==@vger.kernel.org
X-Gm-Message-State: APuU4Z83kD8Fd1AoTHLfUJ0XobvXUmv5cvHfqq4dDzwNFsoPGBCUZwVC
	mNcKWUEYINyaCNIaBIuS5wOmVwlJn8gj3wUzPjZXAyBdG6KAlMaqValLiwfyA0Mz3A==
X-Gm-Gg: AZFdTZcpBOoLv/6TMl0WBSEjPylz3Nqc98xkLNrMLPwoJ+bE2JNuKAl4E0ja9GrD2T5
	p/JZXpjXxPQ4nhuUbKqHagLmI1OkCYFwRjcqPAVZ+6xJRkjYcHtjw0miuk5j00ov+05x+jkj0sg
	rup3NyPjIdpt/gZu+yQi2g/fRORHQtiUQNV3kzqYe9JLIly0WM5SyFtXJa+Bf1dvp/lAn5AO7sf
	Od9IXhlVc2PV3vHIBMJQlrdfILnSAK4Rx1QH1tBNbXWE/2YNab6Wmi85iD3wIB8HH9WlkrkOcZK
	NAkNm1nd1B607zII2+5UOjHkFgoN+dUwA5lDzEoXBci3oRE2kjmDfLcZufQXiIgudB8YABM0Npe
	h1jm55fiqzT+5amX7sXwmoPq5CAu/elG0E4elmJA/+0KVv4eBaz7WI6ZORaJRTkAbLgZhN9NduL
	h2kftNlskKyZKrMTuYztqXxCvgoHjyMBGEe6TbuRoerEZb18m+mJfeFzZY4PW/vv/oBEd2FUdbB
	HjJ1rSGxzJZzZdpIpxMFOVQM7sMkaJdCI3ktYQ2u2/IPJa8q/wqpRe+NUIPU1xnJd2vSEDhvIJj
	ctabFTit7h8JPdZHOnsQXN1fiissT1UWvEB/6YhTGnY79Q/SVK8kGaILAU21Kd6ElstiuA==
X-Received: by 2002:a17:903:2984:b0:2ed:e22b:77a2 with SMTP id d9443c01a7336-2f03f1ea587mr159665435ad.55.1795579093844;
        Tue, 24 Nov 2026 19:58:13 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:46fc:328c:bd84:94eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c2ad2sm77813365ad.16.2026.11.24.19.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:58:13 -0800 (PST)
Date: Wed, 25 Nov 2026 12:58:09 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry@kernel.org>, 
	Hongfeng Chen <hongfengchen@xiaomi.com>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] zsmalloc: free a zspage's pages in one batch
Message-ID: <awZcfYOQXpYLcZSp@google.com>
References: <a74aca7a3d27333972782b29786c7b33861a56f1.1795412161.git.senozhatsky@chromium.org>
 <CAKEwX=MJJVBfdE+LL-j+jwfkNP=OHaV21XLJxEOBv4XwsBLiiw@mail.gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=MJJVBfdE+LL-j+jwfkNP=OHaV21XLJxEOBv4XwsBLiiw@mail.gmail.com>

On (26/11/24 16:16), Nhat Pham wrote:
[..]
> [...]
> 
> > ---
> > +       zpdesc = get_first_zpdesc(zspage);
> > +       if (get_next_zpdesc(zpdesc)) {
> > +               free_page_chain(zpdesc);
> > +       } else {
> > +               /* Single-page zspage, e.g. a huge object: nothing to batch */
> 
> I wonder if it's worth keeping the old logic for incompressible case.

It does appear to be worth it, it's visible in profiles.  Batching comes
as a win for multi-page zspages.
