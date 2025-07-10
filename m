Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2E28C2B8
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137270; cv=none; b=AaKff5Fbxmd0JyBh6csRw7UJLd1ZJHPILZDSWn/q2MfBzC1BWmwG4GzP2yKFxYz60FnyXDempfoYmf46zuNKhjbEYxfKgRafwV5AO13cu5GIjbPj9Mk1e7roHONG0Onl1HQAhxNIWHFpJGoqH54yIttIfQ3TV6e4jbrjvp6nBEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137270; c=relaxed/simple;
	bh=57V0TYHG4HiRpDjObfiX8523KoBb7uejRCFwjUXkGuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gOsvS74DTbGL+OraXvCsLPayiYCM2v+wQFD+5dk7JNox6ap02xr+zrdJTLST/Qc+QjDIBq46botndMr2XSebirIiFb8W4ghgcTUkpiefb0Os0WQvbPlhBywADdNQNUJS/CSfT5bVJIXZGV/G2Rrbj6pVLjWI+MqfDLHOIZcwYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g3iH74tM; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g3iH74tM"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so3782605e9.0
        for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752137265; x=1752742065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiT+cF5jie4GC59R8tbVZyTkxmY5kyeE7d02aQYTPCo=;
        b=g3iH74tMDT98LkIjPjN1EVqMQnCHFxDi8QJeab45CF+BsyIqroNFjo/6z4eXeCs92E
         KmWmHphBvcOW8o1cFA7AxMFrCjg68tNK/q6TXiHkmQ4u2UYhHdlcRuxENacdD3GCU0w5
         W5GcAXSayuA0N6AIgQhatV8FzfRbbA74uOjSas5JvYqSpSa7QRTc+CfovBt/Gc1Gorj+
         7pDW3q4UG3zfn0rF/16qJVvDNwUXCwnAmYT2z5J3qhwGbPIHmDhRbOGtl8H50SfMgFwg
         3v5ploEMWoSeC19ERIy6HtjTDwLrvgtQXvBmo/hiHxv/goIe60aTaGxMrQ9gIuv9JJBu
         oUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137265; x=1752742065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiT+cF5jie4GC59R8tbVZyTkxmY5kyeE7d02aQYTPCo=;
        b=GFo1JtsioNn/HJ3+YmO1nYW4gDX4+sqHU6QuMstQ0BtKUvs5X7D/nykKYvRMRC6DeG
         3YXFcVfIVHDuobg9i0huKfhjb7sDqqm36SSXO30Fw0ssipX/jTrSrQlrHAJ6gQCnhqKM
         reErCUBoyT0vpUQauKk2UgS1sTEmxjD6P27gl8tocVn3SY///+FYsyU7TH5bW7iecwR2
         p+Rwk4/YCsuSmAfxLVDJrQuLfju+xs15ztcgGbj4Kj8jttnmCXn+AJmyr+dQEQnjYJEv
         m987xrLIelR6l9MyCQSbgZpNipEqnb58mfy8YWXDkYqI+xbD0XeNyk5aBGRfh+0UJRvg
         1YjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7rRe5jbkCY/Mu7zvqfpAO51i8RdbVK/2nWTrmCxXgSwIrKqWh3r9jElIK8XSZW3CekZS5zfqEOdrm2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCRRUJa5CVNFUpEJdJ6+JR3/z0jntK1xlLl8dagxaOVIAII6gu
	TN01pX1u0pebxwIN2TAVmKj8+FpgvQ7tPpxL57CbVMYxZNwPS8ga+/N5s5Z9NlpuB99sNEpdztz
	eN5h297J+8p+fnQrapg==
X-Google-Smtp-Source: AGHT+IGK69YzUiltyubhCeTYslvStKPrTGYmrpcKUFP45k02gQ/9NltQd70XDpa+u73OYmjTLWZ0yP9DJqMc6GE=
X-Received: from wmth15.prod.google.com ([2002:a05:600c:8b6f:b0:442:f9fc:2a02])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e55:b0:453:5d8d:d1b8 with SMTP id 5b1f17b1804b1-454db8909a8mr28725405e9.30.1752137265730;
 Thu, 10 Jul 2025 01:47:45 -0700 (PDT)
