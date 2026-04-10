Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD4335CB87;
	Fri, 10 Apr 2026 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775848873; cv=none; b=dTqsc46yDkGcbboLjoZcMrnbyf/s7iF2cWqHJnWdCaCWn8nYYJZP3KP/mMoGozQKPrXKd4bta8p9OLmKnl+Dre1HwBL9zSFOp4IyyoACkqlrx169lpVioAlgYGOr9e4qqKoNTqzCHax8oh+UDWe7whlv/Z+KPFSwHg4Nwkx5aEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775848873; c=relaxed/simple;
	bh=HkVVKjEIEEDJiJpYyVo7gxrWFTMyoa8YlaZay+X00GQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CMP9gCqAO4iZlP1ZOGXuhYFGTfzhRngYqyxby4MScFgP8zx5Y/lG9Pc19/Lw1B1c38f2l1lY1GFW+1ij8A46CdSKojv6HxWOWUoRZxS4UNBjF9AKe1Ixxt6IgxA7+eSPVr51Vsy9I55Ywc1zm/gVZcOozHKh4YKvoks5jUOwmJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=A9ciMmte; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="A9ciMmte"
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3a4a05112;
	Sat, 11 Apr 2026 03:15:55 +0800 (GMT+08:00)
From: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] block: rnull: wire up poll queues dummy callback
Date: Fri, 10 Apr 2026 15:15:44 -0400
Message-Id: <20260410191544.2203201-3-wenzhaoliao@ruc.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410191544.2203201-2-wenzhaoliao@ruc.edu.cn>
References: <20260410191544.2203201-1-wenzhaoliao@ruc.edu.cn>
 <20260410191544.2203201-2-wenzhaoliao@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d78d284d503a2kunmcbf66d2fda433
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTElPVkpPTx5KSUhMHUseSVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=A9ciMmte+F3kwXN/8AsM+0qT5YH1Paj2DxXlFTAcnlioHZ/xgEwfeamuZrgPgk6HVQFrog+a9J3p6TEI+Vlj4j5NAt+Pfc6dGpUZq9FS+63Rstqd7IsabRVnuyfzlo7QR7EfRwkOArnUaJs8jCh4ig/nktZQhQfQyvMXTsbvjFI=; s=default; c=relaxed/relaxed; d=ruc.edu.cn; v=1;
	bh=GToR1qnIRedxVCOonwx0WvOJoMmK0Unw5rKkSyyM5OI=;
	h=date:mime-version:subject:message-id:from;

Implement the new Operations::poll callback for rnull and return a
zero-completion PollResult.

This keeps rnull's current behavior unchanged while validating that the
borrowed poll abstraction wires cleanly into a Rust blk-mq driver.

Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
---
 drivers/block/rnull/rnull.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 0ca8715febe8..a5db14fcac34 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -97,4 +97,12 @@ fn complete(rq: ARef<mq::Request<Self>>) {
             // point, and so `end_ok` cannot fail.
             .expect("Fatal error - expected to be able to end request");
     }
+
+    fn poll(
+        _queue_data: &QueueData,
+        _hctx: &mq::HwCtx,
+        _iob: Option<&mq::IoCompBatch>,
+    ) -> mq::PollResult {
+        mq::PollResult::none()
+    }
 }
-- 
2.34.1

