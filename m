Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE883DC4B9;
	Thu,  4 Jun 2026 20:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604068; cv=none; b=cOTp3c6SIWpjduCYinIa9xBydBOc8sQvC+hwKENevBcc6DBqp2yWs9orbH+8kf8n2H900HtDlU8b/4TiN+3fX1G8o4V0AwW9FNpo2QLHHexuGQPcBKKjWlWUOO8dZsca9MQJKwmO3Djvky46a9BVVDKOuVJBeos2lCGy+xqMtNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604068; c=relaxed/simple;
	bh=4RyZCw8fL1vZdiYtCKnYPrhKo0dFDXqsJU7kpadSv3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IzVAWm3SYPwuNCzNhRBte3oVLC5Qs9LqDO7kUqGw+51ZCYjjezi8zFLGPrz5+mtRqbXeKismahH4c5Rcw+GD0sNabxD27zkVWYPlj+kjXB4f3uDUKxT+Ppjtw+2jOFrEzQbhYrsB2jKfpFIIM7FsyN0hQbDS7K5V9cUzkmMZQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUSWvnjj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUSWvnjj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411F81F00893;
	Thu,  4 Jun 2026 20:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604055;
	bh=UDKImhxSIS/fNprfWQIRF9/bFD0CG+MEzEYu4ZjZLR0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HUSWvnjjP2E25THnS10KhqGscgSWfXPY9OTuEU2lXvu8sGjibTgS2hJh1c7sVR233
	 ZsSMfrGf5wan4J4lQaBQPFxwxHEfkZB+SyslGH0qiD3tupaMJGOF+xfVCXrdCa2nop
	 bfZ4DrP5VtkcSumcTB7mPODx29giM+ghh+FTkROTaLEuAE6mh6otpO2xPVgZt2DqVC
	 XWOJbv6sA3Uf/sptnzfc7WprUW0qPW12ITimONL3qIMyuoyGZsERZkyT7yyp4AoXjJ
	 JSPLPuTZtHSv89xBRY2E+XCGkG/WIy0HPLdmYvkNEYRY8uN7duiAc2vqNKEQ6Rg+2N
	 1E1gmpx/gdZhQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 04 Jun 2026 22:11:16 +0200
Subject: [PATCH v17 04/10] rust: page: update formatting of `use`
 statements
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-unique-ref-v17-4-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, 
 Igor Korotin <igor.korotin@linux.dev>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Boqun Feng <boqun@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>, driver-core@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=908; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=4RyZCw8fL1vZdiYtCKnYPrhKo0dFDXqsJU7kpadSv3Q=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqIdvpNRczTi1MEzbEqRlUSeyXZWfTU4TEqBFL8
 dQ624Rhe9eJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaiHb6QAKCRD6UCkIqsW9
 0GdUD/4yqmBAhNqMpqX2A7JxCA0GG24Vbr11LAL40KqFhbTCAdt3gGkUa/a9Rz9aqi3vkCbe/ST
 FnkQd+bp2YQxM1v4HvkNdYl6bMHsOvU18ZPZoCGKvZQdn0lKxUF293/3c9nt0kC71fWAfWL4wUP
 uy/AgLXJiQ/bVHs8H1//ZL7q//UZyzTjudKIDdn/EdREN8oXJP4QpPMHfnIzWC61sddwm6SZq1X
 7VkKcUzxtOBs75BHWPMXfiC3Xg8KePSbkgSlhLUO70BrcXgRRSLmRRKacG6XS26Yz0me2pRnu7b
 cbjUrbadHMO3LNeUwdHuQjW+WEvIrm1sTyrM0G+4DxAuLLKNhoeiHC192iqOdYproBsGzIdxZ/W
 CcTR5LugyvvJIpEIvAXhvq2C8XTPF3dR/lAhBfHr4vph7dFDwfsiucAQpcXJSOtQ7coI+ZX7Rct
 JvnjdjshEue1W9UTO9m5UWjnXARSegihnwosgjfAX5rft8kqmQ8bOKDDpcHvHZ3qVnJWK/be+Oe
 aq7VqUaKnUOsvjxnxfFEc0jDhigeUxIZUPxZrJeTV1ak7jdJAjZNBIC+vvQ72+hBMXRMIclDCVe
 vviPbhfux8KOliVlfgAoDzFODyHymtIfsJkBJBNpxpvX3P3KI581baQQA6LqlsWWHywfzYv01nt
 XV4VKoWPUlCeb/g==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Update formatting in preparation for next patch

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/page.rs | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index adecb200c654..3bdcee0e16a8 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -3,17 +3,23 @@
 //! Kernel page allocation and management.
 
 use crate::{
-    alloc::{AllocError, Flags},
+    alloc::{
+        AllocError,
+        Flags, //
+    },
     bindings,
     error::code::*,
     error::Result,
-    uaccess::UserSliceReader,
+    uaccess::UserSliceReader, //
 };
 use core::{
     marker::PhantomData,
     mem::ManuallyDrop,
     ops::Deref,
-    ptr::{self, NonNull},
+    ptr::{
+        self,
+        NonNull, //
+    }, //
 };
 
 /// A bitwise shift for the page size.

-- 
2.51.2


