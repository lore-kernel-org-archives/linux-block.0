Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA4B3EA96A
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781696197; cv=none; b=F46p1ichGCvT1JY4XxypHbNhYuEZdl9EFf8MX+fc7tVQ1HfFsGrOVnTrbY7cWaGqmxf+hxkSrzWIaHbbAsUoicT18/K0ySdF1JWUMesUk2Idfw53gddfZVT4iHOYRBZfpDxGUdlNbrupjxfzLnzVruC5qw6u7+zEdjNsQNx/QY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781696197; c=relaxed/simple;
	bh=rOcDjKNM7agwOLTLfbY1xAQ9bt9q2fdtORORxk4X9p0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gvw5na6TacpkKG5PRQYPNd1rROaK3OMK0/sZNR95J2FLorgwUH+slaNjfWb/BPNZcpFBbT7Lx7t82L7vHBdcaxD/0VEUdaTcjw7kQnK/ZRhXEWxXuMNNbM7TJgxKJ29I7qrMRSCjV3O4XE3wqCQk78V87azD3WiRU3lysYBpj+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DO0PL1lz; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DO0PL1lz"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-69595d7933fso257262a12.0
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781696193; x=1782300993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UYicJoYFI4w4qF8sCnn+jRXzXN1/GRmTZzaGc7Ox2u4=;
        b=DO0PL1lz29qKPDyulPg8ifez7mjDclhJ1lmjNppxCX8OOS/xe8hvN1/XIWXHklL92+
         asFHBAnT3gg97rxzzYW2ejWRkLpCJzpks6rhZVsQExYfsGOyzGby37HsAsWmx0HYU9W0
         cEEDJIRqd9ybX0myXUevPrxqy4bt5RNU7LW1xsgVrGKCZwMZjDKU50PziLZfsTpjsrYd
         mINieITCXsvsjwsleB8Bmtiuf51VrdH/VyMW+hgqOf2hRS5MDsSvqKYN3SxTnb7+Ec6w
         FAQwf5rzp8gRPutt8WH3laCVwbanmd/imcEXAaD4aip6e3BKj4MrW6pB4M6IgjGimmkw
         Ib+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781696193; x=1782300993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYicJoYFI4w4qF8sCnn+jRXzXN1/GRmTZzaGc7Ox2u4=;
        b=H2VJgieIULpH73HireM7vJuq/mKO2z3uGMHfS6++jsPN+ZvvX9pSsB0VSYLff/tBSO
         xwuqVEI7RTV2H4FuxQI1DV4VN7hfqdSUhCmq2Z+r/5YpY9C7jrO9wz8aTeqdWQl05fNz
         RxGl9g5UsF2RnxSZiljNmNaPNenaGUO4bpjG3UElqG3JJUQu3sC5xDW8IzuVKoYlS4QG
         3Wbd/NmwK20pxAbHo0cYbLjqyf2JekpgvT7LU7npvhObjdF4cR4wAk52nUMO+mDNtrym
         Rd/elp3XAUxXIZPxgFA0gmh1gg9p11domIpYvTZqcCFkQWSghzo2AGQ9shtQ4jG4WiOO
         xs3g==
X-Forwarded-Encrypted: i=1; AFNElJ+EwPWaA+x+vddN/NUTjxuXZZGp8d53h7JmDegzFq0tZVpMpwiE5FDaFr7jHuRJSIcDsMMh9NeOyxT6YA==@vger.kernel.org
X-Gm-Message-State: AOJu0YycunAvaM6J3C76Sd7f5D47sAZSXXYTy+0gPd5MV1TDUqFVGQ9Z
	xkK0yvk80qqbDqFmftScQM9x9RBl/yw980oif6/p8yln1NS3uoVpujyDfvS26o5NAQ+6cIgCBTb
	0yHyqqAzGZeH7BAGUvQ==
X-Received: from edea23.prod.google.com ([2002:a05:6402:a197:b0:695:72e1:a5a0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a50:cbc1:0:b0:68f:9fd9:435a with SMTP id 4fb4d7f45d1cf-69554cac360mr960260a12.17.1781696192851;
 Wed, 17 Jun 2026 04:36:32 -0700 (PDT)
Date: Wed, 17 Jun 2026 11:36:31 +0000
In-Reply-To: <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org> <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
Message-ID: <ajKGv5ioLSassmND@google.com>
Subject: Re: [PATCH v17 05/10] rust: page: convert to `Ownable`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Igor Korotin <igor.korotin@linux.dev>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, driver-core@lists.linux.dev, 
	Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="utf-8"

On Thu, Jun 04, 2026 at 10:11:17PM +0200, Andreas Hindborg wrote:
> From: Asahi Lina <lina@asahilina.net>
> 
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/page.rs | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index 3bdcee0e16a8..844c75e54134 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs
> @@ -10,6 +10,11 @@
>      bindings,
>      error::code::*,
>      error::Result,
> +    types::{
> +        Opaque,
> +        Ownable,
> +        Owned, //
> +    },
>      uaccess::UserSliceReader, //
>  };
>  use core::{
> @@ -105,7 +110,7 @@ pub const fn page_align(addr: usize) -> Option<usize> {
>  ///
>  /// [`VBox`]: kernel::alloc::VBox
>  /// [`Vmalloc`]: kernel::alloc::allocator::Vmalloc
> -pub struct BorrowedPage<'a>(ManuallyDrop<Page>, PhantomData<&'a Page>);
> +pub struct BorrowedPage<'a>(ManuallyDrop<NonNull<Page>>, PhantomData<&'a Page>);

BorrowedPage<'a> is no longer needed because it's just &Page.

Alice
