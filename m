Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A5B4A2E22;
	Thu,  4 Jun 2026 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604099; cv=none; b=alLoDP2x03ZYEXuT9eMI2Q12NoBgacbaU5Yx2xjUW9gC20+Wda2AdOTk+lmKb6TM+UGcbFgZZ/jBdeO6Y8cdr+NwLjbep+fipQ9tCrVHZ5bTedpwOEgqejKE6SpyOhMlxG+1Pgj34Rd92usN4j/Rq7yRxCcRvqVVnikQ3yTxiZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604099; c=relaxed/simple;
	bh=Yk6QSotN2tq3Mqa2udN0WeFejqVXfRoesEZYyBbnFJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gaPt8Wb/ILejREQmFoy8H+KUrilO5ZYtopbazn5r78gu4L6eC8bO3+cmI+z7eKsM33mmg/H5rRJuYjblDJkMPufUEiRZx77n+ATWs+VJa4dKtXJiVJ3BdvAb2AW4bDi6/95cZ1SKu7nQbP4O3IOLLd3HQYj/HT9gFeCs4SlLO5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emyi1bE3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emyi1bE3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946FA1F00898;
	Thu,  4 Jun 2026 20:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604095;
	bh=t4H8eqNZN4/mIO1u313XVeuHkqdUneIpioBG/gGEBMQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=emyi1bE3lT84UiMs0H/e5sWLBpipKD8aP4rx9nCFc5ww2rHWzTrNroixBU1R1eW3k
	 VvDyq+Y9/EKTN5YutDxaS2ya7aaz09ocK8otk3HD4GePbWSC8Nq3UzR3jpHPJsKnlW
	 D+G1ixqQ2oKb5RLaZIvJKK62Ge4aMEzL6NR04y47K5UJ14jmX8IhLAu4hN5UEpcV0p
	 QeUQfwkvgeuV7wWv1oUW5AiTbIKO9lPOEnLAnAOPOPK8bI7//XDk5clHDilppzR/TY
	 GZxIkL2upvxl1wSbQAKqhnKfs+Sb4dtPjK9uSDcEaZPvRLUc9O84wyUuh3WcYXZw+B
	 dXBq+GQKoz+hA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 04 Jun 2026 22:11:22 +0200
Subject: [PATCH v17 10/10] rust: page: add `from_raw()`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-unique-ref-v17-10-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, 
 Igor Korotin <igor.korotin@linux.dev>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Boqun Feng <boqun@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>, driver-core@lists.linux.dev, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1098; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=MTxQNyPl556p/37N9iYrjSR5gCSkwSCTZpMY90B8pEY=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqIdvvpNub7j04mvxMdRLdPaAd/MQZCqnEQ9G7x
 6NHPMMF+bKJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaiHb7wAKCRD6UCkIqsW9
 0MI+D/0QPO+RBFAbjZRXC9pKgYwjFXnKxpO8ZzAKgdud2wdZcrmS6XnxjFCuPYPaFQ93AhOYZJa
 4HV8ITv5TB34RklZib+C1ex0+Q7HyqZjU22svIR16LfDNFX/PzVeBvcMhmc1WvMZxfKE72VeYMD
 lG1FuQHv/rWnofDymriWJ1qTmmIh7KcWTZTBWOBoRgKjjYMflJitin0NXq39YIxXu1MqcEGW20v
 ceF6r4JVyWfA1qLVdGeuXR56Z/tP/9demSf0WEz4n/JNfPwSO2fQGqgHU5Wl5QkOeyepnUg4nCf
 V7AX9lwpje33yM15jdHfXun61mNZa7LYV/QZyVny/IV39nPfxrEMJMFFzFZhx3H9v6+wmG7Rl7h
 cOtjeMyzfmUxEJ95Tx/gR6H9Lv9v03K0ZTh/L5YdaCZvaNDy0gi0KOnWUL1eP93qbY2kiyZmE5f
 t+Xfj7TX4TebKhIwyEuO/uBVPqXJyZTHt2mkjJ2wP+OAjZlc3btrRL3brJE0UGHxHzedtn8XHk8
 TyidsBvAMRGQ+VtyZO8Vi+OXdrfsKfO4XV4jyBjM1uPFGEafgzam59BvvN/aO0sZQB62OEFCXKc
 SQoUbEQRjie1O1BooUeWFUAPW1OpcbGv5nlsQmCDSxE49cATUzyJjv+bd3ihJjA8yLKgc8vmC5j
 m2qAWViBmLjYVlA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Andreas Hindborg <a.hindborg@samsung.com>

Add a method to `Page` that allows construction of an instance from `struct
page` pointer.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/page.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index 844c75e54134..d56ae597f692 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -214,6 +214,18 @@ pub fn nid(&self) -> i32 {
         unsafe { bindings::page_to_nid(self.as_ptr()) }
     }
 
+    /// Create a `&Page` from a raw `struct page` pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be convertible to a shared reference with a lifetime of `'a`.
+    #[inline]
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {
+        // SAFETY: By function safety requirements, `ptr` is not null and is convertible to a shared
+        // reference.
+        unsafe { &*ptr.cast() }
+    }
+
     /// Runs a piece of code with this page mapped to an address.
     ///
     /// The page is unmapped when this call returns.

-- 
2.51.2


