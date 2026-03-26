Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAD92DB7BF
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532739; cv=pass; b=G5gRRKu9qpjLAgNO6fWnWM9JrNvgOchzTTKpy5/+FzmYW71QdvUTSuyrdphqqsVu8Aa1rzviIKtC3L1IbV0yrk8HYXOez8MLOnjk4VwLEdiibIpcjaH3ffBsytCJ29TAXhp1yAROQj2DTcgDtE7e2MmSmuLpydmxOvQ62qmDHbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532739; c=relaxed/simple;
	bh=/IpBYyVL9HvPcm43E3yQo2TCjyXHBQsh6m4UNgtUnH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLPzhswxivMSgdx7AaoV4kBT0Dmi2o+E5roo+AtMFFMe5QBnLjjawNaS+JHQISBNddwwYeQUALQNqMS6GKnNOItxeLCIdqnNnRc22yJXTpBFdkWmwA14ZWGaIfVTL15ZvTuVfkHwVK39nLnFonrj2caI2WKIpdLrndEzc4EwPkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JdBcuyQ0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jM+xKEcR; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdBcuyQ0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jM+xKEcR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774532737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTimboBJQQ2xN7bbA2vn6JxnGMI53LWgNaqdDkUrhgI=;
	b=JdBcuyQ0y4tTjV+rUg10TEwepsj91GU3RI+XEL2Cfk6Nu7n9exutQg6h33hFWItYckzRKs
	TKmYinJHzfzQsKOFZYjFioDRjv164RgiY+vV+vpb/3iaKAG0Llwg+1UgbIYpkUSxS3nuTI
	qRZF4MNipOHZJK8MjtzjKunNqQHSMsE=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-15VQU-JNOoeDfQPfzcsxRA-1; Thu, 26 Mar 2026 09:45:35 -0400
X-MC-Unique: 15VQU-JNOoeDfQPfzcsxRA-1
X-Mimecast-MFC-AGG-ID: 15VQU-JNOoeDfQPfzcsxRA_1774532735
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-56b7252fd7dso6262203e0c.1
        for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 06:45:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774532735; cv=none;
        d=google.com; s=arc-20240605;
        b=B/y79+CumlV/O+Ozyub03A0f5sBfN5az4gq9sqjO98JTxr2vd1y1D1Unvth4hvkQqG
         6VtxR4SH0PFW9Y2BUUIvkfUMgzB0eukNZHtgY9w77xuj7cpR8RW+Vib5oQkUDqN1pTun
         FZdjQHCYfeXxVb/mZXf+yx4JP6PLxQwLIcXepiSo7xu5MRabdtbwG5ihEaoNp970Xq9U
         u1LigAmjFMGIxCJ2XpIkyzcu5GKTWYrRDjRHaawDjW+yidewjYkVrN7oswjKua53G0oh
         I6qEyiOd7gPU9HTFUEi40ExTJ8PXyTmEKbvLwJVVfx2M23hEij5CaKTtAp7igbgb2CYj
         LwTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DTimboBJQQ2xN7bbA2vn6JxnGMI53LWgNaqdDkUrhgI=;
        fh=zje60Ue8WN8q6U89qeh0OU5U0Lau8UM5sZVnNFg9eM8=;
        b=bPwNxXmmq/ZVMKj/1GcJeU4rDw2ieKCoXBa+s/6e17NkIQ0hKRHrimSqZKfboRFLGQ
         KOaGrVNKre1yHxjnGv0WcdKl0YSq1iGnEJ8vFa7w0maOg9VAfcWtZmcPbhND9lba1SMS
         ENdmAql84JcZpRo8Y5J/6lGqB0XZpy5mfFWH9FE4XtMYGxwNeSc6OL2dzH+5zovg6kyp
         i2xb0BJVjow9QG5VYt17FYnpq+Fx7ra/aQHXsi0Uk1lBwlDFD0QjXsydONoxXuBLPVHo
         YUQCyY5Mhpt7u5GOYp08OrCwEHNIeWpJR1eU4XqXKJCV6uHCWYDLgFN9Jw/cNXK3MHdZ
         bvkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774532735; x=1775137535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTimboBJQQ2xN7bbA2vn6JxnGMI53LWgNaqdDkUrhgI=;
        b=jM+xKEcRi9Lz1UmdOxw7hFB1hSx7FOhzYH7zEQyY4U2lRMHA0II5HTSoRqAUtGYVDO
         WodYl/y9nwuNPorGpSXY0e13eRPqY9E154bSGdbSrdZxiReFqi0by2nXZjy/3uwV4QNA
         YOjugJFO/IPblQm9qmD/wvlG5TrkFclD4XG1gSoKWTP069NmX7wGMkwhMlxEOYojhf2P
         CnPHaKb8ciHB+a4NW15PCsiI7ApsV2rrnYEv7dF0bz4zpihNEOIF2u6sb7gQjpBIjiTR
         JlnVnSCIi1y7VRgcpM3PBYGV2L8FrW20O8QOHRbkQTwr1Rmx4V/55cerwcpwWe3z/a3/
         kz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774532735; x=1775137535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DTimboBJQQ2xN7bbA2vn6JxnGMI53LWgNaqdDkUrhgI=;
        b=YKx/+/LGtJZWa6VDjNYJjyz1jysi8UwQKJ9eP/AcoCR2s+EwrXy00eUqA8/2HK/lIW
         tEhkLeX80rVCVEQkXCxCLcW+4kZ7qFnhgXDEveiCZpvnBbVHtaabpJI/kA5rPXnzhaw4
         HaXTalHLqYM/r6VYVfniuM3qS1bM6csvUp+b0oGO7BFtpSyLLldK1/izmUtcAjn8A+GN
         Bf1QSh6qDqhJC5Y8WJO7O9tMFR0LtZ4R28ONEB4bWyGIJda8Ar9AM/3XZiWECeQ6AtYP
         YB/I/GUaP/GTonUXrkP2lqIZU7Fg3tSQNO//RwX34k4EDsKMLj8+RG1ZAF9eeeGcplVM
         SbBQ==
