Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BACA2FFF8F;
	Sat, 18 Jul 2026 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784399029; cv=none; b=NGS6pK1Jyi6ii/AXnjaKOt4m69PCskFF/Lc3LZ/RvHdW9ZX9/KEjzOS17kKz596VUueneJn3+5BAFiUAiKSuFmdWkDRsasbJA+Evx9OrgQ9dkIkCzx3CPKVYipXroFcX46f1rukK0z+SbDk3PtGDMB3lYQaV8SAkIN6gS15o6+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784399029; c=relaxed/simple;
	bh=l3yZ+37tfBSBMZqQe6H1vW57ZymL2Ah1mvxBjw2Pzwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXunzQmP87EuBaoSc5nWKuaQVKvP7Mvz1Zho4iLO7KcJHhHHEobtVe+sPhM61i/kad54p7o71js/zL0vnjgIO7MupVy7A61KTGFwamOogxNipeNdpU1Yqv72STwxagtpn17k6A6fW1HHaXX7ShCsBMj79n+nNTpTD5tTURjcu0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBiq5/SL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBiq5/SL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3B91F000E9;
	Sat, 18 Jul 2026 18:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784399027;
	bh=E9c/HTeldoMf/dhz9RJlXtx3LAjywkGV2QDWT2jjvy0=;
	h=From:To:Cc:Subject:Date;
	b=SBiq5/SL9PTncSwGU8y0X51qKhqdC1e3GQqpxzsRloSA2wtfBG0bx+7PmyK3dh8p0
	 fIk4Kv7afAkL0MAzGGc53Mw5nl4PoxvuPGewxbZo5w+NT2H0KhNee3YqhlTRbLVqaM
	 N1NQhF4KvGPvQrs8KaTQM9T42A77sTh4vURqsyZQqtsvYlBwrL2tX4pXpgaV4z0BA5
	 MEFSzM7Afa1XtN7jqnt1QjrapaowYFMFfqcJ+vq60deMG1rEmk2dl7HD+AmQedl2Ha
	 IK9quIPzqc6JnzF7e7I8+xub/idVt6Qf30XPU9uouAgw5GiGm//+bRsMHSJx7ZhX68
	 ufyF6iZBadzrw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH 6.12.y] rust: block: `allow(deprecated)` for `fetch_update` for Rust >= 1.99.0
Date: Sat, 18 Jul 2026 20:23:23 +0200
Message-ID: <20260718182323.107565-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with Rust 1.99.0 (expected 2026-10-01), the
`Atomic*::fetch_update` method is deprecated, with the compiler suggesting
the `try_update` alias instead:

    error: use of deprecated method `core::sync::atomic::Atomic::<u64>::fetch_update`: renamed to `try_update` for consistency
       --> rust/kernel/block/mq/request.rs:206:22
        |
    206 |     let old = target.fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| Some(op(x)));
        |                      ^^^^^^^^^^^^
        |
        = note: `-D deprecated` implied by `-D warnings`
        = help: to override `-D warnings` add `#[allow(deprecated)]`
    help: replace the use of the deprecated method
        |
    206 -     let old = target.fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| Some(op(x)));
    206 +     let old = target.try_update(Ordering::Relaxed, Ordering::Relaxed, |x| Some(op(x)));
        |

The deprecation was added in Rust 1.95.0 [1], but only triggers starting
with Rust 1.99.0.

However, we cannot use the alias since our minimum in 6.12.y is Rust
1.78.0 -- `try_update` was added in Rust 1.86.0 [2].

Thus just allow the lint.

Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Link: https://github.com/rust-lang/rust/pull/148590 [1]
Link: https://github.com/rust-lang/rust/pull/133829 [2]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
Warning: this is a 6.12.y-only patch -- I assume you prefer something
local like this instead of backporting the commit that made this go away
later with the move to `Refcount`.

 rust/kernel/block/mq/request.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 7943f43b9575..1c7937653542 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -203,6 +203,7 @@ unsafe impl<T: Operations> Sync for Request<T> {}
 /// Store the result of `op(target.load())` in target, returning new value of
 /// target.
 fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> u64 {
+    #[allow(deprecated)]
     let old = target.fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| Some(op(x)));

     // SAFETY: Because the operation passed to `fetch_update` above always
@@ -215,6 +216,7 @@ fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> u64
 /// Store the result of `op(target.load)` in `target` if `target.load() !=
 /// pred`, returning [`true`] if the target was updated.
 fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64, pred: u64) -> bool {
+    #[allow(deprecated)]
     target
         .fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| {
             if x == pred {

base-commit: 6c7577041b6a76ee4e18c3910bab12a268df037e
--
2.55.0
