Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D462E3B0E
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067595; cv=none; b=GzVK0+YN4+4WMBolDiErlyQlcUlQOy/8oHAiHeQPWIHvzKyL1Shysy5UOaK4HOL8xHnbx6kgDbRd8zakA/RP0vOYvYghvzB2hNf6F095Dhwy6aLfW5LMaI0reqKxhrOT+F+QJ4+9eBSanMtw19Kf+en3YQCeVRMAsxRIpi+DsEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067595; c=relaxed/simple;
	bh=Mwk7EQIGinazovFKy6rm1e4ck2Eb4n2+egCG14FKWyk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FpiYbR9UueDn9uVAHHWnJBjZlMoYjcOsFAne8rkw63EcqSkJm1QJdFd9sn0oO1qxCCKunGNK+OdKQ/8Ksz5/zyp7xkk9vnc6C84cvcgZI+sfwZvyxXXhbyeXuhIxR2sJTgAYnDpp/QZbMT0svoaTlr5IR3xlzSFxTL7+Lp22fLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CTlApoUm; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CTlApoUm"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-606ee65164fso6075073a12.1
        for <linux-block@vger.kernel.org>; Wed, 09 Jul 2025 06:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752067592; x=1752672392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+AWzaFX7X0IoBwJtsGal3/qiXcwEGzW/IG/WeYHir0=;
        b=CTlApoUmOKxj0bnZRcmHuqd9PXPCyOvRc1Cdd4WlPCnpAbYxXhEAmTylbHbRKFRBlC
         PziBAEioJlRmuudj9E27szrRL2r3jM0ktGUMEDBBcxoCkM2uACLV37v7++A2q1R1pWFw
         XUcyEqkKO/0MoDbAyq4uGUn2aMq6uoulrqRq30HqwlhCGOw2BLt2dlycxhS3Vrj7HZRY
         jZQsJMFnqz+FBO7jyPByP4xPO60pgS/UXnFH3VVBlhU9+CYTGbQ1Rm9MOC9Vmfrhobdm
         HXQgFqI7D3ejfO1qxooNu2Uv1SIhpE28s34sT4tu6VS5szpniPrXldhEQ/N/n13FIkvu
         f4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752067592; x=1752672392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+AWzaFX7X0IoBwJtsGal3/qiXcwEGzW/IG/WeYHir0=;
        b=MQWTyEwypoRjB2ywz2GmoMbJLwyM80QAn3puNMnFKZFYhqUY4CNxMy+ZTNO1nwh795
         xOz85ROqsV/MFtFOOYFnf9MiCYdPF7ZA228xoHAv/prYChIjX0HyV3oqvlWO8ltxG+kz
         OGSyc2+f8jH0gdTly+yZ2eNyouJ33w/qjkicfoIhhCUgC0JJKeXXdZQsi0T4el+DCTW4
         Yq5wc7gQK2n/CiqQ36dba28as+5WAQTRXoScwU2IgBSTZG3Y/D7T5U3mgEQe7WWSSJzm
         EulZGIdy7RY7AUL8u6zG4HoJI5vgX/eoBSEW4qqEotUJ4gh3FywBuB7oyHlsW4KkHouh
         s2Rg==
X-Forwarded-Encrypted: i=1; AJvYcCW7ZVyVZQbAwiC0P8rObsGnGV25+TdtpMpXJmZldUbZDYLVaEiE55vsED/VT2f3X9kSxylQeWMiyZFDqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUlSlVbn1pTgMXTNtLYzfNtLz6CQFKg9roi6s0vLx1pME3j6U
	UFJ0wcoxCyokJ6wrXHPW7mZgcziJ6kNcxgYcCgVA4/8SHR7t1Ko4+NglOwLiWAUWn4+J6N9GHsP
	MnV5kQpetwFBW9DxwDw==
X-Google-Smtp-Source: AGHT+IFaIoO2aQ/ITtjF6XALcWJVnX8Rw7wLdSLQbLPowQYEildPkBPfx8TmVXR/yD9aSmB3fybHDe1guOBaPfE=
X-Received: from edbeg18.prod.google.com ([2002:a05:6402:2892:b0:60e:7792:da2b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:34d5:b0:60c:3f77:3f4e with SMTP id 4fb4d7f45d1cf-611a6e36b64mr2162510a12.22.1752067592574;
 Wed, 09 Jul 2025 06:26:32 -0700 (PDT)
Date: Wed, 9 Jul 2025 13:26:31 +0000
In-Reply-To: <20250708-rnull-up-v6-16-v2-1-ab93c0ff429b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org> <20250708-rnull-up-v6-16-v2-1-ab93c0ff429b@kernel.org>
Message-ID: <aG5uB2mK5b_WaI3B@google.com>
Subject: Re: [PATCH v2 01/14] rust: str: normalize imports in `str.rs`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 08, 2025 at 09:44:56PM +0200, Andreas Hindborg wrote:
> Clean up imports in `str.rs`. This makes future code manipulation more
> manageable.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
