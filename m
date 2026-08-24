Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBDA259498;
	Mon, 24 Aug 2026 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570368; cv=none; b=vEfvuLLwPIaVWxHympWmxD8fgm8of3/X3dtIjx3W/ON4jJkWv0CSDitEqY9d1JuWSJOOOvjFck9awjkhNgMohptTu5h6tYzhYC/EJownkfpa4Z7kp5TMXMhUJ+iSPuXPsZ8HvSI+PiYuBHdw9A//rxPZw8SRhoXDpb/GPmqHkcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570368; c=relaxed/simple;
	bh=Bz9Y+wuriC6USNq9dghH0Oc0RgRceIN5mLKgknmkXjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EYYHKPsSwSU2Du+fUli7vSi2BW+WvBt0xX+VpOl/r5BsIXPoVGLd3yMUqVZt7pXMHwd0uqXibvubfRry+VujvF5ugM5QHy5vkLrPxDrBCSF3uwsNLEqDxBiEKXOWUCIvxaK5Pw48ZOx2BIaJX1/lmm6XQbFU7RkyEmeTQ7zPu9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pt9mYJzd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pt9mYJzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A601F00A3D;
	Mon, 24 Aug 2026 11:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570367;
	bh=9JfWIbwT4//CafJUB37oPZ4gAJDTQRPaodJm/XlS444=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Pt9mYJzdHdzl4fQzAVrswSnLK1ugEdizF+iDaboQyRXVOzra9ZiPlB/Z3pAX+gRQ7
	 FlvuxDHz487tjiESkDMKQq+qrWU6tUF5KyEJ5N5EoOqXeSYHfees5b2NvdTeY4JzGg
	 2ASC/szsGCPUbmXMcnP1YJhN9Voj39B3hlLhHUJuupoWLcKTtNJUxQo7g4As96pJBw
	 cU5Waqa/ZJ9kBvahCcv4atl/fAiNgenV8MSkoIvfJkZNk75BrLcCFbWc0jAzm+P9bx
	 VoTqsK9exzJ0Pevfe9KOF4zMp5ZeZG/LPDRC+HadCNWknQmgUdkQPzSBjTKZCbzQD8
	 BIsVt7vDKq/Pw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Aug 2026 13:17:53 +0200
Subject: [PATCH v20 1/8] rust: alloc: add `KBox::into_non_null`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-unique-ref-v20-1-490735672187@kernel.org>
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
 linux-usb@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Bz9Y+wuriC6USNq9dghH0Oc0RgRceIN5mLKgknmkXjY=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqjCiANjOTA/QLk0NbdgT+Aipy/VQqpA4/e4r1P
 uWaXDqaFq+JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaowogAAKCRD6UCkIqsW9
 0LcUD/9JlybCkRh5vp32gkmPMvQSq6QcOhJid/ktAibn3taPc2bE2UpUDNFbJn/mQH7ZVtCu1ZM
 Tuys8Ev6iAI3y5ohAEMU7v9qE67FroO23PPZqT3Fo/KhIAFQYpdvy5BC5GdaHEnW0RLQr/WpR5C
 lrzj4oZaLV/RfEkuTqzwgr/RcT/tNk6g95wN+JCT/GX28fo0bksGHfkal2ewedoOfK4REnj/6W6
 897sw2bg+rKaHODMYi3mNwWJ/nk6crdtLhMpFjaV1m5I+m7PAKhrFK/J859fg6GceYm6Qk2qIuv
 h2xNuhsDtW6kBHqkN2FjJQSDvsjUozwkUmr3GbpsjE99tnoN0+LzFcKD8TafAZyBQESTkAD83t/
 Dpo3yEG6fZUHtdq29nvUu1TDnotfGPxdUDGLtKAlpvVnxGvfaC3OnEkGrsNgugffVt7ObVl+d3E
 UZtUeA30SEzENwbdDvDLd3/SDxlBkY+vOTcv+Cxo5ZRLKr1gTMiLc+NWBFRyZWbLjboFrSDWOJf
 GEkBbnGOC23EJMljiV9hbphKVdr8Vh1b5XdRjMkVjl9g0HiMYMlzPRxgYyFn6SIwNxvKiFnlwoA
 JyBfok+kTwA5TiP6zAWy+d8Xo7+N/0qPbS+AwCN2XkIrv8K/hLcpPQrIUYclplEKXVyQwS9CoHV
 AblCyvWtJHkb08Q==
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
index 35d1e015848dd..e6c637bbe2009 100644
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


