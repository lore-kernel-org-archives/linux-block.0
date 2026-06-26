Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA1D3F4DC2;
	Fri, 26 Jun 2026 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474987; cv=none; b=a5vfyZT0se/LlXjagT6jqDE7g0OqYw6aej7LbeoDHTaxY04xSJL9rKjrpfh0mkTQA2FKqy9c8HeaZMfANaX+UXsQd2Yv/OD3NAg7zfU0ZnPnH5nAt9/WvZhQqzBUckWJ//xxZhutHogziR1YthTuxrxyrGVCNbtkOOpGPv2y2qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474987; c=relaxed/simple;
	bh=L57zDm7ALp0lZWMW+Cln/Gg2DuJozYQVYKA2SZ2s83c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rb2rK14iGiEfHVb6aQHhaUfB+5f0kxtYwWLZVFIVIt4Heauqqw9let9rB0pITjPcL1CFTxQTA/l+EGE1Av8+MVTcnOybrAxvzaenx9SFB7LR4S3MEx9lT0uFaDqEacS2VuP6bsY6CVmc5Scfb9JNF2Wl0SXdAjCbnyYoW0tqGvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkuZ7XBk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkuZ7XBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BDD1F000E9;
	Fri, 26 Jun 2026 11:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782474984;
	bh=9MHwt/piGbHaBX1U0Ciw0A9tLdy3GnbZtG5V2/pNbH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HkuZ7XBkNBbPpmNh0jHv41Wuw70A+GdUFYjWET1qmXcQIKjTVrIaymEhyhQxZiJDQ
	 OYQaC+YTngeDtEXGcTZg2nrhdNP6R8cyrSArn0Vcg4mmq7Hto8gxALTcWSWfRU8kgb
	 i1NX1hBZ94yWCUrkJOY2045ItoVFnZTRZkQr1dHUJS9nY+rKTbTq6HIwWBAr/01JNd
	 oDiP18WI45XFmDdzBNkxdUAOofCB8I9OwzTdx5AOBXno0NZp0mktQRseoVeUXD9ds/
	 Ea6yM6KoBk2H/UJkJmv+1gH1PriKePYHNbY2wWHbjbguzGKMCCtNXrSSLLiaCwHwV6
	 ioGjyljtNEVjg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 26 Jun 2026 13:53:58 +0200
Subject: [PATCH v19 1/8] rust: alloc: add `KBox::into_non_null`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-unique-ref-v19-1-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
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
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Igor Korotin <igor.korotin@linux.dev>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=L57zDm7ALp0lZWMW+Cln/Gg2DuJozYQVYKA2SZ2s83c=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqPmh0T9NXm2ekfnSlVS5q2a5Nkx3elel1Z+sUE
 lVzxvaywm6JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaj5odAAKCRD6UCkIqsW9
 0GQwD/kBPhAfqhuRT/wPQuyxM0apWmNdKJ15rz0l+MH0DxUqynfkKds77p9Ba1hBaXZEiIgHmCH
 pDIBbcmrQR3ZzjLNEC27ic8X6+BdCVjQKsQBQWJ7NKui+imMc++MYWVIYyM0r0enlZe2kmN8hO5
 neGpUe0IvwQ3Lj6UWc6ACsUoOIJ/VSSl4SFZNnkH2SbWvbImu4RPT5mmyv3heMJ9g65NMAedvle
 tw99mHlW+RMWghmbVY1G0CFXcrMFX/ICi7lpll6iz01cgmdWZ00Zk2kIk1MDSePNSLkiHcviPYo
 eujIyeR9+opejbUdjMsWAJIqUz1K+CusSsy+pMB9t+0TM36BK03TehWUHzki1rXsWQby8KUOQx5
 JtTsLGUeCdq8jj5LJh7ikHfha1V5+4WAgb1NU6rWbu0HAaCDeoUfacnX5DMEVlA2YDZYl6lGSYy
 LTe2rZntwugKRllSVNPfbq+vpbu4eh/00OZ+rZuo6jg4qjxcaF8bpEujK1QOVaT6mqH0SIO6fL7
 dafroHQszbX998/omhRnZ/sCkPDELv4EwBaAlkTH7N3G0DsXiUEUx3nko9wa630BA3dS1kWBvKn
 cRx4J3Tc31/zybazPxJ7yei5pHjMTfOHDnSsGrWwiXODWfvRUZiqgEWUO3S3KJWIZpG2VabKArA
 vHegIagDX5flLQQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
is a convenience wrapper around `Self::into_raw` for callers that need
a `NonNull` pointer rather than a raw pointer.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/alloc/kbox.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 35d1e015848dd..d534e8adcf7b3 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -211,6 +211,15 @@ pub fn leak<'a>(b: Self) -> &'a mut T {
         // which points to an initialized instance of `T`.
         unsafe { &mut *Box::into_raw(b) }
     }
+
+    /// Consumes the `Box<T,A>` and returns a `NonNull<T>`.
+    ///
+    /// Like [`Self::into_raw`], but returns a `NonNull`.
+    #[inline]
+    pub fn into_non_null(b: Self) -> NonNull<T> {
+        // SAFETY: `KBox::into_raw` returns a valid pointer.
+        unsafe { NonNull::new_unchecked(Self::into_raw(b)) }
+    }
 }
 
 impl<T, A> Box<MaybeUninit<T>, A>

-- 
2.51.2


