Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A2222582;
	Fri, 23 May 2025 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011955; cv=none; b=JDVkh1teJl/q5r6Z1ArLVOek1Pd9IQeDHaCT2l646+C7OxrHTZWipdPKuSpa1dxo4w0EdjjyK9Iy/uYyOAGIDSYYTlVMLmb4wk0sjYLaSKjVD4LV05owdpVdpq6XyWTfJ8WLItBFTm8EOLXFeoWi0nNYALvEHJ+LU/TtWljqLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011955; c=relaxed/simple;
	bh=WtfxZc3ql2DwHkxLZ+K1cXWxYdXZeMWf1geuA3qEH7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAH2yOhUkjQzjFZtBdcRBQ/x3VLLN1cb1wOOmPMfUlnaxzgOELm4908qVP4Qv0YerwUqMIG7vW6SvKZykLP/JkQAvKZaNp2P2xI7cZfOrQ0dvcYcgVzbB5IVxURNWxwbb5iWp3nLjbVC6dyA6VeszZZ14uDFzTkDJDZdDEVRMzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXKN2HhL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXKN2HhL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92400C4CEE9;
	Fri, 23 May 2025 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748011954;
	bh=WtfxZc3ql2DwHkxLZ+K1cXWxYdXZeMWf1geuA3qEH7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gXKN2HhLYzp/D0yQJluwxfs+UKMMpDF8P/ilNBpmo3SRhl0XYh+rqlwWiD0B+z1vj
	 P5vvnU2sJQ4gZ9p6rHY4bhHkTmRLlPg22o4YsCTbxmhpJfMrVPzCYTtP4VBdLoA+PH
	 A6UhWfHmrVIsXOECcKelAXAyHEo3hSSQqsl7nSPdAHootYFI0faFgrLZW1pfJ1xI/3
	 IKFPMG0mPihFkTKYywQ+vWQrL8CnwCWrkAja7a3yPRqnalmkyyzhtImRAHYHviRB/G
	 qbpXEdNW8O6wyxBmns8Iaiu9tqU3CLEwl9ELfYC1Noef0nuNatVpiU8QVDSnBQnbcQ
	 4Q7WT5V3GZ0tw==
From: Benno Lossin <lossin@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Yutaro Ohno <yutaro.ono.418@gmail.com>,
	Xizhe Yin <xizheyin@smail.nju.edu.cn>,
	Manas <manas18244@iiitd.ac.in>,
	Fiona Behrens <me@kloenk.dev>
Cc: Lyude Paul <lyude@redhat.com>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/13] rust: block: replace `core::mem::zeroed` with `pin_init::zeroed`
Date: Fri, 23 May 2025 16:51:07 +0200
Message-ID: <20250523145125.523275-12-lossin@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523145125.523275-1-lossin@kernel.org>
References: <20250523145125.523275-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All types in `bindings` implement `Zeroable` if they can, so use
`pin_init::zeroed` instead of relying on `unsafe` code.

If this ends up not compiling in the future, something in bindgen or on
the C side changed and is most likely incorrect.

Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 3 +--
 rust/kernel/block/mq/tag_set.rs  | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index cd54cd64ea88..75b90fe20c7d 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -93,8 +93,7 @@ pub fn build<T: Operations>(
         name: fmt::Arguments<'_>,
         tagset: Arc<TagSet<T>>,
     ) -> Result<GenDisk<T>> {
-        // SAFETY: `bindings::queue_limits` contain only fields that are valid when zeroed.
-        let mut lim: bindings::queue_limits = unsafe { core::mem::zeroed() };
+        let mut lim: bindings::queue_limits = pin_init::zeroed();
 
         lim.logical_block_size = self.logical_block_size;
         lim.physical_block_size = self.physical_block_size;
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index bcf4214ad149..44d4c8d800e9 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -38,9 +38,7 @@ pub fn new(
         num_tags: u32,
         num_maps: u32,
     ) -> impl PinInit<Self, error::Error> {
-        // SAFETY: `blk_mq_tag_set` only contains integers and pointers, which
-        // all are allowed to be 0.
-        let tag_set: bindings::blk_mq_tag_set = unsafe { core::mem::zeroed() };
+        let tag_set: bindings::blk_mq_tag_set = pin_init::zeroed();
         let tag_set = core::mem::size_of::<RequestDataWrapper>()
             .try_into()
             .map(|cmd_size| {
-- 
2.49.0

