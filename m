Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF54139D0A
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245569; cv=none; b=dHW6REayHyYpYcN4suUyvEVAmqwUz6l+IyvxLMapBrT9UOh/315FmZzruphGhDgvekkg4UMbqLvvWiUSFqi9NKGXHxHj9U6SoolPp7wotNRfU8MH0Ef18o47oCt8VetpFgbD30xQaZxrnoQ3XbecW9L1UKDEZkhpJxJ5kUy9Eo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245569; c=relaxed/simple;
	bh=abhrhcISpQjbyoZdKXYTQQvSjPCiAbh+YQdM6HuPjgw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WgygjDMn8we2usb4A/NH0cOLND0JfwGcwokldu2zj/wbIttfLclaIF+u/zbPjSH0chQsJmF3F/v05GDitMM9bt9jb5gnFStziRW76qDlygqXo7TeS+29C3QGuEOEyWdPCyzL1SZPT4LB6LkAQsckIT9ptTHAlArACH9CdyG7EO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPtGS6EC; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPtGS6EC"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0cb0aaso10553475e9.3
        for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 01:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755245566; x=1755850366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BUuLc6GQjc6I3bOha/5f7UPoVVJZ0dlyEwJUu9zoAI0=;
        b=XPtGS6ECWHx1cp5EPoxTOS+/Q8aYHN33m8H48dnkFACDmbdaoJ2iBPmORHYjsRs9/e
         iMuUgWCaUJRLvZNEeCGJ6RX12JiUj3FgRTh9H/tCpyAOnhZvkSkPHisPTks30FbxdSft
         OWR5hAhyMHoh5Vro8cM7EXXKZweS0Jhs7zBFY8ctr5kssHF01bYIoAEdqemjTDMrBjgg
         ZtmyU+jQVPYv5Gae4L415L+j7acAsbA0F+0jZe0SWKTwCCAUvRrEkppzl8YI3fK7CYUK
         Zgf9EWoG0u2zrAYLyQXjgmUfwo+mvm9wCDT7obeRuF/v/A4M72olQJa0hms6tohoRlJA
         OnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755245566; x=1755850366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUuLc6GQjc6I3bOha/5f7UPoVVJZ0dlyEwJUu9zoAI0=;
        b=JWrUujyqjXf4dwG90KZaNx0sZRPbzRgDffUW9On5fo1tjjdJJuHE4a/f5py461W6te
         AsPyqpLtUgMl8ICwkMjGukYX5Aay9tVHoueLLy8moIaZHDtElFmsdummXAE7cbPDWrXN
         mxEDUfpVKLK6NGDlsX8XG9SL19n0WIk2Sw1bvZMfTFzXdCURpGLPENx4CA31uF3/mXTW
         dM1+581O22ffzhaNLlRL0TbQRxv0/XwOwDsd6F3KiEA0HIZNks/sHSrC4Dh+bykhwKFH
         3Q9UXYq4l8GjrdaTuvQIqPxWoZODXU0TMqh0TMuDxJisLrfnYlq40TqOQguGOb2qVf+F
         azMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1X84gQH2fra7pGw03Mjjlrr1nIet8L8QpBtLl7laCOSxcIlYfZqtja2kD/U6Gmvxr7QHPt51PBI/9ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFjUt1lZHyj9FSJ/7LKWdVjSsz86AoBRMYYeB0eusT3XEOk8Q7
	jO6ccWKQ6PQk69W6jtnT9yU8V8xlvlw7rIrt+g6ivys9Rckwm0Zzh8z+iHpKXA1OP00d/yt8+p4
	ixRj5a8wwqIC08YJ39A==
X-Google-Smtp-Source: AGHT+IHe7CyNgbL/lpgK6820FIeZcTErDvAuNK2XAyJAFEs6HJRHhOHCUqfeT/GDizrcAd4+Ao4Fdo22KSX1xrc=
X-Received: from wmbeq15.prod.google.com ([2002:a05:600c:848f:b0:459:d6d6:554d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:138f:b0:459:dde3:1a33 with SMTP id 5b1f17b1804b1-45a218631eamr9819375e9.26.1755245566429;
 Fri, 15 Aug 2025 01:12:46 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:12:45 +0000
In-Reply-To: <20250815-rnull-up-v6-16-v5-6-581453124c15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org> <20250815-rnull-up-v6-16-v5-6-581453124c15@kernel.org>
Message-ID: <aJ7r_W0BzdSYMfT6@google.com>
Subject: Re: [PATCH v5 06/18] rust: str: add `bytes_to_bool` helper function
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Breno Leitao <leitao@debian.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Aug 15, 2025 at 09:30:41AM +0200, Andreas Hindborg wrote:
> Add a convenience function to convert byte slices to boolean values by
> wrapping them in a null-terminated C string and delegating to the
> existing `kstrtobool` function. Only considers the first two bytes of
> the input slice, following the kernel's boolean parsing semantics.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/str.rs | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 5611f7846dc0..ced1cb639efc 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -978,6 +978,16 @@ pub fn kstrtobool(string: &CStr) -> Result<bool> {
>      kernel::error::to_result(ret).map(|()| result)
>  }
>  
> +/// Convert `&[u8]` to `bool` by deferring to [`kernel::str::kstrtobool`].
> +///
> +/// Only considers at most the first two bytes of `bytes`.
> +pub fn bytes_to_bool(bytes: &[u8]) -> Result<bool> {
> +    // `ktostrbool` only considers the first two bytes of the input.
> +    let nbuffer = [*bytes.first().unwrap_or(&0), *bytes.get(1).unwrap_or(&0), 0];
> +    let c_str = CStr::from_bytes_with_nul(nbuffer.split_inclusive(|c| *c == 0).next().unwrap())?;
> +    kstrtobool(c_str)
> +}

Ouch. That's unpleasant. I would probably suggest this instead to avoid
the length computation:

/// # Safety
/// `string` is a readable NUL-terminated string
unsafe fn kstrtobool_raw(string: *const c_char) -> Result<bool> {
    let mut result: bool = false;
    let ret = unsafe { bindings::kstrtobool(string, &raw mut result) };
    kernel::error::to_result(ret).map(|()| result)
}

pub fn kstrtobool(string: &CStr) -> Result<bool> {
    // SAFETY: Caller ensures that `string` is NUL-terminated.
    unsafe { kstrtobool_cstr(string.as_char_ptr()) }
}

pub fn kstrtobool_bytes(string: &[u8]) -> Result<bool> {
    let mut stack_string = [0u8; 3];

    if let Some(first) = string.get(0) {
        stack_string[0] = *first;
    }
    if let Some(second) = string.get(1) {
        stack_string[1] = *second;
    }

    // SAFETY: stack_string[2] is zero, so the string is NUL-terminated.
    unsafe { kstrtobool_cstr(stack_string.as_ptr()) }
}

Alice
