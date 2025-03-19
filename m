Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44B51A072A
	for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742414800; cv=none; b=r7GFm6lBbiNhDiybeAfG1DolLasy4iW/z7PP7URCDNxrYhBtr8P6OHPf2loljAXR/cvqvyGn0iZqxsQMzNc6dhanrzu4NxYHoFfAPDy7Cipaa8G40kOSzN1sOr442J1oS1lLcFy4rpEpg5n2JVpAYixWL3ySOK3PjTfjW4UluI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742414800; c=relaxed/simple;
	bh=sBQizwXG0Ih32L76gbEuUHAYkdvvLkptVImMH98yU3M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNO0mfRQ9D1KIjsrqsUfJ3hcFWwarDrYghDIW9rVSghbAJu49VKfsCqd+uvpcNm9PCbvaSmZ+BwpVsXtigEKb9bvZa/5Y5GKJqe0cIIpHY6y/j5ov2MT3PdToo1SS97I8bgd2QVs8TkuOMKK6zIyQd1M4jRHiQdaIkIxJeoCZ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TkmI5WJR; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TkmI5WJR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742414796; x=1742673996;
	bh=sBQizwXG0Ih32L76gbEuUHAYkdvvLkptVImMH98yU3M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=TkmI5WJRmBKhXPvPqG28K9WsoFVFQRoTF2o7mjeqwqWaVj7NYOKz3YJdtyRz/Ycmf
	 y3jkM559fQZgtjcBKLQadCBdCaJK0mEvKs47V9jt4ZKYfgFVYdUpHkA13KUcmKp5nM
	 VmJxTbb9yQLkM5rwYsNnGl4JeWCUvchQ30gG+0kPyWBySCiRx1/50uPo1dXsuT0iPd
	 CwVTF4oSriUDdZiJXdmrp+0AdEBAjcalyw5VMV9e2ZZbYjqBrkJ9802qvoct4mo3go
	 myp3ofL6xrG+nOkP6V3+x8cNMsPIz8D1mOm9Jr3LSNUMMP50nqtA8Rdi6gFq/WX0vS
	 IcUQAA5CEDb5g==
Date: Wed, 19 Mar 2025 20:06:29 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
Message-ID: <D8KIHNXCPE0P.K4MD7QJ1AC17@proton.me>
In-Reply-To: <CAJ-ks9kD++_T_3my1Etam9PRJHHZvdM=zbkWgbxW3oybwMTw9w@mail.gmail.com>
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com> <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com> <Z9lnIJCcVSza6UVo@google.com> <D8JTC30W0NF6.17SR73Y9I99ZT@proton.me> <Z9q2xpwsNMDzZ2Gp@google.com> <CAJ-ks9m8r_ABh4ift3wmM_wpbYLo=ZuhUarfLJKQnS7TcGHRdg@mail.gmail.com> <D8KBL9Z0B68N.2Q3MU9UK9YI6G@proton.me> <CAJ-ks9kD++_T_3my1Etam9PRJHHZvdM=zbkWgbxW3oybwMTw9w@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: c1e16fe86517918748b68b2b3bbf9b93cc99ada5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 19, 2025 at 7:23 PM CET, Tamir Duberstein wrote:
> The improved ergonomics arrive in Rust 1.79. See Boqun's reply that
> explains we need to keep all the stubs until then.
>
> Regarding landing the rest of the series - you said it yourself: "it's
> only going to get more painful in the long run to change this". The
> nature of lints is that the longer you don't enable them, the likelier
> you are to have a higher hill to climb later.

Yeah that's also true (for some reason I was understanding "dropping"
the patch as "abandoning" the patch :)
As discussed in the meeting, feel free to split the series.

---
Cheers,
Benno

