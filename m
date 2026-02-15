Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F000E1FE45A;
	Sun, 15 Feb 2026 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198840; cv=none; b=W3muOzuqo7KoqwFJAU5Jr9l+jpUMC5ZgzNVuvOfzbCzpFmzJQpSO6sR7kopwvdDXQiIjTsWH/9n20Q/J5yIM0SVMODfbVX7Ny+NVTeIz3iOYWPmT3LFKxR6Dp0LbgLc1yrEIR+s8A8pcO2VkisbcqfGwlwtfoAcbYtDiyAnV1VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198840; c=relaxed/simple;
	bh=O3C0OWPFlCYQRkqgbpxphoxzn0AXFyZkFVXVYjg1yE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RtXdq7qQQ5fbGiiga+BCcXWMT+wfzol5jD7LNItgCPPnvvgVTYXU/Hugx8XjGGgr4xVcA6jvi47pbF8pgialnjrZo3D+sp8amfr/jI08E8JlT5PT7viSMKyGdzL2fyYXyFYg7xYEABtez3KLLVmFsEG4QWFKfqUdNQoP2YQNiY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcSSioyc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcSSioyc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C190C4CEF7;
	Sun, 15 Feb 2026 23:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198839;
	bh=O3C0OWPFlCYQRkqgbpxphoxzn0AXFyZkFVXVYjg1yE4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LcSSioycaHq7sW6v7S8VaMxmPBnrA0XxM/+JfYOZzzNyMOKQ9iJnYTOaI0DgToSTp
	 bB2PKE7e6AniGtKH1YCSTRffWWeIxzuD+r0kRNjm3NnH81MN88AskeW7Wrry71RgCl
	 a3/M2ZTS8ZU/Q/c6edwuFMId2JfKy47xwf7GbEA8V+9ggW4LAExBmGR6o/VUhpP2j4
	 ihEBh2jyeTbSuOGQn57iigRsghpmM3IlkCAURIzlifsiQ1C3xmUlJU5anvFFLuew+G
	 xu6LFD4QMgW2hvZKcSv15Gqui7zG641/KK0tZGRFSeme74yzer7kJsvhKkFSTXcdad
	 xtSoAtNYXDWpQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:32 +0100
Subject: [PATCH 45/79] block: rust: add a method to set the target sector
 of a request
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-45-de9a7af4b469@kernel.org>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=O3C0OWPFlCYQRkqgbpxphoxzn0AXFyZkFVXVYjg1yE4=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhEQwaxLvWD0eoBUNtZkrfvjdBAfQM5QFLvA
 DPqydXXjkmJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYRAAKCRDhuBo+eShj
 d7HpEACf0tE//nAl5WKx3CMVmGyPVZd06Zxo3HMqJo6lqiyYsbSiJtt9bGZZbPI6/H5CWRAt1m2
 szk1Q1ELBF+ypVdLMydJS0WraFl5vKpHY+tWPvkQURN5QOLlSCi6g9kz+gfDgRoKx8a5CfcRAEk
 uJFZuYIgnptGybIxMuQYiOwAxvwVFYPsI1zEQrvpNUhnq8DLGB6f6lvRE0s4/ZksCGPAxkRzQBy
 wF1pdl7X2z63pgbZZHh1ngeHc6g+UEfl/dzY9mHeqzwkYUYlUnECxI2FIOrKAF8D7grLtfAL/lc
 6/hsl7UtTA1XOMdaHcnwVGjZjglQE7s0jCFbSsnYdJBn1ly3Z56xArWHvtVFcMasgoE7IKE0eOp
 iHbf9JNaLaCOrrMGicyUsl1f2QZNfrctAe/1c+Iw9Hk08uNCkkkd7i4AGiA1uHX+s1gFKtkikJ0
 DHGZVJNZPRHJxRgdVcqfD1jq69/c0R/o1RJhlyuytbRxGcb0ok82GDSGv1r415P48i9IJNuqV4Z
 FeB9v1ChkeD6VgzxMWKi4xO+P5Tl7ivi9B/OrJHSPQu+Z3swBN9XdU4bZekYmvYojAZZ+uR8iPI
 Tj//FhDuPVGWtrVxOG06uGngv2m1dzJF9k1FciK+tf73F9L2IirB2Z2060mIt2oBbGHVpg9T4Lt
 EvIIMlfAMkM/cOA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a `block::mq::Request::set_sector` to allow setting the target sector
of a request.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 4e47419776e0f..4e7adb10929f0 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -7,6 +7,7 @@
 use crate::{
     bindings,
     block::mq::Operations,
+    prelude::*,
     sync::{
         aref::{ARef, RefCounted},
         atomic::ordering,
@@ -296,6 +297,13 @@ pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper<T> {
     pub fn data_ref(&self) -> &T::RequestData {
         &self.wrapper_ref().data
     }
+
+    /// Set the target sector for the request.
+    #[inline(always)]
+    pub fn set_sector(self: Pin<&mut Self>, sector: u64) {
+        // SAFETY: By type invariant of `Self`, `self.0` is valid and live.
+        unsafe { (*self.0 .0.get()).__sector = sector }
+    }
 }
 
 /// A wrapper around data stored in the private area of the C [`struct request`].

-- 
2.51.2


