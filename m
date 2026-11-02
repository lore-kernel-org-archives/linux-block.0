Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793585366;
	b=KA1EsC6YS84ta8bnEuxZHf/yi6VaOPgoc3mFfZF0KxDt/PY2VsxDFyoc2l81tsSO949U
	 u/d3Ax/ueIGoL59QlaRx4rwdE28klofc6pCWNE6SH/cxPCinzVktwiZwCYldPHWtQ7QZX
	 BMz8yfhHWFAhvW85PGO96veXrrtUREUfq7YrtCcyKVqgG4DJbMe/Hqmxj0d/mqqlRJa3a
	 nDubo5l0TG9LWZo9mbjlHolPK/lP6yXmqSjszr7QgZpODr9xvSwPts6HbiNb6RM64Lo87
	 MxqPN+MpftDz4fUSi8bWioGnYR1vve4TCiEzqKBeRANOIyCWtSrEC8u4CKYH6BPMCwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JM+w6aBnc/6mcug/U+Sf72nhtCKL0cl1TGwbfpZXBto=;
	b=RdnM699cByj36SCGDGXOHmAVVh7K5Kl9qvHvvqAlrTpclP4mJf48lG7tHryDvuTIzXf5
	 o5KB7uhwNBhmSwrijnHsjiF2sTjfC0a3Cya+l1hhHTSZsz6QN6SwXoheZRabZdJs0vhLb
	 8t01ShDgOrD6etDwlYCyyby1FHM5+PI4tvDpWK4v9ONYq3YiPOVqQKPZVijBfJSftiezl
	 gGIuT/sHkKldRzBi8+ib06O1PbdkcO3QQcoLwINkLaCW5gSLBv7rXdAWJHzswxN1/B6YN
	 vQswABQiHo2HW1vIFPj1Hdhe6CkR4VJFYAWSSAllaPWmURf07FvXK/GJ4Tx75PbnSOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xLli9ooL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF054606A327
	for <linux-block@vger.kernel.org>; Mon,  2 Nov 2026 02:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF054606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xLli9ooL
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36a6b774d12so61524eec.3
        for <linux-block@vger.kernel.org>; Sun, 01 Nov 2026 18:09:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793585365; cv=none;
        d=google.com; s=arc-20260327;
        b=lBswrf8CO30g6WGs1/v6ILOS3El4Us8DO+tJ8pKSMVqlfZvJmZRVT5GKmolPvICjeH
         c1A6w6cCfBgqgMxeA+wSw2fqaMoPLhxM6gZGVPL0xs7/yMTz9kcdp7LbTafNJTn3L48G
         rWayaEyAv5FS2DTsH1RbdYYUWnwE0EVDULaMBZUA0TG+eRHEV4C17MHcIpxXmcu/D6cC
         BbcJnWApOYMGTZHmEdnkq7ijIhx+5FC2iWHqi44d3AYn5fYt+JEgRJwnR3/PgocVMIP5
         CT5RC60BUysC5eU8e5GFmWEc0W+ALW7TsDcQZYfCyHWSxu2iTBer7UPlgqit/vt1t0b+
         +lPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JM+w6aBnc/6mcug/U+Sf72nhtCKL0cl1TGwbfpZXBto=;
        fh=pUUbLGwdGgedkyQnJM6JtaijKxh4jfMyz7SNifNywac=;
        b=UgjceoMeiafTpAmOdTUV302MtNI3Im6WL1G0Y1S80k64I74/JRtua2sndBG5MxndDQ
         JxndKTQQa4D9dxbfWZwhoR655mFnrcmgQlxHuiV+YIS+20xK0WG4CGQwzKtBWvJZzwa7
         UK5c2HTqWofMxxHkUU4QYYG4yBbMGc0or1gmzzjkf7H019oLKDj55U85go33QZgBM6EU
         7Dp36rVVhBSRR7O0s8+Qx22kWveJMAFeeltwGN+uA63blXaH1hiJRy563SPbQ3a8Uu1q
         9KLSCC5XvqNrm0bBZBHCfDyEqBADVt2gcGpJ0fl4wG3i26Vl6uyY/EXMpt6TnAB7lBLJ
         rlXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793585365; x=1794190165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JM+w6aBnc/6mcug/U+Sf72nhtCKL0cl1TGwbfpZXBto=;
        b=xLli9ooLhzieBA7ShWegrKHg7wsQlkXwGdZxFt4Ehnp8tKPxxEJShw6Vd5tIKTsbaV
         1YnzdlwFEmRnrgn0AhMdBFet7R6GVJ9ZDs6oJIyCzVkVyaC0GFZKzdh6VvbCaZTRjPzF
         TLI2zjZBfGs25VnHv8pszD23F7dFRTR2OCZ8ezOnSK9AC/Lvo4Cq05MxTICnxPp1K1Wq
         8nQnrJ66XVyiZ9ikzfKA+7KWcZeD9mlPz52kfEqAAjvGi1tLG4sjNRCGfHKZZl8dOgJz
         i4ar3liEMt8MTMo0h4mptYCaLpR5HBLxabA+UsOzEjpCLJ7MizXTqNZbMx7vKTeDBswR
         kLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793585365; x=1794190165;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JM+w6aBnc/6mcug/U+Sf72nhtCKL0cl1TGwbfpZXBto=;
        b=q4Is59vIo2yiHOhg43tjoh2ThfK/GqG/apGYOgHXWn5ors2odaHybnua+ZP+pz3yuK
         0sG/1x1lYM3mPaG2N/F3sxqM0MvJ96WKE6bPcHC1MUKsIYLxEhxwODPRGKD1d9vFhKit
         mOLwYTQM8k5zv3wcbqAttQMl6x7TV4pAOPpoAueJ5E2cod6sKBrKALZswz+TcS7HO/Al
         WGeNiJ/LOrdopIOb40TULCo/DlIvZsRjIBLUWch32ulnMDLhg4PcrmJikLDZgBWWPLcW
         pbqY9FYQYInBL8YZ85liNjtR1H+8bxz9bbWPzQHRRg0ZEpOzN/CUEOir9fITN0gwUgJI
         73Ag==
