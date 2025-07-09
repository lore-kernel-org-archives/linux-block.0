Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528172DEA75
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067513; cv=none; b=bw1PQllFat/h/hhhHFW7BtNHPdiUewR8mK6v1m1i+Zzm1dpyO3t7bSsQzWwOTjVS+FejEN0Sm1Ify3kTVCIex+tc/Q7sDRdFj/8OrdZi7tAoHENznBqzafWFVX9psAdFTTtqNDnYgevApZzio2WnBJO88wbRLousUOVG+Y0IIXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067513; c=relaxed/simple;
	bh=NHNbSrqTeMsIn0Slu2oKDt0QDZh47Zum79PAprUdfFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nxZc2WG8diVA1JRH03cy4DDE6lqA7zgQwR/kGEU+2tqlW1fnlwdAHPBMK2fFP5j8nSH43hPjobn7Wj2p2+4qe0k84HkWCo8yxIN3Eq7adcrXeogyPhXs8fcEUQodmDguKc2LzslU54jZESiIswvzytSzBocUXlUR1A/SL+5oLcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q/3Ss61z; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q/3Ss61z"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so3567454f8f.3
        for <linux-block@vger.kernel.org>; Wed, 09 Jul 2025 06:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752067510; x=1752672310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XXIlm31EilbmsYU5xvHTfVZMMQy9qv0LqnF1DXKbnRA=;
        b=Q/3Ss61zr1+8/ManDKoeOs/xHnCPg6+AgeC0y80ks7mHCGSQGxb/HzNjfr057Cw2u5
         2rUt7M6fr9eVnFerLOLZhG/JZbG3zLQrRDGAIAxr6oRMgpNUkdW91RbJr6+cMHPcEztp
         bykdVyLbz+WznjbnDQDFvtmAZD5krCj8g47boJSkHtNMYnGa6s+oS6tE0Qrn+U5Pub0i
         nMY2yfTDqxKR1b4RqhX3qswzd6HE0XL2KmyC3b97dwgAXoAM/3DnU0T0zyqwygUt7Q99
         1EMkEG2cN4/PwCQVMJrHjr3jImoWsU3AB7Zzqn3czc0kAknCI6Mc9qTm6DM2E9PcwbIM
         /fUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752067510; x=1752672310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXIlm31EilbmsYU5xvHTfVZMMQy9qv0LqnF1DXKbnRA=;
        b=LL1WynBRzfsUmz65FPwQAmium+Jidf0EwvcppZlDlfLsLsJaUdxXQEhDBOdMs5Hm3K
         pTw6teiUn0udmQgsZCnFeHo0ju/DsH20lx4/aj6IB+x3JFBrLgf868ue9qh7j049XZqj
         HJ20VHIidJtVTd5aIoUpXC/7R6s4bfoebfVkutSzEJmHMcM3z07vzuMRMtlfiM/cdmSx
         XbqLALiJrtauVPy0n9KKIf2KESWxQTIRkAqURQThfQYQ9mbpuSJk4D2IybHwwi4OSLBH
         CPOs8D0tqMWYQimGDNlNUx5f81DpccAmdB8SzNu1pjFFTXDSb2AlFQOfgMIgtIqpecoi
         UY2w==
X-Forwarded-Encrypted: i=1; AJvYcCVJOYmaHwK6ZIgxhzx+ET7ljNTR7X5HwFM2Nz3bYHE4uNrMlabzvEzBSAxib6trPgPvxf6SO7o8aCscrA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+GRDDtHljf7BTSLzb9uMv9ZVk1YjfvzSrTMvVxzoSCPT7DKJg
	4CaR6QA/9FnDCf+ejzinDDQUjBcRZNFQ5VvwUk+Nuxpi5V+qvDp8p7erdlWUkaYUvq1hWwiGAwF
	YFLST8q4mTELeEYqFuQ==
X-Google-Smtp-Source: AGHT+IHPHqf0UCSK/HlZxzPJodC8GgYw3644TdfQ+Ny0ndQqa0F+bXEPu1xA9YYDu6mVQp5mBA2+jSnEsE+oo9M=
X-Received: from wrod11.prod.google.com ([2002:adf:ef8b:0:b0:3b3:9c56:9547])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:26ca:b0:3a3:7115:5e7a with SMTP id ffacd0b85a97d-3b5e452bc17mr2122006f8f.42.1752067509573;
 Wed, 09 Jul 2025 06:25:09 -0700 (PDT)
Date: Wed, 9 Jul 2025 13:25:08 +0000
In-Reply-To: <20250708-rnull-up-v6-16-v2-5-ab93c0ff429b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org> <20250708-rnull-up-v6-16-v2-5-ab93c0ff429b@kernel.org>
Message-ID: <aG5ttHBYW3SQlSv7@google.com>
Subject: Re: [PATCH v2 05/14] rust: block: use `NullBorrowFormatter`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 08, 2025 at 09:45:00PM +0200, Andreas Hindborg wrote:
> Use the new `NullBorrowFormatter` to write the name of a `GenDisk` to the
> name buffer. This new formatter automatically adds a trailing null marker
> after the written characters, so we don't need to append that at the call
> site any longer.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/block/mq/gen_disk.rs   | 8 ++++----
>  rust/kernel/block/mq/raw_writer.rs | 1 +
>  rust/kernel/str.rs                 | 7 -------
>  3 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
> index 679ee1bb21950..e0e42f7028276 100644
> --- a/rust/kernel/block/mq/gen_disk.rs
> +++ b/rust/kernel/block/mq/gen_disk.rs
> @@ -7,9 +7,10 @@
>  
>  use crate::{
>      bindings,
> -    block::mq::{raw_writer::RawWriter, Operations, TagSet},
> +    block::mq::{Operations, TagSet},
>      error::{self, from_err_ptr, Result},
>      static_lock_class,
> +    str::NullBorrowFormatter,
>      sync::Arc,
>  };
>  use core::fmt::{self, Write};
> @@ -143,14 +144,13 @@ pub fn build<T: Operations>(
>          // SAFETY: `gendisk` is a valid pointer as we initialized it above
>          unsafe { (*gendisk).fops = &TABLE };
>  
> -        let mut raw_writer = RawWriter::from_array(
> +        let mut writer = NullBorrowFormatter::from_array(
>              // SAFETY: `gendisk` points to a valid and initialized instance. We
>              // have exclusive access, since the disk is not added to the VFS
>              // yet.
>              unsafe { &mut (*gendisk).disk_name },
>          )?;
> -        raw_writer.write_fmt(name)?;
> -        raw_writer.write_char('\0')?;
> +        writer.write_fmt(name)?;

Although this is nicer than the existing code, I wonder if it should
just be a function rather than a whole NullBorrowFormatter struct? Take
a slice and a fmt::Arguments and write it with a nul-terminator. Do you
need anything more complex than what you have here?

Alice
