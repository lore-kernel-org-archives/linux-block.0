Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BEF23B61A
	for <linux-block@vger.kernel.org>; Sat, 18 Oct 2025 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807390; cv=none; b=LN5vaN7gbNT6Y0ZY8ABoiMytLPJ4TaL8XfIsZCOA6NslXF8cl2cGVSUQGXlG15Fuat3qHExcTq0ctMgiMgkEOe++o6rWTa9e+VLcsjhjJBnHE3yePRtV9l8PK+taI8GVWMmngGpi3klLmTB6d826GCa+i54+tFLBbKCQFJvuGXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807390; c=relaxed/simple;
	bh=odtCe9zBLcd2KigvnEagfj6Hjlz+S098qgy/zAjyk5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mEH6C6Cg6+744IAMvZB8JLhjMJISua9H15v9KXTnX/qnWddgfYpGn3xJrYJX3GS34Gu5gDxQchXgmwkyAmS9Ol0OZnDbG4nv2kI7mXFYUYJp5rN3g4KchYMJG4xZ01Jlpt4QPd9sUldiQixak/CoS5piqxpeCkCZHOPfi4AaYwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2W1IKbe; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2W1IKbe"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4711899ab0aso20398655e9.2
        for <linux-block@vger.kernel.org>; Sat, 18 Oct 2025 10:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760807387; x=1761412187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gbgmXbo5t+1RIxOlN8V1tPuxrDnGp84UG4kpKP+4AI=;
        b=s2W1IKbeLEuX2kkxo9AybDWEDEm5rqNnkDaV/DCZDcr0M6r+aOVdhus7bB83epvYuf
         CfQos9YRn9xfGKMVJ3dtLfPW/AyRT3U/NAkz+FEHIwuEgELPVWAAqLoHTxd6i0Ay+Frg
         64BU/nqpOZAiTu4YijG6Wt3rsAnk5/+v55pEJ+icNmkTX6g2MHda3cZmgfXYt+0wQt5s
         JMMWH7elqV35qJZZmILPEgos39P2n/nEHhzD+SDeEwR7m0dE/0522ChttpOlSoXdgslt
         45Uj42+Eto2H85xG5oSev9Es3P4neIyc/0LilICNFNdkpU3y+ZFQ0moED2mm8mqZn4v2
         Tnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760807387; x=1761412187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gbgmXbo5t+1RIxOlN8V1tPuxrDnGp84UG4kpKP+4AI=;
        b=Cg7MxFp7SOe6ZSgwj8LF1yLu4x16kqxEfglNpWnIWHN03FlAc0IR1o5xkMZkqJNxzr
         km632Zf5/4yWTGhOuavjc7oDityRQV45PcFscjb854dehgO9p1JGzYmXB+Tlu9fyjPut
         LPeuQSM24hPft1N8FS480xWzOWWcvDPmpw3g0S9t6a0pfSXOaNx3+2J1fZoOpPb5cFJ7
         v/3z7OAL8snDu3zAVgJiAU0ptxN6YN1jNwasWWxlCDuaZWqjYp8wgyK9NyX8nvrVVT6T
         l/VmI0dJmw204hnN0UkGAGLAW8hr722yTR2CLghF/hJzGvTqdfQXBwHHTfFHmpzkdcvA
         F2Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUpz4BI6CytZF5CPRQEVq1AsHSenI4rgo9GdizzwC7MEZ3rapvYWf2PSu8uYK7scyQ8OWVVK380TT53Qg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9d6xw0AtQLBuhGW4jDSloWylAHFtAU70Lx8ffoRn1KZ9Z0aiy
	BVbZe1Emb0M6QQcvyXOc28UPkNBRZV0ZeIsQzXBnEXVP8wek59bJ+wQQRHGcX5YDcCDJOHWMHks
	6yj8W0hCh0GJoGtL8Vg==
X-Google-Smtp-Source: AGHT+IE2qIYxI4Vw1+ECgA1gn5ogbwuagPgH2cctNTftSEDiGSn1/+RvZtZON2v3lqv5N/Nfcs1I9R9CXWA7rAA=
X-Received: from wmwg2.prod.google.com ([2002:a05:600d:8242:b0:45d:e2f3:c626])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3512:b0:471:12c2:201f with SMTP id 5b1f17b1804b1-471179134f0mr67710035e9.32.1760807387121;
 Sat, 18 Oct 2025 10:09:47 -0700 (PDT)
Date: Sat, 18 Oct 2025 17:09:46 +0000
In-Reply-To: <aPPIL6dl8aYHZr8B@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com> <aPPIL6dl8aYHZr8B@google.com>
Message-ID: <aPPJ2qDhxXNh8360@google.com>
Subject: Re: [PATCH v17 00/11] rust: replace kernel::str::CStr w/ core::ffi::CStr
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, Oct 18, 2025 at 05:02:39PM +0000, Alice Ryhl wrote:
> On Wed, Oct 15, 2025 at 03:24:30PM -0400, Tamir Duberstein wrote:
> > This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
> > have omitted Co-authored tags, as the end result is quite different.
> > 
> > This series is intended to be taken through rust-next. The final patch
> > in the series requires some other subsystems' `Acked-by`s:
> > - drivers/android/binder/stats.rs: rust_binder. Alice, could you take a
> >   look?
> > - rust/kernel/device.rs: driver-core. Already acked by gregkh.
> > - rust/kernel/firmware.rs: driver-core. Danilo, could you take a look?
> > - rust/kernel/seq_file.rs: vfs. Christian, could you take a look?
> > - rust/kernel/sync/*: locking-core. Boqun, could you take a look?
> > 
> > Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vadorovsky@protonmail.com/t/#u [0]
> > Closes: https://github.com/Rust-for-Linux/linux/issues/1075
> > 
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> 
> You need a few more changes:

One more:

diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index 69efbdb4c85a..5489961a62ca 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -156,7 +156,7 @@ macro_rules! declare_drm_ioctls {
                         Some($cmd)
                     },
                     flags: $flags,
-                    name: $crate::c_str!(::core::stringify!($cmd)).as_char_ptr(),
+                    name: $crate::str::as_char_ptr_in_const_context($crate::c_str!(::core::stringify!($cmd))),
                 }
             ),*];
             ioctls
