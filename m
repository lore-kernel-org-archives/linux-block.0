Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DC0F4FA;
	Fri, 20 Dec 2024 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734687569; cv=none; b=umw0qFGFr0C9KnYKbpvOD7htj0mtrtU+OxqAE/51Vb8nMrFuWEXzidJjrkRR2dt9hQl5FJaPtdw0/YAxCdjluGxwtH+ltz4AYoR0VXEm5GbeemhxeZAeVJXd4Q+3j0VDGxtuzXrpGvXTSFZXEjnzP/AD+MmHUM2Lqiy+rjzwC1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734687569; c=relaxed/simple;
	bh=EUqVRxG6c4pap6xeF3zCpvKsKOJGx8APATJXQJOX86A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E7g/cvpyMzeW4amWWNAUVYIO/CmY0CL6WHRkNovXXfDcSqewUZ2gae4BLnB8S66AaSlDYLB3I0OaEKIYuK9vyPlt2JI3uM+AltyXStTo1PUcSYf+98WZRUmN+yUI1n2ofTCe+15fH0WGzdhQSnOanZMzHa5+0SsLlU/o4dvGZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkmnQ5N2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkmnQ5N2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62099C4CECD;
	Fri, 20 Dec 2024 09:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734687568;
	bh=EUqVRxG6c4pap6xeF3zCpvKsKOJGx8APATJXQJOX86A=;
	h=From:Date:Subject:To:Cc:From;
	b=dkmnQ5N2XwbzQW/fMTijM4gLJ09kaYdLLt4iviudxrJUt9UZTCrht6sOnI2qin92y
	 i2CHJWztFvAjduV4w0p92kbODuAa72mCRFP980ajtu8rUAkBxG53m7XnVbZUvEG+FL
	 JIXWOWeervRPxnqk2W63tasEk3idTmLUmgA6CwHxMYUMfZjAG+lVDcJlbe0CSHk+ys
	 v9Pq4lcSlYBqKX1yaYMf1BWbJSZEkhg1D3sP7gFxFrnDIzlovVaOoV4wzRTu+ZCNt+
	 jRHyXGoqOPXGJbCJKu28UAWXaiQogGcvg6KU0Yy4aP5yZd57eoYVrEq17UiguJN0I2
	 8cSTH8D4t0SrA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 20 Dec 2024 10:37:57 +0100
Subject: [PATCH] rust: block: fix use of BLK_MQ_F_SHOULD_MERGE
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-merge-flag-fix-v1-1-41b7778dac06@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPQ6ZWcC/x2MSQqAMAwAv1JytmDjAvoV8RBtqgE3WhCh+HeDx
 xmYyZA4CifoTYbItyQ5DwVXGJhXOha24pUBS6wdYml3jirDRosN8lhk8lPniNqmAo2uyKr/4TC
 +7wflhoHTYAAAAA==
X-Change-ID: 20241220-merge-flag-fix-2eadb91aa653
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1271; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=EUqVRxG6c4pap6xeF3zCpvKsKOJGx8APATJXQJOX86A=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnZTsBkwPhVsSkoTudokUqjeYQjRWaqzYo5j1ty
 /fJfKIbGf6JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ2U7AQAKCRDhuBo+eShj
 d12GD/9KvusFX+EvE5OPYuDiZKJp3dFGyTsO0jDTgwVdfaedHEfYK7TRq3pn4mmO7wbecYuAB+R
 6+pNLzjuChK7JoBwNMI12tEJKz2CuBTOdNoJOQPVECndSWJEpWL39Pi9Ad/CB8cjMbncA/gBeLU
 GK0MD6b+i0FntDF3ofseHhKyzS1CG27sOgFfEvzNmtlhM5FYWfYHZfh/fW4xAIU7ieOTP4L0WHg
 mmgceTFPcudvWUjp9zDb5xUzXysysuTim6gP62Nm6ElSLbUtMLz9nNMK4XYrf5ieoC8/KW9OjMD
 D+asB7WVT8ZzqvWilxjE910RVhUEM3x1iKPSvJQhHAAXwiTfmNutLB22dPT5pQ6hQxolitYMxso
 ULkaEHh/35oWq4HNEONFcz+SqU8mQCpsyXUZMeKIRb1sKhGHp1qrSLMr7+pq5NIicC+eZOT+f74
 M/lEHlTrKUV2R/UwP5aP8LSCyltEf2uYIFLAqxiwd6xWSFXZ5hge/jVSaWmqZXtjyJKW9mHLJ9u
 araMeGfnK3/TN4HIK5bzvkl1ypCXccTinTEvbwdFtmobdSszuasntESfE2/nxT3V7n2VowMQq5b
 74b8AP1xR3WWGOuHkWscztS0REnOEk3lFY8qmImSxOF9w36M1Tw3xVQ2lTw5L9djiWcH9t882Vq
 XLI8joru1TxezKA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

BLK_MQ_F_SHOULD_MERGE has was removed [1] and is now in effect by default.
So remove the flag from tag sets of Rust block device drivers.

Link: https://lore.kernel.org/r/20241219060214.1928848-1-hch@lst.de [1]
Fixes: 9377b95cda73 ("block: remove BLK_MQ_F_SHOULD_MERGE")
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/tag_set.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
index d7f175a05d992b95c0a65522fbb2b8e08a9276d2..00ddcc71dfa2a1da28d66c542b554196461bea33 100644
--- a/rust/kernel/block/mq/tag_set.rs
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -52,7 +52,7 @@ pub fn new(
                     numa_node: bindings::NUMA_NO_NODE,
                     queue_depth: num_tags,
                     cmd_size,
-                    flags: bindings::BLK_MQ_F_SHOULD_MERGE,
+                    flags: 0,
                     driver_data: core::ptr::null_mut::<crate::ffi::c_void>(),
                     nr_maps: num_maps,
                     ..tag_set

---
base-commit: 3af068412d79f2e1b8c394cde2a54ce84c8df143
change-id: 20241220-merge-flag-fix-2eadb91aa653

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


