Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8ED3939AB
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773662541; cv=none; b=k+A4TO+hkwKj6BR8Ijnwxab3869ykaut0t3kPvIsggfdPeCk5C9NoQ/MW3uwBDTCPepJdXjgg8/4U/kZ7f0yTUyr9lq0szehMMDyAxTjFbUYARGuS8tdsJeIQlgmeazqM0FFDikIXCafvp9sn/WhXQybA2gryvR4nzOW7eLFBEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773662541; c=relaxed/simple;
	bh=763wC3RRPxIsptrmNPCWXS4C9poStXcpGsCSDU2gvlQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U1n81eFSbpWjfGkacoKhxAa15sdLllPPmRp7LSHD4T8ZpIGE1E8MrbFs+XRT75NBx1nHXpFn2CkCcJQdHh2lSBbJ6DyfKIl19Oc7gun27huy0lZQwFBOU7ZzncfErCTpj1nj8vbNAqVSVNZ0p95hnzB4B+EZXCiVXOSeHbcWu+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wF+QsSY/; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wF+QsSY/"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4853ac455b2so42994525e9.1
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 05:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773662539; x=1774267339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UX+URBpTt60dMhGkY9Id85Iw5Xtu00SbMnwBlBMIQ14=;
        b=wF+QsSY/GQEgB0KYucoeprZCajrScL9vnmSkDBafohk5snzh9c5n/hawYgI/k+MB1B
         /Pgt2z//Y2bsHpclpB4ewebNbslyjK24KrACWrZcr/8172tv9mwnr492CTEBO3xByOlI
         QeZwFk/JYx1FA4VQqYDjlxnPzFm4tgzj/UBDQwlwBbems5621c8da7oyNgm9oEscDxLK
         nuFR3dE3YrGRnStqmu7pSdJkHu2GAQuoIqrn+EkmBnv6NK64Dab6i61iQwR0EbITIFY4
         UXTU6y0A9FUlxABmJ9q0K5uS6MxEPGkN3wEoUc3oF0sPCOgM4kaLRaL8rb6hVaghQM0e
         Vw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773662539; x=1774267339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UX+URBpTt60dMhGkY9Id85Iw5Xtu00SbMnwBlBMIQ14=;
        b=X1oSnpQ3piHFuOGu0nyF7NyHNGThPLtldM1xDsb9EvpUeibbxJlGNfDkt79dQIdySe
         SOhAGxPvRBNsXb4oB1/LRTIabq/tHMf1StCIE13+X5F4Qp33Y55w3CkL+dF4zKO8E/KM
         u+E/TAbj0FZ6TNxNXy/FfBHPfoQYX6sDPurj++zcwHWiH4rDnyNvcY70CAAT5I4MXMqQ
         xnb8CzPqv+4ePDrjwInqRISfSr1exNtB6mPavS1/l/rlXmoM2c2+IBBx5pLJXVgGmWNm
         c20FBxJAfxkY0qbE4np+m24nLDnvIzP7rTQqjflXZGwsfyHRSpaM5s0apwoQBH8syG6g
         N+7w==
X-Forwarded-Encrypted: i=1; AJvYcCXvMh7d4BTsRPskc/A+YzZ3ZZnZd0qYj5adwHetrPLNjtqJtNE2v2kfx3AgFxAafdpn9iPb5nnrsLSYHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKcUjjzdM6Z2r/Kmp3XUwe9ArmwCwDisFZQ8YnlcYh+FrhvmB/
	Q/7mKMMd97ePSXXuKzFJzys084HblSy8rdbaMKZlhTbW1s6crXJ4VSB7JGKJY3HhvK+gUaQmF7D
	jR/JSLtp46vXHf9KMzQ==
X-Received: from wmi8.prod.google.com ([2002:a05:600c:208:b0:485:513d:66da])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b16:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-4855671e83bmr211989475e9.24.1773662538650;
 Mon, 16 Mar 2026 05:02:18 -0700 (PDT)
Date: Mon, 16 Mar 2026 12:02:17 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-26-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-26-de9a7af4b469@kernel.org>
Message-ID: <abfxSTL2qTMtpnY7@google.com>
Subject: Re: [PATCH 26/79] block: rnull: add badblocks support
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

On Mon, Feb 16, 2026 at 12:35:13AM +0100, Andreas Hindborg wrote:
> Add badblocks support to the rnull driver with a configfs interface for
> managing bad sectors.
> 
> - Configfs attribute for adding/removing bad blocks via "+start-end" and
>   "-start-end" syntax.
> - Request handling that checks for bad blocks and returns IO errors.
> - Updated request completion to handle error status properly.
> 
> The badblocks functionality is disabled by default and is enabled when
> first bad block is added.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

> +    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
> +        // This attribute can be set while device is powered.
> +
> +        for line in core::str::from_utf8(page)?.lines() {
> +            let mut chars = line.chars();
> +            match chars.next() {
> +                Some(sign @ '+' | sign @ '-') => {
> +                    if let Some((start, end)) = chars.as_str().split_once('-') {
> +                        let start: u64 = start.parse().map_err(|_| EINVAL)?;
> +                        let end: u64 = end.parse().map_err(|_| EINVAL)?;
> +
> +                        if start > end {
> +                            return Err(EINVAL);
> +                        }
> +
> +                        this.data.lock().bad_blocks.enable();
> +
> +                        if sign == '+' {
> +                            this.data.lock().bad_blocks.set_bad(start..=end, true)?;
> +                        } else {
> +                            this.data.lock().bad_blocks.set_good(start..=end)?;

Taking lock twice: TOCTOU.

> @@ -118,6 +125,7 @@ fn make_group(
>                      home_node: bindings::NUMA_NO_NODE,
>                      discard: false,
>                      no_sched: false,
> +                    bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,
>                  }),
>              }),
>              core::iter::empty(),

[..]

> @@ -155,6 +160,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
>                      home_node: *module_parameters::home_node.value(),
>                      discard: *module_parameters::discard.value() != 0,
>                      no_sched: *module_parameters::no_sched.value() != 0,
> +                    bad_blocks: Arc::pin_init(BadBlocks::new(false), GFP_KERNEL)?,

It seems weird to construct this Arc in two places. Is it shared or not?

Alice
