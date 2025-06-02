Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D18013AD26
	for <linux-block@vger.kernel.org>; Mon,  2 Jun 2025 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748853992; cv=none; b=e7DQ9/qXvUwcktvH1PBKSACv+zm5duso66Kf6PLHiVH/kmbrygPDKGdW8DT7SO7fKApTcuyRvAVUGhfsgcfohu+TtrFYHvmthx/R1yqQqCAgE1L9lPluwGSju9poHhvYeEEXb2wiAwRmPd4TrLM1VxRKaWxSfUKRrZyGGuAlBqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748853992; c=relaxed/simple;
	bh=jMbUYSpsToA7O3te9eApd0pFDpdOD0eqFMFbPLpvW2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XIitUbiuh0mS3iQauLdL9a5rjJfR0BsYDVJaYBUiA3CsxFi2DamXMgm5FGRWIKasFJ9MrKSZE3uMAE4CRqJVFb2FmjShmCN+vVIQGwDjvC2rKBazML/staDmJD/2UevmrUKGlSMK8tt2tRs0/L8wy9J7s1i74ekls+bHdSat7KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zh5H11YE; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zh5H11YE"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-450dada0f83so18544575e9.0
        for <linux-block@vger.kernel.org>; Mon, 02 Jun 2025 01:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748853989; x=1749458789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ktsVoxepsNTrdCKxowANypGkEb6jHKbHJKn1XhGy1Uw=;
        b=zh5H11YEjyHf/ZrGbGCtt0Ram36PTgfDVCpkP50fPzhGYifYz56NsRHr1SJDNOLkQ/
         K0iIa1gQLeNm/fTQQs/czGTGqMofzLe2kIGZYtnEa+BEwPMN7UyWN1IEcthJNN3RVcUy
         0Z7P2OkpuUPlOXy/X0P85wCgLYOEdFcCBqAJHOTcb4wGIUzFx63gWOmKA8CdR7tnTkj/
         Zz70blfHTTQpuj78I9t7GOjB5Mf744L7BHpQJkQhGqV18HSQgzt5WvCsdmR4R1upBO/A
         9MPR8B2tW4PgVrYLjVzx81Q6Bbx4p4HWo6rlttExAAA3/ib3ASiiG4OPZWaLzyvHrXdy
         ebLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748853989; x=1749458789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktsVoxepsNTrdCKxowANypGkEb6jHKbHJKn1XhGy1Uw=;
        b=fro7TbwkweH/qtczjpWDeCy2Y8sGHbbR+kusgIDEh9i+NUuEeXVjUZrlqg2DqM1dWf
         BjmbkhgpSrq9CO/yP3theY3xdGbjN7yMBpl1uG0rQhrvzW8lCUcXWVrWvVTiw6xjAlHJ
         TODMKyCUb0x0GQlhycoRBhXTAQyzKi+8sGd+zKgPhdSxh1x/5IS4M3YSwN7E0EYg06Ux
         zLh0Yu1IiN/gy1Xdv+6YkBOsvw2J7EnWbYtjsEm8WVTZR7SmcIKOa0g/IU8wHrMqDPG+
         wf72O36slgVYcJawtLpcK2gzld1Wz3YT+sDDlHiHA8b5xBvpwPm99M7EP/GJVj2ik68j
         m2yw==
X-Forwarded-Encrypted: i=1; AJvYcCVOJJP7Jk/0+DQNFfsvTMZhQL6LmJH/eMYbjLC/DohTbg+KCaSlmroWjC2byD6BH9epTbxsRr/+qRUgeA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+CKqV6+cndYxFz8uWLTnejf2bZqAV+w6+EZvxuw0OLRrht+j
	4Qy6iYgJHdlYZaADHepfc/wfu/+tSYANDI8XRfWuXEs0hwmiMr/Fa0nau8nknbSq8Rz64fWwmTl
	Y0XFzspnWHKHI4PNp9A==
X-Google-Smtp-Source: AGHT+IEN8wW1H0RTzFbTdIlqYAJYXEVRMaA4cvq7c8CG74BNxW0QzTAmaWpfyWc/gO5HljzZUpfF3+rdjR1DcgY=
X-Received: from wmbhc27.prod.google.com ([2002:a05:600c:871b:b0:450:d422:69f9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ec9:b0:442:ccfa:fa with SMTP id 5b1f17b1804b1-45121fb9373mr61377385e9.27.1748853988668;
 Mon, 02 Jun 2025 01:46:28 -0700 (PDT)
Date: Mon, 2 Jun 2025 08:46:26 +0000
In-Reply-To: <20250530-cstr-core-v11-3-cd9c0cbcb902@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250530-cstr-core-v11-0-cd9c0cbcb902@gmail.com> <20250530-cstr-core-v11-3-cd9c0cbcb902@gmail.com>
Message-ID: <aD1k4rRK8Pt5Tkva@google.com>
Subject: Re: [PATCH v11 3/5] rust: replace `CStr` with `core::ffi::CStr`
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, Benno Lossin <lossin@kernel.org>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, llvm@lists.linux.dev, 
	linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, May 30, 2025 at 08:27:44AM -0400, Tamir Duberstein wrote:
> `kernel::ffi::CStr` was introduced in commit d126d2380131 ("rust: str:
> add `CStr` type") in November 2022 as an upstreaming of earlier work
> that was done in May 2021[0]. That earlier work, having predated the
> inclusion of `CStr` in `core`, largely duplicated the implementation of
> `std::ffi::CStr`.
> 
> `std::ffi::CStr` was moved to `core::ffi::CStr` in Rust 1.64 in
> September 2022. Hence replace `kernel::str::CStr` with `core::ffi::CStr`
> to reduce our custom code footprint, and retain needed custom
> functionality through an extension trait.
> 
> C-String literals were added in Rust 1.77, while our MSRV is 1.78. Thus
> opportunistically replace instances of `kernel::c_str!` with C-String
> literals where other code changes were already necessary or where
> existing code triggered clippy lints; the rest will be done in a later
> commit.
> 
> Link: https://github.com/Rust-for-Linux/linux/commit/faa3cbcca03d0dec8f8e43f1d8d5c0860d98a23f [0]
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> index 2494c96e105f..582ab648b14c 100644
> --- a/rust/kernel/firmware.rs
> +++ b/rust/kernel/firmware.rs
> @@ -4,7 +4,14 @@
>  //!
>  //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h)
>  
> -use crate::{bindings, device::Device, error::Error, error::Result, ffi, str::CStr};
> +use crate::{
> +    bindings,
> +    device::Device,
> +    error::Error,
> +    error::Result,
> +    ffi,
> +    str::{CStr, CStrExt as _},
> +};

Did you not add CStrExt to the prelude?

> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -164,6 +164,8 @@ pub fn name(&self) -> Option<&'static CStr> {
>          if ptr.is_null() {
>              None
>          } else {
> +            use crate::str::CStrExt as _;
> +
>              // SAFETY: The string returned by `errname` is static and `NUL`-terminated.
>              Some(unsafe { CStr::from_char_ptr(ptr) })
>          }

Ditto here.

Alice
