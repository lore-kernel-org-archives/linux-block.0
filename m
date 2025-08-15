Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C273727713
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245636; cv=none; b=djVOQopPqSS+3PSamBXaDc7EX0NRtbcScpUFacMcZycj2thU7L8AT9wcca0+BaqRhcv9hlE50sLOC1Stw/pGOf+d6oXE1gM/KaM3EzOiIxiLgSS4s/Z7cW7KZw/w78rZGajeCSuvqtk3PV9kTB/cExb4XIQzUGGAuKxLsAHCjtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245636; c=relaxed/simple;
	bh=hsWxra9q3X13ElQHCFuvspSvuybQPgvseoguKxJRnfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uat5af/bi7KaLk7MM2Rf8jQ4hE30Awze+mcsXQVsYCm+NbW4J2P+RF/yeSV552nhr/+KsCYgV11MqOGs6ftwI9UJFYDhTWPfWwdWuqQKUgfkP06y5XHDt1oGvWyXjyvz676YiAUyTArxu1/eiZaBBPDDOJS65BsR8ffrfN+kPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h+ipDgxR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+ipDgxR"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0d0feaso10843895e9.2
        for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 01:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755245633; x=1755850433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1f7kL6gjN2F1fV8ToMQJ5E9ndI3HLl8+wtRhuObA6Hg=;
        b=h+ipDgxRlZFOuC5crkpbLUCBs4kCdB2Zk93699NsY7Gw7hnouJy8mhjo1pOCqrCX2p
         Vfbz47YHDNTrve/nEel4bGlMxnnwucJrlGFbewY1JhnKLdi5ImEzxw6SfENPWwEoN7Mj
         UNAvW2WP7uCtO8vgoplINBhqGxDFryd0+1kCAsYMioK8fz5+duVnmKYYewPmdsPSsvWx
         bFyNHnKI1EnbCJr6OxMmHIT+7F28vdfXQsUdU43CNwTKpLR91PN9MUxPSnXQkrhEkO9l
         HCdbki/3gHfxolyvFJhHSJFvHINF9S/hpQTp65SLFhRZMirJ9EUSoY3VdjLOSnDVBZkA
         mbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755245633; x=1755850433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1f7kL6gjN2F1fV8ToMQJ5E9ndI3HLl8+wtRhuObA6Hg=;
        b=i6LaSLGR8Sspg6BGP9PZoMWVrOhOaNyAy9v+RaDZY9N0MEUwVgEL+H/GjAD0y4U8Ej
         /xx7zfcKR2G0LjXTpSrpyrNNFevkKOFfvBGKs4uieaAZb+Si62TlKRqDSv3baKVs+pB2
         dijkwwCxbjjrRQ+ihactQuqU5kNtMDUI8c9OjjJCbf0RkJp6GAW9hduCp8fYKp+I1bAj
         b6nj3nqprUNmZ1BfJogg5Z0GGDWip31KbvFIk97A/RFx2E0n0Jxd1GUuTYw8YKZOL/f+
         4rq1FYITt3n9kuCaoVl+L/0zgxYa2SG7G32Ts4Q/aYXMlUkyNl9udXLjNBP3Fx7NaaBl
         Dm3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3TbDyF+a+pEijZYx4VwhYmmkwKbcoc4Lc9L9+Ti8JBjpMtMnZ92+ZWTRQXzlq/JVXcVepJljnwdLZyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9pZwV+hX1Gu/fes9YQxhsllGmLUlgG8iYh172Ve+FRW5GFh7A
	8nrXtrj1uCNIQIOvpJ8oJYyfG2WLZ8nMmlqjQjqZnPB7CevkNjph1sc6dVJqBl3WIxC+x/U4q+W
	6zmMPjt4z06iMlNY7YA==
X-Google-Smtp-Source: AGHT+IFYd17OhDNmiLfiosyGDGjCTy9zqn/5SXr3YlG4Wt+k4EHu0NIK+WLSW+zValRgSH9t7RLNNnppVYd95ao=
X-Received: from wmbay33.prod.google.com ([2002:a05:600c:1e21:b0:458:bea8:57ef])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3596:b0:458:add2:d4b4 with SMTP id 5b1f17b1804b1-45a21803ebdmr11738045e9.12.1755245633160;
 Fri, 15 Aug 2025 01:13:53 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:13:52 +0000
In-Reply-To: <20250815-rnull-up-v6-16-v5-7-581453124c15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org> <20250815-rnull-up-v6-16-v5-7-581453124c15@kernel.org>
Message-ID: <aJ7sQF6ObVlwX3U0@google.com>
Subject: Re: [PATCH v5 07/18] rust: configfs: re-export `configfs_attrs` from
 `configfs` module
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Breno Leitao <leitao@debian.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Aug 15, 2025 at 09:30:42AM +0200, Andreas Hindborg wrote:
> Re-export `configfs_attrs` from `configfs` module, so that users can import
> the macro from the `configfs` module rather than the root of the `kernel`
> crate.
> 
> Also update users to import from the new path.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/kernel/configfs.rs       | 2 ++
>  samples/rust/rust_configfs.rs | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
> index 2736b798cdc6..0ca35ca8acb8 100644
> --- a/rust/kernel/configfs.rs
> +++ b/rust/kernel/configfs.rs
> @@ -121,6 +121,8 @@
>  use core::cell::UnsafeCell;
>  use core::marker::PhantomData;
>  
> +pub use crate::configfs_attrs;

In other re-exports of macros, we've placed it immediately after the
macro_rules! declaration.

Alice
