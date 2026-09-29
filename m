Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C61148594B;
	Tue, 29 Sep 2026 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674547; cv=none; b=UdwZ8zZ/CyGTSX9vQyGeoHBWRziGnoR+QjCrX4Nlf8ZjaSdPP0Ngv5FZBfm4mR10zGRCdHY0dotuGwe4lc+pFifP8lV2RWl4jVma9CI5z3CZGsVH7INz9n/Kw80Vz155sK4vOh/Bwr5K1+RsLNBiZQvVir3glCvA7lmM1RPzJA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674547; c=relaxed/simple;
	bh=JWUgTW58DKJa+SF20VPBKXZN5xw3rbFKDUJVZsaDaUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A4W3PZSUjJT4fayAhMmrH9yFk8jPSPlNd4djIolGfuqwlQQ/4uKUxedmHYhJ024z/17AecvD+DZQP/S/OTUDRYbCheFtWHGInA++Y7WMYeTojNJZMa/ea2G8q5vEzI65ELt9Rv1DNy/n39Fol9kN1TWNXNmNKEe9iZdHRVjo5A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdWMe9T6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdWMe9T6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C7F1F000FF;
	Tue, 29 Sep 2026 09:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790674546;
	bh=StXmc2LqbHdixuPvvg8ubUtbQsp0wahYjgdRPfdzTKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VdWMe9T64Z/qCJaqlBMit803Sq1//0IIpO67rg3qEgmAYlUPijxj10JHpi3LFYEuQ
	 NpJLDsLAJ7ewRxyvTBDFk1u8fvZkJzNsli8apmii/pDz12ZEUoO1IlsBV0WwTF3wCK
	 w9GhCJdhIOmLfAayBWmF5oSfURxTthrMjhPA2VKp7pLe2fgXpJ1X4wKxMAqhKCHrzF
	 u85ypEcaDviItMKC8xIGPGVaOI9zumpBkRWuhQt9axwNoHOX04IhcmLCrUdKoZNu9S
	 uxZb3AY1VbKhZpcYBptisYL61jnf4G7PqF11RWmd6iSNXbVUqevqvQJyRs15z7BA3O
	 XglKgFIxQe/Rw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 29 Sep 2026 11:34:03 +0200
Subject: [PATCH GIT PULL 5/9] rust: block: gen_disk: set fops.owner from
 driver module pointer
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-rust-block-for-v7-4-rc1-b4-v1-5-642a4c1aebd7@kernel.org>
References: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
In-Reply-To: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2664; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=b7Nrhx/lRf7Kc2gzxnShGkiGd+OZ0loDoAZS400fyJ4=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqu4YXOBxIGpTgdJX+iVF3j8XKtuPXRAgCJISQH
 h3cm7q6dbWJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaruGFwAKCRD6UCkIqsW9
 0HwlEACX0HM/3ggs+3LqLGQ63dtAgm8A7dz/vIGMfOrEacwEb2J8pQu2eTnrlY6JAB3MgRE+jMh
 co0UGascrc7YFEIJKYGsWXLrpfs/Tzvd0fgTDysTRDqSz5mFAPUfFM6AftjzNMmZffyIhmiCVYY
 T8sbKZLn4T+lmIAWeQua10EojUr4wZkXVM9hBzZ/sXOc02ArPLaV331g0AYR4ik+DtCrlKPPRVw
 CeWb2qUll+xedow/R1nXSe0n3B/wXH2oyYZ5IWprXNPDGPsthAwShFObyotC0HU/uwjS2/XN54f
 Fg6WViiNsd6dTxKG8zXuK5StJNfYfchcSi3s9k1ZDTjjAWtnGgSnnX1/LNXyQq4+zgZ46d62MZ+
 txHWWsNiQfA6J6h8eFqhAkrBxm8npGBzVR35LH0VGtuSvkTeqPS37l7+AhmAC8jgn76XGRSJKPO
 uWHCdlTYdMqzaO0//yYmNN+qLBDFkQeD+l9VNDlkyaAosj7S6wpo5VlDSxssfVnuHYb3e3EfL5m
 8Iwm92dwKl+Da+kjbohmlaX1V/TPysFwL4u2I6WdmGf2jvlBmPPWCQGMfx/BXgAZBNvcgcohOus
 lVFqssbq/O4CfMRqWB9Mtk8DmTUFzjTiUl0JA0XC7KBmnDSJfv4zrNZsCCcXXZPV98/wiIfQn1g
 XrEE9Osk8oVlJGA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Alvin Sun <alvin.sun@linux.dev>

Set `fops.owner` from the driver module pointer via
`this_module::<T::OwnerModule>().as_ptr()` instead of defaulting to
null, so the module cannot be unloaded while a block device is still
in use.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
Link: https://msgid.link/20260811-fix-gendisk-owner-v1-1-c0fe4a449ecb@linux.dev
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 080dedb5d5d9..90d364ab3bf2 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -137,30 +137,9 @@ pub fn build<T: Operations>(
             )
         })?;
 
-        const TABLE: bindings::block_device_operations = bindings::block_device_operations {
-            submit_bio: None,
-            open: None,
-            release: None,
-            ioctl: None,
-            compat_ioctl: None,
-            check_events: None,
-            unlock_native_capacity: None,
-            getgeo: None,
-            set_read_only: None,
-            swap_slot_free_notify: None,
-            report_zones: None,
-            devnode: None,
-            alternative_gpt_sector: None,
-            get_unique_id: None,
-            // TODO: Set to `THIS_MODULE`.
-            owner: core::ptr::null_mut(),
-            pr_ops: core::ptr::null_mut(),
-            free_disk: None,
-            poll_bio: None,
-        };
-
-        // SAFETY: `gendisk` is a valid pointer as we initialized it above
-        unsafe { (*gendisk).fops = &TABLE };
+        // SAFETY: `gendisk` is a valid pointer. We have exclusive access,
+        // since the disk is not added to the VFS yet.
+        unsafe { (*gendisk).fops = &GenDisk::<T>::VTABLE };
 
         let cleanup_failure = ScopeGuard::new_with_data((gendisk, data), |(gendisk, data)| {
             // SAFETY: `gendisk` came from `__blk_mq_alloc_disk()` above and
@@ -223,6 +202,13 @@ pub struct GenDisk<T: Operations> {
     gendisk: *mut bindings::gendisk,
 }
 
+impl<T: Operations> GenDisk<T> {
+    const VTABLE: bindings::block_device_operations = bindings::block_device_operations {
+        owner: crate::module::this_module::<T::OwnerModule>().as_ptr(),
+        ..pin_init::zeroed()
+    };
+}
+
 // SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a
 // `TagSet`. It is safe to send this to other threads as long as these two are `Send`.
 unsafe impl<T> Send for GenDisk<T>

-- 
2.54.0


