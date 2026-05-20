Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74B1EE01A
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 02:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245937; cv=none; b=Bf6G5TjnVcHvig02R2VTi/vSakBDLk9j6/4ctTdCeqNiGNIr5HtYUp3R+7HJJjNzBZwwFOtXnx2xPy6iCKla/43R+K9H00cJmFLj3Mf6gD5b5PAAh2IOPMxbaBH/J7bkJ3lOBiwgk81k1iPt5mpfcFxvWdy5cqynPfSCFsw0As0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245937; c=relaxed/simple;
	bh=Lm7JGqQBKhvPbaxJtOLLGub+vPa2ovKT7hoIZk/bBOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhbV60XGObR15LfXmhljZAQPn4ldDAr1z8/ydylfGo6iLReUltEVKPt4j84QipXQNTvMe1kLK34xVN5oHxH7ICStlwAxgCLDKIOKsZ4mhb5LvCPLyKudx/X69q4bYuj1VMUP2jvIPUaX5eFd+/EILr03jRT3Id2cwmXZC0t4tog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Ci+qguYH; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Ci+qguYH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779245927; x=1779505127;
	bh=TCpEbNuXwECXOxD/9cT3jUPsiKLteaaU0zK3Wu86Vq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Ci+qguYHYU5n67cO7a4xM09I9qRypzWrlQi5RTU+mfU3HfX3rvUQezHSqA2p90EsN
	 eT+iqV848tAY7cdJ+6ovD1GbTyKK0t3TaCE3SoGBtbFktekJecqvh4TyiSvShdteju
	 C6oQxZJKXmbPVYwycGGl0lW0OgBq5vdzCGZidhX6XLc9cJyWtcmra4B5539BfoBA8U
	 mFI4xu20xZZC6dG5X4UPE2NwGOj17skAP1nLSvscuCNKAIs3CXHvj5paazAbKSCPW7
	 IoK8QqyNyAw7JdDtYyki952OFHPSFksDpT8mI64MSRl/Akzc437XCOXpT7CnopdW2w
	 ojjkgUPzlrJuA==
X-Pm-Submission-Id: 4gKx7l442jz1DF7B
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
Subject: Re: [PATCH v2 2/5] samples: rust_misc_device: use vertical import style
Date: Wed, 20 May 2026 05:58:39 +0300
Message-ID: <20260520025842.34118-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260520-miscdev-use-format-v2-2-64dc48fc1345@linux.dev>
References: <20260520-miscdev-use-format-v2-0-64dc48fc1345@linux.dev> <20260520-miscdev-use-format-v2-2-64dc48fc1345@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 May 2026 10:40:09 +0800=0D
Alvin Sun <alvin.sun@linux.dev> wrote:=0D
=0D
> Convert `use` imports to vertical layout for better readability and=0D
> maintainability.=0D
> =0D
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>=0D
=0D
Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
=0D
> ---=0D
>  samples/rust/rust_misc_device.rs | 34 ++++++++++++++++++++++++++++------=
=0D
>  1 file changed, 28 insertions(+), 6 deletions(-)=0D
> =0D
> diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_de=
vice.rs=0D
> index 87a1fe63533ae..41e26c825060b 100644=0D
> --- a/samples/rust/rust_misc_device.rs=0D
> +++ b/samples/rust/rust_misc_device.rs=0D
> @@ -97,14 +97,36 @@=0D
>  =0D
>  use kernel::{=0D
>      device::Device,=0D
> -    fs::{File, Kiocb},=0D
> -    ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},=0D
> -    iov::{IovIterDest, IovIterSource},=0D
> -    miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},=
=0D
> +    fs::{=0D
> +        File,=0D
> +        Kiocb, //=0D
> +    },=0D
> +    ioctl::{=0D
> +        _IO,=0D
> +        _IOC_SIZE,=0D
> +        _IOR,=0D
> +        _IOW, //=0D
> +    },=0D
> +    iov::{=0D
> +        IovIterDest,=0D
> +        IovIterSource, //=0D
> +    },=0D
> +    miscdevice::{=0D
> +        MiscDevice,=0D
> +        MiscDeviceOptions,=0D
> +        MiscDeviceRegistration, //=0D
> +    },=0D
>      new_mutex,=0D
>      prelude::*,=0D
> -    sync::{aref::ARef, Mutex},=0D
> -    uaccess::{UserSlice, UserSliceReader, UserSliceWriter},=0D
> +    sync::{=0D
> +        aref::ARef,=0D
> +        Mutex, //=0D
> +    },=0D
> +    uaccess::{=0D
> +        UserSlice,=0D
> +        UserSliceReader,=0D
> +        UserSliceWriter, //=0D
> +    },=0D
>  };=0D
>  =0D
>  const RUST_MISC_DEV_HELLO: u32 =3D _IO('|' as u32, 0x80);=0D
> =0D
> -- =0D
> 2.43.0=0D
> =0D
> =0D
