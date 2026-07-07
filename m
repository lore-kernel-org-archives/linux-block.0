Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F613672A8;
	Tue,  7 Jul 2026 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431922; cv=none; b=Fpu9JdQLqpufGTjiQ0xQWRPN4lOOzumbzKhjL8q6kQXqC11xrSn8hvCB5lpW0XWc4qaGztNFG2yp6L9QwFxfrSHXutLGeioFxq8om/Ilg8Mnmqd2Q1//dm2LtHXvvn7FoBVUU3/nEQqfb7gkzrnUyBIdgFCtihRitbV8Rnq53qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431922; c=relaxed/simple;
	bh=BBhibmhM3huTGhOUaEJeDEVf51iSJDzcZUUrU/ERrGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mplDo2AL3Z9dtAAqryueuQPH+/n6745RX6IhNpm9dNIjVFiHCjbXMYGhqbZhWKIuWO5p1+Douv6GbvzfCcwsULXMjdwbz0HpqfaqH/HOXbpEhunLr7nEZPFM3AsmRGASACFPDplEUgcbJ7Xc06lcZQ0cWOAnEl7k7g5fvaI1cqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4MiNEMJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4MiNEMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9C81F00A3A;
	Tue,  7 Jul 2026 13:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783431920;
	bh=5dBcpWRkjDihs/b/BMTjKD0Em+iYR5MGgaj1yp5+iB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=D4MiNEMJNcTmxqDlMZCoH62oCY3cYVFlHkMoBqrh5hHiW+Dkz1tQ86/trc39HBApB
	 X8eTLZMbpulAs2C3Qi7h2HOUF8ZlG4WoS6laW5KEDFs5hksV4FvB1SM9Mb/hU0J1jN
	 cnd6ToDcIboBP6ZkVct206hvBMTDII/mesleY4CAYoajJA59MBq5B2HQGdh8OBRGCH
	 Cz1/BrGJS2BL+j9VOyArVQM+I36I7wJyh/jQfdHw9WjuPhudL3PsbjSJWAbR6TTlOo
	 mJe+J5t41xG4qgLkjJR9YkpnmJMS1R/P7Ou2LFGJ7HLqAt2ngKfOajl46FCG54bY59
	 I0j6afhX/vIoA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: =?utf-8?B?7ZWY7Iq57KKF?= <engineer.jjhama@gmail.com>
Cc: "Liam R. Howlett" <liam@infradead.org>, Alice Ryhl
 <aliceryhl@google.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Benno Lossin <lossin@kernel.org>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Boqun Feng <boqun@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, Gary Guo <gary@garyguo.net>,
 Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>, Lorenzo
 Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, Miguel Ojeda
 <ojeda@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 10/83] block: rust: allow `hrtimer::Timer` in
 `RequestData`
In-Reply-To: <CAGAB667mVuECQDwYDij5PcZ-fvqr-6womuRCHibrwiR_wP=YDg@mail.gmail.com>
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
 <20260609-rnull-v6-19-rc5-send-v2-10-82c7404542e2@kernel.org>
 <CAGAB667mVuECQDwYDij5PcZ-fvqr-6womuRCHibrwiR_wP=YDg@mail.gmail.com>
Date: Tue, 07 Jul 2026 15:45:06 +0200
Message-ID: <87v7aqhq1p.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=ED=95=98=EC=8A=B9=EC=A2=85 <engineer.jjhama@gmail.com> writes:

> 2026=EB=85=84 6=EC=9B=94 10=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 4:23,=
 Andreas Hindborg <a.hindborg@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
>> +    fn cancel(&mut self) -> bool {
>> +        let request_data_ptr =3D &self.inner.wrapper_ref().data as *con=
st T::RequestData;
>
> I think this trips clippy::ref_as_ptr, which is enabled in the top-level
> Makefile (-Wclippy::ref_as_ptr), so `make CLIPPY=3D1` fails here under
> CONFIG_RUST_WERROR. IMO core::ptr::from_ref() would read better.

Thanks. I'm not sure why I did not see clippy complaining. I agree
`ptr::from_ref` is a better choice.

>
>> +        let pdu_ptr =3D self.data_ref() as *const T::RequestData;
>
> Same here, I'd go with:
>
>     let pdu_ptr =3D core::ptr::from_ref(self.data_ref());
>
> I applied both changes on top of rnull-v7.1-rc2 and `make CLIPPY=3D1` pas=
ses
> cleanly here (the two ref_as_ptr errors go away, no new warnings).

I'll add this in next version.

>
> Best regards,
> SeungJong Ha
>
> ---
> I'm not a regular reviewer for this subsystem =E2=80=94 I just ran into t=
his while
> building your rnull tree with clippy. Let me know if drive-by notes like =
this
> aren't the right fit here.

I appreciate the comments, please do continue sending them if you come
across more stuff.

Best regards,
Andreas

