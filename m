Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42A84DB568;
	Tue,  9 Jun 2026 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032582; cv=none; b=in+wEXynmgW0erQKSJEuA0Oa5C8KuoU8JeWoVq0K/WAKUUdJDh5UyWdgT3y83jNEJkLuI47b8uYuthFc/VOK6aJ3JEGao6T+XkQnVbix9uSfygjmZG54b2G7SNPXOekzGSH3jtLrx6ixlS8fst6Y7XRH9FGKkseZNuo9hIAGWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032582; c=relaxed/simple;
	bh=VH2F2EOtPdHOtGslg/ieQKsqzCG4W9fZoz+7ESvbugA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hPlryEbJjPxzvQauUukl5KBQo7+Cm+9JR4/Sc5qEB1tj7asjKAc8frP9/pp4nOaG//5DGOxB4T9SiyzlSNlyTEcWaO86FOFKoR+q6ZyMuyp7AjjmDutsbVTSKZNSp7DjKTdMv9uVrIfItxWrdwVtVhJtGZ0IlhlXWklPr7vvHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oErhkH5/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oErhkH5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7FA1F00898;
	Tue,  9 Jun 2026 19:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032581;
	bh=e+XDXLChurzP2r5iP0BK/Xmgv4b9xTF7r8tpuv8eUXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oErhkH5/RvsU0pYxaGvsH8J04eqib3UlDmfBu006mx+qHGpOK7zmrbYXnd8jITMuF
	 pc81Wo2vAhP5ShprAawD0YzrZr87uu5PIeaaLzwRLlCVGDDSBs9TH2ljfGejE9QFLo
	 1njvvfMDcPJU8TCJTTuhAe7mvxLaofUY6xXDExPkk+GqRIHJMnXa4IJQ2I64+mQ72l
	 k+yiINMEiMIk1sgMwmop7aLKxDLB8ovJCfSPMlRtQWXqeB9LZRg9L+e3S6ekcNJT2b
	 QutGQosDKhYG0taub6tEw+i183GSKcSUN19YbgznxPNE29KMY1fZzL4VKNXx8/NsZX
	 +JGLZ8fby/Z0Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:07:52 +0200
Subject: [PATCH v2 13/83] block: rust: add `command` getter to `Request`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-13-82c7404542e2@kernel.org>
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
 rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=JgJ/K9nxltyXzGsFxBuvnKQJ52RCZyxIiod6jnOKKd4=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTAUkk0LcDHa3vjJ0+TBKsyJketYcEgtB4lQ
 W0HgArxGNuJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkwAAKCRD6UCkIqsW9
 0IBMD/9LTXBuBuAUnixSWlmlKgnI0lwXtwNfEAaUVoVY0DQ7Lsr+Hb5gWYPkTVBCmyKN8FWHT9j
 o4tQWP+BaptnALclsraBmmGiV7+m6J2mJZtJFRJosJIaDUkJ99PN0+Nw5GxTUl/vAcoKJiM82hD
 Femk99RwRCgWkb9zu3RpDebOw2ZP3ssLMoxeKASj7yTQpV0bBaiuWMCfQTYBhnOebVQd96l9URP
 sPHS1MuQeUcebhigYWJn2EfeIke8EljTgjcQvQf1Kf+lkqWvM5TRf44GXxQZT1mZPjtsBwrBwKu
 tfWGwgloAAj6FQjS/nZqrJfmV+gjIOEwQosq3LNCAkwFhxW572m/UN47kUc0dvq5qDSnrI8J3JM
 yuLJODtcJjkUvj5ewwqZpcYa16o+/bS6jo1rEG/EU7Neoni+FE+5qw0Cf8TU70WqqoVMdimrQ74
 eR1SmgLCp1Q4/dXLKctTGI5wSOB/MxtUw+ecU75dVlvSjGQpwDOx727LR2bhbBRg7TJy/KFw9lC
 iTRExSEHadwSnr1F9vreBiS2LyvcUVkNiQp0w3s/lNHw3hYtCiCUD3NNPyWUp3WzvJ/6HBm9rtW
 +3oIR8BySUbSN40gULMBY64GsLjcYE39eEbdR606WEgnuNvqhOvfals2ZGW2mmHiEPNV7wEivcG
 GGuPyYMYUFbkwUQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Andreas Hindborg <a.hindborg@samsung.com>

Add a method to extract the command operation code from a request. The
command is obtained by masking the lower bits of `cmd_flags` as defined by
`REQ_OP_BITS`. This allows Rust block drivers to determine the type of
operation being requested.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 98e54f0586d1..19bdf17de166 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -116,6 +116,13 @@ pub(crate) unsafe fn aref_from_raw(ptr: *mut bindings::request) -> ARef<Self> {
         unsafe { ARef::from_raw(NonNull::new_unchecked(ptr.cast())) }
     }
 
+    /// Get the command identifier for the request
+    pub fn command(&self) -> u32 {
+        use core::ops::BitAnd;
+        // SAFETY: By C API contract and type invariant, `cmd_flags` is valid for read
+        unsafe { (*self.0.get()).cmd_flags }.bitand((1u32 << bindings::REQ_OP_BITS) - 1)
+    }
+
     /// Complete the request by scheduling `Operations::complete` for
     /// execution.
     ///

-- 
2.51.2