X-Gm-Message-State: AOJu0Ywf3+mxHIX6CNgtMbHpYYl+R4hZCo1LKMzh4A8oWC5K/bdYOuLY
	9TFzuwyiw7eXLttP2A6T+6YHhINjMh9jKGOOpKYa1gxEkXcnOVFNpGw4tNaeYpsxHzwTk5DD+7V
	YI0TaBizCGInm+YT+hKwHhwq6afeUmaGAxZd9bvlwQp+jKWfU/4zD2o6eMYGxfapt+2aPGPS6wI
	hTqLBbR7xw+Z/nzETm2uNUwCO5D/GYrG0wyYYfsig=
X-Gm-Gg: ATEYQzwBR5f8ZzflMJSlL+PsH66E3HNztdH92VmZM6K50FmGEcIiLBC+O8EwFgDHXqh
	xSpHfspW2L/nmBHAiVmzOTz9ezTyesj/Ma/TqriM0vuYSj7cq0tz7id3T5EgzL/90X3cDr5aAtp
	j2g0gYIsImyiLz6UYbyik2/G4QiGhflu0Mt10fiEZD6cwAEHWaWHvKfc4ofhokbEIX34LhtbM1o
	JWasLepL9IulgxIAIw1Bwb/rDz2WoYrIfFgW4o=
X-Received: by 2002:a05:6122:8283:b0:56b:72f6:1b9e with SMTP id 71dfb90a1353d-56d3d6e4d87mr557775e0c.8.1774532734701;
        Thu, 26 Mar 2026 06:45:34 -0700 (PDT)
X-Received: by 2002:a05:6122:8283:b0:56b:72f6:1b9e with SMTP id
 71dfb90a1353d-56d3d6e4d87mr557768e0c.8.1774532734311; Thu, 26 Mar 2026
 06:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324090052.1782766-1-ming.lei@redhat.com> <c0c9becb-7ec7-4774-99f4-a265f53166e4@kernel.dk>
In-Reply-To: <c0c9becb-7ec7-4774-99f4-a265f53166e4@kernel.dk>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 26 Mar 2026 21:45:21 +0800
X-Gm-Features: AQROBzA4wLMKdCUBht9HDO_wqDz1zySGPCCVrxJoXrRfzROAAlmsD-y27s6oN2U
Message-ID: <CAFj5m9++xK4dS99+cukn5QvH9YaafHUAYnnb-iou-9ZUf1t+Tg@mail.gmail.com>
Subject: Re: [PATCH] bio: fix kmemleak false positives from percpu bio alloc cache
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 9:29=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 3/24/26 3:00 AM, Ming Lei wrote:
> > When a bio is allocated from the mempool with REQ_ALLOC_CACHE set and
> > later completed, bio_put() places it into the per-cpu bio_alloc_cache
> > via bio_put_percpu_cache() instead of freeing it back to the
> > mempool/slab. The slab allocation remains tracked by kmemleak, but the
> > only reference to the bio is through the percpu cache's free_list,
> > which kmemleak fails to trace through percpu memory. This causes
> > kmemleak to report the cached bios as unreferenced objects.
> >
> > Use symmetric kmemleak_free()/kmemleak_alloc() calls to properly track
> > bios across percpu cache transitions:
> >
> >  - bio_put_percpu_cache: call kmemleak_free() when a bio enters the
> >    cache, unregistering it from kmemleak tracking.
> >
> >  - bio_alloc_percpu_cache: call kmemleak_alloc() when a bio is taken
> >    from the cache for reuse, re-registering it so that genuine leaks
> >    of reused bios remain detectable.
> >
> >  - __bio_alloc_cache_prune: call kmemleak_alloc() before bio_free() so
> >    that kmem_cache_free()'s internal kmemleak_free() has a matching
> >    allocation to pair with.
>
> Looks fine to me, but can you please do it against for-7.1/block
> instead? It's not a huge issue, and I'd rather not introduce a merge
> conflict by shoving it into 7.0 if that can be avoided.

Sure, will send v2 against for-7.1.

Thanks

