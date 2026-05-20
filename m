Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D9D17B50A
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 02:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245883; cv=none; b=lrTU8OWdUvowBEZV0UHqcqDp9h2MjJ7iBHonX95pD1938ipyUTRqOrd1L8Hjsl0yPYIr/hAscC3Mpd1RDBnV8WnK+shuH/sV98Nli5/fE2p0B8+ztjJKm2yZ1ZtVRUGQcZaem052wgsLk8aiHQnfgnLhpQNkoWUfjKmVf0TDt6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245883; c=relaxed/simple;
	bh=JYmwJ10Q/X6BIP7TZU0p2oXEr64Lfl2uYD7b5gohn/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgOltyNGmt8S+Zi6xCkO16JmIwrBz7KqntxfGQohHOBhtswzEAtEa6avMyoPBVbDLgRLZVLi/GMimlbs/DiqMt1VSIBJ7hT6CA6LMypm+4Cog4XBEp/9fIl8lLToIjb6A3OT7mx5oEU6Yo+R11b/ZKvGlaTS+WGzaxl+988++ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Ews0QMxd; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Ews0QMxd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779245877; x=1779505077;
	bh=HMq9Kjag9CHf0MPnSr5IKPbFSpP3OZPnDYq4FIJoKX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Ews0QMxd+ay79QhpTiAIHgopATwYQ4PW1TYqREmx9pBZlEm0TrbqQgopjYSqT0oxI
	 FolwGQ6ooWNaGFW8v+695Mau0ScF0RzcxH4aFXO6yY7nkrg3vqnIDKQ0hivEck0o05
	 HH0rX3ZdqtWRXJcoB4535oBpf6qJj5jLU2tTcF28wONUtH9XuGsSaqc3ISZAA7zZjw
	 EAyAKo/JkUGUFcCXFekytmeETzGR99euKU/NFz4/YLUsHHYdP7D+IQhDK24hlHxrgW
	 Oi1HPc+WeXwrtiHtF+WiO6MeagmJ5OUuqu4F0WmVRBbYo0ELMU1Mmyevs61YLVHq7w
	 IBp4S0OOOiqDw==
X-Pm-Submission-Id: 4gKx6q2f0rz1DFG3
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
Subject: Re: [PATCH v2 1/5] rust: miscdevice: use vertical import style
Date: Wed, 20 May 2026 05:57:51 +0300
Message-ID: <20260520025754.32911-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260520-miscdev-use-format-v2-1-64dc48fc1345@linux.dev>
References: <20260520-miscdev-use-format-v2-0-64dc48fc1345@linux.dev> <20260520-miscdev-use-format-v2-1-64dc48fc1345@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 May 2026 10:40:08 +0800=0D
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
>  rust/kernel/miscdevice.rs | 34 ++++++++++++++++++++++++++++------=0D
>  1 file changed, 28 insertions(+), 6 deletions(-)=0D
> =0D
> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs=0D
> index c3c2052c92069..05a6b6b9770f2 100644=0D
> --- a/rust/kernel/miscdevice.rs=0D
> +++ b/rust/kernel/miscdevice.rs=0D
> @@ -11,16 +11,38 @@=0D
>  use crate::{=0D
>      bindings,=0D
>      device::Device,=0D
> -    error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},=0D
> -    ffi::{c_int, c_long, c_uint, c_ulong},=0D
> -    fs::{File, Kiocb},=0D
> -    iov::{IovIterDest, IovIterSource},=0D
> +    error::{=0D
> +        to_result,=0D
> +        Error,=0D
> +        Result,=0D
> +        VTABLE_DEFAULT_ERROR, //=0D
> +    },=0D
> +    ffi::{=0D
> +        c_int,=0D
> +        c_long,=0D
> +        c_uint,=0D
> +        c_ulong, //=0D
> +    },=0D
> +    fs::{=0D
> +        File,=0D
> +        Kiocb, //=0D
> +    },=0D
> +    iov::{=0D
> +        IovIterDest,=0D
> +        IovIterSource, //=0D
> +    },=0D
>      mm::virt::VmaNew,=0D
>      prelude::*,=0D
>      seq_file::SeqFile,=0D
> -    types::{ForeignOwnable, Opaque},=0D
> +    types::{=0D
> +        ForeignOwnable,=0D
> +        Opaque, //=0D
> +    },=0D
> +};=0D
> +use core::{=0D
> +    marker::PhantomData,=0D
> +    pin::Pin, //=0D
>  };=0D
> -use core::{marker::PhantomData, pin::Pin};=0D
>  =0D
>  /// Options for creating a misc device.=0D
>  #[derive(Copy, Clone)]=0D
> =0D
> -- =0D
> 2.43.0=0D
> =0D
> =0D
