Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8190D2E2F00;
	Tue, 12 Aug 2025 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988350; cv=none; b=Ne0+YDakcl1UUvDXvU55Uhl96fQIVVEIBUiDCpjxVHWDLi6bNiNfbi9NC4C9goLwyYJr4jZ0iuahC8KT8O34tfoerYb0wjtHaWK5vB4/ncp3HvdDgo5Ha2cbBjdM+nU79bPfSuDyKjSkif/YBafp9xa61z9Xto8c/I48JPZYba0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988350; c=relaxed/simple;
	bh=hixYhOSo78Opw3JCXq3T7Ep1Lb7kHadQhoAfotnnjUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H/ipXPidpcY9JJsH38Pv9yFGYFo+TVrVK8A/Kcr/jc8N1UvYaHmxUvzlHPtGJ1/SGXGKcoYzwT+lqJPMS52v68b17vWcOf0nmZVcObaEgP+DeYwpPiRP63ERDx6L9zm5snEIkGrQmkfKSgb+FbR1DPes9sYBRAzancm8Zo+4eAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnDqN1w+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnDqN1w+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F6AC4CEF0;
	Tue, 12 Aug 2025 08:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754988350;
	bh=hixYhOSo78Opw3JCXq3T7Ep1Lb7kHadQhoAfotnnjUc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OnDqN1w+kxgPxjqRAoMGPGkSBnHIZ2OgTuodUVoMErKT7/ZonG9AapY1wOiEtKx4B
	 0KrcbayDHBijDL1XUXbezRqp29RPFi3w+dsD6f1pnz2Pp/219Gy3F4SMlodgjxxmuI
	 +1MusBoCih8p7rDjQQvlE+NotTlGBRGDV0lsv5u8eHTc58TDkT/td0twI+kXxMYvAV
	 /XFS+FTLDZaKklAKcg3jf0pftNA5u/pLZe8G+MFK264tiNcJ8ClQfwh/wGlLju/paA
	 8ykKx4NcnE4U1w9bcXEJbS7L9INGyR8s8XN/uDw1k3hZ7rV+/dQnZ4VyFw4r4PM66F
	 QlhRNDBLRsLGQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 12 Aug 2025 10:44:31 +0200
Subject: [PATCH v4 13/15] rust: block: mq: fix spelling in a safety comment
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-rnull-up-v6-16-v4-13-ed801dd3ba5c@kernel.org>
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
In-Reply-To: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=hixYhOSo78Opw3JCXq3T7Ep1Lb7kHadQhoAfotnnjUc=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBomv8nR6f5YHNi4lcwRMm3sGBZYHg2ejkbg6QKT
 Prm3hxxSD2JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJr/JwAKCRDhuBo+eShj
 d+YtD/982aKjbpSoMiK83wsCuYk2VQaDUMyorncCr6PdMK/TwEBwD3wK56jhHzdMbzvvm9m5JEo
 IzhWFFPB2w/yBxlioQNkU2CJ+IcOgubz0S/eyeaXqdRSP+/Hr2Z+98WaEjHTfchuNDCa0X4/Qmb
 4gJJQtbRDhb2XmquTWWdDVcoUZ39VS93HJXdrdcSz/Nf+ngdnkni23ek1LLGaNyQkUpb3F6QgJJ
 ochCpD5WT9+xpZDNnTpgOb/aKdSvMM0NApHeb3wiUnsdMunz/34jLAtGEMDQTSq6TI+pXCzdez9
 aicXXTzZar9hl+/XsdCD2X8tV5z/gpmXtAFT5bUBhgDg44vVZhWaggO/v0YKC8lIusoF+7yhnFm
 h2X2nwlhAAnz+7XMX2ZqvGnsp7NMmihGFjS5WiQX2D81QVFEJyCrwTN0p6O+d5pT3SPvoO6zIXk
 lQQClEiJmT40f80EdS1QG9djnRyr9HvJyDL5dt7AxTIKXF+GQcBgWNQ3uEjZ3out/OLx5vpA3mE
 0RME6VdfbQrPNze6FJfgu6LXX8l0onlkkTxTMo2qHWJLtyu/3x1zbE9SWFRQHzqCbsf8D9SZtKC
 kZDlnRtIYln7Cd2kNbw5Leuhc87SDeuRH2bRTZHGewhOHblVLo6rkNUEapS8KJBkxilhnSGBtCV
 zX/bebxdXI7/4oA==
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


