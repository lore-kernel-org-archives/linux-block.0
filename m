Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58AB1A3A80;
	Thu, 19 Dec 2024 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641968; cv=none; b=hHJWSXFI8erFCeTvsNYisRFCGk42fwwcfoPCIyh/2ClT8hCEJfJUCdv1uU6v1mZWSNAAoR7VqG3SJDxODvxFH3Nb3PW22gYHbTk0CX+UGbr3pIByixcUlvSnTSEiJGrDqT7F81lTIf2BTDUxRM/pAG51Wic2zN2PqrEiRdkarkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641968; c=relaxed/simple;
	bh=V7J/LAhSIPTXjimVIbXDd3f2+rXpgilX72JEzf/sZts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zvu2rTh3Og4tf83jQYohBquPrcqBDrsGNX6Aq2unGaTY+twdUc7cJRUt0Uz1TiBFCja3DF4g09X/pfmzNh+gFdh1kNp3lRQbn0aT3RWKFb32Q2Xlu3ewx8yvpj7zHuTewBI1I6cVetlfCBFBMnoAk09en0VMQXqforrPFzeD16Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HISu6lUj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HISu6lUj"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725dc290c00so1919410b3a.0;
        Thu, 19 Dec 2024 12:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734641966; x=1735246766; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2Jk2YHJUust1FHTygKl17EVvckqZVKe7okhPqKlraM=;
        b=HISu6lUjzDeiRo8Xfp4dfry0ZTD0im9RTK9XUZRsCEE61iVVao6W7XwMiifvaSfVmQ
         eR6lWQbB6xXvGWF+d9gpS2mlGhe81kmJ0O7epwsmjuWvhXS/MOc5jr+Alh1ODLNkh610
         pvqasSGkCh0UTWXPaZy/XU+oEvUjwk6xtn0SviwBSen+wck7G9dn07aLHVz/Fnd94kC6
         qZF+bp2442kXsT9IMxcIC2iD5uI7LAkrEbYGNMcPxIdtIANZ6n8JoUMs4rqZgllWKNJH
         xrhIevJ7jmGCgNbOEs/lGjqjnFWBDkBV8uvtp8dqooMzOdnVXqoslHihLV16ItbI9a7s
         rwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734641966; x=1735246766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2Jk2YHJUust1FHTygKl17EVvckqZVKe7okhPqKlraM=;
        b=HPD+70cSvJ+iSLlETLCR1UV4k+yqa8HDGhbFrfOMyh321OkBnwAAunShu0T1yVvx6Y
         Hlnd8ZHlgeHnmKKf81v5LX176ZkkTq4GN/Uv+RT0DLhriuYIh0WZC1vhWa8edhT0/rt+
         LqVzTsMOPOFjONx82jSifVNMTVn/KT0mgXExI8EDPEPnQo5Mkkf1LpT1q1tqcwbomd76
         COkPIIBCcjam4bK+2SBp6Anjic6Ij01rmFx+R3BPRzKWICCcdKYrNcEYFr2xs5Dir7iB
         uCT5DO4x+fVLG5VHL3gC6Djm4nhDFeOwotvqSI24Ppxqz4AdUgQfH3C0TqFORwUUgsP7
         20Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVnrJAdsv9l5o03ragFnV3k9nG//wmQq093ihpgOYKARXKh6TCRzTQ693D7Em3enK7nJPva5X9W@vger.kernel.org, AJvYcCVw86DU+Bj67lA+lHzT81NFSJtJRhj9EqA4jVxob3GL/CNpBfoEWNApgaDgjrcVeRSQg5HkoXRrqNsQmQ8=@vger.kernel.org, AJvYcCWaZLQQsVgdl5N6wl4ABuQqZzBoEJ0bnZkQ7Hx/riZ80Y8whz5rZ+DvwYJgyZKCJdNMIWS5Er6z/oQCG6bILws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQqww1EUlLxM8XvzlhECVVc5i3EsrHYhrjllSQ+nlFdgtmBJ5I
	FZTBMZGKGz0/92u4t9zNrg5AbOaXt9t16y25Wz72mfzSOedy7FEC
X-Gm-Gg: ASbGncsxvhHGZR7qc6d7AYLysA8ax9bFRgdWJiNYQnf+/hcoJG+qtZJQG83Pz4KTTf4
	Sxb6NbTFJmr/7Q9fqqFV0U2IEboukqoqoe53yReih1T9XjWHdWD20FHDEIGy57Z8DjQH1qvkmuM
	nmmHBgYtX3pQ1ujdsRqNGEBndKpLbeBXx1W3D0FXONrS5YmlRt3ThpjgsTQueA1mwgwkRGzKr8E
	vkVsxTyYjpRaHVOD2m2wtbq0mqv+/FtlTyla3f92m3YEOM8PJypgTJlZc7QkHRwiA==
X-Google-Smtp-Source: AGHT+IFcOYrivglfZ9zfZFu5ZYZNKIlKewzZxcX4XLRNGDxuStBQsF8sv5sfHD4+SliIfgiUph33RA==
X-Received: by 2002:a05:6a21:3989:b0:1d9:a94:feec with SMTP id adf61e73a8af0-1e5e1e0460bmr406814637.2.1734641966069;
        Thu, 19 Dec 2024 12:59:26 -0800 (PST)
Received: from mitchelllevy. ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c331sm1751090b3a.196.2024.12.19.12.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 12:59:25 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Thu, 19 Dec 2024 12:58:55 -0800
Subject: [PATCH v2 1/2] rust: lockdep: Remove support for dynamically
 allocated LockClassKeys
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-rust-lockdep-v2-1-f65308fbc5ca@gmail.com>
References: <20241219-rust-lockdep-v2-0-f65308fbc5ca@gmail.com>
In-Reply-To: <20241219-rust-lockdep-v2-0-f65308fbc5ca@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734641963; l=1584;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=V7J/LAhSIPTXjimVIbXDd3f2+rXpgilX72JEzf/sZts=;
 b=fdDHwQLnhJBN6KsfvmXze7GEOBK4QBrmIdx3gK5872qfQ6BXrI4aIhL76dVXrJH35rN3aJ18y
 99hdb/WsF3PC5RLFjqhnSorkB3iXRmJdhu1SlKWRghDt3qxGnvK8FM8
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

Currently, dynamically allocated LockCLassKeys can be used from the Rust
side without having them registered. This is a soundness issue, so
remove them.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/rust-for-linux/20240815074519.2684107-3-nmi@metaspace.dk/
Cc: stable@vger.kernel.org
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 rust/kernel/sync.rs | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 1eab7ebf25fd..ae16bfd98de2 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -29,28 +29,20 @@
 unsafe impl Sync for LockClassKey {}
 
 impl LockClassKey {
-    /// Creates a new lock class key.
-    pub const fn new() -> Self {
-        Self(Opaque::uninit())
-    }
-
     pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
         self.0.get()
     }
 }
 
-impl Default for LockClassKey {
-    fn default() -> Self {
-        Self::new()
-    }
-}
-
 /// Defines a new static lock class and returns a pointer to it.
 #[doc(hidden)]
 #[macro_export]
 macro_rules! static_lock_class {
     () => {{
-        static CLASS: $crate::sync::LockClassKey = $crate::sync::LockClassKey::new();
+        // SAFETY: lockdep expects uninitialized memory when it's handed a statically allocated
+        // lock_class_key
+        static CLASS: $crate::sync::LockClassKey =
+            unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
         &CLASS
     }};
 }

-- 
2.34.1

