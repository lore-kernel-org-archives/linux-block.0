Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B0F38E130
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658358; cv=none; b=O0kEzdLq0AoW6Ou+t6Lvpu1xmysYVrLwwlBPxuZqUtlHnzBc35pgwHiSVu2ocJheVfMvdTQj0Z03iouVw4q8OiZ3a/8hpVe2pdaudrnAYGQ5pXvSqEwhuH+Ov149/hJAq+22Xi5eL9S0aVx7E+ESnDf3Xm0sWyBpVGv1cujAr50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658358; c=relaxed/simple;
	bh=L26jm5jX24iJ3KU18ihZvHPzNtD1XydWhsRzUBY1WTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hqeOkGhDjv73+nU1+1GXzmzlSSW+K4+P+EhZD82z0z0P166ziSo9UdbudTWycdPsz9yDFAxwcSGDE6AVqiy2WIVZNqMomg+Tp9pEUVMpSp7D5OZ+XLFwbwP79jLUxpgdhtwc/YnXtGIm4v08KOn1P/8RoChWfYcRr8OWJlzyNDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n0mYfS2R; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0mYfS2R"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b9766fcff6fso329871766b.0
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 03:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773658356; x=1774263156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2E+qOfGop+QubRQ5BjqIf2g5ptnhpPI53+IOJpnWpE=;
        b=n0mYfS2RCtrEsy9SwWQwLvPwLry19aIbQS++V/6FquchFRX0DMV94ZzYDwM/+GeSAL
         5tIvCHA9AL2Phab61tuF9GlYDbPlmBL53J4PrpUTSywBmY9sS6md7T8jx+RH0RfVjXtg
         nUjgjzpuefqlEd5NYh8dOlQFFk61ShcoIp2Aq+c1zNjnVpHAoc5KwDJtD7D/p7L8xzH/
         sRnq5tgAkZ2t1zXirJ1x17Di23CjcBr/rv2M6rhtvlURllmRReQJRp4etYIz6NgQddPY
         1D2xtSRjYJt2GrCHn60iADvXonRCDAPFkSEqJVHbSHTYYuLGh4X6M9KKY7I8xKQw9sh8
         lyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658356; x=1774263156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2E+qOfGop+QubRQ5BjqIf2g5ptnhpPI53+IOJpnWpE=;
        b=lxb5RIp1296Pg9+qxomZM+QNX25P6+r1+aiw8yXnt+nNDrAMXnbZQvBiTywstKMGzN
         eV9rtZhOWQ0EHCzjuSyElSQW0MC2YtPwTirz6yNzaOjiU6/gEmtIZvdjykx/iF2ZxBG7
         XSCOc0CBQz5GusoG5o1hWCNYDpKWX9okQMJRyRXt0pfOsDmHEVlDl1xvjXk5PkiCovj7
         j/3z1/ovB1B5hm9eBT6c6aNBiiUdhhRn9o/brTGcpdEiY9SmNM6nsdQrg8YXDlx9UEgg
         6b/O12NhLxbZybnJFpMCnlAQ15bhIW88F/ANGe7JJP2qS5usWtpJ/FqvBp9mACatYkYV
         DquQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9vSm+aU/XwSMmQBEL1VHVhU7goJqXb272/ur/cINGmEm+pDXixZMIYadkhAF3h7k07Myk7ily57q73A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHhFQ7E80UJDi+1Q9TH7dCD5r34S9q0mGltdwnWebL1QCWHUL4
	izqhyFPgz7ziychxLWXjkIL6xP1JDwFRbgA+SH4GRmv7M/4lNrj+Ir9BGnGgqVZB+3pirf7KWCL
	5KFugovrPtwKhiqer7A==
X-Received: from ejcuc33.prod.google.com ([2002:a17:907:c8a1:b0:b93:4f5f:7d88])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c0a:b0:b97:a39d:ae3d with SMTP id a640c23a62f3a-b97a39dc4c4mr350209766b.44.1773658355573;
 Mon, 16 Mar 2026 03:52:35 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:52:34 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-20-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-20-de9a7af4b469@kernel.org>
Message-ID: <abfg8lN2L-kVVrOy@google.com>
Subject: Re: [PATCH 20/79] block: rnull: add discard support
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

On Mon, Feb 16, 2026 at 12:35:07AM +0100, Andreas Hindborg wrote:
> +configfs_attribute!(DeviceConfig, 10,
> +    show: |this, page| show_field(this.data.lock().discard, page),
> +    store: |this, page| store_with_power_check(this, page, |this, page| {
> +        if !this.data.lock().memory_backed {
> +            return Err(EINVAL);
> +        }
> +        this.data.lock().discard = kstrtobool_bytes(page)?;

Similar to the race I mentioned earlier with store_with_power_check(),
this is also a TOCTOU race.

> +        discard: u8 {
> +            default: 0,
> +            description:
> +            "Support discard operations (requires memory-backed null_blk device). Default: false",
> +        },

kstrtobool again here...

> -type TreeNode = Owned<SafePage>;
> +const _CHEKC_STATUS_WIDTH: () = build_assert!((PAGE_SIZE >> SECTOR_SHIFT) <= 64);

Use static_assert! or assert! here.

Alice
