Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5C1303CA8;
	Wed, 27 Aug 2025 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756297543; cv=pass; b=Sb6TuX6SY8bQTEIXuIU7/zM5Bk/aHk6bDo/tMc9TnXg3mTh/Eb0jZY400xr6vw7c3Bu07BcepgeJBFD8aS+DeqhI5SrKo0O0d5Dw1eH2vKFNL3Vm65pUf64h0o3uVCn+wBO6GXfYgfk8xJ8bWXBnDYPCzbZfUi4s9N3xKHUsMLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756297543; c=relaxed/simple;
	bh=C4+vc/rI27ADAlxP0+hNA33yvt2az3LH6R0xRiNv94I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=T6a/rTmTdLWuYUpjBoN8yjm7UYqyZF/S23iYvGnTEGKeMfIbr9KN4Okkw3O1mwCkMtAmufoKKA9tF+pBMFtoAj+EBpOHgNyaG5EjVW+IpFFu4+MQQ10MvtbQqnfzIgVdHzH7/zbnAuAUhAOLDLT8KCvDPMs1ZBn90/0Hqv1EOcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=hiLQ73mD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="hiLQ73mD"
ARC-Seal: i=1; a=rsa-sha256; t=1756297524; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aY6oSfgPN9mYAxX76fKjCykaf/85KK42O2x8A7NmUOwFZ5XrkeuDW4xPxg6J7hDHlxbhokpmc9Ju+vTbHwrhr/qb5lb15n7vsVJ0vTkJIo7l2eGAVAJ4l9C/X0cjbiQhvogCyGAY5YAm/20prm5oXik1SHctZPlyh5Sjn/72Kck=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756297524; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yTHr4GuvJ82yATxlRHsTWsU3wlSxy8CyHreP2Xc96ik=; 
	b=G6er20C5i/y88T6Jm6yHNWSo0HXDUoQtOqla5+w0oGRCr4KpXYkbINwZgjmA4PtLpRbjDZbgOdYMiCd/6f29kPbyNEXhZLepLFqvOg1f9two/l/vMixtMpRD1x82MdOWL51ZpyWCPtW1dtNn/CZYQGWtB3mp2fpEQ6keEdYTHEc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756297524;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=yTHr4GuvJ82yATxlRHsTWsU3wlSxy8CyHreP2Xc96ik=;
	b=hiLQ73mD5BMf4IdM7C8tyqsYK7iW2pP/SHcW+WL15lmyg77hiz05skCXgsHnBMZF
	df+oUaenfvjutDu+bIIUjFV2mo+gHYXYPdNUELmBJNP3r3osXvPRQraMbrrNB0EY+HW
	CwXOC8axaeIa/wxShU+GZ2/MwoE99t/CWz6mSy+k=
Received: by mx.zohomail.com with SMTPS id 1756297521363698.2551424341978;
	Wed, 27 Aug 2025 05:25:21 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 01/18] rust: str: normalize imports in `str.rs`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250822-rnull-up-v6-16-v6-1-ec65006e2f07@kernel.org>
Date: Wed, 27 Aug 2025 09:25:04 -0300
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 Breno Leitao <leitao@debian.org>,
 linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D9BA84D8-51D8-4473-8FF0-9FBD4BF58F81@collabora.com>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
 <20250822-rnull-up-v6-16-v6-1-ec65006e2f07@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 22 Aug 2025, at 09:14, Andreas Hindborg <a.hindborg@kernel.org> wrote:
> 
> Clean up imports in `str.rs`. This makes future code manipulation more
> manageable.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/str.rs | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 6c892550c0ba..082790b7a621 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -2,12 +2,13 @@
> 
> //! String representations.
> 
> -use crate::alloc::{flags::*, AllocError, KVec};
> -use crate::fmt::{self, Write};
> +use crate::{
> +    alloc::{flags::*, AllocError, KVec},
> +    fmt::{self, Write},
> +    prelude::*,
> +};
> use core::ops::{self, Deref, DerefMut, Index};
> 
> -use crate::prelude::*;
> -
> /// Byte string without UTF-8 validity guarantee.
> #[repr(transparent)]
> pub struct BStr([u8]);
> 
> -- 
> 2.47.2
> 
> 
> 

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

