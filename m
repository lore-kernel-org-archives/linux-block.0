Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643BC18EFDB
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395098; cv=none; b=rdIQ/fgqJwM2I9I8NC+0kzBMqje5SIBGTT1YJxAsirVKPy3iQDucZZeaoeB9CZWVLRFbEDlK399Fb0tPzHtayvAo0G7rCkjiwkscnUcKysGe2Q3GlIX+KpZWQ0bMHHel9hu1lghbDzelZr6oGydzOonn3PNH4WAza97+yfPXIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395098; c=relaxed/simple;
	bh=VNHzcWuYQK0bAEMKUb8JAk2vL03Ybu2yBC14t6W6Hno=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxqnP6f20kziFmg906E3X8StHojVNbjRTfRb0ycSkyys/3emxaEsaMigpnHlcJpemj0TGgwD1UH66J8xGxUkTqF7JxZZ+OU2Bc90NhekR/lk6AN72TdeHioLEaL4Ma5iWwQGzXWyKsCQol8MpfxotHZsipARxR+XD9pSVTJRVLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ERrsBTHa; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ERrsBTHa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725395088; x=1725654288;
	bh=VNHzcWuYQK0bAEMKUb8JAk2vL03Ybu2yBC14t6W6Hno=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ERrsBTHaumDOkGjC/8RI6f03pzjnXc5Ao/m+OozZqrtASW2tNIKk7v5DXRNKkqPue
	 kKEDQmbNwhP41pxqBVl8mKYgAlSnzyJ2AXXuw1K1YLeOP/QgLZYnqYOEW2OM+5cgkR
	 jcK3pTDhXwutYLS4j0GoUu0MZlCmGRjYIEUn9fInKBlu2UuFCB/4KwcLmlTb2PTIfP
	 Nhm7H8L6wiWwDVGv3cdiE/11FEbpPvB+fYycjYV0/x3K1nrb7Rm4n6u8wDFAIQW8gk
	 FORwrvL2IQo4HnR6aGYVRN3yUJNsj3AWs5CTeIHfCxddK7gM9UL6gFAXxF6odZGBPC
	 Bdk/kkaLbo3XQ==
Date: Tue, 03 Sep 2024 20:24:42 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <nmi@metaspace.dk>, Alexey Dobriyan <adobriyan@gmail.com>, Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH RESEND] block, rust: simplify validate_block_size() function
Message-ID: <1ecef86a-0528-4027-904b-401af790c54f@proton.me>
In-Reply-To: <ZtdnuH9lWtsPCg-X@google.com>
References: <878qwaxtsd.fsf@metaspace.dk> <Ztdctd0mbsJOBtJV@google.com> <CANiq72=GRbxY=3-NP6RutcJjCqRxRftafVZqDD73tureOh20Ew@mail.gmail.com> <ZtdnuH9lWtsPCg-X@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f3cba3123ea0b0560f1aefd2112bae488ff3a378
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.09.24 21:47, Dmitry Torokhov wrote:
> On Tue, Sep 03, 2024 at 09:30:53PM +0200, Miguel Ojeda wrote:
>> On Tue, Sep 3, 2024 at 9:00=E2=80=AFPM Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>>> able to parse the things quickly and not constantly think if my Rust is
>>> idiomatic enough or I could write the code in a more idiomatic way with
>>> something brand new that just got off the nightly list and moved into
>>> stable.
>>
>> If a feature is in the minimum support version we have for Rust in the
>> kernel, and it improves the way we write code, then we should consider
>> taking advantage of it.
>>
>> Now, that particular function call would have compiled since Rust 1.35
>> and ranges were already a concept back in Rust 1.0. So I am not sure
>> why you mention recently stabilized features here.
>=20
> I was talking in general, not about this exact case, sorry if I was
> unclear. But in general I personally have this issue with Rust and to
> extent also with C++ where I constantly wonder if my code is "idiomatic
> enough" or if it looks obsolete because it is "only" C++14 and not 17
> or 20.
>=20
> With C usually have no such concerns which allows me to concentrate on
> different things.

I personally don't worry about whether my code is idiomatic. I just code
and when others give suggestions that sound good, I apply them. There is
nobody requiring all Rust code to be as idiomatic as possible. In the
review process you might be nudged to write in a more idiomatic style,
but that should also be true for C. The kernel is constantly adding new
ways of doing things and while the language itself doesn't evolve, the
codebase surely does.

>> For this particular case, I don't think it matters too much, and I can
>> see arguments both ways (and we could introduce other ways to avoid
>> the reference or swap the order, e.g. `n.within(a..b)`).
>>
>>> This is a private function and an implementation detail. Why does it
>>> need to be exposed in documentation at all?
>>
>> That is a different question -- but even if it should be a private
>> function, it does not mean documentation should be removed (even if
>> currently we do not require documentation for private items).
>=20
> I think exposing documentation for private function that can change at
> any time and is not callable from outside has little value. That does
> not mean that comments annotating such function have no value. But they
> need to be taken together with the function code, and in this case
> Alexey's concern about comments like "this increments that by 1"
> becomes quite valid.

For the private `validate_block_size` function, I can see your argument.
However, I don't think that the function will change any time soon, so I
don't think it's a huge issue.

---
Cheers,
Benno

