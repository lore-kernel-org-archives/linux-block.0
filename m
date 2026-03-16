Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCD13859D1
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653261; cv=none; b=d6009kGGN0s0DV7a8cePM3dOgQNwLn7s/b2z5yJhD+fj7UwCoSSpYng/IKH09cckmtFNVEfIjaPs1GBFgiv1Oyn/d2IBy3o8k7RRZDJa6rNanuOPY5Nzud/JL1d+Pp17vjEuEic6YwfxipME7IY0t2BzHi7fzNc9cQMZoBuEg+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653261; c=relaxed/simple;
	bh=fG/m/7watyEcbnXXgUUvv88DMlrRh0CMAuXRlm9LWmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aUur9v6J3kZeP1Nx65yEBWfs6R01BwAkJgwOY1NJzkBWRC7e5eX9AlJweuxUyzJe6VbKl9XQYnC+39t6VSfc6uC/DG8RL6jTrBJYbIOHPyPm0UXk/BBNUSXbwXRuogEhkaBM5aU4jJOhcgPZrnI8Hda3vHmuDIYyHWbu94kvmCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ImwZ6zht; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ImwZ6zht"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4853f33b7dbso37742485e9.3
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773653258; x=1774258058; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7q6QzcmG6dxnzbKj8eqJeASThBGQ4nQR5hfoFgOE7Lk=;
        b=ImwZ6zhtkxAg1VMUevaTo0kja1miEFr9LvFz41rvWgv6MS875qMBO3P9zGO5M1HQzv
         2l1mz8eINjBTla0VQZzDO4SfhHRiPhehuq9qUd/mBBvQ0RTHmHtfwY2FMLgjbPIVV35w
         jknzjcNOJBAjO1I13jZa2OLhGKKJU3UJiD+Hc8lpEnTqzNktnYQpqMxm0Waj3v5KDlMX
         a59MtA8zM5cPcA+c2uOqfxu3fBskBpNRkHozn4gduiSirZbVLUoOoJWBG12uAsWwDE9N
         0aar0dSChJ7egQ56mAlxZtFT9KZtxGchf3WuIRhvQMVF0X1FS5vqjezaL5wS3Eh0UHgq
         mIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773653258; x=1774258058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7q6QzcmG6dxnzbKj8eqJeASThBGQ4nQR5hfoFgOE7Lk=;
        b=qXh3/bim+xku00aYQg+CR3gDex0XbCnhGEj06uB3i/VVkHfNeRxDc+q1Bhf6Te385X
         9bT6LEtc7NAu1UcqvUvmMvww72NgXWcd8n/Dc/EA3C4Dat8tGi/9Ar37R4NNubhoOLVE
         ThGq1Vnzn1mxLYKPWRmyF2wn0jKiiuuplhdUzILnbNqzifEAHHwm2MS3gG1n8tjbAwmP
         jlSLB0thRjKCLl8/bYrDed2QgSlN1ll+6VfwaIWaJm5vwusT2Qn67aS4mlXrjluZNL5I
         K+P/o4EiiWhi55NwYcQcX4HXS4CGGmfgqr345/Z2NkhEIs546ILx96WQAyZ3MJ44Plwo
         pFlw==
X-Forwarded-Encrypted: i=1; AJvYcCWT0c7YNtYERdkt2PikMQ1iRm14nf50jcLfHLKcszqEQz4pFQDbl6of7s1tshE1O1U3VW2FR5XCtHRnhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpBshvNZAvodkDyfQTLTr+/2SRmOifNFLQpzeqR8NE1uJOUf+t
	zPJQ3+x78SSXdzkxIdqLpJJO+C84aE4Q6vEKn9m44ceogNoXQZmEBLpYkqu3NEFCau+a6tKiTvO
	adYNY+JSy4A8uG/IOYQ==
X-Received: from wmbg26.prod.google.com ([2002:a05:600c:a41a:b0:485:385e:a8c1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c0d1:20b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-485570ce1cfmr145458085e9.4.1773653257588;
 Mon, 16 Mar 2026 02:27:37 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:27:35 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-4-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-4-de9a7af4b469@kernel.org>
Message-ID: <abfNByL15D4s69Al@google.com>
Subject: Re: [PATCH 04/79] block: rust: fix generation of bindings to `BLK_STS_.*`
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

On Mon, Feb 16, 2026 at 12:34:51AM +0100, Andreas Hindborg wrote:
> Bindgen generates constants for CPP integer literals as u32. The
> `blk_status_t` type is defined as `u8` but the variants of the type are
> defined as integer literals via CPP macros. Thus the defined variants of
> the type are not of the same type as the type itself.
> 
> Prevent bindgen from emitting generated bindings for the `BLK_STS_.*`
> defines and instead define constants manually in `bindings_helper.h`
> 
> Also remove casts that are no longer necessary.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

It'd be ideal to change the C header to use an enum, but that may not
work as I'm not sure you can specify the integer width you want for an
enum.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