Date: Thu, 10 Jul 2025 08:47:44 +0000
In-Reply-To: <87qzypjrdm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
 <20250708-rnull-up-v6-16-v2-3-ab93c0ff429b@kernel.org> <kpVk60lBMPJ_b4glgS0w-BfbIjN1cMCDSKDoM0RAB4p1Bg1BNfIdA4YRuOu70BbSZjlserkd8EJDwy0vVmR7yQ==@protonmail.internalid>
 <aG5tObucycBg9dP1@google.com> <87qzypjrdm.fsf@kernel.org>
Message-ID: <aG9-MAwbNbjuoR0i@google.com>
Subject: Re: [PATCH v2 03/14] rust: str: introduce `NullBorrowFormatter`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Jul 09, 2025 at 05:49:57PM +0200, Andreas Hindborg wrote:
> "Alice Ryhl" <aliceryhl@google.com> writes:
> 
> > On Tue, Jul 08, 2025 at 09:44:58PM +0200, Andreas Hindborg wrote:
> >> Add `NullBorrowFormatter`, a formatter that writes a null terminated string
> >> to an array or slice buffer. Because this type needs to manage the trailing
> >> null marker, the existing formatters cannot be used to implement this type.
> >>
> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> >> ---
> >>  rust/kernel/str.rs | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 59 insertions(+)
> >>
> >> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> >> index 78b2f95eb3171..05d79cf40c201 100644
> >> --- a/rust/kernel/str.rs
> >> +++ b/rust/kernel/str.rs
> >> @@ -860,6 +860,65 @@ fn deref_mut(&mut self) -> &mut Self::Target {
> >>      }
> >>  }
> >>
> >> +/// A mutable reference to a byte buffer where a string can be written into.
> >> +///
> >> +/// The buffer will be automatically null terminated after the last written character.
> >> +///
> >> +/// # Invariants
> >> +///
> >> +/// `buffer` is always null terminated.
> >> +pub(crate) struct NullBorrowFormatter<'a> {
> >> +    buffer: &'a mut [u8],
> >> +    pos: usize,
> >> +}
> >
> > Do you need `pos`? Often I see this kind of code subslice `buffer`
> > instead.
> 
> How would that work? Can I move the start index of `buffer` in some way
> without an unsafe block?

Yes. I think this will work:

let buffer = mem::take(&mut self.buffer);
self.buffer = &mut buffer[pos..];

Temporarily storing an empty slice avoids lifetime issues.

> >> +    #[expect(dead_code)]
> >> +    pub(crate) fn from_array<const N: usize>(
> >> +        a: &'a mut [crate::ffi::c_char; N],
> >> +    ) -> Result<NullBorrowFormatter<'a>> {
> >> +        Self::new(
> >> +            // SAFETY: the buffer of `a` is valid for read and write as `u8` for
> >> +            // at least `N` bytes.
> >> +            unsafe { core::slice::from_raw_parts_mut(a.as_mut_ptr().cast::<u8>(), N) },
> >> +        )
> >> +    }
> >
> > Arrays automatically coerce to slices, so I don't think this is
> > necessary. You can just call `new`.
> 
> Nice!

I'm guessing it used to be necessary back when we used core::ffi::c_char
since &[i8;N] doesn't coerce to &[u8]. But now that we use the right
c_char definition, that isn't the case anymore.

> >> +impl Write for NullBorrowFormatter<'_> {
> >> +    fn write_str(&mut self, s: &str) -> fmt::Result {
> >> +        let bytes = s.as_bytes();
> >> +        let len = bytes.len();
> >> +
> >> +        // We want space for a null terminator
> >> +        if self.pos + len > self.buffer.len() - 1 {
> >
> > Integer overflow?
> 
> In the subtraction? `buffer.len()` is at least 1, because of the type invariant.
> 
> Or do you mean I should do a checked add for `self.pos + len`?

Ah, I guess self.pos and len are both <= the length of a slice, which is
at most isize::MAX, so the addition can't overflow an usize. Would be
good to comment this, though.

Alice
