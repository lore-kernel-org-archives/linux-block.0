Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DD02DB7A1;
	Sun, 15 Feb 2026 23:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198944; cv=none; b=NZvmUvoNjxsDwezDLO0VFwEcoAjZqb01bFn/E8F61Sge6i9Ulzo07AuAKhvD8sdrmBHU+KLnPvcLxibVekNOzGlrEAJ0wQkQYT7LCrHtIptACf96Ek87PXb+gKQf5jEp1P9I1UwaprOUbF+B+OSQ7Aw2YjF0IcSh5DVkaOIUvWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198944; c=relaxed/simple;
	bh=7BsUMdxU+4o8Atmxvi2C2Yk4sut1Zh21/NZvpuROV9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ao3I0cGy+NmhMOtJwxU3oh3yq+pgkBIBb8QfaNatWkSF8QQ4ZHT/rrtjbBpq5i6xppOQHd/1Qv/Mmn71JPT8y5XBHR8dq+6J+BMRkuBa6khyU5IzgQ6Xh7FDs7t7khr5MjwbtuHW/nZzHj13ykJTS069br15x5K3lHUcZMAj5CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EegIw3n9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EegIw3n9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B953C19422;
	Sun, 15 Feb 2026 23:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198943;
	bh=7BsUMdxU+4o8Atmxvi2C2Yk4sut1Zh21/NZvpuROV9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EegIw3n9AdLDkfngVG9lXqk9jft65qhpfo7Y99ZYTJpFjM0kcakmlgeOqfTqa39np
	 CGDtEygqvaUzQVXVkn7uhm35v42HlHKpNJSF6ZWaMThfSXkDbT0d5oZuA29WBFXLSz
	 yPcZJxj4Drwm1X8Od7cbhYIFkTCOpMGP/Mw8JO3JMPzvPFwe2h7VRME0TaLde5DGvU
	 tqQcC3t4+ligYcd1ufKAT3OebAopO/oTInmhAMBA48c98UMtB9Q/eUtdUQzJ/kmKMC
	 JAekf0ru/muJbn6mFt0y4zH+Qzy6ZtH4g3gt9gD2+t9NCIOeNypeXp6jnK2HBP6iEE
	 jP1Jy+fPjLrkw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:19 +0100
Subject: [PATCH 32/79] block: rust: implement `Sync` for `GenDisk`.
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-32-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=7BsUMdxU+4o8Atmxvi2C2Yk4sut1Zh21/NZvpuROV9U=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklg4ccLaxdetyIDs2ivzwrKOGT9mU3qMRJbLi
 d6udKXYB6SJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYOAAKCRDhuBo+eShj
 d/SMD/4/4YwNGwDDtKVPiCoYpIESWdAQIduCAObFrzlsZL/kCIkB0OMU0EMKO2cMmBBT6bBYFd4
 qwedoAdYdDByA3piKaKLOQezC5celEc4+F+IphMdiaMg4tBLjAMqFL89thiK2OnvtZbp6OL79rT
 NBUa7EFfsQiAnB4bZcRRYzklaRthtLFmRqcIdJZGHau7OsWUvw3wj+aPzdlf//RqEN63DtvzKEc
 mRMVMLqSeZr1ZHQ4CwBFbyEC1yrDP2WFEy6gj0BiiuDexcKL8K/0N/NvzxNK3bCPtUOV/1pHbfU
 3uUAbAci131lesi6I+yYt/+QInj/lXfCzn3IKf823uTyiqVLSMPbbOVzKhxVmaTkMeRFucAhRSZ
 oiHx2upFd/aQAOuBcGrj/OkFuwkvJvIFJxLySCTC8t22KX8GEn6V6j7UuBH5S9W0B1McCBvVeFK
 XncX2V3/mHuBkbio45kWI+PXeWDVQSAeqXa/60JmUhvrhg9Ch/X1pWqsL712Tu/qQ24BswVQ8aO
 gI+GMJV7qKO28JtHvCtGjpLDZ1K8M12Y3tsyn1GNqq0EPY0CAlDJY0rrNnaNhFQGgYOlPfz9TCx
 g06pY4/jCcEw5VJ1WUVg/wtHYiBCYOySd7LvzbXLfFmR8VWI35FnRmPOOxWnuQE2C71SiAefNiI
 TzllyUbiu4t9g4w==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

`GenDisk` is a pointer to a `struct gendisk`. It is safe to reference this
struct from multiple threads.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 75968d6a57639..72bbf3cadfe82 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -218,6 +218,10 @@ pub struct GenDisk<T: Operations> {
 // `TagSet` It is safe to send this to other threads as long as T is Send.
 unsafe impl<T: Operations + Send> Send for GenDisk<T> {}
 
+// SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a `TagSet`. It is
+// safe to reference these from multiple threads.
+unsafe impl<T: Operations> Sync for GenDisk<T> {}
+
 impl<T: Operations> Drop for GenDisk<T> {
     fn drop(&mut self) {
         // SAFETY: By type invariant of `Self`, `self.gendisk` points to a valid

-- 
2.51.2


