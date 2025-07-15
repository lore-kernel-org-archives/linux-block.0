Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BB9272E56
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572464; cv=none; b=undZ00CDvIuxWtb9Ot3hmIwgddJwbyFZFXi1rwF9EiRrORSxLLe8HILTXC4h/EyKDmi+PZu0hvYTnVqjfDFPIeKtEO4nAoEhU8T0KQCJVqqzVliCrKLpjXX1+/E6aiSg73p6L0XVEOBIFwZxJiPjV26DwxrWx4IVKgUQx1jlZ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572464; c=relaxed/simple;
	bh=JqDdcfQdEDJOh4OncebmRMNbfmeS+RyF0B608pIf4Tc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lnkUYZzbc50PMw2jcjUcC/DcX0Ls29dpZ8CK5F81KJsPAturXujGzRJLQno2IgwyrRcDD/0MD69X1FvfUWeWJHyKZhnq0woZf2vpvJaIExrug4BP61Rg95+bpMm2YKD80sS7hneoCNV+sflH6y2GXBrUAG8ZOErAbFS8ygFg1zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DuxESk9L; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DuxESk9L"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-ade5b98537dso585774366b.2
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 02:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752572461; x=1753177261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0aKhbD3D+7KTOT18UwrPb+VSeMuW0rSuyUidAagH1dk=;
        b=DuxESk9LXLCTqw//q3zsLK6d59gyUavEnojy+HO8SJsl3NuXu9BHK9odO6yA/bMMLV
         RNn3DV3Jz6c8Um+CLDwsgJRA0aaQ6yUtAh/mV2ndlxKPQbPm/C/uWUc5sz3zbNOF3FeJ
         ADH8Lb3oXE5uJ7kzM7Lsj0CCp/gnSsxl+bLgToXjMnPACiNElqTK/mOHE3q7kq2Jipb0
         DZh325yMnb52LEuLjfT4hQdTl3XJMGJ41yFhUszJeoL5t2oxLgJa9CEBHvLK2LdhK2JC
         +WO+El/QEOsqye9L2aBwkWIEfTt07qS86nVSuI3YuVLM8qL2ykd6zu/UMUlj8Y0iXOCP
         6XKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572461; x=1753177261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0aKhbD3D+7KTOT18UwrPb+VSeMuW0rSuyUidAagH1dk=;
        b=fvqmHcgjVfhCJGJ4X4aNfLCv/v06xxoQpjHiXH7SsqfCrslFaFOzdmfrSN6ndTFCR2
         BmhPUBI9gXQ2midKiLdbxocRCpnL4IlisYYTJ8WsHhTmASf+y+KORB1b3Flfu8EHUiq6
         LiRXsaOEOCPE1Sw2Z2fKxekfCOxCYqZdCHLZXoFuVVkkaxzmYQkCyWPZZzuJ5CH6sSsL
         SDLfXt1EIu1GMl95tgkpJawiR3MzqKcjQ7T6SvWuGbY4+iMJwTTY5w/AB2gL+Y7EwPea
         XKRB8qanIMrGXRl0UGrNps65MgUd6WA7k5cgz/Mt3I0AAHwrix+IKzB34Q0r2uUjj6hL
         Kpyw==
X-Forwarded-Encrypted: i=1; AJvYcCUXhUZmFnBWIb6VFVZNFxvnExgVjS9qKb70BWQMphnOOUAioW2RlkC8UwGNGE3rI6O41Php/CkuxRGBtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YykkAUNAH+Q3N+KEKvEjQDmW8Zx2G/AZ1Mo/tXs4uqIMzPZeWnI
	1eClA9HgpLJLW5eT6dHtqNoWlJIrekxmlUIDlx1r1fcD52gRPT+rwWaSDF/ZzcOY5nQzdyUatHW
	jIpxd9ke0NAjOwqxrwQ==
X-Google-Smtp-Source: AGHT+IErrNlePgQ6rL1zFxiVjv41kdZLhL8lPvBaFoc/gkVv4LYI0ZeP76kWXRrZLOeY2AQR9VmxeP4Uuhyl8N0=
X-Received: from ejctl10.prod.google.com ([2002:a17:907:c30a:b0:ae9:342d:ee72])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:7308:b0:ad8:a935:b905 with SMTP id a640c23a62f3a-ae6fbe7f231mr1714518266b.22.1752572460745;
 Tue, 15 Jul 2025 02:41:00 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:40:59 +0000
In-Reply-To: <20250711-rnull-up-v6-16-v3-5-3a262b4e2921@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org> <20250711-rnull-up-v6-16-v3-5-3a262b4e2921@kernel.org>
Message-ID: <aHYiK1cr3I_ShQU2@google.com>
Subject: Re: [PATCH v3 05/16] rust: str: introduce `NullTerminatedFormatter`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 11, 2025 at 01:43:06PM +0200, Andreas Hindborg wrote:
> Add `NullTerminatedFormatter`, a formatter that writes a null terminated
> string to an array or slice buffer. Because this type needs to manage the
> trailing null marker, the existing formatters cannot be used to implement
> this type.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/str.rs | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index b1bc584803b0..c58925438c6e 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -838,6 +838,56 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
>      }
>  }
>  
> +/// A mutable reference to a byte buffer where a string can be written into.
> +///
> +/// The buffer will be automatically null terminated after the last written character.
> +///
> +/// # Invariants
> +///
> +/// `buffer` is always null terminated.

Since you modify the buffer range, the actual invariant is that the
first byte of `buffer` is zero.

> +pub(crate) struct NullTerminatedFormatter<'a> {

Isn't it called "nul" rather than "null"? My understanding is that
"null" is for the pointer case, and "nul" is the name of the ascii
character at codepoint zero.

> +    buffer: &'a mut [u8],
> +}
> +
> +impl<'a> NullTerminatedFormatter<'a> {
> +    /// Create a new [`Self`] instance.
> +    pub(crate) fn new(buffer: &'a mut [u8]) -> Option<NullTerminatedFormatter<'a>> {
> +        *(buffer.first_mut()?) = 0;
> +
> +        // INVARIANT: We null terminated the buffer above.
> +        Some(Self { buffer })
> +    }
> +
> +    #[expect(dead_code)]
> +    pub(crate) fn from_array<const N: usize>(
> +        buffer: &'a mut [crate::ffi::c_char; N],
> +    ) -> Option<NullTerminatedFormatter<'a>> {

Can't you just call `::new` where you use this method?

> +        Self::new(buffer)
> +    }
> +}
> +
> +impl Write for NullTerminatedFormatter<'_> {
> +    fn write_str(&mut self, s: &str) -> fmt::Result {
> +        let bytes = s.as_bytes();
> +        let len = bytes.len();
> +
> +        // We want space for a null terminator. Buffer length is always at least 1, so no overflow.

overflow -> underflow

> +        if len > self.buffer.len() - 1 {

this is just `len >= self.buffer.len()`.

> +            return Err(fmt::Error);
> +        }
> +
> +        let buffer = core::mem::take(&mut self.buffer);
> +        // We break the null termination invariant for a short while.
> +        buffer[..len].copy_from_slice(bytes);
> +        self.buffer = &mut buffer[len..];
> +
> +        // INVARIANT: We null terminate the buffer.
> +        self.buffer[0] = 0;
> +
> +        Ok(())
> +    }
> +}
> +
>  /// An owned string that is guaranteed to have exactly one `NUL` byte, which is at the end.
>  ///
>  /// Used for interoperability with kernel APIs that take C strings.
> 
> -- 
> 2.47.2
> 
> 
