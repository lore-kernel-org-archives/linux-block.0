Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F38E2D8384;
	Sun, 15 Feb 2026 23:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199116; cv=none; b=jm3Ug9ekB3fVR79MNqxKye9jbZL+WPaXDQSwNu4YdAXVLt0z9dbSOQnHvrcK4dKl0KRTAzuMOiToj04vyxlQo74oDQs5OJC8ltA+1RZV0QjHRNzgScN0X7p0bzLJh9Vli7d69to69ST0M5EKts0a0UT6GNEXzW9d6Ko9tVzhvc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199116; c=relaxed/simple;
	bh=xknlJKjDgQx2PklWhfpIJtdR7sb0fmRIcoqZtD2O+JQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d+uA1MjU7mKCND9SUcVlw3GTfOTgSU2v8Oul7hl9x9C8RYq3DbV2FGmAKAQPpKeF0eV+dxvHAcavF25hczfCTjMxF0KbQ/NqCiD592J3uycAU6dvTS9iSEmmyxe1/7h1UAqMWkYdyjjkQe152StqV74IRRIFrK3IeD2yxIw/faY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTq0574l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTq0574l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BA5C4CEF7;
	Sun, 15 Feb 2026 23:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199116;
	bh=xknlJKjDgQx2PklWhfpIJtdR7sb0fmRIcoqZtD2O+JQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DTq0574lt4lFIjV5BGtsOf53qYZq/UUXgIQFVYEJnLtavbUVAreck4t93U/I85b4w
	 8rtpG/bqaQF0Cl4uI4mW2ivUpfjqgcqtlad46pfHK2iq2nF9FgWbopKXZmp2MxtF0M
	 qDiMt3QAsZGIJoPl9/85vRHZdH5bY8sRMYw9PJ+YWjXXmuEoB8vPr2h9OxoJWSrK5X
	 LblQ1dOTw+BPdGutBKjuTMjRhVLuvBNJIKxM/Q+PnSQfLKxV2m9GWo8np2086DBB9Q
	 NauJCPEqCnOcEW/PTtC3Jdk0N+EvnM5Uib1/M0iw+/Xc4qvrUCnSTasP9UKa0aCPch
	 dEXJRtvDrsbqQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:34:48 +0100
Subject: [PATCH 01/79] block: rnull: adopt new formatting guidelines
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-1-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=xknlJKjDgQx2PklWhfpIJtdR7sb0fmRIcoqZtD2O+JQ=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklgcx+Hel7olsXH4zRoVtUmD4dmhza68hS3aH
 Ic1/VCoziCJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYHAAKCRDhuBo+eShj
 d/mQEAC2VIEFmtp53Y73KZqpnd3iisJkJprBqibxgwe4PmVofc2jb+vYmI0M27QBCSy7TZI70qa
 fGabetSqKwfit5BTtDd9i8VWhdIt28z2tBa7lQAQU6gUXN7+h/0OrgZUjrQMYNSiMHEFfjDKRnm
 vabPA9SvNgKI9Nnq8mkj/4DwHLO9QedW9ZuM5LWiGLNx2tYrP6i4d6f17F0u0F3Q/YEXzg7Ad79
 rCfup6mPXjh+Xf0R9Yh17SM491NorZ3/e62rV/U9PgM2mDlpJz52MpGgdcWoecew5g0h1GVb26L
 zFkE5WCDPNOrzhFCo7ezaTdQ1lwwVrBjyYuJZb4tEmPP7qHwjN6Awf73ZPJCjhBN31N9Hfe1l9+
 AvHq3/DZURYUCKi8+421oXhmInZaNb9i7n8dd5vLyZar08vDXomuh6rNdNoUDo5MHhEkI2NvbXs
 zwiWTGN2OytTL79j5+i6BQQQQkYcUR3mpk+wN0LAw3G/kd1FGEicOnVdIs7u25hOO5FvJUSuWKE
 /5IDy8vVRxcU0Bxei4QO7I70wnsJPp8f2XIZhRzeWn75szLBUXWyEoO1QJssJXqH8ztnRr3rdL4
 HSQUvjWibaQyn2e79bqnYQP7AjY51xhJ+EF84ezBywBBDfAj+JSzVpIgtytQanunAnN6dcj1GU/
 jqhUKqDc7YaEwKQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Reformat `use` statements to have one item per line as required by the
updated Rust formatting guidelines. Apply a formatting workaround to
ensure `rustfmt` produces the expected output.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index a9d5e575a2c43..2c83b014b05e9 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -10,14 +10,21 @@
         self,
         mq::{
             self,
-            gen_disk::{self, GenDisk},
-            Operations, TagSet,
+            gen_disk::{
+                self,
+                GenDisk, //
+            },
+            Operations,
+            TagSet, //
         },
     },
     error::Result,
     pr_info,
     prelude::*,
-    sync::{aref::ARef, Arc},
+    sync::{
+        aref::ARef,
+        Arc, //
+    },
 };
 use pin_init::PinInit;
 

-- 
2.51.2


