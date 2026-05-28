Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5226D3290B7;
	Thu, 28 May 2026 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953330; cv=none; b=Bb9FEkN6XoDS2sR9VkDlXK4y/OY8a7E1060EZRjQ4GJ3haPZ/HXAgYoX+nVyhX7Aim6bx9bDxPCLEtJPVUbkFPizKH7Svn4U4TO1ETogVuWM4DQnmt2ILo55cr0yv99lSzqxFTlL3x29r82Aytxf6jn5mwukuWqF48KmoxBJOJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953330; c=relaxed/simple;
	bh=Jo0H8Cca5NP/eFYzNdFQsdHpOhXkaDyGJ0uBm0IYeM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDnhVI6sWZ+xXW5UFM9A8b9rC5qJtTzPDGbWJM8Adm3O+w/Z0t3o5tqcewFlQIj4s2XYKlO097UqlXnsKe074Oq3215yVGvYucWiXB9elgMJB7RbcMtY1V4bzlcHPo602efmSIPoA1Ut9P8jh31y5Pzvb/xneyqGh4W9EaPLI50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAD3E76S7hdq6Ok3AA--.40328S2;
	Thu, 28 May 2026 15:28:18 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	axboe@kernel.dk,
	tamird@kernel.org,
	sunke@kylinos.cn,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	royenheart@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH v2 1/1] rust: block: fix GenDisk cleanup paths
Date: Thu, 28 May 2026 15:28:03 +0800
Message-ID: <e14c015e2e0bde04f84a9452330b94436e2d8e68.1779901336.git.royenheart@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAD3E76S7hdq6Ok3AA--.40328S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy5JF43ury8CrWDJryfCrg_yoW5KF1kp3
	93Gw4YkrWkGFn7tF4UAr4xur18Jw4kG34rAFZ8G3ya9F15Grn7Xr4FgF43ZryDJFs29rZa
	qr4j9rW3tr18AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRi_HU3UUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQABCWoWqU4S3wAAsf

From: Haoze Xie <royenheart@gmail.com>

GenDiskBuilder::build() still has fallible work after
__blk_mq_alloc_disk(), but its error path only recovers the
foreign queue data. That leaks the temporary gendisk and
request_queue until later teardown. If the caller moved the last
Arc<TagSet<T>> into build(), the leaked queue can retain blk-mq
state after the tag set is dropped.

Fix the pre-registration failure path by dropping the temporary
gendisk reference with put_disk() before recovering queue_data,
so disk_release() can tear down the owned queue.

Also pair GenDisk::drop() with put_disk() after del_gendisk().
Once a Rust GenDisk has been added with device_add_disk(),
del_gendisk() only unregisters it; the final gendisk reference
still has to be dropped to complete the release path.

Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Haoze Xie <royenheart@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
Changes in v2:
  - Add the missing put_disk() after del_gendisk() in GenDisk::drop(),
    as suggested by Andreas Hindborg.
  - Keep the GenDiskBuilder::build() failure cleanup fix and fold both
    lifecycle fixes into one patch.
  - v1 Link: https://lore.kernel.org/r/b6411cc055080c984a67bfad72fd683aa84b8e13.1779596478.git.royenheart@gmail.com

 rust/kernel/block/mq/gen_disk.rs | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 912cb805caf5..6ea16b943c99 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -149,6 +149,17 @@ pub fn build<T: Operations>(
 
         // SAFETY: `gendisk` is a valid pointer as we initialized it above
         unsafe { (*gendisk).fops = &TABLE };
+        let cleanup_failure = ScopeGuard::new_with_data((gendisk, data), |(gendisk, data)| {
+            // SAFETY: `gendisk` came from `__blk_mq_alloc_disk()` above and
+            // has not been added to the VFS on this cleanup path.
+            unsafe { bindings::put_disk(gendisk) };
+            // SAFETY: `data` came from `into_foreign()` above and has not been
+            // converted back on this cleanup path.
+            drop(unsafe { T::QueueData::from_foreign(data) });
+        });
+        // The failure guard now owns both pieces of cleanup; the early guard
+        // must not run on this path anymore.
+        recover_data.dismiss();
 
         let mut writer = NullTerminatedFormatter::new(
             // SAFETY: `gendisk` points to a valid and initialized instance. We
@@ -172,7 +183,7 @@ pub fn build<T: Operations>(
             },
         )?;
 
-        recover_data.dismiss();
+        cleanup_failure.dismiss();
 
         // INVARIANT: `gendisk` was initialized above.
         // INVARIANT: `gendisk` was added to the VFS via `device_add_disk` above.
@@ -214,6 +225,10 @@ fn drop(&mut self) {
         // initialized instance of `struct gendisk`, and it was previously added
         // to the VFS.
         unsafe { bindings::del_gendisk(self.gendisk) };
+        // SAFETY: By type invariant, `self.gendisk` was added to the VFS, so
+        // `put_disk()` must follow `del_gendisk()` to drop the final gendisk
+        // reference and trigger the remaining release path.
+        unsafe { bindings::put_disk(self.gendisk) };
 
         // SAFETY: `queue.queuedata` was created by `GenDiskBuilder::build` with
         // a call to `ForeignOwnable::into_foreign` to create `queuedata`.
-- 
2.47.3

