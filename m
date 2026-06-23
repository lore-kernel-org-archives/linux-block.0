Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAF084039;
	Tue, 23 Jun 2026 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206361; cv=none; b=lpoVYJkQPd1ukszp3qDFegHdiWBwQ+WsqwtLLOVmaJmK/Bk9Cul0C5NXM8iQfwK2T/nM6IoeOL9bUyEvWzlEQTt8Wue7FJ8ejcm8gEYdnn4bU3JJ/hGW8ni10ZIPycvKRleip0S3LU/6J1WOt8nyuFB/FZFSWVL1uArdlnfFcz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206361; c=relaxed/simple;
	bh=fIsU9HO78Ig0J4qHlFK6IG674XoTwqOhcn5KaIphiaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cT7d17eH2HIdMvWhqtDlZxXYR94BByoZCK8+4uhv8Bh3MnRJV/6nOEJSiUdWX6vOrYK5FPhZLVRQRwZeE+JTOX1bi4+v80O90VnO3mfUfuod+g24OlIMdNTB8iraEX2VYVhjNTdIdot/lfq6HqRAgSBUCqvjL5gE3QasQfqvt90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id E04EC1D7585; Tue, 23 Jun 2026 17:19:10 +0800 (AWST)
X-Spam-Level: 
Received: from [IPV6:2001:8003:8810:ea00::9c4] (unknown [IPv6:2001:8003:8810:ea00::9c4])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id CCA7E1D7574;
	Tue, 23 Jun 2026 17:19:07 +0800 (AWST)
Message-ID: <5748f9ca-e684-42a0-9297-e587b178a47c@davidgow.net>
Date: Tue, 23 Jun 2026 17:19:04 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] rust: doctest: use vertical import style
To: Alvin Sun <alvin.sun@linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Brendan Higgins <brendan.higgins@linux.dev>,
 Rae Moar <raemoar63@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20260521-miscdev-use-format-v3-0-56240ca70d0c@linux.dev>
 <20260521-miscdev-use-format-v3-7-56240ca70d0c@linux.dev>
From: David Gow <david@davidgow.net>
Content-Language: fr
In-Reply-To: <20260521-miscdev-use-format-v3-7-56240ca70d0c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 21/05/2026 à 2:57 PM, Alvin Sun a écrit :
> Convert `use` imports to vertical layout for better readability and
> maintainability.
> 
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---

Assuming this'll go in via the Rust tree, given there are other changers
to the rustdoc work which will likely go in that way. (But, if we'd
prefer it to go in via kselftest/kunit, that shouldn't be a problem.)

Acked-by: David Gow <david@davidgow.net>

Cheers,
-- David

>  scripts/rustdoc_test_gen.rs | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
> index d61a77219a8c2..ee76e96b41eea 100644
> --- a/scripts/rustdoc_test_gen.rs
> +++ b/scripts/rustdoc_test_gen.rs
> @@ -31,8 +31,15 @@
>  use std::{
>      fs,
>      fs::File,
> -    io::{BufWriter, Read, Write},
> -    path::{Path, PathBuf},
> +    io::{
> +        BufWriter,
> +        Read,
> +        Write, //
> +    },
> +    path::{
> +        Path,
> +        PathBuf, //
> +    }, //
>  };
>  
>  /// Find the real path to the original file based on the `file` portion of the test name.
> 

