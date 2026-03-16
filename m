Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92FD392837
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773662250; cv=none; b=ZZaojEUpTVDuIZcWSsMj+szmxkQvqnZ3HB4Erl6YKKvRNnoUEw35wx2uAxalB70qqBD4rkukEs5ltye/SfN6SwsJdEWEcwTcSXdKbmCpdBM3i0HX56cTcEQCO0BCo28NJp201+JNZnM07o8mo/1i7qnLAhZO6XYZ8SP8UlMna3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773662250; c=relaxed/simple;
	bh=FuNmO4/hB2Qs4Ti5dS8eJT7wL2LJCFM2Y0ub/bRlbKE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EmqMa2RHLYnOj+RESEIZliGy3T8/ihqxsKEDAZ2QEUw4vz4MvDsWDlEf4DdJm3MCglWdIiPffHoYvw2I/y6mAdYrO5GLw1LMfEsIlHyZMK+YSqTHNqH1mTssFqFOnUlOquMoFQ1SgsaX0NDKIF+WOUbuHGYVf5vKlUu6Xmza8GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZXJCwoW9; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXJCwoW9"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-485350666bfso36394315e9.3
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 04:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773662248; x=1774267048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1fcoRP59CGw48vJfNa9YQqD0Rlv5rHRkuoFgchM3ME=;
        b=ZXJCwoW9OWg0SuIfhfRcwEMAh+4Vjma2qJYzBTyKtoRaelt0HhxOoNnSfV96EvWihH
         x7JcAJPUMaMeBYoybfnjHe/DumK/xPKDK0zWfaNpdeohUPWe/8DQKM3a5cGtLQr/ymF/
         pQ8X+yD9okzpj75fElaw8Xf31/qfaJENA4GmYTW3L4/hD/erZmtuTe+K4e0mzaYx3BO4
         UAD8pD3eWBQ3EIf2LuUu5crKD1DbDtbwPmsxRDza/g1tRmqdwcCSLJ6+fn/sYP3JEKKH
         bz5EI6VD6xzQFPLxkoCmyyED8gDglzIlJTuTGGTw9266LsskB8bFNsz5LqTl/03rGTm+
         Msrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773662248; x=1774267048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1fcoRP59CGw48vJfNa9YQqD0Rlv5rHRkuoFgchM3ME=;
        b=nMsEZSr0eaYBxjFCz716ffSVo/15qmAgfqqnuCwtmbbtIeOcvwDLM9CoT23qAXoUHq
         kzxoSOfPI8i4KFDyeRDCXQuBCBnJRplnhxCpoRAAWzBmnOE8lQYjA+ryKtovOkYD0xRY
         boeepsX3LzaQAK93YeIc8c/MyaiG0D4H5rBXJoudJ+vVnAkXdnwkluLBp2Y07x+5pXvz
         l4vl4G1q+H/v+7kvOYebE1w+ce3a1pXvS1DSkoI+vWJWM1YyabTBHFAd93GYGknhekR3
         EqEEtA2QgMQwHweBVdFz9389UdYBbkNKvs46EwvMuNt61Gt3tNvarx00TN7MlvXtdDZX
         xMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB6egF0PM9fiTJAk8xwDURpQZJuDNxRnhXpvRdRsFMiRei3qV28ALJh6VYm5McYLhsfBoFQbBfcBdxDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw91/fzqjqtnGZunij1ueX0Z3PkgGstTUr/krsff89pgUTVvdO
	U64XYMbwaZDO258NywE0G4hi9TD+dY7yqIRUjBNtTAifJ2+GVd8AH9SmN76q3/vNC6XIo63TZIg
	x93PY2FPXWiuOLFh2Ag==
X-Received: from wmbeu8.prod.google.com ([2002:a05:600c:81c8:b0:485:4f26:fe69])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1395:b0:485:2fc5:3a5 with SMTP id 5b1f17b1804b1-48556709d85mr206811255e9.26.1773662247858;
 Mon, 16 Mar 2026 04:57:27 -0700 (PDT)
Date: Mon, 16 Mar 2026 11:57:26 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-25-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-25-de9a7af4b469@kernel.org>
Message-ID: <abfwJrDEHoaINFwH@google.com>
Subject: Re: [PATCH 25/79] block: rust: mq: add Request::end() method for
 custom status codes
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

On Mon, Feb 16, 2026 at 12:35:12AM +0100, Andreas Hindborg wrote:
> Add end() method to Request that accepts a custom status code parameter,
> refactoring end_ok() to use it with BLK_STS_OK.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
