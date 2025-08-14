Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242C72EAB95;
	Thu, 14 Aug 2025 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163884; cv=none; b=VQU/P9jzEy6tGF4QOLZjs8KJZQmNp0RjOyTfymRH1CBzzKY29efbiweIELA87c7oaL9rnWlq+rhLwtSUM11t2PYRFjwAmmuEwiSPa5LHSsY+o5hWZtrHpZxpyBwR+MNzGlMTIBBapFFH3a4dd3t2LaDSvxFUP+sWXYECPy9Km1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163884; c=relaxed/simple;
	bh=yKJUWm1zLKi1m/VPpREySff4bPrqQHo2VgSLpYvSluo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Va+KAnr6IPobbXzGkJGkcJiegUdc9RRacX1dcoycG/No1eLAdmRlCjQYBs3MRqLyeIp90qIEspWLUOrX4iRMA1RF5IJUExOQYqcPt3dL7rK/BbEG7ozAVtpdd7dY0yYtcDmWcg/nYYnkhvtfFzgmEP6jL2Nbh34uw/HtZuYWzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxSST9/E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxSST9/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7DAC4CEED;
	Thu, 14 Aug 2025 09:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755163884;
	bh=yKJUWm1zLKi1m/VPpREySff4bPrqQHo2VgSLpYvSluo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kxSST9/E5SjL+n89YastPyvyzkDMOtJ5q7V6TqcUjFuLgzUbcauZQcC0M4PewJ9ln
	 c0Nrc1goBx8OEwwt1C/0zEh6g6ULihnrut8r2Ck8ELDTi7NOtooZi2jA7kHhWaDOk0
	 FCPNH42dMrlD25ILDTxCp/PaVcQyULspu4GDAr17IQe4KwhRUuko1hg9G/QqnNC+eF
	 F6pHarsNFPsiA+LXo1qQw5EtkM046JYJn+wbla3iuETL0zK/iKwYtRtHWMzFrgt35r
	 tUNY9S0ruMTmiy4lerhidIjUw88nN/S5rJQAm4yvdbEpbbKOzSWi0wjdAUWwfOtJug
	 M7NjGr8sj4Zug==
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
	Yutaro Ohno <yutaro.ono.418@gmail.com>,
	Manas <manas18244@iiitd.ac.in>,
	Xizhe Yin <xizheyin@smail.nju.edu.cn>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/11] rust: block: replace `core::mem::zeroed` with `pin_init::zeroed`
Date: Thu, 14 Aug 2025 11:30:32 +0200
Message-ID: <20250814093046.2071971-6-lossin@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814093046.2071971-1-lossin@kernel.org>
References: <20250814093046.2071971-1-lossin@kernel.org>
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
index c3cf56d52bee..dae9df408a86 100644
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
         let tag_set: Result<_> = core::mem::size_of::<RequestDataWrapper>()
             .try_into()
             .map(|cmd_size| {
-- 
2.50.1

