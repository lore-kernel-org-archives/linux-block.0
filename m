Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4793DC4D3;
	Thu,  4 Jun 2026 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604017; cv=none; b=FeVQ89kSMeljA75twT90aoEeJ4RKZ7qhd33n5dwGcHQjkbEjGaK6Upp6EKN1i0XCWbGoPxu63myqgl4M8tpZFfxoX3ENvJFBoYoWoc8Rqs8THJkIvxTxSCjtVAdwkTLVAt1WVwviGPhuVvE9jcL6jwe2dPSlxUypoRWPMs+ysE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604017; c=relaxed/simple;
	bh=l5c0q5tDqBvfUKptiUH9ujhgGaCW4zeIf26teZmhjjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C30DZH43EkKCTOKgJstCNASJIxcbIbyQcvqCwfU+BxLODurac5D10E3YEHAMtpNHiZOC+pF7bLbazj6i9CNshX15STvipgeB9mV8IaC+HpgcJgVnG12FI/Mc9GIbGfI/vwZUZTy/fd4MEE2U+T9SwscQidF1tlyJHESh5BJfjJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMaDa3T3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMaDa3T3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EDF1F00893;
	Thu,  4 Jun 2026 20:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604014;
	bh=NPcZxJix8R8ASgeYRVdWoUpgDuVO0mdlMhZYBbXxkJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NMaDa3T3vyLRFmymA/V52rXGwDjbP7qMQN4Wc6U9T7dNibSv9rS4yWTPxKF0xFzfN
	 dFZOd0Y8wfML/F5N2JdyfxqQMOrT524BxyBbUKRKu4/typQSBoh7ZOcQC5MdBLbD5r
	 C9zJAYfKCjEVkzTKSipsvwoebejBXmrm2+xD/6QwEn4TFfc2wN8StX1Sz9WdD8podp
	 spMPdFZLO9/8wFf7L+vHYI9bVVvTww+5hLMn9V3TZzZQohZXAxPSqm0SM6NfrnEkOK
	 pX49PkQ8gXFAS4hFTKiK9du8Dtl/oCH7bqwbLMSjbXowqz9mGLhnspH9Kps2IJKiI9
	 ZKCEb3I8LC1ew==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 04 Jun 2026 22:11:20 +0200
Subject: [PATCH v17 08/10] rust: aref: update formatting of use statements
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-unique-ref-v17-8-7b4c3d2930b9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=751; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=l5c0q5tDqBvfUKptiUH9ujhgGaCW4zeIf26teZmhjjI=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqIdvtLrwkUygT4paQMSlPzGAJcExHlfQf51liz
 OCOSDABPJiJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaiHb7QAKCRD6UCkIqsW9
 0J6WD/0Z8lBgQ1MuPW0rDHqnrcon/KFXZUwq3cjDwyiCbtTXQiqqqEQxzoFn4yoVsgCmwPqmeOm
 Cx8DTKkFZa72O2fudXulQnzc7oh1qvTtZL2jIN9XCKwsrlO7B397BRIbW6DZDciF5UEjT2f2RKq
 5zYNXCH8IfEgUZMKL78lTl39Rcp6XKKbUoW5PEVlEm73+SKiXHxwzFfJDkH9jcjGprTlztQ0T/4
 DBj4iiOWhCKUfv8pxas1yPG0xsvkuhy2jH2bpT51pe1X9kWG7qV62tbl60SpN/1r4D6NS08pgtE
 /jtE3A+Q+2Ai7gLh+sEwFFLBptTVRkjy+rFiBivZDSkpYmEh4Z3a+FqILoLdN/dcb0zMcUra4a4
 vdzb2MagQbOIERyflkW4Apz1YcbHDkL/895OLyzPFZKeEu6BACgcnvSr7JOca+rn3dccghtl9vs
 5lbeD662E/jwmvKHa9r6/35yJ0BcM4EZcPeAFvpbHFJjgNA2CYXmZLjWWEuw3bS7+DPTVPSN1s9
 kZ8uc2TYKagptlINpzFfIOqH2ojTx4awhCIuHNDv2K7rqJve7fI+WZewsteU15iOq9AfRec34+u
 Tdpn/pMgwdni2r7UW1vly0W0TNj1enYARL7mXpTRJR0J0On5QpNOeJfBJypkxp5AS6MB1G61dMu
 wuM844VmxxYXIDA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Update formatting if use statements in preparation for next commit.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/sync/aref.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index 7491382bcf29..818c84fa923a 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -17,7 +17,12 @@
 //! [`Arc`]: crate::sync::Arc
 //! [`Arc<T>`]: crate::sync::Arc
 
-use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref, ptr::NonNull};
+use core::{
+    marker::PhantomData,
+    mem::ManuallyDrop,
+    ops::Deref,
+    ptr::NonNull, //
+};
 
 /// Types that are internally reference counted.
 ///

-- 
2.51.2


