Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039DC2E7BC9;
	Fri, 11 Jul 2025 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234248; cv=none; b=osqE5VN6EvQjYO7AQSgA4H74BSRyk9HjG2NH3WwL0uC0Mn5FW124pBKcLBeC+y19njT+lrB3YNTJ72Kum8yF4TlxlaUmE/MLlCSFA5sNghCOlw5+YOJ1qvaOwsXbJBR+HhyhBwWq2rsa35F9drCx7ouVFYPcVA+NtaoQ9ITwJ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234248; c=relaxed/simple;
	bh=bwWpprsdtyVDZaqvZNUcUvzzn3+xorlxFgD0pWYxMCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hXtDurlbxOzqLGVKHKB7SB7qsCx0GFN1+ZaHC6VTQ+AJo7/TSvk1KTUXgI2LPCy3Rj4Su41ajq7FUn/1H5hAmsuqRZl97kFM4JCMIPQD8XJQmEQg6u5G0CdVHRV8iLAe0cQd/9GzZ0sSXtHcDd9zTTfWJ2DOmNqazFkFhBRNac8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtIRTN5W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtIRTN5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DC8C4CEED;
	Fri, 11 Jul 2025 11:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234247;
	bh=bwWpprsdtyVDZaqvZNUcUvzzn3+xorlxFgD0pWYxMCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BtIRTN5WRRlkK4GdCX+LH6geTHzmIpPeDEwLD5X9VQhZMMoPzG3N4D7cpggtt7MtK
	 yFW2QG8Ov0zFg1jrXuDIacY4IkRpK0DHYPkEsmSmUl+WwPDzS2WiFCWznP5rbyDB9p
	 JhUBPbum51dwk37gAGihntlbDtU3Yvby/6D+ypj1hpKtTjHs14OmARc7afKZMx4hEJ
	 i55/03brw07Kr+gftmsDKd/MwnDQR0xoj/xkKlxKD/B8JAGnqWDX0Oae/aOoSEGnSX
	 F0axrhS4VwAOpvOQ8cVPquSzIzB1C3akAyopikIu3JgGu1cEXRm4Af6w9nxtOGgr3y
	 c3vDRrCZdb1TQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 11 Jul 2025 13:43:15 +0200
Subject: [PATCH v3 14/16] rust: block: mq: fix spelling in a safety comment
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-rnull-up-v6-16-v3-14-3a262b4e2921@kernel.org>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
In-Reply-To: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=928; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=bwWpprsdtyVDZaqvZNUcUvzzn3+xorlxFgD0pWYxMCs=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBocPjWCKRMbAOxHydWnAXkvhwvFbZyeFFvgYNEL
 4bmKes5mWiJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaHD41gAKCRDhuBo+eShj
 d4GKEAC0Ryfui49XYVyNu2nBXF0JD3WMkvbaj+vgsxuk5Uqf4zERuN76BaLLX/qdPJyF11K+DS3
 HDXfl9B7X9PwBbE+VfJcUuSJhSBmEG1Ln80/+j009quKHDX05//qzVzItMJIqYF7Ju4hyBBmHGn
 qxDdWVeDHp5vDXnwT8lsSyP9kvNacZZKOed8hiJIZd8bTCZ8+Jh5YSUd6rI8Vf2rVM4uN5JO4+W
 MC43+2ZxubjFbTaU3MMeoXx9pFJ4f4n6waI8Z+9es3gFW3mXgsFvOmE9DHngxsCiLs2LJ4h8kSL
 ep3Ak00Lw/0wDiXMRyVhvBKW+ana1C6ar5PbJeJ6dhe+jxgsAZ6hqBCrJ4UY10FsUY44hNsAYRu
 DPDk9FEPZrY938GN0HkW/2tswymvgQXyxPGC3DWnnphG6Qfo/YFz1cD7avFn6WmTo7Ovr1Cez3m
 83f5U8n8ZFtuF3RkzAzmpYv/y5Hc/y/4mrzBlqUTJybp6T44DoRUwe8C0+LMmTfOpMKd/GEmbZk
 kvJktevrzCoTnBYUsWF85P0R19/43oVxHNK0Hnnk2ppsfUfPBHmK7ow/6jaTzsL3w2gqmg9U9b0
 kogFdsaSdXVsKhxzwIYwjw/yLvyyTSoaMuYPlM+fPQ+OAlT9ldoZilhMG9Fw4mgza4dnmnmgI6X
 DoQE8cWsEjnz9lA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add code block quotes to a safety comment.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 2d14a6261a31..873d00db74dd 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -143,7 +143,7 @@ pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<RequestDataWrapper>
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