X-Forwarded-Encrypted: i=1; AKwUvByGu/xyTv3sgXOQMQGbYDKScW6U2bvlMX+8gvnaPDYinZM5NVs1od2PplalLWdFuKMcgu4L/OlVYpjDEQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+N7qldTlZ3XPfWMkbu6W3X0ngpaTv60M2BXI8383NEn6HteZOj
	yUD5DUr20cjSz/DG4wLRja1CSbV/R/udz9MWOmvYMp6LJL7PsgolkUHnnQ2f57+Jh8mdDdpOtVF
	jnFvtNreA2VCCSEaHCZq6o2USHNv0x4Q=
X-Gm-Gg: AYBFou2NZfX2AoCQIu/eEaSZoxlKvz1HlwohWM/QKkCn3rUSPqICyxHpkqHxPnNdJxP
	98SV6z4dqkY9ekBw7UShl2jivhhClb48s5dEXq0aGEgWJL26nwpWwiu8KYdIGE9hcJ2qp9uRH8v
	x5KP8c2jP1C6D+t3T+iGotKK181QhPNMbm2NSQj+U1/3SY80mfti/TW4FYL0vAzpfjh0uv3SeCm
	m7N9CdSLifB0tmiI9+oLQNFVWq/fSttO4EhQ+68nNlt/2Gws06LCw/pYVygcc0XrDqr4O+u+hdu
	e34Gg3mnc5LNRkeO8PggxsVsBhpNw5lurXYiHg7DIZCGX4rW7ufhiQNKLs5Up5aWldI3Q4ywg3l
	aV9uWg+eNQwtwXXCYSj7ixyZYHHa85Y/YknRlM00StpCU8FZ4JOlF1LR3dnRWpf8CLZlWZVHfuZ
	yrbb19iwqCJ1Ub4urVoRGJ5/x8TX7gHIVZHOW26n4bajEGxjjSsd5OmYlk6LaYbQWqIcqSqQrW3
	x6oGXsBmgQM0HPGIFjci9lHrkpuJCqlsrgA
X-Received: by 2002:a05:7300:d090:b0:36a:e7a:e89 with SMTP id
 5a478bee46e88-36a4239cc86mr20960721eec.2.1793585364848; Sun, 01 Nov 2026
 18:09:24 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <27b58e47-723b-4d67-a1f0-ccb8b0ae66a9@kernel.dk> <20261031152846.746656-1-sashal@kernel.org>
In-Reply-To: <20261031152846.746656-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 2 Nov 2026 03:09:10 +0100
X-Gm-Features: AclHuK9ySQ6mOkAgL_UJrSzXhdUVu9i8QnIVYFXWb_u0s7kLFxls3StjHm71adg
Message-ID: <CANiq72=jdQdNeTNoSxnMGvQ9URQ7yJjLWceYiB1ZcbpoYxj7wA@mail.gmail.com>
Subject: Re: [PATCH] rust: bindings: derive Zeroable for bindgen's opaque
 array wrappers
To: Sasha Levin <sashal@kernel.org>, =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <emilio@crisal.io>
Cc: Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 4:28=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> bindgen 0.73 emits the blob of some opaque types, such as ones aligned
> to more than 4 bytes, as a `__BindgenOpaqueArray` or
> `__BindgenOpaqueArray<align>` newtype instead of a plain array. The
> newtype only derives `PartialEq`, `Eq`, `Copy`, `Clone`, `Debug` and
> `Hash`, and the `MaybeZeroable` custom derive does not reach it, so a
> struct that embeds such an opaque type is no longer `Zeroable`.
>
> `spinlock` is opaque (see rust/bindgen_parameters), and with lockdep its
> blob becomes a `__BindgenOpaqueArray8<[u8; 72]>`. Commit 71ec3c7d6db8
> ("blk-mq: quiesce a queue that joins a quiesced tag set") added a
> `spinlock_t` to `struct blk_mq_tag_set`, so an allmodconfig build with
> bindgen 0.73 now fails:
>
>   error[E0277]: the trait bound `bindings::__BindgenOpaqueArray8<[u8; 72]=
>: pin_init::Zeroable` is not satisfied
>     --> rust/kernel/block/mq/tag_set.rs:41:49
>
> Which wrappers exist depends on the bindgen version and on the opaque
> types of the configuration, so they cannot be covered by unconditional
> impls in rust/bindings/lib.rs like `__BindgenBitfieldUnit` is. Derive
> `Zeroable` for each wrapper in the generated bindings instead. The
> pattern allows for the spacing of bindgen's output when rustfmt is not
> available.
>
> Fixes: 71ec3c7d6db8 ("blk-mq: quiesce a queue that joins a quiesced tag s=
et")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Applied to `rust-fixes` -- thanks everyone!

I can send this to Linus in a couple days, unless Andreas shouts or
Jens prefer to take it through his tree for some reason (now that
v7.4-rc1 is out, it shouldn't matter).

Cc'ing Emilio as well so that he is aware that this means we are using
a regex to match the source code that `bindgen` emits, which isn't
great (fragile etc.) -- you can see the context at:

  https://lore.kernel.org/rust-for-linux/20261031152846.746656-1-sashal@ker=
nel.org/T/

Cheers,
Miguel
