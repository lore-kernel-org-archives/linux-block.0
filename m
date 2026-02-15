Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5804E30C614;
	Sun, 15 Feb 2026 23:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199171; cv=none; b=FTALpC4KNqqV+I1hQrFMUc+6ePwHdAcKNvgI6ZMD33OdIcYStx9JQvf4UrfgURowDk0ZnVTy1X7nCHzTJRVHv7UEDy+h3V3gua+IP4A2QkoEI+XFwD2+MjTdD6ws+JgCfcztC9MPuAG5t7B7uFQGSkrUcSVewoSzxGeLiyHH4d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199171; c=relaxed/simple;
	bh=09c7uzZkxTyVrHNvjFvmG71WyMeEUT6Jt3cM3tUyoBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FpDxUoBAaVcvhlm3ZS2CCPB2Xsoy6Ar2wQejErkpJNZoyGK9+4K8YOlKeI/wa9I9w7We+ujtf144nV6lIJr1Mor0WdrNmVbjr/UvEIUP5zmRF+L3VtbaVkWm0xG2hKEICUjsM9WPaQh/KrHYcfzHEHgck366Tiv3T9TTpTeT/Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cn925NUd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cn925NUd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E806C4CEF7;
	Sun, 15 Feb 2026 23:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199170;
	bh=09c7uzZkxTyVrHNvjFvmG71WyMeEUT6Jt3cM3tUyoBs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cn925NUdJj4OBEmpfeVpbTqvDSZsJTqZer9GL5rgWPDKXUNrKh7N7CvEZ/8q7ZlB/
	 JR6Ub+cilzPA0SEV5a66KNxM4O0/p4Il22WIzHeHBk7zGxciQfy3Z8sB8iVgBF2vXx
	 ZbpfOUVueW4pb8ZnXQ4kk91lkCS5qV2wNGWQCOr1uL6xf6/SdglBx+UKcX8lr4kYZY
	 sX0dY0R+f9p48b3UPwm9bD3Ed2cWgsK0BSQfpqcd52jnd7Mz06lcT7GAHEOmF3KRuq
	 6JwAXz9P/u3kKRE0PAiNqbZhhUyrumt/IzZAimFLzxBHLnY5tsD4nCQciQchOdNp3u
	 Jbs4h+OBc2xgQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:55 +0100
Subject: [PATCH 68/79] block: rust: add a debug assert for refcounts
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-68-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1216; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=09c7uzZkxTyVrHNvjFvmG71WyMeEUT6Jt3cM3tUyoBs=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhZFlZdiDql4cqam8az2bqXKyXBUh/nt996f
 hHOmyZjco2JAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYWQAKCRDhuBo+eShj
 d+g1D/9Tp63vqvjenlUu+5ZJU1lZ+9dfMcKfq9m3hw47N4hrC9Z4Q6onk654vGOU2FPLlpUNy8O
 KFHhFrvdjxRcIbLPUsQOFHJGFib9kBLRrM6/JaRWlH5iq6m5ETg0Q5R+WGViG44b169vc4/YW1N
 JzNKqKwWBx66ko26VSg8maFMMAErumOt7G10lKzpSzcp4cOGXui6ZkKmiQDqJrWSaZQKDbZg1yy
 8bhhfuK5uo9d+cDLVDb5Ea1EcGG0W+wP+9g/YDAfR0qF4qjcwLPL9vChJRJXchgei9i5rx7gFth
 2xSBY+ot3E1dHVntP9S+ghLoduNyau62Rd9Cc31zYM8heVQM3/HPOed2K4c+KF/TRpoKjvxgHFb
 YIPbvfyMA6a5YpVqIygvX8iSCGULk5WoA6CP1LzQE6zSK6zEhZPj0vc/zviKoEe8uxcHUScNFqc
 z+BsrGzv5O2m7ZbGzZgin6qvb5UV/3nqjB/EwntF6hW5J3xMTu6O0f0rw2PdEAVdCVjzYXBCFuj
 L3ExONihceAiCdO20rH5z/EFwxqcNDWF2fqaXXOR1SB2Z+ZWciJYmnJJV4zgMpJiFQPQKFGPQi4
 ICC96uXCC3tdqBoeeBBLLXLPkSwXL+phd4rQNh8+oV2xj7+yqiB/5R6yXRUf04+giFNXYDLK2j5
 jxL++PfGAvuA3vg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a debug assertion in `ARef<Request>::dismiss` to verify that the
request refcount is at least two when an `ARef<Request>` exists. This
helps catch reference counting bugs during development.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index e22af7ea77bbc..9a05bce39c64b 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -579,6 +579,17 @@ pub fn dismiss(mut self) {
         // SAFETY: `inner` is valid for reads and writes, is properly aligned and nonnull. We have
         // exclusive access to `inner` and we do not access `inner` after this call.
         unsafe { core::ptr::drop_in_place(inner) };
+
+        debug_assert!(
+            self.inner
+                .wrapper_ref()
+                .refcount()
+                .as_atomic()
+                .load(ordering::Relaxed)
+                >= 2,
+            "Request refcount must be at least two when an ARef<Request> exist"
+        );
+
         core::mem::forget(self);
     }
 }

-- 
2.51.2


