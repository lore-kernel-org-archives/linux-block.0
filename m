Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC614DA549;
	Tue,  9 Jun 2026 19:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032397; cv=none; b=I1a08JkAN0hPxJtAfo+8VnuPBIOFuRdrl7mYXemMhUg8KUsl3xAzHoA4CFP7V0qy9hlqjiD0CM4ZKmuB5oAi9F8WpZLXk6Yz65bFgqmWg4FiRFFft66MCTnJMHcF71LU3JfMBkJ01Y4dMjylQB90LFEDcf648hu+NhJtvnUDyxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032397; c=relaxed/simple;
	bh=j94rzYXVcMOYMwkP1BfZKPpHsVdQeUm+yqM3C4KWNns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JzhLkFgocFqREBOvtvbHYdphaTI/Kk4oN7psN7aIOzgYr87TZJFdgQEaQ48643hKr/ezVkrb9DmW4eBxeyQ5M1mdS81u2VsVOpWMI1MUZ/fYGA0OCGaXPyYsW3Kbg37TbYZlR7cn2HaQJdlM49kq6jgZqjCu6jIAAYjpKmu1MuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALQ4MDJ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALQ4MDJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E211F00898;
	Tue,  9 Jun 2026 19:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032395;
	bh=+SB8unmwrAO9mUO9xf4AbinL27K1XIFUUebCtsNMw1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ALQ4MDJ39UaQi4Xcs0/po7LiGIPPyP5hBFLR0xeILyrKkWGyU2T13VYHajc/84m52
	 lOhsZ9Pl4J6iG2SNWK3KrVrLIWeN70xM8JrHv8jjZT95NKJylLX/a4NyuzVsKmkpHy
	 POtU8lbn05to8Jz8D3CVT0tNcIvCqSXxWURs/EBmyeax80BEVIpQpdZOhEPfZzpDqL
	 mJTh7ZGuFe0ZL8NckFGbZBnqNXKJqtCawKadfffdzXFCSMQuysSbS65b+HiLlW7FQG
	 AbfFHuLz0h+ogiRgdj9JcjXHUzXrvhVbruVMLTmR9JpVPmyh0exfPcItLKtQlu2Jcq
	 2Ee86TSyLLBJg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:07:40 +0200
Subject: [PATCH v2 01/83] block: rust: fix `Send` bound for `GenDisk`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-1-82c7404542e2@kernel.org>
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
In-Reply-To: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 "Liam R. Howlett" <liam@infradead.org>, Boqun Feng <boqun@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 rust-for-linux@vger.kernel.org, Yuan Tan <ytan089@ucr.edu>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1957; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=j94rzYXVcMOYMwkP1BfZKPpHsVdQeUm+yqM3C4KWNns=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGS115ZnPcBcAbPrOuPuRVqGsLxm3lnTlZcjW
 axvRMhOjeuJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihktQAKCRD6UCkIqsW9
 0GV+D/4l9Bq3nvQRAYx6wrVRSnUhKN8gQ453qln/Ip/dk0q8mtRhyZ0Za/ISiSc5OIZp+4G3xPb
 2d0KQ6dpftTRPG0isURFnasRIjo30OxcCpEH2ICK4N21I/RiyGMOqsAQMteSdFPQPRWgh9HiJRz
 hFfXXLzIdGxd3T+tpvOsfMnYe4PI+JS8C7gO/8Y6s+jimfh3vU+oKyHs89kOsEShkPnQfDSx3fZ
 x50Plys3MjPb5vaimaBRtnziqYsi9IkRmhkyzDKXl+RSZ+Tl6xCWucnlzQoBkxTrWld6IYjdhkA
 aTyWkcib7SjvbwEQqu43KtlhmHL/CAoNPgXSh9uNz+6n+KXwSzZSxoVWb/5A6elZZeUtcrcgvw2
 aB4OrN4TnINzJBneIGB5REjg0Do+AFBoJKPtP5BYa026fLRymtQVd50v6eUlvHvNLgNli9X8QFu
 KJiurZBg81YdReVkJQezYm1dgGfyPtZxiRhPgN8UbxJPxXMHE+1s4jnnVM2ATmmdAfGbR+Ugrgz
 8B/32qMGDi/1zCDNIrR1WnMQ7dyDus5zLM6m56VLTtW0nGq1dLGwiDsK+Mzh6rIszwtFkuo/2G4
 Glk/yxf5td/ojCS22TRv4n+bUDGP3zuQU8u77H2mjPPIKLfJCY07oq0xFlM3a3zLfhXlsVJjHbb
 K4TkagJxdHac3MA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The `Send` implementation for `GenDisk<T>` was conditioned on `T: Send`.
This constrains the wrong type. `T` is the `Operations` implementation,
which is typically a zero-sized marker type that carries no data, so `T:
Send` says nothing about whether the data a `GenDisk` actually owns can be
moved to another thread.

A `GenDisk<T>` owns the queue data `T::QueueData` (stored as the
`gendisk`'s `queuedata` and dropped when the `GenDisk` is dropped) and an
`Arc<TagSet<T>>`. These are the values transferred when a `GenDisk` is sent
across a thread boundary, so the `Send` bound must constrain exactly them.
Bound `T::QueueData: Send` and `Arc<TagSet<T>>: Send` instead.

Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
Suggested-by: Yuan Tan <ytan089@ucr.edu>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---

Please take patch from Yuan instead of this one, if they send a fixed
version [1].

[1] https://lore.kernel.org/r/8839ddc5ff54bf454d508cde91d27d00fc3e2dd8.1780633578.git.ytan089@ucr.edu
---
 rust/kernel/block/mq/gen_disk.rs | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 912cb805caf5..b36d24382cc3 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -199,8 +199,14 @@ pub struct GenDisk<T: Operations> {
 }
 
 // SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a
-// `TagSet` It is safe to send this to other threads as long as T is Send.
-unsafe impl<T: Operations + Send> Send for GenDisk<T> {}
+// `TagSet`. It is safe to send this to other threads as long as these two are `Send`.
+unsafe impl<T> Send for GenDisk<T>
+where
+    T: Operations,
+    T::QueueData: Send,
+    Arc<TagSet<T>>: Send,
+{
+}
 
 impl<T: Operations> Drop for GenDisk<T> {
     fn drop(&mut self) {

-- 
2.51.2


