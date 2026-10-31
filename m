Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.221.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793463482;
	b=5TNxmdwXidCtFI2YQf0CAerJt1AzHiaEo38uUKEitQ/YOjRCUMAgh5xTpaEYXSjaT9Fc
	 OZLzh6Iu/9/0/k/vivuc/BP4dMsKFcJLNE3o6BXRmyh3kHFMJqxpgLuUndJ7jJOX31bYp
	 OVvzT49OkMIGw3XSoTxvsiozdgjThNn9Q9CZC7GVvn5Cq5AOXzKvPpo1P6sKk6BtF6bF4
	 fgolxQRWNb9LnA0MVonX4AmwmqCyNRXYNIullDtrbR7buxspRB1PIch+aIEGEjKON2rqM
	 OMGsD35R8V+rN9JFGlCVJWM98M5Ing3CR6iP0N/f9pdjx3+HguJm4eGB8StV1Ve2Mfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793463482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=B1bwDfWXqtdtKzMUXXL8Xhn7s+stBQep1iI2lQ9nd7Y=;
	b=gNkdiOxF82gkWWvVjZlHFUwL6FT0UAaszKb5r1gDGxSI8cYLxqiA4YFzWHeYmw7B7KRi
	 jrl5I7+vgYpm8VtvVU1MCsQtr8mt00dGuiZkGJoV9RUfdjYSoH9DMAIqEJ6CAdE7vuHcE
	 ArFZgA/Ljeno0YzN4nE/XhJ92lEqfoCkGQRo+iucZbsmD4N2BZ9xJYkR/xZEVTW4U09p+
	 rv/Ku8F87iNDWOJJOX1nLBOKH38lL1AsKRd0ZGFhonRihC5S7eqA8zM0uAH65cMbA5p9s
	 1VxmHoWW8MyLWuYoeJSySVOQxUYYhZY2SldswMcNuxKq2x9a6c3ni0+L+PEYgjgtMFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fsyXfqZA;
	arc=fail smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4F6606A31C
	for <linux-block@vger.kernel.org>; Sat, 31 Oct 2026 16:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D4F6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fsyXfqZA
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso1187708f8f.1
        for <linux-block@vger.kernel.org>; Sat, 31 Oct 2026 09:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793463480; cv=none;
        d=google.com; s=arc-20260327;
        b=qJrfbfhADqMD/03Zh1NHAFylHHuOfEccSCR74vsCcX0tXhzejP9RXDTumyDpMR6q35
         QhOXRerlCpdOw5o6KunJmj12CdnMZhDNLJfIQzW+bVM5mkueyPh6okXAZohHSITqpAq6
         wEtM3OYCnPRjQ2lDeybUFdQEpYOGk4eKDGOSEOI5V68UDADlDvZLKZ/hEtMp0cOH7JRz
         yVup8UGpfD2yfsbDO4BW1f9SDKO7BQpc7FBrTQIgvyKPeyqlAVyz6e0qZpUm+JCkzL/p
         T7JWmShmJHPLPs6Cw8j64N2HPAn+cFexP2hdTeNnstW6VoE8Vn6zPVF/zmFCXw9dAn6Z
         sX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B1bwDfWXqtdtKzMUXXL8Xhn7s+stBQep1iI2lQ9nd7Y=;
        fh=kY2F+ZJ6qveeJXyttI08F8WkWv/2heABPaYqQgsPpiw=;
        b=jXZ/gDloqQEbonzu9Q6M0xfS/sOARXonGCtubeubqjwCV9mNsP09jk3gVwspRdH/cp
         SvmHqmg65sQz31Uqrs0sNdA2DQZlgmlnhQ1GD3eSfN6AE1t5g7l3CY5StFjd9EhVaVxQ
         RGrGaa4NM6suij4Sb9+pVImNCeIWIRozk7xJGD48+TRZOAPymmpKmeXMAxXQUiS5lypW
         kmrroegLpj9NIYMvdHS+2y5xBsWqGs+MMcREuhtfyIwvm6h2qduuMm+4GbPqoIbN5y3+
         WR0yzI20dpx1tb7Z7vQcxZOnAmrwFhlMVuSWhGTOKUd9yC7UqPGsUB0bkNv/huiG+kdq
         NERg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793463480; x=1794068280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B1bwDfWXqtdtKzMUXXL8Xhn7s+stBQep1iI2lQ9nd7Y=;
        b=fsyXfqZAOV3CRH/Mk9W5qKH+QAuXRoVHQiFPt8VfTL/X/gLTEeSd1Qb6sMYxW/PGcj
         ABk+PV3TePzv/Oo7TcVxy/UrGmGXeTr+i3GA1OyofX0ufwDoBTn0a1Er4zpusI7iL/CF
         X70Hdx0DwSaRWKi9TR5ApQ0aK4fdqlaKgfQI5rHW+g/TwtDXUknu6BjSpM9IskBEJ+Ah
         7sySD6zZjlZevdA1iTi7bupNo2z7aFxGZytmH6JXu1Kw5UNetlKYpuoMLmeA+gqyZeyA
         BQ3fLoh6ru6sZxD51rFSuxz3JuwYFzeTlqJ4KHxeB8GjMh2UWFSGy3BLrGRT/BWEVItT
         dqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793463480; x=1794068280;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B1bwDfWXqtdtKzMUXXL8Xhn7s+stBQep1iI2lQ9nd7Y=;
        b=mgoIdayxyLB79Jp0BCDbeF7EJH8QTndqVWSup3CTx85iWmqh0Eu3jz8phtm7xcUYzp
         PZ9M8CEPQbmwnMduqQaHPKcOnIAYyFcp0CKVfS8UWcjRdpW9hA6DclU3iF+otenw16lC
         VxJ5BOn4txVAAW5omkMGMLLeQs+A7MavbFVEQf84aHCsOwavot1aPbGgwGl4YNXtduiO
         Ibp5VxIvV15MEAktaTKl53oBYKu9g3ppEfaNODo+UKCQNGAzHRaQuQUJlqH4/A/vVhtW
         kj4/mjw09JomaMrQXYBs+YpmBLpseYJgD/8+q9wk+3y5dzk8o6AvLHF2s9ucvjXfDBxh
         KkUA==
