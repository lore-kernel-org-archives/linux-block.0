Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0162372B39
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657020; cv=none; b=EtZl1vfUzIMUy4kO8SHrt0HI9XtGKsA3Brpumm2FqbnLqn4sK/9H3EXA8OZUhAlAsw3kALrA6dluh3/DetN9q0CisWSM766f42d/W8AuQ6PtHI5/ROtN21HxFsyG6MXMc8ysS93cf1AliTtPXHE/Ac9DL/uyYoiAPFKWpLthxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657020; c=relaxed/simple;
	bh=SG87F33h8ujBo0C2w/pQHnQsga/jNHQfpXQk21n7QDU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t8WzgMuZsyu0ls7LIqROe/bwdC9vU1LXFHnKbefNFOdM47H3biRdmSISQDFiFdlFxkLViDYWFWg3ztstn8xrj4V9ozC0jMEkNDCy57o2KKUEYVOdA9q8uo2rmrKMI4uw+LyQLECCjwoQeIB6IT12P0kYSVSf4o9FkqQcALtLZGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=izu/RGpZ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="izu/RGpZ"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4852fbfc379so59527365e9.0
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 03:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773657017; x=1774261817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=94lhIbTPxgV+K8KYN274qmP1kh/M3SwTueiM469hswI=;
        b=izu/RGpZDywgsm0k4oD4jhvJ/iu7sNcLLA+TaVeDScN9uy5+p8ECIRVL1tX6y2dJJF
         jw+/ubYE0sJy4RmCpWbMzC7+QN6cYOsfpF2cqimrk2a6rmMn//DjsgaNVNOFp9JhcPha
         ZtR7iMd/TWR4mxvFGqlVwOSBZM7VIgausuejjRAz4+NghXatj0yPD6nPKmaPmVIlVrgf
         CxwncXrMioV6j4cctXjmlNXQV7OEMxrGoAANd2WJtHSz44C63HD9WVZ18OrucDcpf4TB
         4/yBfd/hpxscXM3wUcXQ1DcOw/CvgnkR3xgVMlAZQp7mg27IU/2k0NnV/Je7HWXOnzu5
         6cVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773657017; x=1774261817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94lhIbTPxgV+K8KYN274qmP1kh/M3SwTueiM469hswI=;
        b=mjhcAhp7niXFOoQM8ayx9jmCe19NIqdX+HHOTcAwUKIzZY5qSPWQ1kTCPPVk8nZlJE
         6Jn1cCZd1Vg9iDgKFf3pOp+tKQ2c8qdrK314fg1mCzXzsOPKDMhAzTrzegRHRDfizmOG
         CRUF0bOGM29qXPBwrXPr/KJ5x2zZKSjAggmsg0e0noMj5J9T/htoniyrHUMF+0Er8GVu
         k5cw9AcIEzghXzc0YdXAtJgOsSzgD+7NKWMTOSWam2O3ZT5fiAc44Y6BORd4h0jCm/SR
         wQeXDHDWJFlLmMHPDx8X6q++ZfK4+vN+wrzeCGGPFw/S8twcVLoNOzQqC5KAt2anvpAN
         jHlA==
X-Forwarded-Encrypted: i=1; AJvYcCXcG5IVLMwFzmI37TJGr7gGZTCe56EOlI0PVfJIal1kaWXTnL9GobLbXxO+eW5nlPpQKdfj0GnUdu6CzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSMrGYIoueOBMPlPZhxZMfXAMoM1QUE8/edjLHypdBkUbMx0e/
	hXL5itzPBrxU5Ao1KfZsmaC22SxFT/gSfNHUV8g5eQVBhpLwzR+VdeiCYD108bqhHI2HZ5oIHET
	2fzAxLLDMqCDnOClquQ==
X-Received: from wmej7.prod.google.com ([2002:a05:600c:42c7:b0:485:3ddc:f26b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f8d:b0:485:4278:24fb with SMTP id 5b1f17b1804b1-48556711dfcmr208483425e9.32.1773657017048;
 Mon, 16 Mar 2026 03:30:17 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:30:16 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-10-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-10-de9a7af4b469@kernel.org>
Message-ID: <abfbuJVbPtIEyweC@google.com>
Subject: Re: [PATCH 10/79] block: rust: add `command` getter to `Request`
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

On Mon, Feb 16, 2026 at 12:34:57AM +0100, Andreas Hindborg wrote:
> Add a method to extract the command operation code from a request. The
> command is obtained by masking the lower bits of `cmd_flags` as defined by
> `REQ_OP_BITS`. This allows Rust block drivers to determine the type of
> operation being requested.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

With the nit below fixed:
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/kernel/block/mq/request.rs | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
> index b49197a0c66d7..0dd329ae93dfc 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
> @@ -78,6 +78,12 @@ pub(crate) unsafe fn aref_from_raw(ptr: *mut bindings::request) -> ARef<Self> {
>          unsafe { ARef::from_raw(NonNull::new_unchecked(ptr.cast())) }
>      }
>  
> +    /// Get the command identifier for the request
> +    pub fn command(&self) -> u32 {
> +        // SAFETY: By C API contract and type invariant, `cmd_flags` is valid for read
> +        unsafe { (*self.0.get()).cmd_flags & ((1 << bindings::REQ_OP_BITS) - 1) }

Nit: scope of unsafe

	unsafe { (*self.0.get()).cmd_flags } & ((1 << bindings::REQ_OP_BITS) - 1)
