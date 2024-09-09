Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A860F3B791;
	Mon,  9 Sep 2024 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725909728; cv=none; b=ohgYmsmDzCSlyDZqnJDCAVDQxdEFNpGTUGJ6q8dqzj/88+wa4pKm4f7txdXtgY2Z6TW88aD+gXNKc1Wznk3LMpsFyfL2eou0MYH60vhBuZh3qSN8gpgnVDT/SP1pa3hjXBtGQiBag4/w38tfDbo17+FsVVmeV1whDgIhj/aXjck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725909728; c=relaxed/simple;
	bh=iAYIIHRt18lg9w7vLJijk467AYA5AqKTOUwAyqj4X70=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUTY0Ecnn0ZhY+ikG/RQ95OjQvdt58vlU8o9ZFCiEorlYktse8pQ8h+56ize8XuVpWk+ogkOYTn46jC6Dg034nCUGd8dmQsVAPtdzXcznKcdlljrROeR6pEZiQ1uVor1LBdnjEU6WEEMZ91aAr/PLFZvf+CWNu3NJQdC4MeWGsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NTUjHPgI; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NTUjHPgI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725909718; x=1726168918;
	bh=BbaACj++wGC+vRsUotK63/Ncake27cvpWE5Gb9nDHk4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NTUjHPgIQPf5vTU4Jngyz3XAXuh17LUo/R0KnLULVTgb2YxCtJG32rMQ4QfFln4hc
	 kulE6IxIgZnAt8I+RdgKxknS3yz5CcGtGrwmJ3IDWhHQl4wCP56ICT1jqHJrq0rMPE
	 x8+o6jizpZ4FJWtO/qy+Q5VXjnhjrcgk7jqAQh8+katU0Ys3MAaivkSCodup2AxdFM
	 x+vtAfyiw2ZWjavr6tWZHL6EATN6pEuAZgticrqxvcDPeeZDDqr3pJO58wlMUXBRCa
	 fHF4T0jlfRhl/RzMSa4CFdyT/kEtr9MqZMKbxo3IX4hzcXPLdPkZlKYXEjTYSKURsn
	 f3R2207MBx1Pg==
Date: Mon, 09 Sep 2024 19:21:54 +0000
To: hridesh <hridesh699@gmail.com>, linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?=27Bj=C3=B6rn_Roy_Baron=27?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, Matt Gilbride <mattgilbride@google.com>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] docs: rust: clean up empty `\\\` lines and improve rustdoc formatting
Message-ID: <7b98dbcc-318d-49e7-b71a-f64cc611c2ad@proton.me>
In-Reply-To: <20240909161749.147076-1-hridesh699@gmail.com>
References: <20240909161749.147076-1-hridesh699@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: dc0c0f0bf0835221911e1df6237157ff7ae24ed3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I see that this is your first kernel contribution, welcome!
I have left a couple comments below; before you send a new version,
please wait a couple days for other people to also leave their feedback.
You then create a new version (add `-v2` to `git format-patch`) and send
it to the list. You can put a changelog underneath the `---`, it will
not be included int the commit message, but for people reading the mail
it is rather helpful.

On 09.09.24 18:17, hridesh wrote:
> Remove unnecessary empty `\\\` lines in the rust docs. Also add linebreak=
s

You wrote backslashes here, but it should be forward slashes instead.
Please also fix it in the title.

I don't know if the commit title should start with `docs`, maybe we want
to do `rust: docs` when changing rustdocs? (This is a question to the
other Rust reviewers)

I think the title doesn't need to mention the exact cleanup, just
something along the lines "clean up docs" should suffice.

> in kernel::block::mq::Request to fix formatting
>=20
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1109

The issue also mentions that you should implement a `checkpatch.pl`
check in an additional patch:

> Clean up consecutive empty `///` lines and implement a checkpatch.pl
> check for it. These should be two different patches.

Please include that patch in your series.

> Signed-off-by: hridesh <hridesh699@gmail.com>
> ---
>  rust/kernel/block/mq/request.rs | 7 +++----
>  rust/kernel/rbtree.rs           | 1 -
>  2 files changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/reque=
st.rs
> index a0e22827f3f4..3ab2917c9d25 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
> @@ -22,15 +22,14 @@
>  ///
>  /// There are four states for a request that the Rust bindings care abou=
t:
>  ///
> -/// A) Request is owned by block layer (refcount 0)
> +/// A) Request is owned by block layer (refcount 0)\

Instead of adding these backslashes, I personally would prefer if we
make this a normal markdown list using `1.`, `2.` etc.
Of course only if Andreas is OK with that though.

---
Cheers,
Benno

>  /// B) Request is owned by driver but with zero `ARef`s in existence
> -///    (refcount 1)
> +///    (refcount 1)\
>  /// C) Request is owned by driver with exactly one `ARef` in existence
> -///    (refcount 2)
> +///    (refcount 2)\
>  /// D) Request is owned by driver with more than one `ARef` in existence
>  ///    (refcount > 2)
>  ///
> -///
>  /// We need to track A and B to ensure we fail tag to request conversion=
s for
>  /// requests that are not owned by the driver.
>  ///
> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
> index 25eb36fd1cdc..006f6e03aba5 100644
> --- a/rust/kernel/rbtree.rs
> +++ b/rust/kernel/rbtree.rs
> @@ -1031,7 +1031,6 @@ fn next(&mut self) -> Option<Self::Item> {
>=20
>  /// A memory reservation for a red-black tree node.
>  ///
> -///
>  /// It contains the memory needed to hold a node that can be inserted in=
to a red-black tree. One
>  /// can be obtained by directly allocating it ([`RBTreeNodeReservation::=
new`]).
>  pub struct RBTreeNodeReservation<K, V> {
> --
> 2.46.0
>=20