X-Forwarded-Encrypted: i=1; AKwUvBx6eUsT1Xhwa7XuhXyMcKoicipoe11MPRq8GmBOU+JKDIlrXqOkWLnfE4EeOiKXKHEudEJJSeU7QnomJw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJjiay51Q3glKKaT9T2IRzV3m9172CLDXhmIMIoltadEM5xUK20
	tAprVVCV05/+loYdCiZKqLBhbzdu0XkhPvZVnxo05frTnr7VXcJdX/Nq6J6CLIxuicdaDB3yXJJ
	VTxhpKhaakwKjrtyPsQwRwhaEP9+e4G8hGBR+j/EUKe4LxcmqpuuTNTYNGxWkYw==
X-Gm-Gg: AYBFou1JzbVHB2g/oqmgCoRktocv4dTtoKAro+bURVJHmoRsOIMjFpipTiAYnMBhDjh
	eUVlE5bga0FSq1cxjWtOz3F0wjTpRo/AeA4TtyM73NDod8XtBJZkxv37PvWOaQs4j3vuwhAcYsN
	9Fbmj68dc4bqE1oKXQ1mfEjWycJOhqtgsk/EpLznuZpL5kc1JK6JwWdHc+9TU4zdTUfDa6JY9ka
	eepry5rVYYYTYtgshxYXOU5H+S9m/8FIzC81sqIkTzWp2YgskCK7lD5tfxvwPm5NcWesC3YEBIy
	fSb1YZE1+JZ+Xm3sT9/UTStXzo9j+tJHdC5iXYf5l5D5ZCEjirCcXpge06D1vIMCStOMLb8s0og
	9JEY6Eb4ix5R/go9s7fnRLayIhhAmm+cAbruaEtOpFpYQk4xpQz0zeOGaU3+yvSs5vdb6o2R/wR
	4ERYENfOv6EPXtkeIBgERY9JpChmtYsLi+TVXQ
X-Received: by 2002:a05:6000:4026:b0:48b:4a2:8175 with SMTP id
 ffacd0b85a97d-48e6e501911mr12571791f8f.43.1793463480123; Sat, 31 Oct 2026
 09:18:00 -0700 (PDT)
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
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 31 Oct 2026 17:17:46 +0100
X-Gm-Features: AclHuK9l18-NBetzRhpu2rSGbrBFqOZ1yvwZnbwEAmvoiR_gPddFIoalS6dNMJQ
Message-ID: <CAH5fLgiSOae48jr65rv6ynLWUhT7xVCjjCEK=9oKXvSxKpdq6g@mail.gmail.com>
Subject: Re: [PATCH] rust: bindings: derive Zeroable for bindgen's opaque
 array wrappers
To: Sasha Levin <sashal@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, rust-for-linux@vger.kernel.org, 
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

Is it possible to instead fix this by adding the impl of Zeroable in
rust/bindings/lib.rs, similar to this piece of code that we already
have:

unsafe impl<Storage> Zeroable for __BindgenBitfieldUnit<Storage> where
Storage: Zeroable {}

Alice
