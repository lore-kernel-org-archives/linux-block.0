Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB72192D68;
	Wed,  6 Aug 2025 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754485178; cv=pass; b=lrdMoZvTNZEN9gwkac7mUmbq4pyqM6P1dyUz0JPafaqFE31bAYqQ043Ud/gTF6+xO8no72danm82Ntx55x/4JhoScnRNDKVAIEKYZOQBwiKqcG6YybuhteGCnkE7Wq3D7n/shr+MGnPYvPP6r/59NrZq2RZOCTymJSZxdnugDgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754485178; c=relaxed/simple;
	bh=sccRvjWO8qYKQF4pMmNy1suS+6rw5KNqTkJEfCt4rn8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pXV3E4XJvcZakuoP5+t+4XSqq5feXsWWsfj7tbm6h1Sdn5nofSRStWyQOtVE6+ebHdvkOmLKh1NC8kxXS3dQnRQUDNqGR/3DdT0Xw0CGqsrE6AgEeM7WPi7uOEzKwVgx+vcF4ce5Leq7qA1fj5rct+vZtQInNPgtvheRzcJfWBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=YnawhX8U; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="YnawhX8U"
ARC-Seal: i=1; a=rsa-sha256; t=1754485161; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h4lXCRutFnaV0Exnp03AuMVXzduD58KA8NOarjCZJfDWEFYtAD762t51VN5T9ggpvXiTEuWuUAqGxtas17rREb4v6EGvKUmoaQ8ztO2Jrt7XAKawD5sZacjkW2Y0MkvYX90FzBuvFUmg0BbN5QcVcNt5FVuLMncWPlJkzJCSqlI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754485161; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MYoIeLesrB8dXB4doGUptdUb9SA2VNw7HCU02k3TwjA=; 
	b=JDOfXw/rJaRVH586BfkTsg/7B0jDCCejyO11eSZvf6qEobSXv1sKtPodTUsF/qRxJ/CBTrVF3bMy+gXqQ1tZ4Ae8Jzo4OUf0Au2lRGQcoyQCeQtCMmdPK9j6MK7RrtfoSQa/oUXDjNqGrwxa61YnuHXUwECg497M4Lx00hZxWTU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754485161;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=MYoIeLesrB8dXB4doGUptdUb9SA2VNw7HCU02k3TwjA=;
	b=YnawhX8Ut3gcvMwCT3Se6mXoIC/CYjT1SMf4ZB83bQ9D5VHv3ieCCOyNmFBcC6CO
	fq/oMberdE7cBgnpxWziPfoZ9BVu59/HbeOYnrYFPCWjOmglgeilCLC4daKzfCmesmY
	GIaHaaVwKo7DTOYXOUbQOzBvtcjmahSKMiEEwNQ4=
Received: by mx.zohomail.com with SMTPS id 1754485158590384.6390366625128;
	Wed, 6 Aug 2025 05:59:18 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 01/16] rust: str: normalize imports in `str.rs`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250711-rnull-up-v6-16-v3-1-3a262b4e2921@kernel.org>
Date: Wed, 6 Aug 2025 09:59:03 -0300
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
 linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <501E5204-6270-448C-ACF2-F98B041B49F5@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-1-3a262b4e2921@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Andreas,

> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> Clean up imports in `str.rs`. This makes future code manipulation more
> manageable.

Here=E2=80=99s another instance of why I think this import syntax is not =
good.

>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/str.rs | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index a927db8e079c..488b0e97004e 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -3,10 +3,11 @@
> //! String representations.
>=20
> use crate::alloc::{flags::*, AllocError, KVec};
> -use core::fmt::{self, Write};
> -use core::ops::{self, Deref, DerefMut, Index};
> -
> use crate::prelude::*;
> +use core::{
> +    fmt::{self, Write},
> +    ops::{self, Deref, DerefMut, Index},
> +};
>=20
> /// Byte string without UTF-8 validity guarantee.
> #[repr(transparent)]
>=20
> --=20
> 2.47.2
>=20
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
