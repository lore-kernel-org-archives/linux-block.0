Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A02B408602;
	Mon, 24 Aug 2026 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570425; cv=none; b=kUy5bsi/qQ9Pz4E6C8ShwTWl4htNd4qve1NdwgAfesRYRO0n2VzB+YwM3Sw7xdNZoulkqBO0qFC6hlLfDbCX4vAOEMPCrNf1DXQ1Irs5+ASqDwh/sJOYa6sjcetqVykePfWLmhM3DiPmz9/cQlxWSvBrXRub6r2ZiJinO5+2rS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570425; c=relaxed/simple;
	bh=vSOqJFayRfX2VpqkoQBcpBdLMfaWMqIb6v/l01/Pb14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AC82DknoJ3d9xUDmSBz4qsBqhQkBJxLNxkePwBwIY158adW+dNfDYSk3qUAJuhfy0Y3V176q7Ui93wb54ZbXAoSnktC8dDCACeuzxqyo+O202NjbMmuuzLOCP4rQrJQqp3qZNArRKEy7EXkS/nsNWXAbvITgijtZp9CQ4yMmEc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9EW113i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9EW113i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B1E1F000E9;
	Mon, 24 Aug 2026 11:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570424;
	bh=gsf4C31WIGEdvjURLO6bh8+KS225jhHsASFOIqCjPTM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=T9EW113i0F7o9cpyn0NKMrr4qzmRV5ZF8U/NZoyuc8hneKIS+m7cpuDvzSVgPWLv3
	 UZ/T59ijq/leurmQCv1iHl0cmEuk1NIzbIWD6fJx8EeAGt6U1JI1XyOxMxA5DDGolk
	 cgOQmWmEn9qSTztT73EmE54JnIvSFMBXxz1qP+EiXrnNjG8t7VS3q0HgSuto+OVHb5
	 K1G1+3cT4C6dI3/1VVHMRa7YVVcSo8rBEa8pYN4f07pLSh1dQdd8A+63hq+JoW803b
	 2R0aVMMZrfm+rKheifoo5O0r8MXv+DayvLLCFDSDOnBonW+N25ZJmtopKH8uu/+ZSn
	 N3LkyVXe2gdQA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Aug 2026 13:18:00 +0200
Subject: [PATCH v20 8/8] rust: page: add `from_raw()`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260824-unique-ref-v20-8-490735672187@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
In-Reply-To: <20260824-unique-ref-v20-0-490735672187@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, Ira Weiny <iweiny@kernel.org>, 
 Ira Weiny <iweiny@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-usb@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=wkOYacmcCbns70mMJJNOqXe3g11b+kHYA0S0dbdXM7c=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqjCiGqEXZYrPpUe2ITj4yrNHK12u5/qghuV8op
 wHiEF9/CzyJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaowohgAKCRD6UCkIqsW9
 0FasEACY3/FKckvX+qb6nS6iG9Xov+RkCghkBwWrcp/pKjcC9tE3uc6u5dni0Jlv0phoXM9ZRCq
 4Oiskvu/fzDYM3OpBsN5yPrYo5z4pHMgQ1iyZ/E4PT2Qt3U5csMyACtNOfzK20rc5GW+JFzxdSm
 GIwUm1bZmMmmNMMZRB+8ErW6F9CbksrWSHSDwxAJMAQE9ePY1NSP3y5e06cyaZzR5dJmIbd8Qhr
 iaKt2yKFZKa4w9XJTygaZ1X1ufWNpW0NaoqexhZ0Gw1ms6cMuvFEjI4/N/xLlD5YPdiEhExs0NT
 qqL2XTiWvEQ6MqT3NkIe0DeoXtWwmA/KXc72ctatlG4NwhOrqjPanKOBFztt2qMEGDM8l4FIZlL
 DpzZe+X6qPhXJBkNVuMQxBhztKCpOjbSfd32N6Lj/sZX6MIrzjOvvAX/lkZodnyZAqNctVA6OEx
 cEtPjNHNN86XW5r6RbLvk/5f2Xz9Ma85CmnI7b9PMULgpQ4y9DKOXgxQqXwyqph6gf4Hpz0DZ5N
 3Vci9dlrdolAiJLda0B0TkW4nnyv76G3i538Khhkr6C/u8tAJfA7Bb6K/GM3QJew6tJBXduGUdx
 YYs+T2vtUZz9CkjJrbvnHCPMJFQMH9cbMvEkos3w8s+D6i03ispYF0phnZ+cSWLIoLItRLQxpFZ
 cqeuQ7JvqxT38Fg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Andreas Hindborg <a.hindborg@samsung.com>

Add a method to `Page` that allows construction of an instance from `struct
page` pointer.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/page.rs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index e807ffe3cfef..32dd030c8315 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -144,6 +144,20 @@ pub fn nid(&self) -> i32 {
         unsafe { bindings::page_to_nid(self.as_ptr()) }
     }
 
+    /// Create a `&Page` from a raw `struct page` pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be convertible to a shared reference with a lifetime of `'a`.
+    #[inline]
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {
+        // INVARIANT: By the function safety requirements, `ptr` refers to a valid `struct page`, so
+        // the returned reference upholds the type invariant of `Page`.
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


