Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864F13398B;
	Wed,  6 Aug 2025 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754486348; cv=pass; b=U/BEmWSMvKULjjmvngRLKi2HmAzwRolT4WkR5xr3Jp33psSqpLN6FM36FT9eko9owke8WT5SdczpcvmxIQnrfK5pfxloS+XqbFIAd5cURVzYKpLhfGZsZV+OEZmMHR0m5QBI+jDuKSHjKBGQOWJNqnxrJGq2/KERFmtxllTPyUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754486348; c=relaxed/simple;
	bh=8XF2Wm5tZg3cfpi2Fmfz3qB3Cf3dERh/2dXyKjt+AII=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=p745GGE4SuoUsLJg3o5xpbIjiMf9XZ4PeXN+e5fWtJHa+K2DQr2AvyRqA8V2vr1E0jDwXYxTIwH5dMcwqRzO7Wpy4CbN6YSd1Rmefi8yINJu6xiY1bYc7QNuaTRbGM/9C/bbQls5GuQvQWXy21IS4aDYyHdcAUJPD2o63p78tTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=IfPxlgHx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="IfPxlgHx"
ARC-Seal: i=1; a=rsa-sha256; t=1754486329; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YLI8YlI4SeMWfjpMGh3nlY+HLs50+NQUURoaYVBACTxymKvUnFol398kQcBks0jNDBJFdzUmFl2ha4/qjOObsTYvsc/4flNjJcdwD+9kx80zu18fNPXoRJpku8RtW6P1bCSR77AbB7eMLILd5teX2wsjSDVSLQ/E1LiZUh/IZ74=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754486329; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=huaiX/ufWgpYzt41uF5yQzLm16cIy2PNu+SzH1hEfuc=; 
	b=VTHLnutpBSmcjkLAv2COG+pRa0Ct1XRF2g6+rO9U9xpo0l6SuQQ/UatOo0vHTAimqrNVWlDKgpd+ujLV3baIfdWXDxtCeTfW5B+hqZzmL9Ff+IQSJvnb6hQS7fCSzCvTlEgTQojD7SBanpQNmNjuyn0nsqyjaijBKbdfEmA9ofE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754486329;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=huaiX/ufWgpYzt41uF5yQzLm16cIy2PNu+SzH1hEfuc=;
	b=IfPxlgHxwQzJxfyzwgZqWvHC7U7C+L6Q29OSPF0qPAjyB3py739dkw2vOMGoSHjg
	CcBUWZ6IMi7yPrO9T9/TI7frEVL5T8Gw79wGnOT8Y+Y1mUcs5kcmS3F/oQ7KNGt3Aru
	3+TA7dZUbrr5fnI/HUe/AENY4Z8XHUyNGbCt6N/M=
Received: by mx.zohomail.com with SMTPS id 1754486327241580.4707847732928;
	Wed, 6 Aug 2025 06:18:47 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 06/16] rust: block: normalize imports for `gen_disk.rs`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250711-rnull-up-v6-16-v3-6-3a262b4e2921@kernel.org>
Date: Wed, 6 Aug 2025 10:18:32 -0300
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
Message-Id: <F5A3232C-50E8-4615-929A-80F3ED4EFEBA@collabora.com>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
 <20250711-rnull-up-v6-16-v3-6-3a262b4e2921@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 11 Jul 2025, at 08:43, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> Clean up the import statements in `gen_disk.rs` to make the code =
easier to
> maintain.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/block/mq/gen_disk.rs | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/rust/kernel/block/mq/gen_disk.rs =
b/rust/kernel/block/mq/gen_disk.rs
> index cd54cd64ea88..679ee1bb2195 100644
> --- a/rust/kernel/block/mq/gen_disk.rs
> +++ b/rust/kernel/block/mq/gen_disk.rs
> @@ -5,9 +5,13 @@
> //! C header: =
[`include/linux/blkdev.h`](srctree/include/linux/blkdev.h)
> //! C header: =
[`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
>=20
> -use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
> -use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
> -use crate::{error, static_lock_class};
> +use crate::{
> +    bindings,
> +    block::mq::{raw_writer::RawWriter, Operations, TagSet},
> +    error::{self, from_err_ptr, Result},
> +    static_lock_class,
> +    sync::Arc,
> +};
> use core::fmt::{self, Write};
>=20
> /// A builder for [`GenDisk`].
>=20
> --=20
> 2.47.2
>=20
>=20
>=20

Same comment as the preceding =E2=80=9Cimport=E2=80=9D patch: this is =
syntax is problematic.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
