Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35DF38E124
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658224; cv=none; b=AUvq8+W2fR7C98QneqpZBE1v0bCzSj/N5V0SOMcSBxA3N4MDDCEW9TkyZzftCcBnlFM8ZIuXffvLZe3tl73N+26L4AirovaDMDIM8xA04Pqx1nOeCkbbBB1uEmpDaCRLGw6mxY/viYc3PfzHP8MoKLXN3XDhdDtNRLWcAybBrS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658224; c=relaxed/simple;
	bh=/GSWFR/pM5/df7HwMsjGIPrNXwbMBghAM7Fw9l1aLJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jHcQFZ+QNqisH98/juJsHglQhN+2/fVH4RTm0bMTf8W97plxhG+5tYx5gC0MJeaD5qkuAKbrI+Yk0PQttD+9qHDNbYjY7Kmg8aQcFicgvjo6xKTqW9rqJEzwL9xaom2gF1jOWoWYxUXfbOC2gVm0yP7tQsVGFi0ldyT6h5OWFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HVzvsqQW; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HVzvsqQW"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4853f33b7dbso38553955e9.3
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 03:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773658221; x=1774263021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CN70017b9XscXy7JbJrHaMQDBe/xTJqIeRZ6kPNoH6A=;
        b=HVzvsqQWoaa24CprDq11YBa0EJK/H9aExVa7hZIE4acQ+YtHqzOvwdVQRmU4D/F9tA
         3xjsriRm/CFpES/RsDZgLyZ2GFnjxmrJ+iUI2LFTeCH90pXnTgE3JC469urplOZBwvgh
         FbjumMn6Bb5WYEALg5PdXKE8YrqMXtX4JfIqGwoDFJjvj6d7bqH/h4rA4S1UgdiHzldd
         O+hHI/paAaYQIxWxi3/2DROBl8beOBsuSP7RrfXdYuv+325hR1eC4BhxqfyljyqtH0fy
         OdQPq1EwEMAxvMRNI+JDPelj8gV5QZuHMztJY/D6AvOrqyppX5OkHqBQxy24BFmWT0iv
         7mSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658221; x=1774263021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CN70017b9XscXy7JbJrHaMQDBe/xTJqIeRZ6kPNoH6A=;
        b=YwDjzLNDQZo+3CDf0/+stG0dTAK0+bBYw5FKIlewricuZx5cmqHe3I9/GgoltatjE8
         Dn2CThCpedivpBjp5gJoazmHnRSOq/qUu5owpyPeHK7ojKQMq6Ner1sAbXw1yB8pJXC/
         nGzeynJb2UREPcwS/I+BnCxkVATdCPSaRvd0XGioiddhGvduY1YdSeis87VaczZADhYe
         Y72XiDNJaoRoo6UbzC8l5KhbfdLdIWjscxW40lc59Tgcf3863dSkoO03lWwGWCfYpZWa
         C5ZckAIdJxLZ9l2W1csc6v8KFWZxrYs3yJdmxAFAkip/3XyJkogZnsO/u0y/biFnyVMJ
         sLjw==
X-Forwarded-Encrypted: i=1; AJvYcCWrMM5BNzQ/UZy7FuDbOsSDRr5nNfXJBvap23YC1k+TctbAFoe0rdfmUBlGejY6SMBdxQGxXBchLCbYMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YweERYLbnSVoB7zNScpe/PJL9r9mOFT7exy7ZK3Ofln2RR05cDd
	HcaD9Vka3tS4PtLpSpwcG0KbxR96SJLyX57YTU0kLt2L4dIY/0V8A7V+WpZ4voIdDKPMZ7ouEmW
	ajmnBD0FBPHY5iGu41A==
X-Received: from wmpo26.prod.google.com ([2002:a05:600c:339a:b0:480:6c91:3efb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4514:b0:485:2f6a:6ed with SMTP id 5b1f17b1804b1-4855670b701mr196241325e9.28.1773658221003;
 Mon, 16 Mar 2026 03:50:21 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:50:20 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-19-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-19-de9a7af4b469@kernel.org>
Message-ID: <abfgbBjloS39qrbM@google.com>
Subject: Re: [PATCH 19/79] block: rust: mq: add max_hw_discard_sectors support
 to GenDiskBuilder
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

On Mon, Feb 16, 2026 at 12:35:06AM +0100, Andreas Hindborg wrote:
> Add support for configuring the maximum hardware discard sectors
> through GenDiskBuilder. This allows block devices to specify their
> discard/trim capabilities.
> 
> Setting this value to 0 (the default) indicates that discard is not
> supported by the device. Non-zero values specify the maximum number
> of sectors that can be discarded in a single operation.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

If 0 is a special value, then it could be slightly cleaner to use
Option<NonNullU32> or even a custom enum

	enum MaxHwDiscardSectors {
	    Unsupported,
	    Supported { max: NonNullU32, }
	}

But I'm also ok with current design, so:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
