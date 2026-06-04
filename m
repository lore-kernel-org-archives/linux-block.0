Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468C3C4561;
	Thu,  4 Jun 2026 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604076; cv=none; b=cBnJgb8MHx1JxZNz58amZqknPtIKNBkGyzNin/7v3LwVq0EkJmz28mOEPZytJItSw8tQ+at0KPjkGNXNULR77J4miwxsvA5FLMVSKtwszAZL8l3TfWSFCTTOISmcA2lmbr1cuRgN/TVaX/tt4Unfi8WB5m0i3z6lgxft/MFL058=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604076; c=relaxed/simple;
	bh=HIU6Nmu7iABl9KtQIYtvgtPsm8T0d+RqMDFg+vb7EbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ePp8dXj9Ax8CCsqnDiwH+WwvUXmAat75FyX0dUe5J6/1z3nofKxSPgJe8H7J+FhAGL3YxDyLG4Wz8mjmRVYkhk7HDJVRBz2YRg4WBb+fakACZtywNfx+obY7kU0pnIW8RKabVaPy3ORd8Amjcv3fLt/IAgSZLHztHqBjQweE4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Koul0/fk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Koul0/fk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1AB1F00899;
	Thu,  4 Jun 2026 20:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604075;
	bh=G3TVjSgjK9G7CyHxcZcbdJi1JuXhkhXf1eJMpalGwTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Koul0/fk1we1IaCTJ09OH1HS+PPhIUtV9DSBqsN9ivuoz0s/UmIQ2Q6kp6W8Z4/mu
	 ZF/Yxkjr4/r0P88xOyitn3hyuyev9JS+RNCrRgXiJu6OF2AVGzhu6IrA0HGDgZIPm/
	 4ClHjq1YDnPgBSpqrZJoqyanInFwWw7lbRXjOM7Nq/TN87cur4wSynpuOfJ6gJ0y9v
	 s0NWv/VGyf9weS7al6hGSQv05pLvqg0uYB5M0n8n0KrVAa7vJJ1Te6vUe1WfIm0dft
	 qxH6Gf/rEVZR2M6y4v/mPV2BgbRKXbCiXxY8/Q7JHtDuKZkxM9WnnuapYMrS8/RtVZ
	 o7mhUs79w09Xg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 04 Jun 2026 22:11:13 +0200
Subject: [PATCH v17 01/10] rust: alloc: add `KBox::into_non_null`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-unique-ref-v17-1-7b4c3d2930b9@kernel.org>
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
 Andreas Hindborg <a.hindborg@kernel.org>, driver-core@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=HIU6Nmu7iABl9KtQIYtvgtPsm8T0d+RqMDFg+vb7EbI=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqIdvnvaCfCPZprFYoyr5bjX3TfukME5Od6oPB9
 tR7l/9inKGJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaiHb5wAKCRD6UCkIqsW9
 0LVHD/9orCNW9km7eoo7svZph7kf2oFSscnDuSfnZbnknSzXSrxvmhwExeDA1cSgUg7ATS13m3M
 xpd+u7kmEAhHJpaerkAELxtghRA4/yE0MhmVrNvWeQpIHOya0srATnagWFriXahuqmMwDkzpWGf
 GT4mFbiGz+DAiE6iSQm7E3tvl785uUxtjXKpgqHSZT0HMbqOT0UxX4cztFf+i2cKC3D40Of5EDy
 BjE0KgRHNh66eYXVBnI1tjYOrOLbVNwfNdvhCpwo+PI38AbWVAU7qJCTO+yCPRsIVrcW+W3CM3x
 +tRe3sIbQORfl6dsfv+Noz/08sOpItUKm6c94Fn2bYYJ7VI9xbe6qrTQnXzmvuD2F3e0ArAOvIE
 2INo1C1b2Ky8odRfgPR6tvPP9k+FpeidXIm5n5kNm/yprJ76UETTS32XGwcO3fVDoFmGtPjq9fW
 nzxKp0nXHmqq8BrQf+RLIRYWnRjzpmB4XuhAfAAsTK3B6ib0x0oX0nFWUPk8+GOrnEfDhlNh9ep
 CsuBUXl5x3yrcyq7mCOBEYNuzZwxHLJtTsO1ycz90dn42DAfEfAw8HA7pI7dZ4zPXoRetBRsoUw
 F8ELxr+1c3uiHRADNWr0nN7b23n92tdEiOAINa+JakitVe3c9j3MS5jLOQCb6KBQfuu8bstQ0De
 BtJ6FehLCTXpwLQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
is a convenience wrapper around `Self::into_raw` for callers that need
a `NonNull` pointer rather than a raw pointer.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/alloc/kbox.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index bd6da02c7ab8..6fab67704294 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -188,6 +188,15 @@ pub fn leak<'a>(b: Self) -> &'a mut T {
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


