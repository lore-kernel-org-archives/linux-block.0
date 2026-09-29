Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C294FD7B2
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687670; cv=pass; b=OuzhdOB2XZNRkoURGIjPpk/fQFQyZsUDU9uBIXrSEFMTQ8LMit5L8siLP2/GQpfNu/w/xwskd6nEoFqOXvrHttEOwZJ7GNKVyX+ueaAKNIRThioFVsDzV7Gi3eVXheErC5s1FgNhpnlzKQGRcO0ldANm5Z0ppXlCast2kjSTssY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687670; c=relaxed/simple;
	bh=mc9ZngTcAoluBbUuX2lmbdpcrwmnX9oPwgK3aLjWg04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qk8pLfE8o8pa6rHnXtCu7DNICaH0IAPcLithjpd3lE5yCc6tp6BcNAtmAjCIkxNeXLZxIjMMPKauzW0jWaB7Q4rUkdxkdk6CXHJy/VZPeAZQEgyhUgUR+P3MCAgajYLBghYjkHnolqyQY/Xh2jBBK13qGoci7CdbnNW64rlgHrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCg4rfp1; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCg4rfp1"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffa15f67fso17932775e9.2
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 06:14:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790687667; cv=none;
        d=google.com; s=arc-20260327;
        b=pkEcXnIDODAJgwzsriF1LQGWJnI6CeHdBVD4im6jEGMWNjHMZvNXVsGBQSEBnEOGK7
         NPzAenQzePTo+uemHMIfAHRvWUiYuRTW8V0lGAUshAlCeSteUDAjd5eEuXF2zFsPK5L3
         AH2ev4fEquOQWv6Ag5PHbmlkrvvqLtfYalqwr9KNm1P6Il8cgDG47gmHsU3X47fWAWph
         O4rcI0rSgAp9flp5t5chFY9QcFbeEeFNyPWYU4TX0as+iFpTgVuaMWVg1jLcxX0n9ZAy
         0I+DDRxpITAbQSUUnIPDSvK1g141EABd92fRKH3V4tW337jX7dgB2ZARk3mjScq+9QHO
         l0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SYRpRMxccbtbpG1laeX3wfTBykfDUuE+jqqX7h3vEZ0=;
        fh=kLW4rnCFy7Acr0qdxgvvcEAD1qYXKmOZj9ELQgRpE+4=;
        b=MwvUkJJLoGCKRV4aWk20QrsnhC4i+x7UoIwokEfjsFSqwcWW79rdadpbTQSMU2BnSz
         qbZiy5BIbuk3MqozPD8gcCqwDZ1vS1iQ+baickoQtIP+bxEsTxzTpjgW8fgjHDXrM4Ci
         knw7WjqVouvcwx2owdcDUF7H29THVdIuqQRCmt78564lyX4v8McrAxZroZxCzN0oQO62
         rLaQktgGX9FZONlTNkikpzWAFtoxTuv+HsU4scQkaBHoptSsS3GEcSF0SjHU/ucJQnrL
         rS3lNuS1ypT/qjzXSN15+EWM4k4GhiSuZpf3899jS62vvUvTgM1WumjQ9SPZpqWakInO
         VZwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790687667; x=1791292467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SYRpRMxccbtbpG1laeX3wfTBykfDUuE+jqqX7h3vEZ0=;
        b=iCg4rfp14eSuBBOibIB2qwEDqX7qD8s2MEzh1y2AaasArYmYpvIeJXGhXNRMYFmkb2
         zuMGGQb4SGdrYm7nI4bg4/0ILMs/+6qhTny2PiYw+Gie0KPZWt9QtXLLRtlf5Hk0uA41
         T/Y1M4g7dLbSk5wVWRqxrTGC0hia7y2DBuFGbdzRrWWIeHFvXfR6XgP+/rojWvSpuI8+
         cVnTEMvUbJp8zYOUiVrMbC0cB8jMw7X+Q3bquNiYLmUIefX43lG9i/VsyuTCFPgU8Uw/
         kgqO4u+ZkZSsXWN6n8w3pw1Wo2ejmrwPDpkVTTZL8A0IyhYaFho+gZaDWO30x69a5ux0
         PFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790687667; x=1791292467;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SYRpRMxccbtbpG1laeX3wfTBykfDUuE+jqqX7h3vEZ0=;
        b=X83hFmqI6ghEwPzHtLo+IG9MZIU98A3PKmfqgc4TsKTL0t8B8aiJlzOyngbqp9M54G
         z2oXZ9nbSw75oxCu5aAYD1dMFTTu+j2T5CorM2zvLVNZIuGQhuWvyK2MhxmOp1hdQonS
         ImKFjzpDb/FiFeYrvZaYiE+XHbaiHOYvLFh6fOBv7+WrprB4PnnYyOPFH2boJXronMmh
         NnPOUv3R4Zhe/yITWHWkjrx3PO49ICyV2hQV2YPQZl+O1U4BX0MWwfuirbYBlpUQniwK
         V2qXe2Py+Vp/Xz5em8oIyADOwaqJHy3Pr5FyMH3Usg9rJh7+uw4Gu0MfNcA0Qvr34jkP
         iEOA==
