Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0D1A072A
	for <linux-block@vger.kernel.org>; Sun, 16 Mar 2025 06:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742106057; cv=none; b=RYKBOgdeugsR6d9xUJkIfELf6dGsUROW5b6N2JBs5l5xOesEXtb5sTyPwyXPMb8yC8mPWwE+ofi5lTWLSVAfSGo3si99dib3QZIwr0UK/32G97CDAPxAQaO31LbMf5v1z8HG5e1TVyMtryUE1PdocO8IFmxuJqdohjXfQn5zUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742106057; c=relaxed/simple;
	bh=EqM50h/btgoJMdEf89EdWwvVqjoFb69GSCAu9mgcPp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvnQ53w86q4Bc+vmdSm2qbCsbtGeebremxqIFtmc9N7A3K2Ui9cp9S0vnLxOSDW8IdfuYNiNgSO+BAebysIWs+lsMeybfU2Zb2IhZNQ45MWUcBxWv+C0urYhnjM4GdRN/3xuzwyl/l3lQ+eJuKnI9x+HeZMvkuxpAKULGUHZ4Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=SvfDgMij; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="SvfDgMij"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e549be93d5eso3100323276.1
        for <linux-block@vger.kernel.org>; Sat, 15 Mar 2025 23:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742106054; x=1742710854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=241ofKXR9vke6qRBqiwABES078cvuaemVLjJE3c+p2U=;
        b=SvfDgMijghFhKWOJO56k//6nMm9O9MSrUwn9dsO4x4nyTtlSBuOmHTmsiKaMqp7HnV
         HsSpRJ4GcVxqHZztAeXqfuREWDX0wHsP1tHKJEOkVU4y6wZM18gCMJTD5oL+uVXNdaA6
         CQ1gfqEXmQtD6pekol3PxVf8E2fgFdxajctes3+prTqLglYtu81vCLAW0SvuEtgUUs/4
         9HhF9qgw0FUMx/CX12tE5OubuzW0bKlV9hbmZjjHnoMql1pMNd4j0UOtkciCVWdm/dNw
         WlVqPNmCk7JN2yEfM6LG1EaRPy7pfjPub4OWdNOuwX7PJsvY7XKi0VNrCp6uOKVEjOj+
         MSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742106054; x=1742710854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=241ofKXR9vke6qRBqiwABES078cvuaemVLjJE3c+p2U=;
        b=sWlkaG5iXmSDybMOqVmiC1oukr3MQM3YgW8VqLBKgoWeAGkPrIoW5Ye1x9tkKmsgy2
         zF8402NxrcO3GDbXMg72lH4FCt90lpTBlEUbT1PgbWvfjFpBBwd0muXzE+EiJrheTAdu
         h9qLCmbwfm0h9gyw0ZjjwQEHPoNz6digOQ38714NHw5s1iLR26xH5yV8p7zeGl+wRTuN
         0VQdMIGjycG6hQiQmXFcRObU1tWR7edeVE1a4iPzN558L9hIbpKpnfXOVlPPwEqn1BR0
         v+wRVEvh9y5TdruyK/Ml5qQahEw6f54iK/oe18H1+x1jDXZrbNXoDX9Imb3sCpAfClND
         UZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjBg7d8tPxaOrT3mR7mdhZt8VIrmOj087XEsKynpV89I0GZ1qT2Mh1kv3bPw6w3wCCx7xFpo8V3CGxdw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9G6ED+4ynOHWtRMWzq4Z9O9iTR7CT/6mKcJfC9DBOtKFe+lpO
	Smp7gJMb32pRR5K3g0kh/BBZpWe9R4ISn71onIH/kRmQKmsPhrrI0qwTMU7A/L4=
X-Gm-Gg: ASbGncsCYXJ82q1eunGgVNVMfIMAGeG/Lo6ash+2BH0vUmkvggu07EE4eBdNbBijDCQ
	RdTipKtOB5n99uaKD0HJmMSvhM732Bhq0XSrZ+GY2tD7JzL4aWvw+kDXuMXktDhD2F+NdO6algY
	X4LzBtNEDQcckxnXVfPuhi8Pi61E4icsF+oNe3zZ0Ne14DO/IGCRbohXn0pTTVobIPLh6ynaZZi
	OMhJh1awExV+aTq9+L/5SslaWgowHUFNSK8CCOJ9sc6MsghK+nNwyJ3xX0cX9hdh88kiJG0Dvc9
	thVQGptf6HJAw0a+NSIl8msNDshfPRX+RqgFcc6eMYl9njAeb+h+KbT+vd43uDD4VT6JxNTmlvb
	gTKxoaX5wzhIW8DTcrJGrsp7piO6fyQ==
X-Google-Smtp-Source: AGHT+IGKBdFtgod+IDVWl6Fklt0hsLoHS9ez/t0qzlD1TVTBuTVrBJZz3FUeEagLsJQuRjXeXkbofg==
X-Received: by 2002:a05:6902:2182:b0:e5d:cc41:75d with SMTP id 3f1490d57ef6-e63f6534433mr9215444276.26.1742106054606;
        Sat, 15 Mar 2025 23:20:54 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e53fd277sm1618673276.11.2025.03.15.23.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:20:54 -0700 (PDT)
From: Antonio Hickey <contact@byte-forge.io>
X-Google-Original-From: Antonio Hickey <contact@antoniohickey.com>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/16] rust: block: refactor to use `&raw [const|mut]`
Date: Sun, 16 Mar 2025 02:14:24 -0400
Message-ID: <20250316061429.817126-16-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316061429.817126-1-contact@antoniohickey.com>
References: <20250316061429.817126-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
with `&raw const place` and `&raw mut place` respectively.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw const`, `&raw mut` are similar
to `&`, `&mut` making it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/block/mq/request.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 7943f43b9575..4a5b7ec914ef 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -12,7 +12,7 @@
 };
 use core::{
     marker::PhantomData,
-    ptr::{addr_of_mut, NonNull},
+    ptr::NonNull,
     sync::atomic::{AtomicU64, Ordering},
 };
 
@@ -187,7 +187,7 @@ pub(crate) fn refcount(&self) -> &AtomicU64 {
     pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU64 {
         // SAFETY: Because of the safety requirements of this function, the
         // field projection is safe.
-        unsafe { addr_of_mut!((*this).refcount) }
+        unsafe { &raw mut (*this).refcount }
     }
 }
 
-- 
2.48.1

