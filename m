Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430BE2F747A;
	Tue,  2 Sep 2025 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806991; cv=none; b=DY14zTUOyjQ3A8jazRNxCTBJx8S66JUll8c/UBCZMphG47UhT3XYmY1caV73C9aqnV7geCGRlxCroEpAVX9ihJvlgsFeC5cshqQ0JjSJ8bKMbabxZKC2UVzKpV3s/m+VqjE8Z0peQ+vS1hu+2l/HeIWLI6cWVtmzZWQinlys9g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806991; c=relaxed/simple;
	bh=hixYhOSo78Opw3JCXq3T7Ep1Lb7kHadQhoAfotnnjUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ez+s2AuZjzcW9vkA44PSx1Vo1GmhOghHaaNpy7jaoq0rLBXqvmcyMcPhCfgEMO9GcdrzwIH8ii/KNWBnBEsWIYW7Rg/f9StHjdD3CnNTZFMxXjaYP/JgTor+yih/2gpK/F4egh328GtHGJpCFOcAYta7orQAqpLeKBvNsdC/xSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsHblFPX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsHblFPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EBCC4CEED;
	Tue,  2 Sep 2025 09:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806991;
	bh=hixYhOSo78Opw3JCXq3T7Ep1Lb7kHadQhoAfotnnjUc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OsHblFPXfz01Qew8I3kdGqcfhrJRAr8lB396dsqdp0M5e9CbS7Jmw355Hq3DGKrSq
	 hEPaOj/jXJZDWgK1JqHDhfAhEU/Er4siaAcYwjo0B3QqdoMZQUfkOoRRLruqaGOIPz
	 giFqgo9IjZJWBU/QOgJzWkctP8oIlc8wf6d5cPxu27saLTL4oFucFZZ8qvhZmN6pJp
	 nV5+1LCsH9F8KJgVs8OFAKzrbDDTE2E6pI1u/5fVJB490PKEy9hh4zJr20BftR1j/7
	 aR4n3tw2QJKQijr5QcxzdxzbPZMRnfpZMlujVfHRZWCj+/7wAyFJnJASKn2rMfR+cR
	 C4HzVTjtCtWWQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 02 Sep 2025 11:55:09 +0200
Subject: [PATCH v7 15/17] rust: block: mq: fix spelling in a safety comment
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-rnull-up-v6-16-v7-15-b5212cc89b98@kernel.org>
References: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
In-Reply-To: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
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
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBotr8Gae24Vv0iFDvJMLbTGRD84ZTe/kukacaQe
 MW+AqJRfveJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaLa/BgAKCRDhuBo+eShj
 d4U3D/4gJIkgF55T6ecHFdtVubLkVr34NYS5iGEeDxCP/xHnthRVmGcfgkll2bNRGS8EM8/AGgf
 6t2PYXZSionkEVrtMynNSokrYPX3WmLX8hN1CiCPoPcr5h4GaccVuUAoObTNOYE/G87M4bJS0cq
 W1ksrOB+0H90a+t4an3+alJMHP6rTw4K7KRZzrOm/wjC9nEYEoCB+g7P+rZCFiac40JxnEQHpNQ
 kd6hi3Bhgb1MjkCZfZ3uvb6t3bhSFAetUaISlkKerYawlPhPsw7CEdXBSwozkHR0YX5+bjF6Huo
 /ZLhiEh+At2RB8QAWA6/bl2g6XDLpE6ExXin6SJa7uCDhWI6H/pjpw4kPqPDbo6fbk1BvSURMaU
 ODZ7NNmgcLJmjhAdXcUTkmo59DxW28kzjJFiP2x5hUQAv5wnkbM9w2laCrYtjIGln5/cSffjXKH
 YE/e/YhNmZulQ9k/Quk3EbpGeZgSnBRhpVcIWU8vPEXS6+znWhFNOS2GBAYaV13Jui6Je5hgmLw
 HpSSFWY9yOJhWHh1Nu7pxPh/x0LGI3CjqzaTbalpABeXUOie7NuBD59gFkCWGf4MmrSOshY/0Yc
 oEs1IyuuFxXp9/5T0ohxfrZRoY79cGfKlW4PxY8MT2VSLN3BggLPirMNL3rpur6xjcxfuQK12Id
 3QRVX5cX2kw34+w==
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


