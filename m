Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5763E2769;
	Fri, 10 Apr 2026 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839957; cv=none; b=aNcjx7TLNpTCFTlPOcKfNBw9Z2si9rQShEDbzPh/zVIKtjPKOE+AMgy88/uWwL9gQjYLu5RRyu7qNquZhyvguUJUab7arwrSlJ5VzogxPwBvKYsAfNye4G7/I4mvjuEkBT89TAuwXucQkxQBk75lTV6/neGeATYLYJ7Ii8qeAs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839957; c=relaxed/simple;
	bh=SlUu5i3SihdxZ4s3+Xbtxw+qM6Dh1ZXxEGlkmxDghvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AqdxCbDBZOEUrwT9Nlb7N1jmR76BYpBM91XNmVs0LHPuPvH2t4RYuYH8Wu/9cgzAWq4Vpm8EKjrVfyRPAbJ5qjXBH4Obd/FoQWPHN9oELncC/+xPYKmcrYs5vURkJsyQUd4uGPTp+brH29tJhuST5vTjPBNm6obDHTAutmghaUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=ORO/7cgr; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="ORO/7cgr"
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3a484aada;
	Sat, 11 Apr 2026 00:47:15 +0800 (GMT+08:00)
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
Subject: [RFC PATCH 2/2] block: rnull: implement dummy timeout callback
Date: Fri, 10 Apr 2026 12:47:04 -0400
Message-Id: <20260410164704.1986859-3-wenzhaoliao@ruc.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410164704.1986859-1-wenzhaoliao@ruc.edu.cn>
References: <20260410164704.1986859-1-wenzhaoliao@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d784a68c803a2kunmb238a8d6d33bc
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZH00aVkkfTUsYGBpMTBpOQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVUpCS0
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ORO/7cgrWdQ01RfA5+HJyDT1P2wkhp1s/waKiLnYcZYeN3nNBOkJxoDx6JKjUe5hoePFr/KMxpY2QoLuqYDP+O8cFRIrV+Zr5B1kw14/DQKMk2VQMNS5vkk7rRqcharuCVMhyCoceCkh47mRH7s3+3XsI43D1sb607rFaIlnGew=; s=default; c=relaxed/relaxed; d=ruc.edu.cn; v=1;
	bh=/7JCRYcuLbHYsiV6vNu5s8U223EflbR7L5cyAfTd/DY=;
	h=date:mime-version:subject:message-id:from;

Implement the new Operations::timeout callback for rnull and return
TimeoutReturn::ResetTimer.

Using ResetTimer keeps the behavior close to the existing blk-mq
default timeout handling while proving that the Rust timeout
abstraction wires cleanly into a driver.

Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
---
 drivers/block/rnull/rnull.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 0ca8715febe8..3833a5bec7a4 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -97,4 +97,8 @@ fn complete(rq: ARef<mq::Request<Self>>) {
             // point, and so `end_ok` cannot fail.
             .expect("Fatal error - expected to be able to end request");
     }
+
+    fn timeout(_rq: &mq::Request<Self>) -> mq::TimeoutReturn {
+        mq::TimeoutReturn::ResetTimer
+    }
 }
-- 
2.34.1

