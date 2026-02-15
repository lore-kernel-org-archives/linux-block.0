Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A74F30E82B;
	Sun, 15 Feb 2026 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199072; cv=none; b=Cktr3BtEhO1cEVEKcuOFV9jePYYhPbd7Yp2uVwbHpaWnNi53sV0y6l64Gy864ewuAXIM5PgucQcJV+iaVOFzBuYe4dMYDmywzsGggBwowlgRmDDS6iYjKC0W8ykahoAydtgH2PUPkNk/ApSFk4IiYsIvl/s5eh89Hh4NATXDg1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199072; c=relaxed/simple;
	bh=lMkix+l7YL3LsaeozijpZ70ut/nAoZ1bvzW7x8MaTVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZTWGp2HGteeWNh6GwWi+rccypX7m7VVHuvOzsgIMrtiSF7mhbhnXVn/xYjpCQswUY5+h1/+1Vys2kTtiHzgGPL2wgGhuMzOPw5u60RakK83lkWiN+DAztq5/xDMUmPWB41GX+Xbrmq2qDok07baYJMAhnmxwlyCBpOmoOSFYO64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/HS3paD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/HS3paD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AEEC4CEF7;
	Sun, 15 Feb 2026 23:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199071;
	bh=lMkix+l7YL3LsaeozijpZ70ut/nAoZ1bvzW7x8MaTVg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R/HS3paDi2eXXvgNc/RC2Gh15brVOf29/uOZWoin9FCssxNtw01OqyYUNZtHcBJnj
	 N0ZIuR24Dz0MDafAvoLvM7OlIkk0Kops5y1M6Rmj6+6JC8Adf6tU2Kx/OzF6EHyg6v
	 Q6lHBxRHdswAmozCKwNl1Yk6Wbl6EY4Yn17UR2P/HNwSChN8JzVddKHggptzdBx6p4
	 4NY1+fg2SOBwc7lHzoeOPKS6gOXuw5RkwFyDC4Kx2UZVzhHBws6oL1f8YmtXRwo3iK
	 XmPknUyi/LfsuSAYI/GuKk4my1XcGX701xHJ04UM6tTXm3OOSImI5IWoJURQyYw+xG
	 lXMdkNnBwpCeA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:39 +0100
Subject: [PATCH 52/79] block: rust: add accessors to `TagSet`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-52-de9a7af4b469@kernel.org>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=lMkix+l7YL3LsaeozijpZ70ut/nAoZ1bvzW7x8MaTVg=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhKcY5nY1KWMizzxuSEORA04SamyEuwDQMar
 kiUG9Zee1mJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYSgAKCRDhuBo+eShj
 d5v7EACQiUbG3DpCSqYweozV15pPocS41T8Gc3taZE4wwex28+Dgu0T+ZjyUxhoI5rWG47Sorzl
 iHOhY9a567WS4In+gqDkVx3HHfzg9GpiDdtrIganFB4y381gFo4nL+x09xDr73iF8BLhdWP2HL5
 l7aqqNKU+bIB4oSyL6CsqxHkIKhhFJubVmGr1E1GZxO5yD0CCWtObhTK0MPuq30Ty88uXYjhdCQ
 QMXWnqTQkCmIzfEftgpvlqABMGH+3i0fSf2UZsQ7gWrJsbpkFGYoh4PdropXXPs8GG5uuiDIoLe
 xOp8sxKLgd+xFCVDprQNmGyxwGoiNvFmCwpuilkzI2MvCkvYyvN5db+EHfHKGnJ/uc9lqx7pUL6
 hqemjwBzYaKc25c9JD1MuvLdnzQ/On3Tsrb7EC5Wfn92fZ+IbOW89ZpE5XEKlrwwzwWRbNl3Gj0
 PfJ8nwjnFhPIRv4RsUH034uZpgtMjpqmi35EtgYTNrJxX6jCkj0EzZZLP91tbWYkyL2jMNnJ9g6
 m9/gqpSyPokz0MhvpfXKFNwJ6Z+JM6hd5c4iFirSSUhEv3oxuWfRb4nsbcbOTci4ApNGfJls5wr
 H2R5Vx9SJYZTnGs/tqcRpAeDm+eAlG7T2Kmu978bkDJFsrIGzKj1enxr3EXEK7AizS3QKkgTrdh
 7OuWjn0T4XL2IYw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add `hw_queue_count()` to query the number of hardware queues and
`data()` to borrow the private tag set data associated with a `TagSet`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/tag_set.rs | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index e6edc5bc39312..4d00979a83dbd 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -4,8 +4,6 @@
 //!
 //! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
 
-use core::pin::Pin;
-
 use crate::{
     bindings,
     block::mq::{operations::OperationsVTable, request::RequestDataWrapper, Operations},
@@ -13,7 +11,7 @@
     try_pin_init,
     types::{ForeignOwnable, Opaque},
 };
-use core::{convert::TryInto, marker::PhantomData};
+use core::{convert::TryInto, marker::PhantomData, pin::Pin};
 use pin_init::{pin_data, pinned_drop, PinInit};
 
 mod flags;
@@ -137,6 +135,22 @@ pub fn update_maps(self: Pin<&mut Self>, mut cb: impl FnMut(QueueMap)) -> Result
 
         Ok(())
     }
+
+    /// Return the number of hardware queues for this tag set.
+    pub fn hw_queue_count(&self) -> u32 {
+        // SAFETY: By type invariant, `self.inner` is valid.
+        unsafe { (*self.inner.get()).nr_hw_queues }
+    }
+
+    /// Borrow the [`T::TagSetData`] associated with this tag set.
+    pub fn data(&self) -> <T::TagSetData as ForeignOwnable>::Borrowed<'_> {
+        // SAFETY: By type invariant, `self.inner` is valid.
+        let ptr = unsafe { (*self.inner.get()).driver_data };
+
+        // SAFETY: `ptr` was created by `into_foreign` during initialization and the target is not
+        // converted back with `from_foreign` while `&self` is live.
+        unsafe { T::TagSetData::borrow(ptr) }
+    }
 }
 
 #[pinned_drop]

-- 
2.51.2


