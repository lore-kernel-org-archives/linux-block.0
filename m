Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BD22FB99D;
	Fri, 22 Aug 2025 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864965; cv=none; b=Ll1Zkyco5kGx+UA6gjeIcDexkkOOzsK2AlR7Cg389VYi+JoMWt0VECdmEWy/kACPFPKZMrzAAX67TuVrHiiYwrH/7bXCEfi9/2H9hO5dJhwJ/iQFFBcVfSkn/AylVt9G7uoydHKpyhWfG8aLJ9FRzT8uFU/2I6ANx80DyTY8Z38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864965; c=relaxed/simple;
	bh=hixYhOSo78Opw3JCXq3T7Ep1Lb7kHadQhoAfotnnjUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QUqqDyawgZlCyYnxRxZShHtDFczNR7W/5iQ/IaCY/xk4idlq2890vIYehuGT4qePDAtkysJiOApoNwWQnu4mu9IRj4Gmp7tanXtV6JVnHgw1owH20RZjaRMpJcUhNIwBtRhOYwNSDUsvLgh2sSidXf37mY8EuHt+HH4ZMciIvoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T794kpr2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T794kpr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC761C4CEED;
	Fri, 22 Aug 2025 12:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864964;
	bh=hixYhOSo78Opw3JCXq3T7Ep1Lb7kHadQhoAfotnnjUc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T794kpr2h+gU9Uv15PtsimOUEZ5w3zHQF6j27zlDiYik6NM/38VGrNl/8moL9gFpW
	 C38cPntho+JTr9GbjdCRUj/UYURlvdHIQGKIgaHtj4SYQoRuzQSx26yWVKt6pJEf2J
	 u6MgGpAaNbZH1uqGBHq8ZhP2kHDEo+2QfloVhzcw/KIy3st5mbDcz2sYex3BKgL4KF
	 XDzgJxMYNCeeGn4HLBoqBSPnhnFYD0Dn8+biXmsYMVFMiXCwbLIUDmWDvg+gNEOFCF
	 q4iut4rH8hKNN18nWE+okOg31oy01ldqHYR+3DaTRH1lgYTzL6dbsT/3BG38nbu52a
	 wPr2LrrFcz7Lw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 22 Aug 2025 14:14:52 +0200
Subject: [PATCH v6 16/18] rust: block: mq: fix spelling in a safety comment
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-rnull-up-v6-16-v6-16-ec65006e2f07@kernel.org>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
In-Reply-To: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=hixYhOSo78Opw3JCXq3T7Ep1Lb7kHadQhoAfotnnjUc=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoqF9ANI4YO+smi7cQq/qeFb+af2TjjuNSdBh8n
 4I/oe2FvVWJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaKhfQAAKCRDhuBo+eShj
 dzhREAC+30PPeI2mX66s3bRMr5GopkanEZobESOXLAncwXZb8RxrE1NtTDv9UgiAqZQk8+m4emD
 MDj6gNfn0DZaSxub9ZcvzTaFpSdmIfofAphzsxnGyRto1pW8qJeR6WyoGj1AEqxvkQt6DuhNoNl
 peGcAYm5tR3grzsCS1Ry0hlkcsuRtqC7hUmEk+g/bY4S98AtcqyXG5wYA9aDC77dh7mln7av0v1
 SSV7BpZlxI1fZyOP3/TF4pxJEldAXa9GRY9xj9fsY3Endt1EmM61eXvobZ2Sx7uxG2xwMLKFwwL
 8yncrOJ3G60EgbyBmSRpqWopt+B3i4OX7osO8XLE6ZfoP/tbV6+RaHRCeWRZTBgiJFeX+DeemHc
 qm2U4D8Mx+v/WFdSCP+zCyAaBv4Xk5TFn0xC+WpuXP3y8p1uUjcwf3ekdzWfS9wmSUE9zT8b+KW
 qSYlbhjuFfbTQzaScveRtVij/DfoVBVGBxAi/E9NutOW5umb+09qXWFlIdoIgHCkYUbyloEKdhI
 4VdMQEXO2Vz/w1CiDHPvCHgNdg2XpE5sWpWj03ZHvs+lzEQqGCN/OWLpVa6s9B7h3hgbRx4s5SE
 4eApfSLrD1J+OjJwk8Bkpgw17jw7PEL7fjt8kYzWCre2Fm7pMFyrWrZbXLQ5CtrS+rcRzAXtE7U
 ow6f+/9flP5Na7Q==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add code block quotes to a safety comment.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index f723d74091c1..3848cfe63f77 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -148,7 +148,7 @@ pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<RequestDataWrapper>
         // valid allocation.
         let wrapper_ptr =
             unsafe { bindings::blk_mq_rq_to_pdu(request_ptr).cast::<RequestDataWrapper>() };
-        // SAFETY: By C API contract, wrapper_ptr points to a valid allocation
+        // SAFETY: By C API contract, `wrapper_ptr` points to a valid allocation
         // and is not null.
         unsafe { NonNull::new_unchecked(wrapper_ptr) }
     }

-- 
2.47.2


