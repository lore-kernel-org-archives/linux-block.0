Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C21248861
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 02:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245953; cv=none; b=fR4HXiqk07zr5tw4Hmke0ruTtCKjrOinHZIy/LOtBSbmX9Vskr9KO6CiXe/AjYZSelnw5knFGTotRHG8BKERIQxrLFNfkwPVthAV60jU/LL6j/jRsAV5FxlvIEB/wAI67YOQ2skGlauT7nqBphdXzIctMI7xewhoE6NMBm1gYy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245953; c=relaxed/simple;
	bh=aYyZVmht/tkW2NO1zwjDqHH4kpqIDgepd+X4B0fgqWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kh3RngKdd+YkJHBYfbwmSiJX4XOX0ygzzEexueF4CIpQKAHB5T4khrfB7mRV8EpU3wVoHEyqjO1Q8JusLWUCZSVY1U/C79CIvfFdzQdHS+bR82hm2aV76mzEibqDoswIaUeejWjNgWlJvhYvc/qpy5weklFYY6d26r6XVs5XKC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=SdHInleO; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="SdHInleO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779245948; x=1779505148;
	bh=zjmdVO9L+tItPwql0zzPqqUIC1GdDAoMr9xMbml9SOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SdHInleOJgX+VXUiGLjYIXdmE8cI00mDFwxP6D+kuezh5ezFJlP/lhOXICy4cYQrB
	 V6HC28i11y+HCgisfgijKtQ93bCIU68AiNp1sIxS/cTKMpWgSAjlpZ+T4DuZ1oesix
	 VqSSk98WhAUE6d+qTnsevSbpb/EGxt1+wZJ7xJzRjb3qBTa//YPVbj/D0t29u5YAd3
	 jjlNdFe8mfK2Z46CcwlYZY6abCzOnrqUtjWjjOS3mow2zcg2OtqOVwC8mJLhSCyTNG
	 yJ6Na0buu2ua9kiXA2E41bbBvNiKgt77MWeDC7gqLzo1TEAyoOZdXCh9YRI26tI0vV
	 43qsMH34RqrKg==
X-Pm-Submission-Id: 4gKx892Bgmz1DDKx
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH v2 3/5] rust: miscdevice: remove redundant imports
Date: Wed, 20 May 2026 05:59:01 +0300
Message-ID: <20260520025902.34629-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260520-miscdev-use-format-v2-3-64dc48fc1345@linux.dev>
References: <20260520-miscdev-use-format-v2-0-64dc48fc1345@linux.dev> <20260520-miscdev-use-format-v2-3-64dc48fc1345@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 May 2026 10:40:10 +0800=0D
Alvin Sun <alvin.sun@linux.dev> wrote:=0D
=0D
> Drop `Error`, `Result`, `Pin`, `c_int`, `c_long`, `c_uint`, and=0D
> `c_ulong` imports already provided by `kernel::prelude`.=0D
> =0D
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>=0D
=0D
Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
=0D
> ---=0D
>  rust/kernel/miscdevice.rs | 13 +------------=0D
>  1 file changed, 1 insertion(+), 12 deletions(-)=0D
> =0D
> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs=0D
> index 05a6b6b9770f2..83ce50def5ac9 100644=0D
> --- a/rust/kernel/miscdevice.rs=0D
> +++ b/rust/kernel/miscdevice.rs=0D
> @@ -13,16 +13,8 @@=0D
>      device::Device,=0D
>      error::{=0D
>          to_result,=0D
> -        Error,=0D
> -        Result,=0D
>          VTABLE_DEFAULT_ERROR, //=0D
>      },=0D
> -    ffi::{=0D
> -        c_int,=0D
> -        c_long,=0D
> -        c_uint,=0D
> -        c_ulong, //=0D
> -    },=0D
>      fs::{=0D
>          File,=0D
>          Kiocb, //=0D
> @@ -39,10 +31,7 @@=0D
>          Opaque, //=0D
>      },=0D
>  };=0D
> -use core::{=0D
> -    marker::PhantomData,=0D
> -    pin::Pin, //=0D
> -};=0D
> +use core::marker::PhantomData;=0D
>  =0D
>  /// Options for creating a misc device.=0D
>  #[derive(Copy, Clone)]=0D
> =0D
> -- =0D
> 2.43.0=0D
> =0D
> =0D
