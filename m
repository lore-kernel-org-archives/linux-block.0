Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54E3C9ED5;
	Thu, 10 Sep 2026 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030955; cv=none; b=nWjVHlIYupapATZPcZaDu3r3XAycvBCvmyrT9WtkKb51nr5242wAjbh/Ta4wEWZC9O0QNukj+7wK4WHxo3VQEnc48R5QYp0xUPDn5730fchLzywBJ0LQd+IAWtrYQN6KW1fNbcOroVMYByzAlk2uijBC1XxECY5yaZWp7AnCSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030955; c=relaxed/simple;
	bh=WHW93VvrHeXgOCjNosfBMI4vPnTOHHkUoJXKjGlJMdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hFlmSFtP82uGRHKtPxj/xTkKkKdPliRU+4zg6b9afpduo9ddj9rk6nc8EkrcdNqJhbpxBN8Vd2AyoO7dq7LDEJei4DkNv9ipr/mdOOzcP3C3Nq44F3NPcDcgujRpWw5sYBGE8hH8fsLV6MpHSH8PA0gbrGwR5TQs1Rr1+jDQE9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=If5M6sRe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If5M6sRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4011F00893;
	Thu, 10 Sep 2026 09:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789030954;
	bh=bi6HQbpS7WbVT11MZapyDiTA6f2yGohKV5fr13xqRJc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=If5M6sReucxfAa8nllZsBD5rzyKL9ELmN7J++KhzVHXMFwuo+ywIXweYK0qHvKt73
	 1DlZC6yieZdrctVpoPbK8xAnJ01MqKDgn8JNOrREKfLrtY3kuk1QD0WFmmwZvIkpKc
	 cjwQhwi6gfGiK1mJpr70MGacbhPTAkvMJSrfODwcnkW7h00u9xgR6Tozex936pATmf
	 Y/e3g5Q+e44jwwElZlmy2drakal4M8C3ZYhzWEtU1LZSzTfNXyLU3yRFX7wXmiz5xW
	 ThtO/NXMID8mQwyR1hAETqMn3NvdBwCEMEnIpbQLdGFzMn0iPU5Qgbppp1CAYsoqRp
	 rYXsEVBqyS45Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 10 Sep 2026 11:00:05 +0200
Subject: [PATCH v21 1/9] rust: alloc: add `KBox::into_non_null`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-unique-ref-v21-1-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
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
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Ira Weiny <iweiny@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-usb@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=WHW93VvrHeXgOCjNosfBMI4vPnTOHHkUoJXKjGlJMdY=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqonGhYtutHmW3K5/iWt2PtNR0EOOEvKOh8GOE3
 cAXhRn6VpqJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaqJxoQAKCRD6UCkIqsW9
 0PiAEAC1ZaUVBOkvlRXYa1uoG7fv8BkX7iuoYs3OUE6Xs7RBS7CbugsVYpLdGgml2yB5Xo/AfF1
 lOrJHP03TKEIawI0QIjvbDUNXrYGXND3iwPfW4oW9EKyBDMM7aQlMGM2ptkYJDcGzux3kw7pAqx
 zYjptUpVSESYUlKv7c6+bSMK1AeydAw1bt04eyJrzPRMgus+QTTFKWMkFU2w4n/A2Vybuz6QDSb
 +gMpzM9B3XcB5EYFx92khT1NMRiQsSRHxCc54Ro6JbS9nA7SFf4X1SRG2ZwFwEYJQw4+P2eXu/B
 kn8z2qUOFN7+DY5TEDT7kwV+OE7FFgKaMjSOLZh48VmeDrw9fYdtqIKT7xIuy1KqplTIuTjsNpb
 Iy++9Nqzy8yEHUWDqdzclvjSepDS5DSFpG5VMDldAC4AENbijZpOJVJwq41LMojHASK+t1NsF2T
 t6P+wfaQTuumBObShygOAi7WRMKfgFIBmoMisdn0c5sE+W1UPIzdRH53GVM7b8aY6Q+rsRPEu32
 rNoYVKX1ZCSGlH/Cai+CxLnb58kRzvOkj9jCMjG804rAMG2AgG+ExQoP1ymqRN4D8kik1NLlEy3
 5yp5HL4qYcm91XRinv0cXg5icrFwfKuSpkpNl0UuMdJs9OSwTJV3P5cjHJpDbgZcd/sKdO+4yNt
 KzVWbdwXn+Hi8TQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
is a convenience wrapper around `Self::into_raw` for callers that need
a `NonNull` pointer rather than a raw pointer.

Assisted-by: LLM
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/alloc/kbox.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index c63d6acdbb6f9..27c31120c3854 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -211,6 +211,15 @@ pub fn leak<'a>(b: Self) -> &'a mut T {
         // which points to an initialized instance of `T`.
         unsafe { &mut *Box::into_raw(b) }
     }
+
+    /// Consumes the `Box<T, A>` and returns a `NonNull<T>`.
+    ///
+    /// Like [`Self::into_raw`], but returns a `NonNull`.
+    #[inline]
+    pub fn into_non_null(b: Self) -> NonNull<T> {
+        // SAFETY: `Box::into_raw` returns a valid pointer.
+        unsafe { NonNull::new_unchecked(Self::into_raw(b)) }
+    }
 }
 
 impl<T, A> Box<MaybeUninit<T>, A>

-- 
2.51.2


