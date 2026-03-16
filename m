Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437EC38E5C4
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657251; cv=none; b=U0w+FzJg5lYv8lgOmbzcNR7v2YoJ6YrXjCtqjCtDjeHUeCkiiiu19yZbIFiou8UnQAIFQ/L3qSccnN7O4acdW17A7H+AvxJXfP9t3pZNZnJKrLXJN2YfmhcEYtiKOfmEdNbfUVDXtdaqW1xfNkIgO36h7r4h+hx/RCfEUeuILvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657251; c=relaxed/simple;
	bh=nXYX8ohuOP1WmALF4quMK90p2fquSx08wx4cHnDn4Ek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CqxAFcB+q1AIO9qsVJu5HifpcS5G9pXzg89zUThJyEe0rqKvJKs/82Nj1jigBh1SOAqIRiETzRJRB5+EGx0F7CeQSAFPg6JHmGojKfV2fjA7vA7kTAfdEeXz8rGb4YwUdqAsvOIzvB2dJv/a3tuKV9tMaIwnBq61fe10LQVqAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mYnJiQSc; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mYnJiQSc"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48553fdd03dso25733745e9.0
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 03:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773657249; x=1774262049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1Pp6B+kbyJ7AS+BSznHhsZJFqEGhJ13TKhxuOIaMsk=;
        b=mYnJiQScoqIII8IdrA7JUZEpPeb7bvbvtcZhHUOsdxk851zsnwq3LNP598+VWnkndC
         IQEQTXy2yKC1iiiyUYr5xbXq8ccBk0Px48BqZL1CZeBHRwayTsthRpFDXQmsc2XcHE9O
         qswpRZ1BhqcTc9w3QxcaeGuL5a5TeeJoBXdCFxJw4gWjR31dXHIW/kJjdrbVLRRhq/L+
         g3Bj4/XUm6guLFlZSIT4wf/+kUztGezIQMrcnX1FTkZgKettp81mLaAy+H+d1uh1Lqt/
         cIL5LP8c1yxgiQjzfIvYpmML/sJZpMBqZt2aUB2Ifykh7wi4FYlog0MvjPX7IDGZz7SB
         9tKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773657249; x=1774262049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1Pp6B+kbyJ7AS+BSznHhsZJFqEGhJ13TKhxuOIaMsk=;
        b=TZFuYF2w77nzrjQCn0K7hnmQ14n6TAht4RYdU9Fq0MdZQjkWu4r1PuVwVI/yDSPXKE
         lIgZSfK0nLd/UdZebGinSfXEcMQ0Y22W1NUmk0VH2tnwBpR8SSlfSYV6zBZg81vbsbUB
         DvAM+eHYQ7FKPqBDLtEqGkz/EvQPulIP3CDvpVnMlXzdW17G3GzBY4sJDFSvggAjNios
         7krtPJsPpSnu1WpdxYqaDlWW7f145dctQKkS3Z3As7dm4cY59e1Gw6gJiD/9tsWBVmtL
         qLgK+3sloZT/caHMeHqrSAHUgQnDpHI8f6MM8D8BLl3Z+HtVKQepSU3w7cSEf/mUe0Z/
         ANIw==
X-Forwarded-Encrypted: i=1; AJvYcCU2jXLDwxnjItAEItRvMDi/XIVZeDTpoo+InPsqdCSGDpXEbomArY+IZ2hpf4RxoOCOJBTc0yGpIXrMdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWjtewBaluFZszTktB+3s9aOEX3P6uHlvIL6RW84E4jb5Dv/VO
	6GO+IliP4cT26euApHeISH8xv7BGNNdKb2GbX5W6WFbjjG4YEvhXiDD+nlhS+dzJzFhbtj3lAg2
	s63M8lbxLPo+LzJib6w==
X-Received: from wmoo9.prod.google.com ([2002:a05:600d:109:b0:485:4f4a:bd87])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3553:b0:485:3a27:a961 with SMTP id 5b1f17b1804b1-4855649fdafmr220588635e9.0.1773657248391;
 Mon, 16 Mar 2026 03:34:08 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:34:07 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-12-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-12-de9a7af4b469@kernel.org>
Message-ID: <abfcn5dVzjoQmomd@google.com>
Subject: Re: [PATCH 12/79] block: rust: add `TagSet` flags
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

On Mon, Feb 16, 2026 at 12:34:59AM +0100, Andreas Hindborg wrote:
> Add support for `TagSet` flags by introducing a `Flags` type and adding
> a flags parameter to `TagSet::new`. This allows configuring tagset
> behavior such as blocking vs non-blocking operation.
> 
> The Flags type supports bitwise operations and provides values like
> `Blocking` for common use cases. The module documentation example is
> updated to demonstrate the new API.
> 
> For now, only a single flag is added.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

with nits fixed:
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  /// A wrapper for the C `struct blk_mq_tag_set`.
>  ///
>  /// `struct blk_mq_tag_set` contains a `struct list_head` and so must be pinned.
> @@ -37,6 +41,7 @@ pub fn new(
>          nr_hw_queues: u32,
>          num_tags: u32,
>          num_maps: u32,
> +        flags: Flags,
>      ) -> impl PinInit<Self, error::Error> {
>          // SAFETY: `blk_mq_tag_set` only contains integers and pointers, which
>          // all are allowed to be 0.
> @@ -51,7 +56,7 @@ pub fn new(
>                      numa_node: bindings::NUMA_NO_NODE,
>                      queue_depth: num_tags,
>                      cmd_size,
> -                    flags: 0,
> +                    flags: flags.into_inner(),
>                      driver_data: core::ptr::null_mut::<crate::ffi::c_void>(),

c_void in prelude.

>                      nr_maps: num_maps,
>                      ..tag_set
> diff --git a/rust/kernel/block/mq/tag_set/flags.rs b/rust/kernel/block/mq/tag_set/flags.rs
> new file mode 100644
> index 0000000000000..768db938b9a95
> --- /dev/null
> +++ b/rust/kernel/block/mq/tag_set/flags.rs
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use kernel::prelude::*;
> +
> +impl_flags! {
> +
> +    /// Flags to be used when creating [`super::TagSet`] objects.
> +    #[derive(Debug, Clone, Default, Copy, PartialEq, Eq)]
> +    pub struct Flags(u32);

Nit: Spurious newline in beginning of macro.

Alice
