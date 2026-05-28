Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6993B960B;
	Thu, 28 May 2026 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969056; cv=none; b=Otv5HQZMIKC5haF791LtKUaDqJGfacY1mJZBrLs16/SNlm+xr0AAvWs9BAqQIM4xEFBL72b9b00UtA1TnOC280Bsapuz38tHAnKKk1J1Mue3s0ihPXRSYxjbh+kmdNMNwIQmgj7Fc0sIT5CntHYOacR5yb3SXOUX/ZNOKZqLo9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969056; c=relaxed/simple;
	bh=aWA7rEsrqvANl6MVbaBX4D4zGr5K+M7ddhon1j6yYQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RCv13eWj/HU9XjmS518e36AcJHAeUon9BT/9/RVlK4JV3clZPlfoRxQqak35ItjENIIY6sZ66nqtZSBQ0CGbXVkU9Qj5Fc3SQP6dJbxjhKnNkikQT6LdebkBp78VrtjqlRLPUags6sAs42c0g/t05fuMJwxE7OGtXBZxFF4IVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE1J3bRw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE1J3bRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB861F000E9;
	Thu, 28 May 2026 11:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779969054;
	bh=tzOYLnNmfatgJt40jq08mU/2TFAS1f4Zcn4F1Y76X1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nE1J3bRww4EW8HPtW8n2ESVbCUKWErXoOBQmSxy+3ZBEdUxTKzOJHoMKav/qwYzdD
	 /J95DocihKTJ+P91MF7sXeXkCxAiI07pSBwfC5LkucK5LGFK5O6cVw2zGR0USTchd8
	 tlHdWfe4+IT1vqZFEGPD7FNA/2BvWVuFlCZQ+yDz32N2YyXRZrogv5oGPaKuN/fyQ2
	 hgWCQ+w3UjvA9EkxxLGyBm8e6ZQboy7FQ+zSBycB/R/u06hWyxC9BsHr9xql1VXM4k
	 dFyQ9s8lohk8fVGLlXSUCgHlu+ssXI7MVTCA0yLLOZHgSbsJh92O8tes5jqEiGOCJA
	 K/eCczfGssvQA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Cc: ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com,
 axboe@kernel.dk, tamird@kernel.org, sunke@kylinos.cn,
 yuantan098@gmail.com, bird@lzu.edu.cn, royenheart@gmail.com,
 n05ec@lzu.edu.cn
Subject: Re: [PATCH v2 1/1] rust: block: fix GenDisk cleanup paths
In-Reply-To: <e14c015e2e0bde04f84a9452330b94436e2d8e68.1779901336.git.royenheart@gmail.com>
References: <e14c015e2e0bde04f84a9452330b94436e2d8e68.1779901336.git.royenheart@gmail.com>
Date: Thu, 28 May 2026 13:50:39 +0200
Message-ID: <87ldd37nxs.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ren Wei <n05ec@lzu.edu.cn> writes:

> From: Haoze Xie <royenheart@gmail.com>
>
> GenDiskBuilder::build() still has fallible work after
> __blk_mq_alloc_disk(), but its error path only recovers the
> foreign queue data. That leaks the temporary gendisk and
> request_queue until later teardown. If the caller moved the last
> Arc<TagSet<T>> into build(), the leaked queue can retain blk-mq
> state after the tag set is dropped.
>
> Fix the pre-registration failure path by dropping the temporary
> gendisk reference with put_disk() before recovering queue_data,
> so disk_release() can tear down the owned queue.
>
> Also pair GenDisk::drop() with put_disk() after del_gendisk().
> Once a Rust GenDisk has been added with device_add_disk(),
> del_gendisk() only unregisters it; the final gendisk reference
> still has to be dropped to complete the release path.
>
> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Haoze Xie <royenheart@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Looks good to me, but could you please add some newlines for
readability:

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 6ea16b943c99..fc97dd873974 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -149,6 +149,7 @@ pub fn build<T: Operations>(
 
         // SAFETY: `gendisk` is a valid pointer as we initialized it above
         unsafe { (*gendisk).fops = &TABLE };
+
         let cleanup_failure = ScopeGuard::new_with_data((gendisk, data), |(gendisk, data)| {
             // SAFETY: `gendisk` came from `__blk_mq_alloc_disk()` above and
             // has not been added to the VFS on this cleanup path.
@@ -157,6 +158,7 @@ pub fn build<T: Operations>(
             // converted back on this cleanup path.
             drop(unsafe { T::QueueData::from_foreign(data) });
         });
+
         // The failure guard now owns both pieces of cleanup; the early guard
         // must not run on this path anymore.
         recover_data.dismiss();
@@ -225,6 +227,7 @@ fn drop(&mut self) {
         // initialized instance of `struct gendisk`, and it was previously added
         // to the VFS.
         unsafe { bindings::del_gendisk(self.gendisk) };
+
         // SAFETY: By type invariant, `self.gendisk` was added to the VFS, so
         // `put_disk()` must follow `del_gendisk()` to drop the final gendisk
         // reference and trigger the remaining release path.

With those changes:

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg


