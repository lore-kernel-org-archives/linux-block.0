Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C8F261B71;
	Sat, 30 May 2026 06:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780121548; cv=none; b=jLVZDe55SBcsJ8EQcZ3oDM1pLbBR55hrObZl1eriU0kJLVpjbj1t9DM64hiYZfXvmf92ca6MV8cVzfFUQ+wgtoAjanF0Wajmbi/cZMGTLRlor6XOLa8qVgWKFmwLJvV+7zxtp54Ybgf6v9mNSwFaA9h9vDDkozRftuQ7um8uzy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780121548; c=relaxed/simple;
	bh=7ouJQbjnkf4ajwlrMpoph4gL41YDuMTIoHaBSseSOHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JBaagqpWJ9xoZPQrQDYdv1/SqgLDksi1rON4GJEvH5qjZl2PPtdQfrjW6Fi4TuXyXL2AOObdrBbzUM23hvc5jAUNSj2pg9Hdx0r+1ZI3+a+xW7J7kKvIKrnGuJDkUCA+NxmF0Z+9ltjtV+VjCkF11KVSH3OVmbycG2G93zCkiio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app3 (Coremail) with SMTP id ywmowAA3dv66fxpqXeQOAA--.28177S2;
	Sat, 30 May 2026 14:12:10 +0800 (CST)
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
Subject: [PATCH rust-fixes v3 1/1] rust: block: fix GenDisk cleanup paths
Date: Sat, 30 May 2026 14:11:54 +0800
Message-ID: <b70aff9a920cc42110fe5cf454c3099561863519.1780063368.git.royenheart@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywmowAA3dv66fxpqXeQOAA--.28177S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy5JF43ury8CrWDJryfCrg_yoWrGFW3pr
	WrWws0krWkKFn7tF4UArW7Zry8Gw1kG34rJa98C34a9F98Jrn7XrsYgF43ZFWDJFs29rZa
	qay09rW2gr1rAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
	W8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRpOJnUUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQsDCWoZTE8LOwABsB

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
Changes in v3:
  - Add the requested blank lines around cleanup blocks for readability.
  - v2 Link: https://lore.kernel.org/r/e14c015e2e0bde04f84a9452330b94436e2d8e68.1779901336.git.royenheart@gmail.com
Changes in v2:
  - Add the missing put_disk() after del_gendisk() in GenDisk::drop(),
    as suggested by Andreas Hindborg.
  - Keep the GenDiskBuilder::build() failure cleanup fix and fold both
    lifecycle fixes into one patch.
  - v1 Link: https://lore.kernel.org/r/b6411cc055080c984a67bfad72fd683aa84b8e13.1779596478.git.royenheart@gmail.com

 rust/kernel/block/mq/gen_disk.rs | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 912cb805caf5..fc97dd873974 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -150,6 +150,19 @@ pub fn build<T: Operations>(
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
+
+        // The failure guard now owns both pieces of cleanup; the early guard
+        // must not run on this path anymore.
+        recover_data.dismiss();
+
         let mut writer = NullTerminatedFormatter::new(
             // SAFETY: `gendisk` points to a valid and initialized instance. We
             // have exclusive access, since the disk is not added to the VFS
@@ -172,7 +185,7 @@ pub fn build<T: Operations>(
             },
         )?;
 
-        recover_data.dismiss();
+        cleanup_failure.dismiss();
 
         // INVARIANT: `gendisk` was initialized above.
         // INVARIANT: `gendisk` was added to the VFS via `device_add_disk` above.
@@ -215,6 +228,11 @@ fn drop(&mut self) {
         // to the VFS.
         unsafe { bindings::del_gendisk(self.gendisk) };
 
+        // SAFETY: By type invariant, `self.gendisk` was added to the VFS, so
+        // `put_disk()` must follow `del_gendisk()` to drop the final gendisk
+        // reference and trigger the remaining release path.
+        unsafe { bindings::put_disk(self.gendisk) };
+
         // SAFETY: `queue.queuedata` was created by `GenDiskBuilder::build` with
         // a call to `ForeignOwnable::into_foreign` to create `queuedata`.
         // `ForeignOwnable::from_foreign` is only called here.
-- 
2.47.3

