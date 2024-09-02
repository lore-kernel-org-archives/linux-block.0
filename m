Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8E62032A
	for <linux-block@vger.kernel.org>; Mon,  2 Sep 2024 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265132; cv=none; b=UXY4y72QWOghO2p5ALvKMnjLnE0Tq9lJCX162d4toe9LmW/yj29RKT5dXi6EYcsUDPX98jpvdDjDnNDceiX5IN9s4dMiIWVHa5VgPyLAykx0fhNyIfwoDZtZWaBKHRmNCepz4+BpAnsMElODzmbnQvtVfmoYh7nMnDMW7uO0550=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265132; c=relaxed/simple;
	bh=0XBlDPmNzBYUn+4H02GVn0eXdNtRNCQGIcsW9pKqJeQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8WwKT2D/xCArSJTmTBsydgGFngowjyRxVwUP03B6N4ltWm1ePmaxcRX38PRP8J3rhtZXGXFWZ+GIhKYi4mmnoG6UlJayXw1R63J3k2C+ya9+jc5V9NC6/rMv4hBwrBNsVvtrlrQTvLXmi+RWMhxwbDjGT4p8+9kvlTZ2NnLSOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QIL5s/hq; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QIL5s/hq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725265121; x=1725524321;
	bh=S95bxlo27WVbdFZgGK4z8TIsKVubHTnpzo+VgzlMuZo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QIL5s/hqHFkPtjZdgkV9OnSHpqiRH2VFoRkzI/Jcep/MComFP1IaOrtijJ7Q6fEL1
	 LK8g8OrZU5U9kUSLrBa+OauAfQsPollBudgs5BGJ/P+IKD2OOUlWfS90RMQgTuXtQG
	 vPpF6NJkb1y19sDkygfmr8JEaEBKBHdihcrq/5dJfIPMaJoQysC+X4ZedJ3oXIqQQH
	 2i6PpU7OeI2yxXyT5ydemEr0aY1Y6zt5OqeC7nfQkt5fnGwb5GoHz3tE/D7bZabvK9
	 OJxWstWEyQbztpYt4q8pgzRsUje0w2j+R56uJfMQxVjzQYX1tQzI4Lu1YV9ZjDHiwh
	 /78VNAeCCmUMA==
Date: Mon, 02 Sep 2024 08:18:37 +0000
To: Alexey Dobriyan <adobriyan@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH RESEND] block, rust: simplify validate_block_size() function
Message-ID: <c33ed288-9c83-4d94-b820-e4e457a0426e@proton.me>
In-Reply-To: <4386823d-d611-44ef-9017-88ddd5e7ba57@p183>
References: <005b6680-da19-495a-bc99-9ec3f66a5e74@p183> <309bd39a-0c58-472a-9fc8-6fa33d14925a@proton.me> <4386823d-d611-44ef-9017-88ddd5e7ba57@p183>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 2d986a1bd40491f7cd845a826c2b75aa31766403
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.09.24 21:56, Alexey Dobriyan wrote:
> On Sat, Aug 31, 2024 at 08:39:45PM +0000, Benno Lossin wrote:
>> On 31.08.24 22:15, Alexey Dobriyan wrote:
>>> two comparisons. Using range doesn't prevent any bugs here because
>>> typing "=3D" in range can be forgotten just as easily as in "<=3D" oper=
ator.
>>
>> I don't think that using traditional comparisons is an improvement.
>=20
> They are an improvement, or rather contains() on integers is of dubious
> value.
>=20
> First, coding style mandates that there are no whitespace on both sides
> of "..". This merges all characters into one Perl-like line noise.

Can you please provide a link to that coding style? This is the default
formatting of rustfmt.

> Second, when writing C I've a habit of writing comparisons like numeric
> line in school which goes from left to right:
>=20
> =09512 ... size .. PAGE_SIZE   ------> infinity
>=20
> See?
> Now it is easy to insert comparisons:
>=20
> =09512 <=3D size <=3D PAGE_SIZE
>=20
> Of course in C the middle variable must be duplicated but so what?
>=20
> How hard is to parse this?
>=20
> =09512 <=3D size && size <=3D PAGE_SIZE

I would argue that this is just a matter of taste and familiarity. In
mathematics there are also several other ways to express the above.
For example $size \in [512, PAGE_SIZE]$.

> And thirdly, to a C/C++ dev, passing u32 by reference instead of by
> value to a function which obviously doesn't mutate it screams WHAT???

That is because the function is implemented with generics over the type
inside of the range. So if you have your own type, you can use `..` and
`..=3D` to create ranges. For big structs you wouldn't use by-value even
in C and C++.

>> When
>> using `contains`, both of the bounds are visible with one look.
>=20
> Yes, they are within 4 characters of each other 2 of which are
> whitespace.
>=20
> This is what this patch is all about: contains() for integers?
> I can understand contains() instead of strstr() but for integers?

Don't get me wrong, we can have a discussion about this. I just think
that it is not as clear-cut as you make it out to be.

>> When
>> using two comparisons, you have to first parse that they compare the
>> same variable and then look at the bounds.
>=20
> Yes but now you have to parse () and .. and &.

As I said above, it's a matter of familiarity. I don't think that using
contains is inherently worse.

>>> Also delete few comments of "increment i by 1" variety.
>>
>> As Miguel already said, these are part of the documentation. Do not
>> remove them.
>=20
> Kernel has its fair share of 1:1 kernel-doc comments which contain
> exactly zero useful information because everything is in function
> signature already.

Sure, but in this case, I don't think everything is in the function
signature.

> This is the original function:
>=20
> =09/* blk_validate_limits() validates bsize, so drivers don't usually nee=
d to */
> =09static inline int blk_validate_block_size(unsigned long bsize)
> =09{
> =09        if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
> =09                return -EINVAL;
> =09        return 0;
> =09}
>=20
> I have to say this is useful comment because it refers to another more
> complex function and hints that it should be used instead. It doesn't
> reiterate what the function does internally.
>
> Something was lost in translation.

We currently don't have that function in Rust. Also note that in
contrast to C, this function is private. So no driver is able to call it
anyways.

In this case, documentation is not really necessary, as we only require
it for publicly facing functions. But for those I think it is useful to
reiterate what the code does. They might be the entrypoint for first
time kernel developers and giving them an easier time of understanding
is IMO a good thing.

---
Cheers,
Benno

