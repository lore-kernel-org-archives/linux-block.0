Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E062EACEF;
	Wed, 27 Aug 2025 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302554; cv=pass; b=bAg3hUJjTYF33wP/f92PPw1N4ljHqK8Khp/ruvah6lVYNJebCFFb52Crg+gCw6uTcfkOmCw42VwPJsp+Ug8ko5w/NSfj21+pkBu7GPsagbAYFUkmcg8sQxdL3gOnc2n+25tiCkPoSdO1oPcz3QMeIcLx2lTM+N8iUQXYOkB96Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302554; c=relaxed/simple;
	bh=phbd8aXSaP/OR1qJvMNuysR5rKmV7cN8BJSmKMNybzk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HwXOYj2zOegpaOPpmmDHfzryLxAVsPpJujSvYOrv45ZX6+usNboHGVVDpYNsMbOxA1PikQHV5k/G+3KHyev0nlA4L65pnbJCt+06hoeAJnsnLkXw+g+BaFJCgfdCzBrbYktUIgBG4H11NZEJwUhOe+Dd/urrELz7GQd4RH5KWVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=A1TdO/EE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="A1TdO/EE"
ARC-Seal: i=1; a=rsa-sha256; t=1756302534; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S/O6eWEN5q6SAI3A9eKQajoU8zhhpeAzX2TRfoj77EDTruVBoRze4R4J06R7VwvZSicOqiGctEPw6iGu9cg+J2VI8SjjHFLNyofFUe9aT65T85yr68i2bFoMbM6yiR0MM3uvJqumquaFnc+n1+ezUOV0Lch7GzGWvCYAzDNjb9E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756302534; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bev1UYNNO9TNoilL6Ch+V4I1og/LGfHRmEFQwCrifvs=; 
	b=ZzvslLKRaqONnx30cAO0k2XxKmdhpftg4lGPeDXIHL+mBFVgADSyd5vCkWvjsJptJF8RYzZKHxr3NE6GELG1Or8AS/rdY5c9AqvdoUSRNtRhBBlY0VMYtb27wqXd96zcaCVtY13Sfw7PO8euGDNtLeO9/Bzn4nuv08UawZNi9aU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756302534;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=bev1UYNNO9TNoilL6Ch+V4I1og/LGfHRmEFQwCrifvs=;
	b=A1TdO/EEGcubukTMTT7AsaB/+2TvCIbhASEosUebiRafbnaT5MGbBNYJa+citm0u
	IPlSnByXX919go8fYRHqLfABaN2FEheLUa8pRQ/2A+99gwBO8mj4ambDT21qLmLJNx6
	/2szd+c9htqEdZMmlgw+3tyWZkG4Pzjxhn0uLcUE=
Received: by mx.zohomail.com with SMTPS id 175630253092986.34973539824443;
	Wed, 27 Aug 2025 06:48:50 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 07/18] rust: configfs: re-export `configfs_attrs` from
 `configfs` module
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250822-rnull-up-v6-16-v6-7-ec65006e2f07@kernel.org>
Date: Wed, 27 Aug 2025 10:48:35 -0300
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
Message-Id: <8AA2058F-B9CA-4B5F-99B5-8C719C4630C3@collabora.com>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
 <20250822-rnull-up-v6-16-v6-7-ec65006e2f07@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 22 Aug 2025, at 09:14, Andreas Hindborg <a.hindborg@kernel.org> wrote:
> 
> Re-export `configfs_attrs` from `configfs` module, so that users can import
> the macro from the `configfs` module rather than the root of the `kernel`
> crate.
> 
> Also update users to import from the new path.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> rust/kernel/configfs.rs       | 2 ++
> samples/rust/rust_configfs.rs | 2 +-
> 2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
> index 2736b798cdc6..318a2f073d1c 100644
> --- a/rust/kernel/configfs.rs
> +++ b/rust/kernel/configfs.rs
> @@ -1039,3 +1039,5 @@ macro_rules! configfs_attrs {
>     };
> 
> }
> +
> +pub use crate::configfs_attrs;
> diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
> index af04bfa35cb2..ad364fb93e53 100644
> --- a/samples/rust/rust_configfs.rs
> +++ b/samples/rust/rust_configfs.rs
> @@ -5,7 +5,7 @@
> use kernel::alloc::flags;
> use kernel::c_str;
> use kernel::configfs;
> -use kernel::configfs_attrs;
> +use kernel::configfs::configfs_attrs;
> use kernel::new_mutex;
> use kernel::page::PAGE_SIZE;
> use kernel::prelude::*;
> 
> -- 
> 2.47.2
> 
> 
> 

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
