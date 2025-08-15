Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E672C324C
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244647; cv=none; b=ebMGKzftLqcmmewFsdlCeus1+YQ9uVRSB5Ac28/SF64TxDWepE1QtMZ3L2S2tKAURlxHUOxv0wUC2oE2G2V9TggaXGzRRyJMSO6p/vw+9Y/MiXd6Vd8f5OHJtnfVC1PHGlJU/pzZCC7LPxRv7Eog5HrwFQSZaQkryyvw4pRsSqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244647; c=relaxed/simple;
	bh=S3PyHRya11+qZZoLBhC4j0hGymegURexx3ja0gfDP5k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X1V7T1pnszYtG82YgtBl3h0BvS3fZwVXpILO68q0iEpGSTuly3eKqc2D82HPmh0VqxBTzeslOBspYY0sBY8Qy4tld4dlcI+uWMC5d52as+bN2ZyHnnl3Mpal/SEvxfXa0UUk6cyLDnAGoGH4ma2euuNvS8Ws0JvHEDlWylbx52g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qj9AzmOc; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qj9AzmOc"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b9e40ffdffso1387722f8f.2
        for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 00:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755244644; x=1755849444; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JliYzecp+8vx7iCZ9GJLeCQ8PS5q6wpUw4vUME/s30E=;
        b=qj9AzmOcz3WUQgVM4tdjs3eex1wsrDoeEJjNl3xnmVMPb08wEluHqA++N9Fe7RHUdB
         QR0b4yXBfF5tJAYpDB6hsjyDuZf3pCQeYscuguRifQSaarqsHpJRBANyLjoEqyWUhgbR
         lhZdNA9lHGeod6htN/XYU+av0ljusDFLNfNDPkOhYbxOyd7yuXTi1H85sB8WZ9ywbT2Y
         d8KjLBdBQXU2+Q1xSHWszHt6DrKyKktAjc5IYK1sf9KBMd+f1e9/XEKCDpQTVK1Emlxs
         ezwn/XtSjmuYQwV0zkwVOjcEZj2rdyf6u8O3OrJzggQhl0M30WNnABVso9ChiDg8rjlN
         QGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755244644; x=1755849444;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JliYzecp+8vx7iCZ9GJLeCQ8PS5q6wpUw4vUME/s30E=;
        b=EgcaxMJuv1AZj0mFQ6k4kG3rCm+ISpwt3boG+tb2U8vlYZiMIWUbC/9M7T6B8HaQkM
         MjqHvH628Yrn6VBxNcw906ynf6PAdJjL9bX7nfST98bIc2tCrPzL/Xsiz/Yvas/q5Mf4
         3KTEsjwFqAbxJMaRCSKtVXBDV7Uk/JpzD/rg7tglm1rOpUbiZ369a8xkvmJXhnNwz4qB
         iXikHMWEI/lAIGg2PYl1oguOyZ/tF0yblAW4HEGZh21Mqb81KK5rSzPGzRgqmX+qhkpn
         zZWzOHBJZh1b6Z0qCypIXxLbY2f0Z8Wdp6YFtsAqaeBSJUaNu5wGFDkU+TM7U1OLV7Yi
         LKpw==
X-Forwarded-Encrypted: i=1; AJvYcCVj5JcRl34XRlCkOpV0U4BLFHg0MWX+sabvMOoe5zYK+I3Q/fnSPkWo0DOBZEyw+p1EVPHvNpgmdNa0tA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSABuiFbYBHPT/hMMx9bdwlltriyWPYneyREWT8Nihf28Naj7w
	AkO0yzBjpEeO2zb9kUPGKwmnXsZdRzgLbx7kdlcTMcbsVDW1wMNrOCNA+mUkgUylGcBWxECsAt8
	HgC3cfZti2H9ljFdVrg==
X-Google-Smtp-Source: AGHT+IF4UAIGeGPcDCFJRIRqOWfB2t00wIC/GdVYBLo4fLARPgG9tdEIjrdMKNGCFc4KqwkU7tZqFWVeQcaemCw=
X-Received: from wmbep25.prod.google.com ([2002:a05:600c:8419:b0:456:2003:32a5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5850:0:b0:3a4:e68e:d33c with SMTP id ffacd0b85a97d-3bb693b1d7dmr874644f8f.47.1755244644250;
 Fri, 15 Aug 2025 00:57:24 -0700 (PDT)
Date: Fri, 15 Aug 2025 07:57:23 +0000
In-Reply-To: <20250815-rnull-up-v6-16-v5-5-581453124c15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org> <20250815-rnull-up-v6-16-v5-5-581453124c15@kernel.org>
Message-ID: <aJ7oY9pxlrnfAv8s@google.com>
Subject: Re: [PATCH v5 05/18] rust: str: introduce `kstrtobool` function
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Breno Leitao <leitao@debian.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Aug 15, 2025 at 09:30:40AM +0200, Andreas Hindborg wrote:
> Add a Rust wrapper for the kernel's `kstrtobool` function that converts
> common user inputs into boolean values.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/str.rs | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index d8326f7bc9c1..5611f7846dc0 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -4,6 +4,7 @@
>  
>  use crate::{
>      alloc::{flags::*, AllocError, KVec},
> +    error::Result,
>      fmt::{self, Write},
>      prelude::*,
>  };
> @@ -920,6 +921,63 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
>      }
>  }
>  
> +/// Convert common user inputs into boolean values using the kernel's `kstrtobool` function.
> +///
> +/// This routine returns `Ok(bool)` if the first character is one of 'YyTt1NnFf0', or
> +/// \[oO\]\[NnFf\] for "on" and "off". Otherwise it will return `Err(EINVAL)`.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::{c_str, str::kstrtobool};
> +///
> +/// // Lowercase
> +/// assert_eq!(kstrtobool(c_str!("true")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("tr")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("t")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("twrong")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("false")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("f")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("yes")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("no")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("on")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("off")), Ok(false));
> +///
> +/// // Camel case
> +/// assert_eq!(kstrtobool(c_str!("True")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("False")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("Yes")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("No")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("On")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("Off")), Ok(false));
> +///
> +/// // All caps
> +/// assert_eq!(kstrtobool(c_str!("TRUE")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("FALSE")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("YES")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("NO")), Ok(false));
> +/// assert_eq!(kstrtobool(c_str!("ON")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("OFF")), Ok(false));
> +///
> +/// // Numeric
> +/// assert_eq!(kstrtobool(c_str!("1")), Ok(true));
> +/// assert_eq!(kstrtobool(c_str!("0")), Ok(false));
> +///
> +/// // Invalid input
> +/// assert_eq!(kstrtobool(c_str!("invalid")), Err(EINVAL));
> +/// assert_eq!(kstrtobool(c_str!("2")), Err(EINVAL));
> +/// ```
> +pub fn kstrtobool(string: &CStr) -> Result<bool> {
> +    let mut result: bool = false;
> +
> +    // SAFETY: `string` is a valid null-terminated C string, and `result` is a valid
> +    // pointer to a bool that we own.
> +    let ret =
> +        unsafe { bindings::kstrtobool(string.as_char_ptr(), core::ptr::from_mut(&mut result)) };

Using ptr::from_mut here seesm excessive IMO. I think that function
makes sense when it replaces an explicit `as` cast, but now when it can
be done by a coercion. This is perfectly readable:

let ret = unsafe { bindings::kstrtobool(string.as_char_ptr(), &mut result) };

Or if you insist, you could directly create a raw pointer:

let ret = unsafe { bindings::kstrtobool(string.as_char_ptr(), &raw mut result) };

Alice
