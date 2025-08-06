Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D49293C45
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500873; cv=pass; b=e2EcPs/ZqM6mtY4mw6ExFcbZVuQlpRJ1CIet7UgwztAiHZYfTw8kLDz7cAhs03scSHUrrpgQHJ2R8H1klesh6rxcj1SGPe+e6MXUq39nQNVrQn4fGUZJfVos1tNLCmwKUsCoEkF+i9S/7C/ddo4VlJF+N/bAHAB3ihOCIjjgBl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500873; c=relaxed/simple;
	bh=6FS27BvCoDSrw234OdLkExJnHsnBYp0LIddCzBR5h2U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pHxsW7QSgW7tisfAl/5p1b99987tmlmNL+kZekvh9K795FpNcdCHXr4k9cCDXUN1sQG4BgNQBnL2Cx+0ItZru4CJJBnFYA0bWgxljeZCBHYfQE3aBewo53wokcqE1p6LlvApPaw67SHhbGaTeVvLAXUD5w3NUAccM0NHKlYqLvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=QVYL6TwA; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="QVYL6TwA"
ARC-Seal: i=1; a=rsa-sha256; t=1754500844; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=H6fjnNsYMoT7u5kczWtfInjaDQgX+uMLp4B1LlHU/qwDiCfBCmSLN3/GJNwz5KVPmhmsm1dyO11nlGyEf9CO1xD5+hKvz+3ayMgd1etRSF/YttL4xU8INW2XRk1//BS2lmvJK6Ih9HCfQrNwk1bzGZljjjuAhLgXVTQEcC8/F20=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754500844; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=b3ByGLijYjouPfXdZnT1mmyvWFV8Eup0EyYjQuwpvss=; 
	b=Dr4QIOxTz3NzywcAqS1lcg+/LinLhMihZMoS94C0ONw+YKkloAxqxDBwX6xUxYJzQ3T4p9gUL9QNz7UmFQt5C+PLHoLkIZ+rEzkUIlvqmqGb3NDFx5TaOLDJZp6RAHyaqUBJlhuMDIUQFkBe7JD4EkkNBTdU+WFfpQFeHsPVkak=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754500844;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=b3ByGLijYjouPfXdZnT1mmyvWFV8Eup0EyYjQuwpvss=;
	b=QVYL6TwA5d3KmXmeq1k2OJPNSXN6+TR0aw053rG3Mzt6nfuoLLOB/jdOK0pKI0PS
	qOIqxD/XTXraRC5y5mRMzC991VziBKnriGXCEpFBfs5X+6pKcov+RlU0f5TUc+J8fQt
	36pHqxW4Cl90eWXn+cyt4XwM9eE8EiO93yTS71c0=
Received: by mx.zohomail.com with SMTPS id 1754500833326482.85802898921736;
	Wed, 6 Aug 2025 10:20:33 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 09/16] rust: block: remove trait bound from
 `mq::Request` definition
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250711-rnull-up-v6-16-v3-9-3a262b4e2921@kernel.org>
Date: Wed, 6 Aug 2025 14:20:17 -0300
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
Message-Id: <6A18D5EB-20CF-496C-A451-5C505726DD28@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-9-3a262b4e2921@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> Remove the trait bound `T:Operations` from `mq::Request`. The bound is =
not
> required, so remove it to reduce complexity.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/block/mq/request.rs | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/block/mq/request.rs =
b/rust/kernel/block/mq/request.rs
> index 4a5b7ec914ef..2d14a6261a31 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
> @@ -53,7 +53,7 @@
> /// [`struct request`]: srctree/include/linux/blk-mq.h
> ///
> #[repr(transparent)]
> -pub struct Request<T: Operations>(Opaque<bindings::request>, =
PhantomData<T>);
> +pub struct Request<T>(Opaque<bindings::request>, PhantomData<T>);
>=20
> impl<T: Operations> Request<T> {
>     /// Create an [`ARef<Request>`] from a [`struct request`] pointer.
>=20
> --=20
> 2.47.2
>=20
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
