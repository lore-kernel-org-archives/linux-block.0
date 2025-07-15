Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6972749C3
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572668; cv=none; b=MsZ9UHHeQ2ubQttCK+IgGTdQ2e8HTq9wyFC1UyfW833b1RMr/wrVxEdhnJnu7agPfyTXqVBTakK6LovxCz2qsF2M6F6rFvZkogQ8PyBeNAbvc5gU17TC4BCx5nn8SdDvGG//N3dZC2fLz1ljvWt2XQMOUq2XRhUoxdrhwAobohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572668; c=relaxed/simple;
	bh=lSeA/LDnEt1glLu7Dasv3hTt4/7Fnfbj78CTXFDmYcQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sq07nimSBBznKpJubXMnEuUu9TlY4lar8U9/V84tVRYZOvevomJsLz3hI7iKj4bUAzwc01ju5qTPBw3ytcpHdD8sFTUV6ouekpe+7Sd85DGgy+0rXYMqciqzcunfT4lLjDVPeKXjGv1CcADbcW6Q8PQd8XWoKNSeNLaGFJNUikI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JYXpT9M+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYXpT9M+"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45526e19f43so14208925e9.3
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 02:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752572665; x=1753177465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8aIV18upBwtnpGAz2ciR1j/dicG/X743xikh+l1DhFk=;
        b=JYXpT9M+45w9erDPc0UK7CNqa47VQejpFjaguyhUMFqjmzedNlq/wgaaFEAdzklR4n
         C+EQMsh0yMJQs4bsiJGZQWoXAmmYvT/bw6cIAXA+BbANth6PGk4XkuqZelnfDRorMXFv
         a/S9RUikwr28PHQw6Wkf7mj23r3AzkOX1ThLYSht9IxuG/8Z/AEcMqWjgav7ItZxk229
         ORXXN3KmSkEbW+WGhPfl8yjO06gFx/p/LiOhX1M/C2cfqcgjeZ46OJYElu5za6jh7H/4
         h8gaRstEbrjjuoq6tPDiCDPBhaGACOFRIv14igKlDYHiL1snc/d3BWc8SATXTzPWk4N0
         e1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572665; x=1753177465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aIV18upBwtnpGAz2ciR1j/dicG/X743xikh+l1DhFk=;
        b=edXPf4XHNmkhq0cRDGP7jdf5G/xHYoB+oaS5X/+4JUsV9SVP80w9EWKhaENg1qfbmZ
         7tvJ0a3iiIzQcjCOqDjPi3W/3gSYr2+q0BvpmxfC3IUFl3kP0OshDi+R/ZBg3ZPL5hRb
         4x7JidDpnXYp86ZeSAEhHp64r9E8RJVOFmHC4ADIpKI97DDUtu8C5XjjBLF+TRcmzIyt
         DEMiS15TcOqFgqL9bbvNkT8ets8VKoCDvDt2eqveZBdfJBroLNuvFKsX6kCcUlavvJgA
         ImG6AXLKoRrS9FE/DK9s4lPc2c6UkJtfGUPI+GMIxMfJINBHZ5U6FxkcBBNNn/7RnL8t
         mJ+A==
X-Forwarded-Encrypted: i=1; AJvYcCWJ3hAxmok7vglBQpwLqmQYOZmY3LUnMW5sZKBuaonK2iiCOqQkTFvt099SbwZp389k/qJ7PS0K6WVFeA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2IKzEa/EH+U7a7B+WgYexmL1u2GbeEWlMU1UuX7sC7SR6Y+1b
	Dzs1utbKtKufx+p7fcsF3D+Gyi7k7TVokRKCfb/glTtDiZe0jEeiLp/TEHTzQXwD8TqnBdsk6NN
	XIEf/tG4YvzUWP2T/ng==
X-Google-Smtp-Source: AGHT+IEfrFbb5XOTs0vByF+cJyENIraTLg0DkCXSI8ECPvP+KQorjjEcB8BKNA0WhVlVHFSqJ+tbrV5euNWKkl8=
X-Received: from wmbgw8.prod.google.com ([2002:a05:600c:8508:b0:451:4d6b:5b7e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6304:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-454ec16cb2emr169347295e9.12.1752572665040;
 Tue, 15 Jul 2025 02:44:25 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:44:24 +0000
In-Reply-To: <20250711-rnull-up-v6-16-v3-10-3a262b4e2921@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org> <20250711-rnull-up-v6-16-v3-10-3a262b4e2921@kernel.org>
Message-ID: <aHYi-PRsEQ-YpeYm@google.com>
Subject: Re: [PATCH v3 10/16] rust: block: add block related constants
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 11, 2025 at 01:43:11PM +0200, Andreas Hindborg wrote:
> Add a few block subsystem constants to the rust `kernel::block` name space.
> This makes it easier to access the constants from rust code.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/block.rs | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
> index 150f710efe5b..7461adf4d7e0 100644
> --- a/rust/kernel/block.rs
> +++ b/rust/kernel/block.rs
> @@ -3,3 +3,15 @@
>  //! Types for working with the block layer.
>  
>  pub mod mq;
> +
> +/// Bit mask for masking out [`SECTOR_SIZE`]
> +pub const SECTOR_MASK: u32 = bindings::SECTOR_MASK;
> +
> +/// Sectors are size `1 << SECTOR_SHIFT`.
> +pub const SECTOR_SHIFT: u32 = bindings::SECTOR_SHIFT;
> +
> +/// Size of a sector.
> +pub const SECTOR_SIZE: u32 = bindings::SECTOR_SIZE;
> +
> +/// Power of two difference in size of a page and size of a sector.
> +pub const PAGE_SECTORS_SHIFT: u32 = bindings::PAGE_SECTORS_SHIFT;

I was looking for the user to double-check whether u32 was the right
choice, but I can't find it. It looks like you don't use these yet?

Alice
