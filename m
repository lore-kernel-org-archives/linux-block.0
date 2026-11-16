Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794838925;
	b=M/ymBt2aCD6kRnaY6XWf8SFmTYsuu0gZ6TXG8bUQiDiHcQia7+j4EWYSTmdBmWm2QWQN
	 dXqlP42LoJQglVYsFl4cebpx36AS0VOCo3I91Mh73PRdAeFGH4TTqPbky72HGmCRLueDc
	 0BAPI17Sh/HyRCX7RLk/CqFxORBsRIH/OxXTq7RJ2qAtYDUmW5OF2jpsyUFm1BwysZdp7
	 fI+nk11fNzkzY3NgE8nwZA57fi3ouXhc5FHty0Wt6nDdQqGlaIX0Gu+BXl99zmunaMiho
	 XzypsA6smm/8OcY2CAjnWEtp4Xc2qqUuI+AIorlHWYL3IgUVm0a34LaTSM5W+qfoo4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838925;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=9998Op+ciK4KzNkfg/cHkmiaE6KVNwv+CiIQ7yuk35I=;
	b=1sHXSlHpkZ4iarG0zRtvM7z7VU5kKr7xHXxNvoeZt+b0tVV7rfUiyhiS8rfJvt9TPROF
	 Db1dqcDsIzQB5da0hDf+k3GIASEPOGV4xIHa39iEah1lIDGz4EqbKv1rpufMJmoAlmBZQ
	 tqKYjFjglStqUBoJh/k8fK/B8lzHebiQPBH4F8MlDi5nTOdAKL7Y4DvJayKQ7jijTaxx0
	 H7Qnq5xHQ+Aw2TgtAn022q7uLMO2DkMFoEuq4OMnZ0PuF83lKlDCs9EKfaBqkAfusAQtX
	 1jxk/1Mrd8C3BVVzzDaXXm9lDyju+rfKwEJiv8qI8T6+HMJuGEKop8GHjX9q/K7PK6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6YGkIo6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D268606A323;
	Mon, 16 Nov 2026 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6YGkIo6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35181F000C6;
	Mon, 16 Nov 2026 14:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794838924;
	bh=9998Op+ciK4KzNkfg/cHkmiaE6KVNwv+CiIQ7yuk35I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=U6YGkIo6jSIx0cKZbIhjwuEgIIlJTCZggyc7Z8QV1XUlyRujA+fOfTj05QIdFvjmc
	 1GPlHh0WYwXiceAt5e+EOb4TWlJ+ekRtWUEIYD37Ry4cG1eM3BBsusAQmgNbH/nwwg
	 J/pDQnGW6254ZHslJYec2SF27t3v0Zu3mhyEkgA/Fj+QnlisuY9EZqeFnEhdKqqEUD
	 0HdO6MGaCIEyx7ukZYHcJ7spKtuVXByl9n84BG0R98l2e8HuWNmtkQ+Vl4IgfLdUWQ
	 YGpwfzqTqS6+oPT6wB/Kg6uws6N87/tmxHVLz/vMiKNzHHdYnFIi9Pgs3kQ6f2gjXt
	 Ez1w8IoBWY5ng==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Nov 2026 15:20:58 +0100
Subject: [PATCH v22 1/5] rust: alloc: add `KBox::into_non_null`
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-unique-ref-v22-1-12029383206d@kernel.org>
References: <20261116-unique-ref-v22-0-12029383206d@kernel.org>
In-Reply-To: <20261116-unique-ref-v22-0-12029383206d@kernel.org>
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
 Christian Brauner <brauner@kernel.org>, 
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
 Johan Hovold <johan@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Saeed Mahameed <saeedm@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Markus Probst <markus.probst@posteo.de>, Ira Weiny <iweiny@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-serial@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=nnq/EApvqpnDipb7ZMMGHyUc30IDlzBw/XCY2d2nR2I=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBq+xFRqMYICGBG+ejnnQrHCo2Qiew0xJ4tKwFW5
 FAStlInHLGJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCavsRUQAKCRD6UCkIqsW9
 0MiMD/9Q8HebKQyWtVT3j+58+5Dz3Y1m3kT35wm3KPbPB7t0UAJ7ogziU0L97LGVruRRB34TcTu
 1CXyHSibnht9sqUnd3frpfwAILOszsx3O5g92cMyi6dAOnpfwgYfsJrgS76YDxIMSs6hzhbW0b0
 ZdTb2ogrtqwYoTSFPq9Yq8Y6Aae/klTsQZ+5zhYq9x/i6eeksYBRrAAthMHU38+eNUbptna92Fg
 EzSDCS1x4Lh0+8XysAAabbtvDCcs0rppOnCBCF99huGij8Uru81TKzD5FSbmYo2OinEXo6ctGxq
 +E7p7ZXvkQgf86OcwY6ZIgpDBHrtcE9x0rFxcIptzBzj0JJOEzWA8iRUoQrzBgdNXbE2PeEe9Vi
 ZpClcdgUNxB23pKbt8fj1tC/ohlfz563sEfVMmOBFp9z+4GLRtI1e3iQur4L+mDabf6kJPtfUHb
 EHJvSgpc+mdZAv0AXN0TE6romZIfZzrcJNDWVgOrEBEXYh20BpHI1Vyr6KM+eDa/u7fWNkhfKAF
 2X+DzyfE/T9n55HpdJUdtE7HxKbJ6oMkeTRrviQjc6Qfd02CAM+g/mAybG5yMMJrCGm4hCC1AGr
 gWM3HjZl5l241jl1zkJkDbw2N1pUvs2AavWjD34YQP7A+Bw2GSakJGIeQgVdVGd4rK9bU3AeBbU
 hfprB7+xbLZOC0A==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
is a convenience wrapper around `Self::into_raw` for callers that need
a `NonNull` pointer rather than a raw pointer.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/kbox.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 2c929eb1c3d6..7e8ce3b36673 100644
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
2.54.0


