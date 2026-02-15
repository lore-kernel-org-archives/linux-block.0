Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41FB30DD07;
	Sun, 15 Feb 2026 23:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199046; cv=none; b=Nwl9RFuIdRnBFQocHrvPugTeUuOKcXwG3yuD8N0LvlnSWwU9xG6fzB5newO64LO5mInspaJbjbO5OaByxbrg757JPzdhuDOZs2FikwGiDNHYThLiAf3xnY7z4tDJwnefP013L7p3U88t1BXv2kAesFDvZpivvlV3J0QBj+oBjuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199046; c=relaxed/simple;
	bh=HXXe3ZuaQh0jtawnDxB+W/Q37k4GGbJvn35e1qpXTRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Idi426K3LPx4pEV+cj3/f7bxxiIk5igqFW1qhBAFceOjnDIq9fU4QOo/4mek706gcKCNcn8J6gSsYgTuHsEPR/IqvG47KaW6VBSvAKhJDO9z485LUBylS/DWFR0g1bL8MR7OElmMIpwHiFkm/u1x2oK1MChChrztKchFH4/xPvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/cAr2ex; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/cAr2ex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35922C4CEF7;
	Sun, 15 Feb 2026 23:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199046;
	bh=HXXe3ZuaQh0jtawnDxB+W/Q37k4GGbJvn35e1qpXTRo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X/cAr2exmax8lXA+n5QNdVX/hBbQVn347xBA5DUD43Ygvq790YZfIzSVNXjevosvy
	 5nDZFrviyPAratHgQaIn4vCEBeWKTif9T6X2JcMKahVd2V18L54yXYi75oLxsbBSrP
	 LRGnKMoLmYxBwkVqpgjtEcTNR3LKw6Es2bR7qZAnqxGpzW9s5H9nyAa1UH1xTjJ5NS
	 tb0cBOcjqxT6P8OYpOxQk1Da1x/ZJMh5dvr1W9h6SQvnYIvwOiiUxG7eNB7hS/Fuh1
	 m64m+TGAtJ70wBFw5h8TcbrjNqsai2TZkT0DoYP9dNZEF8RKP+1ilIakmZT3x2gU6r
	 /KX+laZXIZQ3A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:57 +0100
Subject: [PATCH 70/79] block: rust: add `Request::queue_index`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-70-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=HXXe3ZuaQh0jtawnDxB+W/Q37k4GGbJvn35e1qpXTRo=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhbvCV/K7QHpAKO17p9tlhElvwrVj3iR8aTO
 xSxbX9mMTyJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYWwAKCRDhuBo+eShj
 d8suD/9uK5x4p4mZa2NHYzVIAjBzj2akl2B5TMECJhzE1rCk8/JBpPTetMD4LGk9ASmRi7Ss2yb
 XVwBn/7/CqdmjvQvolnlPIgr6WxOJ3Ao5tMDZUSdOQd2g9qJVtCpNxVrZa0Xxp1jGhODM7/ONdm
 Euyrcd5g5obOyGTHKfmDOq63E4X5xyMawHVsDq4Mg6tCvs/9vyMBLhICEGfGTQNYyu552AbxTGu
 zWjDlXrTvEnUlU23A5VDDjhOZlbIsUq/jJZYdiO9cI98Ha4xxQm0TLZkkE4pZvi0KI0GvQGz0hL
 F86Fwk6MT0uBkuhU9RaqP5mkugJPZuDgf0p54aCQvKEmzlZ3v9hQFW8H+Wv1HsueHaNxEYYU7Vm
 9Msejz9Ho1DIFwmNj3cSSAKVJGgGR4PDPtpTMaJEVcLoFnaISC0YLCpsZfOHLSNm7L9KS6JfNOF
 TRFYI5QqRgZNmN8VNoE2xbBznLYLwkTkLgTDOyYIATbqwrPAgn6dPG3opCw5htI3mDmpKOo/Q+c
 BL5GCwR13fQ0OhJEWc0S40MSWPRsWx11M9x4kGJ4UpYB7jFUIwFd+PjD7mGpiWlCGYZ8Ug/h0vQ
 XLX0H4zdnBIvqDX2nXLCm/R35mAsWe1U858koRujJFRhUVLyceDIfutFKteIUwCR1YLtXqrQ7Qf
 cFU/nem3vF4xiqw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to query a request about the index for the hardware queue
associated with the request.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 9a05bce39c64b..e2fafe7737379 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -166,6 +166,13 @@ pub fn hw_data(&self) -> <T::HwData as ForeignOwnable>::Borrowed<'_> {
         unsafe { T::HwData::borrow((*hctx).driver_data) }
     }
 
+    /// Get the queue index for the hardware queue associated with this request.
+    pub fn queue_index(&self) -> u32 {
+        // SAFETY: The requests is guaranteed to be associated with a hardware
+        // context while we have access to it.
+        unsafe { (*self.hctx_raw()).queue_num }
+    }
+
     pub fn is_poll(&self) -> bool {
         let hctx = self.hctx_raw();
 

-- 
2.51.2


