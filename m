Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4F038D6A9
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657820; cv=none; b=Ydb6Jfr1x3WiTC3WrbWEp5SMlbe7m6aHf/tMFYsif0GY/rna0ZgnVAsYccZxYmV2BueYvCrUoQPiogEoTQGtxDJLQ79URTSInZqPHiTM2r8I4LfhqiVMWoFdczzmNccTkghN7NTPfkTtdj1sWSz0c/tAwHpiQNLFXvg1neYag7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657820; c=relaxed/simple;
	bh=7Kjtg1MX3iLegJm44RLS5OQbZBubSoAhUXBe90+ZL58=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C21Ab8WSI/yR9l3Dw4DPdqyrXFlNyHIII11ohGAvEJggOV6iX5JsHOOGotiVfX5a3MEuYGjXbQFycsOp6cY79Gwusd1vz4O5YifHu7cJtjbJRKP/kiETJgMxfxjaxEbs38ifdZP6iXXN/zAjXW7tAXgIIjH+WF0wJFS40lS+Wy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXkI0zLV; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXkI0zLV"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-485389bf0daso30163345e9.0
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 03:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773657818; x=1774262618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aIsjm9vE54z8tUJ1wyvdDm1uLSUX2YtWlUueHA6I6BA=;
        b=CXkI0zLV8aHfHu+TKs6dowrLt2dzH7FCpL0ennNh7Sq3qbx5epHgsDkJtXnZj5s81z
         v5WY6/jxlE2Kz6P/Aa4P6oeGa3eXmlxPtdsxlZnanlDIZnZa1lk2TXfh4Qx6/nXObD3p
         DqIMyxTFKSvlUzhX1QNfHPaOG3eME+eM7c+KQcmsieqUbt+ln0iyFxDLFQAjhFr4LQ9n
         BnEgp2SeqiIase/q5UQL1S3E/B5jBMx0Ku3y9oyYKiVsqDuyRDdu3ekfqTFHsfrHjAwJ
         xCclGFnH+X0g76YG/dX4xhJlgHbaKdEkiyHvX+tOLkQxx/iNgfqRgrTCiZNTRWAXJRyH
         uFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773657818; x=1774262618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIsjm9vE54z8tUJ1wyvdDm1uLSUX2YtWlUueHA6I6BA=;
        b=chN4HQlWwTT5gInRljTSb8n61Kyn6yd2mjU3c/gKGhNM7jrK4c0mCYOYF4Iv8hmyRu
         7GGmJMHUFz4QijKojc3TVfyabA8tY+qbCSKFtW24JhwHTcdKKVrQ5TYaTBk7Ii9b6/3X
         m57ezB3+3N7GG+lxAJp1R37bwPWPtVHplwqWYiP3Q4Xs+DShf1l9ZSXSQ6krdvDUDxrU
         KpgqtJR57ObxOXX9yMSqMriAvx1ArWmDkaQc9ODxkedp3LExBqs2s8L1+eRBIQU/qf4g
         EbfW6JRtbSZQCgoy3kytHPPixv9D/nbKW5a2BE5pgfg4UPJRk4h4vDn9abfQHiILoUI6
         56yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgmS1JZ+dpc285HJ18qt54rXlBp/VLxxuhJnLgorcGOyw6vyc+0uWeciGk146XxJBDMghYhv/NmL84Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfek77wKVLy9S+tJ5dbjHz24ysLVM6tHb9Ar71vUDYCqxIWCAS
	cEj4xnuuq3ACKVBjD9k8bctKzJfPGdJB97JtNfbyCuw+OX5ToOLRuj4K/LHBobWqlBnF3Q9VrCF
	wOoR3P0HAGwJizWh1eQ==
X-Received: from wmno9.prod.google.com ([2002:a05:600c:1649:b0:485:38ca:51c9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e8c:b0:485:3e00:9440 with SMTP id 5b1f17b1804b1-4855670c296mr200273645e9.24.1773657817662;
 Mon, 16 Mar 2026 03:43:37 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:43:36 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-15-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-15-de9a7af4b469@kernel.org>
Message-ID: <abfe2LbhLzXiGCkA@google.com>
Subject: Re: [PATCH 15/79] block: rnull: add `use_per_node_hctx` config option
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

On Mon, Feb 16, 2026 at 12:35:02AM +0100, Andreas Hindborg wrote:
> Add a configfs attribute to enable per-NUMA-node hardware contexts.
> When enabled, the driver creates one hardware queue per NUMA node
> instead of the default configuration.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

This and other patches make me think that module parameters should have
value() return a copy of the value (and require Copy). For non-copy
types, there can be a separate value_ref() method. You would avoid *so*
many asterisks by doing that.

> +configfs_attribute!(DeviceConfig, 8,
> +    show: |this, page| show_field(
> +        this.data.lock().submit_queues == kernel::num_online_nodes(), page
> +    ),
> +    store: |this, page| store_with_power_check(this, page, |this, page| {
> +        let value = core::str::from_utf8(page)?
> +            .trim()
> +            .parse::<u8>()
> +            .map_err(|_| kernel::error::code::EINVAL)?
> +            != 0;
> +
> +        if value {
> +            this.data.lock().submit_queues *= kernel::num_online_nodes();
> +        }

kstrtobool again. Also, this is *multiplying* the existing submit_queues
value by the number of NUMA nodes?

> +        use_per_node_hctx: u8 {
> +            default: 0,
> +            description:
> +        "Use per-node allocation for hardware context queues, 0-false, 1-true. Default: 0-false",
> +        },

formatting (rustfmt ignores macros)

Alice
