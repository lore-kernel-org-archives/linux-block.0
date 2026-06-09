Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9104D8DAE;
	Tue,  9 Jun 2026 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032358; cv=none; b=sackz7LJtb1vhnyEjKAiTuyqG3gODJelBMA5Dw6hUc+8kGNMXP8m4VNfFyz74R5tlf50IqVutnpggL7YOoDK02JSoth260dTqDwW2M2v5Zms9xkIN45JqA5Vhbhds4U/XUurGt/Vk3Z+bnMsosgUTy/5HpMcr7fjOdLh5aGjuAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032358; c=relaxed/simple;
	bh=OGr4o32gLgytplFNTefSvmBphLU6/cXTR/X1CTCtpbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NtR0KHwcfmNHMRTdlvWWuoLD/r1/6YtI0MmE+8G4CfX/jhDL/ymxlwLq5qPXOmIrfrmRHWOZsIH1rTbLQ24QtIpBQ/ljdQ98q9nXu8SVNnAa34g+/SpHcb9NbqIU3h6LNqK3BbWD22BtU/YiXMp2g6D8mc6wlG4BV44eyWsZsQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSLqirSm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSLqirSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC361F00893;
	Tue,  9 Jun 2026 19:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032357;
	bh=SHThiWRFl6eX+o7HfToI0BveZqoyq24Iln96WP9m9/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hSLqirSmMdfe7JHeDMJEbaGk2xH+r8zJCJzvpqX2KhAAr9i8+gTGMZyAN1O1wjZFC
	 87zQtjSJAnw4CigqubVw8wKx94QKtNmMrfN5c7at91IeS592SC+4RIGtymDHm1YwCa
	 YLJUWRbTanGImSCTPh9eGyzpeIrCOd2UbjnURp/RndyphhSh+uuhENiu2XosWeNgGW
	 CdVJAtOFqRqSx44VleaAHHBq96ylbwR33okKwYWrDDhCCpyXGW8l/aCJ10fBnnoNeF
	 gDyNOm1J8ES8pByB/3zTYzR5n0qqCLrmYO2IeqK/tGMJ6+8bvXHby5oTUt8Hb2HC8z
	 /PO7x6UNlMlnw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:31 +0200
Subject: [PATCH v2 52/83] block: rust: add `TagSet::flags`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-52-82c7404542e2@kernel.org>
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
In-Reply-To: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 "Liam R. Howlett" <liam@infradead.org>, Boqun Feng <boqun@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=OGr4o32gLgytplFNTefSvmBphLU6/cXTR/X1CTCtpbs=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTjD/SsS15S2X0k9iUPabdH4odGbYwDe1N6N
 6f6Z6npMbGJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk4wAKCRD6UCkIqsW9
 0BqjEACmNfk+sSeVLWEKg7qqrjEhETKAJdKa0iscz0fFFu5BCZYtskqN1Pe+gzH4+dxsr0nPBZp
 wFoG2ahBVLl1ZFM6xUD5wlUwnvbCqawttYwP9tRmHVlVHeDArVaWUnXcapkxPDUNo+RWr3nsPSQ
 TM3hKexhjGLQDNoOtZwP6z4n4J58mZ0FeHYSZgx6TOD3SOMpR0vOLZ8+opSfcFQDXnoo9T9xkHk
 EqbddpiRIe17zJHcW1XA6kUthmI2JZab72b+IjuBR/NQqr+cg5oRSFafIj0EjDD/IdeVQ+DRqNd
 8vUgnW+2fAyuIbgxeq+/bnuy+Yp0MsopvmFj9siA3Kpr1l8LgSJ6Qw6D9AbQ0CnL1Hrg3DgGDVH
 fF4DCvpOb7/bEaKGo6OQ5hsY8kPb13y1q0p4XM94MvgobrunqFlJNuWulMDtz6cBJewScWUyKoc
 9c4dGEBHCEJokswtZYoAvoQJDhfOQGzI/5k1jUwapW44qpjVhWS4OlRZD8qPJKoa0iI8dm+m5Vl
 S3+RawjqCptgUdxVWG0VUXAaEpWzQ+ddyLGHOK4WV1kP77VB6GlWEprAoNoj4fhj7s1SciGYsa3
 cv85EOjJFomaU8MELbJfwoihhJgdcgv8QPmNTICa+Zinnxx9Zir+POqXejgqcP07lZVrtdQPIi9
 vu2Y6Bmvw6jKhQQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a way for block device drivers to query the flags that a `TagSet`
was configured with. This is needed so drivers can inspect properties
such as whether the tag set uses blocking queues.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/tag_set.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index 5359e60fb5a5..157c47f64334 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -107,6 +107,15 @@ pub fn new(
     pub(crate) fn raw_tag_set(&self) -> *mut bindings::blk_mq_tag_set {
         self.inner.get()
     }
+
+    /// Return the [`Flags`] that this tag set was configured with.
+    pub fn flags(&self) -> Flags {
+        let this = self.raw_tag_set();
+        // SAFETY: By type invariant, `this` points to a valid and initialized
+        // `blk_mq_tag_set`.
+        let flags_raw = unsafe { (*this).flags };
+        Flags::try_from(flags_raw).expect("Expected valid flags from C struct")
+    }
 }
 
 #[pinned_drop]

-- 
2.51.2


