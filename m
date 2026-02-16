Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1330D26E175;
	Mon, 16 Feb 2026 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235915; cv=none; b=gOX2NZdFNRUu6OlJrgmIDAQKKdJ/mnE/xuEvUqeIolTTSd/y1GoiWFPRqnQujdruA1XAmIIHNh2+Lr5wTxMhrGIoFwSh8cPGA+jU4fc6bZ5MxTZLaUyc0fQKcssPczBTMWQZZXMNwyeuIBIKW1BP/7MiH1nMHjzk8Kvp9MFUTyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235915; c=relaxed/simple;
	bh=Je+2BLA+vLRxPnS3i8+XJCu6/EY9qzsoEAPkWQEYgxc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=a4BJ514gWm9JIv/cOH5k/VnpmIJb5JPfHVAPMNTTzlURG73MxkJSQtl/vyup8Pm9LmCZ435ycQPO54vVFBhjHKDnExFno3gE5uECPYSKxuO5LpIzgG3UErQS2JL5LePbYtYl5ny70i3EazaO5p2j742pHWIKxBZBATugVwnM7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQcFS1Fb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQcFS1Fb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BE8C116C6;
	Mon, 16 Feb 2026 09:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771235914;
	bh=Je+2BLA+vLRxPnS3i8+XJCu6/EY9qzsoEAPkWQEYgxc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=LQcFS1Fbv4Gu9buLkY73ffGxbNIyaq9nyTTFbJcDPgawZ3u7hsqve8euWd+a08s71
	 7EuEYr8kjGDB1NpBBe0bkIO6ooGJJy3i+HdcNIiiac0Q1mCjOoJgQRYYejoqr7dCdW
	 QzVnjVndqFRnuVRuryd25k5sIsmvaoGt54aF4YDRjM4s/NbdpmCEZJpmhEgArbP3PN
	 hDHp8NT1WgT6rEjj/l7Jl3dvTEoBW0LEBP/R6brPdsSbLHABH4OlbyDMxa93vB5MoG
	 hKO37m18mVWJZLee8fdjPejTGKhMlCZlUxZPHUIiiMYZcU5wAnhQh5F+Fi9xwQlIjM
	 wWqwqI4NcKrdg==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 10:58:30 +0100
Message-Id: <DGGAQ7XIDJ3P.1Q2K9WCC25EH3@kernel.org>
Subject: Re: [PATCH] configfs: rust: add an API for adding default groups
 from C
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Jens Axboe" <axboe@kernel.dk>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Breno Leitao" <leitao@debian.org>,
 <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260215-configfs-c-default-groups-v1-1-e967daef6c36@kernel.org>
In-Reply-To: <20260215-configfs-c-default-groups-v1-1-e967daef6c36@kernel.org>

On Sun Feb 15, 2026 at 9:33 PM CET, Andreas Hindborg wrote:
> @@ -259,7 +269,13 @@ pub fn new(
>          name: CString,
>          item_type: &'static ItemType<Group<Data>, Data>,
>          data: impl PinInit<Data, Error>,
> +        default_groups: impl IntoIterator<Item =3D Arc<dyn CDefaultGroup=
>>,
>      ) -> impl PinInit<Self, Error> {
> +        let mut dg =3D KVec::new();
> +        for group in default_groups {
> +            dg.push(group, GFP_KERNEL).unwrap();

We should not panic the kernel on allocation failure.

If you wrap the function body into pin_init::pin_init_scope() you can just =
use
the '?' operator instead.

> +        }
> +
>          try_pin_init!(Self {
>              group <- pin_init::init_zeroed().chain(|v: &mut Opaque<bindi=
ngs::config_group>| {
>                  let place =3D v.get();
> @@ -268,13 +284,28 @@ pub fn new(
>                  unsafe {
>                      bindings::config_group_init_type_name(place, name.ca=
st(), item_type.as_ptr())
>                  };
> +
> +                for default_group in &dg {
> +                    // SAFETY: We keep the default groups alive until `S=
elf` is dropped.
> +                    unsafe { bindings::configfs_add_default_group(defaul=
t_group.group_ptr(), place) }
> +                }
>                  Ok(())
>              }),
>              data <- data,
> +            default_groups: dg,
>          })
>      }
>  }