X-Forwarded-Encrypted: i=1; AKwUvBzz2ZPEmln2VLZ7c1SfSdGnXCMhBwVBsAEs8KCWsYYwDtH0NmmCb3KALWVIX/dVUvJNRW8/DAKdtFbhPQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kyzygRZjc1G4gALJm/XqChQv/YT4A43sAKEV2XH9qz0c327h0N
	Cj7NllVYkHsNYx9/De6tgNn69C6bAJbKg7n9ho6vBQ/OTUs+AOwV1nqPjiTQJTUbFMM45/C+TxL
	RJjJjv7Ho/8X2qhFOzaqSaFABotmhZJA=
X-Gm-Gg: AYBFou3+ecJpvIpTKpvt3Vo7pJNUNS+BzdtPVWB+Ru9YEyVy9o0i4s2A3hosrHELMI8
	TyBCezDwwvKfMGwln4pZX7dHxHYIiIB7FOmdW3fLMgUXD7P5/b3z68qALNkl5i7MSzBetWiB/1k
	yACzERbOdSPQtxOFcbZ6ARIm0/hT0M6RiB0BE2dSfUYkQZvn2SJkFn9iiQbSlNaEaBhbtdICkyd
	oDyJ1vdAeU7TjQtbkquTyTwjVKy6q0Ftoj+DcM1oP1jyZnMoR77qzIfhihR3A8n9oWoJzBm728F
	aQx8FnvjBCacLTXBNZsv2yo4Vn2YgRfku3XxlJlVNcH2JOSKbGOsXl/7JqZWWPJpjhXyL1IS4Dy
	eBz+WpsyA5G3bgb/liMicmyQDcBM=
X-Received: by 2002:a05:600c:310b:b0:49c:ee20:e787 with SMTP id
 5b1f17b1804b1-49fe66c8959mr264819315e9.1.1790687666921; Tue, 29 Sep 2026
 06:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928081900.4187482-1-alex@ghiti.fr>
In-Reply-To: <20260928081900.4187482-1-alex@ghiti.fr>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 29 Sep 2026 14:14:13 +0100
X-Gm-Features: AclHuK-gHF1dvlctEtmdSR2RHiaD0wcMX6yQUH1GuqMtNTGrIvszFdFCGGkiTPs
Message-ID: <CAKEwX=MzVBTF46m6qBedUtpSgZFksRNonG6Gkw0kEMaCF17SBA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm/zswap: make shrinker writeback work with iocost
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, cgroups@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 9:19=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> We want to enable the zswap shrinker on our fleet, which runs iocost,
> but with it on, a large production workload is slower than with it
> off. Two reasons:
>
> 1. zswap writeback is REQ_SWAP, so the IO controllers issue it as root
>    and charge it to the cgroup afterwards, as debt. The workload pays it
>    back: its swapin and page cache reads wait, and iocost eventually
>    stalls its allocations, which in turn stalls the application.
>    Patches 1-3 let zswap writeback be throttled instead, by marking it
>    REQ_BACKGROUND.
>
> 2. A throttled write sleeps in its submitter, which for the shrinker is
>    whoever entered reclaim, often an application thread in a page fault.
>    Patch 4 moves that writeback to a per-lruvec kworker.

Yeah that tracks with an older experiment of mine, where I add some
manual throttling to zswap shrinker to reduce latency :) So I think
this problem is real - thanks for root-causing this, Alex!

I'm a bit nervous about adding multiple kworker threads though, hmmm.
Per-lruvec sounds like a lot of threads... Do we have to scale this by
lruvec? Why not per-cpu, or just a global thread? Is there any data to
support this autoscaling?

And do we have any concerns with work (CPU) accounting, from a cgroup
perspective...?
