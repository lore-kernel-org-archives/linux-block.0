Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCC720B817;
	Wed,  5 Feb 2025 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785572; cv=none; b=M2EHvJ+j3iZsof49HGQM+VriSDeU1IjkWeTJUlJLHB8NL8M6NIKmcGxUc4q8GfKz0X5zREBRHNgR1rRS7wWitgbAzfzV6K186G2YZENpqOvobtqalmkvOn8TFVvDUAtMsUb4QImLa5N6SOrjkZib7g/+LwDV6t/ucUb4AxAEvqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785572; c=relaxed/simple;
	bh=isPThrDC+P8VxYb/Z9yet5NnsmTv3r983AWlt4y24R8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MSdHAvkzNZM4sB9ScNTPjMNwchka8loMd8mXro/oe1ZY6oAdrYys1Cfm2MiEHKckF2HejGhPdHbw0RZ7I5ivhOU6aFHRnwqoR0o5mxNtIHA+P6e+IAoEKHaI2pjQSk0uOMu3u2oYCUXPRT57IqNIZiPS95IGMZaI9xWwUdf/slo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlhX2oLD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlhX2oLD"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21670dce0a7so4578115ad.1;
        Wed, 05 Feb 2025 11:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738785570; x=1739390370; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ch7PTuj2kijT0scGWWUUFMKJdPsA8B1kH+X1prJXnag=;
        b=GlhX2oLDu9BIm+8BLix3QYZ3w7EJJ14kcMPMq7PDueXHj+ibZz/ZoYCZfMlXdlWn9c
         /tcOluWRA12lPg1wuwRMpkmruNKIemMkXY8dENt4ev8mHg+bbxWNszhFfru0GtDjxWz+
         FmF9o3WjegMoWKxNCNRaO9iiP0c7kEhoEPZ1gYZZ6n1fYKQjBmjNCk4JNDbE8EixAcrj
         MdLQEiHiEXpt4+shCvgwf6os861o3UxvjYm3sq4m+apiH0DvFCRaBwEvNbovBM36GMsf
         FODjFlUr6CXOi0X/mP7PA7uYoLJKOK/PZy8KG4e6oByO1FN10HXUXUGk1KQ/rWN0Hr3x
         prog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738785570; x=1739390370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ch7PTuj2kijT0scGWWUUFMKJdPsA8B1kH+X1prJXnag=;
        b=faePbLkszJi8ElyBEE5JoP0dQ00akCXNM+Hq8ScUBupruYj9wjH8+NmJziUCST/bSP
         cd7yVIirYfBaj0tBHOJPVvgeCdCd4uqJIQbCijkDH27fztn2TU3ff6R/VKYPAywzStzX
         50NskvTsAvrYIcRIHDskGonOZAcsKT4lTSe5PiI7NUbSkQirZQHxIr09m3XxtODS528q
         RzxHX2FFajQ566udaHZvfZP3TMorVUGiIm4aYh5m6w0dcn3fXRy1Y2Noe+gi3oIOdYzo
         RQ+bRGP3cldSsHyX9adkruwHGBXO4LPpIUiPSsNwb0WiXxYLgto4Uix6y2co9WZx+yin
         sRKA==
X-Forwarded-Encrypted: i=1; AJvYcCVzxR5egkkNl/espCTeiPaw2H4sk5Ya2S/bs+TIFvc5+2PmTa3LDugv6+3fCWzXSrgmH8FYRL3P@vger.kernel.org, AJvYcCX6ajCHluFmhoT8cRVE8NUEKCklv4ZoijOtpeRqN4W44D9u3/dSBvGtfp3kOrSwpEcsPLLSsroqccPNhqk=@vger.kernel.org, AJvYcCXGknehyAAAdumP6C75dUNpXUbiGSbb+87jMd1fsZbR/FEmZA2UrGl6Io9zjeA3bd7aZMf5nf72sNz9zNIyMlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrn98SK2Bho6qTYKvGy/IKxQpGxZMRS6pXfzif3+schK4qvQ1i
	Fwsr6w+6vnoD1JU4OFyYcCupvLTXf7ZZKYrZgaZzt3SKmUdTJPdv
X-Gm-Gg: ASbGncs1OKtH/o4Jpg18+hF+D0VmHtRyQqkCi43+HTss/pHlK6XPEX2vNKrhYRbt8VX
	nGW2v8etpCYEAXUoFvNX483+TG17tzd4mQ0EhFJFzG30XiSRtSCtmkFmlsAJeR77FSfra9yebee
	2QhERyBvR3BzzPb9KRbLnLT0cZNzdxzzFTNcBD/CyqBIvwl0x7P3OdU8MtLzJ7swoX6GBd/qmsL
	cV+OBg+j9MiC/ozYbunKTwRiJy2emQga1OP/Y+eHb+YmM9UK8/ampS63LBEMGagm0rlP686os3h
	VZwZ0PcOght6KfyLW47L8RPH
X-Google-Smtp-Source: AGHT+IGf2RzANsOOKVIeC1dTB20Qmm3HhY5XX4jxaTixQbb/gPDKauzaUzpOF05cdC/Cqkdx0/1h4A==
X-Received: by 2002:a17:902:f54b:b0:21f:1553:12b5 with SMTP id d9443c01a7336-21f17ec7bcemr75167155ad.36.1738785570204;
        Wed, 05 Feb 2025 11:59:30 -0800 (PST)
Received: from mitchelllevy. ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f1668800fsm19685765ad.158.2025.02.05.11.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:59:29 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Wed, 05 Feb 2025 11:59:04 -0800
Subject: [PATCH v3 1/2] rust: lockdep: Remove support for dynamically
 allocated LockClassKeys
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-rust-lockdep-v3-1-5313e83a0bef@gmail.com>
References: <20250205-rust-lockdep-v3-0-5313e83a0bef@gmail.com>
In-Reply-To: <20250205-rust-lockdep-v3-0-5313e83a0bef@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738785568; l=1592;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=isPThrDC+P8VxYb/Z9yet5NnsmTv3r983AWlt4y24R8=;
 b=T1yW+dmA5LnIr1EAMZn5lsrRGwPG6dP7iFEukq24CK+pbVT0jSMAvWDdoezpIeqpQik5HXuwc
 ji9rgSzNJfmCzPWL8aYwh4oWocCDPxPg2mu0unEeEjLyvRk6xX6eJil
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
index 1eab7ebf25fd..cb92f2c323e5 100644
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
+        static CLASS: $crate::sync::LockClassKey =
+            // SAFETY: lockdep expects uninitialized memory when it's handed a statically allocated
+            // lock_class_key
+            unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
         &CLASS
     }};
 }

-- 
2.34.1

