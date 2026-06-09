Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FA4408A3D;
	Tue,  9 Jun 2026 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032666; cv=none; b=H1L+7/OM5kxyMsdM84DX5w9XMoI8ecaJT9NZ5kun2f0tC/MtA3dqai/5GRJb4ahIlZYRG7PFI3VjgJthOs8E0XqocPdGwsfUBNxcS8yr4jkIbYvv8nUEiF7xFig6/6l38Yfa1h7NkBJLa3dLxAKwvVLNj8l8Ov+QQ2xeAoTY6P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032666; c=relaxed/simple;
	bh=6A74Jcx8EHUn7wYuZ9sgvdf2Nhmf1F3bFtPD29rpOao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A5LaewhsPNWK8j40jV2YtIV6acZi9FWp3pYga5y4Wa+/RLHRT61cnyagupbo+dt0nUAMju91V8xJGiv8hzxa4mj5MyBQSsKFu7haI+tz+AHMkcSM/cvQKxddyc3WRQNq91vK+jFQlDY1JDqJ3KHz8PqPQqOCFME2Eb9dWy3Jmc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ef6/ao6J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef6/ao6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80781F00899;
	Tue,  9 Jun 2026 19:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032665;
	bh=yhhiPZN9dpoZ4xyJGnlIqf2UGsG9mC/RzPjjGnQZ8J8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ef6/ao6J/2x2P2Q0Ul+w5+fI3fcDAeHUvj8joaMLKxAOVfCBVdPNot/Dls8xWkw8p
	 v+JkUcacIS0nQQkJ/g5mHuqZ6LTZavpNlH7Vq7SckIE2cKU70qtoKIoJSOBQsKxLX6
	 EsGwOEGpGG8IWiJH4xnBt5uAgSQDGPmrzm5TAyXHdJ3csKbYVR2KJyH8LD8yeOaKMB
	 eO/8GZHy0QdHegguUdWDWs0DcCD1TiXd+Mfco4iYtoI3Z/sXFZ+TpLtsba4Tbw3+7V
	 cjGLu+gU5awGymhS6I9SChG4YS4j6jqfuQPBSnfW4CFpyz81vaDHIOJ0LNmGEUMY9a
	 NQ0qZYbWXBpcw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:15 +0200
Subject: [PATCH v2 36/83] block: rust: implement `Sync` for `GenDisk`.
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-36-82c7404542e2@kernel.org>
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
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=6A74Jcx8EHUn7wYuZ9sgvdf2Nhmf1F3bFtPD29rpOao=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTVV4QA6fjC6s5QJaM+DuAAdyzosiERGRI2a
 nDPiCvCHpqJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk1QAKCRD6UCkIqsW9
 0ONmD/4z/u7pdgX5Wmx6bwNyWB7SgoBcZbYO0GePl/pxDjGYrsXBAKCaR+jIq7gru/rtRnshdS/
 S0P4TMMhpGCOhEBoc5NpThiIJBzW3N3u/kL4X9FOxsEs7jdy1tCyUPZrlxWzi5QVbSowIVdo/Mb
 WVTCRroH4sw+/02YE2fKpBLUhNyzc0GRG5Qu0DdFMrHxJRDsOK0EAFlRvzJ2gb4E16xFBJv8rFg
 0qEcfUc+f/5FKhLO8QHeS1qOSPQFC9/AANVaJr8MdbO1NY8BTnLXMf+yuyjr0VdynNTDtInejC5
 7+OsySI1f8LWISEwii89pTJ+aey3e9JTXUB44v56mcrUrAA5HwbIxe0QrEZePJWfllIIBUVXK8j
 SRmyAz1KO6c7xMEgiKtdNeB+3wpH44dMtkiOUIQKUD2Gbt6pJD2T3iBhMv8+hOJlZQHsEOj2LbV
 GXOrsB75EiLe9qmROJ3RTxojwEA/O3HyReIJhIveUu/5JJSEqTEmUkDMtoexgHbVnK2hD5UGOmM
 3TquGBebSsc0PsF7c4v/tR71vnCbhOIcchnkbWsyk3DDItKVKIToZQ7sC3FVAHezHNxEdZS44r3
 oCQ0x6gzZjYl3a6jO0cPAREwRMDet2vkSIgEqB09MIEIXMHeUl5DGM50Sll8XyZGhVhrIUNr4Nq
 XxKWA13bCrjnvFw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

`GenDisk` is a pointer to a `struct gendisk`. It is safe to reference this
struct from multiple threads.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 2b204b0ed49a..94af85fe1716 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -234,6 +234,17 @@ unsafe impl<T> Send for GenDisk<T>
 {
 }
 
+// SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a `TagSet`. It is
+// safe to reference these from multiple threads if the `Arc` and the `gendisk` private data is
+// `Sync`.
+unsafe impl<T> Sync for GenDisk<T>
+where
+    T: Operations,
+    T::QueueData: Sync,
+    Arc<TagSet<T>>: Sync,
+{
+}
+
 impl<T: Operations> Drop for GenDisk<T> {
     fn drop(&mut self) {
         // SAFETY: By type invariant of `Self`, `self.gendisk` points to a valid

-- 
2.51.2


