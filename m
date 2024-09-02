Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DF51D2F6A
	for <linux-block@vger.kernel.org>; Mon,  2 Sep 2024 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271060; cv=none; b=itFj9NkXu4LEgKHNkg68PvrUxDRjv+Nj6BDu5i/uBtKcSu7LRzNNSEuYfhcjHM/oZqYzdqt7+UF86YdqtJCEH4Y1ufYiVNm2GTE7hHNHaKjBRmhctfQJNVNDWcsnNkqnMA1unz6kK/OGdWle9WGDIY8ckTEvDDwCL/dvrd+ZrBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271060; c=relaxed/simple;
	bh=iCQrhe26Itmky33un7/z2BBl5eDbinlN+XD/NVKKj6M=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HE4sMaDR+XwaA87I0xlZI3w6nqYpbq6ZH35AvvpmNSi8iCxaWlJ6T0A00WP1zLx9fRl9VcvRGScZHAVAVjWtbr2IZLiYBfy96nCby4EGd4AYKa4sbRYLlGWYUyOX7Xwk4p/ZNlfU/g8tOcHJKL/YBkOVEJahc1HzBjaKCDYFwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=ZpQlxwyP; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="ZpQlxwyP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1725271041; x=1725530241;
	bh=qcy8s4h8yOEJ93i9Gix72rkvI+TkLEBo6Z1FLODB+DA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ZpQlxwyPGBe/xbA8iYA3pVdW5GVuobvVLnhqgTIlXF5kj6lA1a5+GykvTErRpLOQs
	 CDBSPh22YP9wYLkFztNvGhbTsGcoe/vIQXhddEDsW8Snqq6tV78tvEnyvkJjrj6JJu
	 UpEltmqrktDBKpxGMRKAczRyBMn4hgCoEuucVcTfBvtPiygEq5VTTGPb0L8xtpHeSs
	 d3qHMGma5OI5emS8huuIjdogLUSQh5Iyq4Go61mPnTfjSkeJ9mCXdVwMPYcxWikdE0
	 fZLu6Rh0z3I5l+YPgb+i8ifq/zXoyBUT95NjYrm7ZoTNZnLdmIqZ2ULmN3U4Kxhj7J
	 4ZWo2mKX6uhgQ==
Date: Mon, 02 Sep 2024 09:57:17 +0000
To: Alexey Dobriyan <adobriyan@gmail.com>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Benno Lossin <benno.lossin@proton.me>, Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH RESEND] block, rust: simplify validate_block_size() function
Message-ID: <878qwaxtsd.fsf@metaspace.dk>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: a6e12d4490f7f8334a9d58c0151c9341179d21ca
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Alexy,

Thanks for your patch. I think I understand why you would suggest the
change, with you strong C background. I would prefer that we do not
apply this change, see below.

Alexey Dobriyan <adobriyan@gmail.com> writes:

> On Sat, Aug 31, 2024 at 08:39:45PM +0000, Benno Lossin wrote:
>> On 31.08.24 22:15, Alexey Dobriyan wrote:
>> > Using range and contains() method is just fancy shmancy way of writing
>>=20
>> This language doesn't fit into a commit message. Please give a technical
>> reason to change this.
>
> Oh come on!

Could you elaborate?

>
>> > two comparisons. Using range doesn't prevent any bugs here because
>> > typing "=3D" in range can be forgotten just as easily as in "<=3D" ope=
rator.
>>=20
>> I don't think that using traditional comparisons is an improvement.
>
> They are an improvement, or rather contains() on integers is of dubious
> value.

I would disagree. To me, and probably to many people who are experienced
in Rust code, the range.contains() formulation is much more clear.

> First, coding style mandates that there are no whitespace on both sides
> of "..". This merges all characters into one Perl-like line noise.

I don't think it looks like noise or Perl. But I am not that experienced
in Perl =F0=9F=A4=B7

What code style are you referring to? We use `rustfmt` default settings
as code style, although I am not sure if that is written down anywhere.

> Second, when writing C I've a habit of writing comparisons like numeric
> line in school which goes from left to right:

But this is not C. In Rust we have other options.

>
> =09512 ... size .. PAGE_SIZE   ------> infinity
>
> See?
> Now it is easy to insert comparisons:
>
> =09512 <=3D size <=3D PAGE_SIZE
>
> Of course in C the middle variable must be duplicated but so what?
>
> How hard is to parse this?
>
> =09512 <=3D size && size <=3D PAGE_SIZE
>
>
> And thirdly, to a C/C++ dev, passing u32 by reference instead of by
> value to a function which obviously doesn't mutate it screams WHAT???

It might look a little funny, but in general lookups take references to
the key you are searching for. It makes sense for a larger set of types.
In this particular case, I don't think codegen is any different due to
the reference.

>
>> When
>> using `contains`, both of the bounds are visible with one look.
>
> Yes, they are within 4 characters of each other 2 of which are
> whitespace.

I like whitespace. I think it helps make the code more readable.


> This is what this patch is all about: contains() for integers?
> I can understand contains() instead of strstr() but for integers?

To me it makes sense to check if a number is in a range with `contains`.
I appreciate that it might not make sense to you, since it is not an
option in C.

>
>> When
>> using two comparisons, you have to first parse that they compare the
>> same variable and then look at the bounds.
>
> Yes but now you have to parse () and .. and &.

Reading Rust takes a bit of practice. Just like reading C takes some
practice to people who have not done it before.

>
>> > Also delete few comments of "increment i by 1" variety.
>>=20
>> As Miguel already said, these are part of the documentation. Do not
>> remove them.
>
> Kernel has its fair share of 1:1 kernel-doc comments which contain
> exactly zero useful information because everything is in function
> signature already.

The comment is useful to a person browsing the documentation in the HTML
format. It is available here [1] if you want to have a look.


Best regards,
Andreas


[1] https://rust.docs.kernel.org/kernel/block/mq/gen_disk/struct.GenDiskBui=
lder.html#method.physical_block_size


