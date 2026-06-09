Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CE84BCAA2;
	Tue,  9 Jun 2026 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032258; cv=none; b=JFSV4ZlgQCF6+eRLD2nXNmDwu1qSfANTJGaqvZSgEnHszaWLOykGxwLSuFCRAEK1QOhIlNpekCdpdsdPC1TYMoQjV9UT+9HSxFJcGs/vf7dE/jM3WUMD7koNyw8AQaSjQGyvixCmQ4eGkkgrLE9EXAnDH48v9D268idnYJ17/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032258; c=relaxed/simple;
	bh=4NVXyfJD6Wc3B91hTYpUVWCQ5xmIczODt3j5Z23HY6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QlGmZPNkCiOHs22HNF5PpvFJJ8IxoOhQZaMl/DoguXFIWhSaxV+wMa/BLhuaLTKFWhTSDsJ97SrDNKOr4J+Ef8MQxqyWr100i3B6HoJvhtlElw1Go0Gs+uXvivti0GxwRclSxA7Gltei8cb5kgoUfgIOchcLbvRmdnab0ZiYCoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyT24jGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyT24jGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317391F00893;
	Tue,  9 Jun 2026 19:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032257;
	bh=z3StJ1SDVAol/xVojKQU2uRTOblocEMLOnL3mqoENfg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PyT24jGXtIi3d0UF04FVHwiZclVhw/6Ja+SJ0WHyKYnIz34KeUUX8ad3sCHCDHAKI
	 /n1gD3j6hBu41FBHAfylAUdeDpuzs/GQkt+EqsM8aezKqsnqi8i7Zz9H0Q0amI9ghX
	 bZUFwofKeBJuAGg1pJS6stvUEGb+n8sRJGcRs5ZApZw90maEIicpz/WebeBGlZ+Nr/
	 PRM/9VNUd6DluM5kek4MBKALBdIHMyBfBuqBp19OeWGjiJnoA1bUubIuQntNfBLQ5z
	 gpBAQGsEJ5ZlWDqFcTuX4C04foUANCTNaw+daq0g9pVXGwS49d62pEHwJdfWHcSYgO
	 Uy12ml271T44w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:07:42 +0200
Subject: [PATCH v2 03/83] block: rnull: adopt new formatting guidelines
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-3-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=4NVXyfJD6Wc3B91hTYpUVWCQ5xmIczODt3j5Z23HY6s=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGS3eaUcUB7ex1Rk0/NrKNjqPU45h3WR6lcRF
 3h/f82EGjWJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihktwAKCRD6UCkIqsW9
 0G5wD/908gLu/c/luttZa3fhus/yQ22Ibyd1bQaE7Go+HRNeE0PP5PijB26fEiwMq+wZapKjfdF
 cD0lxtPlkAJVWuWuZMEQvHzv6J0+ty/3lmAAZH0EYuNh91xn2ME9AtGQe4sqk8YZefRw/t4glgD
 Ok4VQbhmdyOTfo7LVrggMkNcY0hlyGoBf98O3LYmyavBT1HnoY/DxeRyK+iUTWA0bA4IkgSZsNV
 4sbHm2WLjLP2yXmdWfa4BNfU0ASOfzEHa1Yp1EIOPicsDZTrKrmGz1VEDUjpe8+vV8hukWazy00
 Na+XzMEtJ/leSsLYEIaOY9CBnjoWCjH/oHPAXpLuLrd6lOfpXEtg4MSWfkKn9yldpPZzUzidEdW
 uGHTkxc3guVO56mTrk51YkCcsjDa0//MCCEK2VY5ToUCbCUYZdyq9qe1VpUcW3kJp6m83AuLMrf
 881PPqrOdhirescgirjUkUSYVc7V/BpVtpIhrXbB0ll2MD5ve9oMY3mDNkwr/Pj5O82VakOQcfP
 moq5YSm46RG3ISMDFJF5hDRDbzbKrJ852TWNAv4rdk6/TUMKY8frEIdz1goOCaB6afbhDaQ+nhv
 ByCqFxHXnAGfwSm8MMWzExl3veZcnaO4TvvjJJV+4tVPBJdGRsfAppZUQ1x3YZNhN4dNctHK2je
 3oVTGh1mKkqd5dA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Reformat `use` statements to have one item per line as required by the
updated Rust formatting guidelines. Apply a formatting workaround to
ensure `rustfmt` produces the expected output.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/rnull.rs | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 0ca8715febe8..d58d2c4c5f63 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -10,12 +10,19 @@
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
     prelude::*,
-    sync::{aref::ARef, Arc},
+    sync::{
+        aref::ARef,
+        Arc, //
+    },
 };
 
 module! {

-- 
2.51.2


